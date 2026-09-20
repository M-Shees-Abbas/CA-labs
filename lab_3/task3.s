.text
.globl main

main:
    li   a0, 0x100          # a0 = base address of v
    li   a1, 0              # a1 = k = 0

    # Populate only the two elements the swap uses
    li   t0, 10
    li   t1, 20
    sw   t0, 0(a0)          # v[0] = 10
    sw   t1, 4(a0)          # v[1] = 20

    jal  ra, swap           # call swap(v, k)

    lw   s0, 0(a0)          # s0 = v[0], should now be 20
    lw   s1, 4(a0)          # s1 = v[1], should now be 10
    j    end                # done

swap:
    slli t1, a1, 2          # t1 = k * 4 (each long is 4 bytes)
    add  t1, a0, t1         # t1 = address of v[k]
    lw   t0, 0(t1)          # temp = v[k]
    lw   t2, 4(t1)          # t2 = v[k+1]
    sw   t2, 0(t1)          # v[k] = v[k+1]
    sw   t0, 4(t1)          # v[k+1] = temp
    jalr x0, 0(ra)          # return to caller

end:
    j    end                # loop forever to stop execution