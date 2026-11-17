	lw	0	1	npairs	reg1 = number of pairs
	add	0	0	2	reg2 = pair index
	lw	0	3	one	reg3 = 1
	lw	0	4	bits	reg4 = 15 (operand width)
next	beq	2	1	done	all pairs processed
	add	2	2	5	reg5 = offset of the pair
	lw	5	6	pairs	reg6 = mcand
	add	5	3	5	offset of mplier
	lw	5	7	pairs	reg7 = mplier
	add	0	0	8	reg8 = product
	add	0	0	9	reg9 = bit index
bit	beq	9	4	store	all 15 bits processed
	bt	7	9		CF = mplier[i]
	rcr	0	3	10	reg10 = CF in bit 55
	beq	10	0	skip	bit is 0: nothing to add
	shl	6	9	11	reg11 = mcand << i
	add	8	11	8	product += mcand << i
skip	add	9	3	9	i++
	beq	0	0	bit	next bit
store	sw	2	8	prods	prods[index] = product
	add	2	3	2	index++
	beq	0	0	next	next pair
done	halt				end of program
one	.fill	1
bits	.fill	15
npairs	.fill	3
pairs	.fill	12345			pairs (mcand, mplier)
	.fill	321
	.fill	32767
	.fill	32767
	.fill	1000
	.fill	999
prods	.fill	0			products
	.fill	0
	.fill	0
pad8	.fill	0			spare cells
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
