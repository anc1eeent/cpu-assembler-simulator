	lw	0	1	ptrsa	reg1 = address of the pointer table
	lw	0	2	count	reg2 = number of elements
	lw	0	3	one	reg3 = 1
	add	0	0	4	reg4 = index
copy	beq	4	2	verify	all elements copied
	lw	4	5	src	reg5 = src[index]
	add	1	4	6	reg6 = address of ptrs[index]
	sw	@6	5		Mem[Mem[reg6]] = src[index]
	add	4	3	4	index++
	beq	0	0	copy	next element
verify	add	0	0	4	index = 0
	add	0	0	7	reg7 = sum of the copy
sum	beq	4	2	done	all elements summed
	lw	4	8	d0	reg8 = dst[index] (direct addressing)
	add	7	8	7	sum += dst[index]
	add	4	3	4	index++
	beq	0	0	sum	next element
done	sw	0	7	result	store the sum
	halt				end of program
one	.fill	1
count	.fill	20
ptrsa	.fill	ptrs
result	.fill	0
src	.fill	-1			source array
	.fill	76
	.fill	37
	.fill	79
	.fill	-26
	.fill	29
	.fill	55
	.fill	66
	.fill	83
	.fill	-25
	.fill	58
	.fill	95
	.fill	97
	.fill	-79
	.fill	67
	.fill	26
	.fill	-32
	.fill	-10
	.fill	89
	.fill	-68
ptrs	.fill	d0			pointer table
	.fill	d1
	.fill	d2
	.fill	d3
	.fill	d4
	.fill	d5
	.fill	d6
	.fill	d7
	.fill	d8
	.fill	d9
	.fill	d10
	.fill	d11
	.fill	d12
	.fill	d13
	.fill	d14
	.fill	d15
	.fill	d16
	.fill	d17
	.fill	d18
	.fill	d19
d0	.fill	0			destination array
d1	.fill	0
d2	.fill	0
d3	.fill	0
d4	.fill	0
d5	.fill	0
d6	.fill	0
d7	.fill	0
d8	.fill	0
d9	.fill	0
d10	.fill	0
d11	.fill	0
d12	.fill	0
d13	.fill	0
d14	.fill	0
d15	.fill	0
d16	.fill	0
d17	.fill	0
d18	.fill	0
d19	.fill	0
