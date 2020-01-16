.section .text
.global rand_3

################################################################################
# a0: base address of array A
# a1: number of elements in array A
# a2: seed
#
# Generate pseudo-random numbers.
# Optimize with:
# 1. new instruction: lfsr
# 2. loop unrolling
################################################################################
rand_3:
        # t0: the addr of a[n]
        # t1: the addr of a[i]
        # t2: a[i-1]
        # t3: 0x380000c3
        # t4: temp
        sw      a2, 0(a0)       # a[0] = seed 
        slli    t4, a1, 2       # temp = 4n
        add     t0, a0, t4      # t0 = *a[n]
        addi    t1, a0, 4       # t1 = *a[1]
        add     t2, a2, zero    # t2 = seed
        lui     t3, 0x38000
        addi    t3, t3, 0x0c3   # t3 = 0x380000c3
for:    .word 0x01c3f38b
        sw      t2, 0(t1)       # store a[i]
	.word 0x01c3f38b
        sw      t2, 4(t1)       # store a[i]
	.word 0x01c3f38b
        sw      t2, 8(t1)       # store a[i]
	.word 0x01c3f38b
        sw      t2, 12(t1)       # store a[i]
        addi    t1, t1, 16       # i++
        blt     t1, t0, for     # i < n
        ret
