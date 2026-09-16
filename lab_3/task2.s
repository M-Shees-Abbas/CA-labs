.text
.globl main
main:
    li x10, 4
    li x11, 3
    li x12, 2
    li x13, 1

    li x18, 10
    li x19, 20
    li x20, 30

    jal x1, leaf
    j Exit

leaf:
    addi sp, sp, -12
    sw x18, 0(sp)
    sw x19, 4(sp)
    sw x20, 8(sp)
    li x20, 0
    add x18,x10,x11
    add x19,x12,x13
    sub x20, x18, x19
    mv x10, x20
    lw x20, 8(sp)
    lw x19, 4(sp)
    lw x18, 0(sp)
    addi sp, sp, 12
    jalr x0, 0(x1)


Exit:

end:
    j end   