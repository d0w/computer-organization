		.data
HW: 	.asciiz 	"Hello World\n"
Int1:	.word	20		#32 bits used in memory, the value is 14 in hex
Char1:	.byte	'a'		#8 bits used in memory, ASCII in hex: 61
Char2:	.byte	'b'		#8 bits used in memory, ASCII in hex: 62. See how 'a' and 'b' are stored in memory (under data tag in QtSpim)
Array1:	.word	2, 3, 4, 5	#spaces are needed after each comma
Array2: .space  8		#empty space specified in bytes 

		.text
main:	#label to indicate your main loop. Labels and Data names are unique. 	#can be called anything?
	
		#print string	
		la $a0, HW			#get base address of string
		li $v0,4				#load command to print string 
		syscall		
		#print integer
		lw $a0, Int1			#get the value of Int1
		li $v0,1				#load command to print integer
		syscall 
		#get input
		li $v0,5				#load command to get input
		syscall 
		addi $t0, $v0, 0 		#copy to general purpose register
		#store integer
		la $t1, Array2			#get base address of Array2
		sw $t0, 0($t1)			#store input value to Array2[0]
		#copy array element
		la $t2, Array1			#get base address of Array1
		lw $t0, 8($t2)			#get the value of Array1[2]
		addi $t1, $t1, 4		#get the address of Array2[1]
		sw $t0, 0($t1) 			#Array2[1] = Array1[2]

	
		jr $ra

