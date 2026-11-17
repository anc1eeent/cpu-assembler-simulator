	lw	0	1	n	reg1 = n = 25
	lw	0	2	one	reg2 = 1
	add	0	0	3	reg3 = i
	add	0	0	4	reg4 = sum of squares
	lw	0	5	sqra	reg5 = address of the subroutine
loop	beq	3	1	done	all numbers processed
	add	3	2	3	i++
	add	3	0	10	reg10 = argument
	jalr	5	7		call square, return address in reg7
	add	4	11	4	sum += result (reg11)
	beq	0	0	loop	next number
done	sw	0	4	result	store the sum
	halt				end of program
square	imul	10	10	11	reg11 = reg10 * reg10
	jalr	7	6		return to the caller
n	.fill	25
one	.fill	1
sqra	.fill	square
result	.fill	0
pad14	.fill	0			spare cells
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
