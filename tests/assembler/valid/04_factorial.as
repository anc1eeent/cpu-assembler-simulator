	lw	0	1	one	reg1 = factorial accumulator = 1
	lw	0	2	one	reg2 = n = 1
	lw	0	3	one	reg3 = 1 (step)
	lw	0	4	limit	reg4 = 19 (stop value)
loop	beq	2	4	check	stop when n == 19
	imul	1	2	1	acc = acc * n
	sw	2	1	fact	fact[n] = n!
	add	2	3	2	n++
	beq	0	0	loop	next n
check	lw	0	2	top	reg2 = 18, verify the table backwards
	add	0	0	9	reg9 = number of mismatches
back	beq	2	3	done	stop at n == 1
	lw	2	5	fact	reg5 = n!
	div	5	2	6	reg6 = n! / n
	sub	2	3	7	reg7 = n - 1
	lw	7	8	fact	reg8 = (n-1)!
	cmpne	6	8	10	reg10 = 1 if they differ
	add	9	10	9	count mismatches
	sub	2	3	2	n--
	beq	0	0	back	previous n
done	sw	0	1	result	store 18!
	halt				end of program
one	.fill	1
limit	.fill	19
top	.fill	18
result	.fill	0
fact	.fill	1			fact[0..18], fact[0] = 0! = 1
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
spare	.fill	0			spare cells
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
