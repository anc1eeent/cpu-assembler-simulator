	lw	0	1	bits	reg1 = 56 (word width)
	lw	0	2	one	reg2 = 1
	add	0	0	3	reg3 = total number of set bits
	add	0	0	9	reg9 = word index
	lw	0	10	nwords	reg10 = number of words
word	beq	9	10	done	all words processed
	lw	9	5	words	reg5 = current word
	add	0	0	4	reg4 = bit position
bit	beq	4	1	nextw	all 56 bits tested
	bt	5	4		CF = word[position]
	rcr	0	2	6	reg6 = CF moved into bit 55
	cmpne	6	0	6	reg6 = 1 if the bit was set
	add	3	6	3	count it
	add	4	2	4	position++
	beq	0	0	bit	next bit
nextw	add	9	2	9	word index++
	beq	0	0	word	next word
done	sw	0	3	result	store the count
	halt				end of program
bits	.fill	56
one	.fill	1
nwords	.fill	2
result	.fill	0
words	.fill	264917625139440			words to analyse
	.fill	20015998343868
pad7	.fill	0			spare cells
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
