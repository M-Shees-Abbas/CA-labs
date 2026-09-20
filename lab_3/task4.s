.text
.globl main

main:
    li   a0, 0x200          # a0 = base address of x (destination)
    li   a1, 0x100          # a1 = base address of y (source)

    # Populate y with the string "Hi!" and the null terminator
    li   t0, 72             # 'H'
    li   t1, 105            # 'i'
    li   t2, 33             # '!'
    sb   t0, 0(a1)          # y[0] = 'H'
    sb   t1, 1(a1)          # y[1] = 'i'
    sb   t2, 2(a1)          # y[2] = '!'
    sb   zero, 3(a1)        # y[3] = '\0'

    jal  ra, strcpy         # call strcpy(x, y)

    lbu  s0, 0(a0)          # s0 = x[0], should be 72 ('H')
    lbu  s1, 1(a0)          # s1 = x[1], should be 105 ('i')
    lbu  s2, 2(a0)          # s2 = x[2], should be 33 ('!')
    lbu  s3, 3(a0)          # s3 = x[3], should be 0 ('\0')
    j    end                # done

strcpy:
    li   t0, 0              # i = 0
    loop:
        add  t1, t0, a1         # t1 = address of y[i]
        lbu  t2, 0(t1)          # t2 = y[i]
        add  t3, t0, a0         # t3 = address of x[i]
        sb   t2, 0(t3)          # x[i] = y[i]
        beq  t2, zero, done     # if y[i] == '\0', exit loop
        addi t0, t0, 1          # i += 1
        j    loop               
    done:
        jalr x0, 0(ra)         

end:
    j    end