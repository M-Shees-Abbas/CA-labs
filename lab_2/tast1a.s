.text
.globl main
main:
    li x20, 0x6
    li x21, 0x3
    li x22, 0x7
    li x23, 0x5
    
    bne x22,x23,Else
    add x19, x20, x21
    beq x0,x0,Exit
    Else: sub x19, x20, x21
    Exit:

end:
    j end   