#Author: Jack Teversham 05/10/2019
#add.asm-- A program that computes the sum of 1 and 2,
#leaving the result in register $t0. Registers used:
# t0-used to hold the number inputted
# t1-used to hold the divisor
# t3-used to hold the result
# t4 used to hold the remainder

main:                      #SPIM starts execution at main

       li $t1, 0          #load 1 into $t1, initial counter

loop:
       add $t1, $t1, 1     #increment divisor by 1
       beq $t1, 6, endloop #if index>5, endloop

       la $a0, input_msg   #load the address of the prompt message into the regitser a0 (where syscall expects strings)
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall

       li $v0, 5           #code telling syscall to read in a value
       syscall
       move $t0, $v0       #move the number read into the register t0

       li $t3, 2           #put 2 in t3 for division purposes

       div $t0, $t3        #perform divison by 2
       mfhi $t4            #remainder stored in $t4

       beqz $t4, divisibleBy3true2 #if it is divisible by 2, check if its divisible by 3 next
       bnez $t4, divisibleBy3false2


divisibleBy3true2:
       li $t3, 3
       div $t0, $t3
       mfhi $t4

       beqz $t4, print1
       bnez $t4, print4

       print4:
       la $a0, output4
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall
       b loop


       print1:
       la $a0, output1
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall

       b loop

divisibleBy3false2:
       li $t3, 3
       div $t0, $t3
       mfhi $t4

       beqz $t4, print3
       bnez $t4, print2

       print2:
       la $a0, output2
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall
       b loop

       print3:
       la $a0, output3
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall

       b loop


endloop:
      li $v0, 10          #syscall code 10 is for exit
      syscall             #transfers control to the operating system (which looks in register $v0 for an exit code)


#data for the program
    .data
input_msg:    .asciiz "Enter a number:"
newline:      .asciiz "\n"
output1:      .asciiz "It is divisible by both 2 and 3\n"
output2:      .asciiz "It is neither divisible by 2 nor 3\n"
output3:      .asciiz "It is divisible by 3\n"
output4:      .asciiz "It is divisible by 2\n"



#end of question1.asm
