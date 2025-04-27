	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_initrandom                     ; -- Begin function initrandom
	.p2align	2
_initrandom:                            ; @initrandom
	.cfi_startproc
; %bb.0:
	mov	w0, #1001
	b	_srandom
	.cfi_endproc
                                        ; -- End function
	.globl	_random64                       ; -- Begin function random64
	.p2align	2
_random64:                              ; @random64
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
	bl	_random
	mov	x19, x0
	bl	_random
	add	x0, x0, x19, lsl #32
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_create_zobrist_table           ; -- Begin function create_zobrist_table
	.p2align	2
_create_zobrist_table:                  ; @create_zobrist_table
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	w0, #1001
	bl	_srandom
	mov	w0, #48
	bl	_malloc
	mov	x19, x0
	mov	w0, #512
	bl	_malloc
	mov	x20, x0
	str	x0, [x19]
	mov	w0, #512
	bl	_malloc
	mov	x21, x0
	str	x0, [x19, #24]
	mov	w0, #40
	bl	_malloc
	str	x0, [x19, #16]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	str	x8, [x19, #8]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	lsr	x8, x8, #6
	str	x8, [x19, #32]
	bl	_random
	mov	x22, x0
	bl	_random
	mov	x23, #0
	add	x8, x0, x22, lsl #32
	lsr	x8, x8, #6
	str	x8, [x19, #40]
LBB2_1:                                 ; =>This Inner Loop Header: Depth=1
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	str	x8, [x21, x23]
	mov	w0, #96
	bl	_malloc
	str	x0, [x20, x23]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #8]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #16]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #24]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #32]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #40]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #48]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #56]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #64]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #72]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #80]
	bl	_random
	mov	x22, x0
	bl	_random
	add	x8, x0, x22, lsl #32
	ldr	x9, [x20, x23]
	str	x8, [x9, #88]
	add	x23, x23, #8
	cmp	x23, #512
	b.ne	LBB2_1
; %bb.2:
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_hash_board                     ; -- Begin function hash_board
	.p2align	2
_hash_board:                            ; @hash_board
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x19, x1
	mov	x20, x0
	ldrb	w8, [x0, #8]
	cmp	w8, #1
	b.ne	LBB3_2
; %bb.1:
	ldr	x21, [x19, #8]
	b	LBB3_3
LBB3_2:
	mov	x21, #0
LBB3_3:
	mov	x22, #0
	mov	w23, #5
	b	LBB3_5
LBB3_4:                                 ;   in Loop: Header=BB3_5 Depth=1
	add	x22, x22, #1
	cmp	x22, #64
	b.eq	LBB3_7
LBB3_5:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x0, [x20]
	and	w1, w22, #0xff
	bl	_get_piece_at
	and	w8, w0, #0xffff
	cmp	w8, #256
	b.lo	LBB3_4
; %bb.6:                                ;   in Loop: Header=BB3_5 Depth=1
	and	w8, w0, #0xff00
	tst	w0, #0xff
	csinv	w9, w23, wzr, eq
	add	w8, w9, w8, lsr #8
	ldr	x9, [x19]
	ldr	x9, [x9, x22, lsl  #3]
	ldr	x8, [x9, w8, uxtw  #3]
	eor	x21, x8, x21
	b	LBB3_4
LBB3_7:
	ldrb	w8, [x20, #11]
	tbz	w8, #0, LBB3_9
; %bb.8:
	ldrb	w8, [x20, #10]
	ldr	x9, [x19, #16]
	ldr	x8, [x9, x8, lsl  #3]
	eor	x21, x8, x21
LBB3_9:
	ldrh	w8, [x20, #14]
	ldp	x10, x9, [x19, #32]
	mul	x8, x9, x8
	eor	x8, x8, x21
	ldrh	w9, [x20, #12]
	mul	x9, x10, x9
	eor	x0, x8, x9
	ldrb	w8, [x20, #9]
	tbnz	w8, #0, LBB3_14
; %bb.10:
	tbnz	w8, #1, LBB3_15
LBB3_11:
	tbnz	w8, #2, LBB3_16
LBB3_12:
	tbnz	w8, #3, LBB3_17
LBB3_13:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB3_14:
	ldr	x9, [x19, #16]
	ldr	x9, [x9]
	eor	x0, x9, x0
	tbz	w8, #1, LBB3_11
LBB3_15:
	ldr	x9, [x19, #16]
	ldr	x9, [x9, #8]
	eor	x0, x9, x0
	tbz	w8, #2, LBB3_12
LBB3_16:
	ldr	x9, [x19, #16]
	ldr	x9, [x9, #16]
	eor	x0, x9, x0
	tbz	w8, #3, LBB3_13
LBB3_17:
	ldr	x8, [x19, #16]
	ldr	x8, [x8, #24]
	eor	x0, x8, x0
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
