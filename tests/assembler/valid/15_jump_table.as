	lw	0	1	count	reg1 = number of commands
	lw	0	2	one	reg2 = 1
	add	0	0	3	reg3 = index
	lw	0	4	one	reg4 = accumulator = 1
	lw	0	5	tablea	reg5 = address of the jump table
loop	beq	3	1	done	all commands processed
	lw	3	6	cmds	reg6 = command code 0..3
	lw	3	10	args	reg10 = argument
	add	5	6	8	reg8 = address of table[code]
	jalr	@8	7		call the handler, PC = Mem[reg8]
	add	3	2	3	index++
	beq	0	0	loop	next command
done	sw	0	4	result	store the accumulator
	halt				end of program
hadd	add	4	10	4	acc += arg
	jalr	7	6		return
hsub	sub	4	10	4	acc -= arg
	jalr	7	6		return
hxor	xor	4	10	4	acc ^= arg
	jalr	7	6		return
hshl	shl	4	2	4	acc <<= 1
	jalr	7	6		return
one	.fill	1
count	.fill	30
tablea	.fill	table
result	.fill	0
table	.fill	hadd			jump table
	.fill	hsub
	.fill	hxor
	.fill	hshl
cmds	.fill	3			command codes
	.fill	1
	.fill	3
	.fill	1
	.fill	2
	.fill	2
	.fill	1
	.fill	0
	.fill	2
	.fill	0
	.fill	1
	.fill	2
	.fill	3
	.fill	1
	.fill	2
	.fill	3
	.fill	1
	.fill	1
	.fill	1
	.fill	2
	.fill	0
	.fill	0
	.fill	1
	.fill	2
	.fill	2
	.fill	1
	.fill	2
	.fill	0
	.fill	1
	.fill	2
args	.fill	5			arguments
	.fill	2
	.fill	3
	.fill	5
	.fill	2
	.fill	8
	.fill	1
	.fill	9
	.fill	1
	.fill	8
	.fill	8
	.fill	7
	.fill	9
	.fill	2
	.fill	3
	.fill	5
	.fill	9
	.fill	9
	.fill	7
	.fill	3
	.fill	8
	.fill	8
	.fill	9
	.fill	8
	.fill	3
	.fill	3
	.fill	4
	.fill	4
	.fill	5
	.fill	2
