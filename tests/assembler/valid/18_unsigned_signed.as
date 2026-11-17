	lw	0	1	count	reg1 = number of elements
	lw	0	2	one	reg2 = 1
	lw	0	3	limit	reg3 = threshold 100
	add	0	0	4	reg4 = index
	add	0	0	5	reg5 = count of x >= 100 (unsigned)
	add	0	0	6	reg6 = count of x > 99 (signed)
	sub	3	2	9	reg9 = 99
loop	beq	4	1	done	all elements processed
	lw	4	7	arr	reg7 = x
	jmae	7	3	uns	unsigned x >= 100 (negative numbers are huge)
	beq	0	0	sgn	skip
uns	add	5	2	5	count unsigned
sgn	jmnle	7	9	sgnok	signed x > 99
	beq	0	0	next	skip
sgnok	add	6	2	6	count signed
next	add	4	2	4	index++
	beq	0	0	loop	next element
done	sub	5	6	8	reg8 = numbers that differ = negatives
	sw	0	8	result	store the difference
	halt				end of program
count	.fill	30
one	.fill	1
limit	.fill	100
result	.fill	0
arr	.fill	-398			signed numbers
	.fill	95
	.fill	781
	.fill	917
	.fill	336
	.fill	-456
	.fill	-152
	.fill	-761
	.fill	-879
	.fill	191
	.fill	-184
	.fill	-299
	.fill	-127
	.fill	-229
	.fill	518
	.fill	685
	.fill	624
	.fill	659
	.fill	-326
	.fill	-11
	.fill	-521
	.fill	181
	.fill	-215
	.fill	129
	.fill	-905
	.fill	812
	.fill	-175
	.fill	834
	.fill	208
	.fill	-121
