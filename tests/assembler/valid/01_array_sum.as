	lw	0	1	count	reg1 = number of elements
	lw	0	2	one	reg2 = 1 (step)
	add	0	0	3	reg3 = sum = 0
	add	0	0	4	reg4 = index = 0
loop	beq	4	1	done	stop when index == count
	lw	4	5	arr	reg5 = arr[index]
	add	3	5	3	sum += arr[index]
	add	4	2	4	index++
	beq	0	0	loop	next element
done	sw	0	3	result	store the sum
	halt				end of program
count	.fill	40
one	.fill	1
result	.fill	0
arr	.fill	427			array of 40 signed numbers
	.fill	240
	.fill	202
	.fill	305
	.fill	284
	.fill	401
	.fill	426
	.fill	-346
	.fill	-234
	.fill	190
	.fill	150
	.fill	369
	.fill	426
	.fill	-397
	.fill	393
	.fill	-165
	.fill	86
	.fill	427
	.fill	-327
	.fill	-473
	.fill	-79
	.fill	-84
	.fill	-424
	.fill	-395
	.fill	-372
	.fill	-174
	.fill	-15
	.fill	472
	.fill	94
	.fill	-40
	.fill	-79
	.fill	-287
	.fill	-296
	.fill	-176
	.fill	140
	.fill	430
	.fill	197
	.fill	-157
	.fill	-164
	.fill	-63
