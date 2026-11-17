	lw	0	1	npairs	reg1 = number of pairs
	add	0	0	2	reg2 = pair index
	lw	0	3	one	reg3 = 1
	add	0	0	4	reg4 = number of mismatches
next	beq	2	1	done	all pairs processed
	add	2	2	5	reg5 = offset of the pair
	lw	5	6	pairs	reg6 = a
	add	5	3	5	offset of b
	lw	5	7	pairs	reg7 = b
	nand	6	7
	nand	6	6	9	reg9 = ~a
	nand	7	7	10	reg10 = ~b
	nand	9	10	11	reg11 = a | b
	nand	11	8	12	reg12 = ~((a | b) & ~(a & b))
	nand	12	12	13	reg13 = (a | b) & ~(a & b) = a ^ b
	xor	6	7	14	reg14 = a ^ b (instruction)
	cmpne	13	14	15	reg15 = 1 if the results differ
	add	4	15	4	count mismatches
	add	2	3	2	index++
	beq	0	0	next	next pair
done	sw	0	4	result	store the number of mismatches
	halt				end of program
one	.fill	1
npairs	.fill	13
result	.fill	-1
pairs	.fill	1962031919715060			pairs (a, b)
	.fill	26297592154979766
	.fill	1678889126608976
	.fill	32121197231824514
	.fill	22960100601950661
	.fill	20560144962252321
	.fill	33872554656976388
	.fill	32698259542459814
	.fill	22388881895962281
	.fill	1815087761174611
	.fill	2411168805856786
	.fill	1457789573217068
	.fill	30344348997044043
	.fill	33123892796821845
	.fill	6117503514332946
	.fill	30957634545722495
	.fill	1772078040432774
	.fill	28380670961762562
	.fill	1148653618690036
	.fill	391524747668027
	.fill	22686665016275677
	.fill	7340273996156165
	.fill	31011036095848893
	.fill	24051456528582917
	.fill	36028797018963967
	.fill	-36028797018963968
