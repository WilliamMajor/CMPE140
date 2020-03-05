Main:
addi 	$a0, $0, 0x100
addi	$a1, $0, 0
addi	$t0, $0, 3
addi	$t1, $0, 50

CreateArray_Loop:
slt 	$t2, $a1, $t1 # i < 50?
beq 	$t2, $0, Exit_Loop # if not then exit loop
sll 	$t2, $a1, 2 	# $t2 = i * 4 (byte offset)
add 	$t2, $t2, $a0 	# address of array[i]
mult 	$a1, $t0
mflo 	$t3 		# $t3 = i * 3
sw 	$t3, 0($t2) 	# save array[i]
addi 	$a1, $a1, 1 	# i = i + 1
j 	CreateArray_Loop

Exit_Loop:
# arithmetic calculation
addi	$t6, $0, 30
lw 	$t4, 100($a0) 	#load my_array[25]
lw	$t5, 120($a0) 	#load my_array[30]
add	$t5, $t4, $t5
div	$t5, $t6
mflo	$a1
sw	$a1, 0

# factorial computation
jal 	Factorial 	# call procedure
add 	$s0, $v0, $0 	# return value
sw	$s0, 0x10
j	exit

Factorial:
addi 	$sp, $sp, -8 	# make room on the stack
sw 	$a1, 4($sp) 	# store $a1
sw 	$ra, 0($sp) 	# store $ra
addi 	$t0, $0, 2	# add 2 to temp reg to use for if statement
slt	$t0, $a1, $t0	#set t0 to 1 when a0 is less then t0
beq	$t0, $0, else	#if t0 is 0 branch to the else label
addi	$v0, $0, 1	#return 1
addi	$sp, $sp, 8
jr	$ra

else:
addi	$a1, $a1, -1
jal	Factorial
lw	$ra, 0($sp)
lw	$a1, 4($sp)
addi	$sp, $sp, 8
mul	$v0, $a1, $v0
jr	$ra

exit:


