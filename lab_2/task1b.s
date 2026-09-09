.text
.globl main
main:
    li x24, 2
    li x25, 0x100
    li x22, 0
    li x5, 2
    sw x5, 0(x25)
    li x5, 2
    sw x5, 4(x25)
    li x5, 4
    sw x5, 8(x25)
    li x5, 2
    sw x5, 12(x25)
    Loop: slli x10,x22,2
        add x10, x10, x25
        lw x9, 0(x10)
        bne x9,x24,Exit
        addi x22,x22,1
        beq x0,x0,Loop
    Exit: 

end:
    j end   