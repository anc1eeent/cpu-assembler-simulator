	lw	0	1	npairs	reg1 = number of pairs
	add	0	0	2	reg2 = pair index
	lw	0	3	one	reg3 = 1
	add	0	0	20	reg20 = sum of all gcd values
next	beq	2	1	done	all pairs processed
	add	2	2	4	reg4 = 2 * index (offset of the pair)
	lw	4	5	pairs	reg5 = a
	add	4	3	4	offset of b
	lw	4	6	pairs	reg6 = b
loop	beq	5	6	found	a == b: gcd found
	jmnle	5	6	agtb	a > b (signed)
	sub	6	5	6	b = b - a
	beq	0	0	loop	continue
loop	sub	5	6	5	a = a - b
	beq	0	0	loop	continue
found	sw	2	5	gcds	gcds[index] = gcd
	add	20	5	20	accumulate
	add	2	3	2	index++
	beq	0	0	next	next pair
done	sw	0	20	total	store the sum
	halt				end of program
one	.fill	1
npairs	.fill	8
total	.fill	0
pairs	.fill	1071			pairs (a, b)
	.fill	462
	.fill	270
	.fill	192
	.fill	1386
	.fill	3213
	.fill	48
	.fill	180
	.fill	840
	.fill	3960
	.fill	17
	.fill	289
	.fill	987
	.fill	610
	.fill	1001
	.fill	77
gcds	.fill	0			results
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
	.fill	0
pad5	.fill	0			spare cells
	.fill	0
	.fill	0
