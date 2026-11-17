	lw	0	1	count	reg1 = number of elements
	lw	0	2	divsr	reg2 = divisor
	lw	0	3	one	reg3 = 1
	add	0	0	4	reg4 = index
	add	0	0	10	reg10 = sum of quotients
	add	0	0	11	reg11 = sum of remainders
loop	beq	4	1	done	all elements processed
	lw	4	5	nums	reg5 = x
	div	5	2	6	reg6 = q = x / d
	imul	6	2	7	reg7 = q * d
	sub	5	7	8	reg8 = r = x - q * d
	sw	4	6	quots	store q
	sw	4	8	rems	store r
	add	10	6	10	sum of q
	add	11	8	11	sum of r
	add	4	3	4	index++
	beq	0	0	loop	next element
done	halt				end of program
count	.fill	20
divsr	.fill	7
one	.fill	1
nums	.fill	12153			dividends
	.fill	82271
	.fill	67875
	.fill	64502
	.fill	53075
	.fill	10677
	.fill	27045
	.fill	75131
	.fill	31803
	.fill	4600
	.fill	26452
	.fill	12389
	.fill	10977
	.fill	24947
	.fill	33216
	.fill	90890
	.fill	37155
	.fill	39985
	.fill	90472
	.fill	33657
quots	.fill	0			quotients
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
rems	.fill	0			remainders
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
