// Two-pass assembler for the base SK (32-bit) instruction set.
#include <cctype>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>

constexpr int NUM_REGS = 8;
constexpr int OFFSET_MIN = -32768;  // 16-bit signed offset
constexpr int OFFSET_MAX = 32767;

// One line of an assembly program split into fields
struct Line {
    std::string label;   // optional label (may be empty)
    std::string opcode;  // instruction mnemonic or .fill
    std::string arg0, arg1, arg2;
};

// Any error in the source program; reported with the line address
struct AsmError : std::runtime_error {
    using std::runtime_error::runtime_error;
};

using LabelTable = std::unordered_map<std::string, int>;

enum Opcode { ADD = 0, NAND, LW, SW, BEQ, JALR, HALT, NOOP };

const std::unordered_map<std::string, Opcode> OPCODES = {
    {"add", ADD}, {"nand", NAND}, {"lw", LW},     {"sw", SW},
    {"beq", BEQ}, {"jalr", JALR}, {"halt", HALT}, {"noop", NOOP},
};

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

// Register field: a number from 0 to NUM_REGS - 1
int parseRegister(const std::string& s) {
    if (s.empty()) throw AsmError("missing register field");
    if (!isNumber(s)) throw AsmError("register must be a number: '" + s + "'");
    int reg = std::stoi(s);
    if (reg < 0 || reg >= NUM_REGS) throw AsmError("register out of range: " + s);
    return reg;
}

// Field that holds either a number or a label; labels resolve to their address
long long resolveValue(const std::string& s, const LabelTable& labels) {
    if (s.empty()) throw AsmError("missing field");
    if (isNumber(s)) return std::stoll(s);
    auto it = labels.find(s);
    if (it == labels.end()) throw AsmError("undefined label '" + s + "'");
    return it->second;
}

// Pass 1: assigns an address to every label
LabelTable buildLabelTable(const std::vector<Line>& program) {
    LabelTable labels;
    for (size_t addr = 0; addr < program.size(); ++addr) {
        const std::string& label = program[addr].label;
        if (label.empty()) continue;
        if (!isValidLabel(label)) {
            throw AsmError("address " + std::to_string(addr) + ": invalid label '" + label + "'");
        }
        if (labels.count(label)) {
            throw AsmError("address " + std::to_string(addr) + ": duplicate label '" + label + "'");
        }
        labels[label] = static_cast<int>(addr);
    }
    return labels;
}

// Pass 2: turns one line into a 32-bit machine word
int32_t encode(const Line& line, int addr, const LabelTable& labels) {
    if (line.opcode == ".fill") {
        return static_cast<int32_t>(resolveValue(line.arg0, labels));
    }

    auto it = OPCODES.find(line.opcode);
    if (it == OPCODES.end()) throw AsmError("unknown opcode '" + line.opcode + "'");
    Opcode op = it->second;

    int32_t instr = op << 22;
    switch (op) {
    case ADD:
    case NAND:  // R-type: regA regB destReg
        instr |= parseRegister(line.arg0) << 19;
        instr |= parseRegister(line.arg1) << 16;
        instr |= parseRegister(line.arg2);
        break;

    case LW:
    case SW:
    case BEQ: {  // I-type: regA regB offset
        instr |= parseRegister(line.arg0) << 19;
        instr |= parseRegister(line.arg1) << 16;
        long long offset = resolveValue(line.arg2, labels);
        // beq jumps relative to the next instruction, so a label becomes a distance
        if (op == BEQ && !isNumber(line.arg2)) {
            offset -= addr + 1;
        }
        if (offset < OFFSET_MIN || offset > OFFSET_MAX) {
            throw AsmError("offset out of range: " + std::to_string(offset));
        }
        instr |= static_cast<int32_t>(offset & 0xFFFF);
        break;
    }

    case JALR:  // J-type: regA regB
        instr |= parseRegister(line.arg0) << 19;
        instr |= parseRegister(line.arg1) << 16;
        break;

    case HALT:
    case NOOP:  // O-type: no fields
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

    std::vector<int32_t> machineCode;
    try {
        LabelTable labels = buildLabelTable(program);
        for (size_t addr = 0; addr < program.size(); ++addr) {
            try {
                machineCode.push_back(encode(program[addr], static_cast<int>(addr), labels));
            } catch (const AsmError& e) {
                throw AsmError("address " + std::to_string(addr) + ": " + e.what());
            }
        }
    } catch (const AsmError& e) {
        std::cerr << "error: " << e.what() << "\n";
        return 1;
    }

    // The output file is written only if the whole program assembled without errors
    std::ofstream out(argv[2]);
    if (!out) {
        std::cerr << "error: cannot open " << argv[2] << "\n";
        return 1;
    }
    for (int32_t word : machineCode) {
        out << word << "\n";
    }
    return 0;
}
