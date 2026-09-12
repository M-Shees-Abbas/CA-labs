.text
.globl main
main:
   li x22, 0
   li x23, 0
   li x5, 10
   li x6, 0x200

FOR1: bge x22, x5, EXIT1
    slli x7, x22, 2
    add x7, x7, x6
    sw x22, 0(x7)
    addi x22,x22,1
    j FOR1
EXIT1:
li x22, 0
FOR2:bge x22,x5,EXIT2
    slli x7,x22,2
    add x7, x7, x6
    lw x8, 0(x7)
    add x23, x23,x8
    addi x22,x22,1
    j FOR2
EXIT2:


end:
    j end   