	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_square_empty                   ; -- Begin function square_empty
	.p2align	2
_square_empty:                          ; @square_empty
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	ldr	x9, [x0, #56]
	mov	w8, #1
	lsl	x8, x8, x1
	tst	x9, x8
	b.eq	LBB0_2
; %bb.1:
	mov	w0, #0
	ret
LBB0_2:
	ldr	x9, [x0, #48]
	tst	x9, x8
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_white_occupies                 ; -- Begin function white_occupies
	.p2align	2
_white_occupies:                        ; @white_occupies
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	ldr	x8, [x0, #48]
	lsr	x8, x8, x1
	and	w0, w8, #0x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_black_occupies                 ; -- Begin function black_occupies
	.p2align	2
_black_occupies:                        ; @black_occupies
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	ldr	x8, [x0, #56]
	lsr	x8, x8, x1
	and	w0, w8, #0x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_color_occupies                 ; -- Begin function color_occupies
	.p2align	2
_color_occupies:                        ; @color_occupies
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	cbz	w2, LBB3_3
; %bb.1:
	cmp	w2, #1
	b.ne	LBB3_4
; %bb.2:
	add	x8, x0, #48
	ldr	x8, [x8]
	lsr	x8, x8, x1
	and	w0, w8, #0x1
	ret
LBB3_3:
	add	x8, x0, #56
	ldr	x8, [x8]
	lsr	x8, x8, x1
	and	w0, w8, #0x1
	ret
LBB3_4:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_en_passant_is                  ; -- Begin function en_passant_is
	.p2align	2
_en_passant_is:                         ; @en_passant_is
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #11]
	cbz	w8, LBB4_2
; %bb.1:
	ldrb	w8, [x0, #10]
	cmp	w8, w1
	cset	w0, eq
	ret
LBB4_2:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_piece_type_bb              ; -- Begin function get_piece_type_bb
	.p2align	2
_get_piece_type_bb:                     ; @get_piece_type_bb
	.cfi_startproc
; %bb.0:
	mov	x8, x0
                                        ; implicit-def: $x0
	cmp	w1, #8
	b.hi	LBB5_8
; %bb.1:
	mov	w9, w1
Lloh0:
	adrp	x10, lJTI5_0@PAGE
Lloh1:
	add	x10, x10, lJTI5_0@PAGEOFF
	adr	x11, LBB5_2
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
                                        ; implicit-def: $x0
	br	x11
LBB5_2:
	ldp	x9, x8, [x8, #48]
	orr	x8, x8, x9
	mvn	x0, x8
	ret
LBB5_3:
	ldr	x0, [x8]
	ret
LBB5_4:
	ldr	x0, [x8, #8]
	ret
LBB5_5:
	ldr	x0, [x8, #16]
	ret
LBB5_6:
	ldr	x0, [x8, #32]
	ret
LBB5_7:
	ldr	x0, [x8, #40]
LBB5_8:
	ret
LBB5_9:
	ldr	x0, [x8, #24]
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
	.section	__TEXT,__const
lJTI5_0:
	.byte	(LBB5_2-LBB5_2)>>2
	.byte	(LBB5_8-LBB5_2)>>2
	.byte	(LBB5_8-LBB5_2)>>2
	.byte	(LBB5_3-LBB5_2)>>2
	.byte	(LBB5_4-LBB5_2)>>2
	.byte	(LBB5_5-LBB5_2)>>2
	.byte	(LBB5_9-LBB5_2)>>2
	.byte	(LBB5_6-LBB5_2)>>2
	.byte	(LBB5_7-LBB5_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_get_piece_bb                   ; -- Begin function get_piece_bb
	.p2align	2
_get_piece_bb:                          ; @get_piece_bb
	.cfi_startproc
; %bb.0:
	ubfx	x9, x1, #8, #8
                                        ; implicit-def: $x8
	cmp	w9, #8
	b.hi	LBB6_9
; %bb.1:
Lloh2:
	adrp	x8, lJTI6_0@PAGE
Lloh3:
	add	x8, x8, lJTI6_0@PAGEOFF
	adr	x10, LBB6_2
	ldrb	w11, [x8, x9]
	add	x10, x10, x11, lsl #2
                                        ; implicit-def: $x8
	br	x10
LBB6_2:
	ldp	x8, x9, [x0, #48]
	orr	x8, x9, x8
	mvn	x8, x8
	b	LBB6_9
LBB6_3:
	ldr	x8, [x0]
	b	LBB6_9
LBB6_4:
	ldr	x8, [x0, #8]
	b	LBB6_9
LBB6_5:
	ldr	x8, [x0, #16]
	b	LBB6_9
LBB6_6:
	ldr	x8, [x0, #32]
	b	LBB6_9
LBB6_7:
	ldr	x8, [x0, #40]
	b	LBB6_9
LBB6_8:
	ldr	x8, [x0, #24]
LBB6_9:
	and	x9, x1, #0xff
	mov	w10, #56
	mov	w11, #48
	cmp	x9, #1
	csel	x9, x11, x10, eq
	ldr	x9, [x0, x9]
	and	x0, x9, x8
	ret
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
	.section	__TEXT,__const
lJTI6_0:
	.byte	(LBB6_2-LBB6_2)>>2
	.byte	(LBB6_9-LBB6_2)>>2
	.byte	(LBB6_9-LBB6_2)>>2
	.byte	(LBB6_3-LBB6_2)>>2
	.byte	(LBB6_4-LBB6_2)>>2
	.byte	(LBB6_5-LBB6_2)>>2
	.byte	(LBB6_8-LBB6_2)>>2
	.byte	(LBB6_6-LBB6_2)>>2
	.byte	(LBB6_7-LBB6_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_get_piece_bb_from_board        ; -- Begin function get_piece_bb_from_board
	.p2align	2
_get_piece_bb_from_board:               ; @get_piece_bb_from_board
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ubfx	x10, x1, #8, #8
                                        ; implicit-def: $x9
	cmp	w10, #8
	b.hi	LBB7_9
; %bb.1:
Lloh4:
	adrp	x9, lJTI7_0@PAGE
Lloh5:
	add	x9, x9, lJTI7_0@PAGEOFF
	adr	x11, LBB7_2
	ldrb	w12, [x9, x10]
	add	x11, x11, x12, lsl #2
                                        ; implicit-def: $x9
	br	x11
LBB7_2:
	ldp	x9, x10, [x8, #48]
	orr	x9, x10, x9
	mvn	x9, x9
	b	LBB7_9
LBB7_3:
	ldr	x9, [x8]
	b	LBB7_9
LBB7_4:
	ldr	x9, [x8, #8]
	b	LBB7_9
LBB7_5:
	ldr	x9, [x8, #16]
	b	LBB7_9
LBB7_6:
	ldr	x9, [x8, #32]
	b	LBB7_9
LBB7_7:
	ldr	x9, [x8, #40]
	b	LBB7_9
LBB7_8:
	ldr	x9, [x8, #24]
LBB7_9:
	and	x10, x1, #0xff
	mov	w11, #56
	mov	w12, #48
	cmp	x10, #1
	csel	x10, x12, x11, eq
	ldr	x8, [x8, x10]
	and	x0, x8, x9
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc
	.section	__TEXT,__const
lJTI7_0:
	.byte	(LBB7_2-LBB7_2)>>2
	.byte	(LBB7_9-LBB7_2)>>2
	.byte	(LBB7_9-LBB7_2)>>2
	.byte	(LBB7_3-LBB7_2)>>2
	.byte	(LBB7_4-LBB7_2)>>2
	.byte	(LBB7_5-LBB7_2)>>2
	.byte	(LBB7_8-LBB7_2)>>2
	.byte	(LBB7_6-LBB7_2)>>2
	.byte	(LBB7_7-LBB7_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_count_piece_type               ; -- Begin function count_piece_type
	.p2align	2
_count_piece_type:                      ; @count_piece_type
	.cfi_startproc
; %bb.0:
	sub	w9, w1, #3
	cmp	w9, #5
	b.hi	LBB8_3
; %bb.1:
	ldr	x8, [x0]
Lloh6:
	adrp	x10, lJTI8_0@PAGE
Lloh7:
	add	x10, x10, lJTI8_0@PAGEOFF
	adr	x11, LBB8_2
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
	br	x11
LBB8_2:
	ldr	x0, [x8, #8]!
	b	_count_bits
LBB8_3:
	mov	w0, #0
	ret
LBB8_4:
	ldr	x0, [x8, #16]!
	b	_count_bits
LBB8_5:
	ldr	x0, [x8, #24]!
	b	_count_bits
LBB8_6:
	ldr	x0, [x8, #32]!
	b	_count_bits
LBB8_7:
	add	x8, x8, #40
LBB8_8:
	ldr	x0, [x8]
	b	_count_bits
	.loh AdrpAdd	Lloh6, Lloh7
	.cfi_endproc
	.section	__TEXT,__const
lJTI8_0:
	.byte	(LBB8_8-LBB8_2)>>2
	.byte	(LBB8_2-LBB8_2)>>2
	.byte	(LBB8_4-LBB8_2)>>2
	.byte	(LBB8_5-LBB8_2)>>2
	.byte	(LBB8_6-LBB8_2)>>2
	.byte	(LBB8_7-LBB8_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_count_color                    ; -- Begin function count_color
	.p2align	2
_count_color:                           ; @count_color
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	cbz	w1, LBB9_3
; %bb.1:
	cmp	w1, #1
	b.ne	LBB9_4
; %bb.2:
	ldr	x0, [x8, #48]!
	b	_count_bits
LBB9_3:
	ldr	x0, [x8, #56]!
	b	_count_bits
LBB9_4:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count_piece                    ; -- Begin function count_piece
	.p2align	2
_count_piece:                           ; @count_piece
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
	ldr	x19, [x0]
	mov	x0, x1
	bl	_index_to_piece
	ubfx	w9, w0, #8, #8
                                        ; implicit-def: $x8
	cmp	w9, #8
	b.hi	LBB10_9
; %bb.1:
Lloh8:
	adrp	x8, lJTI10_0@PAGE
Lloh9:
	add	x8, x8, lJTI10_0@PAGEOFF
	adr	x10, LBB10_2
	ldrb	w11, [x8, x9]
	add	x10, x10, x11, lsl #2
                                        ; implicit-def: $x8
	br	x10
LBB10_2:
	ldp	x8, x9, [x19, #48]
	orr	x8, x9, x8
	mvn	x8, x8
	b	LBB10_9
LBB10_3:
	ldr	x8, [x19]
	b	LBB10_9
LBB10_4:
	ldr	x8, [x19, #8]
	b	LBB10_9
LBB10_5:
	ldr	x8, [x19, #16]
	b	LBB10_9
LBB10_6:
	ldr	x8, [x19, #32]
	b	LBB10_9
LBB10_7:
	ldr	x8, [x19, #40]
	b	LBB10_9
LBB10_8:
	ldr	x8, [x19, #24]
LBB10_9:
	and	w9, w0, #0xff
	cmp	w9, #1
	mov	w9, #56
	mov	w10, #48
	csel	x9, x10, x9, eq
	ldr	x9, [x19, x9]
	and	x0, x9, x8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_count_bits
	.loh AdrpAdd	Lloh8, Lloh9
	.cfi_endproc
	.section	__TEXT,__const
lJTI10_0:
	.byte	(LBB10_2-LBB10_2)>>2
	.byte	(LBB10_9-LBB10_2)>>2
	.byte	(LBB10_9-LBB10_2)>>2
	.byte	(LBB10_3-LBB10_2)>>2
	.byte	(LBB10_4-LBB10_2)>>2
	.byte	(LBB10_5-LBB10_2)>>2
	.byte	(LBB10_8-LBB10_2)>>2
	.byte	(LBB10_6-LBB10_2)>>2
	.byte	(LBB10_7-LBB10_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_net_piece_type                 ; -- Begin function net_piece_type
	.p2align	2
_net_piece_type:                        ; @net_piece_type
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
	ldr	x20, [x0]
                                        ; implicit-def: $x21
	cmp	w1, #8
	b.hi	LBB11_9
; %bb.1:
	mov	w8, w1
Lloh10:
	adrp	x9, lJTI11_0@PAGE
Lloh11:
	add	x9, x9, lJTI11_0@PAGEOFF
	adr	x10, LBB11_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
                                        ; implicit-def: $x21
	br	x10
LBB11_2:
	ldp	x8, x9, [x20, #48]
	orr	x8, x9, x8
	mvn	x21, x8
	b	LBB11_9
LBB11_3:
	ldr	x21, [x20]
	b	LBB11_9
LBB11_4:
	ldr	x21, [x20, #8]
	b	LBB11_9
LBB11_5:
	ldr	x21, [x20, #16]
	b	LBB11_9
LBB11_6:
	ldr	x21, [x20, #32]
	b	LBB11_9
LBB11_7:
	ldr	x21, [x20, #40]
	b	LBB11_9
LBB11_8:
	ldr	x21, [x20, #24]
LBB11_9:
	ldr	x8, [x20, #48]
	and	x0, x8, x21
	bl	_count_bits
	mov	x19, x0
	ldr	x8, [x20, #56]
	and	x0, x8, x21
	bl	_count_bits
	sub	w8, w19, w0
	sxtb	w0, w8
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh10, Lloh11
	.cfi_endproc
	.section	__TEXT,__const
lJTI11_0:
	.byte	(LBB11_2-LBB11_2)>>2
	.byte	(LBB11_9-LBB11_2)>>2
	.byte	(LBB11_9-LBB11_2)>>2
	.byte	(LBB11_3-LBB11_2)>>2
	.byte	(LBB11_4-LBB11_2)>>2
	.byte	(LBB11_5-LBB11_2)>>2
	.byte	(LBB11_8-LBB11_2)>>2
	.byte	(LBB11_6-LBB11_2)>>2
	.byte	(LBB11_7-LBB11_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_write_bitboard                 ; -- Begin function write_bitboard
	.p2align	2
_write_bitboard:                        ; @write_bitboard
	.cfi_startproc
; %bb.0:
	tst	x0, #0x100000000000000
	mov	w8, #48
	cinc	w9, w8, ne
	strb	w9, [x1]
	mov	w9, #32
	strb	w9, [x1, #1]
	tst	x0, #0x200000000000000
	cinc	w10, w8, ne
	strb	w10, [x1, #2]
	strb	w9, [x1, #3]
	tst	x0, #0x400000000000000
	cinc	w10, w8, ne
	strb	w10, [x1, #4]
	strb	w9, [x1, #5]
	tst	x0, #0x800000000000000
	cinc	w10, w8, ne
	strb	w10, [x1, #6]
	strb	w9, [x1, #7]
	tst	x0, #0x1000000000000000
	cinc	w10, w8, ne
	strb	w10, [x1, #8]
	strb	w9, [x1, #9]
	tst	x0, #0x2000000000000000
	cinc	w10, w8, ne
	strb	w10, [x1, #10]
	strb	w9, [x1, #11]
	tst	x0, #0x4000000000000000
	cinc	w10, w8, ne
	strb	w10, [x1, #12]
	strb	w9, [x1, #13]
	cmp	x0, #0
	cinc	w10, w8, lt
	strb	w10, [x1, #14]
	mov	w10, #2592
	sturh	w10, [x1, #15]
	tst	x0, #0x1000000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #17]
	strb	w9, [x1, #18]
	tst	x0, #0x2000000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #19]
	strb	w9, [x1, #20]
	tst	x0, #0x4000000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #21]
	strb	w9, [x1, #22]
	tst	x0, #0x8000000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #23]
	strb	w9, [x1, #24]
	tst	x0, #0x10000000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #25]
	strb	w9, [x1, #26]
	tst	x0, #0x20000000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #27]
	strb	w9, [x1, #28]
	tst	x0, #0x40000000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #29]
	strb	w9, [x1, #30]
	tst	x0, #0x80000000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #31]
	strh	w10, [x1, #32]
	tst	x0, #0x10000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #34]
	strb	w9, [x1, #35]
	tst	x0, #0x20000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #36]
	strb	w9, [x1, #37]
	tst	x0, #0x40000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #38]
	strb	w9, [x1, #39]
	tst	x0, #0x80000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #40]
	strb	w9, [x1, #41]
	tst	x0, #0x100000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #42]
	strb	w9, [x1, #43]
	tst	x0, #0x200000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #44]
	strb	w9, [x1, #45]
	tst	x0, #0x400000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #46]
	strb	w9, [x1, #47]
	tst	x0, #0x800000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #48]
	sturh	w10, [x1, #49]
	tst	x0, #0x100000000
	cinc	w11, w8, ne
	strb	w11, [x1, #51]
	strb	w9, [x1, #52]
	tst	x0, #0x200000000
	cinc	w11, w8, ne
	strb	w11, [x1, #53]
	strb	w9, [x1, #54]
	tst	x0, #0x400000000
	cinc	w11, w8, ne
	strb	w11, [x1, #55]
	strb	w9, [x1, #56]
	tst	x0, #0x800000000
	cinc	w11, w8, ne
	strb	w11, [x1, #57]
	strb	w9, [x1, #58]
	tst	x0, #0x1000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #59]
	strb	w9, [x1, #60]
	tst	x0, #0x2000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #61]
	strb	w9, [x1, #62]
	tst	x0, #0x4000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #63]
	strb	w9, [x1, #64]
	tst	x0, #0x8000000000
	cinc	w11, w8, ne
	strb	w11, [x1, #65]
	strh	w10, [x1, #66]
	tst	x0, #0x1000000
	cinc	w11, w8, ne
	strb	w11, [x1, #68]
	strb	w9, [x1, #69]
	tst	x0, #0x2000000
	cinc	w11, w8, ne
	strb	w11, [x1, #70]
	strb	w9, [x1, #71]
	tst	x0, #0x4000000
	cinc	w11, w8, ne
	strb	w11, [x1, #72]
	strb	w9, [x1, #73]
	tst	x0, #0x8000000
	cinc	w11, w8, ne
	strb	w11, [x1, #74]
	strb	w9, [x1, #75]
	tst	x0, #0x10000000
	cinc	w11, w8, ne
	strb	w11, [x1, #76]
	strb	w9, [x1, #77]
	tst	x0, #0x20000000
	cinc	w11, w8, ne
	strb	w11, [x1, #78]
	strb	w9, [x1, #79]
	tst	x0, #0x40000000
	cinc	w11, w8, ne
	strb	w11, [x1, #80]
	strb	w9, [x1, #81]
	tst	x0, #0x80000000
	cinc	w11, w8, ne
	strb	w11, [x1, #82]
	sturh	w10, [x1, #83]
	tst	x0, #0x10000
	cinc	w11, w8, ne
	strb	w11, [x1, #85]
	strb	w9, [x1, #86]
	tst	x0, #0x20000
	cinc	w11, w8, ne
	strb	w11, [x1, #87]
	strb	w9, [x1, #88]
	tst	x0, #0x40000
	cinc	w11, w8, ne
	strb	w11, [x1, #89]
	strb	w9, [x1, #90]
	tst	x0, #0x80000
	cinc	w11, w8, ne
	strb	w11, [x1, #91]
	strb	w9, [x1, #92]
	tst	x0, #0x100000
	cinc	w11, w8, ne
	strb	w11, [x1, #93]
	strb	w9, [x1, #94]
	tst	x0, #0x200000
	cinc	w11, w8, ne
	strb	w11, [x1, #95]
	strb	w9, [x1, #96]
	tst	x0, #0x400000
	cinc	w11, w8, ne
	strb	w11, [x1, #97]
	strb	w9, [x1, #98]
	tst	x0, #0x800000
	cinc	w11, w8, ne
	strb	w11, [x1, #99]
	strh	w10, [x1, #100]
	tst	x0, #0x100
	cinc	w11, w8, ne
	strb	w11, [x1, #102]
	strb	w9, [x1, #103]
	tst	x0, #0x200
	cinc	w11, w8, ne
	strb	w11, [x1, #104]
	strb	w9, [x1, #105]
	tst	x0, #0x400
	cinc	w11, w8, ne
	strb	w11, [x1, #106]
	strb	w9, [x1, #107]
	tst	x0, #0x800
	cinc	w11, w8, ne
	strb	w11, [x1, #108]
	strb	w9, [x1, #109]
	tst	x0, #0x1000
	cinc	w11, w8, ne
	strb	w11, [x1, #110]
	strb	w9, [x1, #111]
	tst	x0, #0x2000
	cinc	w11, w8, ne
	strb	w11, [x1, #112]
	strb	w9, [x1, #113]
	tst	x0, #0x4000
	cinc	w11, w8, ne
	strb	w11, [x1, #114]
	strb	w9, [x1, #115]
	tst	x0, #0x8000
	cinc	w11, w8, ne
	strb	w11, [x1, #116]
	sturh	w10, [x1, #117]
	tst	x0, #0x1
	cinc	w11, w8, ne
	strb	w11, [x1, #119]
	strb	w9, [x1, #120]
	tst	x0, #0x2
	cinc	w11, w8, ne
	strb	w11, [x1, #121]
	strb	w9, [x1, #122]
	tst	x0, #0x4
	cinc	w11, w8, ne
	strb	w11, [x1, #123]
	strb	w9, [x1, #124]
	tst	x0, #0x8
	cinc	w11, w8, ne
	strb	w11, [x1, #125]
	strb	w9, [x1, #126]
	tst	x0, #0x10
	cinc	w11, w8, ne
	strb	w11, [x1, #127]
	strb	w9, [x1, #128]
	tst	x0, #0x20
	cinc	w11, w8, ne
	strb	w11, [x1, #129]
	strb	w9, [x1, #130]
	tst	x0, #0x40
	cinc	w11, w8, ne
	strb	w11, [x1, #131]
	strb	w9, [x1, #132]
	tst	x0, #0x80
	cinc	w8, w8, ne
	strb	w8, [x1, #133]
	strh	w10, [x1, #134]
	strb	wzr, [x1, #136]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_mask_board_with                ; -- Begin function mask_board_with
	.p2align	2
_mask_board_with:                       ; @mask_board_with
	.cfi_startproc
; %bb.0:
	dup.2d	v0, x1
	ldp	q1, q2, [x0]
	and.16b	v1, v1, v0
	and.16b	v2, v2, v0
	stp	q1, q2, [x0]
	ldp	q1, q2, [x0, #32]
	and.16b	v1, v1, v0
	and.16b	v0, v2, v0
	stp	q1, q0, [x0, #32]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_delete_piece_at                ; -- Begin function delete_piece_at
	.p2align	2
_delete_piece_at:                       ; @delete_piece_at
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	mov	w8, #1
	lsl	x8, x8, x1
	mvn	x8, x8
	dup.2d	v0, x8
	ldp	q1, q2, [x0]
	and.16b	v1, v1, v0
	and.16b	v2, v2, v0
	stp	q1, q2, [x0]
	ldp	q1, q2, [x0, #32]
	and.16b	v1, v1, v0
	and.16b	v0, v2, v0
	stp	q1, q0, [x0, #32]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_delete_piece_at_board          ; -- Begin function delete_piece_at_board
	.p2align	2
_delete_piece_at_board:                 ; @delete_piece_at_board
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w2 killed $w2 def $x2
	ldr	x8, [x0]
	mov	w9, #1
	lsl	x9, x9, x2
	mvn	x9, x9
	dup.2d	v0, x9
	ldp	q1, q2, [x8]
	and.16b	v1, v1, v0
	and.16b	v2, v2, v0
	stp	q1, q2, [x8]
	ldp	q1, q2, [x8, #32]
	and.16b	v1, v1, v0
	and.16b	v0, v2, v0
	stp	q1, q0, [x8, #32]
	cbz	x1, LBB15_2
; %bb.1:
	mov	w8, w2
	strb	wzr, [x1, x8]
LBB15_2:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count_pieces                   ; -- Begin function count_pieces
	.p2align	2
_count_pieces:                          ; @count_pieces
	.cfi_startproc
; %bb.0:
	mov	x17, #0
	mov	w9, #0
	mov	w8, #0
	mov	w15, #0
	mov	w10, #0
	mov	w11, #0
	mov	w12, #0
	mov	w13, #0
	mov	w14, #0
	mov	w16, #0
	mov	w1, #0
	ldr	x2, [x0, #48]
	mov	w3, #1
	b	LBB16_3
LBB16_1:                                ;   in Loop: Header=BB16_3 Depth=1
	add	w10, w10, #1
LBB16_2:                                ;   in Loop: Header=BB16_3 Depth=1
	add	x17, x17, #1
	cmp	x17, #64
	b.eq	LBB16_22
LBB16_3:                                ; =>This Inner Loop Header: Depth=1
	lsl	x4, x3, x17
	tst	x2, x4
	b.eq	LBB16_7
; %bb.4:                                ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0]
	tst	x5, x4
	b.ne	LBB16_1
; %bb.5:                                ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #8]
	tst	x5, x4
	b.eq	LBB16_10
; %bb.6:                                ;   in Loop: Header=BB16_3 Depth=1
	add	w11, w11, #1
	b	LBB16_2
LBB16_7:                                ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #56]
	tst	x5, x4
	b.eq	LBB16_2
; %bb.8:                                ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0]
	tst	x5, x4
	b.eq	LBB16_12
; %bb.9:                                ;   in Loop: Header=BB16_3 Depth=1
	add	w16, w16, #1
	b	LBB16_2
LBB16_10:                               ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #16]
	tst	x5, x4
	b.eq	LBB16_14
; %bb.11:                               ;   in Loop: Header=BB16_3 Depth=1
	add	w12, w12, #1
	b	LBB16_2
LBB16_12:                               ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #8]
	tst	x5, x4
	b.eq	LBB16_16
; %bb.13:                               ;   in Loop: Header=BB16_3 Depth=1
	add	w1, w1, #1
	b	LBB16_2
LBB16_14:                               ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #24]
	tst	x5, x4
	b.eq	LBB16_18
; %bb.15:                               ;   in Loop: Header=BB16_3 Depth=1
	add	w13, w13, #1
	b	LBB16_2
LBB16_16:                               ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #16]
	tst	x5, x4
	b.eq	LBB16_19
; %bb.17:                               ;   in Loop: Header=BB16_3 Depth=1
	add	w15, w15, #1
	b	LBB16_2
LBB16_18:                               ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #32]
	tst	x5, x4
	cinc	w14, w14, ne
	b	LBB16_2
LBB16_19:                               ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #24]
	tst	x5, x4
	b.eq	LBB16_21
; %bb.20:                               ;   in Loop: Header=BB16_3 Depth=1
	add	w8, w8, #1
	b	LBB16_2
LBB16_21:                               ;   in Loop: Header=BB16_3 Depth=1
	ldr	x5, [x0, #32]
	tst	x5, x4
	cinc	w9, w9, ne
	b	LBB16_2
LBB16_22:
	and	w17, w1, #0xff
	lsl	x17, x17, #48
	bfi	x17, x15, #56, #8
	and	w15, w16, #0xff
	bfi	x17, x15, #40, #8
	and	w14, w14, #0xff
	bfi	x17, x14, #32, #8
	and	x13, x13, #0xff
	bfi	x17, x13, #24, #8
	and	x12, x12, #0xff
	and	x11, x11, #0xff
	bfi	x17, x12, #16, #8
	and	x10, x10, #0xff
	bfi	x17, x11, #8, #8
	orr	x0, x17, x10
	and	x9, x9, #0xff
	and	x1, x8, #0xff
	bfi	x1, x9, #8, #8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_counts_match                   ; -- Begin function counts_match
	.p2align	2
_counts_match:                          ; @counts_match
	.cfi_startproc
; %bb.0:
	cmp	w0, #255
	ccmp	w0, w1, #4, ne
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_board_has_counts               ; -- Begin function board_has_counts
	.p2align	2
_board_has_counts:                      ; @board_has_counts
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
	mov	x19, x2
	mov	x20, x1
	and	w21, w20, #0xff
	ldr	x0, [x0]
	bl	_count_pieces
	cmp	w21, #255
	b.eq	LBB18_3
; %bb.1:
	and	w8, w0, #0xff
	cmp	w21, w8
	b.eq	LBB18_3
; %bb.2:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_3:
	ubfx	w8, w20, #8, #8
	cmp	w8, #255
	b.eq	LBB18_6
; %bb.4:
	ubfx	w9, w0, #8, #8
	cmp	w8, w9
	b.eq	LBB18_6
; %bb.5:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_6:
	ubfx	w8, w20, #16, #8
	cmp	w8, #255
	b.eq	LBB18_9
; %bb.7:
	ubfx	w9, w0, #16, #8
	cmp	w8, w9
	b.eq	LBB18_9
; %bb.8:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_9:
	ubfx	x8, x20, #24, #8
	cmp	w8, #255
	b.eq	LBB18_12
; %bb.10:
	ubfx	x9, x0, #24, #8
	cmp	w8, w9
	b.eq	LBB18_12
; %bb.11:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_12:
	ubfx	x8, x20, #32, #8
	cmp	w8, #255
	b.eq	LBB18_15
; %bb.13:
	ubfx	x9, x0, #32, #8
	cmp	w8, w9
	b.eq	LBB18_15
; %bb.14:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_15:
	ubfx	x8, x20, #40, #8
	cmp	w8, #255
	b.eq	LBB18_18
; %bb.16:
	ubfx	x9, x0, #40, #8
	cmp	w8, w9
	b.eq	LBB18_18
; %bb.17:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_18:
	ubfx	x8, x20, #48, #8
	cmp	w8, #255
	b.eq	LBB18_21
; %bb.19:
	ubfx	x9, x0, #48, #8
	cmp	w8, w9
	b.eq	LBB18_21
; %bb.20:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_21:
	lsr	x8, x20, #56
	cmp	w8, #255
	b.eq	LBB18_24
; %bb.22:
	lsr	x9, x0, #56
	cmp	w8, w9
	b.eq	LBB18_24
; %bb.23:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_24:
	and	w8, w19, #0xff
	cmp	w8, #255
	b.eq	LBB18_27
; %bb.25:
	and	w9, w1, #0xff
	cmp	w8, w9
	b.eq	LBB18_27
; %bb.26:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB18_27:
	ubfx	w8, w19, #8, #8
	ubfx	w9, w1, #8, #8
	cmp	w8, #255
	ccmp	w8, w9, #4, ne
	cset	w0, eq
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_filter_boards_from_counts      ; -- Begin function filter_boards_from_counts
	.p2align	2
_filter_boards_from_counts:             ; @filter_boards_from_counts
	.cfi_startproc
; %bb.0:
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
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
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	cbz	x1, LBB19_5
; %bb.1:
	mov	x19, x4
	mov	x20, x2
	mov	x21, x1
	mov	x23, x0
	mov	x22, #0
	and	x24, x3, #0xffff
	b	LBB19_3
LBB19_2:                                ;   in Loop: Header=BB19_3 Depth=1
	add	x23, x23, #8
	subs	x21, x21, #1
	b.eq	LBB19_6
LBB19_3:                                ; =>This Inner Loop Header: Depth=1
	ldr	x25, [x23]
	mov	x0, x25
	mov	x1, x20
	mov	x2, x24
	bl	_board_has_counts
	cbz	w0, LBB19_2
; %bb.4:                                ;   in Loop: Header=BB19_3 Depth=1
	str	x25, [x19, x22, lsl  #3]
	add	x22, x22, #1
	b	LBB19_2
LBB19_5:
	mov	x22, #0
LBB19_6:
	mov	x0, x22
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_contains_piece                 ; -- Begin function contains_piece
	.p2align	2
_contains_piece:                        ; @contains_piece
	.cfi_startproc
; %bb.0:
	tst	x1, #0xff00
	b.eq	LBB20_4
; %bb.1:
	and	x8, x1, #0xff
	mov	w9, #56
	mov	w10, #48
	cmp	x8, #1
	csel	x8, x10, x9, eq
	ldr	x8, [x0, x8]
	ubfx	w9, w1, #8, #8
	sub	w9, w9, #3
	cmp	w9, #4
	b.hi	LBB20_5
; %bb.2:
Lloh12:
	adrp	x10, lJTI20_0@PAGE
Lloh13:
	add	x10, x10, lJTI20_0@PAGEOFF
	adr	x11, LBB20_3
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
	br	x11
LBB20_3:
	ldr	x9, [x0, #8]!
	and	x8, x9, x8
	cmp	x8, #0
	cset	w0, ne
	ret
LBB20_4:
	ldp	x9, x8, [x0, #48]
	and	x8, x9, x8
	mvn	x8, x8
	cmp	x8, #0
	cset	w0, ne
	ret
LBB20_5:
	add	x0, x0, #40
LBB20_6:
	ldr	x9, [x0]
	and	x8, x9, x8
	cmp	x8, #0
	cset	w0, ne
	ret
LBB20_7:
	ldr	x9, [x0, #16]!
	and	x8, x9, x8
	cmp	x8, #0
	cset	w0, ne
	ret
LBB20_8:
	ldr	x9, [x0, #24]!
	and	x8, x9, x8
	cmp	x8, #0
	cset	w0, ne
	ret
LBB20_9:
	ldr	x9, [x0, #32]!
	and	x8, x9, x8
	cmp	x8, #0
	cset	w0, ne
	ret
	.loh AdrpAdd	Lloh12, Lloh13
	.cfi_endproc
	.section	__TEXT,__const
lJTI20_0:
	.byte	(LBB20_6-LBB20_3)>>2
	.byte	(LBB20_3-LBB20_3)>>2
	.byte	(LBB20_7-LBB20_3)>>2
	.byte	(LBB20_8-LBB20_3)>>2
	.byte	(LBB20_9-LBB20_3)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_contains_piece_index           ; -- Begin function contains_piece_index
	.p2align	2
_contains_piece_index:                  ; @contains_piece_index
	.cfi_startproc
; %bb.0:
	cmp	w1, #12
	b.hi	LBB21_3
; %bb.1:
	ldr	x8, [x0]
	mov	w9, w1
Lloh14:
	adrp	x10, lJTI21_0@PAGE
Lloh15:
	add	x10, x10, lJTI21_0@PAGEOFF
	adr	x11, LBB21_2
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
	br	x11
LBB21_2:
	ldp	x9, x8, [x8, #48]
	orr	x8, x8, x9
	cmn	x8, #1
	cset	w0, ne
	ret
LBB21_3:
	mov	w0, #0
	ret
LBB21_4:
	ldr	x9, [x8, #48]
	ldr	x8, [x8]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_5:
	ldr	x9, [x8, #48]
	ldr	x8, [x8, #8]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_6:
	ldr	x9, [x8, #48]
	ldr	x8, [x8, #16]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_7:
	ldr	x9, [x8, #48]
	ldr	x8, [x8, #24]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_8:
	ldr	x9, [x8, #48]
	ldr	x8, [x8, #32]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_9:
	ldp	x8, x9, [x8, #40]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_10:
	ldr	x9, [x8, #56]
	ldr	x8, [x8]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_11:
	ldr	x9, [x8, #56]
	ldr	x8, [x8, #8]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_12:
	ldr	x9, [x8, #56]
	ldr	x8, [x8, #16]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_13:
	ldr	x9, [x8, #56]
	ldr	x8, [x8, #24]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_14:
	ldr	x9, [x8, #56]
	ldr	x8, [x8, #32]
	tst	x8, x9
	cset	w0, ne
	ret
LBB21_15:
	ldr	x9, [x8, #56]
	ldr	x8, [x8, #40]
	tst	x8, x9
	cset	w0, ne
	ret
	.loh AdrpAdd	Lloh14, Lloh15
	.cfi_endproc
	.section	__TEXT,__const
lJTI21_0:
	.byte	(LBB21_2-LBB21_2)>>2
	.byte	(LBB21_4-LBB21_2)>>2
	.byte	(LBB21_5-LBB21_2)>>2
	.byte	(LBB21_6-LBB21_2)>>2
	.byte	(LBB21_7-LBB21_2)>>2
	.byte	(LBB21_8-LBB21_2)>>2
	.byte	(LBB21_9-LBB21_2)>>2
	.byte	(LBB21_10-LBB21_2)>>2
	.byte	(LBB21_11-LBB21_2)>>2
	.byte	(LBB21_12-LBB21_2)>>2
	.byte	(LBB21_13-LBB21_2)>>2
	.byte	(LBB21_14-LBB21_2)>>2
	.byte	(LBB21_15-LBB21_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_is_subset                      ; -- Begin function is_subset
	.p2align	2
_is_subset:                             ; @is_subset
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0, #48]
	ldr	x9, [x1, #48]
	bics	xzr, x8, x9
	b.ne	LBB22_8
; %bb.1:
	ldr	x8, [x0, #56]
	ldr	x9, [x1, #56]
	bics	xzr, x8, x9
	b.ne	LBB22_8
; %bb.2:
	ldr	x8, [x0]
	ldr	x9, [x1]
	bics	xzr, x8, x9
	b.ne	LBB22_8
; %bb.3:
	ldr	x8, [x0, #8]
	ldr	x9, [x1, #8]
	bics	xzr, x8, x9
	b.ne	LBB22_8
; %bb.4:
	ldr	x8, [x0, #16]
	ldr	x9, [x1, #16]
	bics	xzr, x8, x9
	b.ne	LBB22_8
; %bb.5:
	ldr	x8, [x0, #24]
	ldr	x9, [x1, #24]
	bics	xzr, x8, x9
	b.ne	LBB22_8
; %bb.6:
	ldr	x8, [x0, #32]
	ldr	x9, [x1, #32]
	bics	xzr, x8, x9
	b.ne	LBB22_8
; %bb.7:
	ldr	x8, [x0, #40]
	ldr	x9, [x1, #40]
	bics	xzr, x8, x9
	cset	w0, eq
	ret
LBB22_8:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_positions_equal                ; -- Begin function positions_equal
	.p2align	2
_positions_equal:                       ; @positions_equal
	.cfi_startproc
; %bb.0:
	mov	w8, #0
	cbz	x0, LBB23_10
; %bb.1:
	cbz	x1, LBB23_10
; %bb.2:
	ldr	x8, [x0, #56]
	ldr	x9, [x1, #56]
	cmp	x8, x9
	b.ne	LBB23_11
; %bb.3:
	ldr	x8, [x0, #48]
	ldr	x9, [x1, #48]
	cmp	x8, x9
	b.ne	LBB23_11
; %bb.4:
	ldr	x8, [x0]
	ldr	x9, [x1]
	cmp	x8, x9
	b.ne	LBB23_11
; %bb.5:
	ldr	x8, [x0, #8]
	ldr	x9, [x1, #8]
	cmp	x8, x9
	b.ne	LBB23_11
; %bb.6:
	ldr	x8, [x0, #16]
	ldr	x9, [x1, #16]
	cmp	x8, x9
	b.ne	LBB23_11
; %bb.7:
	ldr	x8, [x0, #32]
	ldr	x9, [x1, #32]
	cmp	x8, x9
	b.ne	LBB23_11
; %bb.8:
	ldr	x8, [x0, #24]
	ldr	x9, [x1, #24]
	cmp	x8, x9
	b.ne	LBB23_11
; %bb.9:
	ldr	x8, [x0, #40]
	ldr	x9, [x1, #40]
	cmp	x8, x9
	cset	w8, eq
LBB23_10:
	mov	x0, x8
	ret
LBB23_11:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_boards_legally_equal           ; -- Begin function boards_legally_equal
	.p2align	2
_boards_legally_equal:                  ; @boards_legally_equal
	.cfi_startproc
; %bb.0:
	mov	w8, #0
	cbz	x0, LBB24_16
; %bb.1:
	cbz	x1, LBB24_16
; %bb.2:
	ldrb	w8, [x0, #9]
	ldrb	w9, [x1, #9]
	cmp	w8, w9
	b.ne	LBB24_17
; %bb.3:
	ldrb	w8, [x0, #8]
	ldrb	w9, [x1, #8]
	cmp	w8, w9
	b.ne	LBB24_17
; %bb.4:
	mov	w8, #0
	ldr	x9, [x0]
	cbz	x9, LBB24_16
; %bb.5:
	ldr	x10, [x1]
	cbz	x10, LBB24_16
; %bb.6:
	ldr	x8, [x9, #56]
	ldr	x11, [x10, #56]
	cmp	x8, x11
	b.ne	LBB24_17
; %bb.7:
	ldr	x8, [x9, #48]
	ldr	x11, [x10, #48]
	cmp	x8, x11
	b.ne	LBB24_17
; %bb.8:
	ldr	x8, [x9]
	ldr	x11, [x10]
	cmp	x8, x11
	b.ne	LBB24_17
; %bb.9:
	ldr	x8, [x9, #8]
	ldr	x11, [x10, #8]
	cmp	x8, x11
	b.ne	LBB24_17
; %bb.10:
	ldr	x8, [x9, #16]
	ldr	x11, [x10, #16]
	cmp	x8, x11
	b.ne	LBB24_17
; %bb.11:
	ldr	x8, [x9, #32]
	ldr	x11, [x10, #32]
	cmp	x8, x11
	b.ne	LBB24_17
; %bb.12:
	ldr	x8, [x9, #24]
	ldr	x11, [x10, #24]
	cmp	x8, x11
	b.ne	LBB24_17
; %bb.13:
	ldr	x8, [x9, #40]
	ldr	x9, [x10, #40]
	cmp	x8, x9
	b.ne	LBB24_17
; %bb.14:
	ldrb	w9, [x0, #11]
	ldrb	w8, [x1, #11]
	tbnz	w9, #0, LBB24_18
; %bb.15:
	tst	w8, #0x1
	cset	w8, eq
LBB24_16:
	mov	x0, x8
	ret
LBB24_17:
	mov	w0, #0
	ret
LBB24_18:
	ldrb	w9, [x1, #10]
	ldrb	w10, [x0, #10]
	cmp	w10, w9
	cset	w9, eq
	and	w0, w8, w9
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_boards_equal                   ; -- Begin function boards_equal
	.p2align	2
_boards_equal:                          ; @boards_equal
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
	mov	x19, x1
	mov	x20, x0
	bl	_boards_legally_equal
	cbz	w0, LBB25_3
; %bb.1:
	ldrh	w8, [x20, #12]
	ldrh	w9, [x19, #12]
	cmp	w8, w9
	b.ne	LBB25_4
; %bb.2:
	ldrh	w8, [x20, #14]
	ldrh	w9, [x19, #14]
	cmp	w8, w9
	cset	w0, eq
LBB25_3:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB25_4:
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_board_has_pattern              ; -- Begin function board_has_pattern
	.p2align	2
_board_has_pattern:                     ; @board_has_pattern
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
	ldr	x8, [x0]
	ubfx	x10, x1, #8, #8
                                        ; implicit-def: $x9
	cmp	w10, #8
	b.hi	LBB26_9
; %bb.1:
Lloh16:
	adrp	x9, lJTI26_0@PAGE
Lloh17:
	add	x9, x9, lJTI26_0@PAGEOFF
	adr	x11, LBB26_2
	ldrb	w12, [x9, x10]
	add	x11, x11, x12, lsl #2
                                        ; implicit-def: $x9
	br	x11
LBB26_2:
	ldp	x9, x10, [x8, #48]
	orr	x9, x10, x9
	mvn	x9, x9
	b	LBB26_9
LBB26_3:
	ldr	x9, [x8]
	b	LBB26_9
LBB26_4:
	ldr	x9, [x8, #8]
	b	LBB26_9
LBB26_5:
	ldr	x9, [x8, #16]
	b	LBB26_9
LBB26_6:
	ldr	x9, [x8, #32]
	b	LBB26_9
LBB26_7:
	ldr	x9, [x8, #40]
	b	LBB26_9
LBB26_8:
	ldr	x9, [x8, #24]
LBB26_9:
	and	x10, x1, #0xff
	mov	w11, #56
	mov	w12, #48
	cmp	x10, #1
	csel	x10, x12, x11, eq
	ldr	x8, [x8, x10]
	and	x0, x8, x9
	ubfx	w8, w1, #16, #8
	cmp	w8, #2
	b.eq	LBB26_12
; %bb.10:
	cmp	w8, #1
	b.ne	LBB26_13
; %bb.11:
	bl	_count_bits
	cmp	w0, w19, uxtb
	cset	w0, eq
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB26_12:
	cmp	x0, x19
	cset	w0, eq
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB26_13:
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh16, Lloh17
	.cfi_endproc
	.section	__TEXT,__const
lJTI26_0:
	.byte	(LBB26_2-LBB26_2)>>2
	.byte	(LBB26_9-LBB26_2)>>2
	.byte	(LBB26_9-LBB26_2)>>2
	.byte	(LBB26_3-LBB26_2)>>2
	.byte	(LBB26_4-LBB26_2)>>2
	.byte	(LBB26_5-LBB26_2)>>2
	.byte	(LBB26_8-LBB26_2)>>2
	.byte	(LBB26_6-LBB26_2)>>2
	.byte	(LBB26_7-LBB26_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_board_has_patterns             ; -- Begin function board_has_patterns
	.p2align	2
_board_has_patterns:                    ; @board_has_patterns
	.cfi_startproc
; %bb.0:
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
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
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	cbz	x2, LBB27_16
; %bb.1:
	mov	x19, x2
	mov	x20, x0
	add	x21, x1, #8
	mov	w22, #1
	mov	w23, #56
	mov	w24, #48
Lloh18:
	adrp	x25, lJTI27_0@PAGE
Lloh19:
	add	x25, x25, lJTI27_0@PAGEOFF
	b	LBB27_4
LBB27_2:                                ;   in Loop: Header=BB27_4 Depth=1
	cmp	x0, x26
LBB27_3:                                ;   in Loop: Header=BB27_4 Depth=1
	cset	w0, eq
	cmp	w0, #0
	ccmp	x22, x19, #2, ne
	add	x22, x22, #1
	add	x21, x21, #16
	b.hs	LBB27_17
LBB27_4:                                ; =>This Inner Loop Header: Depth=1
	ldp	x8, x26, [x21, #-8]
	ldr	x9, [x20]
	ubfx	x11, x8, #8, #8
                                        ; implicit-def: $x10
	cmp	w11, #8
	b.hi	LBB27_13
; %bb.5:                                ;   in Loop: Header=BB27_4 Depth=1
	adr	x12, LBB27_6
	ldrb	w10, [x25, x11]
	add	x12, x12, x10, lsl #2
                                        ; implicit-def: $x10
	br	x12
LBB27_6:                                ;   in Loop: Header=BB27_4 Depth=1
	ldp	x10, x11, [x9, #48]
	orr	x10, x11, x10
	mvn	x10, x10
	b	LBB27_13
LBB27_7:                                ;   in Loop: Header=BB27_4 Depth=1
	ldr	x10, [x9]
	b	LBB27_13
LBB27_8:                                ;   in Loop: Header=BB27_4 Depth=1
	ldr	x10, [x9, #32]
	b	LBB27_13
LBB27_9:                                ;   in Loop: Header=BB27_4 Depth=1
	ldr	x10, [x9, #8]
	b	LBB27_13
LBB27_10:                               ;   in Loop: Header=BB27_4 Depth=1
	ldr	x10, [x9, #16]
	b	LBB27_13
LBB27_11:                               ;   in Loop: Header=BB27_4 Depth=1
	ldr	x10, [x9, #24]
	b	LBB27_13
LBB27_12:                               ;   in Loop: Header=BB27_4 Depth=1
	ldr	x10, [x9, #40]
LBB27_13:                               ;   in Loop: Header=BB27_4 Depth=1
	and	x11, x8, #0xff
	cmp	x11, #1
	csel	x11, x24, x23, eq
	ldr	x9, [x9, x11]
	and	x0, x9, x10
	ubfx	w8, w8, #16, #8
	cmp	w8, #2
	b.eq	LBB27_2
; %bb.14:                               ;   in Loop: Header=BB27_4 Depth=1
	cmp	w8, #1
	b.ne	LBB27_18
; %bb.15:                               ;   in Loop: Header=BB27_4 Depth=1
	bl	_count_bits
	cmp	w0, w26, uxtb
	b	LBB27_3
LBB27_16:
	mov	w0, #1
LBB27_17:
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
LBB27_18:
	mov	w0, #0
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh18, Lloh19
	.cfi_endproc
	.section	__TEXT,__const
lJTI27_0:
	.byte	(LBB27_6-LBB27_6)>>2
	.byte	(LBB27_13-LBB27_6)>>2
	.byte	(LBB27_13-LBB27_6)>>2
	.byte	(LBB27_7-LBB27_6)>>2
	.byte	(LBB27_9-LBB27_6)>>2
	.byte	(LBB27_10-LBB27_6)>>2
	.byte	(LBB27_11-LBB27_6)>>2
	.byte	(LBB27_8-LBB27_6)>>2
	.byte	(LBB27_12-LBB27_6)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_squares_with_piece             ; -- Begin function squares_with_piece
	.p2align	2
_squares_with_piece:                    ; @squares_with_piece
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ubfx	x9, x1, #8, #8
                                        ; implicit-def: $x11
	cmp	w9, #8
	b.hi	LBB28_9
; %bb.1:
Lloh20:
	adrp	x10, lJTI28_0@PAGE
Lloh21:
	add	x10, x10, lJTI28_0@PAGEOFF
	adr	x12, LBB28_2
	ldrb	w11, [x10, x9]
	add	x12, x12, x11, lsl #2
                                        ; implicit-def: $x11
	br	x12
LBB28_2:
	ldp	x9, x10, [x8, #48]
	orr	x9, x10, x9
	mvn	x11, x9
	b	LBB28_9
LBB28_3:
	ldr	x11, [x8]
	b	LBB28_9
LBB28_4:
	ldr	x11, [x8, #8]
	b	LBB28_9
LBB28_5:
	ldr	x11, [x8, #16]
	b	LBB28_9
LBB28_6:
	ldr	x11, [x8, #32]
	b	LBB28_9
LBB28_7:
	ldr	x11, [x8, #40]
	b	LBB28_9
LBB28_8:
	ldr	x11, [x8, #24]
LBB28_9:
	mov	x9, #0
	mov	w10, #0
	and	x12, x1, #0xff
	mov	w13, #56
	mov	w14, #48
	cmp	x12, #1
	csel	x12, x14, x13, eq
	ldr	x8, [x8, x12]
	and	x8, x8, x11
	b	LBB28_11
LBB28_10:                               ;   in Loop: Header=BB28_11 Depth=1
	add	x9, x9, #1
	cmp	x9, #64
	b.eq	LBB28_13
LBB28_11:                               ; =>This Inner Loop Header: Depth=1
	lsr	x11, x8, x9
	tbz	w11, #0, LBB28_10
; %bb.12:                               ;   in Loop: Header=BB28_11 Depth=1
	and	x11, x10, #0xff
	add	w10, w10, #1
	strb	w9, [x2, x11]
                                        ; kill: def $w10 killed $w10 def $x10
	b	LBB28_10
LBB28_13:
	and	w0, w10, #0xff
	ret
	.loh AdrpAdd	Lloh20, Lloh21
	.cfi_endproc
	.section	__TEXT,__const
lJTI28_0:
	.byte	(LBB28_2-LBB28_2)>>2
	.byte	(LBB28_9-LBB28_2)>>2
	.byte	(LBB28_9-LBB28_2)>>2
	.byte	(LBB28_3-LBB28_2)>>2
	.byte	(LBB28_4-LBB28_2)>>2
	.byte	(LBB28_5-LBB28_2)>>2
	.byte	(LBB28_8-LBB28_2)>>2
	.byte	(LBB28_6-LBB28_2)>>2
	.byte	(LBB28_7-LBB28_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_index_into                     ; -- Begin function index_into
	.p2align	2
_index_into:                            ; @index_into
	.cfi_startproc
; %bb.0:
	ldrb	w0, [x0, w1, uxtw]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_copy_into                      ; -- Begin function copy_into
	.p2align	2
_copy_into:                             ; @copy_into
	.cfi_startproc
; %bb.0:
	ldrh	w8, [x1, #8]
	strh	w8, [x0, #8]
	ldrh	w8, [x1, #10]
	strh	w8, [x0, #10]
	ldr	w8, [x1, #12]
	str	w8, [x0, #12]
	ldr	x8, [x1]
	ldr	x9, [x0]
	ldr	q0, [x8]
	str	q0, [x9]
	ldr	q0, [x8, #16]
	str	q0, [x9, #16]
	ldr	q0, [x8, #32]
	str	q0, [x9, #32]
	ldr	q0, [x8, #48]
	str	q0, [x9, #48]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_set_piece_at                   ; -- Begin function set_piece_at
	.p2align	2
_set_piece_at:                          ; @set_piece_at
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	mov	w9, #1
	mov	x8, x0
	ldr	x11, [x8, #56]!
	lsl	x9, x9, x1
	mov	x10, x8
	ldr	x12, [x10, #-8]!
	orr	x13, x11, x12
	tst	x13, x9
	b.eq	LBB31_2
; %bb.1:
	mvn	x13, x9
	dup.2d	v0, x13
	ldp	q2, q1, [x0, #16]
	and.16b	v3, v1, v0
	ldr	q1, [x0]
	and.16b	v1, v1, v0
	and.16b	v0, v2, v0
	str	q1, [x0]
	stp	q0, q3, [x0, #16]
	bic	x12, x12, x9
	bic	x11, x11, x9
	stp	x12, x11, [x0, #48]
LBB31_2:
	ubfx	x13, x2, #8, #8
	cmp	w13, #8
	b.hi	LBB31_10
; %bb.3:
Lloh22:
	adrp	x14, lJTI31_0@PAGE
Lloh23:
	add	x14, x14, lJTI31_0@PAGEOFF
	adr	x15, LBB31_4
	ldrb	w16, [x14, x13]
	add	x15, x15, x16, lsl #2
	br	x15
LBB31_4:
	add	x0, x0, #8
	b	LBB31_9
LBB31_5:
	add	x0, x0, #16
	b	LBB31_9
LBB31_6:
	add	x0, x0, #32
	b	LBB31_9
LBB31_7:
	add	x0, x0, #40
	b	LBB31_9
LBB31_8:
	add	x0, x0, #24
LBB31_9:
	ldr	x13, [x0]
	orr	x13, x13, x9
	str	x13, [x0]
LBB31_10:
	and	x13, x2, #0xff
	cmp	x13, #1
	csel	x11, x12, x11, eq
	csel	x8, x10, x8, eq
	orr	x9, x11, x9
	str	x9, [x8]
LBB31_11:
	ret
	.loh AdrpAdd	Lloh22, Lloh23
	.cfi_endproc
	.section	__TEXT,__const
lJTI31_0:
	.byte	(LBB31_11-LBB31_4)>>2
	.byte	(LBB31_10-LBB31_4)>>2
	.byte	(LBB31_10-LBB31_4)>>2
	.byte	(LBB31_9-LBB31_4)>>2
	.byte	(LBB31_4-LBB31_4)>>2
	.byte	(LBB31_5-LBB31_4)>>2
	.byte	(LBB31_8-LBB31_4)>>2
	.byte	(LBB31_6-LBB31_4)>>2
	.byte	(LBB31_7-LBB31_4)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_set_piece_index                ; -- Begin function set_piece_index
	.p2align	2
_set_piece_index:                       ; @set_piece_index
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
	mov	x19, x3
	mov	x21, x2
	mov	x20, x1
	mov	x22, x0
	mov	x0, x3
	bl	_index_to_piece
	ldr	x8, [x22]
	mov	w10, #1
	mov	x9, x8
	ldr	x12, [x9, #56]!
	lsl	x10, x10, x21
	mov	x11, x8
	ldr	x13, [x11, #48]!
	orr	x14, x12, x13
	tst	x14, x10
	b.eq	LBB32_2
; %bb.1:
	mvn	x14, x10
	dup.2d	v0, x14
	ldp	q2, q1, [x8, #16]
	and.16b	v3, v1, v0
	ldr	q1, [x8]
	and.16b	v1, v1, v0
	and.16b	v0, v2, v0
	str	q1, [x8]
	stp	q0, q3, [x8, #16]
	bic	x13, x13, x10
	bic	x12, x12, x10
	stp	x13, x12, [x8, #48]
LBB32_2:
	ubfx	w14, w0, #8, #8
	cmp	w14, #8
	b.hi	LBB32_10
; %bb.3:
Lloh24:
	adrp	x15, lJTI32_0@PAGE
Lloh25:
	add	x15, x15, lJTI32_0@PAGEOFF
	adr	x16, LBB32_4
	ldrb	w17, [x15, x14]
	add	x16, x16, x17, lsl #2
	br	x16
LBB32_4:
	add	x8, x8, #8
	b	LBB32_9
LBB32_5:
	add	x8, x8, #16
	b	LBB32_9
LBB32_6:
	add	x8, x8, #32
	b	LBB32_9
LBB32_7:
	add	x8, x8, #40
	b	LBB32_9
LBB32_8:
	add	x8, x8, #24
LBB32_9:
	ldr	x14, [x8]
	orr	x14, x14, x10
	str	x14, [x8]
LBB32_10:
	and	w8, w0, #0xff
	cmp	w8, #1
	csel	x8, x13, x12, eq
	csel	x9, x11, x9, eq
	orr	x8, x8, x10
	str	x8, [x9]
LBB32_11:
	cbz	x20, LBB32_13
; %bb.12:
	mov	w8, w21
	strb	w19, [x20, x8]
LBB32_13:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh24, Lloh25
	.cfi_endproc
	.section	__TEXT,__const
lJTI32_0:
	.byte	(LBB32_11-LBB32_4)>>2
	.byte	(LBB32_10-LBB32_4)>>2
	.byte	(LBB32_10-LBB32_4)>>2
	.byte	(LBB32_9-LBB32_4)>>2
	.byte	(LBB32_4-LBB32_4)>>2
	.byte	(LBB32_5-LBB32_4)>>2
	.byte	(LBB32_8-LBB32_4)>>2
	.byte	(LBB32_6-LBB32_4)>>2
	.byte	(LBB32_7-LBB32_4)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_get_piece_at_bb                ; -- Begin function get_piece_at_bb
	.p2align	2
_get_piece_at_bb:                       ; @get_piece_at_bb
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, x0
	ldr	x9, [x0, #56]
	tst	x9, x1
	b.eq	LBB33_3
; %bb.1:
	mov	w0, #0
	ldr	x9, [x8]
	tst	x9, x1
	b.eq	LBB33_5
LBB33_2:
	mov	w8, #3
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB33_3:
	ldr	x9, [x8, #48]
	tst	x9, x1
	b.eq	LBB33_7
; %bb.4:
	mov	w0, #1
	ldr	x9, [x8]
	tst	x9, x1
	b.ne	LBB33_2
LBB33_5:
	ldr	x9, [x8, #8]
	tst	x9, x1
	b.eq	LBB33_8
; %bb.6:
	mov	w8, #4
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB33_7:
	bl	_empty_piece
	ubfx	w8, w0, #8, #8
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB33_8:
	ldr	x9, [x8, #16]
	tst	x9, x1
	b.eq	LBB33_10
; %bb.9:
	mov	w8, #5
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB33_10:
	ldr	x9, [x8, #24]
	tst	x9, x1
	b.eq	LBB33_12
; %bb.11:
	mov	w8, #6
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB33_12:
	ldr	x8, [x8, #32]
	tst	x8, x1
	mov	w8, #7
	cinc	w8, w8, eq
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_piece_at                   ; -- Begin function get_piece_at
	.p2align	2
_get_piece_at:                          ; @get_piece_at
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
                                        ; kill: def $w1 killed $w1 def $x1
	mov	x8, x0
	mov	w9, #1
	lsl	x9, x9, x1
	ldr	x10, [x0, #56]
	tst	x10, x9
	b.eq	LBB34_3
; %bb.1:
	mov	w0, #0
	ldr	x10, [x8]
	tst	x10, x9
	b.eq	LBB34_5
LBB34_2:
	mov	w8, #3
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB34_3:
	ldr	x10, [x8, #48]
	tst	x10, x9
	b.eq	LBB34_7
; %bb.4:
	mov	w0, #1
	ldr	x10, [x8]
	tst	x10, x9
	b.ne	LBB34_2
LBB34_5:
	ldr	x10, [x8, #8]
	tst	x10, x9
	b.eq	LBB34_8
; %bb.6:
	mov	w8, #4
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB34_7:
	bl	_empty_piece
	ubfx	w8, w0, #8, #8
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB34_8:
	ldr	x10, [x8, #16]
	tst	x10, x9
	b.eq	LBB34_10
; %bb.9:
	mov	w8, #5
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB34_10:
	ldr	x10, [x8, #24]
	tst	x10, x9
	b.eq	LBB34_12
; %bb.11:
	mov	w8, #6
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB34_12:
	ldr	x8, [x8, #32]
	tst	x8, x9
	mov	w8, #7
	cinc	w8, w8, eq
	bfi	w0, w8, #8, #24
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_index_at                   ; -- Begin function get_index_at
	.p2align	2
_get_index_at:                          ; @get_index_at
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	mov	w8, #1
	lsl	x10, x8, x1
	ldr	x8, [x0, #56]
	tst	x8, x10
	b.eq	LBB35_2
; %bb.1:
	mov	w9, #6
	b	LBB35_3
LBB35_2:
	mov	w9, #0
	mov	w8, #0
	ldr	x11, [x0, #48]
	tst	x11, x10
	b.eq	LBB35_14
LBB35_3:
	ldr	x8, [x0]
	tst	x8, x10
	b.eq	LBB35_5
; %bb.4:
	orr	w0, w9, #0x1
	ret
LBB35_5:
	ldr	x8, [x0, #8]
	tst	x8, x10
	b.eq	LBB35_7
; %bb.6:
	add	w0, w9, #2
	ret
LBB35_7:
	ldr	x8, [x0, #16]
	tst	x8, x10
	b.eq	LBB35_9
; %bb.8:
	add	w0, w9, #3
	ret
LBB35_9:
	ldr	x8, [x0, #24]
	tst	x8, x10
	b.eq	LBB35_11
; %bb.10:
	add	w0, w9, #4
	ret
LBB35_11:
	ldr	x8, [x0, #32]
	tst	x8, x10
	b.eq	LBB35_13
; %bb.12:
	add	w0, w9, #5
	ret
LBB35_13:
	ldr	x8, [x0, #40]
	add	w11, w9, #6
	tst	x8, x10
	csel	w8, w9, w11, eq
LBB35_14:
	mov	x0, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_piece_at_board             ; -- Begin function get_piece_at_board
	.p2align	2
_get_piece_at_board:                    ; @get_piece_at_board
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	ldr	x8, [x0]
	mov	w9, #1
	lsl	x10, x9, x1
	ldr	x9, [x8, #56]
	tst	x9, x10
	b.eq	LBB36_2
; %bb.1:
	mov	w9, #6
	b	LBB36_3
LBB36_2:
	mov	w9, #0
	mov	w0, #0
	ldr	x11, [x8, #48]
	tst	x11, x10
	b.eq	LBB36_14
LBB36_3:
	ldr	x11, [x8]
	tst	x11, x10
	b.eq	LBB36_5
; %bb.4:
	orr	w0, w9, #0x1
	ret
LBB36_5:
	ldr	x11, [x8, #8]
	tst	x11, x10
	b.eq	LBB36_7
; %bb.6:
	add	w0, w9, #2
	ret
LBB36_7:
	ldr	x11, [x8, #16]
	tst	x11, x10
	b.eq	LBB36_9
; %bb.8:
	add	w0, w9, #3
	ret
LBB36_9:
	ldr	x11, [x8, #24]
	tst	x11, x10
	b.eq	LBB36_11
; %bb.10:
	add	w0, w9, #4
	ret
LBB36_11:
	ldr	x11, [x8, #32]
	tst	x11, x10
	b.eq	LBB36_13
; %bb.12:
	add	w0, w9, #5
	ret
LBB36_13:
	ldr	x8, [x8, #40]
	add	w11, w9, #6
	tst	x8, x10
	csel	w0, w9, w11, eq
LBB36_14:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_fill_piece_index_array         ; -- Begin function fill_piece_index_array
	.p2align	2
_fill_piece_index_array:                ; @fill_piece_index_array
	.cfi_startproc
; %bb.0:
	mov	x8, #0
	ldr	x9, [x0]
	mov	w10, #1
	b	LBB37_3
LBB37_1:                                ;   in Loop: Header=BB37_3 Depth=1
	orr	w13, w11, #0x1
LBB37_2:                                ;   in Loop: Header=BB37_3 Depth=1
	strb	w13, [x1, x8]
	add	x8, x8, #1
	cmp	x8, #64
	b.eq	LBB37_16
LBB37_3:                                ; =>This Inner Loop Header: Depth=1
	lsl	x12, x10, x8
	ldr	x11, [x9, #56]
	tst	x11, x12
	b.eq	LBB37_5
; %bb.4:                                ;   in Loop: Header=BB37_3 Depth=1
	mov	w11, #6
	b	LBB37_6
LBB37_5:                                ;   in Loop: Header=BB37_3 Depth=1
	mov	w11, #0
	mov	w13, #0
	ldr	x14, [x9, #48]
	tst	x14, x12
	b.eq	LBB37_2
LBB37_6:                                ;   in Loop: Header=BB37_3 Depth=1
	ldr	x13, [x9]
	tst	x13, x12
	b.ne	LBB37_1
; %bb.7:                                ;   in Loop: Header=BB37_3 Depth=1
	ldr	x13, [x9, #8]
	tst	x13, x12
	b.eq	LBB37_9
; %bb.8:                                ;   in Loop: Header=BB37_3 Depth=1
	add	w13, w11, #2
	b	LBB37_2
LBB37_9:                                ;   in Loop: Header=BB37_3 Depth=1
	ldr	x13, [x9, #16]
	tst	x13, x12
	b.eq	LBB37_11
; %bb.10:                               ;   in Loop: Header=BB37_3 Depth=1
	add	w13, w11, #3
	b	LBB37_2
LBB37_11:                               ;   in Loop: Header=BB37_3 Depth=1
	ldr	x13, [x9, #24]
	tst	x13, x12
	b.eq	LBB37_13
; %bb.12:                               ;   in Loop: Header=BB37_3 Depth=1
	add	w13, w11, #4
	b	LBB37_2
LBB37_13:                               ;   in Loop: Header=BB37_3 Depth=1
	ldr	x13, [x9, #32]
	tst	x13, x12
	b.eq	LBB37_15
; %bb.14:                               ;   in Loop: Header=BB37_3 Depth=1
	add	w13, w11, #5
	b	LBB37_2
LBB37_15:                               ;   in Loop: Header=BB37_3 Depth=1
	ldr	x13, [x9, #40]
	add	w14, w11, #6
	tst	x13, x12
	csel	w13, w11, w14, eq
	b	LBB37_2
LBB37_16:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_clear_board                    ; -- Begin function clear_board
	.p2align	2
_clear_board:                           ; @clear_board
	.cfi_startproc
; %bb.0:
	movi.2d	v0, #0000000000000000
	stp	q0, q0, [x0, #32]
	stp	q0, q0, [x0]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_has_kingside_castling_rights   ; -- Begin function has_kingside_castling_rights
	.p2align	2
_has_kingside_castling_rights:          ; @has_kingside_castling_rights
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #9]
	cmp	w1, #1
	mov	w9, #4
	csinc	w9, w9, wzr, ne
	tst	w8, w9
	cset	w0, ne
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_has_queenside_castling_rights  ; -- Begin function has_queenside_castling_rights
	.p2align	2
_has_queenside_castling_rights:         ; @has_queenside_castling_rights
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #9]
	mov	w9, #8
	mov	w10, #2
	cmp	w1, #1
	csel	w9, w10, w9, eq
	tst	w8, w9
	cset	w0, ne
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_has_castling_rights            ; -- Begin function has_castling_rights
	.p2align	2
_has_castling_rights:                   ; @has_castling_rights
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #9]
	mov	w9, #12
	mov	w10, #3
	cmp	w1, #1
	csel	w9, w10, w9, eq
	tst	w8, w9
	cset	w0, ne
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_clear_castling_rights          ; -- Begin function clear_castling_rights
	.p2align	2
_clear_castling_rights:                 ; @clear_castling_rights
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #9]
	mov	w9, #3
	mov	w10, #12
	cmp	w1, #1
	csel	w9, w10, w9, eq
	and	w8, w8, w9
	strb	w8, [x0, #9]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_clear_kingside_castling_rights ; -- Begin function clear_kingside_castling_rights
	.p2align	2
_clear_kingside_castling_rights:        ; @clear_kingside_castling_rights
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #9]
	mov	w9, #-5
	mov	w10, #-2
	cmp	w1, #1
	csel	w9, w10, w9, eq
	and	w8, w8, w9
	strb	w8, [x0, #9]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_clear_queenside_castling_rights ; -- Begin function clear_queenside_castling_rights
	.p2align	2
_clear_queenside_castling_rights:       ; @clear_queenside_castling_rights
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #9]
	mov	w9, #-9
	mov	w10, #-3
	cmp	w1, #1
	csel	w9, w10, w9, eq
	and	w8, w8, w9
	strb	w8, [x0, #9]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_set_full_castling_rights       ; -- Begin function set_full_castling_rights
	.p2align	2
_set_full_castling_rights:              ; @set_full_castling_rights
	.cfi_startproc
; %bb.0:
	mov	w8, #15
	strb	w8, [x0, #9]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_add_castling_rights            ; -- Begin function add_castling_rights
	.p2align	2
_add_castling_rights:                   ; @add_castling_rights
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #9]
	mov	w9, #1
	mov	w10, #8
	mov	w11, #4
	cmp	w1, #0
	csel	w10, w11, w10, ne
	cinc	w9, w9, eq
	cmp	w2, #1
	csel	w9, w9, w10, eq
	orr	w8, w8, w9
	strb	w8, [x0, #9]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_clear_ep_square                ; -- Begin function clear_ep_square
	.p2align	2
_clear_ep_square:                       ; @clear_ep_square
	.cfi_startproc
; %bb.0:
	mov	w8, #64
	strh	w8, [x0, #10]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_set_ep_square                  ; -- Begin function set_ep_square
	.p2align	2
_set_ep_square:                         ; @set_ep_square
	.cfi_startproc
; %bb.0:
	mov	w8, #1
	strb	w8, [x0, #11]
	strb	w1, [x0, #10]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_set_ep_square_checked          ; -- Begin function set_ep_square_checked
	.p2align	2
_set_ep_square_checked:                 ; @set_ep_square_checked
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w1 killed $w1 def $x1
	cmp	w1, #63
	b.ls	LBB49_2
; %bb.1:
Lloh26:
	adrp	x0, l_.str@PAGE
Lloh27:
	add	x0, x0, l_.str@PAGEOFF
	ret
LBB49_2:
	mov	w8, #1
	lsl	x9, x8, x1
	mov	x8, #16711680
	movk	x8, #65280, lsl #32
	tst	x9, x8
	b.eq	LBB49_6
; %bb.3:
	ldr	x10, [x0]
	ldr	x8, [x10]
	ldrb	w11, [x0, #8]
	cmp	w11, #1
	b.ne	LBB49_7
; %bb.4:
	and	x11, x9, #0xff0000
	cbz	x11, LBB49_9
; %bb.5:
Lloh28:
	adrp	x0, l_.str.2@PAGE
Lloh29:
	add	x0, x0, l_.str.2@PAGEOFF
	ret
LBB49_6:
Lloh30:
	adrp	x0, l_.str.1@PAGE
Lloh31:
	add	x0, x0, l_.str.1@PAGEOFF
	ret
LBB49_7:
	and	x9, x9, #0xff0000000000
	cbz	x9, LBB49_11
; %bb.8:
Lloh32:
	adrp	x0, l_.str.4@PAGE
Lloh33:
	add	x0, x0, l_.str.4@PAGEOFF
	ret
LBB49_9:
	ldr	x10, [x10, #56]
	and	x9, x10, x9, lsr #8
	tst	x9, x8
	b.ne	LBB49_12
; %bb.10:
Lloh34:
	adrp	x0, l_.str.3@PAGE
Lloh35:
	add	x0, x0, l_.str.3@PAGEOFF
	ret
LBB49_11:
	ldr	x9, [x10, #48]
	mov	w10, w1
	mov	w11, #256
	lsl	x10, x11, x10
	and	x9, x9, x10
	tst	x9, x8
	b.eq	LBB49_13
LBB49_12:
	mov	w9, #1
	strb	w9, [x0, #11]
	strb	w1, [x0, #10]
	mov	x0, #0
	ret
LBB49_13:
Lloh36:
	adrp	x0, l_.str.5@PAGE
Lloh37:
	add	x0, x0, l_.str.5@PAGEOFF
	ret
	.loh AdrpAdd	Lloh26, Lloh27
	.loh AdrpAdd	Lloh28, Lloh29
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpAdd	Lloh32, Lloh33
	.loh AdrpAdd	Lloh34, Lloh35
	.loh AdrpAdd	Lloh36, Lloh37
	.cfi_endproc
                                        ; -- End function
	.globl	_update_castling_rights         ; -- Begin function update_castling_rights
	.p2align	2
_update_castling_rights:                ; @update_castling_rights
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ldr	x9, [x8, #40]
	cmp	w1, #1
	b.ne	LBB50_6
; %bb.1:
	ldr	x10, [x8, #48]
	and	x9, x10, x9
	mov	x11, #16
	movk	x11, #4096, lsl #48
	tst	x9, x11
	b.eq	LBB50_11
; %bb.2:
	ldr	x8, [x8, #24]
	and	x8, x8, x10
	tbnz	w8, #0, LBB50_4
; %bb.3:
	ldrb	w9, [x0, #9]
	and	w9, w9, #0xfffffffd
	strb	w9, [x0, #9]
LBB50_4:
	tbnz	w8, #7, LBB50_14
; %bb.5:
	mov	w8, #254
	b	LBB50_13
LBB50_6:
	ldr	x10, [x8, #56]
	and	x9, x10, x9
	mov	x11, #16
	movk	x11, #4096, lsl #48
	tst	x9, x11
	b.eq	LBB50_12
; %bb.7:
	ldr	x8, [x8, #24]
	and	x8, x8, x10
	tbnz	x8, #56, LBB50_9
; %bb.8:
	ldrb	w9, [x0, #9]
	and	w9, w9, #0xfffffff7
	strb	w9, [x0, #9]
LBB50_9:
	tbnz	x8, #63, LBB50_14
; %bb.10:
	mov	w8, #251
	b	LBB50_13
LBB50_11:
	mov	w8, #252
	b	LBB50_13
LBB50_12:
	mov	w8, #243
LBB50_13:
	ldrb	w9, [x0, #9]
	and	w8, w9, w8
	strb	w8, [x0, #9]
LBB50_14:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_update_all_castling_rights     ; -- Begin function update_all_castling_rights
	.p2align	2
_update_all_castling_rights:            ; @update_all_castling_rights
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ldp	x9, x10, [x8, #40]
	and	x9, x9, #0x1ffffffffffffff0
	and	x9, x9, #0xf00000000000001f
	tst	x9, x10
	b.eq	LBB51_8
; %bb.1:
	ldr	x11, [x8, #24]
	and	x10, x11, x10
	tbz	w10, #0, LBB51_9
; %bb.2:
	tbz	w10, #7, LBB51_10
LBB51_3:
	ldr	x10, [x8, #56]
	tst	x9, x10
	b.eq	LBB51_12
LBB51_4:
	ldr	x8, [x8, #24]
	and	x8, x8, x10
	tbnz	x8, #56, LBB51_6
; %bb.5:
	ldrb	w9, [x0, #9]
	and	w9, w9, #0xfffffff7
	strb	w9, [x0, #9]
LBB51_6:
	tbnz	x8, #63, LBB51_14
; %bb.7:
	mov	w8, #251
	b	LBB51_13
LBB51_8:
	mov	w10, #252
	b	LBB51_11
LBB51_9:
	ldrb	w11, [x0, #9]
	and	w11, w11, #0xfffffffd
	strb	w11, [x0, #9]
	tbnz	w10, #7, LBB51_3
LBB51_10:
	mov	w10, #254
LBB51_11:
	ldrb	w11, [x0, #9]
	and	w10, w11, w10
	strb	w10, [x0, #9]
	ldr	x10, [x8, #56]
	tst	x9, x10
	b.ne	LBB51_4
LBB51_12:
	mov	w8, #243
LBB51_13:
	ldrb	w9, [x0, #9]
	and	w8, w9, w8
	strb	w8, [x0, #9]
LBB51_14:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_fill_board_string              ; -- Begin function fill_board_string
	.p2align	2
_fill_board_string:                     ; @fill_board_string
	.cfi_startproc
; %bb.0:
	cbz	x1, LBB52_19
; %bb.1:
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
	mov	x19, x1
	mov	x20, x0
	mov	w8, #0
	mov	w22, #0
	mov	x23, #-72057594037927936
	mov	w24, #32
                                        ; implicit-def: $x21
	b	LBB52_3
LBB52_2:                                ;   in Loop: Header=BB52_3 Depth=1
	add	x10, x28, x27
	sub	x9, x10, #2
	add	w8, w9, #3
	mov	w11, #10
	strb	w11, [x19, w10, sxtw]
	lsr	x23, x23, #8
	add	w22, w22, #1
	cmp	w22, #8
	b.eq	LBB52_18
LBB52_3:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB52_6 Depth 2
	mov	x27, #0
	sxtw	x28, w8
	add	x26, x19, x28
	mov	x25, #72340172838076673
	b	LBB52_6
LBB52_4:                                ;   in Loop: Header=BB52_6 Depth=2
	mov	w9, #3
LBB52_5:                                ;   in Loop: Header=BB52_6 Depth=2
	lsl	w9, w9, #8
	and	x9, x9, #0xff00
	and	x10, x21, #0xffffffffffff0000
	orr	x8, x10, x8
	orr	x21, x8, x9
	mov	x0, x21
	bl	_piece_symbol
	add	x8, x26, x27
	strb	w0, [x8]
	strb	w24, [x8, #1]
	lsl	x8, x25, #1
	and	x25, x8, #0xfefefefefefefefe
	add	x27, x27, #2
	cmp	w27, #16
	b.eq	LBB52_2
LBB52_6:                                ;   Parent Loop BB52_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x9, [x20]
	and	x10, x25, x23
	ldr	x8, [x9, #56]
	tst	x8, x10
	b.eq	LBB52_8
; %bb.7:                                ;   in Loop: Header=BB52_6 Depth=2
	mov	x8, #0
	ldr	x11, [x9]
	tst	x11, x10
	b.ne	LBB52_4
	b	LBB52_10
LBB52_8:                                ;   in Loop: Header=BB52_6 Depth=2
	ldr	x8, [x9, #48]
	tst	x8, x10
	b.eq	LBB52_12
; %bb.9:                                ;   in Loop: Header=BB52_6 Depth=2
	mov	w8, #1
	ldr	x11, [x9]
	tst	x11, x10
	b.ne	LBB52_4
LBB52_10:                               ;   in Loop: Header=BB52_6 Depth=2
	ldr	x11, [x9, #8]
	tst	x11, x10
	b.eq	LBB52_13
; %bb.11:                               ;   in Loop: Header=BB52_6 Depth=2
	mov	w9, #4
	b	LBB52_5
LBB52_12:                               ;   in Loop: Header=BB52_6 Depth=2
	bl	_empty_piece
                                        ; kill: def $w0 killed $w0 def $x0
	and	x8, x0, #0xff
	ubfx	w9, w0, #8, #8
	b	LBB52_5
LBB52_13:                               ;   in Loop: Header=BB52_6 Depth=2
	ldr	x11, [x9, #16]
	tst	x11, x10
	b.eq	LBB52_15
; %bb.14:                               ;   in Loop: Header=BB52_6 Depth=2
	mov	w9, #5
	b	LBB52_5
LBB52_15:                               ;   in Loop: Header=BB52_6 Depth=2
	ldr	x11, [x9, #24]
	tst	x11, x10
	b.eq	LBB52_17
; %bb.16:                               ;   in Loop: Header=BB52_6 Depth=2
	mov	w9, #6
	b	LBB52_5
LBB52_17:                               ;   in Loop: Header=BB52_6 Depth=2
	ldr	x9, [x9, #32]
	tst	x9, x10
	mov	w9, #7
	cinc	x9, x9, eq
	b	LBB52_5
LBB52_18:
	add	x8, x19, w9, sxtw
	strb	wzr, [x8, #3]
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
LBB52_19:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_print_board                    ; -- Begin function print_board
	.p2align	2
_print_board:                           ; @print_board
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #304
	.cfi_def_cfa_offset 304
	stp	x28, x27, [sp, #272]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #288]            ; 16-byte Folded Spill
	add	x29, sp, #288
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
Lloh38:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh39:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh40:
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	add	x1, sp, #9
	bl	_fill_board_string
	add	x0, sp, #9
	bl	_puts
	ldur	x8, [x29, #-24]
Lloh41:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh42:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh43:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB53_2
; %bb.1:
	ldp	x29, x30, [sp, #288]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #272]            ; 16-byte Folded Reload
	add	sp, sp, #304
	ret
LBB53_2:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh41, Lloh42, Lloh43
	.loh AdrpLdrGotLdr	Lloh38, Lloh39, Lloh40
	.cfi_endproc
                                        ; -- End function
	.globl	_validate_board                 ; -- Begin function validate_board
	.p2align	2
_validate_board:                        ; @validate_board
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
	ldr	x22, [x0]
	cbz	x22, LBB54_4
; %bb.1:
	mov	x19, x0
	ldrb	w8, [x0, #8]
	cmp	w8, #1
	b.hi	LBB54_5
; %bb.2:
	ldp	x9, x8, [x22, #48]
	tst	x8, x9
	b.eq	LBB54_7
; %bb.3:
Lloh44:
	adrp	x0, l_.str.9@PAGE
Lloh45:
	add	x0, x0, l_.str.9@PAGEOFF
	b	LBB54_6
LBB54_4:
Lloh46:
	adrp	x0, l_.str.7@PAGE
Lloh47:
	add	x0, x0, l_.str.7@PAGEOFF
	b	LBB54_6
LBB54_5:
Lloh48:
	adrp	x0, l_.str.8@PAGE
Lloh49:
	add	x0, x0, l_.str.8@PAGEOFF
LBB54_6:
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB54_7:
	ldp	x12, x11, [x22, #8]
	tst	x12, x11
	b.eq	LBB54_9
; %bb.8:
Lloh50:
	adrp	x0, l_.str.10@PAGE
Lloh51:
	add	x0, x0, l_.str.10@PAGEOFF
	b	LBB54_6
LBB54_9:
	ldp	x13, x14, [x22, #24]
	tst	x14, x13
	b.eq	LBB54_11
; %bb.10:
Lloh52:
	adrp	x0, l_.str.11@PAGE
Lloh53:
	add	x0, x0, l_.str.11@PAGEOFF
	b	LBB54_6
LBB54_11:
	ldr	x15, [x22]
	ldr	x10, [x22, #40]
	tst	x10, x15
	b.eq	LBB54_13
; %bb.12:
Lloh54:
	adrp	x0, l_.str.12@PAGE
Lloh55:
	add	x0, x0, l_.str.12@PAGEOFF
	b	LBB54_6
LBB54_13:
	orr	x11, x12, x11
	orr	x12, x14, x13
	tst	x12, x11
	b.eq	LBB54_15
; %bb.14:
Lloh56:
	adrp	x0, l_.str.13@PAGE
Lloh57:
	add	x0, x0, l_.str.13@PAGEOFF
	b	LBB54_6
LBB54_15:
	tst	x15, #0xff000000000000ff
	b.eq	LBB54_17
; %bb.16:
Lloh58:
	adrp	x0, l_.str.15@PAGE
Lloh59:
	add	x0, x0, l_.str.15@PAGEOFF
	b	LBB54_6
LBB54_17:
Lloh60:
	adrp	x0, l_.str.16@PAGE
Lloh61:
	add	x0, x0, l_.str.16@PAGEOFF
	ands	x20, x10, x9
	b.eq	LBB54_6
; %bb.18:
	and	x21, x10, x8
	cbz	x21, LBB54_6
; %bb.19:
	mov	x0, x20
	bl	_count_bits
	cmp	w0, #1
	b.ls	LBB54_21
; %bb.20:
Lloh62:
	adrp	x0, l_.str.17@PAGE
Lloh63:
	add	x0, x0, l_.str.17@PAGEOFF
	b	LBB54_6
LBB54_21:
	mov	x26, x21
	mov	x0, x21
	bl	_count_bits
	cmp	w0, #1
	b.ls	LBB54_23
; %bb.22:
Lloh64:
	adrp	x0, l_.str.18@PAGE
Lloh65:
	add	x0, x0, l_.str.18@PAGEOFF
	b	LBB54_6
LBB54_23:
	ldr	x8, [x22]
	ldp	x9, x10, [x22, #48]
	mov	x28, x22
	and	x27, x8, x9
	and	x21, x10, x8
	mov	x0, x27
	bl	_count_bits
	mov	x22, x0
	mov	x0, x21
	bl	_count_bits
	cmp	w22, #8
	b.ls	LBB54_25
; %bb.24:
Lloh66:
	adrp	x0, l_.str.19@PAGE
Lloh67:
	add	x0, x0, l_.str.19@PAGEOFF
	b	LBB54_6
LBB54_25:
	str	w0, [sp, #12]                   ; 4-byte Folded Spill
	cmp	w0, #8
	b.ls	LBB54_27
; %bb.26:
Lloh68:
	adrp	x0, l_.str.20@PAGE
Lloh69:
	add	x0, x0, l_.str.20@PAGEOFF
	b	LBB54_6
LBB54_27:
	mov	x24, x28
	ldr	x8, [x28, #48]
	ldr	x9, [x28, #16]
	and	x0, x9, x8
	bl	_count_bits
	mov	x25, x0
	ldr	x8, [x28, #48]
	ldr	x9, [x28, #24]
	and	x0, x9, x8
	bl	_count_bits
	mov	x23, x0
	ldr	x8, [x28, #48]
	ldr	x9, [x28, #32]
	and	x0, x9, x8
	bl	_count_bits
	str	w0, [sp, #8]                    ; 4-byte Folded Spill
	ldr	x8, [x28, #48]
	ldr	x9, [x28, #8]
	and	x0, x9, x8
	bl	_count_bits
	add	w8, w22, w25, sxtb
	cmp	w8, #10
	b.le	LBB54_29
; %bb.28:
Lloh70:
	adrp	x0, l_.str.21@PAGE
Lloh71:
	add	x0, x0, l_.str.21@PAGEOFF
	b	LBB54_6
LBB54_29:
	add	w8, w22, w23, sxtb
	cmp	w8, #10
	b.le	LBB54_31
; %bb.30:
Lloh72:
	adrp	x0, l_.str.22@PAGE
Lloh73:
	add	x0, x0, l_.str.22@PAGEOFF
	b	LBB54_6
LBB54_31:
	add	w8, w22, w0, sxtb
	cmp	w8, #10
	b.le	LBB54_33
; %bb.32:
Lloh74:
	adrp	x0, l_.str.23@PAGE
Lloh75:
	add	x0, x0, l_.str.23@PAGEOFF
	b	LBB54_6
LBB54_33:
	ldr	w8, [sp, #8]                    ; 4-byte Folded Reload
	add	w8, w22, w8, sxtb
	cmp	w8, #9
	b.le	LBB54_35
; %bb.34:
Lloh76:
	adrp	x0, l_.str.24@PAGE
Lloh77:
	add	x0, x0, l_.str.24@PAGEOFF
	b	LBB54_6
LBB54_35:
	mov	x24, x28
	ldr	x8, [x28, #56]
	ldr	x9, [x28, #16]
	and	x0, x9, x8
	bl	_count_bits
	mov	x25, x0
	ldr	x8, [x28, #56]
	ldr	x9, [x28, #24]
	and	x0, x9, x8
	bl	_count_bits
	mov	x22, x0
	ldr	x8, [x28, #56]
	ldr	x9, [x28, #32]
	and	x0, x9, x8
	bl	_count_bits
	mov	x23, x0
	ldr	x8, [x28, #56]
	ldr	x9, [x28, #8]
	and	x0, x9, x8
	bl	_count_bits
	ldr	w8, [sp, #12]                   ; 4-byte Folded Reload
	add	w8, w8, w25, sxtb
	cmp	w8, #10
	b.le	LBB54_37
; %bb.36:
Lloh78:
	adrp	x0, l_.str.25@PAGE
Lloh79:
	add	x0, x0, l_.str.25@PAGEOFF
	b	LBB54_6
LBB54_37:
	ldr	w8, [sp, #12]                   ; 4-byte Folded Reload
	add	w8, w8, w22, sxtb
	cmp	w8, #10
	b.le	LBB54_39
; %bb.38:
Lloh80:
	adrp	x0, l_.str.26@PAGE
Lloh81:
	add	x0, x0, l_.str.26@PAGEOFF
	b	LBB54_6
LBB54_39:
	ldr	w8, [sp, #12]                   ; 4-byte Folded Reload
	add	w8, w8, w0, sxtb
	cmp	w8, #10
	b.le	LBB54_41
; %bb.40:
Lloh82:
	adrp	x0, l_.str.27@PAGE
Lloh83:
	add	x0, x0, l_.str.27@PAGEOFF
	b	LBB54_6
LBB54_41:
	ldr	w8, [sp, #12]                   ; 4-byte Folded Reload
	add	w8, w8, w23, sxtb
	cmp	w8, #9
	b.le	LBB54_43
; %bb.42:
Lloh84:
	adrp	x0, l_.str.28@PAGE
Lloh85:
	add	x0, x0, l_.str.28@PAGEOFF
	b	LBB54_6
LBB54_43:
	ldrb	w8, [x19, #9]
	cbz	w8, LBB54_61
; %bb.44:
	ands	w9, w8, #0xc
	cset	w10, ne
	tst	x26, #0x1000000000000000
	cset	w11, eq
	and	w10, w10, w11
	and	w12, w8, #0x3
	cbz	w12, LBB54_47
; %bb.45:
	tbnz	w20, #4, LBB54_47
; %bb.46:
Lloh86:
	adrp	x8, l_.str.30@PAGE
Lloh87:
	add	x8, x8, l_.str.30@PAGEOFF
Lloh88:
	adrp	x9, l_.str.29@PAGE
Lloh89:
	add	x9, x9, l_.str.29@PAGEOFF
	cmp	w10, #0
	csel	x0, x9, x8, ne
	b	LBB54_6
LBB54_47:
	tbz	w10, #0, LBB54_49
; %bb.48:
Lloh90:
	adrp	x0, l_.str.31@PAGE
Lloh91:
	add	x0, x0, l_.str.31@PAGEOFF
	b	LBB54_6
LBB54_49:
	mov	x11, x28
	ldr	x10, [x28, #24]
	ldr	x11, [x28, #48]
	and	x11, x11, x10
	cmp	w12, #2
	b.lo	LBB54_52
; %bb.50:
	mov	w12, #1
	bic	x12, x12, x11
	cbz	x12, LBB54_52
; %bb.51:
Lloh92:
	adrp	x0, l_.str.32@PAGE
Lloh93:
	add	x0, x0, l_.str.32@PAGEOFF
	b	LBB54_6
LBB54_52:
	tbz	w8, #0, LBB54_55
; %bb.53:
	mvn	x11, x11
	tbz	w11, #7, LBB54_55
; %bb.54:
Lloh94:
	adrp	x0, l_.str.33@PAGE
Lloh95:
	add	x0, x0, l_.str.33@PAGEOFF
	b	LBB54_6
LBB54_55:
	ldr	x11, [x28, #56]
	and	x10, x11, x10
	cmp	w9, #8
	b.lo	LBB54_58
; %bb.56:
	tbnz	x10, #56, LBB54_58
; %bb.57:
Lloh96:
	adrp	x0, l_.str.34@PAGE
Lloh97:
	add	x0, x0, l_.str.34@PAGEOFF
	b	LBB54_6
LBB54_58:
	tbz	w8, #2, LBB54_61
; %bb.59:
	tbnz	x10, #63, LBB54_61
; %bb.60:
Lloh98:
	adrp	x0, l_.str.35@PAGE
Lloh99:
	add	x0, x0, l_.str.35@PAGEOFF
	b	LBB54_6
LBB54_61:
	ldrb	w8, [x19, #11]
	tbnz	w8, #0, LBB54_64
LBB54_62:
	mov	x0, x19
	bl	_opponent_in_check
	tbz	w0, #0, LBB54_68
; %bb.63:
Lloh100:
	adrp	x0, l_.str.41@PAGE
Lloh101:
	add	x0, x0, l_.str.41@PAGEOFF
	b	LBB54_6
LBB54_64:
	ldrb	w8, [x19, #10]
	mov	w9, #1
	lsl	x9, x9, x8
	mov	x10, #16711680
	movk	x10, #65280, lsl #32
	tst	x9, x10
	b.eq	LBB54_69
; %bb.65:
	ldrb	w10, [x19, #8]
	cmp	w10, #1
	b.ne	LBB54_70
; %bb.66:
	and	x8, x9, #0xff0000
	cbz	x8, LBB54_72
; %bb.67:
Lloh102:
	adrp	x0, l_.str.37@PAGE
Lloh103:
	add	x0, x0, l_.str.37@PAGEOFF
	b	LBB54_6
LBB54_68:
	mov	x0, x19
	bl	_get_checkers
Lloh104:
	adrp	x8, l_.str.42@PAGE
Lloh105:
	add	x8, x8, l_.str.42@PAGEOFF
	cmp	w0, #2
	csel	x0, x8, xzr, hi
	b	LBB54_6
LBB54_69:
Lloh106:
	adrp	x0, l_.str.36@PAGE
Lloh107:
	add	x0, x0, l_.str.36@PAGEOFF
	b	LBB54_6
LBB54_70:
	and	x9, x9, #0xff0000000000
	cbz	x9, LBB54_74
; %bb.71:
Lloh108:
	adrp	x0, l_.str.39@PAGE
Lloh109:
	add	x0, x0, l_.str.39@PAGEOFF
	b	LBB54_6
LBB54_72:
	tst	x21, x9, lsr #8
	b.ne	LBB54_62
; %bb.73:
Lloh110:
	adrp	x0, l_.str.38@PAGE
Lloh111:
	add	x0, x0, l_.str.38@PAGEOFF
	b	LBB54_6
LBB54_74:
	lsr	x8, x27, x8
	tbnz	w8, #8, LBB54_62
; %bb.75:
Lloh112:
	adrp	x0, l_.str.40@PAGE
Lloh113:
	add	x0, x0, l_.str.40@PAGEOFF
	b	LBB54_6
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
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpAdd	Lloh66, Lloh67
	.loh AdrpAdd	Lloh68, Lloh69
	.loh AdrpAdd	Lloh70, Lloh71
	.loh AdrpAdd	Lloh72, Lloh73
	.loh AdrpAdd	Lloh74, Lloh75
	.loh AdrpAdd	Lloh76, Lloh77
	.loh AdrpAdd	Lloh78, Lloh79
	.loh AdrpAdd	Lloh80, Lloh81
	.loh AdrpAdd	Lloh82, Lloh83
	.loh AdrpAdd	Lloh84, Lloh85
	.loh AdrpAdd	Lloh88, Lloh89
	.loh AdrpAdd	Lloh86, Lloh87
	.loh AdrpAdd	Lloh90, Lloh91
	.loh AdrpAdd	Lloh92, Lloh93
	.loh AdrpAdd	Lloh94, Lloh95
	.loh AdrpAdd	Lloh96, Lloh97
	.loh AdrpAdd	Lloh98, Lloh99
	.loh AdrpAdd	Lloh100, Lloh101
	.loh AdrpAdd	Lloh102, Lloh103
	.loh AdrpAdd	Lloh104, Lloh105
	.loh AdrpAdd	Lloh106, Lloh107
	.loh AdrpAdd	Lloh108, Lloh109
	.loh AdrpAdd	Lloh110, Lloh111
	.loh AdrpAdd	Lloh112, Lloh113
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Illegal en passant Square, {ep} is not a valid Square"

l_.str.1:                               ; @.str.1
	.asciz	"Illegal en passant Square {ep}, must be on either rank 3 or rank 6"

l_.str.2:                               ; @.str.2
	.asciz	"Illegal en passant Square {ep}, must be on rank 6 if it is white's turn"

l_.str.3:                               ; @.str.3
	.asciz	"Illegal en passant Square {ep}, there is no corresponding black pawn"

l_.str.4:                               ; @.str.4
	.asciz	"Illegal en passant Square {ep}, must be on rank 3 if it is black's turn"

l_.str.5:                               ; @.str.5
	.asciz	"Illegal en passant Square {ep}, there is no corresponding white pawn"

l_.str.7:                               ; @.str.7
	.asciz	"Board has no position"

l_.str.8:                               ; @.str.8
	.asciz	"Board turn is not White or Black"

l_.str.9:                               ; @.str.9
	.asciz	"Piece color bitboard values are conflicting"

l_.str.10:                              ; @.str.10
	.asciz	"Knight and bishops bitboard values are conflicting"

l_.str.11:                              ; @.str.11
	.asciz	"Rook and queen bitboard values are conflicting"

l_.str.12:                              ; @.str.12
	.asciz	"Pawn and king bitboard values ares conflicting"

l_.str.13:                              ; @.str.13
	.asciz	"Minor and major piece bitboard values are conflicting"

l_.str.15:                              ; @.str.15
	.asciz	"Board cannot have pawns on the back ranks"

l_.str.16:                              ; @.str.16
	.asciz	"Board must have a king for both players"

l_.str.17:                              ; @.str.17
	.asciz	"Board cannot have more than 1 white king"

l_.str.18:                              ; @.str.18
	.asciz	"Board cannot have more than 1 black king"

l_.str.19:                              ; @.str.19
	.asciz	"Board cannot have more than 8 white pawns"

l_.str.20:                              ; @.str.20
	.asciz	"Board cannot have more than 8 black pawns"

l_.str.21:                              ; @.str.21
	.asciz	"Board cannot have more white bishops than are able to promote"

l_.str.22:                              ; @.str.22
	.asciz	"Board cannot have more white rooks than are able to promote"

l_.str.23:                              ; @.str.23
	.asciz	"Board cannot have more white knights than are able to promote"

l_.str.24:                              ; @.str.24
	.asciz	"Board cannot have more white queens than are able to promote"

l_.str.25:                              ; @.str.25
	.asciz	"Board cannot have more black bishops than are able to promote"

l_.str.26:                              ; @.str.26
	.asciz	"Board cannot have more black rooks than are able to promote"

l_.str.27:                              ; @.str.27
	.asciz	"Board cannot have more black knights than are able to promote"

l_.str.28:                              ; @.str.28
	.asciz	"Board cannot have more black queens than are able to promote"

l_.str.29:                              ; @.str.29
	.asciz	"Board castling rights are illegal, neither player can castle"

l_.str.30:                              ; @.str.30
	.asciz	"Board castling rights are illegal, white cannot castle"

l_.str.31:                              ; @.str.31
	.asciz	"Board castling rights are illegal, black cannot castle"

l_.str.32:                              ; @.str.32
	.asciz	"Board castling rights are illegal, white cannot castle queenside"

l_.str.33:                              ; @.str.33
	.asciz	"Board castling rights are illegal, white cannot castle kingside"

l_.str.34:                              ; @.str.34
	.asciz	"Board castling rights are illegal, black cannot castle queenside"

l_.str.35:                              ; @.str.35
	.asciz	"Board castling rights are illegal, black cannot castle kingside"

l_.str.36:                              ; @.str.36
	.asciz	"Board has illegal en passant square, must be on either rank 3 or rank 6"

l_.str.37:                              ; @.str.37
	.asciz	"Board has illegal en passant square, must be on rank 6 if it is white's turn"

l_.str.38:                              ; @.str.38
	.asciz	"Board has illegal en passant square, there is no corresponding black pawn"

l_.str.39:                              ; @.str.39
	.asciz	"Board has illegal en passant square, must be on rank 3 if it is black's turn"

l_.str.40:                              ; @.str.40
	.asciz	"Board has illegal en passant square, there is no corresponding white pawn"

l_.str.41:                              ; @.str.41
	.asciz	"Board has impossible position, the player to move cannot be able to capture the opponent's king."

l_.str.42:                              ; @.str.42
	.asciz	"Board has impossible position, a player cannot be in check from more than 2 attackers."

.subsections_via_symbols
