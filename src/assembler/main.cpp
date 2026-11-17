// Two-pass assembler for the modified SK computer (variant 20).
//
// Usage: assemble <input.as> <output.mc>
//
// Pass 1 assigns an address to every label, pass 2 encodes every line
// into a 56-bit machine word. The output file contains one decimal number
// per line and is written only if the whole program assembled without errors.
// Exit code: 0 on success, 1 on any error.

#include <algorithm>
#include <cctype>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>

#include "../common/isa.h"

using isa::Format;
using isa::Opcode;

// One line of an assembly program split into fields
struct Line {
    std::string label;   // optional label (may be empty)
    std::string opcode;  // instruction mnemonic or .fill
    std::string arg0, arg1, arg2;
};

// Any error in the source program
struct AsmError : std::runtime_error {
    using std::runtime_error::runtime_error;
};

using LabelTable = std::unordered_map<std::string, int64_t>;

// Splits a line into label, opcode and up to three fields.
// Everything after the third field is a comment and is ignored.
Line parseLine(const std::string& text) {
    Line line;
    std::istringstream ss(text);

    // A label is present only if the line does not start with whitespace
    bool hasLabel = !text.empty() && text[0] != ' ' && text[0] != '\t';
    if (hasLabel) {
        ss >> line.label;
    }

    // operator>> skips spaces and tabs; if the line ends early,
    // the remaining fields simply stay empty
    ss >> line.opcode >> line.arg0 >> line.arg1 >> line.arg2;
    return line;
}

std::string toLower(std::string s) {
    std::transform(s.begin(), s.end(), s.begin(),
                   [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
    return s;
}

// Label rules: up to 6 characters, letters or digits, must start with a letter
bool isValidLabel(const std::string& s) {
    if (s.empty() || s.size() > 6) return false;
    if (!std::isalpha(static_cast<unsigned char>(s[0]))) return false;
    for (char c : s) {
        if (!std::isalnum(static_cast<unsigned char>(c))) return false;
    }
    return true;
}

// True if s is a decimal integer with an optional sign
bool isNumber(const std::string& s) {
    size_t i = (!s.empty() && (s[0] == '-' || s[0] == '+')) ? 1 : 0;
    if (i == s.size()) return false;
    for (; i < s.size(); ++i) {
        if (!std::isdigit(static_cast<unsigned char>(s[i]))) return false;
    }
    return true;
}

int64_t parseNumber(const std::string& s) {
    try {
        return std::stoll(s);
    } catch (const std::out_of_range&) {
        throw AsmError("number out of range: " + s);
    }
}

// Register field: a number from 0 to NUM_REGS - 1
int64_t parseRegister(const std::string& s) {
    if (s.empty()) throw AsmError("missing register field");
    if (!isNumber(s)) throw AsmError("register must be a number: '" + s + "'");
    int64_t reg = parseNumber(s);
    if (reg < 0 || reg >= isa::NUM_REGS) throw AsmError("register out of range: " + s);
    return reg;
}

// Field that holds either a number or a label; labels resolve to their address
int64_t resolveValue(const std::string& s, const LabelTable& labels) {
    if (s.empty()) throw AsmError("missing field");
    if (isNumber(s)) return parseNumber(s);
    auto it = labels.find(s);
    if (it == labels.end()) throw AsmError("undefined label '" + s + "'");
    return it->second;
}

const isa::OpcodeInfo* findOpcode(const std::string& name) {
    std::string lower = toLower(name);
    for (const auto& info : isa::OPCODE_TABLE) {
        if (lower == info.name) return &info;
    }
    return nullptr;
}

// Pass 1: assigns an address to every label
LabelTable buildLabelTable(const std::vector<Line>& program) {
    LabelTable labels;
    for (size_t addr = 0; addr < program.size(); ++addr) {
        const std::string& label = program[addr].label;
        if (label.empty()) continue;
        std::string where = "address " + std::to_string(addr) + ": ";
        if (!isValidLabel(label)) {
            throw AsmError(where + "invalid label '" + label + "'");
        }
        if (labels.count(label)) {
            throw AsmError(where + "duplicate label '" + label + "'");
        }
        labels[label] = static_cast<int64_t>(addr);
    }
    return labels;
}

// Pass 2: turns one line into a 56-bit machine word
int64_t encode(const Line& line, int64_t addr, const LabelTable& labels) {
    if (line.opcode == ".fill") {
        int64_t value = resolveValue(line.arg0, labels);
        if (value < isa::WORD_MIN || value > isa::WORD_MAX) {
            throw AsmError(".fill value does not fit in 56 bits: " + line.arg0);
        }
        return value;
    }

    const isa::OpcodeInfo* info = findOpcode(line.opcode);
    if (info == nullptr) throw AsmError("unknown opcode '" + line.opcode + "'");
    Opcode op = info->code;

    // A leading '@' on regA selects register indirect addressing
    std::string regA = line.arg0;
    int64_t mode = 0;
    if (!regA.empty() && regA[0] == '@') {
        if (!isa::supportsIndirect(op)) {
            throw AsmError("indirect addressing is only supported by lw, sw and jalr");
        }
        mode = 1;
        regA = regA.substr(1);
    }

    int64_t instr = (mode << isa::MODE_SHIFT) | (int64_t{op} << isa::OPCODE_SHIFT);
    switch (info->format) {
    case Format::R:  // regA regB destReg
        instr |= parseRegister(regA) << isa::REG_A_SHIFT;
        instr |= parseRegister(line.arg1) << isa::REG_B_SHIFT;
        instr |= parseRegister(line.arg2);
        break;

    case Format::I: {  // regA regB offset
        instr |= parseRegister(regA) << isa::REG_A_SHIFT;
        instr |= parseRegister(line.arg1) << isa::REG_B_SHIFT;
        // In indirect mode the address comes from memory, the offset field stays 0
        if (mode == 1) break;
        int64_t offset = resolveValue(line.arg2, labels);
        // Jumps are relative to the next instruction, so a label becomes a distance
        if (isa::isBranch(op) && !isNumber(line.arg2)) {
            offset -= addr + 1;
        }
        if (offset < isa::OFFSET_MIN || offset > isa::OFFSET_MAX) {
            throw AsmError("offset out of range: " + std::to_string(offset));
        }
        instr |= offset & isa::OFFSET_MASK;
        break;
    }

    case Format::J:  // regA regB
        instr |= parseRegister(regA) << isa::REG_A_SHIFT;
        instr |= parseRegister(line.arg1) << isa::REG_B_SHIFT;
        break;

    case Format::O:  // no fields
        break;
    }
    return instr;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "usage: " << argv[0] << " <input.as> <output.mc>\n";
        return 1;
    }
    std::ifstream in(argv[1]);
    if (!in) {
        std::cerr << "error: cannot open " << argv[1] << "\n";
        return 1;
    }

    std::vector<Line> program;
    std::string text;
    while (std::getline(in, text)) {
        Line line = parseLine(text);
        // Skip blank lines so they do not take up an address
        if (line.label.empty() && line.opcode.empty()) continue;
        program.push_back(line);
    }

    std::vector<int64_t> machineCode;
    try {
        if (static_cast<int64_t>(program.size()) > isa::MEMORY_SIZE) {
            throw AsmError("program does not fit in memory");
        }
        LabelTable labels = buildLabelTable(program);
        for (size_t addr = 0; addr < program.size(); ++addr) {
            try {
                machineCode.push_back(encode(program[addr], static_cast<int64_t>(addr), labels));
            } catch (const AsmError& e) {
                throw AsmError("address " + std::to_string(addr) + ": " + e.what());
            }
        }
    } catch (const AsmError& e) {
        std::cerr << "error: " << e.what() << "\n";
        return 1;
    }

    std::ofstream out(argv[2]);
    if (!out) {
        std::cerr << "error: cannot open " << argv[2] << "\n";
        return 1;
    }
    for (int64_t word : machineCode) {
        out << word << "\n";
    }
    std::cout << "assembled " << machineCode.size() << " words into " << argv[2] << "\n";
    return 0;
}
