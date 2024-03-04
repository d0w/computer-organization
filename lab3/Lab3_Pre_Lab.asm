############################################################################
#                       Lab 3 - Pre-Lab
#                       EC413
#
#    		Assembly Language Lab -- Addressing.
#
############################################################################
#  DATA
############################################################################
        .data           # Data segment
Hello:	.asciiz " \n Hello World! \n "  # declare a zero terminated string
Q1:		.asciiz " \n Q1 Answer: \n"	
Q2:		.asciiz " \n Q2 Answer: \n"
In1: .word	5		# Input data for Question 1 
In2: .word	9		# Input data for Question 1
In3: .word	7		# Input data for Question 1
Out1:.word 0		# Output data for Question 1
In4: .word 4, 7, 9	# Input data for Question 2
Out2:.word 0, 0, 0	# Output data for Question 2
space:	.asciiz	" "	# declare a zero terminate string

############################################################################
#  CODE
############################################################################
        .text                   # code segment
#
# Print out greetings
#
main:
        la	$a0,Hello		# address of string to print
        li	$v0,4			# system call code for print_str
        syscall         	# print the string
		
#
# Question 1-- 
# Use direct addressing to add 3 numbers in memory location In1, In2, In3 and write the result to Out1
# Print out the value stored in Out1 after calculation
#
##############Signify the output of Q1############
		la	$a0,Q1
        li	$v0,4	
        syscall
		
##############Your code from here#################
		lw $t0, In1				# Load In1 into t0
		lw $t1, In2				# Load In2 into t1
		lw $t2, In3				# Load In3 into t2
		add $t3, $t0, $t1		# Add In1 and In2 and store in t3
		add $t3, $t3, $t2		# Add t3 and In3 and store in t3
		sw $t3, Out1			# Store t3 in Out1







##############Print out Out1######################			
		lw	$a0,Out1		# Load a value in Out1 to $a0
		li	$v0,1			# syscall command 1 -- Print out 1 word
		syscall
		
		
		
		
		

#
# Question 2--
# Use indirect addressing to reverse the data sequence in array In4 and store the new sequence in Out2
# Print out the value stored in Out2 after operation
#

##############Signify the output of Q2############
		la	$a0,Q2
        li	$v0,4	
        syscall
		
##############Your code from here#################		
		la $s1, In4				# Load the address of In4 into t4
		lw $t0, 0($s1)			# Load the first value in In4 into t0
		lw $t1, 4($s1)			# Load the second value in In4 into t1
		lw $t2, 8($s1)			# Load the third value in In4 into t2

		la $s2, Out2			# Store address of Out2 into s2
		sw $t0, 8($s2)			# Store last elem into Out2[2]
		sw $t1, 4($s2)			# Store middle elem into Out2[1]
		sw $t2, 0($s2)			# Store first elem into Out2[0]



		
		
		
		
		
		
		
##############Print out Out2######################		
		li	$t6,3
		la	$t5,Out2		# $t5 point to the beginning of Out2
Print_Out2:
		lw	$a0,($t5)		# Load the first value in Out2 to $a0
		li	$v0,1			# syscall command 1 -- Print out 1 word
		syscall
		add $t5,4			# $t5 point to the 2nd element of Out2
		add $t6,-1			# counter--
		bgtz $t6,Print_Out2		
		
		
		
		
    jr $ra		
		
		
