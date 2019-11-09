########################################
# Make 'merge' a function: 
#   Similar to the previous task, the only difference is merge now becomes a function.
#   That is,
#   a0 --> nums[]
#   a1 --> low
#   a2 --> mid 
#   a3 --> high 
#   as designated in declaraction of merge() in main.c
#   Again, [low, mid] sorted, [mid+1, high] sorted
########################################


#define MAX_SIZE 1024
.section .data
.align 8
temp: .space MAX_SIZE 


.section .text
.global merge 
merge:

  # your code goes here
  # remember to save register such as s0 or ra onto the stack if you used it in the assembly. 

		# s0: the addr of temp
		# s1: the addr of temp[k]
		# t0: the addr of a[i]
		# t1: the addr of a[j]
		# t2: the addr of a[mid+1]
		# t3: the addr of a[high+1]
		# t4: a[i]
		# t5: a[j]
		# t6: temp register

		# initialize t2
		add	t6, a2, 1		# temp = mid+1
		slli	t6, t6, 3		# temp = 8*(mid+1)
		add	t2, a0, t6		# t2 = *a[mid+1]

		# check whether the nums need to be search, both initialize t5
		ld	t6, -8(t2)		# load a[mid]
		ld	t5, 0(t2)		# load a[mid+1]
		bge	t5, t6, return		# if a[mid+1] > a[mid]

		# push s0, s1 to stack
		addi	sp, sp, -16
		sd	s1, 8(sp)
		sd	s0, 0(sp)

		# initialize s0, s1
		la	s0, temp		# s0 = temp[]
		add	s1, s0, zero		# s1 = temp[0]
		
		# initialize other temp register
		slli	t6, a1, 3		# temp = 8*low
		add	t0, a0, t6		# t0 = *a[low]
		add	t1, t2, zero		# t1 = *a[mid+1]
		addi	t6, a3, 1		# temp = high+1	
		slli	t6, t6, 3		# temp = 8*(high+1)
		add	t3, a0, t6		# t3 = a[high+1]

		## if mid = high, no need to comparison
		bge	t1, t3, remain_i	# if j > high, jump to remain_i
		ld	t4, 0(t0)		# load a[i]
		ld	t5, 0(t1)		# load a[j]

		# comparison
if:		bge	t4, t5, else		# if a[i] >= a[j], jump to else
		sd	t4, 0(s1)		# temp[k] = a[i]
		addi	t0, t0, 8		# i++
		addi	s1, s1, 8		# k++
		ld	t4, 0(t0)		# load a[i]
		blt	t0, t2, if		# if i <= mid, jump to if
remain_j:       add     t3, t1, zero		# high = j-1
                beq     zero, zero, exit        # exit
else:		sd      t5, 0(s1)               # temp[k] = a[j]
		addi	t1, t1, 8		# j++
		addi	s1, s1, 8		# k++
		ld	t5, 0(t1)		# load a[j]
		blt	t1, t3, if		# if j <= high, jump to if
remain_i:	ld	t4, 0(t0)		# load a[i]
		sd      t4, 0(s1)               # temp[k] = a[i]
		addi	t0, t0, 8		# i++
		addi	s1, s1, 8		# k++
        	blt     t0, t2, remain_i	# if i <= mid, jump to remain_i

		# load temp to nums
exit:		addi	t1, t1, -8		# j = high
		addi	s1, s1, -8		# k = high-low
for:		ld      t6, 0(s1)               # load temp[k]
		sd	t6, 0(t1)		# a[j] = temp[k]
		addi	t1, t1, -8		# j--
		addi	s1, s1, -8		# k--
        	bge	s1, s0, for		# if k >= 0, keep for looping

		# pop s0, s1 from stack
		ld	s0, 0(sp)
		ld	s1, 8(sp)
		addi	sp, sp, 16
return:
  ret      #return, same as "jr ra"

