	.text
	.align	2   @align 4 byte
	.global	main
main:

    @prologue
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #4

    @code body
	ldr r7, [r1,#4] 	@read from r1

	mov	r2, #0	@count # of bit
	COUNT:		ldrb	r1, [r7,r2]	@read bits
				cmp		r1, #0
				beq		BREAK
				add		r2, r2, #1
				b		COUNT
	BREAK:		sub		r2, r2, #1
				mov		r4, r2      @r4 has the # of bit
				mov		r1, #0
				mov     r2, #0

                mov     r5, #0
	LOOP:	    cmp		r4, r5      @until r5==r4(done)
				blt		EXIT

				ldr		r0, =string1
				ldrb	r1, [r7,r5]

                mov     r6, #90
                cmp     r1, #65
                blt     NEXT
                cmpge   r6,r1
                addge   r1,r1,#32
                bge     OUT

                mov     r6, #122
                cmp     r1, #97
                blt     NEXT
                cmpge   r6,r1
                bge     OUT
				blt		NEXT

	OUT:		bl		printf
	NEXT:		add 	r5, r5, #1
				b		LOOP


	@epilogue
	EXIT:		sub	sp, fp, #4
				ldmfd	sp!, {r4, r5, r6, r7, r8, r9, fp, lr}
				bx	lr
    string1:
		.asciz	"%c"


    .end

