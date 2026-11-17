// Instruction set of the modified SK computer (variant 20).
// Shared by the assembler and the simulator so both use the same encoding.
#pragma once

#include <cstdint>
#include <string>

namespace isa {

// Machine word
constexpr int WORD_BITS = 56;
constexpr int64_t WORD_MASK = (int64_t{1} << WORD_BITS) - 1;
constexpr int64_t WORD_MIN = -(int64_t{1} << (WORD_BITS - 1));
constexpr int64_t WORD_MAX = (int64_t{1} << (WORD_BITS - 1)) - 1;

// Machine resources
constexpr int NUM_REGS = 128;
constexpr int64_t MEMORY_SIZE = int64_t{1} << 25;  // words

// Instruction layout:
//   bits 55-45  unused (0)
//   bit  44     M, addressing mode (1 = register indirect)
//   bits 43-39  opcode
//   bits 38-32  regA
//   bits 31-25  regB
//   bits 24-0   offset (I-type) or destReg in bits 6-0 (R-type)
constexpr int MODE_SHIFT = 44;
constexpr int OPCODE_SHIFT = 39;
constexpr int REG_A_SHIFT = 32;
constexpr int REG_B_SHIFT = 25;
constexpr int64_t OPCODE_MASK = 0x1F;
constexpr int64_t REG_MASK = 0x7F;

constexpr int OFFSET_BITS = 25;
constexpr int64_t OFFSET_MASK = (int64_t{1} << OFFSET_BITS) - 1;
constexpr int64_t OFFSET_MIN = -(int64_t{1} << (OFFSET_BITS - 1));
constexpr int64_t OFFSET_MAX = (int64_t{1} << (OFFSET_BITS - 1)) - 1;

enum Opcode {
    ADD = 0, NAND, LW, SW, BEQ, JALR, HALT, NOOP,  // base instruction set
    DIV, IMUL, SUB,                                // arithmetic
    XOR, SHL, CMPNE,                               // logic
    JMAE, JMNLE,                                   // conditional jumps
    BT, CMP, RCR,                                  // carry flag
};

enum class Format {
    R,  // regA regB destReg
    I,  // regA regB offset
    J,  // regA regB
    O,  // no fields
};

struct OpcodeInfo {
    const char* name;
    Opcode code;
    Format format;
};

constexpr OpcodeInfo OPCODE_TABLE[] = {
    {"add", ADD, Format::R},     {"nand", NAND, Format::R},   {"lw", LW, Format::I},
    {"sw", SW, Format::I},       {"beq", BEQ, Format::I},     {"jalr", JALR, Format::J},
    {"halt", HALT, Format::O},   {"noop", NOOP, Format::O},   {"div", DIV, Format::R},
    {"imul", IMUL, Format::R},   {"sub", SUB, Format::R},     {"xor", XOR, Format::R},
    {"shl", SHL, Format::R},     {"cmpne", CMPNE, Format::R}, {"jmae", JMAE, Format::I},
    {"jmnle", JMNLE, Format::I}, {"bt", BT, Format::J},       {"cmp", CMP, Format::J},
    {"rcr", RCR, Format::R},
};

// Instructions whose offset is a jump distance relative to PC + 1
inline bool isBranch(Opcode op) {
    return op == BEQ || op == JMAE || op == JMNLE;
}

// Instructions that support register indirect addressing (M = 1)
inline bool supportsIndirect(Opcode op) {
    return op == LW || op == SW || op == JALR;
}

// Interprets the low `bits` bits of value as a signed two's complement number
inline int64_t signExtend(int64_t value, int bits) {
    int64_t mask = (int64_t{1} << bits) - 1;
    value &= mask;
    if (value & (int64_t{1} << (bits - 1))) {
        value -= int64_t{1} << bits;
    }
    return value;
}

}  // namespace isa
