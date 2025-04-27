	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_fen_index_to_square            ; -- Begin function fen_index_to_square
	.p2align	2
_fen_index_to_square:                   ; @fen_index_to_square
	.cfi_startproc
; %bb.0:
	and	w8, w0, #0xf8
	and	w9, w0, #0x7
	sub	w8, w9, w8
	add	w8, w8, #56
	and	w0, w8, #0xff
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_use_empties                    ; -- Begin function use_empties
	.p2align	2
_use_empties:                           ; @use_empties
	.cfi_startproc
; %bb.0:
	cmp	w1, #1
	b.lt	LBB1_2
; %bb.1:
	add	w8, w1, #48
	strb	w8, [x0, w2, sxtw]
	add	w2, w2, #1
LBB1_2:
	mov	x0, x2
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_num                      ; -- Begin function write_num
	.p2align	2
_write_num:                             ; @write_num
	.cfi_startproc
; %bb.0:
	stp	d9, d8, [sp, #-96]!             ; 16-byte Folded Spill
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
	.cfi_offset b8, -88
	.cfi_offset b9, -96
	mov	x19, x1
	mov	x20, x0
	cmp	w2, #99
	b.hi	LBB2_14
; %bb.1:
	mov	w8, w2
Lloh0:
	adrp	x9, lJTI2_0@PAGE
Lloh1:
	add	x9, x9, lJTI2_0@PAGEOFF
	adr	x10, LBB2_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB2_2:
	add	w8, w2, #48
	add	w0, w19, #1
	strb	w8, [x20, w19, sxtw]
	b	LBB2_13
LBB2_3:
	add	x8, x20, w19, sxtw
	mov	w9, #49
	b	LBB2_12
LBB2_4:
	add	x8, x20, w19, sxtw
	mov	w9, #50
	b	LBB2_12
LBB2_5:
	add	x8, x20, w19, sxtw
	mov	w9, #51
	b	LBB2_12
LBB2_6:
	add	x8, x20, w19, sxtw
	mov	w9, #52
	b	LBB2_12
LBB2_7:
	add	x8, x20, w19, sxtw
	mov	w9, #53
	b	LBB2_12
LBB2_8:
	add	x8, x20, w19, sxtw
	mov	w9, #54
	b	LBB2_12
LBB2_9:
	add	x8, x20, w19, sxtw
	mov	w9, #55
	b	LBB2_12
LBB2_10:
	add	x8, x20, w19, sxtw
	mov	w9, #56
	b	LBB2_12
LBB2_11:
	add	x8, x20, w19, sxtw
	mov	w9, #57
LBB2_12:
	strb	w9, [x8]
	and	w9, w2, #0xff
	mov	w10, #205
	mul	w9, w9, w10
	lsr	w9, w9, #11
	mov	w10, #10
	msub	w9, w9, w10, w2
	orr	w9, w9, #0x30
	add	w0, w19, #2
	strb	w9, [x8, #1]
LBB2_13:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp], #96               ; 16-byte Folded Reload
	ret
LBB2_14:
	scvtf	d8, w2
	fmov	d0, d8
	bl	_log10
	fcvtzs	w21, d0
	tbnz	w21, #31, LBB2_17
; %bb.15:
	mov	x22, #0
	add	w23, w21, w19
	add	w24, w21, #1
	mov	w25, #26215
	movk	w25, #26214, lsl #16
	mov	w26, #10
LBB2_16:                                ; =>This Inner Loop Header: Depth=1
	scvtf	d0, w22
	bl	___exp10
	fdiv	d0, d8, d0
	fcvtzs	w8, d0
	smull	x9, w8, w25
	lsr	x10, x9, #63
	lsr	x9, x9, #34
	add	w9, w9, w10
	msub	w8, w9, w26, w8
	add	w8, w8, #48
	strb	w8, [x20, w23, sxtw]
	add	x22, x22, #1
	sub	w23, w23, #1
	cmp	x24, x22
	b.ne	LBB2_16
LBB2_17:
	add	w8, w19, w21
	add	w0, w8, #1
	b	LBB2_13
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
	.section	__TEXT,__const
lJTI2_0:
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_2-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_3-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_4-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_5-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_6-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_7-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_8-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_9-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_10-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
	.byte	(LBB2_11-LBB2_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_parse_position                 ; -- Begin function parse_position
	.p2align	2
_parse_position:                        ; @parse_position
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #160
	.cfi_def_cfa_offset 160
	stp	x28, x27, [sp, #64]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #80]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #96]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #112]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #128]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #144]            ; 16-byte Folded Spill
	add	x29, sp, #144
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
	cbz	x0, LBB3_36
; %bb.1:
	mov	x19, x0
	ldrb	w8, [x0]
	cbz	w8, LBB3_39
; %bb.2:
	mov	x21, x2
	stp	x1, xzr, [sp, #8]               ; 16-byte Folded Spill
	mov	w27, #0
	mov	w26, #0
	mov	w28, #0
	stp	xzr, xzr, [sp, #32]             ; 16-byte Folded Spill
	mov	w20, #0
	mov	x24, #0
	mov	x25, #0
	stp	xzr, xzr, [sp, #48]             ; 16-byte Folded Spill
	str	xzr, [sp, #24]                  ; 8-byte Folded Spill
	movi.2d	v0, #0000000000000000
	mov	x22, x19
	b	LBB3_5
LBB3_3:                                 ;   in Loop: Header=BB3_5 Depth=1
	add	w26, w8, w26
	add	w28, w8, w28
LBB3_4:                                 ;   in Loop: Header=BB3_5 Depth=1
	add	w20, w20, #1
	add	x22, x19, w20, uxtb
	ldrb	w8, [x22]
	cbz	w8, LBB3_37
LBB3_5:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_28 Depth 2
                                        ;     Child Loop BB3_32 Depth 2
                                        ;     Child Loop BB3_35 Depth 2
	and	w9, w26, #0xff
	cmp	w9, #8
	b.ne	LBB3_8
; %bb.6:                                ;   in Loop: Header=BB3_5 Depth=1
	and	w8, w8, #0xff
	cmp	w8, #47
	b.ne	LBB3_40
; %bb.7:                                ;   in Loop: Header=BB3_5 Depth=1
	mov	w26, #0
	add	w27, w27, #1
	b	LBB3_4
LBB3_8:                                 ;   in Loop: Header=BB3_5 Depth=1
	sxtb	w23, w8
	sub	w9, w23, #49
	cmp	w9, #7
	b.hi	LBB3_17
; %bb.9:                                ;   in Loop: Header=BB3_5 Depth=1
	sub	w8, w8, #48
	cbz	x21, LBB3_3
; %bb.10:                               ;   in Loop: Header=BB3_5 Depth=1
	ands	w9, w8, #0xff
	b.eq	LBB3_3
; %bb.11:                               ;   in Loop: Header=BB3_5 Depth=1
	and	w10, w28, #0xfffffff8
	and	w11, w28, #0x7
	sub	w10, w11, w10
	add	w10, w10, #56
	add	w9, w9, w10, uxtb
	add	w11, w10, #1
	and	w12, w11, #0xff
	subs	w11, w9, w12
	csel	w11, wzr, w11, lo
	add	w11, w11, #1
	cmp	w11, #8
	b.lo	LBB3_35
; %bb.12:                               ;   in Loop: Header=BB3_5 Depth=1
	subs	w12, w9, w12
	csel	w12, wzr, w12, lo
	and	w13, w12, #0xff
	mov	w14, #-2
	sub	w14, w14, w10
	cmp	w13, w14, uxtb
	b.hi	LBB3_35
; %bb.13:                               ;   in Loop: Header=BB3_5 Depth=1
	add	w13, w13, w10, uxtb
	lsr	w13, w13, #8
	tbnz	w13, #0, LBB3_35
; %bb.14:                               ;   in Loop: Header=BB3_5 Depth=1
	cmp	w12, #255
	b.hi	LBB3_35
; %bb.15:                               ;   in Loop: Header=BB3_5 Depth=1
	cmp	w11, #64
	b.hs	LBB3_27
; %bb.16:                               ;   in Loop: Header=BB3_5 Depth=1
	mov	w12, #0
	b	LBB3_31
LBB3_17:                                ;   in Loop: Header=BB3_5 Depth=1
	mov	x0, x23
	bl	___tolower
	sxtb	w8, w0
	sub	w11, w8, #98
	cmp	w11, #16
	b.hi	LBB3_45
; %bb.18:                               ;   in Loop: Header=BB3_5 Depth=1
	and	w9, w28, #0xf8
	and	w10, w28, #0x7
	sub	w9, w10, w9
	add	w9, w9, #56
	mov	w10, #1
	lsl	x10, x10, x9
Lloh2:
	adrp	x14, lJTI3_0@PAGE
Lloh3:
	add	x14, x14, lJTI3_0@PAGEOFF
	adr	x12, LBB3_19
	ldrb	w13, [x14, x11]
	add	x12, x12, x13, lsl #2
	br	x12
LBB3_19:                                ;   in Loop: Header=BB3_5 Depth=1
	ldr	x11, [sp, #24]                  ; 8-byte Folded Reload
	orr	x11, x10, x11
	str	x11, [sp, #24]                  ; 8-byte Folded Spill
	mov	w11, #3
	movi.2d	v0, #0000000000000000
	ldrsb	w13, [x22]
	cmp	w8, w13
	csel	x12, xzr, x10, eq
	csel	x10, x10, xzr, eq
	cbnz	x21, LBB3_25
	b	LBB3_26
LBB3_20:                                ;   in Loop: Header=BB3_5 Depth=1
	ldr	x11, [sp, #56]                  ; 8-byte Folded Reload
	orr	x11, x10, x11
	str	x11, [sp, #56]                  ; 8-byte Folded Spill
	mov	w11, #6
	movi.2d	v0, #0000000000000000
	ldrsb	w13, [x22]
	cmp	w8, w13
	csel	x12, xzr, x10, eq
	csel	x10, x10, xzr, eq
	cbnz	x21, LBB3_25
	b	LBB3_26
LBB3_21:                                ;   in Loop: Header=BB3_5 Depth=1
	ldr	x11, [sp, #16]                  ; 8-byte Folded Reload
	orr	x11, x10, x11
	str	x11, [sp, #16]                  ; 8-byte Folded Spill
	mov	w11, #2
	movi.2d	v0, #0000000000000000
	ldrsb	w13, [x22]
	cmp	w8, w13
	csel	x12, xzr, x10, eq
	csel	x10, x10, xzr, eq
	cbnz	x21, LBB3_25
	b	LBB3_26
LBB3_22:                                ;   in Loop: Header=BB3_5 Depth=1
	ldr	x11, [sp, #32]                  ; 8-byte Folded Reload
	orr	x11, x10, x11
	str	x11, [sp, #32]                  ; 8-byte Folded Spill
	mov	w11, #1
	movi.2d	v0, #0000000000000000
	ldrsb	w13, [x22]
	cmp	w8, w13
	csel	x12, xzr, x10, eq
	csel	x10, x10, xzr, eq
	cbnz	x21, LBB3_25
	b	LBB3_26
LBB3_23:                                ;   in Loop: Header=BB3_5 Depth=1
	ldr	x11, [sp, #48]                  ; 8-byte Folded Reload
	orr	x11, x10, x11
	str	x11, [sp, #48]                  ; 8-byte Folded Spill
	mov	w11, #5
	movi.2d	v0, #0000000000000000
	ldrsb	w13, [x22]
	cmp	w8, w13
	csel	x12, xzr, x10, eq
	csel	x10, x10, xzr, eq
	cbnz	x21, LBB3_25
	b	LBB3_26
LBB3_24:                                ;   in Loop: Header=BB3_5 Depth=1
	ldr	x11, [sp, #40]                  ; 8-byte Folded Reload
	orr	x11, x10, x11
	str	x11, [sp, #40]                  ; 8-byte Folded Spill
	mov	w11, #4
	movi.2d	v0, #0000000000000000
	ldrsb	w13, [x22]
	cmp	w8, w13
	csel	x12, xzr, x10, eq
	csel	x10, x10, xzr, eq
	cbz	x21, LBB3_26
LBB3_25:                                ;   in Loop: Header=BB3_5 Depth=1
	and	x9, x9, #0xff
	add	w14, w11, #6
	cmp	w8, w13
	csel	w8, w14, w11, eq
	strb	w8, [x21, x9]
LBB3_26:                                ;   in Loop: Header=BB3_5 Depth=1
	orr	x25, x12, x25
	orr	x24, x10, x24
	add	w26, w26, #1
	add	w28, w28, #1
	b	LBB3_4
LBB3_27:                                ;   in Loop: Header=BB3_5 Depth=1
	mov	w13, #0
	and	w12, w11, #0xffffffc0
LBB3_28:                                ;   Parent Loop BB3_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	w14, w10, w13
	add	x14, x21, w14, uxtb
	stp	q0, q0, [x14]
	stp	q0, q0, [x14, #32]
	add	w13, w13, #64
	cmp	w12, w13
	b.ne	LBB3_28
; %bb.29:                               ;   in Loop: Header=BB3_5 Depth=1
	cmp	w11, w12
	b.eq	LBB3_3
; %bb.30:                               ;   in Loop: Header=BB3_5 Depth=1
	tst	w11, #0x38
	b.eq	LBB3_34
LBB3_31:                                ;   in Loop: Header=BB3_5 Depth=1
	and	w13, w11, #0xfffffff8
	add	w14, w10, w13
LBB3_32:                                ;   Parent Loop BB3_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	w15, w10, w12
	and	x15, x15, #0xff
	str	d0, [x21, x15]
	add	w12, w12, #8
	cmp	w13, w12
	b.ne	LBB3_32
; %bb.33:                               ;   in Loop: Header=BB3_5 Depth=1
	mov	x10, x14
	cmp	w11, w13
	b.ne	LBB3_35
	b	LBB3_3
LBB3_34:                                ;   in Loop: Header=BB3_5 Depth=1
	add	w10, w10, w12
LBB3_35:                                ;   Parent Loop BB3_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x10, #0xff
	strb	wzr, [x21, x11]
	add	w10, w10, #1
	cmp	w9, w10, uxtb
	b.hi	LBB3_35
	b	LBB3_3
LBB3_36:
Lloh4:
	adrp	x0, l_.str@PAGE
Lloh5:
	add	x0, x0, l_.str@PAGEOFF
	b	LBB3_44
LBB3_37:
	and	w8, w27, #0xff
	cmp	w8, #7
	b.ls	LBB3_41
; %bb.38:
Lloh6:
	adrp	x0, l_.str.4@PAGE
Lloh7:
	add	x0, x0, l_.str.4@PAGEOFF
	b	LBB3_44
LBB3_39:
Lloh8:
	adrp	x0, l_.str.5@PAGE
Lloh9:
	add	x0, x0, l_.str.5@PAGEOFF
	b	LBB3_44
LBB3_40:
Lloh10:
	adrp	x0, l_.str.1@PAGE
Lloh11:
	add	x0, x0, l_.str.1@PAGEOFF
	b	LBB3_44
LBB3_41:
Lloh12:
	adrp	x0, l_.str.5@PAGE
Lloh13:
	add	x0, x0, l_.str.5@PAGEOFF
	b.ne	LBB3_44
; %bb.42:
	and	w8, w26, #0xff
	cmp	w8, #8
	b.lo	LBB3_44
; %bb.43:
	mov	x0, #0
	ldp	x8, x9, [sp, #8]                ; 16-byte Folded Reload
	ldr	x10, [sp, #32]                  ; 8-byte Folded Reload
	stp	x10, x9, [x8]
	ldr	x10, [sp, #24]                  ; 8-byte Folded Reload
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	stp	x10, x9, [x8, #16]
	ldp	x10, x9, [sp, #48]              ; 16-byte Folded Reload
	stp	x10, x9, [x8, #32]
	stp	x25, x24, [x8, #48]
LBB3_44:
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	ret
LBB3_45:
	str	x23, [sp]
Lloh14:
	adrp	x0, l_.str.2@PAGE
Lloh15:
	add	x0, x0, l_.str.2@PAGEOFF
	bl	_printf
Lloh16:
	adrp	x0, l_.str.3@PAGE
Lloh17:
	add	x0, x0, l_.str.3@PAGEOFF
	b	LBB3_44
	.loh AdrpAdd	Lloh2, Lloh3
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh16, Lloh17
	.loh AdrpAdd	Lloh14, Lloh15
	.cfi_endproc
	.section	__TEXT,__const
lJTI3_0:
	.byte	(LBB3_19-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_20-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_21-LBB3_19)>>2
	.byte	(LBB3_45-LBB3_19)>>2
	.byte	(LBB3_22-LBB3_19)>>2
	.byte	(LBB3_23-LBB3_19)>>2
	.byte	(LBB3_24-LBB3_19)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_parse_turn                     ; -- Begin function parse_turn
	.p2align	2
_parse_turn:                            ; @parse_turn
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB4_4
; %bb.1:
	ldrb	w8, [x0]
	cbz	w8, LBB4_4
; %bb.2:
	ldrb	w9, [x0, #1]
	cbz	w9, LBB4_5
; %bb.3:
Lloh18:
	adrp	x0, l_.str.9@PAGE
Lloh19:
	add	x0, x0, l_.str.9@PAGEOFF
	ret
LBB4_4:
Lloh20:
	adrp	x0, l_.str.6@PAGE
Lloh21:
	add	x0, x0, l_.str.6@PAGEOFF
	ret
LBB4_5:
	cmp	w8, #97
	b.gt	LBB4_9
; %bb.6:
Lloh22:
	adrp	x0, l_.str.7@PAGE
Lloh23:
	add	x0, x0, l_.str.7@PAGEOFF
	cmp	w8, #66
	b.eq	LBB4_8
; %bb.7:
	cmp	w8, #87
	b.ne	LBB4_12
LBB4_8:
	ret
LBB4_9:
	cmp	w8, #98
	b.eq	LBB4_13
; %bb.10:
	cmp	w8, #119
	b.ne	LBB4_12
; %bb.11:
	mov	x0, #0
	mov	w8, #1
	strb	w8, [x1]
	ret
LBB4_12:
Lloh24:
	adrp	x0, l_.str.8@PAGE
Lloh25:
	add	x0, x0, l_.str.8@PAGEOFF
	ret
LBB4_13:
	mov	x0, #0
	strb	wzr, [x1]
	ret
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpAdd	Lloh20, Lloh21
	.loh AdrpAdd	Lloh22, Lloh23
	.loh AdrpAdd	Lloh24, Lloh25
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_castling                 ; -- Begin function parse_castling
	.p2align	2
_parse_castling:                        ; @parse_castling
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB5_5
; %bb.1:
	ldrb	w8, [x0]
	cbz	w8, LBB5_5
; %bb.2:
	strb	wzr, [x1]
	ldrsb	w9, [x0]
	cmp	w9, #45
	b.ne	LBB5_6
; %bb.3:
	ldrb	w8, [x0, #1]
	cbz	w8, LBB5_30
; %bb.4:
Lloh26:
	adrp	x0, l_.str.18@PAGE
Lloh27:
	add	x0, x0, l_.str.18@PAGEOFF
	ret
LBB5_5:
Lloh28:
	adrp	x0, l_.str.10@PAGE
Lloh29:
	add	x0, x0, l_.str.10@PAGEOFF
	ret
LBB5_6:
Lloh30:
	adrp	x8, l_.str.18@PAGE
Lloh31:
	add	x8, x8, l_.str.18@PAGEOFF
	sub	w11, w9, #75
	cmp	w11, #38
	b.hi	LBB5_9
; %bb.7:
	mov	w10, #0
	mov	w9, #1
Lloh32:
	adrp	x12, lJTI5_0@PAGE
Lloh33:
	add	x12, x12, lJTI5_0@PAGEOFF
	adr	x13, LBB5_8
	ldrb	w14, [x12, x11]
	add	x13, x13, x14, lsl #2
	mov	w11, #1
	mov	w12, #1
	br	x13
LBB5_8:
	mov	w10, #0
	mov	w11, #0
	mov	w9, #2
	mov	w12, #2
	b	LBB5_13
LBB5_9:
	cbz	w9, LBB5_30
LBB5_10:
	mov	x0, x8
	ret
LBB5_11:
	mov	w10, #0
	mov	w11, #0
	mov	w12, #3
	mov	w9, #4
	b	LBB5_13
LBB5_12:
	mov	w11, #0
	mov	w12, #4
	mov	w10, #1
	mov	w9, #8
LBB5_13:
	strb	w9, [x1]
	ldrsb	w13, [x0, #1]
Lloh34:
	adrp	x8, l_.str.18@PAGE
Lloh35:
	add	x8, x8, l_.str.18@PAGEOFF
	sub	w14, w13, #75
	cmp	w14, #38
	b.hi	LBB5_29
; %bb.14:
Lloh36:
	adrp	x13, lJTI5_1@PAGE
Lloh37:
	add	x13, x13, lJTI5_1@PAGEOFF
	adr	x15, LBB5_10
	ldrb	w16, [x13, x14]
	add	x15, x15, x16, lsl #2
	br	x15
LBB5_15:
	tbz	w11, #0, LBB5_28
; %bb.16:
Lloh38:
	adrp	x0, l_.str.11@PAGE
Lloh39:
	add	x0, x0, l_.str.11@PAGEOFF
	ret
LBB5_17:
	cmp	w12, #1
	b.eq	LBB5_25
; %bb.18:
	cmp	w12, #2
	b.ne	LBB5_41
; %bb.19:
Lloh40:
	adrp	x0, l_.str.13@PAGE
Lloh41:
	add	x0, x0, l_.str.13@PAGEOFF
	ret
LBB5_20:
	sub	w8, w12, #1
	cmp	w8, #2
	b.hs	LBB5_34
; %bb.21:
	mov	w11, #0
	mov	w10, #0
	mov	w12, #3
	mov	w8, #4
	b	LBB5_26
LBB5_22:
	tbz	w10, #0, LBB5_24
LBB5_23:
Lloh42:
	adrp	x0, l_.str.17@PAGE
Lloh43:
	add	x0, x0, l_.str.17@PAGEOFF
	ret
LBB5_24:
	mov	w10, #0
	mov	w12, #4
	mov	w11, #1
	mov	w8, #8
	b	LBB5_26
LBB5_25:
	mov	w11, #0
	mov	w8, #2
	mov	w10, #1
	mov	w12, #2
LBB5_26:
	orr	w9, w9, w8
	strb	w9, [x1]
	ldrsb	w13, [x0, #2]
Lloh44:
	adrp	x8, l_.str.18@PAGE
Lloh45:
	add	x8, x8, l_.str.18@PAGEOFF
	sub	w14, w13, #75
	cmp	w14, #38
	b.hi	LBB5_29
; %bb.27:
Lloh46:
	adrp	x13, lJTI5_2@PAGE
Lloh47:
	add	x13, x13, lJTI5_2@PAGEOFF
	adr	x15, LBB5_10
	ldrb	w16, [x13, x14]
	add	x15, x15, x16, lsl #2
	br	x15
LBB5_28:
Lloh48:
	adrp	x0, l_.str.12@PAGE
Lloh49:
	add	x0, x0, l_.str.12@PAGEOFF
	ret
LBB5_29:
	cbnz	w13, LBB5_10
LBB5_30:
	mov	x0, #0
	ret
LBB5_31:
	tbz	w10, #0, LBB5_41
; %bb.32:
Lloh50:
	adrp	x0, l_.str.13@PAGE
Lloh51:
	add	x0, x0, l_.str.13@PAGEOFF
	ret
LBB5_33:
	cmp	w12, #2
	b.eq	LBB5_38
LBB5_34:
	cmp	w12, #3
	b.ne	LBB5_44
LBB5_35:
Lloh52:
	adrp	x0, l_.str.15@PAGE
Lloh53:
	add	x0, x0, l_.str.15@PAGEOFF
	ret
LBB5_36:
	tbnz	w11, #0, LBB5_23
; %bb.37:
	mov	w10, #0
	mov	w11, #1
	mov	w8, #8
	b	LBB5_39
LBB5_38:
	mov	w11, #0
	mov	w10, #1
	mov	w8, #4
LBB5_39:
	orr	w9, w9, w8
	strb	w9, [x1]
	ldrsb	w12, [x0, #3]
Lloh54:
	adrp	x8, l_.str.18@PAGE
Lloh55:
	add	x8, x8, l_.str.18@PAGEOFF
	sub	w13, w12, #75
	cmp	w13, #38
	b.hi	LBB5_42
; %bb.40:
Lloh56:
	adrp	x12, lJTI5_3@PAGE
Lloh57:
	add	x12, x12, lJTI5_3@PAGEOFF
	adr	x14, LBB5_10
	ldrb	w15, [x12, x13]
	add	x14, x14, x15, lsl #2
	br	x14
LBB5_41:
Lloh58:
	adrp	x0, l_.str.14@PAGE
Lloh59:
	add	x0, x0, l_.str.14@PAGEOFF
	ret
LBB5_42:
	cbnz	w12, LBB5_10
	b	LBB5_30
LBB5_43:
	tbnz	w10, #0, LBB5_35
LBB5_44:
Lloh60:
	adrp	x8, l_.str.16@PAGE
Lloh61:
	add	x8, x8, l_.str.16@PAGEOFF
	mov	x0, x8
	ret
LBB5_45:
	tbnz	w11, #0, LBB5_23
; %bb.46:
	orr	w8, w9, #0x8
	strb	w8, [x1]
	ldrb	w8, [x0, #4]
Lloh62:
	adrp	x9, l_.str.19@PAGE
Lloh63:
	add	x9, x9, l_.str.19@PAGEOFF
	cmp	w8, #0
	csel	x0, xzr, x9, eq
	ret
	.loh AdrpAdd	Lloh26, Lloh27
	.loh AdrpAdd	Lloh28, Lloh29
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpAdd	Lloh32, Lloh33
	.loh AdrpAdd	Lloh34, Lloh35
	.loh AdrpAdd	Lloh36, Lloh37
	.loh AdrpAdd	Lloh38, Lloh39
	.loh AdrpAdd	Lloh40, Lloh41
	.loh AdrpAdd	Lloh42, Lloh43
	.loh AdrpAdd	Lloh44, Lloh45
	.loh AdrpAdd	Lloh46, Lloh47
	.loh AdrpAdd	Lloh48, Lloh49
	.loh AdrpAdd	Lloh50, Lloh51
	.loh AdrpAdd	Lloh52, Lloh53
	.loh AdrpAdd	Lloh54, Lloh55
	.loh AdrpAdd	Lloh56, Lloh57
	.loh AdrpAdd	Lloh58, Lloh59
	.loh AdrpAdd	Lloh60, Lloh61
	.loh AdrpAdd	Lloh62, Lloh63
	.cfi_endproc
	.section	__TEXT,__const
lJTI5_0:
	.byte	(LBB5_13-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_8-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_11-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_10-LBB5_8)>>2
	.byte	(LBB5_12-LBB5_8)>>2
lJTI5_1:
	.byte	(LBB5_15-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_17-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_20-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_22-LBB5_10)>>2
lJTI5_2:
	.byte	(LBB5_28-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_31-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_33-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_36-LBB5_10)>>2
lJTI5_3:
	.byte	(LBB5_28-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_41-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_43-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_10-LBB5_10)>>2
	.byte	(LBB5_45-LBB5_10)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_parse_ep_square                ; -- Begin function parse_ep_square
	.p2align	2
_parse_ep_square:                       ; @parse_ep_square
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
	cbz	x0, LBB6_5
; %bb.1:
	mov	x20, x0
	ldrb	w8, [x0]
	cbz	w8, LBB6_5
; %bb.2:
	mov	x19, x1
	cmp	w8, #45
	b.ne	LBB6_6
; %bb.3:
	ldrb	w9, [x20, #1]
	cbnz	w9, LBB6_7
; %bb.4:
	strb	wzr, [x19, #1]
	mov	w8, #64
	mov	x0, #0
	strb	w8, [x19]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB6_5:
Lloh64:
	adrp	x0, l_.str.20@PAGE
Lloh65:
	add	x0, x0, l_.str.20@PAGEOFF
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB6_6:
	ldrb	w9, [x20, #1]
	cbz	w9, LBB6_10
LBB6_7:
	ldrb	w10, [x20, #2]
	cbnz	w10, LBB6_10
; %bb.8:
	sxtb	w0, w8
	sxtb	w1, w9
	bl	_valid_square_chars
	cbz	w0, LBB6_10
; %bb.9:
	mov	w8, #1
	strb	w8, [x19, #1]
	ldrsb	w0, [x20]
	ldrsb	w1, [x20, #1]
	bl	_make_square
	mov	x8, x0
	mov	x0, #0
	strb	w8, [x19]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB6_10:
Lloh66:
	adrp	x0, l_.str.21@PAGE
Lloh67:
	add	x0, x0, l_.str.21@PAGEOFF
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpAdd	Lloh66, Lloh67
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_clock                    ; -- Begin function parse_clock
	.p2align	2
_parse_clock:                           ; @parse_clock
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
	cbz	x0, LBB7_7
; %bb.1:
	ldrb	w8, [x0]
	cbz	w8, LBB7_7
; %bb.2:
	mov	x19, x1
	mov	w9, #1
Lloh68:
	adrp	x2, l_.str.22@PAGE
Lloh69:
	add	x2, x2, l_.str.22@PAGEOFF
LBB7_3:                                 ; =>This Inner Loop Header: Depth=1
	sxtb	w8, w8
	sub	w8, w8, #48
	cmp	w8, #10
	b.hs	LBB7_7
; %bb.4:                                ;   in Loop: Header=BB7_3 Depth=1
	ldrb	w8, [x0, x9]
	add	x9, x9, #1
	cbnz	w8, LBB7_3
; %bb.5:
	bl	_atoi
	mov	w8, #65534
	cmp	w0, w8
	b.gt	LBB7_8
; %bb.6:
	mov	x2, #0
	strh	w0, [x19]
LBB7_7:
	mov	x0, x2
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB7_8:
Lloh70:
	adrp	x2, l_.str.23@PAGE
Lloh71:
	add	x2, x2, l_.str.23@PAGEOFF
	mov	x0, x2
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh68, Lloh69
	.loh AdrpAdd	Lloh70, Lloh71
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_halfmove                 ; -- Begin function parse_halfmove
	.p2align	2
_parse_halfmove:                        ; @parse_halfmove
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
	cbz	x0, LBB8_8
; %bb.1:
	mov	x8, x0
	ldrb	w10, [x0]
	cbz	w10, LBB8_8
; %bb.2:
	mov	x19, x1
	mov	w9, #1
Lloh72:
	adrp	x0, l_.str.22@PAGE
Lloh73:
	add	x0, x0, l_.str.22@PAGEOFF
LBB8_3:                                 ; =>This Inner Loop Header: Depth=1
	sxtb	w10, w10
	sub	w10, w10, #48
	cmp	w10, #10
	b.hs	LBB8_7
; %bb.4:                                ;   in Loop: Header=BB8_3 Depth=1
	ldrb	w10, [x8, x9]
	add	x9, x9, #1
	cbnz	w10, LBB8_3
; %bb.5:
	mov	x0, x8
	bl	_atoi
	mov	w9, #65534
	cmp	w0, w9
	b.gt	LBB8_9
; %bb.6:
	mov	x8, x0
	mov	x0, #0
	strh	w8, [x19]
LBB8_7:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB8_8:
Lloh74:
	adrp	x0, l_.str.24@PAGE
Lloh75:
	add	x0, x0, l_.str.24@PAGEOFF
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB8_9:
Lloh76:
	adrp	x0, l_.str.23@PAGE
Lloh77:
	add	x0, x0, l_.str.23@PAGEOFF
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh72, Lloh73
	.loh AdrpAdd	Lloh74, Lloh75
	.loh AdrpAdd	Lloh76, Lloh77
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_fullmove                 ; -- Begin function parse_fullmove
	.p2align	2
_parse_fullmove:                        ; @parse_fullmove
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
	cbz	x0, LBB9_8
; %bb.1:
	mov	x8, x0
	ldrb	w10, [x0]
	cbz	w10, LBB9_8
; %bb.2:
	mov	x19, x1
	mov	w9, #1
Lloh78:
	adrp	x0, l_.str.22@PAGE
Lloh79:
	add	x0, x0, l_.str.22@PAGEOFF
LBB9_3:                                 ; =>This Inner Loop Header: Depth=1
	sxtb	w10, w10
	sub	w10, w10, #48
	cmp	w10, #10
	b.hs	LBB9_7
; %bb.4:                                ;   in Loop: Header=BB9_3 Depth=1
	ldrb	w10, [x8, x9]
	add	x9, x9, #1
	cbnz	w10, LBB9_3
; %bb.5:
	mov	x0, x8
	bl	_atoi
	mov	w9, #65534
	cmp	w0, w9
	b.gt	LBB9_9
; %bb.6:
	mov	x8, x0
	mov	x0, #0
	strh	w8, [x19]
LBB9_7:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB9_8:
Lloh80:
	adrp	x0, l_.str.25@PAGE
Lloh81:
	add	x0, x0, l_.str.25@PAGEOFF
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB9_9:
Lloh82:
	adrp	x0, l_.str.23@PAGE
Lloh83:
	add	x0, x0, l_.str.23@PAGEOFF
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh78, Lloh79
	.loh AdrpAdd	Lloh80, Lloh81
	.loh AdrpAdd	Lloh82, Lloh83
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_fen                      ; -- Begin function parse_fen
	.p2align	2
_parse_fen:                             ; @parse_fen
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB10_3
; %bb.1:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x20, x2
	mov	x19, x1
	str	xzr, [sp, #8]
Lloh84:
	adrp	x1, l_.str.27@PAGE
Lloh85:
	add	x1, x1, l_.str.27@PAGEOFF
	add	x2, sp, #8
	bl	_strtok_r
	ldr	x1, [x19]
	mov	x2, x20
	bl	_parse_position
	cbz	x0, LBB10_4
LBB10_2:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB10_3:
Lloh86:
	adrp	x0, l_.str.26@PAGE
Lloh87:
	add	x0, x0, l_.str.26@PAGEOFF
	ret
LBB10_4:
Lloh88:
	adrp	x1, l_.str.27@PAGE
Lloh89:
	add	x1, x1, l_.str.27@PAGEOFF
	add	x2, sp, #8
	bl	_strtok_r
	cbz	x0, LBB10_8
; %bb.5:
	ldrb	w8, [x0]
	cbz	w8, LBB10_8
; %bb.6:
	ldrb	w9, [x0, #1]
	cbz	w9, LBB10_9
; %bb.7:
Lloh90:
	adrp	x0, l_.str.9@PAGE
Lloh91:
	add	x0, x0, l_.str.9@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB10_8:
Lloh92:
	adrp	x0, l_.str.6@PAGE
Lloh93:
	add	x0, x0, l_.str.6@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB10_9:
	cmp	w8, #97
	b.gt	LBB10_12
; %bb.10:
Lloh94:
	adrp	x0, l_.str.7@PAGE
Lloh95:
	add	x0, x0, l_.str.7@PAGEOFF
	cmp	w8, #66
	b.eq	LBB10_2
; %bb.11:
	cmp	w8, #87
	b.eq	LBB10_2
	b	LBB10_22
LBB10_12:
	cmp	w8, #119
	b.eq	LBB10_15
; %bb.13:
	cmp	w8, #98
	b.ne	LBB10_22
; %bb.14:
	mov	w8, #0
	b	LBB10_16
LBB10_15:
	mov	w8, #1
LBB10_16:
	strb	w8, [x19, #8]
Lloh96:
	adrp	x1, l_.str.27@PAGE
Lloh97:
	add	x1, x1, l_.str.27@PAGEOFF
	add	x2, sp, #8
	mov	x0, #0
	bl	_strtok_r
	add	x1, x19, #9
	bl	_parse_castling
	cbnz	x0, LBB10_2
; %bb.17:
Lloh98:
	adrp	x1, l_.str.27@PAGE
Lloh99:
	add	x1, x1, l_.str.27@PAGEOFF
	add	x2, sp, #8
	bl	_strtok_r
	cbz	x0, LBB10_23
; %bb.18:
	mov	x20, x0
	ldrb	w8, [x0]
	cbz	w8, LBB10_23
; %bb.19:
	cmp	w8, #45
	b.ne	LBB10_24
; %bb.20:
	ldrb	w9, [x20, #1]
	cbnz	w9, LBB10_25
; %bb.21:
	strb	wzr, [x19, #11]
	mov	w0, #64
	b	LBB10_28
LBB10_22:
Lloh100:
	adrp	x0, l_.str.8@PAGE
Lloh101:
	add	x0, x0, l_.str.8@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB10_23:
Lloh102:
	adrp	x0, l_.str.20@PAGE
Lloh103:
	add	x0, x0, l_.str.20@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB10_24:
	ldrb	w9, [x20, #1]
	cbz	w9, LBB10_31
LBB10_25:
	ldrb	w10, [x20, #2]
	cbnz	w10, LBB10_31
; %bb.26:
	sxtb	w0, w8
	sxtb	w1, w9
	bl	_valid_square_chars
	cbz	w0, LBB10_31
; %bb.27:
	mov	w8, #1
	strb	w8, [x19, #11]
	ldrsb	w0, [x20]
	ldrsb	w1, [x20, #1]
	bl	_make_square
LBB10_28:
	strb	w0, [x19, #10]
Lloh104:
	adrp	x1, l_.str.27@PAGE
Lloh105:
	add	x1, x1, l_.str.27@PAGEOFF
	add	x2, sp, #8
	mov	x0, #0
	bl	_strtok_r
	add	x1, x19, #12
	bl	_parse_halfmove
	cbnz	x0, LBB10_2
; %bb.29:
Lloh106:
	adrp	x1, l_.str.27@PAGE
Lloh107:
	add	x1, x1, l_.str.27@PAGEOFF
	add	x2, sp, #8
	bl	_strtok_r
	add	x1, x19, #14
	bl	_parse_fullmove
	cbnz	x0, LBB10_2
; %bb.30:
Lloh108:
	adrp	x1, l_.str.27@PAGE
Lloh109:
	add	x1, x1, l_.str.27@PAGEOFF
	add	x2, sp, #8
	bl	_strtok_r
Lloh110:
	adrp	x8, l_.str.28@PAGE
Lloh111:
	add	x8, x8, l_.str.28@PAGEOFF
	cmp	x0, #0
	csel	x0, xzr, x8, eq
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB10_31:
Lloh112:
	adrp	x0, l_.str.21@PAGE
Lloh113:
	add	x0, x0, l_.str.21@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.loh AdrpAdd	Lloh84, Lloh85
	.loh AdrpAdd	Lloh86, Lloh87
	.loh AdrpAdd	Lloh88, Lloh89
	.loh AdrpAdd	Lloh90, Lloh91
	.loh AdrpAdd	Lloh92, Lloh93
	.loh AdrpAdd	Lloh94, Lloh95
	.loh AdrpAdd	Lloh96, Lloh97
	.loh AdrpAdd	Lloh98, Lloh99
	.loh AdrpAdd	Lloh100, Lloh101
	.loh AdrpAdd	Lloh102, Lloh103
	.loh AdrpAdd	Lloh104, Lloh105
	.loh AdrpAdd	Lloh106, Lloh107
	.loh AdrpAdd	Lloh110, Lloh111
	.loh AdrpAdd	Lloh108, Lloh109
	.loh AdrpAdd	Lloh112, Lloh113
	.cfi_endproc
                                        ; -- End function
	.globl	_write_castling                 ; -- Begin function write_castling
	.p2align	2
_write_castling:                        ; @write_castling
	.cfi_startproc
; %bb.0:
	mov	x8, x2
	cmp	w0, #15
	b.hi	LBB11_23
; %bb.1:
	mov	w9, #45
	mov	w10, #1
	mov	w11, w0
Lloh114:
	adrp	x12, lJTI11_0@PAGE
Lloh115:
	add	x12, x12, lJTI11_0@PAGEOFF
	adr	x13, LBB11_2
	ldrb	w14, [x12, x11]
	add	x13, x13, x14, lsl #2
	br	x13
LBB11_2:
	mov	w9, #75
	b	LBB11_11
LBB11_3:
	mov	w9, #81
	b	LBB11_11
LBB11_4:
	mov	w9, #75
	strb	w9, [x1, w8, uxtw]
	add	w8, w2, #1
	mov	w9, #81
	mov	w10, #2
                                        ; kill: def $w8 killed $w8 def $x8
	b	LBB11_22
LBB11_5:
	mov	w9, #107
	b	LBB11_11
LBB11_6:
	mov	w9, #75
	b	LBB11_8
LBB11_7:
	mov	w9, #81
LBB11_8:
	strb	w9, [x1, w8, uxtw]
	add	w8, w2, #1
	mov	w9, #107
	mov	w10, #2
                                        ; kill: def $w8 killed $w8 def $x8
	b	LBB11_22
LBB11_9:
	add	w9, w2, #1
	mov	w10, #75
	strb	w10, [x1, w8, uxtw]
	add	w8, w2, #2
	and	x9, x9, #0xff
	mov	w10, #81
	strb	w10, [x1, x9]
	mov	w9, #107
	mov	w10, #3
	b	LBB11_22
LBB11_10:
	mov	w9, #113
LBB11_11:
	mov	w10, #1
	b	LBB11_22
LBB11_12:
	mov	w9, #75
	b	LBB11_16
LBB11_13:
	mov	w9, #81
	b	LBB11_16
LBB11_14:
	add	w9, w2, #1
	mov	w10, #75
	strb	w10, [x1, w8, uxtw]
	add	w8, w2, #2
	and	x9, x9, #0xff
	mov	w10, #81
	b	LBB11_20
LBB11_15:
	mov	w9, #107
LBB11_16:
	strb	w9, [x1, w8, uxtw]
	add	w8, w2, #1
	mov	w9, #113
	mov	w10, #2
                                        ; kill: def $w8 killed $w8 def $x8
	b	LBB11_22
LBB11_17:
	add	w9, w2, #1
	mov	w10, #75
	b	LBB11_19
LBB11_18:
	add	w9, w2, #1
	mov	w10, #81
LBB11_19:
	strb	w10, [x1, w8, uxtw]
	add	w8, w2, #2
	and	x9, x9, #0xff
	mov	w10, #107
LBB11_20:
	strb	w10, [x1, x9]
	mov	w9, #113
	mov	w10, #3
	b	LBB11_22
LBB11_21:
	add	w9, w2, #1
	mov	w10, #75
	strb	w10, [x1, w8, uxtw]
	add	w10, w2, #2
	and	x8, x9, #0xff
	mov	w9, #81
	strb	w9, [x1, x8]
	add	w8, w2, #3
	and	x9, x10, #0xff
	mov	w10, #107
	strb	w10, [x1, x9]
	mov	w9, #113
	mov	w10, #4
LBB11_22:
	and	x8, x8, #0xff
	add	w10, w10, w2
	strb	w9, [x1, x8]
	mov	x8, x10
LBB11_23:
	and	w0, w8, #0xff
	ret
	.loh AdrpAdd	Lloh114, Lloh115
	.cfi_endproc
	.section	__TEXT,__const
lJTI11_0:
	.byte	(LBB11_22-LBB11_2)>>2
	.byte	(LBB11_2-LBB11_2)>>2
	.byte	(LBB11_3-LBB11_2)>>2
	.byte	(LBB11_4-LBB11_2)>>2
	.byte	(LBB11_5-LBB11_2)>>2
	.byte	(LBB11_6-LBB11_2)>>2
	.byte	(LBB11_7-LBB11_2)>>2
	.byte	(LBB11_9-LBB11_2)>>2
	.byte	(LBB11_10-LBB11_2)>>2
	.byte	(LBB11_12-LBB11_2)>>2
	.byte	(LBB11_13-LBB11_2)>>2
	.byte	(LBB11_14-LBB11_2)>>2
	.byte	(LBB11_15-LBB11_2)>>2
	.byte	(LBB11_17-LBB11_2)>>2
	.byte	(LBB11_18-LBB11_2)>>2
	.byte	(LBB11_21-LBB11_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_make_fen                       ; -- Begin function make_fen
	.p2align	2
_make_fen:                              ; @make_fen
	.cfi_startproc
; %bb.0:
	cbz	x1, LBB12_25
; %bb.1:
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
	mov	w9, #0
	mov	w7, #0
	mov	w8, #0
	mov	w10, #1
	mov	w11, #47
	mov	w12, #75
	mov	w13, #107
	mov	w14, #81
	mov	w15, #113
	mov	w16, #82
	mov	w17, #114
	mov	w0, #78
	mov	w1, #110
	mov	w2, #66
	mov	w3, #98
	mov	w4, #80
	mov	w5, #112
	b	LBB12_4
LBB12_2:                                ;   in Loop: Header=BB12_4 Depth=1
	add	w6, w7, #1
	cmp	w8, #62
	b.hi	LBB12_26
LBB12_3:                                ;   in Loop: Header=BB12_4 Depth=1
	add	w8, w8, #1
	mov	x7, x6
LBB12_4:                                ; =>This Inner Loop Header: Depth=1
	and	w6, w8, #0x78
	and	w22, w8, #0x7
	sub	w21, w22, w6
	ldr	x6, [x20]
	cbz	w8, LBB12_9
; %bb.5:                                ;   in Loop: Header=BB12_4 Depth=1
	cbnz	w22, LBB12_9
; %bb.6:                                ;   in Loop: Header=BB12_4 Depth=1
	cmp	w7, #1
	b.lt	LBB12_8
; %bb.7:                                ;   in Loop: Header=BB12_4 Depth=1
	add	w7, w7, #48
	strb	w7, [x19, w9, sxtw]
	add	w9, w9, #1
LBB12_8:                                ;   in Loop: Header=BB12_4 Depth=1
	mov	w7, #0
	strb	w11, [x19, w9, sxtw]
	add	w9, w9, #1
                                        ; kill: def $w9 killed $w9 def $x9
LBB12_9:                                ;   in Loop: Header=BB12_4 Depth=1
	add	w21, w21, #56
	lsl	x22, x10, x21
	ldr	x21, [x6, #48]
	ands	x21, x21, x22
	b.ne	LBB12_11
; %bb.10:                               ;   in Loop: Header=BB12_4 Depth=1
	ldr	x23, [x6, #56]
	tst	x23, x22
	b.eq	LBB12_2
LBB12_11:                               ;   in Loop: Header=BB12_4 Depth=1
	cmp	w7, #1
	b.lt	LBB12_13
; %bb.12:                               ;   in Loop: Header=BB12_4 Depth=1
	add	w7, w7, #48
	strb	w7, [x19, w9, sxtw]
	add	w9, w9, #1
LBB12_13:                               ;   in Loop: Header=BB12_4 Depth=1
	ldr	x7, [x6]
	tst	x7, x22
	b.eq	LBB12_15
; %bb.14:                               ;   in Loop: Header=BB12_4 Depth=1
	cmp	x21, #0
	csel	w6, w5, w4, eq
	strb	w6, [x19, w9, sxtw]
	add	w9, w9, #1
	cmp	w8, #63
	b.lo	LBB12_24
	b	LBB12_28
LBB12_15:                               ;   in Loop: Header=BB12_4 Depth=1
	ldr	x7, [x6, #16]
	tst	x7, x22
	b.eq	LBB12_17
; %bb.16:                               ;   in Loop: Header=BB12_4 Depth=1
	cmp	x21, #0
	csel	w6, w3, w2, eq
	strb	w6, [x19, w9, sxtw]
	add	w9, w9, #1
	cmp	w8, #63
	b.lo	LBB12_24
	b	LBB12_28
LBB12_17:                               ;   in Loop: Header=BB12_4 Depth=1
	ldr	x7, [x6, #8]
	tst	x7, x22
	b.eq	LBB12_19
; %bb.18:                               ;   in Loop: Header=BB12_4 Depth=1
	cmp	x21, #0
	csel	w6, w1, w0, eq
	strb	w6, [x19, w9, sxtw]
	add	w9, w9, #1
	cmp	w8, #63
	b.lo	LBB12_24
	b	LBB12_28
LBB12_19:                               ;   in Loop: Header=BB12_4 Depth=1
	ldr	x7, [x6, #24]
	tst	x7, x22
	b.eq	LBB12_21
; %bb.20:                               ;   in Loop: Header=BB12_4 Depth=1
	cmp	x21, #0
	csel	w6, w17, w16, eq
	strb	w6, [x19, w9, sxtw]
	add	w9, w9, #1
	cmp	w8, #63
	b.lo	LBB12_24
	b	LBB12_28
LBB12_21:                               ;   in Loop: Header=BB12_4 Depth=1
	ldr	x7, [x6, #32]
	sxtw	x6, w9
	tst	x7, x22
	b.eq	LBB12_23
; %bb.22:                               ;   in Loop: Header=BB12_4 Depth=1
	cmp	x21, #0
	csel	w7, w15, w14, eq
	strb	w7, [x19, x6]
	add	w9, w9, #1
	cmp	w8, #63
	b.lo	LBB12_24
	b	LBB12_28
LBB12_23:                               ;   in Loop: Header=BB12_4 Depth=1
	cmp	x21, #0
	csel	w7, w13, w12, eq
	strb	w7, [x19, x6]
	add	w9, w9, #1
	cmp	w8, #63
	b.hs	LBB12_28
LBB12_24:                               ;   in Loop: Header=BB12_4 Depth=1
	mov	w6, #0
	b	LBB12_3
LBB12_25:
	and	w0, wzr, #0xff
	ret
LBB12_26:
	tbnz	w7, #31, LBB12_28
; %bb.27:
	add	w8, w6, #48
	strb	w8, [x19, w9, sxtw]
	add	w9, w9, #1
LBB12_28:
	add	x10, x19, w9, sxtw
	mov	w8, #32
	strb	w8, [x10]
	ldrb	w11, [x20, #8]
	mov	w12, #98
	mov	w13, #119
	cmp	w11, #1
	csel	w11, w13, w12, eq
	strb	w11, [x10, #1]
	strb	w8, [x10, #2]
	ldrb	w14, [x20, #9]
	add	w10, w9, #3
	mov	x11, x10
	cmp	w14, #15
	b.hi	LBB12_51
; %bb.29:
	mov	w12, #45
	mov	w13, #1
Lloh116:
	adrp	x15, lJTI12_0@PAGE
Lloh117:
	add	x15, x15, lJTI12_0@PAGEOFF
	adr	x16, LBB12_30
	ldrb	w17, [x15, x14]
	add	x16, x16, x17, lsl #2
	br	x16
LBB12_30:
	mov	w12, #75
	b	LBB12_39
LBB12_31:
	mov	w12, #81
	b	LBB12_39
LBB12_32:
	add	w11, w9, #4
	and	x9, x10, #0xff
	mov	w12, #75
	strb	w12, [x19, x9]
	mov	w12, #81
	mov	w13, #2
	b	LBB12_50
LBB12_33:
	mov	w12, #107
	b	LBB12_39
LBB12_34:
	add	w11, w9, #4
	and	x9, x10, #0xff
	mov	w12, #75
	b	LBB12_36
LBB12_35:
	add	w11, w9, #4
	and	x9, x10, #0xff
	mov	w12, #81
LBB12_36:
	strb	w12, [x19, x9]
	mov	w12, #107
	mov	w13, #2
	b	LBB12_50
LBB12_37:
	add	w12, w9, #4
	and	x11, x10, #0xff
	mov	w13, #75
	strb	w13, [x19, x11]
	add	w11, w9, #5
	and	x9, x12, #0xff
	mov	w12, #81
	strb	w12, [x19, x9]
	mov	w12, #107
	mov	w13, #3
	b	LBB12_50
LBB12_38:
	mov	w12, #113
LBB12_39:
	mov	w13, #1
	b	LBB12_50
LBB12_40:
	add	w11, w9, #4
	and	x9, x10, #0xff
	mov	w12, #75
	b	LBB12_44
LBB12_41:
	add	w11, w9, #4
	and	x9, x10, #0xff
	mov	w12, #81
	b	LBB12_44
LBB12_42:
	add	w12, w9, #4
	and	x11, x10, #0xff
	mov	w13, #75
	strb	w13, [x19, x11]
	add	w11, w9, #5
	and	x9, x12, #0xff
	mov	w12, #81
	b	LBB12_48
LBB12_43:
	add	w11, w9, #4
	and	x9, x10, #0xff
	mov	w12, #107
LBB12_44:
	strb	w12, [x19, x9]
	mov	w12, #113
	mov	w13, #2
	b	LBB12_50
LBB12_45:
	add	w12, w9, #4
	and	x11, x10, #0xff
	mov	w13, #75
	b	LBB12_47
LBB12_46:
	add	w12, w9, #4
	and	x11, x10, #0xff
	mov	w13, #81
LBB12_47:
	strb	w13, [x19, x11]
	add	w11, w9, #5
	and	x9, x12, #0xff
	mov	w12, #107
LBB12_48:
	strb	w12, [x19, x9]
	mov	w12, #113
	mov	w13, #3
	b	LBB12_50
LBB12_49:
	add	w11, w9, #4
	and	x12, x10, #0xff
	mov	w13, #75
	strb	w13, [x19, x12]
	add	w12, w9, #5
	and	x11, x11, #0xff
	mov	w13, #81
	strb	w13, [x19, x11]
	add	w11, w9, #6
	and	x9, x12, #0xff
	mov	w12, #107
	strb	w12, [x19, x9]
	mov	w12, #113
	mov	w13, #4
LBB12_50:
	and	x9, x11, #0xff
	add	w10, w13, w10
	strb	w12, [x19, x9]
	mov	x11, x10
LBB12_51:
	and	w22, w11, #0xff
                                        ; kill: def $w11 killed $w11 killed $x11 def $x11
	and	x9, x11, #0xff
	strb	w8, [x19, x9]
	ldrb	w8, [x20, #11]
	tbnz	w8, #0, LBB12_53
; %bb.52:
	add	w23, w22, #1
	mov	w0, #45
	mov	w8, #2
	b	LBB12_54
LBB12_53:
	ldrb	w21, [x20, #10]
	mov	x0, x21
	bl	_file_char_of_square
	add	w23, w22, #2
	add	x8, x19, w22, uxtw
	strb	w0, [x8, #1]
	mov	x0, x21
	bl	_rank_char_of_square
	mov	w8, #3
LBB12_54:
	mov	w8, w8
	strb	w0, [x19, w23, uxtw]
	add	x8, x8, w22, uxtw
	add	w1, w8, #1
	mov	w21, #32
	strb	w21, [x19, x8]
	ldrh	w2, [x20, #12]
	mov	x0, x19
	bl	_write_num
	add	w1, w0, #1
	strb	w21, [x19, w0, sxtw]
	ldrh	w2, [x20, #14]
	mov	x0, x19
	bl	_write_num
	strb	wzr, [x19, w0, sxtw]
	add	w8, w0, #1
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	and	w0, w8, #0xff
	ret
	.loh AdrpAdd	Lloh116, Lloh117
	.cfi_endproc
	.section	__TEXT,__const
lJTI12_0:
	.byte	(LBB12_50-LBB12_30)>>2
	.byte	(LBB12_30-LBB12_30)>>2
	.byte	(LBB12_31-LBB12_30)>>2
	.byte	(LBB12_32-LBB12_30)>>2
	.byte	(LBB12_33-LBB12_30)>>2
	.byte	(LBB12_34-LBB12_30)>>2
	.byte	(LBB12_35-LBB12_30)>>2
	.byte	(LBB12_37-LBB12_30)>>2
	.byte	(LBB12_38-LBB12_30)>>2
	.byte	(LBB12_40-LBB12_30)>>2
	.byte	(LBB12_41-LBB12_30)>>2
	.byte	(LBB12_42-LBB12_30)>>2
	.byte	(LBB12_43-LBB12_30)>>2
	.byte	(LBB12_45-LBB12_30)>>2
	.byte	(LBB12_46-LBB12_30)>>2
	.byte	(LBB12_49-LBB12_30)>>2
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"No position specified"

l_.str.1:                               ; @.str.1
	.asciz	"Position has too many squares in a rank"

l_.str.2:                               ; @.str.2
	.asciz	"character unknown %c\n"

l_.str.3:                               ; @.str.3
	.asciz	"Position has unknown character"

l_.str.4:                               ; @.str.4
	.asciz	"Position has too many ranks"

l_.str.5:                               ; @.str.5
	.asciz	"Position does not describe entire board"

l_.str.6:                               ; @.str.6
	.asciz	"No turn specified"

l_.str.7:                               ; @.str.7
	.asciz	"Turn must be specified in lowercase"

l_.str.8:                               ; @.str.8
	.asciz	"Turn is not 'w' or 'b'"

l_.str.9:                               ; @.str.9
	.asciz	"Length of turn is greater than one character"

l_.str.10:                              ; @.str.10
	.asciz	"No castling rights specified"

l_.str.11:                              ; @.str.11
	.asciz	"Invalid castling rights, 'K' cannot be specified twice"

l_.str.12:                              ; @.str.12
	.asciz	"Invalid castling rights, 'K' cannot be specified after 'Q', 'k', or 'q'"

l_.str.13:                              ; @.str.13
	.asciz	"Invalid castling rights, 'Q' cannot be specified twice"

l_.str.14:                              ; @.str.14
	.asciz	"Invalid castling rights, 'Q' cannot be specified after 'k' or 'q'"

l_.str.15:                              ; @.str.15
	.asciz	"Invalid castling rights, 'k' cannot be specified twice"

l_.str.16:                              ; @.str.16
	.asciz	"Invalid castling rights, 'k' cannot be specified after 'q'"

l_.str.17:                              ; @.str.17
	.asciz	"Invalid castling rights, 'q' cannot be specified twice"

l_.str.18:                              ; @.str.18
	.asciz	"Invalid castling rights, unknown character"

l_.str.19:                              ; @.str.19
	.asciz	"Invalid castling rights, too many characters"

l_.str.20:                              ; @.str.20
	.asciz	"Missing en-passant square"

l_.str.21:                              ; @.str.21
	.asciz	"Invalid en-passant square"

l_.str.22:                              ; @.str.22
	.asciz	"Clock includes a non-digit"

l_.str.23:                              ; @.str.23
	.asciz	"Empty clock"

l_.str.24:                              ; @.str.24
	.asciz	"Missing halfmove clock"

l_.str.25:                              ; @.str.25
	.asciz	"Missing fullmove timer"

l_.str.26:                              ; @.str.26
	.asciz	"Empty FEN"

l_.str.27:                              ; @.str.27
	.asciz	" "

l_.str.28:                              ; @.str.28
	.asciz	"FEN has too many terms"

.subsections_via_symbols
