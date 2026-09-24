.text
.globl main

main:
    li   x10, 0x200         
    li   x11, 5              

    li   x5, 1                  #array being populated
    sw   x5, 0(x10)          
    li   x5, 2
    sw   x5, 4(x10)          
    li   x5, 3
    sw   x5, 8(x10)         
    li   x5, 4
    sw   x5, 12(x10)         
    li   x5, 5
    sw   x5, 16(x10) 
    li  x8, 1                   #storing values in saved registers to see the stack implementation
    li  x9, 5
    li  x18, 4
    li  x19, 2

    jal  x1, sumOfSquares    #call the func
    j    end                 

#
sumOfSquares:
    addi sp, sp, -20         #saving value before the sceond function call
    sw   x1, 16(sp)          
    sw   x8, 12(sp)          # as x8, x9, x18 and x19 are saved register so to use them we gonna store their values  
    sw   x9, 8(sp)           
    sw   x18, 4(sp)          
    sw   x19, 0(sp)         

    addi x8, x10, 0          # x8 = a
    addi x9, x11, 0          # x9 = len
    li   x18, 0              # x18 = i = 0
    li   x19, 0              # x19 = sum = 0

loop:
    bge  x18, x9, done        #if (i >= len) exit loop

    slli x6, x18, 2           #x6 = i * 4
    add  x6, x8, x6           #x6 = address of a[i]
    lw   x10, 0(x6)           #argument for square function

    jal  x1, square           #call square function with argument in x10

    add  x19, x19, x10        #sum += sq (result returned in x10)
    addi x18, x18, 1          #i++
    j    loop                 #repeat

done:
    addi x10, x19, 0          #return value = sum

    lw   x1, 16(sp)           #restore return address
    lw   x8, 12(sp)           #restore s0
    lw   x9, 8(sp)            #restore s1
    lw   x18, 4(sp)           #restore s2
    lw   x19, 0(sp)           #restore s3
    addi sp, sp, 20           

    jalr x0, 0(x1)            #return to caller


square:
    mul  x10, x10, x10        #return x * x
    jalr x0, 0(x1)            #return to caller

end:
    j    end                  