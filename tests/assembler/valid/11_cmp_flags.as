	lw	0	1	npairs	reg1 = number of pairs
	add	0	0	2	reg2 = pair index
	lw	0	3	one	reg3 = 1
	add	0	0	4	reg4 = number of pairs with a < b
next	beq	2	1	done	all pairs processed
	add	2	2	5	reg5 = offset of the pair
	lw	5	6	pairs	reg6 = a
	add	5	3	5	offset of b
	lw	5	7	pairs	reg7 = b
	cmp	6	7		CF = SF = 1 if a < b
	rcr	0	3	8	reg8 = CF in bit 55
	cmpne	8	0	8	reg8 = 1 if a < b
	add	4	8	4	count
	add	2	3	2	index++
	beq	0	0	next	next pair
done	sw	0	4	result	store the count
	halt				end of program
one	.fill	1
npairs	.fill	22
result	.fill	0
pairs	.fill	-254			pairs (a, b), signed
	.fill	275
	.fill	-390
	.fill	-706
	.fill	385
	.fill	485
	.fill	-798
	.fill	-991
	.fill	-435
	.fill	-874
	.fill	799
	.fill	-207
	.fill	-236
	.fill	506
	.fill	986
	.fill	-422
	.fill	-190
	.fill	714
	.fill	846
	.fill	-53
	.fill	659
	.fill	-797
	.fill	-864
	.fill	183
	.fill	-39
	.fill	-568
	.fill	974
	.fill	879
	.fill	-980
	.fill	435
	.fill	498
	.fill	83
	.fill	-857
	.fill	889
	.fill	538
	.fill	120
	.fill	274
	.fill	979
	.fill	-303
	.fill	463
	.fill	5
	.fill	5
	.fill	-3
	.fill	-3
