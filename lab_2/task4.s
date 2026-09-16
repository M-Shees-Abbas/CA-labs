.text
.globl main
main:
li x7, 0
li x5, 5
li x6, 5
li x10, 0x100
FOR2:
    bge x7, x5, Exit2
    li x29, 0
    FOR1:
        bge x29, x6, EXIT1
        slli x8, x29, 2
        add x8, x8, x10
        add x9, x7,x29
        sw x9, 0(x8)
        addi x29,x29,1
        j FOR1
    EXIT1:
    addi x7, x7,1
    j FOR2
Exit2:

end:
    j end   