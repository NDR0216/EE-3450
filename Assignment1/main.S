#define MAX_SIZE 1024
.section .data
.align 8
# There are fours global variables:
#  * array: Store the input numbers
#  * low, mid, high: indices 
#  where array[low:mid] and array[mid+1:high] are sorted
# You can modify the following lines to test your program
# Also, max array length = 128 , that is 1024 byte. 
array: .dword  NUM1, NUM2, NUM3, NUM4, NUM5, NUM6, NUM7
low: .dword LOW
high: .dword HIGH
mid: .dword MID
temp: .space MAX_SIZE

.section .text
.global main
main:

  # your code goes here
 
		# s0: the addr of array
		# s1: low
		# s2: high
		# s3: mid
		# s4: the addr of temp
		# s5: i, the index of array[low:mid]
		# s6: j, the index of array[mid+1:high]
		# s7: k, the index of temp
		# s8: a[i]
		# s9: a[j]

		la	s0, array
		ld 	s1, low
		ld	s2, high
		ld	s3, mid
		la	s4, temp
		add	s5, s1, zero		# i = low
		addi	s6, s3, 1		# j = mid+1
		add	s7, zero, zero		# k = 0

while:		addi	t0, s3, 1		# t0 = mid+1
		bge	s5, t0, remain_j	# if i > mid, jump to remain_j
		addi	t1, s2, 1		# t1 = high+1
		bge	s6, t1, remain_i	# if j > high, jump to remain_i
		slli	t2, s5, 3		# t2 = 8*i
		add	t3, s0, t2		# t3 = a[]+8*i
		ld	s8, 0(t3)		# load a[i]
		slli	t4, s6, 3		# t4 = 8*j
		add	t5, s0, t4		# t5 = a[]+8*j
		ld	s9, 0(t5)		# load a[j]

if:		bge	s8, s9, else		# if a[i] >= a[j], jump to else
		slli 	t0, s7, 3		# t0 = 8*k
		add	t1, s4, t0		# t1 = temp[]+8*k
		sd	s8, 0(t1)		# temp[k] = a[i]
		addi	s5, s5, 1		# i++
		addi	s7, s7, 1 		# k++
		beq	zero, zero, while	# while loop
else:		slli    t0, s7, 3               # t0 = 8*k
        	add     t1, s4, t0              # t1 = temp[]+8*k
        	sd      s9, 0(t1)               # temp[k] = a[j]
        	addi    s6, s6, 1               # j++
        	addi    s7, s7, 1               # k++
        	beq     zero, zero, while	# while loop
remain_i:	slli	t0, s5, 3
		add	t1, s0, t0
		ld	s8, 0(t1)
		slli    t2, s7, 3               # t0 = 8*k
        	add     t3, s4, t2              # t1 = temp[]+8*k
        	sd      s8, 0(t3)               # temp[k] = a[i]
        	addi    s5, s5, 1               # i++
        	addi    s7, s7, 1               # k++
        	addi    t4, s3, 1               # t4 = mid+1
        	blt     s5, t4, remain_i	# if i <= mid, jump to dump_i
        	beq     zero, zero, exit	# else jump to exit
remain_j: 	slli    t0, s6, 3
                add     t1, s0, t0
                ld      s9, 0(t1)
                slli    t2, s7, 3               # t0 = 8*k
                add     t3, s4, t2              # t1 = temp[]+8*k
                sd      s9, 0(t3)               # temp[k] = a[i]
                addi    s6, s6, 1               # i++
                addi    s7, s7, 1               # k++
                addi    t4, s2, 1               # t4 = mid+1
                blt     s6, t4, remain_j        # if i <= mid, jump to dump_i
                beq     zero, zero, exit        # else jump to exit
exit:		add	s7, zero, zero		# k = 0
		add	s5, s1, zero		# i = low
for:		slli    t0, s7, 3               # t0 = 8*k
        	add     t1, s4, t0              # t1 = temp[]+8*k
        	ld      t2, 0(t1)               # t2 = temp[k]
		slli	t3, s5, 3
		add	t4, s0, t3
		sd	t2, 0(t4)		# a[k+low] = temp[k]
		addi	s5, s5, 1		# i++
		addi	s7, s7, 1		# k++
		addi    t5, s2, 1               # t5 = high+1
        	blt     s5, t5, for		# if i <= high, jump to for
 
  # do not modify following
  li  a0, 0      #assign 0 to a0
  ret            #return (jump to the addr store in register ra)

