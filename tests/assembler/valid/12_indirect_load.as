	lw	0	1	ptrsa	reg1 = address of the pointer table
	lw	0	2	count	reg2 = number of pointers
	lw	0	3	one	reg3 = 1
	add	0	0	4	reg4 = index
	add	0	0	5	reg5 = sum of the pointed values
loop	beq	4	2	done	all pointers processed
	add	1	4	6	reg6 = address of ptrs[index]
	lw	@6	7		reg7 = Mem[Mem[reg6]] = *ptrs[index]
	add	5	7	5	sum += value
	add	4	3	4	index++
	beq	0	0	loop	next pointer
done	sw	0	5	result	store the sum
	halt				end of program
one	.fill	1
count	.fill	40
ptrsa	.fill	ptrs
result	.fill	0
ptrs	.fill	v17			pointer table
	.fill	v8
	.fill	v27
	.fill	v16
	.fill	v26
	.fill	v25
	.fill	v34
	.fill	v13
	.fill	v32
	.fill	v38
	.fill	v39
	.fill	v22
	.fill	v35
	.fill	v21
	.fill	v30
	.fill	v9
	.fill	v23
	.fill	v7
	.fill	v15
	.fill	v3
	.fill	v0
	.fill	v24
	.fill	v2
	.fill	v4
	.fill	v11
	.fill	v1
	.fill	v19
	.fill	v6
	.fill	v33
	.fill	v10
	.fill	v36
	.fill	v28
	.fill	v18
	.fill	v12
	.fill	v14
	.fill	v20
	.fill	v31
	.fill	v37
	.fill	v5
	.fill	v29
v0	.fill	16			pointed values
v1	.fill	184
v2	.fill	285
v3	.fill	302
v4	.fill	624
v5	.fill	867
v6	.fill	990
v7	.fill	103
v8	.fill	3
v9	.fill	43
v10	.fill	217
v11	.fill	768
v12	.fill	212
v13	.fill	634
v14	.fill	972
v15	.fill	416
v16	.fill	706
v17	.fill	616
v18	.fill	81
v19	.fill	597
v20	.fill	868
v21	.fill	369
v22	.fill	809
v23	.fill	290
v24	.fill	454
v25	.fill	52
v26	.fill	830
v27	.fill	671
v28	.fill	142
v29	.fill	902
v30	.fill	638
v31	.fill	385
v32	.fill	921
v33	.fill	879
v34	.fill	576
v35	.fill	407
v36	.fill	404
v37	.fill	261
v38	.fill	4
v39	.fill	820
