#Author: Jack Teversham 05/10/2019
#add.asm-- A program that computes the sum of 1 and 2,
#leaving the result in register $t0. Registers used:
# t0-used to hold the number inputted
# t1-used to hold the divisor
# t3-used to hold the result
# t4 used to hold the remainder

main:                      #SPIM starts execution at main


       la $a0, input_msg   #load the address of the prompt message into the regitser a0 (where syscall expects strings)
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall

       li $v0, 5           #code telling syscall to read in a value
       syscall
       move $t0, $v0       #move the number read into the register t0

       la $a0, input_msg1   #load the address of the prompt message into the regitser a0 (where syscall expects strings)
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall


       li $t1, 1           #load 1 into $t1, the initial divisor -1

loop:
       beq $t1, 9 , endloop #if divisor = 9, endloop

       add $t1, $t1, 1     #increment divisor by 1
       div $t0, $t1        #perform divison
       mfhi $t4            #remainder stored in $a2

       beqz $t4, printValue #if remainder is zero, print the divisor


       b loop

printValue:
       ##Print out value of $t0
       move $a0, $t1       #put value of t0 into a0 (where syscall accessing the value to be printed)
       li $v0, 1           #syscall code for printing an integer
       syscall

       la $a0, newline
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall

       b loop

endloop:
      li $v0, 10          #syscall code 10 is for exit
      syscall             #transfers control to the operating system (which looks in register $v0 for an exit code)


#data for the program
    .data
input_msg:    .asciiz "Enter a number:\n"
input_msg1:   .asciiz "The single digit divisors are:\n"
newline:      .asciiz "\n"


#end of question1.asm
