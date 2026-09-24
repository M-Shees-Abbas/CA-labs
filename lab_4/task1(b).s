.text
.globl main

main:
    li     x10, 3
    jal    x1, fact       # call fact(3)
    j      end            # stop after return

fact:
    addi   x5 , x0 , 1    

L1: 
    bge    x0 , x10 , exit #if (0 >= n), exit loop
    mul    x5 , x5 , x10   
    addi   x10 , x10 , -1  #n = n - 1
    jal    x0 , L1         #repeat

exit:
    addi   x10 , x5 , 0    #return acc (move result into x10)
    jalr   x0 , 0(x1)      #return

end:
    j      end