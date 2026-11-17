	add	0	0	1	reg1 = F(i) = 0
	lw	0	2	one	reg2 = F(i+1) = 1
	lw	0	3	one	reg3 = 1 (step)
	add	0	0	4	reg4 = i = 0
	lw	0	5	n	reg5 = number of terms
loop	beq	4	5	done	stop after n terms
	sw	4	1	fib	fib[i] = F(i)
	add	1	2	6	reg6 = F(i+2)
	add	2	0	1	F(i) = F(i+1)
	add	6	0	2	F(i+1) = F(i+2)
	add	4	3	4	i++
	beq	0	0	loop	next term
done	lw	0	7	last	reg7 = address of the last term
	lw	7	8	0	reg8 = fib[n-1] (loaded through the base register)
	halt				end of program
one	.fill	1
n	.fill	45
last	.fill	lastf
fib	.fill	0			table of Fibonacci numbers
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
	.fill	0
lastf	.fill	0			last element of the table
