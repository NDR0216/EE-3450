.section .text
.global search_3

################################################################################
# a0: base address of array A
# a1: number of elements in array A
# a2: target number
#
# Linear search.
# Optimize with:
# 1. loop unrolling
# 2. static reordering
################################################################################
search_3:
        # t0: i
        # t1: the addr of a[i]
        # t2: temp reg  

        addi     t0, zero, -1
        add     t1, a0, zero
for:    lw      t2, 0(t1)
	addi	t0, t0, 1
        beq     t2, a2, exit
        lw      t2, 4(t1)
	addi    t0, t0, 1
        beq     t2, a2, exit
        lw      t2, 8(t1)
	addi    t0, t0, 1
        beq     t2, a2, exit
        lw      t2, 12(t1)
	addi    t0, t0, 1
	addi	t1, t1, 16
        beq     t2, a2, exit
        blt     t0, a1, for
        addi    a0, zero, -1
        ret
exit:   add     a0, t0, zero
        ret

