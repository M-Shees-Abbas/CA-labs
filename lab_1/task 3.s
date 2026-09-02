.text
.globl main
main:
    li x20, 5
    li x21, 0

    addi x20, x21, 32

    add x22, x20, x21   # a = x20 , b =x21, temp(a+b) = x22
    addi x23, x22, -5   #d = x23
    sub x22, x20, x23   # temp(a-d) = x22
    sub x5, x21, x20    # temp(b-a) = x5 
    add x6, x22, x5     # temp((a-d)+(b-a)) = x6
    add x7, x6, x23     # e = x7
    
    add x22, x20, x21   # temp(a+b) = x22
    add x5, x23, x7     # temp(d+e) = x5
    add x7, x22, x5
    
end:
    j end