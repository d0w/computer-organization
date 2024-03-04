############################################################################
#                       Lab 3
#                       EC413
#
#    		Assembly Language Lab -- Programming with Loops.
#
############################################################################
#  DATA
############################################################################
        .data           # Data segment
Hello:  .asciiz " \n Hello World! \n "  # declare a zero terminated string
Hello_len: .word 16
AnInt:	.word	12		# a word initialized to 12
# AnInt:  .word   15            # Used to vary AnInt
space:	.asciiz	" "	        # declare a zero terminate string
WordAvg:   .word 0		# use this variable for part 6
ValidInt:  .word 0		#
ValidInt2: .word 0		#
lf:     .byte	10, 0		# string with carriage return and line feed
InLenW:	.word   4       	# initialize to number of words in input1 and input2
InLenB:	.word   16      	# initialize to number of bytes in input1 and input2
        .align  4

# Uncomment to use varying input sizes
# InLenW:	.word   6       	# initialize to number of words in input1 and input2
# InLenB:	.word   24      	# initialize to number of bytes in input1 and input2
# Input1:	.word	0x01020304,0x05060708
# 	.word	0x090A0B0C,0x0D0E0F10
#         .word   0x01030214,0x15161718
#         .align  2
# Input2: .word   0x01221117,0x090b1d1f   # input
# .word   0x0e1c2a08,0x06040210
# .word   0x111428a2,0x11121314
# .align  2
        .align  4
Input1:	.word	0x01020304,0x05060708
	.word	0x090A0B0C,0x0D0E0F10
        .align  4


Input2: .word   0x01221117,0x090b1d1f   # input
        .word   0x0e1c2a08,0x06040210
        .align  4



Copy:  	.space  0x80    # space to copy input word by word
        .align  4
 
Difference: .word 1	# use this variable for part 2
Enter: .asciiz "\n"
Comma: .asciiz ","
Empty: .space 12	# put some empty spaces here so the starting addr of Text is clear
Text: .asciiz " \n It is exciting to watch flying fish after a hard day of work. I do not know why some fish prefer flying and other fish would rather swim. It seems like the fish just woke up one day and decided, Hey, today is the day to fly away \n "	# a big string



############################################################################
#  CODE
############################################################################
        .text                   # code segment
#
# print out greeting
#
main:
        la	$a0,Hello	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

	
#Code for Item 2
#Count number of occurrences of letter "a" and "e" in Text string and compute the difference between the number of occurrences

        la $t0, Text            # Get address of text
        li $t2, 0x61            # ASCII value of 'a'
        li $t3, 0x65            # ASCII value of 'e'
        li $s0, 0               # Initialize count of 'a' to 0
        li $s1, 0               # Initialize count of 'e' to 0
loop_2:
        lb $t1, 0($t0)          # Get the byte at the address
        beqz $t1, diff_2        # check if == 0 and branch to diff_2

        beq $t1, $t2, inc_a     # check if == 'a'
        beq $t1, $t3, inc_e     # check if == 'e'

        addi $t0, $t0, 1        # move to next byte
        j loop_2                # continue loop
        
inc_a:
        addi $s0, $s0, 1        # increment count of 'a'
        addi $t0, $t0, 1        # move to next byte
        j loop_2                # continue loop

inc_e:
        addi $s1, $s1, 1        # increment count of 'e'
        addi $t0, $t0, 1        # move to next byte
        j loop_2                # continue loop

diff_2:
        # do a-e or e-b depending on which is larger
        bge $s0, $s1, diff_a    # check if count of 'a' >= count of 'e'
        bge $s1, $s0, diff_b    # check if count of 'e' >= count of 'a'

diff_a:
        sub $s2, $s0, $s1       # compute difference
        #sw  $s2, Difference     # store difference in memory
        j end_2                 
diff_b:
        sub $s2, $s1, $s0       # compute difference
        #sw  $s2, Difference     # store difference in memory
        j end_2                 

end_2:
        sw $s2, Difference
        move  $a0, $s2          # copy int to print to $a0 (register used for syscall)
        li  $v0, 1              # system call code for print int
        syscall                 # print the int



################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
################################################################################

#
# Code for Item 3 -- 
# Print the integer value of numbers from 5 and less than AnInt
# 
# NOTE: Here, I'm assuming that we are printing values [5, AnInt) (including 5 but excluding AnInt)

        li $t0, 5               # Initialize counter
        lw $s0, AnInt           # Load AnInt into $s0
loop_3:
        bge $t0, $s0, end_3     # check if counter >= AnInt

        # print value
        move $a0, $t0           # copy int to print to $a0 (register used for syscall)
        li $v0, 1               # system call code for print int
        syscall                 # print the int

        # print space
        la $a0, space           # address of string to print
        li $v0, 4               # system call code for print_str
        syscall                 # print the string

        addi $t0, $t0, 1        # increment counter
        j loop_3                # continue loop

end_3:




###################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
###################################################################################
#
# Code for Item 4 -- 
# Print the integer values of each byte less than 4 in the array Input2 (with spaces) 
#
# NOTE: (doing Input1 since Input1 stated on lab sheet)
        la $s0, Input2          # Get address of Input1 
        li $s1, 4               # Load 4 into s1
        li $t0, 0               # Initialize counter to 0
        lw $s4, InLenB  

loop_4:
        beq $t0, $s4, end_4      # Check if counter == inLenB, branch
        lb $t1, 0($s0)          # Load byte from Input1
        addi $s0, $s0, 1        # Move to next byte
        addi $t0, $t0, 1         # Increment counter

        blt $t1, $s1, printInt   # Check if byte < 4
        j loop_4

printInt:
        move $a0, $t1           # copy int to print to $a0 (register used for syscall)
        li $v0, 1               # system call code for print int
        syscall                 # print the int

        la $a0, space           # address of string to print
        li $v0, 4               # system call code for print_str
        syscall                 # print the string

        j loop_4                # continue loop

end_4:








###################################################################################
#
# Code for Item 5 -- 
# Write code to copy the contents of Input2 to Copy
# 
# NOTE: This code only copies contents but does no printing since it was not specified.

        la $s0, Input2          # Get address of Input2
        la $s1, Copy            # Get address of Copy
        li $t0, 0               # Initialize counter to 0

        lw $s4, InLenW
loop_5:
        beq $t0, $s4, end_5     # Branch if looped InLenW times
        lw $t1, 0($s0)          # Load word from Input2
        sw $t1, 0($s1)          # Store word to Copy
        addi $s0, $s0, 4        # Move to next word
        addi $s1, $s1, 4        # Move to next word
        addi $t0, $t0, 1        # Increment counter

        j loop_5
end_5:

la $t7, Copy # use to check address of Copy to check if Input2 copied














#################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
###################################################################################
#
# Code for Item 6 -- 
# Print the integer average of squares of the contents of array Input1
#

        la $s0, Input1          # Get address of Input1
        li $t0, 0               # Initialize counter to 0
        li $t1, 0               # Initialize sum to 0
        li $s1, 0               # Initialize sum of squares to 0

        lw $s4, InLenB          # find byte size of array
loop_6:
        beq $t0, $s4, end_6     # Check if looped InLenB times ( all bytes )
        lb $t2, 0($s0)          # Load byte from Input1
        mult $t2, $t2           # Square the byte
        mflo $t2                # Get low 32 bits of product (without overflow)
        add $s1, $s1, $t2       # Add square to sum of squares

        addi $s0, $s0, 1        # Move to next byte
        addi $t0, $t0, 1        # Increment counter
        j loop_6                # Continue loop
end_6:
        div $s1, $s4            # Divide sum of squares by inLenB
        mflo $s1                # get low 32 bits (without remainder)
        sw $s1, WordAvg         # store value in memory
        move $a0, $s1           # copy int to print to $a0 (register used for syscall)
        li $v0, 1               # system call code for print int
        syscall                 # print the int
















#################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
##################################################################################
#
# Code for Item 7 -- 
# Display the first 10 integers that are divisible by either 7 and 13 (with space)
#

        li $s0, 0              # First value to 0
        li $t0, 0              # Initialize counter to 0

        li $s1, 7              # Load 7 into s1
        li $s2, 13             # Load 13 into s2

        li $t1, 0              # Check until 10 numbers
loop_7:
        beq $t1, 10, end_7     # Check if found 10 numbers

        div $s0, $s1           # Divide current value by 7
        mfhi $t2               # Get remainder
        beqz $t2, print_7      # Check if remainder == 0

        div $s0, $s2           # Divide current value by 13
        mfhi $t2               # Get remainder
        beqz $t2, print_7      # Check if remainder == 0

        addi $s0, $s0, 1       # Increment current value

        j loop_7
print_7:
        addi $t1, $t1, 1       # Incrememt # found numbers

        move $a0, $s0          # Move into a0 reg
        li $v0, 1              # syscall code
        syscall

        la $a0, space           # print space
        li $v0, 4
        syscall

        addi $s0, $s0, 1
        j loop_7


end_7:
        

#################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
##################################################################################











#
# Code for Item 8 -- 
# Repeat step 7 but display the integers in 3 lines each with 5 integers (with spaces between the integers)
# This must be implemented using a nested loop.
#
# NOTE: Repeated step 7 but instead of first 10 numbers, using first 15 since we are trying to get 5x3 matrix

        li $s0, 0               # First value to 0
        li $t0, 0               # Initialize counter to 0

        li $s1, 7               # Load 7 into s1
        li $s2, 13              # Load 13 into s2

        li $t1, 0               # Check until 10 numbers

        li $s3, 5               # number of cols
        li $s4, 3               # number of rows


loop_8:
        li $t4, 0               # i value
       
        loop_inner_8:
                beq $t1, 15, end_8      # Check if found 15 numbers since we need 5x3 matrix

                div $s0, $s1            # Divide current value by 7
                mfhi $t2                # Get remainder
                beqz $t2, print_8       # Check if remainder == 0

                div $s0, $s2            # Divide current value by 13
                mfhi $t2                # Get remainder
                beqz $t2, print_8       # Check if remainder == 0

                addi $s0, $s0, 1        # Increment current value


                j loop_inner_8

                print_8:
                        addi $t1, $t1, 1        # Incrememt # found numbers

                        move $a0, $s0           # Move into a0 reg
                        li $v0, 1               # syscall code
                        syscall

                        la $a0, space           # print space
                        li $v0, 4
                        syscall

                        addi $s0, $s0, 1        # go to next byte in array
                        
                        addi $t4, $t4, 1        # incremement col counter
                        beq $t4, 5, next_row    # jump to next row if reach 5 prints

                        
                j loop_inner_8

        next_row:
                la $a0, lf              # load line feed
                li $v0, 4               # print line feed
                syscall
        # jump to outerloop after 5 prints
        j loop_8


end_8:





Exit:
	jr $ra