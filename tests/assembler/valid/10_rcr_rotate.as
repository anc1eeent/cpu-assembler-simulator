	lw	0	1	value	reg1 = value to rotate
	add	1	0	2	reg2 = working copy
	lw	0	3	one	reg3 = 1 (rotate by one bit)
	lw	0	4	steps	reg4 = 57 rotations
	add	0	0	5	reg5 = rotation counter
loop	beq	5	4	full	57 rotations done
	rcr	2	3	2	rotate right through CF by 1
	add	5	3	5	counter++
	beq	0	0	loop	next rotation
full	cmpne	1	2	6	reg6 = 0: value restored after 57 steps
	lw	0	7	k	reg7 = 20
	rcr	1	7	8	reg8 = rotate by 20 in one step
	lw	0	9	rest	reg9 = 37
	rcr	8	9	10	rotate by the remaining 37 bits
	cmpne	1	10	11	reg11 = 0: 20 + 37 = 57 restores the value
	add	6	11	12	reg12 = total errors
	sw	0	12	errors	store the result
	halt				end of program
value	.fill	9927935178558959
one	.fill	1
steps	.fill	57
k	.fill	20
rest	.fill	37
errors	.fill	-1
pad10	.fill	0			spare cells
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
