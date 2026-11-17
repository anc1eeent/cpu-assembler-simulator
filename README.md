# cpu-assembler-simulator

Two-pass assembler and instruction-level simulator for a custom 56-bit CPU
(computer architecture coursework, Lviv Polytechnic, variant 20).

## Architecture (variant 20)

| Parameter | Value |
|---|---|
| Word | 56 bits, two's complement |
| Memory | 2^25 words |
| Registers | 128 (`reg0` is always 0 by convention) |
| Flags | CF, SF, ZF |
| Instructions | `add nand lw sw beq jalr halt noop` + `div imul sub xor shl cmpne jmae jmnle bt cmp rcr` |
| Extra addressing mode | register indirect (`lw @1 2`, `sw @1 2`, `jalr @1 2`) |

Instruction layout:

```
bits:  55-45   44   43-39   38-32  31-25  24-0
       0       M    opcode  regA   regB   offset (I) / destReg in 6-0 (R)
```

The full encoding is defined in [`src/common/isa.h`](src/common/isa.h).

## Layout

```
src/common/      instruction set shared by the assembler and the simulator
src/assembler/   two-pass assembler
tests/assembler/ valid programs (.as + expected .mc) and broken programs (.as + expected .err)
tests/examples/  example program from the coursework guidelines
```

## Build and run

```powershell
cmake -S . -B build
cmake --build build
.\build\Debug\assemble.exe tests\examples\count5.as out.mc
```

On Linux or macOS the executable is `./build/assemble`.

## Tests

```powershell
ctest --test-dir build -C Debug
```

Every valid program must assemble into exactly the expected machine code.
Every broken program must make the assembler exit with code 1, print the expected
error message and create no output file.
