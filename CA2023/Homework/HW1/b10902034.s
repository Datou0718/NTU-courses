.globl __start

.rodata
    division_by_zero: .string "division by zero"

.text
__start:
    # Read first operand
    li a0, 5
    ecall
    mv s0, a0
    # Read operation
    li a0, 5
    ecall
    mv s1, a0
    # Read second operand
    li a0, 5
    ecall
    mv s2, a0

###################################
#  TODO: Develop your calculator  #
#                                 #
###################################
    
    # For beq op t(i)
    li t0 0
    li t1 1
    li t2 2
    li t3 3
    li t4 4
    li t5 5
    li t6 6

    beq t0, s1, ADDITION
    beq t1, s1, SUBSTRACTION
    beq t2, s1, MULTIPLICATION
    beq t3, s1, DIVISION
    beq t4, s1, MINIMUM
    addi s3, x0, 1
    beq t5, s1, POWER
    beq t6, s1, FACTORIAL
    # exception
    beq x0, x0, exit

ADDITION:
    add s3, s0, s2
    beq t0, s1, output

SUBSTRACTION:
    sub s3, s0, s2
    beq t1, s1, output

MULTIPLICATION:
    mul s3, s0, s2
    beq t2, s1, output

DIVISION:
    beq s2, x0, division_by_zero_except
    div s3, s0, s2
    beq t3, s1, output
    
MINIMUM:
    ble s0, s2, SET_S0
    add s3, s2, x0
    beq t4, s1, output
    SET_S0:
      add s3, s0, x0
      beq t4, s1, output

POWER:
    bge s2, x0, POW_LOOP
    POW_LOOP:
      beq s2, x0, output
      addi s2, s2, -1
      mul s3, s3, s0
      jal x0, POW_LOOP

FACTORIAL:
    beq s0, x0, output
    mul s3, s3, s0
    addi s0, s0, -1
    jal x0, FACTORIAL 

output:
    # Output the result
    li a0, 1
    mv a1, s3
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall

division_by_zero_except:
    li a0, 4
    la a1, division_by_zero
    ecall
    jal zero, exit
