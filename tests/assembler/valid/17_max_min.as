	lw	0	1	count	reg1 = number of elements
	lw	0	2	one	reg2 = 1
	lw	0	3	arr	reg3 = max = arr[0]
	lw	0	4	arr	reg4 = min = arr[0]
	lw	0	5	one	reg5 = index = 1
loop	beq	5	1	done	all elements processed
	lw	5	6	arr	reg6 = arr[index]
	jmnle	6	3	newmax	arr[index] > max
	jmnle	4	6	newmin	min > arr[index]
	beq	0	0	next	neither
newmax	add	6	0	3	max = arr[index]
	beq	0	0	next	continue
newmin	add	6	0	4	min = arr[index]
next	add	5	2	5	index++
	beq	0	0	loop	next element
done	sw	0	3	max	store max
	sw	0	4	min	store min
	sub	3	4	7	reg7 = range = max - min
	halt				end of program
count	.fill	35
one	.fill	1
max	.fill	0
min	.fill	0
arr	.fill	-193411019680016			signed 56-bit numbers
	.fill	175258316430866
	.fill	836393315553650
	.fill	1005824878477647
	.fill	513596891535791
	.fill	-23375279620550
	.fill	-298272706190952
	.fill	-446602328823375
	.fill	383862748246997
	.fill	575086683480577
	.fill	158244406756030
	.fill	-546376829837086
	.fill	-827075365320068
	.fill	-960365331089735
	.fill	-722199145820346
	.fill	-261123131535503
	.fill	875741434745587
	.fill	-930321199583073
	.fill	-695407574455052
	.fill	-413204637401191
	.fill	-597695237906199
	.fill	881007710501375
	.fill	386755069196059
	.fill	-55440367406631
	.fill	906650657035283
	.fill	161164458940707
	.fill	57876222691268
	.fill	257981222591959
	.fill	-841789198644377
	.fill	-1063531125394040
	.fill	-323411686014180
	.fill	-95686899410370
	.fill	-804268536197295
	.fill	861857058292148
	.fill	-1121948354033075
