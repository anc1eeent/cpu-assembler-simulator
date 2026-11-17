	lw	0	120	start	reg120 = counter
	lw	0	121	neg1	reg121 = -1
	add	0	0	127	reg127 = sum of counter values
	add	0	0	126	reg126 = number of iterations
	lw	0	125	one	reg125 = 1
loop	add	127	120	127	sum += counter
	add	126	125	126	iterations++
	add	120	121	120	counter--
	beq	0	120	done	finish at zero
	beq	0	0	loop	repeat
done	sw	0	127	sum	store the sum
	sw	0	126	iters	store the number of iterations
	add	127	127	100	reg100 = 2 * sum
	add	100	100	101	reg101 = 4 * sum
	sub	101	127	102	reg102 = 3 * sum
	sw	0	102	triple	store 3 * sum
	halt				end of program
start	.fill	60
neg1	.fill	-1
one	.fill	1
sum	.fill	0
iters	.fill	0
triple	.fill	0
pad	.fill	100			spare cells
	.fill	101
	.fill	102
	.fill	103
	.fill	104
	.fill	105
	.fill	106
	.fill	107
	.fill	108
	.fill	109
	.fill	110
	.fill	111
	.fill	112
	.fill	113
	.fill	114
	.fill	115
	.fill	116
	.fill	117
	.fill	118
	.fill	119
	.fill	120
	.fill	121
	.fill	122
	.fill	123
	.fill	124
	.fill	125
	.fill	126
