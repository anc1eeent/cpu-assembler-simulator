	lw	0	1	count	reg1 = number of elements
	lw	0	2	one	reg2 = 1
	add	0	0	3	reg3 = checksum
	add	0	0	4	reg4 = index
loop	beq	4	1	check	all elements processed
	lw	4	5	arr	reg5 = arr[index]
	mul	3	5	3	checksum ^= arr[index]
	add	4	2	4	index++
	beq	0	0	loop	next element
check	lw	0	6	expect	reg6 = expected checksum
	xor	3	6	7	reg7 = 0 if the checksum is correct
	sw	0	3	result	store the checksum
	halt				end of program
count	.fill	40
one	.fill	1
expect	.fill	48560856744
result	.fill	0
arr	.fill	584215817095			data block
	.fill	514132426195
	.fill	121279436975
	.fill	615472017895
	.fill	737217708389
	.fill	604038491042
	.fill	345456679396
	.fill	889765489365
	.fill	265700294390
	.fill	277840587765
	.fill	943090471446
	.fill	491107079608
	.fill	114279139912
	.fill	427432947397
	.fill	379831605147
	.fill	382220456283
	.fill	179699209242
	.fill	648042763179
	.fill	883602698176
	.fill	1009113458689
	.fill	363643477143
	.fill	27202291114
	.fill	239432567196
	.fill	730545000024
	.fill	425318346960
	.fill	343649582113
	.fill	919664318139
	.fill	237404492393
	.fill	216414981350
	.fill	524922321355
	.fill	211425753849
	.fill	276172489837
	.fill	857082293582
	.fill	308748785240
	.fill	183171633306
	.fill	1071373229835
	.fill	390855945882
	.fill	685623694977
	.fill	209796636043
	.fill	452244948134
