	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_apply_pawn_promotion           ; -- Begin function apply_pawn_promotion
	.p2align	2
_apply_pawn_promotion:                  ; @apply_pawn_promotion
	.cfi_startproc
; %bb.0:
	ldr	x10, [x0]
	mov	x9, x10
	ldr	x8, [x9, #48]!
	add	x11, x10, #56
	tst	x8, x1
	b.eq	LBB0_2
; %bb.1:
	mov	w8, #0
	mov	x12, x11
	strb	w8, [x0, #8]
	ldr	x13, [x11]
	tst	x13, x2
	b.ne	LBB0_3
	b	LBB0_17
LBB0_2:
	ldrh	w8, [x0, #14]
	add	w8, w8, #1
	strh	w8, [x0, #14]
	mov	w8, #1
	mov	x12, x9
	mov	x9, x11
	strb	w8, [x0, #8]
	ldr	x13, [x12]
	tst	x13, x2
	b.eq	LBB0_17
LBB0_3:
	mvn	x11, x2
	bic	x13, x13, x2
	str	x13, [x12]
	ldr	x12, [x10, #16]
	tst	x12, x2
	b.eq	LBB0_5
; %bb.4:
	and	x11, x12, x11
	str	x11, [x10, #16]
	mov	w11, #5
	b	LBB0_21
LBB0_5:
	ldr	x12, [x10, #24]
	tst	x12, x2
	b.eq	LBB0_10
; %bb.6:
	and	x11, x12, x11
	str	x11, [x10, #24]
	mov	w11, #6
	cmp	x2, #127
	b.gt	LBB0_12
; %bb.7:
	mov	x12, #-9223372036854775808
	cmp	x2, x12
	b.eq	LBB0_18
; %bb.8:
	cmp	x2, #1
	b.ne	LBB0_21
; %bb.9:
	mov	w11, #253
	b	LBB0_20
LBB0_10:
	ldr	x12, [x10, #8]
	tst	x12, x2
	b.eq	LBB0_15
; %bb.11:
	and	x11, x12, x11
	str	x11, [x10, #8]
	mov	w11, #4
	b	LBB0_21
LBB0_12:
	cmp	x2, #128
	b.eq	LBB0_19
; %bb.13:
	mov	x12, #72057594037927936
	cmp	x2, x12
	b.ne	LBB0_21
; %bb.14:
	mov	w11, #247
	b	LBB0_20
LBB0_15:
	ldr	x12, [x10, #32]
	tst	x12, x2
	b.eq	LBB0_17
; %bb.16:
	and	x11, x12, x11
	str	x11, [x10, #32]
	mov	w11, #7
	b	LBB0_21
LBB0_17:
	mov	w11, #0
	b	LBB0_21
LBB0_18:
	mov	w11, #251
	b	LBB0_20
LBB0_19:
	mov	w11, #254
LBB0_20:
	ldrb	w12, [x0, #9]
	and	w11, w12, w11
	strb	w11, [x0, #9]
	mov	w11, #6
LBB0_21:
	mvn	x12, x1
	ldr	x13, [x10]
	bic	x13, x13, x1
	str	x13, [x10]
	sub	w13, w3, #4
	cmp	w13, #3
	b.hi	LBB0_28
; %bb.22:
Lloh0:
	adrp	x14, lJTI0_0@PAGE
Lloh1:
	add	x14, x14, lJTI0_0@PAGEOFF
	adr	x15, LBB0_23
	ldrb	w16, [x14, x13]
	add	x15, x15, x16, lsl #2
	br	x15
LBB0_23:
	add	x10, x10, #8
	b	LBB0_27
LBB0_24:
	add	x10, x10, #16
	b	LBB0_27
LBB0_25:
	add	x10, x10, #24
	b	LBB0_27
LBB0_26:
	add	x10, x10, #32
LBB0_27:
	ldr	x13, [x10]
	orr	x13, x13, x2
	str	x13, [x10]
LBB0_28:
	ldr	x10, [x9]
	orr	x10, x10, x2
	and	x10, x10, x12
	str	x10, [x9]
	mov	w9, #64
	stur	w9, [x0, #10]
	bfi	w8, w11, #8, #3
	mov	x0, x8
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
	.section	__TEXT,__const
lJTI0_0:
	.byte	(LBB0_23-LBB0_23)>>2
	.byte	(LBB0_24-LBB0_23)>>2
	.byte	(LBB0_25-LBB0_23)>>2
	.byte	(LBB0_26-LBB0_23)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_apply_pawn_other               ; -- Begin function apply_pawn_other
	.p2align	2
_apply_pawn_other:                      ; @apply_pawn_other
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	mov	x13, x8
	ldr	x9, [x13, #48]!
	add	x11, x8, #56
	tst	x9, x2
	b.eq	LBB1_2
; %bb.1:
	mov	w9, #0
	mov	x12, #-16711681
	mov	w14, #8
	mov	w15, #65280
	mov	x10, x13
	strb	w9, [x0, #8]
	tst	x15, x2
	b.ne	LBB1_4
	b	LBB1_6
LBB1_2:
	ldr	x9, [x11]
	tst	x9, x2
	b.eq	LBB1_13
; %bb.3:
	ldrh	w9, [x0, #14]
	add	w9, w9, #1
	mov	x12, #-280375465082881
	mov	x15, #71776119061217280
	strh	w9, [x0, #14]
	mov	w9, #1
	mov	w14, #248
	mov	x10, x11
	mov	x11, x13
	strb	w9, [x0, #8]
	tst	x15, x2
	b.eq	LBB1_6
LBB1_4:
	and	x12, x12, x3
	cbz	x12, LBB1_6
; %bb.5:
	mov	w12, #0
	add	w11, w14, w1
	strb	w11, [x0, #10]
	mov	w11, #1
	strb	w11, [x0, #11]
	b	LBB1_29
LBB1_6:
	ldr	x14, [x11]
	tst	x14, x3
	b.eq	LBB1_9
; %bb.7:
	mvn	x13, x3
	ldr	x12, [x8]
	ldr	x15, [x8, #16]
	tst	x12, x3
	b.eq	LBB1_14
; %bb.8:
	mov	w12, #3
	b	LBB1_26
LBB1_9:
	ldrb	w12, [x0, #11]
	cbz	w12, LBB1_28
; %bb.10:
	ldrb	w12, [x0, #10]
	mov	w13, #1
	lsl	x12, x13, x12
	tst	x12, x3
	b.eq	LBB1_16
; %bb.11:
	tst	x12, #0xff0000
	b.eq	LBB1_19
; %bb.12:
	mov	w12, #0
	mov	x13, #-1
	eor	x13, x13, x3, lsl #8
	bic	x14, x14, x3, lsl #8
	b	LBB1_20
LBB1_13:
	mov	w12, #0
                                        ; implicit-def: $w9
	and	w0, w9, #0xff
	bfi	w0, w12, #8, #3
	ret
LBB1_14:
	tst	x15, x3
	b.eq	LBB1_17
; %bb.15:
	and	x15, x15, x13
	mov	w12, #5
	b	LBB1_26
LBB1_16:
	mov	w12, #0
	b	LBB1_28
LBB1_17:
	ldr	x12, [x8, #24]
	tst	x12, x3
	b.eq	LBB1_21
; %bb.18:
	and	x12, x12, x13
	str	x12, [x8, #24]
	mov	w12, #6
	b	LBB1_26
LBB1_19:
	mov	w12, #0
	mov	x13, #-1
	eor	x13, x13, x3, lsr #8
	bic	x14, x14, x3, lsr #8
LBB1_20:
	str	x14, [x11]
	mov	x11, x8
	b	LBB1_27
LBB1_21:
	ldr	x12, [x8, #8]
	tst	x12, x3
	b.eq	LBB1_23
; %bb.22:
	and	x12, x12, x13
	str	x12, [x8, #8]
	mov	w12, #4
	b	LBB1_26
LBB1_23:
	ldr	x12, [x8, #32]
	tst	x12, x3
	b.eq	LBB1_25
; %bb.24:
	and	x12, x12, x13
	str	x12, [x8, #32]
	mov	w12, #7
	b	LBB1_26
LBB1_25:
	mov	w12, #0
LBB1_26:
	and	x14, x14, x13
	str	x14, [x11]
	and	x11, x15, x13
	ldr	x14, [x8, #24]
	and	x14, x14, x13
	stp	x11, x14, [x8, #16]
	ldr	x14, [x8, #8]
	and	x14, x14, x13
	str	x14, [x8, #8]
	add	x11, x8, #32
LBB1_27:
	ldr	x14, [x11]
	and	x13, x14, x13
	str	x13, [x11]
LBB1_28:
	mov	w11, #64
	strh	w11, [x0, #10]
LBB1_29:
	ldr	x11, [x8]
	bic	x11, x11, x2
	orr	x11, x11, x3
	str	x11, [x8]
	ldr	x8, [x10]
	orr	x8, x8, x3
	bic	x8, x8, x2
	str	x8, [x10]
	strh	wzr, [x0, #12]
	and	w0, w9, #0xff
	bfi	w0, w12, #8, #3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_apply_king_move                ; -- Begin function apply_king_move
	.p2align	2
_apply_king_move:                       ; @apply_king_move
	.cfi_startproc
; %bb.0:
	ldr	x9, [x0]
	mov	x13, x9
	ldr	x8, [x13, #48]!
	add	x10, x9, #56
	tst	x8, x1
	b.eq	LBB2_2
; %bb.1:
	mov	w8, #0
	ldrb	w11, [x0, #9]
	and	w12, w11, #0xfffffffc
	strb	wzr, [x0, #8]
	mov	x15, #-129
	mov	x14, #-2
	mov	w4, #64
	mov	w17, #4
	strb	w12, [x0, #9]
	mov	w6, #16
	mov	w16, #8
	mov	w5, #32
	mov	x11, x13
	ands	x13, x6, x1
	b.ne	LBB2_3
	b	LBB2_5
LBB2_2:
	ldrh	w8, [x0, #14]
	add	w11, w8, #1
	mov	w8, #1
	ldrb	w12, [x0, #9]
	and	w12, w12, #0xfffffff3
	mov	x15, #9223372036854775807
	strh	w11, [x0, #14]
	mov	x14, #-72057594037927937
	mov	x4, #4611686018427387904
	mov	x17, #288230376151711744
	mov	x6, #1152921504606846976
	strb	w8, [x0, #8]
	strb	w12, [x0, #9]
	mov	x16, #576460752303423488
	mov	x5, #2305843009213693952
	mov	x11, x10
	mov	x10, x13
	ands	x13, x6, x1
	b.eq	LBB2_5
LBB2_3:
	and	x4, x4, x2
	cbz	x4, LBB2_5
; %bb.4:
	mov	w13, #0
	ldr	x10, [x9, #40]
	bic	x10, x10, x1
	orr	x10, x10, x2
	str	x10, [x9, #40]
	ldr	x10, [x9, #24]
	and	x10, x10, x15
	orr	x10, x10, x5
	str	x10, [x9, #24]
	ldr	x9, [x11]
	bic	x9, x9, x1
	and	x9, x9, x15
	orr	x9, x9, x2
	orr	x9, x9, x5
	str	x9, [x11]
	ldrh	w9, [x0, #12]
	add	w9, w9, #1
	strh	w9, [x0, #12]
	mov	w9, #5
	strb	w9, [x3, #8]
	mov	w9, #64
	strh	w9, [x0, #10]
	strb	w8, [x3, #4]
	strb	w13, [x3, #5]
	ret
LBB2_5:
	cbz	x13, LBB2_8
; %bb.6:
	and	x13, x17, x2
	cbz	x13, LBB2_8
; %bb.7:
	mov	w13, #0
	ldr	x10, [x9, #40]
	bic	x10, x10, x1
	orr	x10, x10, x2
	str	x10, [x9, #40]
	ldr	x10, [x9, #24]
	and	x10, x10, x14
	orr	x10, x10, x16
	str	x10, [x9, #24]
	ldr	x9, [x11]
	bic	x9, x9, x1
	and	x9, x9, x14
	orr	x9, x9, x2
	orr	x9, x9, x16
	str	x9, [x11]
	ldrh	w9, [x0, #12]
	add	w9, w9, #1
	strh	w9, [x0, #12]
	mov	w9, #10
	strb	w9, [x3, #8]
	mov	w9, #64
	strh	w9, [x0, #10]
	strb	w8, [x3, #4]
	strb	w13, [x3, #5]
	ret
LBB2_8:
	ldr	x14, [x10]
	tst	x14, x2
	b.eq	LBB2_11
; %bb.9:
	mvn	x15, x2
	ldr	x13, [x9]
	tst	x13, x2
	b.eq	LBB2_12
; %bb.10:
	and	x12, x13, x15
	str	x12, [x9]
	mov	w13, #3
	b	LBB2_29
LBB2_11:
	mov	w13, #0
	ldrh	w10, [x0, #12]
	add	w10, w10, #1
	strh	w10, [x0, #12]
	b	LBB2_30
LBB2_12:
	ldr	x13, [x9, #16]
	tst	x13, x2
	b.eq	LBB2_14
; %bb.13:
	and	x12, x13, x15
	str	x12, [x9, #16]
	mov	w13, #5
	b	LBB2_29
LBB2_14:
	ldr	x13, [x9, #24]
	tst	x13, x2
	b.eq	LBB2_19
; %bb.15:
	and	x13, x13, x15
	str	x13, [x9, #24]
	mov	w13, #6
	cmp	x2, #127
	b.gt	LBB2_21
; %bb.16:
	mov	x16, #-9223372036854775808
	cmp	x2, x16
	b.eq	LBB2_26
; %bb.17:
	cmp	x2, #1
	b.ne	LBB2_29
; %bb.18:
	mov	w13, #253
	b	LBB2_28
LBB2_19:
	ldr	x12, [x9, #8]
	tst	x12, x2
	b.eq	LBB2_24
; %bb.20:
	and	x12, x12, x15
	str	x12, [x9, #8]
	mov	w13, #4
	b	LBB2_29
LBB2_21:
	cmp	x2, #128
	b.eq	LBB2_27
; %bb.22:
	mov	x16, #72057594037927936
	cmp	x2, x16
	b.ne	LBB2_29
; %bb.23:
	mov	w13, #247
	b	LBB2_28
LBB2_24:
	ldr	x12, [x9, #32]
	tst	x12, x2
	b.eq	LBB2_31
; %bb.25:
	and	x12, x12, x15
	str	x12, [x9, #32]
	mov	w13, #7
	b	LBB2_29
LBB2_26:
	mov	w13, #251
	b	LBB2_28
LBB2_27:
	mov	w13, #254
LBB2_28:
	and	w12, w12, w13
	strb	w12, [x0, #9]
	mov	w13, #6
LBB2_29:
	and	x12, x14, x15
	str	x12, [x10]
	strh	wzr, [x0, #12]
LBB2_30:
	ldr	x10, [x11]
	orr	x10, x10, x2
	bic	x10, x10, x1
	str	x10, [x11]
	ldr	x10, [x9, #40]
	orr	x10, x10, x2
	bic	x10, x10, x1
	str	x10, [x9, #40]
	mov	w9, #64
	strh	w9, [x0, #10]
	strb	w8, [x3, #4]
	strb	w13, [x3, #5]
	ret
LBB2_31:
	mov	w13, #0
	b	LBB2_29
	.cfi_endproc
                                        ; -- End function
	.globl	_other_apply_move               ; -- Begin function other_apply_move
	.p2align	2
_other_apply_move:                      ; @other_apply_move
	.cfi_startproc
; %bb.0:
	ldr	x9, [x0]
	mov	x11, x9
	ldr	x8, [x11, #48]!
	add	x10, x9, #56
	tst	x8, x1
	b.eq	LBB3_4
; %bb.1:
	mov	w12, #0
	mov	x8, x11
	strb	w12, [x0, #8]
	strb	w12, [x3, #4]
	ldr	x11, [x10]
	tst	x11, x2
	b.eq	LBB3_5
LBB3_2:
	mvn	x12, x2
	strh	wzr, [x0, #12]
	ldr	x13, [x9]
	tst	x13, x2
	b.eq	LBB3_9
; %bb.3:
	mov	w14, #3
	strb	w14, [x3, #5]
	and	x13, x13, x12
	str	x13, [x9]
	b	LBB3_34
LBB3_4:
	ldrh	w8, [x0, #14]
	add	w8, w8, #1
	strh	w8, [x0, #14]
	mov	w12, #1
	mov	x8, x10
	mov	x10, x11
	strb	w12, [x0, #8]
	strb	w12, [x3, #4]
	ldr	x11, [x11]
	tst	x11, x2
	b.ne	LBB3_2
LBB3_5:
	ldrh	w10, [x0, #12]
	add	w10, w10, #1
	strh	w10, [x0, #12]
	cmp	x2, #127
	b.gt	LBB3_11
; %bb.6:
	mov	x10, #-9223372036854775808
	cmp	x2, x10
	b.eq	LBB3_19
; %bb.7:
	cmp	x2, #1
	b.ne	LBB3_22
; %bb.8:
	mov	w10, #253
	b	LBB3_21
LBB3_9:
	ldr	x13, [x9, #16]
	tst	x13, x2
	b.eq	LBB3_14
; %bb.10:
	mov	w14, #5
	strb	w14, [x3, #5]
	and	x13, x13, x12
	str	x13, [x9, #16]
	b	LBB3_34
LBB3_11:
	cmp	x2, #128
	b.eq	LBB3_20
; %bb.12:
	mov	x10, #72057594037927936
	cmp	x2, x10
	b.ne	LBB3_22
; %bb.13:
	mov	w10, #247
	b	LBB3_21
LBB3_14:
	ldr	x13, [x9, #24]
	tst	x13, x2
	b.eq	LBB3_24
; %bb.15:
	mov	w14, #6
	strb	w14, [x3, #5]
	and	x13, x13, x12
	str	x13, [x9, #24]
	cmp	x2, #127
	b.gt	LBB3_26
; %bb.16:
	mov	x13, #-9223372036854775808
	cmp	x2, x13
	b.eq	LBB3_31
; %bb.17:
	cmp	x2, #1
	b.ne	LBB3_34
; %bb.18:
	mov	w13, #253
	b	LBB3_33
LBB3_19:
	mov	w10, #251
	b	LBB3_21
LBB3_20:
	mov	w10, #254
LBB3_21:
	ldrb	w11, [x0, #9]
	and	w10, w11, w10
	strb	w10, [x0, #9]
LBB3_22:
	ldr	x10, [x9, #16]
	tst	x10, x1
	b.eq	LBB3_35
LBB3_23:
	orr	x11, x10, x2
	mvn	x10, x1
	bic	x11, x11, x1
	str	x11, [x9, #16]
	mov	w9, #5
	b	LBB3_51
LBB3_24:
	ldr	x13, [x9, #8]
	tst	x13, x2
	b.eq	LBB3_29
; %bb.25:
	mov	w14, #4
	strb	w14, [x3, #5]
	and	x13, x13, x12
	str	x13, [x9, #8]
	b	LBB3_34
LBB3_26:
	cmp	x2, #128
	b.eq	LBB3_32
; %bb.27:
	mov	x13, #72057594037927936
	cmp	x2, x13
	b.ne	LBB3_34
; %bb.28:
	mov	w13, #247
	b	LBB3_33
LBB3_29:
	ldr	x13, [x9, #32]
	tst	x13, x2
	b.eq	LBB3_34
; %bb.30:
	mov	w14, #7
	strb	w14, [x3, #5]
	and	x13, x13, x12
	str	x13, [x9, #32]
	b	LBB3_34
LBB3_31:
	mov	w13, #251
	b	LBB3_33
LBB3_32:
	mov	w13, #254
LBB3_33:
	ldrb	w14, [x0, #9]
	and	w13, w14, w13
	strb	w13, [x0, #9]
LBB3_34:
	and	x11, x11, x12
	str	x11, [x10]
	ldr	x10, [x9, #16]
	tst	x10, x1
	b.ne	LBB3_23
LBB3_35:
	ldr	x10, [x9, #8]
	tst	x10, x1
	b.eq	LBB3_37
; %bb.36:
	orr	x11, x10, x2
	mvn	x10, x1
	bic	x11, x11, x1
	str	x11, [x9, #8]
	mov	w9, #4
	b	LBB3_51
LBB3_37:
	ldr	x10, [x9, #24]
	tst	x10, x1
	b.eq	LBB3_42
; %bb.38:
	cmp	x1, #127
	b.gt	LBB3_44
; %bb.39:
	mov	x11, #-9223372036854775808
	cmp	x1, x11
	b.eq	LBB3_47
; %bb.40:
	cmp	x1, #1
	b.ne	LBB3_50
; %bb.41:
	mov	w11, #253
	b	LBB3_49
LBB3_42:
	ldr	x10, [x9, #32]
	tst	x10, x1
	b.eq	LBB3_52
; %bb.43:
	orr	x11, x10, x2
	mvn	x10, x1
	bic	x11, x11, x1
	str	x11, [x9, #32]
	mov	w9, #7
	b	LBB3_51
LBB3_44:
	cmp	x1, #128
	b.eq	LBB3_48
; %bb.45:
	mov	x11, #72057594037927936
	cmp	x1, x11
	b.ne	LBB3_50
; %bb.46:
	mov	w11, #247
	b	LBB3_49
LBB3_47:
	mov	w11, #251
	b	LBB3_49
LBB3_48:
	mov	w11, #254
LBB3_49:
	ldrb	w12, [x0, #9]
	and	w11, w12, w11
	strb	w11, [x0, #9]
LBB3_50:
	orr	x11, x10, x2
	mvn	x10, x1
	bic	x11, x11, x1
	str	x11, [x9, #24]
	mov	w9, #6
LBB3_51:
	ldr	x11, [x8]
	orr	x11, x11, x2
	and	x10, x11, x10
	str	x10, [x8]
	strb	w9, [x3, #6]
LBB3_52:
	mov	w8, #64
	strh	w8, [x0, #10]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_apply_move_ext                 ; -- Begin function apply_move_ext
	.p2align	2
_apply_move_ext:                        ; @apply_move_ext
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x2
	lsr	x8, x1, #24
	ldrh	w9, [x0, #12]
	strh	w9, [x2, #12]
	ldrb	w9, [x0, #9]
	strb	w9, [x2, #7]
	ldrh	w9, [x0, #10]
	sturh	w9, [x2, #9]
	ubfx	x9, x1, #16, #16
	strb	w9, [x2, #2]
	strh	w1, [x2]
	strb	w8, [x2, #3]
	strb	wzr, [x2, #8]
	ubfx	x8, x1, #24, #8
	cmp	w8, #3
	b.eq	LBB4_4
; %bb.1:
	cbnz	w8, LBB4_5
; %bb.2:
	ldrb	w8, [x0, #8]
	cmp	w8, #1
	b.ne	LBB4_7
; %bb.3:
	strb	wzr, [x0, #8]
	b	LBB4_8
LBB4_4:
	lsr	x9, x1, #8
	mov	w10, #1
	lsl	x8, x10, x1
	lsl	x2, x10, x9
	ubfx	w3, w1, #16, #8
	mov	x1, x8
	bl	_apply_pawn_promotion
	strh	w0, [x19, #4]
	mov	w8, #3
	strb	w8, [x19, #6]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB4_5:
	lsr	x8, x1, #8
	mov	w9, #1
	lsl	x2, x9, x1
	lsl	x3, x9, x8
	ldr	x8, [x0]
	ldr	x9, [x8]
	tst	x9, x2
	b.eq	LBB4_9
; %bb.6:
	and	w1, w1, #0xff
	bl	_apply_pawn_other
	strh	w0, [x19, #4]
	mov	w8, #3
	strb	w8, [x19, #6]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB4_7:
	mov	w8, #1
	strb	w8, [x0, #8]
	ldrh	w8, [x0, #14]
	add	w8, w8, #1
	strh	w8, [x0, #14]
LBB4_8:
	ldrh	w8, [x0, #12]
	add	w8, w8, #1
	strh	w8, [x0, #12]
	mov	w8, #64
	strh	w8, [x0, #10]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB4_9:
	ldr	x8, [x8, #40]
	tst	x8, x2
	b.eq	LBB4_11
; %bb.10:
	mov	w8, #8
	strb	w8, [x19, #6]
	mov	x1, x2
	mov	x2, x3
	mov	x3, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_apply_king_move
LBB4_11:
	mov	x1, x2
	mov	x2, x3
	mov	x3, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_other_apply_move
	.cfi_endproc
                                        ; -- End function
	.globl	_apply_move                     ; -- Begin function apply_move
	.p2align	2
_apply_move:                            ; @apply_move
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	and	x1, x1, #0xffffffff
	mov	x2, sp
	bl	_apply_move_ext
	ldr	x0, [sp]
	ldrh	w8, [sp, #12]
	ldr	w1, [sp, #8]
	bfi	x1, x8, #32, #16
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_undo_move                      ; -- Begin function undo_move
	.p2align	2
_undo_move:                             ; @undo_move
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ldrb	w9, [x0, #8]
	cmp	w9, #1
	b.ne	LBB6_6
; %bb.1:
	strb	wzr, [x0, #8]
	add	x12, x8, #56
	add	x9, x8, #48
	ldrh	w10, [x0, #14]
	sub	w10, w10, #1
	strh	w10, [x0, #14]
	ubfx	x13, x1, #24, #8
	lsr	x10, x2, #8
	cmp	w13, #2
	b.eq	LBB6_7
LBB6_2:
                                        ; implicit-def: $x11
	cmp	w13, #3
	b.ne	LBB6_18
; %bb.3:
	lsr	x11, x1, #8
	mov	w14, #1
	lsl	x13, x14, x1
	lsl	x11, x14, x11
	ubfx	w14, w1, #16, #8
	sub	w14, w14, #4
	cmp	w14, #3
	b.hi	LBB6_13
; %bb.4:
Lloh2:
	adrp	x15, lJTI6_1@PAGE
Lloh3:
	add	x15, x15, lJTI6_1@PAGEOFF
	adr	x16, LBB6_5
	ldrb	w17, [x15, x14]
	add	x16, x16, x17, lsl #2
	br	x16
LBB6_5:
	mvn	x14, x11
	ldr	x15, [x8, #8]
	bic	x15, x15, x11
	str	x15, [x8, #8]
	b	LBB6_17
LBB6_6:
	mov	w9, #1
	strb	w9, [x0, #8]
	add	x12, x8, #48
	add	x9, x8, #56
	ubfx	x13, x1, #24, #8
	lsr	x10, x2, #8
	cmp	w13, #2
	b.ne	LBB6_2
LBB6_7:
	lsr	x14, x1, #48
	lsr	x11, x1, #8
	mov	w15, #1
	lsl	x13, x15, x1
	lsl	x11, x15, x11
	and	w14, w14, #0xff
	sub	w14, w14, #3
	cmp	w14, #5
	b.hi	LBB6_19
; %bb.8:
Lloh4:
	adrp	x15, lJTI6_0@PAGE
Lloh5:
	add	x15, x15, lJTI6_0@PAGEOFF
	adr	x16, LBB6_9
	ldrb	w17, [x15, x14]
	add	x16, x16, x17, lsl #2
	br	x16
LBB6_9:
	tbz	w2, #16, LBB6_12
; %bb.10:
	mov	w14, #1
	lsl	x14, x14, x10
	tst	x14, x11
	b.eq	LBB6_12
; %bb.11:
	ubfx	x15, x2, #8, #8
	mov	w16, #256
	lsl	x15, x16, x15
	lsr	x16, x14, #8
	tst	x14, #0xff0000
	csel	x14, x16, x15, eq
	ldr	x15, [x8]
	orr	x15, x15, x14
	str	x15, [x8]
	ldr	x15, [x9]
	orr	x14, x15, x14
	str	x14, [x9]
LBB6_12:
	mvn	x14, x11
	ldr	x15, [x8]
	bic	x15, x15, x11
	orr	x15, x15, x13
	str	x15, [x8]
	b	LBB6_28
LBB6_13:
	mvn	x14, x11
	b	LBB6_17
LBB6_14:
	mvn	x14, x11
	ldr	x15, [x8, #16]
	bic	x15, x15, x11
	str	x15, [x8, #16]
	b	LBB6_17
LBB6_15:
	mvn	x14, x11
	ldr	x15, [x8, #24]
	bic	x15, x15, x11
	str	x15, [x8, #24]
	b	LBB6_17
LBB6_16:
	mvn	x14, x11
	ldr	x15, [x8, #32]
	bic	x15, x15, x11
	str	x15, [x8, #32]
LBB6_17:
	ldr	x15, [x12]
	and	x14, x15, x14
	orr	x14, x14, x13
	str	x14, [x12]
	ldr	x12, [x8]
	orr	x12, x12, x13
	str	x12, [x8]
LBB6_18:
	tst	x1, #0xff0000000000
	b.ne	LBB6_29
	b	LBB6_37
LBB6_19:
	mvn	x14, x11
	b	LBB6_28
LBB6_20:
	mvn	x14, x11
	ldr	x15, [x8, #8]
	bic	x15, x15, x11
	orr	x15, x15, x13
	str	x15, [x8, #8]
	b	LBB6_28
LBB6_21:
	mvn	x14, x11
	ldr	x15, [x8, #16]
	bic	x15, x15, x11
	orr	x15, x15, x13
	str	x15, [x8, #16]
	b	LBB6_28
LBB6_22:
	mvn	x14, x11
	ldr	x15, [x8, #24]
	bic	x15, x15, x11
	orr	x15, x15, x13
	str	x15, [x8, #24]
	b	LBB6_28
LBB6_23:
	mvn	x14, x11
	ldr	x15, [x8, #32]
	bic	x15, x15, x11
	orr	x15, x15, x13
	str	x15, [x8, #32]
	b	LBB6_28
LBB6_24:
	ubfx	x15, x1, #8, #8
	mvn	x14, x11
	ldr	x16, [x8, #40]
	bic	x16, x16, x11
	orr	x16, x16, x13
	str	x16, [x8, #40]
	mov	w16, #5
	tst	w2, w16
	b.eq	LBB6_26
; %bb.25:
	mov	x16, #-9187201950435737472
	orn	x16, x16, x11, lsr #1
	ldr	x17, [x8, #24]
	and	x17, x17, x16
	ldr	x3, [x12]
	and	x16, x3, x16
	mov	w3, #2
	lsl	x3, x3, x15
	and	x3, x3, #0xfefefefefefefefe
	orr	x17, x17, x3
	str	x17, [x8, #24]
	orr	x16, x16, x3
	str	x16, [x12]
LBB6_26:
	mov	w16, #10
	tst	w2, w16
	b.eq	LBB6_28
; %bb.27:
	mov	w16, #2
	lsl	x15, x16, x15
	mvn	x15, x15
	orr	x15, x15, #0x101010101010101
	ldr	x16, [x8, #24]
	and	x16, x16, x15
	ldr	x17, [x12]
	and	x15, x17, x15
	lsr	x17, x11, #2
	and	x17, x17, #0x3f3f3f3f3f3f3f3f
	orr	x16, x16, x17
	str	x16, [x8, #24]
	orr	x15, x15, x17
	str	x15, [x12]
LBB6_28:
	ldr	x15, [x12]
	and	x14, x15, x14
	orr	x13, x14, x13
	str	x13, [x12]
	tst	x1, #0xff0000000000
	b.eq	LBB6_37
LBB6_29:
	ubfx	x12, x1, #40, #8
	sub	w12, w12, #3
	cmp	w12, #4
	b.hi	LBB6_36
; %bb.30:
Lloh6:
	adrp	x13, lJTI6_2@PAGE
Lloh7:
	add	x13, x13, lJTI6_2@PAGEOFF
	adr	x14, LBB6_31
	ldrb	w15, [x13, x12]
	add	x14, x14, x15, lsl #2
	br	x14
LBB6_31:
	add	x8, x8, #8
	b	LBB6_35
LBB6_32:
	add	x8, x8, #16
	b	LBB6_35
LBB6_33:
	add	x8, x8, #32
	b	LBB6_35
LBB6_34:
	add	x8, x8, #24
LBB6_35:
	ldr	x12, [x8]
	orr	x12, x12, x11
	str	x12, [x8]
LBB6_36:
	ldr	x8, [x9]
	orr	x8, x8, x11
	str	x8, [x9]
LBB6_37:
	lsr	x8, x2, #16
	lsr	x9, x1, #56
	strb	w9, [x0, #9]
	strb	w10, [x0, #10]
	lsr	x9, x2, #32
	strb	w8, [x0, #11]
	strh	w9, [x0, #12]
	ret
	.loh AdrpAdd	Lloh2, Lloh3
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpAdd	Lloh6, Lloh7
	.cfi_endproc
	.section	__TEXT,__const
lJTI6_0:
	.byte	(LBB6_9-LBB6_9)>>2
	.byte	(LBB6_20-LBB6_9)>>2
	.byte	(LBB6_21-LBB6_9)>>2
	.byte	(LBB6_22-LBB6_9)>>2
	.byte	(LBB6_23-LBB6_9)>>2
	.byte	(LBB6_24-LBB6_9)>>2
lJTI6_1:
	.byte	(LBB6_5-LBB6_5)>>2
	.byte	(LBB6_14-LBB6_5)>>2
	.byte	(LBB6_15-LBB6_5)>>2
	.byte	(LBB6_16-LBB6_5)>>2
lJTI6_2:
	.byte	(LBB6_35-LBB6_31)>>2
	.byte	(LBB6_31-LBB6_31)>>2
	.byte	(LBB6_32-LBB6_31)>>2
	.byte	(LBB6_34-LBB6_31)>>2
	.byte	(LBB6_33-LBB6_31)>>2
                                        ; -- End function
.subsections_via_symbols
