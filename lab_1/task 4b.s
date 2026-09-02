.text
.globl main
main:
    li x5, 0x100
    li x6, 0x200
    li x7, 0x300

    lb x21, 0(x5)
    lh x22, 0(x6)
    add x23, x21, x22
    sw x23, 0(x7)

    lb x21, 1(x5)
    lh x22, 2(x6)
    add x23, x21, x22
    sw x23, 4(x7)

    lb x21, 2(x5)
    lh x22, 4(x6)
    add x23, x21, x22
    sw x23, 8(x7)

    lb x21, 3(x5)
    lh x22, 6(x6)
    add x23, x21, x22
    sw x23, 12(x7)


end:
    j end