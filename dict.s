	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_dict_hash                      ; -- Begin function dict_hash
	.p2align	2
_dict_hash:                             ; @dict_hash
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB0_4
; %bb.1:
	ldrb	w8, [x0]
	cbz	w8, LBB0_5
; %bb.2:
	add	x9, x0, #1
	mov	w0, #5919
LBB0_3:                                 ; =>This Inner Loop Header: Depth=1
	add	x10, x0, x0, lsl #5
	add	x0, x10, w8, sxtb
	ldrb	w8, [x9], #1
	cbnz	w8, LBB0_3
LBB0_4:
	ret
LBB0_5:
	mov	w0, #5919
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_new_dict                       ; -- Begin function new_dict
	.p2align	2
_new_dict:                              ; @new_dict
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
	cbz	x0, LBB1_6
; %bb.1:
	mov	x20, x0
	mov	w0, #40
	bl	_malloc
	mov	x19, x0
	cbz	x0, LBB1_5
; %bb.2:
	add	x8, x20, x20, lsl #1
	lsl	x0, x8, #3
	bl	_malloc
	str	x0, [x19, #16]
	cbz	x0, LBB1_6
; %bb.3:
	mov	x0, x20
	bl	_malloc
	str	x0, [x19]
	cbz	x0, LBB1_6
; %bb.4:
	mov	x1, x20
	bl	_bzero
	str	xzr, [x19, #8]
	stp	x20, xzr, [x19, #24]
LBB1_5:
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB1_6:
	mov	x19, #0
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_new_dict_with_func             ; -- Begin function new_dict_with_func
	.p2align	2
_new_dict_with_func:                    ; @new_dict_with_func
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
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
	cbz	x0, LBB2_8
; %bb.1:
	mov	x20, x0
	mov	w0, #40
	bl	_malloc
	mov	x19, x0
	cbz	x0, LBB2_9
; %bb.2:
	add	x8, x20, x20, lsl #1
	lsl	x0, x8, #3
	bl	_malloc
	str	x0, [x19, #16]
	cbz	x0, LBB2_8
; %bb.3:
	mov	x0, x20
	bl	_malloc
	str	x0, [x19]
	cbz	x0, LBB2_8
; %bb.4:
	mov	x1, x20
	bl	_bzero
	mov	x21, #0
	str	xzr, [x19, #8]
	stp	x20, xzr, [x19, #24]
	add	x8, x29, #16
	str	x8, [sp, #8]
LBB2_5:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]
	add	x9, x8, #8
	str	x9, [sp, #8]
	ldr	x1, [x8]
	cbz	x1, LBB2_9
; %bb.6:                                ;   in Loop: Header=BB2_5 Depth=1
	ldr	x8, [sp, #8]
	add	x9, x8, #8
	str	x9, [sp, #8]
	ldr	x2, [x8]
	cbz	x2, LBB2_8
; %bb.7:                                ;   in Loop: Header=BB2_5 Depth=1
	mov	x0, x19
	bl	_dict_add
	add	x21, x21, #2
	cmp	x21, x20
	b.lo	LBB2_5
LBB2_8:
	mov	x19, #0
LBB2_9:
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_dict_add                       ; -- Begin function dict_add
	.p2align	2
_dict_add:                              ; @dict_add
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	x28, x27, [sp, #16]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	cbz	x0, LBB3_19
; %bb.1:
	mov	x21, x1
	mov	x19, x0
	str	x2, [sp, #8]                    ; 8-byte Folded Spill
	cbz	x1, LBB3_5
; %bb.2:
	ldrb	w8, [x21]
	cbz	w8, LBB3_6
; %bb.3:
	add	x9, x21, #1
	mov	w23, #5919
LBB3_4:                                 ; =>This Inner Loop Header: Depth=1
	add	x10, x23, x23, lsl #5
	add	x23, x10, w8, sxtb
	ldrb	w8, [x9], #1
	cbnz	w8, LBB3_4
	b	LBB3_7
LBB3_5:
	mov	x23, #0
	b	LBB3_7
LBB3_6:
	mov	w23, #5919
LBB3_7:
	ldp	x28, x25, [x19, #16]
	udiv	x8, x23, x25
	msub	x26, x8, x25, x23
	ldr	x27, [x19]
	mov	w20, #24
	mov	x24, x26
	b	LBB3_9
LBB3_8:                                 ;   in Loop: Header=BB3_9 Depth=1
	add	x8, x24, #1
	udiv	x9, x8, x25
	msub	x24, x9, x25, x8
	cmp	x24, x26
	b.eq	LBB3_13
LBB3_9:                                 ; =>This Inner Loop Header: Depth=1
	ldrb	w8, [x27, x24]
	cbz	w8, LBB3_8
; %bb.10:                               ;   in Loop: Header=BB3_9 Depth=1
	madd	x8, x24, x20, x28
	ldr	x9, [x8, #16]
	cmp	x9, x23
	b.ne	LBB3_8
; %bb.11:                               ;   in Loop: Header=BB3_9 Depth=1
	ldr	x22, [x8]
	mov	x0, x22
	mov	x1, x21
	bl	_strcmp
	cbnz	w0, LBB3_8
; %bb.12:
	mov	x0, x22
	bl	_free
	mov	x0, x21
	bl	_strlen
	add	x0, x0, #1
	bl	_malloc
	mov	x1, x21
	bl	_strcpy
	ldr	x8, [x19]
	mov	w9, #1
	strb	w9, [x8, x24]
	ldr	x8, [x19, #16]
	mov	w9, #24
	madd	x8, x24, x9, x8
	b	LBB3_18
LBB3_13:
	mov	x22, x26
LBB3_14:                                ; =>This Inner Loop Header: Depth=1
	ldrb	w8, [x27, x22]
	cbz	w8, LBB3_17
; %bb.15:                               ;   in Loop: Header=BB3_14 Depth=1
	add	x8, x22, #1
	udiv	x9, x8, x25
	msub	x22, x9, x25, x8
	cmp	x22, x26
	b.ne	LBB3_14
; %bb.16:
	mov	w0, #0
	b	LBB3_19
LBB3_17:
	mov	x0, x21
	bl	_strlen
	add	x0, x0, #1
	bl	_malloc
	mov	x1, x21
	bl	_strcpy
	ldr	x8, [x19]
	mov	w9, #1
	strb	w9, [x8, x22]
	ldr	x8, [x19, #16]
	mov	w9, #24
	madd	x8, x22, x9, x8
LBB3_18:
	ldr	x9, [sp, #8]                    ; 8-byte Folded Reload
	stp	x0, x9, [x8]
	str	x23, [x8, #16]
	ldr	x8, [x19, #8]
	add	x8, x8, #1
	str	x8, [x19, #8]
	mov	w0, #1
LBB3_19:
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_dict_free                      ; -- Begin function dict_free
	.p2align	2
_dict_free:                             ; @dict_free
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x0
	ldr	x8, [x0, #24]
	cbz	x8, LBB4_6
; %bb.1:
	mov	x20, #0
	mov	x21, #0
	mov	x22, #0
	b	LBB4_3
LBB4_2:                                 ;   in Loop: Header=BB4_3 Depth=1
	add	x21, x21, #1
	add	x20, x20, #24
	cmp	x21, x8
	b.hs	LBB4_6
LBB4_3:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x9, [x19, #8]
	cmp	x22, x9
	b.hs	LBB4_6
; %bb.4:                                ;   in Loop: Header=BB4_3 Depth=1
	ldr	x9, [x19]
	ldrb	w9, [x9, x21]
	cbz	w9, LBB4_2
; %bb.5:                                ;   in Loop: Header=BB4_3 Depth=1
	ldr	x8, [x19, #16]
	ldr	x0, [x8, x20]
	bl	_free
	add	x22, x22, #1
	ldr	x8, [x19, #24]
	b	LBB4_2
LBB4_6:
	ldr	x0, [x19, #16]
	bl	_free
	mov	x0, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_free
	.cfi_endproc
                                        ; -- End function
	.globl	_is_matching_entry              ; -- Begin function is_matching_entry
	.p2align	2
_is_matching_entry:                     ; @is_matching_entry
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x8, [x0]
	ldrb	w8, [x8, x2]
	cbz	w8, LBB5_3
; %bb.1:
	ldr	x8, [x0, #16]
	mov	w9, #24
	madd	x8, x2, x9, x8
	ldr	x9, [x8, #16]
	cmp	x9, x3
	b.ne	LBB5_3
; %bb.2:
	ldr	x0, [x8]
	bl	_strcmp
	cmp	w0, #0
	cset	w0, eq
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB5_3:
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_dict_index_of                  ; -- Begin function dict_index_of
	.p2align	2
_dict_index_of:                         ; @dict_index_of
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	cbz	x0, LBB6_8
; %bb.1:
	mov	x19, x3
	mov	x20, x2
	mov	x21, x1
	ldp	x23, x22, [x0, #16]
	udiv	x8, x2, x22
	msub	x24, x8, x22, x2
	ldr	x25, [x0]
	mov	w26, #24
	mov	x27, x24
	b	LBB6_3
LBB6_2:                                 ;   in Loop: Header=BB6_3 Depth=1
	add	x8, x27, #1
	udiv	x9, x8, x22
	msub	x27, x9, x22, x8
	cmp	x27, x24
	b.eq	LBB6_7
LBB6_3:                                 ; =>This Inner Loop Header: Depth=1
	ldrb	w8, [x25, x27]
	cbz	w8, LBB6_2
; %bb.4:                                ;   in Loop: Header=BB6_3 Depth=1
	madd	x8, x27, x26, x23
	ldr	x9, [x8, #16]
	cmp	x9, x20
	b.ne	LBB6_2
; %bb.5:                                ;   in Loop: Header=BB6_3 Depth=1
	ldr	x0, [x8]
	mov	x1, x21
	bl	_strcmp
	cbnz	w0, LBB6_2
; %bb.6:
	str	x27, [x19]
	mov	w0, #1
	b	LBB6_8
LBB6_7:
	mov	w0, #0
LBB6_8:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_update_last_retrieved          ; -- Begin function update_last_retrieved
	.p2align	2
_update_last_retrieved:                 ; @update_last_retrieved
	.cfi_startproc
; %bb.0:
	str	x1, [x0, #32]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_dict_lookup                    ; -- Begin function dict_lookup
	.p2align	2
_dict_lookup:                           ; @dict_lookup
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	mov	x20, x1
	mov	x19, x0
	cbz	x1, LBB8_5
; %bb.1:
	ldrb	w8, [x20]
	cbz	w8, LBB8_6
; %bb.2:
	add	x9, x20, #1
	mov	w21, #5919
LBB8_3:                                 ; =>This Inner Loop Header: Depth=1
	add	x10, x21, x21, lsl #5
	add	x21, x10, w8, sxtb
	ldrb	w8, [x9], #1
	cbnz	w8, LBB8_3
; %bb.4:
	cbnz	x19, LBB8_7
	b	LBB8_13
LBB8_5:
	mov	x21, #0
	cbnz	x19, LBB8_7
	b	LBB8_13
LBB8_6:
	mov	w21, #5919
	cbz	x19, LBB8_13
LBB8_7:
	ldp	x23, x22, [x19, #16]
	udiv	x8, x21, x22
	msub	x24, x8, x22, x21
	ldr	x25, [x19]
	mov	w26, #24
	mov	x27, x24
	b	LBB8_9
LBB8_8:                                 ;   in Loop: Header=BB8_9 Depth=1
	add	x8, x27, #1
	udiv	x9, x8, x22
	msub	x27, x9, x22, x8
	cmp	x27, x24
	b.eq	LBB8_13
LBB8_9:                                 ; =>This Inner Loop Header: Depth=1
	ldrb	w8, [x25, x27]
	cbz	w8, LBB8_8
; %bb.10:                               ;   in Loop: Header=BB8_9 Depth=1
	madd	x8, x27, x26, x23
	ldr	x9, [x8, #16]
	cmp	x9, x21
	b.ne	LBB8_8
; %bb.11:                               ;   in Loop: Header=BB8_9 Depth=1
	ldr	x0, [x8]
	mov	x1, x20
	bl	_strcmp
	cbnz	w0, LBB8_8
; %bb.12:
	mov	w8, #24
	madd	x8, x27, x8, x23
	ldr	x0, [x8, #8]
	str	x0, [x19, #32]
	b	LBB8_14
LBB8_13:
	mov	x0, #0
LBB8_14:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_dict_remove                    ; -- Begin function dict_remove
	.p2align	2
_dict_remove:                           ; @dict_remove
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	mov	x20, x1
	mov	x19, x0
	cbz	x1, LBB9_5
; %bb.1:
	ldrb	w8, [x20]
	cbz	w8, LBB9_6
; %bb.2:
	add	x9, x20, #1
	mov	w22, #5919
LBB9_3:                                 ; =>This Inner Loop Header: Depth=1
	add	x10, x22, x22, lsl #5
	add	x22, x10, w8, sxtb
	ldrb	w8, [x9], #1
	cbnz	w8, LBB9_3
; %bb.4:
	cbnz	x19, LBB9_7
	b	LBB9_13
LBB9_5:
	mov	x22, #0
	cbnz	x19, LBB9_7
	b	LBB9_13
LBB9_6:
	mov	w22, #5919
	cbz	x19, LBB9_13
LBB9_7:
	ldp	x23, x24, [x19, #16]
	udiv	x8, x22, x24
	msub	x27, x8, x24, x22
	ldr	x25, [x19]
	mov	w28, #24
	mov	x26, x27
	b	LBB9_9
LBB9_8:                                 ;   in Loop: Header=BB9_9 Depth=1
	add	x8, x26, #1
	udiv	x9, x8, x24
	msub	x26, x9, x24, x8
	cmp	x26, x27
	b.eq	LBB9_13
LBB9_9:                                 ; =>This Inner Loop Header: Depth=1
	ldrb	w8, [x25, x26]
	cbz	w8, LBB9_8
; %bb.10:                               ;   in Loop: Header=BB9_9 Depth=1
	madd	x8, x26, x28, x23
	ldr	x9, [x8, #16]
	cmp	x9, x22
	b.ne	LBB9_8
; %bb.11:                               ;   in Loop: Header=BB9_9 Depth=1
	ldr	x21, [x8]
	mov	x0, x21
	mov	x1, x20
	bl	_strcmp
	cbnz	w0, LBB9_8
; %bb.12:
	strb	wzr, [x25, x26]
	ldr	x8, [x19, #8]
	sub	x8, x8, #1
	str	x8, [x19, #8]
	mov	w8, #24
	madd	x8, x26, x8, x23
	ldr	x8, [x8, #8]
	str	x8, [x19, #32]
	mov	x0, x21
	bl	_free
	ldr	x0, [x19, #32]
	b	LBB9_14
LBB9_13:
	mov	x0, #0
LBB9_14:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_add_entry_helper               ; -- Begin function add_entry_helper
	.p2align	2
_add_entry_helper:                      ; @add_entry_helper
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
	mov	x19, x4
	mov	x20, x3
	mov	x21, x2
	mov	x22, x1
	mov	x23, x0
	mov	x0, x1
	bl	_strlen
	add	x0, x0, #1
	bl	_malloc
	mov	x1, x22
	bl	_strcpy
	ldr	x8, [x23]
	mov	w9, #1
	strb	w9, [x8, x20]
	ldr	x8, [x23, #16]
	mov	w9, #24
	madd	x8, x20, x9, x8
	stp	x0, x21, [x8]
	str	x19, [x8, #16]
	ldr	x8, [x23, #8]
	add	x8, x8, #1
	str	x8, [x23, #8]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_dict_keys                      ; -- Begin function dict_keys
	.p2align	2
_dict_keys:                             ; @dict_keys
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
	cbz	x0, LBB11_6
; %bb.1:
	mov	x19, x0
	ldr	x8, [x0, #8]
	lsl	x0, x8, #3
	bl	_malloc
	ldr	x8, [x19, #24]
	cbz	x8, LBB11_6
; %bb.2:
	mov	x9, #0
	ldr	x10, [x19]
	mov	w11, #8
	b	LBB11_4
LBB11_3:                                ;   in Loop: Header=BB11_4 Depth=1
	add	x11, x11, #24
	add	x10, x10, #1
	subs	x8, x8, #1
	b.eq	LBB11_6
LBB11_4:                                ; =>This Inner Loop Header: Depth=1
	ldrb	w12, [x10]
	cbz	w12, LBB11_3
; %bb.5:                                ;   in Loop: Header=BB11_4 Depth=1
	ldr	x12, [x19, #16]
	ldr	x12, [x12, x11]
	str	x12, [x0, x9, lsl  #3]
	add	x9, x9, #1
	b	LBB11_3
LBB11_6:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_dict_values                    ; -- Begin function dict_values
	.p2align	2
_dict_values:                           ; @dict_values
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
	cbz	x0, LBB12_6
; %bb.1:
	mov	x19, x0
	ldr	x8, [x0, #8]
	lsl	x0, x8, #3
	bl	_malloc
	ldr	x8, [x19, #24]
	cbz	x8, LBB12_6
; %bb.2:
	mov	x9, #0
	ldr	x10, [x19]
	mov	w11, #8
	b	LBB12_4
LBB12_3:                                ;   in Loop: Header=BB12_4 Depth=1
	add	x11, x11, #24
	add	x10, x10, #1
	subs	x8, x8, #1
	b.eq	LBB12_6
LBB12_4:                                ; =>This Inner Loop Header: Depth=1
	ldrb	w12, [x10]
	cbz	w12, LBB12_3
; %bb.5:                                ;   in Loop: Header=BB12_4 Depth=1
	ldr	x12, [x19, #16]
	ldr	x12, [x12, x11]
	str	x12, [x0, x9, lsl  #3]
	add	x9, x9, #1
	b	LBB12_3
LBB12_6:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
