	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_validate                       ; -- Begin function validate
	.p2align	2
_validate:                              ; @validate
	.cfi_startproc
; %bb.0:
	cmp	w0, #0
	b.gt	LBB0_3
; %bb.1:
	tbz	w3, #0, LBB0_3
; %bb.2:
Lloh0:
	adrp	x0, l_.str@PAGE
Lloh1:
	add	x0, x0, l_.str@PAGEOFF
	ret
LBB0_3:
	cmp	w1, #0
	b.gt	LBB0_6
; %bb.4:
	tbz	w4, #0, LBB0_6
; %bb.5:
Lloh2:
	adrp	x0, l_.str.1@PAGE
Lloh3:
	add	x0, x0, l_.str.1@PAGEOFF
	ret
LBB0_6:
	cmp	w2, #0
	b.gt	LBB0_9
; %bb.7:
	tbz	w5, #0, LBB0_9
; %bb.8:
Lloh4:
	adrp	x0, l_.str.2@PAGE
Lloh5:
	add	x0, x0, l_.str.2@PAGEOFF
	ret
LBB0_9:
	cmp	w1, #13
	b.lt	LBB0_12
; %bb.10:
	tbz	w4, #0, LBB0_12
; %bb.11:
Lloh6:
	adrp	x0, l_.str.3@PAGE
Lloh7:
	add	x0, x0, l_.str.3@PAGEOFF
	ret
LBB0_12:
	cbz	w5, LBB0_25
; %bb.13:
	tbz	w4, #0, LBB0_20
; %bb.14:
	cmp	w1, #2
	b.ne	LBB0_22
; %bb.15:
	mov	w8, #29
	mov	w9, #23593
	movk	w9, #49807, lsl #16
	mov	w10, #47184
	movk	w10, #1310, lsl #16
	madd	w9, w0, w9, w10
	ror	w9, w9, #4
	mov	w10, #55051
	movk	w10, #163, lsl #16
	cmp	w9, w10
	b.lo	LBB0_18
; %bb.16:
	cbz	w3, LBB0_18
; %bb.17:
	mov	w8, #23593
	movk	w8, #49807, lsl #16
	mov	w9, #47184
	movk	w9, #1310, lsl #16
	madd	w8, w0, w8, w9
	ror	w8, w8, #2
	and	w9, w0, #0x3
	mov	w10, #23593
	movk	w10, #655, lsl #16
	cmp	w8, w10
	ccmp	w9, #0, #0, hs
	mov	w8, #28
	cinc	w8, w8, eq
LBB0_18:
	cmp	w8, w2
	b.ge	LBB0_25
; %bb.19:
Lloh8:
	adrp	x0, l_.str.5@PAGE
Lloh9:
	add	x0, x0, l_.str.5@PAGEOFF
	ret
LBB0_20:
	cmp	w2, #31
	b.le	LBB0_25
; %bb.21:
Lloh10:
	adrp	x0, l_.str.4@PAGE
Lloh11:
	add	x0, x0, l_.str.4@PAGEOFF
	ret
LBB0_22:
Lloh12:
	adrp	x8, _validate.max_days@PAGE
Lloh13:
	add	x8, x8, _validate.max_days@PAGEOFF
	add	x8, x8, w1, sxtw #2
	ldur	w8, [x8, #-4]
	cmp	w8, w2
	b.ge	LBB0_25
; %bb.23:
	sub	w8, w1, #1
	cmp	w8, #12
	b.hs	LBB0_25
; %bb.24:
Lloh14:
	adrp	x9, l_switch.table.validate@PAGE
Lloh15:
	add	x9, x9, l_switch.table.validate@PAGEOFF
	ldr	x0, [x9, w8, sxtw  #3]
	ret
LBB0_25:
	mov	x0, #0
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh2, Lloh3
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh14, Lloh15
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_split                    ; -- Begin function parse_split
	.p2align	2
_parse_split:                           ; @parse_split
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
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
	mov	x22, x3
	mov	x23, x2
	mov	x21, x1
	mov	x19, x0
	str	xzr, [sp, #24]
	str	wzr, [sp, #20]
Lloh16:
	adrp	x1, l_.str.17@PAGE
Lloh17:
	add	x1, x1, l_.str.17@PAGEOFF
	mov	x0, x21
	bl	_strcmp
	mov	x20, x0
	cbz	w0, LBB1_2
; %bb.1:
	add	x8, sp, #28
	str	x8, [sp]
Lloh18:
	adrp	x1, l_.str.18@PAGE
Lloh19:
	add	x1, x1, l_.str.18@PAGEOFF
	mov	x0, x21
	bl	_sscanf
	cbz	w0, LBB1_7
LBB1_2:
	cmp	w20, #0
	cset	w24, ne
Lloh20:
	adrp	x1, l_.str.20@PAGE
Lloh21:
	add	x1, x1, l_.str.20@PAGEOFF
	mov	x0, x23
	bl	_strcmp
	mov	x21, x0
	cbz	w0, LBB1_4
; %bb.3:
	add	x8, sp, #24
	str	x8, [sp]
Lloh22:
	adrp	x1, l_.str.18@PAGE
Lloh23:
	add	x1, x1, l_.str.18@PAGEOFF
	mov	x0, x23
	bl	_sscanf
	cbz	w0, LBB1_14
LBB1_4:
	cmp	w21, #0
	cset	w25, ne
Lloh24:
	adrp	x1, l_.str.20@PAGE
Lloh25:
	add	x1, x1, l_.str.20@PAGEOFF
	mov	x0, x22
	bl	_strcmp
	mov	x23, x0
	cbz	w0, LBB1_8
; %bb.5:
	add	x8, sp, #20
	str	x8, [sp]
Lloh26:
	adrp	x1, l_.str.18@PAGE
Lloh27:
	add	x1, x1, l_.str.18@PAGEOFF
	mov	x0, x22
	bl	_sscanf
	cbz	w0, LBB1_15
; %bb.6:
	ldr	w8, [sp, #20]
	cmp	w23, #0
	cset	w9, ne
	ldp	w10, w11, [sp, #24]
                                        ; kill: def $w10 killed $w10 def $x10
	sxtw	x10, w10
	cbnz	w20, LBB1_9
	b	LBB1_11
LBB1_7:
Lloh28:
	adrp	x0, l_.str.19@PAGE
Lloh29:
	add	x0, x0, l_.str.19@PAGEOFF
	b	LBB1_36
LBB1_8:
	mov	w8, #0
	cmp	w23, #0
	cset	w9, ne
	ldp	w10, w11, [sp, #24]
                                        ; kill: def $w10 killed $w10 def $x10
	sxtw	x10, w10
	cbz	w20, LBB1_11
LBB1_9:
	cmp	w11, #1
	b.ge	LBB1_11
; %bb.10:
Lloh30:
	adrp	x0, l_.str@PAGE
Lloh31:
	add	x0, x0, l_.str@PAGEOFF
	b	LBB1_36
LBB1_11:
	cbz	w21, LBB1_16
; %bb.12:
	cmp	w10, #1
	b.ge	LBB1_16
; %bb.13:
Lloh32:
	adrp	x0, l_.str.1@PAGE
Lloh33:
	add	x0, x0, l_.str.1@PAGEOFF
	b	LBB1_36
LBB1_14:
Lloh34:
	adrp	x0, l_.str.21@PAGE
Lloh35:
	add	x0, x0, l_.str.21@PAGEOFF
	b	LBB1_36
LBB1_15:
Lloh36:
	adrp	x0, l_.str.22@PAGE
Lloh37:
	add	x0, x0, l_.str.22@PAGEOFF
	b	LBB1_36
LBB1_16:
	cbz	w23, LBB1_19
; %bb.17:
	cmp	w8, #1
	b.ge	LBB1_19
; %bb.18:
Lloh38:
	adrp	x0, l_.str.2@PAGE
Lloh39:
	add	x0, x0, l_.str.2@PAGEOFF
	b	LBB1_36
LBB1_19:
	cbz	w21, LBB1_22
; %bb.20:
	cmp	w10, #12
	b.le	LBB1_22
; %bb.21:
Lloh40:
	adrp	x0, l_.str.3@PAGE
Lloh41:
	add	x0, x0, l_.str.3@PAGEOFF
	b	LBB1_36
LBB1_22:
	cbz	w23, LBB1_35
; %bb.23:
	cbz	w21, LBB1_30
; %bb.24:
	cmp	w10, #2
	b.ne	LBB1_32
; %bb.25:
	mov	w12, #29
	cbz	w20, LBB1_28
; %bb.26:
	mov	w13, #34079
	movk	w13, #20971, lsl #16
	smull	x13, w11, w13
	lsr	x14, x13, #63
	asr	x13, x13, #39
	add	w13, w13, w14
	mov	w14, #400
	msub	w13, w13, w14, w11
	cbz	w13, LBB1_28
; %bb.27:
	mov	w12, #23593
	movk	w12, #49807, lsl #16
	mov	w13, #47184
	movk	w13, #1310, lsl #16
	madd	w12, w11, w12, w13
	ror	w12, w12, #2
	and	w13, w11, #0x3
	mov	w14, #23593
	movk	w14, #655, lsl #16
	cmp	w12, w14
	ccmp	w13, #0, #0, hs
	mov	w12, #28
	cinc	w12, w12, eq
LBB1_28:
	cmp	w12, w8
	b.ge	LBB1_35
; %bb.29:
Lloh42:
	adrp	x0, l_.str.5@PAGE
Lloh43:
	add	x0, x0, l_.str.5@PAGEOFF
	b	LBB1_36
LBB1_30:
	cmp	w8, #31
	b.le	LBB1_35
; %bb.31:
Lloh44:
	adrp	x0, l_.str.4@PAGE
Lloh45:
	add	x0, x0, l_.str.4@PAGEOFF
	b	LBB1_36
LBB1_32:
Lloh46:
	adrp	x12, _validate.max_days@PAGE
Lloh47:
	add	x12, x12, _validate.max_days@PAGEOFF
	add	x12, x12, x10, lsl #2
	ldur	w12, [x12, #-4]
	cmp	w12, w8
	b.ge	LBB1_35
; %bb.33:
	sub	w12, w10, #1
	cmp	w12, #12
	b.hs	LBB1_35
; %bb.34:
	mov	w13, #4093
	lsr	w13, w13, w12
	tbnz	w13, #0, LBB1_37
LBB1_35:
	mov	x0, #0
	strh	w11, [x19, #2]
	strb	w10, [x19, #5]
	strb	w8, [x19, #7]
	strb	w24, [x19]
	strb	w25, [x19, #4]
	strb	w9, [x19, #6]
LBB1_36:
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB1_37:
Lloh48:
	adrp	x8, l_switch.table.parse_split@PAGE
Lloh49:
	add	x8, x8, l_switch.table.parse_split@PAGEOFF
	ldr	x0, [x8, w12, sxtw  #3]
	b	LBB1_36
	.loh AdrpAdd	Lloh16, Lloh17
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpAdd	Lloh20, Lloh21
	.loh AdrpAdd	Lloh22, Lloh23
	.loh AdrpAdd	Lloh24, Lloh25
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
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_date                     ; -- Begin function parse_date
	.p2align	2
_parse_date:                            ; @parse_date
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	cbz	x1, LBB2_8
; %bb.1:
	mov	x21, x2
	mov	x22, x1
	mov	x20, x0
	mov	x0, x1
	bl	_strlen
	cmp	x0, #10
	b.ne	LBB2_9
; %bb.2:
	mov	w0, #11
	bl	_malloc
	mov	x19, x0
	mov	x1, x22
	mov	w2, #11
	bl	___strcpy_chk
	strb	w21, [sp, #6]
	strb	wzr, [sp, #7]
	add	x1, sp, #6
	add	x2, sp, #8
	mov	x0, x19
	bl	_strtok_r
	mov	x21, x0
	add	x1, sp, #6
	add	x2, sp, #8
	mov	x0, #0
	bl	_strtok_r
	cbz	x0, LBB2_10
; %bb.3:
	mov	x22, x0
	add	x1, sp, #6
	add	x2, sp, #8
	mov	x0, #0
	bl	_strtok_r
	cbz	x0, LBB2_11
; %bb.4:
	mov	x23, x0
	mov	x0, x21
	bl	_strlen
	cmp	x0, #4
	b.ne	LBB2_12
; %bb.5:
	mov	x0, x22
	bl	_strlen
	cmp	x0, #2
	b.ne	LBB2_13
; %bb.6:
	mov	x0, x23
	bl	_strlen
	cmp	x0, #2
	b.ne	LBB2_14
; %bb.7:
	mov	x0, x20
	mov	x1, x21
	mov	x2, x22
	mov	x3, x23
	bl	_parse_split
	mov	x20, x0
	b	LBB2_15
LBB2_8:
Lloh50:
	adrp	x20, l_.str.23@PAGE
Lloh51:
	add	x20, x20, l_.str.23@PAGEOFF
	b	LBB2_16
LBB2_9:
Lloh52:
	adrp	x20, l_.str.24@PAGE
Lloh53:
	add	x20, x20, l_.str.24@PAGEOFF
	b	LBB2_16
LBB2_10:
Lloh54:
	adrp	x20, l_.str.25@PAGE
Lloh55:
	add	x20, x20, l_.str.25@PAGEOFF
	b	LBB2_15
LBB2_11:
Lloh56:
	adrp	x20, l_.str.26@PAGE
Lloh57:
	add	x20, x20, l_.str.26@PAGEOFF
	b	LBB2_15
LBB2_12:
Lloh58:
	adrp	x20, l_.str.27@PAGE
Lloh59:
	add	x20, x20, l_.str.27@PAGEOFF
	b	LBB2_15
LBB2_13:
Lloh60:
	adrp	x20, l_.str.28@PAGE
Lloh61:
	add	x20, x20, l_.str.28@PAGEOFF
	b	LBB2_15
LBB2_14:
Lloh62:
	adrp	x20, l_.str.29@PAGE
Lloh63:
	add	x20, x20, l_.str.29@PAGEOFF
LBB2_15:
	mov	x0, x19
	bl	_free
LBB2_16:
	mov	x0, x20
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.loh AdrpAdd	Lloh50, Lloh51
	.loh AdrpAdd	Lloh52, Lloh53
	.loh AdrpAdd	Lloh54, Lloh55
	.loh AdrpAdd	Lloh56, Lloh57
	.loh AdrpAdd	Lloh58, Lloh59
	.loh AdrpAdd	Lloh60, Lloh61
	.loh AdrpAdd	Lloh62, Lloh63
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Year must be positive"

l_.str.1:                               ; @.str.1
	.asciz	"Month must be positive"

l_.str.2:                               ; @.str.2
	.asciz	"Day must be positive"

l_.str.3:                               ; @.str.3
	.asciz	"Month cannot be greater than 12"

	.section	__TEXT,__const
	.p2align	2, 0x0                          ; @validate.max_days
_validate.max_days:
	.long	31                              ; 0x1f
	.long	0                               ; 0x0
	.long	31                              ; 0x1f
	.long	30                              ; 0x1e
	.long	31                              ; 0x1f
	.long	30                              ; 0x1e
	.long	31                              ; 0x1f
	.long	31                              ; 0x1f
	.long	30                              ; 0x1e
	.long	31                              ; 0x1f
	.long	30                              ; 0x1e
	.long	31                              ; 0x1f

	.section	__TEXT,__cstring,cstring_literals
l_.str.4:                               ; @.str.4
	.asciz	"Day is invalid for any month"

l_.str.5:                               ; @.str.5
	.asciz	"Day is invalid for February"

l_.str.6:                               ; @.str.6
	.asciz	"Day is invalid for January"

l_.str.7:                               ; @.str.7
	.asciz	"Day is invalid for March"

l_.str.8:                               ; @.str.8
	.asciz	"Day is invalid for April"

l_.str.9:                               ; @.str.9
	.asciz	"Day is invalid for May"

l_.str.10:                              ; @.str.10
	.asciz	"Day is invalid for June"

l_.str.11:                              ; @.str.11
	.asciz	"Day is invalid for July"

l_.str.12:                              ; @.str.12
	.asciz	"Day is invalid for August"

l_.str.13:                              ; @.str.13
	.asciz	"Day is invalid for September"

l_.str.14:                              ; @.str.14
	.asciz	"Day is invalid for October"

l_.str.15:                              ; @.str.15
	.asciz	"Day is invalid for November"

l_.str.16:                              ; @.str.16
	.asciz	"Day is invalid for December"

l_.str.17:                              ; @.str.17
	.asciz	"????"

l_.str.18:                              ; @.str.18
	.asciz	"%d"

l_.str.19:                              ; @.str.19
	.asciz	"Year is not a number"

l_.str.20:                              ; @.str.20
	.asciz	"??"

l_.str.21:                              ; @.str.21
	.asciz	"Month is not a number"

l_.str.22:                              ; @.str.22
	.asciz	"Day is not a number"

l_.str.23:                              ; @.str.23
	.asciz	"No date specified"

l_.str.24:                              ; @.str.24
	.asciz	"Date must be exactly 10 characters"

l_.str.25:                              ; @.str.25
	.asciz	"No month specified"

l_.str.26:                              ; @.str.26
	.asciz	"No day specified"

l_.str.27:                              ; @.str.27
	.asciz	"Year must be exactly 4 digits"

l_.str.28:                              ; @.str.28
	.asciz	"Month must be exactly 2 digits"

l_.str.29:                              ; @.str.29
	.asciz	"Day must be exactly 2 digits"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @switch.table.validate
l_switch.table.validate:
	.quad	l_.str.6
	.quad	0
	.quad	l_.str.7
	.quad	l_.str.8
	.quad	l_.str.9
	.quad	l_.str.10
	.quad	l_.str.11
	.quad	l_.str.12
	.quad	l_.str.13
	.quad	l_.str.14
	.quad	l_.str.15
	.quad	l_.str.16

	.p2align	3, 0x0                          ; @switch.table.parse_split
l_switch.table.parse_split:
	.quad	l_.str.6
	.quad	l_.str.6
	.quad	l_.str.7
	.quad	l_.str.8
	.quad	l_.str.9
	.quad	l_.str.10
	.quad	l_.str.11
	.quad	l_.str.12
	.quad	l_.str.13
	.quad	l_.str.14
	.quad	l_.str.15
	.quad	l_.str.16

.subsections_via_symbols
