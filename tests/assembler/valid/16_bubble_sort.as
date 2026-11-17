	lw	0	1	n	reg1 = n
	lw	0	2	one	reg2 = 1
	sub	1	2	3	reg3 = outer limit = n - 1
	add	0	0	4	reg4 = outer index i
outer	beq	4	3	check	i == n - 1: sorted
	add	0	0	5	reg5 = inner index j
	sub	3	4	6	reg6 = inner limit = n - 1 - i
inner	beq	5	6	nexti	inner pass finished
	lw	5	7	arr	reg7 = arr[j]
	add	5	2	8	reg8 = j + 1
	lw	8	9	arr	reg9 = arr[j+1]
	jmnle	7	9	swap	arr[j] > arr[j+1] (signed): swap
	beq	0	0	nextj	already in order
swap	sw	5	9	arr	arr[j] = old arr[j+1]
	sw	8	7	arr	arr[j+1] = old arr[j]
nextj	add	5	2	5	j++
	beq	0	0	inner	continue the pass
nexti	add	4	2	4	i++
	beq	0	0	outer	next pass
check	add	0	0	5	verify: count descents
	add	0	0	10	reg10 = number of unsorted pairs
chk	beq	5	3	done	all pairs checked
	lw	5	7	arr	arr[j]
	add	5	2	8	j + 1
	lw	8	9	arr	arr[j+1]
	jmnle	9	7	ok	arr[j+1] > arr[j]: in order
	beq	7	9	ok	equal: in order
	add	10	2	10	out of order
ok	add	5	2	5	j++
	beq	0	0	chk	next pair
done	lw	0	11	arr	reg11 = minimum (arr[0])
	lw	3	12	arr	reg12 = maximum (arr[n-1])
	halt				end of program
n	.fill	12
one	.fill	1
arr	.fill	-26			array to sort
	.fill	7
	.fill	1
	.fill	9
	.fill	-42
	.fill	48
	.fill	48
	.fill	-11
	.fill	31
	.fill	18
	.fill	-36
	.fill	-23
pad16	.fill	0			spare cells
	.fill	0
	.fill	0
	.fill	0
