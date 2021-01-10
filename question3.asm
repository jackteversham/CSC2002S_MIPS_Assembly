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

       li $v0, 5           #code telling syscall to read in a value
       syscall
       move $t1, $v0       #move the number read into the register t0

       li $t2, 0         #this will act as a counter for divisors of both numbers

       li $t3, 1           #load 1 into $t3, the initial divisor will be 1


  loop:
       beq $t1, $t3 , endloop #if divisor = number read in, endloop
       beq $t0, $t3 , endloop #if divisor = number read in, endloop
       add $t3, $t3, 1     #increment divisor by 1

       div $t1, $t3        #perform divison
       mfhi $t4            #remainder stored in $a2
       beqz $t4, checkOther #if remainder is zero, there is a divisor so end

       b loop

      checkOther:
      div $t0, $t3        #perform divison
      mfhi $t4            #remainder stored in $a2
      beqz $t4, end #if remainder is zero, there is a divisor so end
      b loop


end:
       la $a0, output2
       li $v0, 4           #code 4 tells syscall uts is printing a string
       syscall

       b exit

endloop:
     la $a0, output1
     li $v0, 4           #code 4 tells syscall uts is printing a string
     syscall

     b exit


exit:
      li $v0, 10          #syscall code 10 is for exit
      syscall             #transfers control to the operating system (which looks in register $v0 for an exit code)


#data for the program
    .data
input_msg:    .asciiz "Enter the first number:\n"
input_msg1:    .asciiz "Enter the second number:\n"
output1:       .asciiz "The two numbers are relatively prime\n"
output2:       .asciiz "The two numbers are not relatively prime\n"
newline:      .asciiz "\n"


#end of question1.asm
