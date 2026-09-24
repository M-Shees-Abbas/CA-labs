    .text
    .globl main

    main:
        li     x10, 0x100
        li     x11, 4
        li     x5, 3
        sw     x5, 0(x10)             
        li     x5, 1
        sw     x5, 4(x10)
        li     x5, 4
        sw     x5, 8(x10)
        li     x5, 2
        sw     x5, 12(x10)   
        jal    x1, bubble
        j      end      

    bubble:
        beq   x10, x0, exit        
        beq   x11, x0, exit        

        li    x5, 0                
    loop_i:
        bge   x5, x11, exit        
        addi  x6, x5, 0            

    loop_j:
        bge   x6, x11, next_i      

        slli  x7, x5, 2            
        add   x7, x10, x7          
        lw    x28, 0(x7)           

        slli  x29, x6, 2          
        add   x29, x10, x29        
        lw    x30, 0(x29)         

        bge   x28, x30, skip      
        sw    x30, 0(x7)         
        sw    x28, 0(x29)         

    skip:
        addi  x6, x6, 1           
        j     loop_j

    next_i:
        addi  x5, x5, 1            
        j     loop_i

    exit:
        jalr  x0, 0(x1)            

    end:
        j      end