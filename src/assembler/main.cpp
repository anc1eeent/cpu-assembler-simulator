#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

// One line of an assembly program split into fields
struct Line {
    std::string label;   // optional label (may be empty)
    std::string opcode;  // instruction mnemonic or .fill
    std::string arg0, arg1, arg2;
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
        program.push_back(parseLine(text));
    }

    // Temporary debug output
    for (size_t i = 0; i < program.size(); ++i) {
        const Line& l = program[i];
        std::cout << i << ": [" << l.label << "] [" << l.opcode << "] ["
            << l.arg0 << "] [" << l.arg1 << "] [" << l.arg2 << "]\n";
    }
    return 0;
}