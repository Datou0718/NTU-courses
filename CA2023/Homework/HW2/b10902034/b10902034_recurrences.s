# Ref: https://github.com/SmallHanley/Computer-Architecture/blob/master/lab1.asm

.globl	__start

.text
__start:
    li t0, 0
    li t1, 1
    # Read n
    li a0, 5
    ecall
    mv s0, a0 # store n at x10
    jal ra, recurse
    beq x0, x0, output 

output:
    # Output the result
    li a0, 1
    mv a1, s0
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall

recurse:
    beq s0, t1, set_1 # if n == 1, set return value to 1
    beq s0, x0, set_0 # else if n == 0, set return value to 0
    addi sp, sp, -12 # push stack
    sw ra, 4(sp) # store return address at SP+4
    sw s0, 8(sp) # store n at SP+8
    addi s0, s0, -1 # s0 = n-1
    jal ra, recurse # calculate T(n-1)
    slli s0, s0, 1 # return value of T(n-1) * 2
    sw s0, 0(sp) # store return value at SP
    lw s0 8(sp) # load n
    addi s0, s0, -2 # s0 = n-2
    jal ra, recurse # calculate T(n-2)
    lw s1, 0(sp) # load 2*T(n-1)
    add s0, s0, s1 # return value = T(n-1)*2 + T(n-2)
    lw ra 4(sp) # load return address
    addi sp, sp, 12 # pop stack
    beq x0, x0, return
    
set_1:
    li x10, 1 # set return value to 1
    beq x0, x0, return # return

set_0:
    li x10, 0 # set return value to 0
    beq x0, x0, return # return

return:
    jalr x0, 0(ra)
      
    