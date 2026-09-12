.text
.globl main
main:
    li x20, 5
    li x21, 2
    li x22, 3
    li x23, 4
    li x5, 1
    

    bne x20, x5, Case2
    add x21, x22, x23
    j done
Case2: li x5, 2
    bne x20, x5, Case3
    sub x21, x22, x23
    j done
Case3: li x5, 3
    bne x20, x5 ,Case4
    slli x21, x22, 1
    j done
Case4: li x5, 4
    bne x20, x5, default
    srli x21, x22, 1
    j done
default: li x21, 0

done:

end:
    j end   