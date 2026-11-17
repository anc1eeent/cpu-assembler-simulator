	lw	0	1	bits	reg1 = 56
	lw	0	2	one	reg2 = 1
	add	0	0	3	reg3 = i
loop	beq	3	1	check	table filled
	shl	2	3	4	reg4 = 1 << i
	sw	3	4	pow	pow[i] = 2^i
	add	3	2	3	i++
	beq	0	0	loop	next power
check	lw	0	5	top	reg5 = 55
	lw	5	6	pow	reg6 = 2^55 (sign bit set: negative)
	lw	0	7	minw	reg7 = smallest 56-bit number
	cmpne	6	7	8	reg8 = 0 if 2^55 equals it
	shl	2	1	9	reg9 = 1 << 56 = 0 (shift by >= 56)
	halt				end of program
bits	.fill	56
one	.fill	1
top	.fill	55
minw	.fill	-36028797018963969
pow	.fill	0			table of powers of two
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
