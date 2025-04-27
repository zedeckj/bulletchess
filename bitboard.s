	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_print_bitboard                 ; -- Begin function print_bitboard
	.p2align	2
_print_bitboard:                        ; @print_bitboard
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
	mov	x19, x0
	mov	x21, #-72057594037927936
	mov	w22, #8
Lloh0:
	adrp	x20, l_.str@PAGE
Lloh1:
	add	x20, x20, l_.str@PAGEOFF
LBB0_1:                                 ; =>This Inner Loop Header: Depth=1
	and	x23, x21, x19
	tst	x23, #0x101010101010101
	cset	w8, ne
	str	x8, [sp]
	mov	x0, x20
	bl	_printf
	tst	x23, #0x202020202020202
	cset	w8, ne
	str	x8, [sp]
	mov	x0, x20
	bl	_printf
	tst	x23, #0x404040404040404
	cset	w8, ne
	str	x8, [sp]
	mov	x0, x20
	bl	_printf
	tst	x23, #0x808080808080808
	cset	w8, ne
	str	x8, [sp]
	mov	x0, x20
	bl	_printf
	tst	x23, #0x1010101010101010
	cset	w8, ne
	str	x8, [sp]
	mov	x0, x20
	bl	_printf
	tst	x23, #0x2020202020202020
	cset	w8, ne
	str	x8, [sp]
	mov	x0, x20
	bl	_printf
	tst	x23, #0x4040404040404040
	cset	w8, ne
	str	x8, [sp]
	mov	x0, x20
	bl	_printf
	tst	x23, #0x8080808080808080
	cset	w8, ne
	str	x8, [sp]
	mov	x0, x20
	bl	_printf
	mov	w0, #10
	bl	_putchar
	lsr	x21, x21, #8
	subs	w22, w22, #1
	b.ne	LBB0_1
; %bb.2:
	mov	w0, #10
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #80
	b	_putchar
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.globl	_serialize_square               ; -- Begin function serialize_square
	.p2align	2
_serialize_square:                      ; @serialize_square
	.cfi_startproc
; %bb.0:
	cbz	x1, LBB1_2
; %bb.1:
	and	w8, w0, #0x7
	add	w8, w8, #97
	strb	w8, [x1]
	lsr	w8, w0, #3
	add	w8, w8, #49
	strb	w8, [x1, #1]
	strb	wzr, [x1, #2]
LBB1_2:
	cmp	x1, #0
	cset	w0, ne
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_file_char_of_square            ; -- Begin function file_char_of_square
	.p2align	2
_file_char_of_square:                   ; @file_char_of_square
	.cfi_startproc
; %bb.0:
	and	w8, w0, #0x7
	add	w0, w8, #97
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_rank_char_of_square            ; -- Begin function rank_char_of_square
	.p2align	2
_rank_char_of_square:                   ; @rank_char_of_square
	.cfi_startproc
; %bb.0:
	lsr	w8, w0, #3
	add	w0, w8, #49
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count_bits                     ; -- Begin function count_bits
	.p2align	2
_count_bits:                            ; @count_bits
	.cfi_startproc
; %bb.0:
	neg	x8, x0
	ands	x9, x8, x0
	b.eq	LBB4_4
; %bb.1:
	mov	w8, #0
LBB4_2:                                 ; =>This Inner Loop Header: Depth=1
	eor	x0, x9, x0
	add	w8, w8, #1
	neg	x9, x0
	ands	x9, x0, x9
	b.ne	LBB4_2
; %bb.3:
	and	w0, w8, #0xff
	ret
LBB4_4:
	and	w0, wzr, #0xff
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_square_in_bitboard             ; -- Begin function square_in_bitboard
	.p2align	2
_square_in_bitboard:                    ; @square_in_bitboard
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	lsr	x8, x0, x1
	and	w0, w8, #0x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_file_bb_of_square              ; -- Begin function file_bb_of_square
	.p2align	2
_file_bb_of_square:                     ; @file_bb_of_square
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w0 killed $w0 def $x0
	mov	w8, #1
	lsl	x8, x8, x0
	tst	x8, #0x101010101010101
	b.eq	LBB6_2
; %bb.1:
	mov	x0, #72340172838076673
	ret
LBB6_2:
	tst	x8, #0x202020202020202
	b.eq	LBB6_4
; %bb.3:
	mov	x0, #144680345676153346
	ret
LBB6_4:
	tst	x8, #0x8080808080808080
	mov	x9, #-9187201950435737472
	csel	x9, xzr, x9, eq
	tst	x8, #0x4040404040404040
	mov	x10, #4629771061636907072
	csel	x9, x10, x9, ne
	tst	x8, #0x2020202020202020
	mov	x10, #2314885530818453536
	csel	x9, x10, x9, ne
	tst	x8, #0x1010101010101010
	mov	x10, #1157442765409226768
	csel	x9, x10, x9, ne
	tst	x8, #0x808080808080808
	mov	x10, #578721382704613384
	csel	x9, x10, x9, ne
	tst	x8, #0x404040404040404
	mov	x8, #289360691352306692
	csel	x0, x8, x9, ne
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_rank_bb_of_square              ; -- Begin function rank_bb_of_square
	.p2align	2
_rank_bb_of_square:                     ; @rank_bb_of_square
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w0 killed $w0 def $x0
	cmp	w0, #8
	b.lo	LBB7_2
; %bb.1:
	mov	w8, #1
	lsl	x8, x8, x0
	cmp	w0, #56
	mov	x9, #-72057594037927936
	csel	x9, xzr, x9, lo
	tst	x8, #0xff000000000000
	mov	x10, #71776119061217280
	csel	x9, x10, x9, ne
	tst	x8, #0xff0000000000
	mov	x10, #280375465082880
	csel	x9, x10, x9, ne
	tst	x8, #0xff00000000
	mov	x10, #1095216660480
	csel	x9, x10, x9, ne
	tst	x8, #0xff000000
	mov	w10, #-16777216
	csel	x9, x10, x9, ne
	tst	x8, #0xff0000
	mov	w10, #16711680
	csel	x9, x10, x9, ne
	tst	x8, #0xff00
	mov	w8, #65280
	csel	x0, x8, x9, ne
	ret
LBB7_2:
	mov	w0, #255
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_square                   ; -- Begin function parse_square
	.p2align	2
_parse_square:                          ; @parse_square
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB8_5
; %bb.1:
	ldrb	w8, [x0]
	cbz	w8, LBB8_6
; %bb.2:
	ldrb	w9, [x0, #1]
	sub	w10, w9, #49
	cmp	w10, #7
	b.hi	LBB8_5
; %bb.3:
	sub	w10, w8, #65
	cmp	w10, #39
	mov	w11, #1
	lsl	x10, x11, x10
	and	x10, x10, #0xff000000ff
	ccmp	x10, #0, #4, ls
	b.eq	LBB8_5
; %bb.4:
	mov	w10, #55
	mov	w11, #23
	cmp	w8, #96
	csel	w10, w11, w10, hi
	add	w8, w10, w8
	add	w9, w8, w9, lsl #3
	mov	w8, #1
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB8_5:
	mov	w8, #0
LBB8_6:
                                        ; implicit-def: $w9
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_valid_square_chars             ; -- Begin function valid_square_chars
	.p2align	2
_valid_square_chars:                    ; @valid_square_chars
	.cfi_startproc
; %bb.0:
	and	w8, w0, #0xff
	and	w9, w1, #0xff
	sub	w9, w9, #49
	sub	w10, w8, #97
	mov	w11, #1
	sub	w8, w8, #65
	cmp	w8, #8
	cset	w8, lo
	cmp	w10, #8
	csel	w8, w11, w8, lo
	cmp	w9, #7
	csel	w0, wzr, w8, hi
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_make_square                    ; -- Begin function make_square
	.p2align	2
_make_square:                           ; @make_square
	.cfi_startproc
; %bb.0:
	mov	w8, #55
	mov	w9, #23
	cmp	w0, #96
	csel	w8, w9, w8, gt
	add	w8, w8, w0
	add	w8, w8, w1, lsl #3
	and	w0, w8, #0xff
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_from_squares                   ; -- Begin function from_squares
	.p2align	2
_from_squares:                          ; @from_squares
	.cfi_startproc
; %bb.0:
	cbz	w1, LBB11_3
; %bb.1:
	mov	w9, w1
	cmp	w1, #8
	b.hs	LBB11_4
; %bb.2:
	mov	x10, #0
	mov	x8, #0
	b	LBB11_13
LBB11_3:
	mov	x0, #0
	ret
LBB11_4:
	cmp	w1, #16
	b.hs	LBB11_6
; %bb.5:
	mov	x8, #0
	mov	x10, #0
	b	LBB11_10
LBB11_6:
	movi.2d	v0, #0000000000000000
	mov	w8, #1
	dup.2d	v2, x8
	movi.2d	v1, #0000000000000000
	and	x10, x9, #0xf0
	mov	x8, x10
	mov	x11, x0
	movi.2d	v4, #0000000000000000
	movi.2d	v3, #0000000000000000
	movi.2d	v7, #0000000000000000
	movi.2d	v5, #0000000000000000
	movi.2d	v16, #0000000000000000
	movi.2d	v6, #0000000000000000
LBB11_7:                                ; =>This Inner Loop Header: Depth=1
	ldr	q17, [x11], #16
	ushll2.8h	v18, v17, #0
	ushll2.4s	v19, v18, #0
	ushll.2d	v20, v19, #0
	ushll.4s	v18, v18, #0
	ushll2.2d	v21, v18, #0
	ushll.8h	v17, v17, #0
	ushll2.4s	v22, v17, #0
	ushll2.2d	v23, v22, #0
	ushll2.2d	v19, v19, #0
	ushll.2d	v18, v18, #0
	ushll.2d	v22, v22, #0
	ushll.4s	v17, v17, #0
	ushll2.2d	v24, v17, #0
	ushll.2d	v17, v17, #0
	ushl.2d	v17, v2, v17
	ushl.2d	v24, v2, v24
	ushl.2d	v22, v2, v22
	ushl.2d	v18, v2, v18
	ushl.2d	v19, v2, v19
	ushl.2d	v23, v2, v23
	ushl.2d	v21, v2, v21
	ushl.2d	v20, v2, v20
	orr.16b	v16, v20, v16
	orr.16b	v5, v21, v5
	orr.16b	v3, v23, v3
	orr.16b	v6, v19, v6
	orr.16b	v7, v18, v7
	orr.16b	v4, v22, v4
	orr.16b	v1, v24, v1
	orr.16b	v0, v17, v0
	subs	x8, x8, #16
	b.ne	LBB11_7
; %bb.8:
	orr.16b	v0, v0, v7
	orr.16b	v2, v4, v16
	orr.16b	v0, v0, v2
	orr.16b	v1, v1, v5
	orr.16b	v2, v3, v6
	orr.16b	v1, v1, v2
	orr.16b	v0, v0, v1
	ext.16b	v1, v0, v0, #8
	orr.8b	v0, v0, v1
	fmov	x8, d0
	cmp	x10, x9
	b.eq	LBB11_15
; %bb.9:
	tbz	w9, #3, LBB11_13
LBB11_10:
	mov	x11, x10
	and	x10, x9, #0xf8
	movi.2d	v0, #0000000000000000
	movi.2d	v1, #0000000000000000
	mov.d	v1[0], x8
	add	x8, x0, x11
	sub	x11, x11, x10
	mov	w12, #1
	dup.2d	v2, x12
	movi.2d	v3, #0000000000000000
	movi.2d	v4, #0000000000000000
LBB11_11:                               ; =>This Inner Loop Header: Depth=1
	ldr	d5, [x8], #8
	ushll.8h	v5, v5, #0
	ushll2.4s	v6, v5, #0
	ushll2.2d	v7, v6, #0
	ushll.2d	v6, v6, #0
	ushll.4s	v5, v5, #0
	ushll2.2d	v16, v5, #0
	ushll.2d	v5, v5, #0
	ushl.2d	v5, v2, v5
	ushl.2d	v16, v2, v16
	ushl.2d	v6, v2, v6
	ushl.2d	v7, v2, v7
	orr.16b	v4, v7, v4
	orr.16b	v3, v6, v3
	orr.16b	v0, v16, v0
	orr.16b	v1, v5, v1
	adds	x11, x11, #8
	b.ne	LBB11_11
; %bb.12:
	orr.16b	v1, v1, v3
	orr.16b	v0, v0, v4
	orr.16b	v0, v1, v0
	ext.16b	v1, v0, v0, #8
	orr.8b	v0, v0, v1
	fmov	x8, d0
	cmp	x10, x9
	b.eq	LBB11_15
LBB11_13:
	add	x11, x0, x10
	sub	x9, x9, x10
	mov	w10, #1
LBB11_14:                               ; =>This Inner Loop Header: Depth=1
	ldrb	w12, [x11], #1
	lsl	x12, x10, x12
	orr	x8, x12, x8
	subs	x9, x9, #1
	b.ne	LBB11_14
LBB11_15:
	mov	x0, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_bitboard_to_square             ; -- Begin function bitboard_to_square
	.p2align	2
_bitboard_to_square:                    ; @bitboard_to_square
	.cfi_startproc
; %bb.0:
	fmov	d0, x0
	cnt.8b	v0, v0
	uaddlv.8b	h0, v0
	fmov	w8, s0
	cmp	x8, #1
	b.ne	LBB12_9
; %bb.1:
	mov	w8, #2147483647
	cmp	x0, x8
	b.le	LBB12_11
; %bb.2:
	mov	x8, #140737488355327
	cmp	x0, x8
	b.gt	LBB12_18
; %bb.3:
	mov	x8, #549755813887
	cmp	x0, x8
	b.gt	LBB12_30
; %bb.4:
	mov	x8, #34359738367
	cmp	x0, x8
	b.gt	LBB12_48
; %bb.5:
	mov	x8, #8589934591
	cmp	x0, x8
	b.gt	LBB12_76
; %bb.6:
	mov	w8, #-2147483648
	cmp	x0, x8
	b.eq	LBB12_118
; %bb.7:
	mov	x8, #4294967296
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.8:
	mov	w8, #1
	mov	w9, #32
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_9:
	mov	w8, #0
                                        ; implicit-def: $w9
LBB12_10:
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_11:
	cmp	x0, #8, lsl #12                 ; =32768
	b.lt	LBB12_24
; %bb.12:
	cmp	x0, #2048, lsl #12              ; =8388608
	b.ge	LBB12_35
; %bb.13:
	cmp	x0, #128, lsl #12               ; =524288
	b.ge	LBB12_52
; %bb.14:
	cmp	x0, #32, lsl #12                ; =131072
	b.ge	LBB12_79
; %bb.15:
	cmp	x0, #8, lsl #12                 ; =32768
	b.eq	LBB12_119
; %bb.16:
	cmp	x0, #16, lsl #12                ; =65536
	b.ne	LBB12_151
; %bb.17:
	mov	w8, #1
	mov	w9, #16
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_18:
	mov	x8, #36028797018963967
	cmp	x0, x8
	b.gt	LBB12_40
; %bb.19:
	mov	x8, #2251799813685247
	cmp	x0, x8
	b.gt	LBB12_56
; %bb.20:
	mov	x8, #562949953421311
	cmp	x0, x8
	b.gt	LBB12_82
; %bb.21:
	mov	x8, #140737488355328
	cmp	x0, x8
	b.eq	LBB12_120
; %bb.22:
	mov	x8, #281474976710656
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.23:
	mov	w8, #1
	mov	w9, #48
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_24:
	cmp	x0, #127
	b.le	LBB12_45
; %bb.25:
	cmp	x0, #2047
	b.gt	LBB12_60
; %bb.26:
	cmp	x0, #511
	b.gt	LBB12_85
; %bb.27:
	cmp	x0, #128
	b.eq	LBB12_121
; %bb.28:
	cmp	x0, #256
	b.ne	LBB12_151
; %bb.29:
	mov	w8, #1
	mov	w9, #8
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_30:
	mov	x8, #8796093022207
	cmp	x0, x8
	b.gt	LBB12_64
; %bb.31:
	mov	x8, #2199023255551
	cmp	x0, x8
	b.gt	LBB12_88
; %bb.32:
	mov	x8, #549755813888
	cmp	x0, x8
	b.eq	LBB12_122
; %bb.33:
	mov	x8, #1099511627776
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.34:
	mov	w8, #1
	mov	w9, #40
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_35:
	mov	w8, #134217727
	cmp	x0, x8
	b.gt	LBB12_68
; %bb.36:
	mov	w8, #33554431
	cmp	x0, x8
	b.gt	LBB12_91
; %bb.37:
	cmp	x0, #2048, lsl #12              ; =8388608
	b.eq	LBB12_123
; %bb.38:
	mov	w8, #16777216
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.39:
	mov	w8, #1
	mov	w9, #24
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_40:
	mov	x8, #576460752303423487
	cmp	x0, x8
	b.gt	LBB12_72
; %bb.41:
	mov	x8, #144115188075855871
	cmp	x0, x8
	b.gt	LBB12_94
; %bb.42:
	mov	x8, #36028797018963968
	cmp	x0, x8
	b.eq	LBB12_124
; %bb.43:
	mov	x8, #72057594037927936
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.44:
	mov	w8, #1
	mov	w9, #56
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_45:
	sub	x10, x0, #1
	cmp	x10, #63
	b.hi	LBB12_151
; %bb.46:
	mov	w9, #0
	mov	w8, #1
Lloh2:
	adrp	x11, lJTI12_0@PAGE
Lloh3:
	add	x11, x11, lJTI12_0@PAGEOFF
	adr	x12, LBB12_10
	ldrh	w13, [x11, x10, lsl  #1]
	add	x12, x12, x13, lsl #2
	br	x12
LBB12_47:
	mov	w9, #1
	mov	w8, #1
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_48:
	mov	x8, #137438953471
	cmp	x0, x8
	b.gt	LBB12_97
; %bb.49:
	mov	x8, #34359738368
	cmp	x0, x8
	b.eq	LBB12_130
; %bb.50:
	mov	x8, #68719476736
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.51:
	mov	w8, #1
	mov	w9, #36
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_52:
	cmp	x0, #512, lsl #12               ; =2097152
	b.ge	LBB12_100
; %bb.53:
	cmp	x0, #128, lsl #12               ; =524288
	b.eq	LBB12_131
; %bb.54:
	cmp	x0, #256, lsl #12               ; =1048576
	b.ne	LBB12_151
; %bb.55:
	mov	w8, #1
	mov	w9, #20
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_56:
	mov	x8, #9007199254740991
	cmp	x0, x8
	b.gt	LBB12_103
; %bb.57:
	mov	x8, #2251799813685248
	cmp	x0, x8
	b.eq	LBB12_132
; %bb.58:
	mov	x8, #4503599627370496
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.59:
	mov	w8, #1
	mov	w9, #52
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_60:
	cmp	x0, #2, lsl #12                 ; =8192
	b.ge	LBB12_106
; %bb.61:
	cmp	x0, #2048
	b.eq	LBB12_133
; %bb.62:
	cmp	x0, #1, lsl #12                 ; =4096
	b.ne	LBB12_151
; %bb.63:
	mov	w8, #1
	mov	w9, #12
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_64:
	mov	x8, #35184372088831
	cmp	x0, x8
	b.gt	LBB12_109
; %bb.65:
	mov	x8, #8796093022208
	cmp	x0, x8
	b.eq	LBB12_134
; %bb.66:
	mov	x8, #17592186044416
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.67:
	mov	w8, #1
	mov	w9, #44
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_68:
	mov	w8, #536870911
	cmp	x0, x8
	b.gt	LBB12_112
; %bb.69:
	mov	w8, #134217728
	cmp	x0, x8
	b.eq	LBB12_135
; %bb.70:
	mov	w8, #268435456
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.71:
	mov	w8, #1
	mov	w9, #28
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_72:
	mov	x8, #2305843009213693951
	cmp	x0, x8
	b.gt	LBB12_115
; %bb.73:
	mov	x8, #576460752303423488
	cmp	x0, x8
	b.eq	LBB12_136
; %bb.74:
	mov	x8, #1152921504606846976
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.75:
	mov	w8, #1
	mov	w9, #60
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_76:
	mov	x8, #8589934592
	cmp	x0, x8
	b.eq	LBB12_137
; %bb.77:
	mov	x8, #17179869184
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.78:
	mov	w8, #1
	mov	w9, #34
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_79:
	b.eq	LBB12_138
; %bb.80:
	cmp	x0, #64, lsl #12                ; =262144
	b.ne	LBB12_151
; %bb.81:
	mov	w8, #1
	mov	w9, #18
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_82:
	mov	x8, #562949953421312
	cmp	x0, x8
	b.eq	LBB12_139
; %bb.83:
	mov	x8, #1125899906842624
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.84:
	mov	w8, #1
	mov	w9, #50
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_85:
	cmp	x0, #512
	b.eq	LBB12_140
; %bb.86:
	cmp	x0, #1024
	b.ne	LBB12_151
; %bb.87:
	mov	w8, #1
	mov	w9, #10
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_88:
	mov	x8, #2199023255552
	cmp	x0, x8
	b.eq	LBB12_141
; %bb.89:
	mov	x8, #4398046511104
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.90:
	mov	w8, #1
	mov	w9, #42
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_91:
	mov	w8, #33554432
	cmp	x0, x8
	b.eq	LBB12_142
; %bb.92:
	mov	w8, #67108864
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.93:
	mov	w8, #1
	mov	w9, #26
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_94:
	mov	x8, #144115188075855872
	cmp	x0, x8
	b.eq	LBB12_143
; %bb.95:
	mov	x8, #288230376151711744
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.96:
	mov	w8, #1
	mov	w9, #58
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_97:
	mov	x8, #137438953472
	cmp	x0, x8
	b.eq	LBB12_144
; %bb.98:
	mov	x8, #274877906944
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.99:
	mov	w8, #1
	mov	w9, #38
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_100:
	b.eq	LBB12_145
; %bb.101:
	cmp	x0, #1024, lsl #12              ; =4194304
	b.ne	LBB12_151
; %bb.102:
	mov	w8, #1
	mov	w9, #22
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_103:
	mov	x8, #9007199254740992
	cmp	x0, x8
	b.eq	LBB12_146
; %bb.104:
	mov	x8, #18014398509481984
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.105:
	mov	w8, #1
	mov	w9, #54
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_106:
	b.eq	LBB12_147
; %bb.107:
	cmp	x0, #4, lsl #12                 ; =16384
	b.ne	LBB12_151
; %bb.108:
	mov	w8, #1
	mov	w9, #14
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_109:
	mov	x8, #35184372088832
	cmp	x0, x8
	b.eq	LBB12_148
; %bb.110:
	mov	x8, #70368744177664
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.111:
	mov	w8, #1
	mov	w9, #46
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_112:
	mov	w8, #536870912
	cmp	x0, x8
	b.eq	LBB12_149
; %bb.113:
	mov	w8, #1073741824
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.114:
	mov	w8, #1
	mov	w9, #30
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_115:
	mov	x8, #2305843009213693952
	cmp	x0, x8
	b.eq	LBB12_150
; %bb.116:
	mov	x8, #4611686018427387904
	cmp	x0, x8
	b.ne	LBB12_151
; %bb.117:
	mov	w8, #1
	mov	w9, #62
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_118:
	mov	w8, #1
	mov	w9, #31
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_119:
	mov	w8, #1
	mov	w9, #15
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_120:
	mov	w8, #1
	mov	w9, #47
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_121:
	mov	w8, #1
	mov	w9, #7
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_122:
	mov	w8, #1
	mov	w9, #39
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_123:
	mov	w8, #1
	mov	w9, #23
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_124:
	mov	w8, #1
	mov	w9, #55
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_125:
	mov	w8, #1
	mov	w9, #2
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_126:
	mov	w8, #1
	mov	w9, #3
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_127:
	mov	w8, #1
	mov	w9, #4
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_128:
	mov	w8, #1
	mov	w9, #5
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_129:
	mov	w8, #1
	mov	w9, #6
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_130:
	mov	w8, #1
	mov	w9, #35
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_131:
	mov	w8, #1
	mov	w9, #19
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_132:
	mov	w8, #1
	mov	w9, #51
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_133:
	mov	w8, #1
	mov	w9, #11
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_134:
	mov	w8, #1
	mov	w9, #43
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_135:
	mov	w8, #1
	mov	w9, #27
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_136:
	mov	w8, #1
	mov	w9, #59
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_137:
	mov	w8, #1
	mov	w9, #33
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_138:
	mov	w8, #1
	mov	w9, #17
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_139:
	mov	w8, #1
	mov	w9, #49
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_140:
	mov	w8, #1
	mov	w9, #9
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_141:
	mov	w8, #1
	mov	w9, #41
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_142:
	mov	w8, #1
	mov	w9, #25
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_143:
	mov	w8, #1
	mov	w9, #57
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_144:
	mov	w8, #1
	mov	w9, #37
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_145:
	mov	w8, #1
	mov	w9, #21
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_146:
	mov	w8, #1
	mov	w9, #53
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_147:
	mov	w8, #1
	mov	w9, #13
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_148:
	mov	w8, #1
	mov	w9, #45
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_149:
	mov	w8, #1
	mov	w9, #29
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_150:
	mov	w8, #1
	mov	w9, #61
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
LBB12_151:
	mov	w8, #1
	mov	w9, #63
	and	w0, w9, #0xff
	bfi	w0, w8, #8, #1
	ret
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
	.section	__TEXT,__const
	.p2align	1, 0x0
lJTI12_0:
	.short	(LBB12_10-LBB12_10)>>2
	.short	(LBB12_47-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_125-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_126-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_127-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_128-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_151-LBB12_10)>>2
	.short	(LBB12_129-LBB12_10)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_unchecked_bb_to_square         ; -- Begin function unchecked_bb_to_square
	.p2align	2
_unchecked_bb_to_square:                ; @unchecked_bb_to_square
	.cfi_startproc
; %bb.0:
	mov	w8, #2147483647
	cmp	x0, x8
	b.gt	LBB13_6
; %bb.1:
	cmp	x0, #8, lsl #12                 ; =32768
	b.ge	LBB13_13
; %bb.2:
	cmp	x0, #127
	b.gt	LBB13_25
; %bb.3:
	sub	x8, x0, #1
	cmp	x8, #63
	b.hi	LBB13_115
; %bb.4:
	mov	w0, #0
Lloh4:
	adrp	x9, lJTI13_0@PAGE
Lloh5:
	add	x9, x9, lJTI13_0@PAGEOFF
	adr	x10, LBB13_5
	ldrh	w11, [x9, x8, lsl  #1]
	add	x10, x10, x11, lsl #2
	br	x10
LBB13_5:
	mov	w0, #1
	ret
LBB13_6:
	mov	x8, #140737488355327
	cmp	x0, x8
	b.gt	LBB13_19
; %bb.7:
	mov	x8, #549755813887
	cmp	x0, x8
	b.gt	LBB13_30
; %bb.8:
	mov	x8, #34359738367
	cmp	x0, x8
	b.gt	LBB13_45
; %bb.9:
	mov	x8, #8589934591
	cmp	x0, x8
	b.gt	LBB13_73
; %bb.10:
	mov	w8, #-2147483648
	cmp	x0, x8
	b.eq	LBB13_122
; %bb.11:
	mov	x8, #4294967296
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.12:
	mov	w0, #32
	ret
LBB13_13:
	cmp	x0, #2048, lsl #12              ; =8388608
	b.ge	LBB13_35
; %bb.14:
	cmp	x0, #128, lsl #12               ; =524288
	b.ge	LBB13_49
; %bb.15:
	cmp	x0, #32, lsl #12                ; =131072
	b.ge	LBB13_76
; %bb.16:
	cmp	x0, #8, lsl #12                 ; =32768
	b.eq	LBB13_123
; %bb.17:
	cmp	x0, #16, lsl #12                ; =65536
	b.ne	LBB13_150
; %bb.18:
	mov	w0, #16
	ret
LBB13_19:
	mov	x8, #36028797018963967
	cmp	x0, x8
	b.gt	LBB13_40
; %bb.20:
	mov	x8, #2251799813685247
	cmp	x0, x8
	b.gt	LBB13_53
; %bb.21:
	mov	x8, #562949953421311
	cmp	x0, x8
	b.gt	LBB13_79
; %bb.22:
	mov	x8, #140737488355328
	cmp	x0, x8
	b.eq	LBB13_124
; %bb.23:
	mov	x8, #281474976710656
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.24:
	mov	w0, #48
	ret
LBB13_25:
	cmp	x0, #2047
	b.gt	LBB13_57
; %bb.26:
	cmp	x0, #511
	b.gt	LBB13_82
; %bb.27:
	cmp	x0, #128
	b.eq	LBB13_125
; %bb.28:
	cmp	x0, #256
	b.ne	LBB13_150
; %bb.29:
	mov	w0, #8
	ret
LBB13_30:
	mov	x8, #8796093022207
	cmp	x0, x8
	b.gt	LBB13_61
; %bb.31:
	mov	x8, #2199023255551
	cmp	x0, x8
	b.gt	LBB13_85
; %bb.32:
	mov	x8, #549755813888
	cmp	x0, x8
	b.eq	LBB13_126
; %bb.33:
	mov	x8, #1099511627776
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.34:
	mov	w0, #40
	ret
LBB13_35:
	mov	w8, #134217727
	cmp	x0, x8
	b.gt	LBB13_65
; %bb.36:
	mov	w8, #33554431
	cmp	x0, x8
	b.gt	LBB13_88
; %bb.37:
	cmp	x0, #2048, lsl #12              ; =8388608
	b.eq	LBB13_127
; %bb.38:
	mov	w8, #16777216
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.39:
	mov	w0, #24
	ret
LBB13_40:
	mov	x8, #576460752303423487
	cmp	x0, x8
	b.gt	LBB13_69
; %bb.41:
	mov	x8, #144115188075855871
	cmp	x0, x8
	b.gt	LBB13_91
; %bb.42:
	mov	x8, #36028797018963968
	cmp	x0, x8
	b.eq	LBB13_128
; %bb.43:
	mov	x8, #72057594037927936
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.44:
	mov	w0, #56
	ret
LBB13_45:
	mov	x8, #137438953471
	cmp	x0, x8
	b.gt	LBB13_94
; %bb.46:
	mov	x8, #34359738368
	cmp	x0, x8
	b.eq	LBB13_129
; %bb.47:
	mov	x8, #68719476736
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.48:
	mov	w0, #36
	ret
LBB13_49:
	cmp	x0, #512, lsl #12               ; =2097152
	b.ge	LBB13_97
; %bb.50:
	cmp	x0, #128, lsl #12               ; =524288
	b.eq	LBB13_130
; %bb.51:
	cmp	x0, #256, lsl #12               ; =1048576
	b.ne	LBB13_150
; %bb.52:
	mov	w0, #20
	ret
LBB13_53:
	mov	x8, #9007199254740991
	cmp	x0, x8
	b.gt	LBB13_100
; %bb.54:
	mov	x8, #2251799813685248
	cmp	x0, x8
	b.eq	LBB13_131
; %bb.55:
	mov	x8, #4503599627370496
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.56:
	mov	w0, #52
	ret
LBB13_57:
	cmp	x0, #2, lsl #12                 ; =8192
	b.ge	LBB13_103
; %bb.58:
	cmp	x0, #2048
	b.eq	LBB13_132
; %bb.59:
	cmp	x0, #1, lsl #12                 ; =4096
	b.ne	LBB13_150
; %bb.60:
	mov	w0, #12
	ret
LBB13_61:
	mov	x8, #35184372088831
	cmp	x0, x8
	b.gt	LBB13_106
; %bb.62:
	mov	x8, #8796093022208
	cmp	x0, x8
	b.eq	LBB13_133
; %bb.63:
	mov	x8, #17592186044416
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.64:
	mov	w0, #44
	ret
LBB13_65:
	mov	w8, #536870911
	cmp	x0, x8
	b.gt	LBB13_109
; %bb.66:
	mov	w8, #134217728
	cmp	x0, x8
	b.eq	LBB13_134
; %bb.67:
	mov	w8, #268435456
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.68:
	mov	w0, #28
	ret
LBB13_69:
	mov	x8, #2305843009213693951
	cmp	x0, x8
	b.gt	LBB13_112
; %bb.70:
	mov	x8, #576460752303423488
	cmp	x0, x8
	b.eq	LBB13_135
; %bb.71:
	mov	x8, #1152921504606846976
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.72:
	mov	w0, #60
	ret
LBB13_73:
	mov	x8, #8589934592
	cmp	x0, x8
	b.eq	LBB13_136
; %bb.74:
	mov	x8, #17179869184
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.75:
	mov	w0, #34
	ret
LBB13_76:
	b.eq	LBB13_137
; %bb.77:
	cmp	x0, #64, lsl #12                ; =262144
	b.ne	LBB13_150
; %bb.78:
	mov	w0, #18
	ret
LBB13_79:
	mov	x8, #562949953421312
	cmp	x0, x8
	b.eq	LBB13_138
; %bb.80:
	mov	x8, #1125899906842624
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.81:
	mov	w0, #50
	ret
LBB13_82:
	cmp	x0, #512
	b.eq	LBB13_139
; %bb.83:
	cmp	x0, #1024
	b.ne	LBB13_150
; %bb.84:
	mov	w0, #10
	ret
LBB13_85:
	mov	x8, #2199023255552
	cmp	x0, x8
	b.eq	LBB13_140
; %bb.86:
	mov	x8, #4398046511104
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.87:
	mov	w0, #42
	ret
LBB13_88:
	mov	w8, #33554432
	cmp	x0, x8
	b.eq	LBB13_141
; %bb.89:
	mov	w8, #67108864
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.90:
	mov	w0, #26
	ret
LBB13_91:
	mov	x8, #144115188075855872
	cmp	x0, x8
	b.eq	LBB13_142
; %bb.92:
	mov	x8, #288230376151711744
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.93:
	mov	w0, #58
	ret
LBB13_94:
	mov	x8, #137438953472
	cmp	x0, x8
	b.eq	LBB13_143
; %bb.95:
	mov	x8, #274877906944
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.96:
	mov	w0, #38
	ret
LBB13_97:
	b.eq	LBB13_144
; %bb.98:
	cmp	x0, #1024, lsl #12              ; =4194304
	b.ne	LBB13_150
; %bb.99:
	mov	w0, #22
	ret
LBB13_100:
	mov	x8, #9007199254740992
	cmp	x0, x8
	b.eq	LBB13_145
; %bb.101:
	mov	x8, #18014398509481984
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.102:
	mov	w0, #54
	ret
LBB13_103:
	b.eq	LBB13_146
; %bb.104:
	cmp	x0, #4, lsl #12                 ; =16384
	b.ne	LBB13_150
; %bb.105:
	mov	w0, #14
	ret
LBB13_106:
	mov	x8, #35184372088832
	cmp	x0, x8
	b.eq	LBB13_147
; %bb.107:
	mov	x8, #70368744177664
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.108:
	mov	w0, #46
	ret
LBB13_109:
	mov	w8, #536870912
	cmp	x0, x8
	b.eq	LBB13_148
; %bb.110:
	mov	w8, #1073741824
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.111:
	mov	w0, #30
	ret
LBB13_112:
	mov	x8, #2305843009213693952
	cmp	x0, x8
	b.eq	LBB13_149
; %bb.113:
	mov	x8, #4611686018427387904
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.114:
	mov	w0, #62
	ret
LBB13_115:
	mov	x8, #-9223372036854775808
	cmp	x0, x8
	b.ne	LBB13_150
; %bb.116:
	mov	w0, #63
	ret
LBB13_117:
	mov	w0, #2
	ret
LBB13_118:
	mov	w0, #3
	ret
LBB13_119:
	mov	w0, #4
	ret
LBB13_120:
	mov	w0, #5
	ret
LBB13_121:
	mov	w0, #6
	ret
LBB13_122:
	mov	w0, #31
	ret
LBB13_123:
	mov	w0, #15
	ret
LBB13_124:
	mov	w0, #47
	ret
LBB13_125:
	mov	w0, #7
	ret
LBB13_126:
	mov	w0, #39
	ret
LBB13_127:
	mov	w0, #23
	ret
LBB13_128:
	mov	w0, #55
	ret
LBB13_129:
	mov	w0, #35
	ret
LBB13_130:
	mov	w0, #19
	ret
LBB13_131:
	mov	w0, #51
	ret
LBB13_132:
	mov	w0, #11
	ret
LBB13_133:
	mov	w0, #43
	ret
LBB13_134:
	mov	w0, #27
	ret
LBB13_135:
	mov	w0, #59
	ret
LBB13_136:
	mov	w0, #33
	ret
LBB13_137:
	mov	w0, #17
	ret
LBB13_138:
	mov	w0, #49
	ret
LBB13_139:
	mov	w0, #9
	ret
LBB13_140:
	mov	w0, #41
	ret
LBB13_141:
	mov	w0, #25
	ret
LBB13_142:
	mov	w0, #57
	ret
LBB13_143:
	mov	w0, #37
	ret
LBB13_144:
	mov	w0, #21
	ret
LBB13_145:
	mov	w0, #53
	ret
LBB13_146:
	mov	w0, #13
	ret
LBB13_147:
	mov	w0, #45
	ret
LBB13_148:
	mov	w0, #29
	ret
LBB13_149:
	mov	w0, #61
	ret
LBB13_150:
	mov	w0, #255
LBB13_151:
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc
	.section	__TEXT,__const
	.p2align	1, 0x0
lJTI13_0:
	.short	(LBB13_151-LBB13_5)>>2
	.short	(LBB13_5-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_117-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_118-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_119-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_120-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_150-LBB13_5)>>2
	.short	(LBB13_121-LBB13_5)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_above_bb                       ; -- Begin function above_bb
	.p2align	2
_above_bb:                              ; @above_bb
	.cfi_startproc
; %bb.0:
	lsl	x0, x0, #8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_right_bb                       ; -- Begin function right_bb
	.p2align	2
_right_bb:                              ; @right_bb
	.cfi_startproc
; %bb.0:
	lsl	x8, x0, #1
	and	x0, x8, #0xfefefefefefefefe
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_left_bb                        ; -- Begin function left_bb
	.p2align	2
_left_bb:                               ; @left_bb
	.cfi_startproc
; %bb.0:
	lsr	x8, x0, #1
	and	x0, x8, #0x7f7f7f7f7f7f7f7f
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_below_bb                       ; -- Begin function below_bb
	.p2align	2
_below_bb:                              ; @below_bb
	.cfi_startproc
; %bb.0:
	lsr	x0, x0, #8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_bitboard_or                    ; -- Begin function bitboard_or
	.p2align	2
_bitboard_or:                           ; @bitboard_or
	.cfi_startproc
; %bb.0:
	orr	x0, x1, x0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_bitboard_and                   ; -- Begin function bitboard_and
	.p2align	2
_bitboard_and:                          ; @bitboard_and
	.cfi_startproc
; %bb.0:
	and	x0, x1, x0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_bitboard_not                   ; -- Begin function bitboard_not
	.p2align	2
_bitboard_not:                          ; @bitboard_not
	.cfi_startproc
; %bb.0:
	mvn	x0, x0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_bitboard_xor                   ; -- Begin function bitboard_xor
	.p2align	2
_bitboard_xor:                          ; @bitboard_xor
	.cfi_startproc
; %bb.0:
	eor	x0, x1, x0
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"%d "

.subsections_via_symbols
