	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_error_move                     ; -- Begin function error_move
	.p2align	2
_error_move:                            ; @error_move
	.cfi_startproc
; %bb.0:
	mov	w0, #16777216
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_null_move                      ; -- Begin function null_move
	.p2align	2
_null_move:                             ; @null_move
	.cfi_startproc
; %bb.0:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_move_body                      ; -- Begin function move_body
	.p2align	2
_move_body:                             ; @move_body
	.cfi_startproc
; %bb.0:
	bfi	w0, w1, #8, #8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_generic_move                   ; -- Begin function generic_move
	.p2align	2
_generic_move:                          ; @generic_move
	.cfi_startproc
; %bb.0:
	mov	w8, #33554432
	bfxil	w8, w0, #0, #16
	mov	x0, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_promotion_move                 ; -- Begin function promotion_move
	.p2align	2
_promotion_move:                        ; @promotion_move
	.cfi_startproc
; %bb.0:
	and	w8, w0, #0xffff
	bfi	w8, w1, #16, #8
	orr	w0, w8, #0x3000000
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_make_move_from_parts           ; -- Begin function make_move_from_parts
	.p2align	2
_make_move_from_parts:                  ; @make_move_from_parts
	.cfi_startproc
; %bb.0:
	bfi	w0, w1, #8, #8
	orr	w8, w0, #0x2000000
	bfi	w0, w2, #16, #8
	orr	w9, w0, #0x3000000
	cmp	w2, #0
	csel	w0, w8, w9, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_ext_construct_move             ; -- Begin function ext_construct_move
	.p2align	2
_ext_construct_move:                    ; @ext_construct_move
	.cfi_startproc
; %bb.0:
	cmp	w0, #63
	b.ls	LBB6_2
; %bb.1:
Lloh0:
	adrp	x0, l_.str@PAGE
Lloh1:
	add	x0, x0, l_.str@PAGEOFF
	ret
LBB6_2:
	cmp	w1, #63
	b.ls	LBB6_4
; %bb.3:
Lloh2:
	adrp	x0, l_.str.1@PAGE
Lloh3:
	add	x0, x0, l_.str.1@PAGEOFF
	ret
LBB6_4:
	bfi	w0, w1, #8, #8
	orr	w8, w0, #0x2000000
	bfi	w0, w2, #16, #8
	orr	w9, w0, #0x3000000
	cmp	w2, #0
	csel	w0, w8, w9, eq
	str	w0, [x3]
	b	_error_from_move
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
	.globl	_error_from_move                ; -- Begin function error_from_move
	.p2align	2
_error_from_move:                       ; @error_from_move
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
	ubfx	x8, x0, #24, #8
	cbz	w8, LBB7_20
; %bb.1:
	mov	x20, x0
	cmp	w8, #3
	b.eq	LBB7_6
; %bb.2:
	cmp	w8, #2
	b.ne	LBB7_17
; %bb.3:
	ubfx	w19, w20, #8, #8
	mov	x0, x19
	bl	_file_char_of_square
	mov	x21, x0
	mov	x0, x19
	bl	_rank_char_of_square
	mov	x19, x0
	and	w20, w20, #0xff
	mov	x0, x20
	bl	_file_char_of_square
	mov	x22, x0
	mov	x0, x20
	bl	_rank_char_of_square
	subs	w8, w21, w22
	b.ne	LBB7_18
; %bb.4:
Lloh4:
	adrp	x8, l_.str.13@PAGE
Lloh5:
	add	x8, x8, l_.str.13@PAGEOFF
	cmp	w0, w19
	csel	x0, x8, xzr, eq
LBB7_5:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB7_6:
	and	x8, x20, #0xfc0000
	cmp	x8, #64, lsl #12                ; =262144
	b.ne	LBB7_21
; %bb.7:
	ubfx	w21, w20, #8, #8
	mov	x0, x21
	bl	_file_char_of_square
	mov	x19, x0
	mov	x0, x21
	bl	_rank_char_of_square
	mov	x21, x0
	and	w22, w20, #0xff
	mov	x0, x22
	bl	_file_char_of_square
	mov	x20, x0
	mov	x0, x22
	bl	_rank_char_of_square
	cmp	w21, #56
	b.eq	LBB7_9
; %bb.8:
	and	w8, w21, #0xff
	cmp	w8, #49
	b.ne	LBB7_22
LBB7_9:
	cmp	w21, #56
	b.ne	LBB7_11
; %bb.10:
	cmp	w0, #55
	b.eq	LBB7_20
LBB7_11:
	cmp	w21, #49
	b.ne	LBB7_16
; %bb.12:
	cmp	w0, #50
	b.ne	LBB7_16
; %bb.13:
	mov	x0, #0
	cmp	w19, w20
	b.eq	LBB7_5
; %bb.14:
	add	w8, w20, #1
	cmp	w8, w19
	b.eq	LBB7_5
; %bb.15:
	sub	w8, w20, #1
	cmp	w8, w19
	b.eq	LBB7_5
LBB7_16:
Lloh6:
	adrp	x0, l_.str.12@PAGE
Lloh7:
	add	x0, x0, l_.str.12@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB7_17:
Lloh8:
	adrp	x0, l_.str.16@PAGE
Lloh9:
	add	x0, x0, l_.str.16@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB7_18:
	subs	w9, w19, w0
	b.eq	LBB7_20
; %bb.19:
	cmp	w8, #0
	cneg	w8, w8, mi
	cmp	w9, #0
	cneg	w9, w9, mi
	cmp	w9, w8, sxtb
	b.ne	LBB7_23
LBB7_20:
	mov	x0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB7_21:
Lloh10:
	adrp	x0, l_.str.15@PAGE
Lloh11:
	add	x0, x0, l_.str.15@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB7_22:
Lloh12:
	adrp	x0, l_.str.11@PAGE
Lloh13:
	add	x0, x0, l_.str.11@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB7_23:
	cmp	w8, #1
	ccmp	w9, #2, #0, eq
	cset	w10, eq
	cmp	w8, #2
	ccmp	w9, #1, #0, eq
	cset	w8, eq
	orr	w8, w10, w8
Lloh14:
	adrp	x9, l_.str.14@PAGE
Lloh15:
	add	x9, x9, l_.str.14@PAGEOFF
	cmp	w8, #0
	csel	x0, xzr, x9, ne
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh14, Lloh15
	.cfi_endproc
                                        ; -- End function
	.globl	_hash_move                      ; -- Begin function hash_move
	.p2align	2
_hash_move:                             ; @hash_move
	.cfi_startproc
; %bb.0:
	and	x8, x0, #0xff000000
	ubfx	x9, x0, #16, #8
	mov	w10, #50331648
	cmp	x8, x10
	csel	x8, x9, xzr, eq
	and	x9, x0, #0xff00
	lsl	w10, w0, #16
	and	x10, x10, #0xff0000
	orr	x9, x10, x9
	orr	x0, x9, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_unhash_move                    ; -- Begin function unhash_move
	.p2align	2
_unhash_move:                           ; @unhash_move
	.cfi_startproc
; %bb.0:
	and	w8, w0, #0xff00
	bfxil	w8, w0, #16, #8
	orr	w9, w8, #0x2000000
	bfi	w8, w0, #16, #8
	orr	w8, w8, #0x3000000
	tst	x0, #0xff
	csel	w0, w9, w8, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_moves_equal                    ; -- Begin function moves_equal
	.p2align	2
_moves_equal:                           ; @moves_equal
	.cfi_startproc
; %bb.0:
	ubfx	x8, x0, #24, #8
	cbz	w8, LBB10_2
; %bb.1:
	lsr	x9, x0, #8
	lsr	x10, x1, #8
	and	x11, x1, #0xff000000
	mov	w12, #33554432
	eor	w13, w1, w0
	eor	w14, w10, w9
	tst	x14, #0xff
	cset	w14, eq
	tst	x13, #0xff
	csel	w13, wzr, w14, ne
	cmp	x11, x12
	csel	w12, wzr, w13, ne
	mov	w13, #50331648
	eor	w14, w1, w0
	eor	w9, w10, w9
	tst	x9, #0xff
	cset	w9, eq
	tst	x14, #0xff
	csel	w9, wzr, w9, ne
	cmp	x11, x13
	csel	w9, wzr, w9, ne
	cmp	w8, #3
	csel	w9, wzr, w9, ne
	cmp	w8, #2
	csel	w0, w12, w9, eq
	ret
LBB10_2:
	tst	x1, #0xff000000
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_pointer_moves_equal            ; -- Begin function pointer_moves_equal
	.p2align	2
_pointer_moves_equal:                   ; @pointer_moves_equal
	.cfi_startproc
; %bb.0:
	ldr	w9, [x0, x1, lsl  #2]
	ldr	w10, [x2, x3, lsl  #2]
	ubfx	x8, x9, #24, #8
	cbz	w8, LBB11_2
; %bb.1:
	lsr	x11, x9, #8
	lsr	x12, x10, #8
	and	x13, x10, #0xff000000
	mov	w14, #33554432
	eor	w15, w10, w9
	eor	w16, w12, w11
	tst	x16, #0xff
	cset	w16, eq
	tst	x15, #0xff
	csel	w15, wzr, w16, ne
	cmp	x13, x14
	csel	w14, wzr, w15, ne
	mov	w15, #50331648
	eor	w9, w10, w9
	eor	w10, w12, w11
	tst	x10, #0xff
	cset	w10, eq
	tst	x9, #0xff
	csel	w9, wzr, w10, ne
	cmp	x13, x15
	csel	w9, wzr, w9, ne
	cmp	w8, #3
	csel	w9, wzr, w9, ne
	cmp	w8, #2
	csel	w0, w14, w9, eq
	ret
LBB11_2:
	ubfx	x8, x10, #24, #8
	cmp	w8, #0
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_error_move                  ; -- Begin function is_error_move
	.p2align	2
_is_error_move:                         ; @is_error_move
	.cfi_startproc
; %bb.0:
	and	x8, x0, #0xff000000
	mov	w9, #16777216
	cmp	x8, x9
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_null_move                   ; -- Begin function is_null_move
	.p2align	2
_is_null_move:                          ; @is_null_move
	.cfi_startproc
; %bb.0:
	tst	x0, #0xff000000
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_debug_print_board              ; -- Begin function debug_print_board
	.p2align	2
_debug_print_board:                     ; @debug_print_board
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
	mov	x19, x0
Lloh16:
	adrp	x0, l_str@PAGE
Lloh17:
	add	x0, x0, l_str@PAGEOFF
	bl	_puts
	ldr	x8, [x19]
	ldr	x0, [x8, #48]
	bl	_print_bitboard
Lloh18:
	adrp	x0, l_str.24@PAGE
Lloh19:
	add	x0, x0, l_str.24@PAGEOFF
	bl	_puts
	ldr	x8, [x19]
	ldr	x0, [x8, #56]
	bl	_print_bitboard
Lloh20:
	adrp	x0, l_str.25@PAGE
Lloh21:
	add	x0, x0, l_str.25@PAGEOFF
	bl	_puts
	ldr	x8, [x19]
	ldr	x0, [x8]
	bl	_print_bitboard
Lloh22:
	adrp	x0, l_str.26@PAGE
Lloh23:
	add	x0, x0, l_str.26@PAGEOFF
	bl	_puts
	ldr	x8, [x19]
	ldr	x0, [x8, #16]
	bl	_print_bitboard
Lloh24:
	adrp	x0, l_str.27@PAGE
Lloh25:
	add	x0, x0, l_str.27@PAGEOFF
	bl	_puts
	ldr	x8, [x19]
	ldr	x0, [x8, #8]
	bl	_print_bitboard
Lloh26:
	adrp	x0, l_str.28@PAGE
Lloh27:
	add	x0, x0, l_str.28@PAGEOFF
	bl	_puts
	ldr	x8, [x19]
	ldr	x0, [x8, #24]
	bl	_print_bitboard
Lloh28:
	adrp	x0, l_str.29@PAGE
Lloh29:
	add	x0, x0, l_str.29@PAGEOFF
	bl	_puts
	ldr	x8, [x19]
	ldr	x0, [x8, #32]
	bl	_print_bitboard
Lloh30:
	adrp	x0, l_str.30@PAGE
Lloh31:
	add	x0, x0, l_str.30@PAGEOFF
	bl	_puts
	ldr	x8, [x19]
	ldr	x0, [x8, #40]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_print_bitboard
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpAdd	Lloh28, Lloh29
	.loh AdrpAdd	Lloh26, Lloh27
	.loh AdrpAdd	Lloh24, Lloh25
	.loh AdrpAdd	Lloh22, Lloh23
	.loh AdrpAdd	Lloh20, Lloh21
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpAdd	Lloh16, Lloh17
	.cfi_endproc
                                        ; -- End function
	.globl	_get_castling_type              ; -- Begin function get_castling_type
	.p2align	2
_get_castling_type:                     ; @get_castling_type
	.cfi_startproc
; %bb.0:
	and	x8, x0, #0xff000000
	mov	w9, #33554432
	cmp	x8, x9
	b.ne	LBB15_8
; %bb.1:
	lsr	x9, x0, #8
	and	w8, w0, #0xff
	cmp	w8, #4
	b.ne	LBB15_4
; %bb.2:
	and	w9, w9, #0xff
	cmp	w9, #6
	b.eq	LBB15_9
; %bb.3:
	cmp	w9, #2
	b.eq	LBB15_11
	b	LBB15_8
LBB15_4:
	cmp	w8, #60
	b.ne	LBB15_8
; %bb.5:
	and	w9, w9, #0xff
	cmp	w9, #62
	b.eq	LBB15_10
; %bb.6:
	cmp	w9, #58
	b.ne	LBB15_8
; %bb.7:
	mov	w9, #8
	b	LBB15_11
LBB15_8:
	mov	w0, #0
	ret
LBB15_9:
	mov	w9, #1
	b	LBB15_11
LBB15_10:
	mov	w9, #4
LBB15_11:
	ldr	x10, [x1]
	cmp	w8, #4
	mov	w11, #56
	mov	w12, #48
	csel	x11, x12, x11, eq
	ldr	x11, [x10, x11]
	ldr	x10, [x10, #40]
	mov	w12, #1
	lsl	x8, x12, x8
	and	x8, x11, x8
	tst	x8, x10
	csel	w0, wzr, w9, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_uci_body                 ; -- Begin function write_uci_body
	.p2align	2
_write_uci_body:                        ; @write_uci_body
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
	mov	x19, x1
	mov	x20, x0
	and	w21, w20, #0xff
	mov	x0, x21
	bl	_file_char_of_square
	strb	w0, [x19]
	mov	x0, x21
	bl	_rank_char_of_square
	strb	w0, [x19, #1]
	ubfx	w20, w20, #8, #8
	mov	x0, x20
	bl	_file_char_of_square
	strb	w0, [x19, #2]
	mov	x0, x20
	bl	_rank_char_of_square
	strb	w0, [x19, #3]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_uci                      ; -- Begin function write_uci
	.p2align	2
_write_uci:                             ; @write_uci
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
	mov	x19, x1
	ubfx	x8, x0, #24, #8
	cbz	w8, LBB17_4
; %bb.1:
	mov	x20, x0
	cmp	w8, #3
	b.eq	LBB17_5
; %bb.2:
	cmp	w8, #2
	b.ne	LBB17_6
; %bb.3:
	and	w21, w20, #0xff
	mov	x0, x21
	bl	_file_char_of_square
	strb	w0, [x19]
	mov	x0, x21
	bl	_rank_char_of_square
	strb	w0, [x19, #1]
	ubfx	w20, w20, #8, #8
	mov	x0, x20
	bl	_file_char_of_square
	strb	w0, [x19, #2]
	mov	x0, x20
	bl	_rank_char_of_square
	strb	w0, [x19, #3]
	strb	wzr, [x19, #4]
	mov	w0, #1
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB17_4:
	strb	wzr, [x19, #4]
	mov	w8, #808464432
	str	w8, [x19]
	mov	w0, #1
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB17_5:
	and	w21, w20, #0xff
	mov	x0, x21
	bl	_file_char_of_square
	strb	w0, [x19]
	mov	x0, x21
	bl	_rank_char_of_square
	strb	w0, [x19, #1]
	ubfx	w21, w20, #8, #8
	mov	x0, x21
	bl	_file_char_of_square
	strb	w0, [x19, #2]
	mov	x0, x21
	bl	_rank_char_of_square
	strb	w0, [x19, #3]
	ubfx	w0, w20, #16, #8
	bl	_piece_type_symbol
	strb	w0, [x19, #4]
	strb	wzr, [x19, #5]
	mov	w0, #1
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB17_6:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_pointer_write_uci              ; -- Begin function pointer_write_uci
	.p2align	2
_pointer_write_uci:                     ; @pointer_write_uci
	.cfi_startproc
; %bb.0:
	ldr	w0, [x0, x1, lsl  #2]
	mov	x1, x2
	b	_write_uci
	.cfi_endproc
                                        ; -- End function
	.globl	_err_promotion_move_with        ; -- Begin function err_promotion_move_with
	.p2align	2
_err_promotion_move_with:               ; @err_promotion_move_with
	.cfi_startproc
; %bb.0:
	cmp	w3, #56
	b.eq	LBB19_2
; %bb.1:
	cmp	w3, #49
	b.ne	LBB19_5
LBB19_2:
	cmp	w1, #55
	b.ne	LBB19_6
; %bb.3:
	cmp	w3, #56
	b.ne	LBB19_6
; %bb.4:
	mov	x0, #0
	ret
LBB19_5:
Lloh32:
	adrp	x0, l_.str.11@PAGE
Lloh33:
	add	x0, x0, l_.str.11@PAGEOFF
	ret
LBB19_6:
	cmp	w1, #50
	b.ne	LBB19_11
; %bb.7:
	cmp	w3, #49
	b.ne	LBB19_11
; %bb.8:
	mov	x8, #0
	cmp	w2, w0
	b.eq	LBB19_12
; %bb.9:
	add	w9, w0, #1
	cmp	w9, w2
	b.eq	LBB19_12
; %bb.10:
	sub	w9, w0, #1
	cmp	w9, w2
	b.eq	LBB19_12
LBB19_11:
Lloh34:
	adrp	x8, l_.str.12@PAGE
Lloh35:
	add	x8, x8, l_.str.12@PAGEOFF
LBB19_12:
	mov	x0, x8
	ret
	.loh AdrpAdd	Lloh32, Lloh33
	.loh AdrpAdd	Lloh34, Lloh35
	.cfi_endproc
                                        ; -- End function
	.globl	_err_generic_move_with          ; -- Begin function err_generic_move_with
	.p2align	2
_err_generic_move_with:                 ; @err_generic_move_with
	.cfi_startproc
; %bb.0:
	subs	w8, w2, w0
	b.ne	LBB20_2
; %bb.1:
Lloh36:
	adrp	x8, l_.str.13@PAGE
Lloh37:
	add	x8, x8, l_.str.13@PAGEOFF
	cmp	w1, w3
	csel	x0, x8, xzr, eq
	ret
LBB20_2:
	subs	w9, w3, w1
	b.ne	LBB20_4
; %bb.3:
	mov	x0, #0
	ret
LBB20_4:
	cmp	w8, #0
	cneg	w8, w8, mi
	cmp	w9, #0
	cneg	w9, w9, mi
	cmp	w9, w8, sxtb
	b.ne	LBB20_6
; %bb.5:
	mov	x0, #0
	ret
LBB20_6:
	cmp	w8, #1
	ccmp	w9, #2, #0, eq
	cset	w10, eq
	cmp	w8, #2
	ccmp	w9, #1, #0, eq
	cset	w8, eq
	orr	w8, w10, w8
Lloh38:
	adrp	x9, l_.str.14@PAGE
Lloh39:
	add	x9, x9, l_.str.14@PAGEOFF
	cmp	w8, #0
	csel	x0, xzr, x9, ne
	ret
	.loh AdrpAdd	Lloh36, Lloh37
	.loh AdrpAdd	Lloh38, Lloh39
	.cfi_endproc
                                        ; -- End function
	.globl	_err_generic_move               ; -- Begin function err_generic_move
	.p2align	2
_err_generic_move:                      ; @err_generic_move
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
	mov	x20, x0
	ubfx	w19, w20, #8, #8
	mov	x0, x19
	bl	_file_char_of_square
	mov	x21, x0
	mov	x0, x19
	bl	_rank_char_of_square
	mov	x19, x0
	and	w20, w20, #0xff
	mov	x0, x20
	bl	_file_char_of_square
	mov	x22, x0
	mov	x0, x20
	bl	_rank_char_of_square
	subs	w8, w21, w22
	b.ne	LBB21_2
; %bb.1:
Lloh40:
	adrp	x8, l_.str.13@PAGE
Lloh41:
	add	x8, x8, l_.str.13@PAGEOFF
	cmp	w0, w19
	csel	x0, x8, xzr, eq
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB21_2:
	subs	w9, w19, w0
	b.ne	LBB21_4
; %bb.3:
	mov	x0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB21_4:
	cmp	w8, #0
	cneg	w8, w8, mi
	cmp	w9, #0
	cneg	w9, w9, mi
	cmp	w9, w8, sxtb
	b.ne	LBB21_6
; %bb.5:
	mov	x0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB21_6:
	cmp	w8, #1
	ccmp	w9, #2, #0, eq
	cset	w10, eq
	cmp	w8, #2
	ccmp	w9, #1, #0, eq
	cset	w8, eq
	orr	w8, w10, w8
Lloh42:
	adrp	x9, l_.str.14@PAGE
Lloh43:
	add	x9, x9, l_.str.14@PAGEOFF
	cmp	w8, #0
	csel	x0, xzr, x9, ne
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh40, Lloh41
	.loh AdrpAdd	Lloh42, Lloh43
	.cfi_endproc
                                        ; -- End function
	.globl	_err_promotion_move             ; -- Begin function err_promotion_move
	.p2align	2
_err_promotion_move:                    ; @err_promotion_move
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
	and	x8, x0, #0xfc0000
	cmp	x8, #64, lsl #12                ; =262144
	b.ne	LBB22_7
; %bb.1:
	mov	x20, x0
	ubfx	w21, w20, #8, #8
	mov	x0, x21
	bl	_file_char_of_square
	mov	x19, x0
	mov	x0, x21
	bl	_rank_char_of_square
	mov	x21, x0
	and	w22, w20, #0xff
	mov	x0, x22
	bl	_file_char_of_square
	mov	x20, x0
	mov	x0, x22
	bl	_rank_char_of_square
	cmp	w21, #56
	b.eq	LBB22_3
; %bb.2:
	and	w8, w21, #0xff
	cmp	w8, #49
	b.ne	LBB22_8
LBB22_3:
	cmp	w21, #56
	b.ne	LBB22_9
; %bb.4:
	cmp	w0, #55
	b.ne	LBB22_9
; %bb.5:
	mov	x0, #0
LBB22_6:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB22_7:
Lloh44:
	adrp	x0, l_.str.15@PAGE
Lloh45:
	add	x0, x0, l_.str.15@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB22_8:
Lloh46:
	adrp	x0, l_.str.11@PAGE
Lloh47:
	add	x0, x0, l_.str.11@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB22_9:
	cmp	w21, #49
	b.ne	LBB22_14
; %bb.10:
	cmp	w0, #50
	b.ne	LBB22_14
; %bb.11:
	mov	x0, #0
	cmp	w19, w20
	b.eq	LBB22_6
; %bb.12:
	add	w8, w20, #1
	cmp	w8, w19
	b.eq	LBB22_6
; %bb.13:
	sub	w8, w20, #1
	cmp	w8, w19
	b.eq	LBB22_6
LBB22_14:
Lloh48:
	adrp	x0, l_.str.12@PAGE
Lloh49:
	add	x0, x0, l_.str.12@PAGEOFF
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh44, Lloh45
	.loh AdrpAdd	Lloh46, Lloh47
	.loh AdrpAdd	Lloh48, Lloh49
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_uci                      ; -- Begin function parse_uci
	.p2align	2
_parse_uci:                             ; @parse_uci
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
	cbz	x0, LBB23_11
; %bb.1:
	mov	x20, x0
	ldrb	w8, [x0]
	cbz	w8, LBB23_13
; %bb.2:
	mov	x19, x1
	cmp	w8, #48
	b.ne	LBB23_14
; %bb.3:
	ldrb	w9, [x20, #1]
	cbz	w9, LBB23_13
; %bb.4:
	cmp	w9, #48
	b.ne	LBB23_15
; %bb.5:
	ldrb	w9, [x20, #2]
	cbz	w9, LBB23_13
; %bb.6:
	cmp	w9, #48
	b.ne	LBB23_23
; %bb.7:
	ldrb	w9, [x20, #3]
	cbz	w9, LBB23_13
; %bb.8:
	cmp	w9, #48
	b.ne	LBB23_23
; %bb.9:
	ldrb	w8, [x20, #4]
	cbnz	w8, LBB23_39
; %bb.10:
	mov	x0, #0
	str	wzr, [x19]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_11:
Lloh50:
	adrp	x0, l_.str.18@PAGE
Lloh51:
	add	x0, x0, l_.str.18@PAGEOFF
LBB23_12:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_13:
Lloh52:
	adrp	x0, l_.str.19@PAGE
Lloh53:
	add	x0, x0, l_.str.19@PAGEOFF
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_14:
	ldrb	w9, [x20, #1]
LBB23_15:
	sxtb	w0, w8
	sxtb	w1, w9
	bl	_valid_square_chars
	cbz	w0, LBB23_39
LBB23_16:
	ldrsb	w0, [x20, #2]
	ldrsb	w1, [x20, #3]
	bl	_valid_square_chars
	cbz	w0, LBB23_39
; %bb.17:
	ldrsb	w0, [x20, #4]
	cbz	w0, LBB23_20
; %bb.18:
	tbnz	w0, #31, LBB23_30
; %bb.19:
Lloh54:
	adrp	x8, __DefaultRuneLocale@GOTPAGE
Lloh55:
	ldr	x8, [x8, __DefaultRuneLocale@GOTPAGEOFF]
	add	x8, x8, w0, uxtw #2
	ldr	w8, [x8, #60]
	and	w0, w8, #0x4000
	cbz	w0, LBB23_31
LBB23_20:
	ldrb	w10, [x20]
	ldrsb	w1, [x20, #1]
	ldrb	w8, [x20, #2]
	ldrsb	w9, [x20, #3]
	sxtb	w0, w10
	cmp	w8, w10
	b.ne	LBB23_24
; %bb.21:
	cmp	w1, w9
	b.ne	LBB23_29
; %bb.22:
Lloh56:
	adrp	x0, l_.str.13@PAGE
Lloh57:
	add	x0, x0, l_.str.13@PAGEOFF
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_23:
	mov	w9, #48
	sxtb	w0, w8
	sxtb	w1, w9
	bl	_valid_square_chars
	cbz	w0, LBB23_39
	b	LBB23_16
LBB23_24:
	subs	w9, w9, w1
	b.eq	LBB23_29
; %bb.25:
	sxtb	w8, w8
	subs	w8, w8, w0
	cneg	w8, w8, mi
	cmp	w9, #0
	cneg	w9, w9, mi
	cmp	w9, w8, sxtb
	b.eq	LBB23_29
; %bb.26:
	cmp	w8, #2
	ccmp	w9, #1, #0, eq
	cset	w10, eq
	cmp	w9, #2
	ccmp	w8, #1, #0, eq
	b.eq	LBB23_29
; %bb.27:
	cbnz	w10, LBB23_29
; %bb.28:
Lloh58:
	adrp	x0, l_.str.14@PAGE
Lloh59:
	add	x0, x0, l_.str.14@PAGEOFF
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_29:
	bl	_make_square
	mov	x21, x0
	ldrsb	w0, [x20, #2]
	ldrsb	w1, [x20, #3]
	bl	_make_square
	mov	x8, x0
	mov	x0, #0
	bfi	w21, w8, #8, #8
	orr	w8, w21, #0x2000000
	str	w8, [x19]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_30:
	mov	w1, #16384
	bl	___maskrune
	cbnz	w0, LBB23_20
LBB23_31:
	ldrsb	w0, [x20, #5]
	cbz	w0, LBB23_36
; %bb.32:
	tbnz	w0, #31, LBB23_34
; %bb.33:
Lloh60:
	adrp	x8, __DefaultRuneLocale@GOTPAGE
Lloh61:
	ldr	x8, [x8, __DefaultRuneLocale@GOTPAGEOFF]
	add	x8, x8, w0, uxtw #2
	ldr	w8, [x8, #60]
	and	w0, w8, #0x4000
	b	LBB23_35
LBB23_34:
	mov	w1, #16384
	bl	___maskrune
LBB23_35:
	cbz	w0, LBB23_39
LBB23_36:
	ldrsb	w0, [x20, #4]
	bl	___tolower
	sxtb	w8, w0
	sub	w8, w8, #98
	cmp	w8, #16
	b.hi	LBB23_39
; %bb.37:
Lloh62:
	adrp	x0, l_.str.20@PAGE
Lloh63:
	add	x0, x0, l_.str.20@PAGEOFF
	mov	w23, #458752
Lloh64:
	adrp	x9, lJTI23_0@PAGE
Lloh65:
	add	x9, x9, lJTI23_0@PAGEOFF
	adr	x10, LBB23_12
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB23_38:
	mov	w23, #327680
	b	LBB23_43
LBB23_39:
Lloh66:
	adrp	x0, l_.str.17@PAGE
Lloh67:
	add	x0, x0, l_.str.17@PAGEOFF
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_40:
Lloh68:
	adrp	x0, l_.str.21@PAGE
Lloh69:
	add	x0, x0, l_.str.21@PAGEOFF
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_41:
	mov	w23, #262144
	b	LBB23_43
LBB23_42:
	mov	w23, #393216
LBB23_43:
	ldrsb	w21, [x20]
	ldrsb	w22, [x20, #1]
	ldrsb	w2, [x20, #2]
	ldrsb	w3, [x20, #3]
	mov	x0, x21
	mov	x1, x22
	bl	_err_promotion_move_with
	cbnz	x0, LBB23_12
; %bb.44:
	and	w8, w21, #0xff
	and	w9, w22, #0xff
	sxtb	w0, w8
	sxtb	w1, w9
	bl	_make_square
	mov	x21, x0
	ldrsb	w0, [x20, #2]
	ldrsb	w1, [x20, #3]
	bl	_make_square
	mov	x8, x0
	mov	x0, #0
	bfi	w21, w8, #8, #8
	orr	w8, w21, w23
	orr	w8, w8, #0x3000000
	str	w8, [x19]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh50, Lloh51
	.loh AdrpAdd	Lloh52, Lloh53
	.loh AdrpLdrGot	Lloh54, Lloh55
	.loh AdrpAdd	Lloh56, Lloh57
	.loh AdrpAdd	Lloh58, Lloh59
	.loh AdrpLdrGot	Lloh60, Lloh61
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpAdd	Lloh62, Lloh63
	.loh AdrpAdd	Lloh66, Lloh67
	.loh AdrpAdd	Lloh68, Lloh69
	.cfi_endproc
	.section	__TEXT,__const
lJTI23_0:
	.byte	(LBB23_38-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_40-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_41-LBB23_12)>>2
	.byte	(LBB23_39-LBB23_12)>>2
	.byte	(LBB23_12-LBB23_12)>>2
	.byte	(LBB23_43-LBB23_12)>>2
	.byte	(LBB23_42-LBB23_12)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_san_parse_piece_type           ; -- Begin function san_parse_piece_type
	.p2align	2
_san_parse_piece_type:                  ; @san_parse_piece_type
	.cfi_startproc
; %bb.0:
	sub	w8, w0, #66
	cmp	w8, #16
	b.hi	LBB24_3
; %bb.1:
	mov	w0, #5
Lloh70:
	adrp	x9, lJTI24_0@PAGE
Lloh71:
	add	x9, x9, lJTI24_0@PAGEOFF
	adr	x10, LBB24_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB24_2:
	mov	w0, #8
	ret
LBB24_3:
	mov	w0, #0
LBB24_4:
	ret
LBB24_5:
	mov	w0, #4
	ret
LBB24_6:
	mov	w0, #7
	ret
LBB24_7:
	mov	w0, #6
	ret
	.loh AdrpAdd	Lloh70, Lloh71
	.cfi_endproc
	.section	__TEXT,__const
lJTI24_0:
	.byte	(LBB24_4-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_2-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_5-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_3-LBB24_2)>>2
	.byte	(LBB24_6-LBB24_2)>>2
	.byte	(LBB24_7-LBB24_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_san_parse_file                 ; -- Begin function san_parse_file
	.p2align	2
_san_parse_file:                        ; @san_parse_file
	.cfi_startproc
; %bb.0:
	sub	w8, w0, #97
	cmp	w8, #8
	cset	w0, lo
	bfi	w0, w8, #8, #24
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_san_parse_rank                 ; -- Begin function san_parse_rank
	.p2align	2
_san_parse_rank:                        ; @san_parse_rank
	.cfi_startproc
; %bb.0:
	sub	w8, w0, #49
	cmp	w8, #8
	cset	w0, lo
	bfi	w0, w8, #8, #24
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_ann_helper               ; -- Begin function parse_ann_helper
	.p2align	2
_parse_ann_helper:                      ; @parse_ann_helper
	.cfi_startproc
; %bb.0:
	ldrsb	w8, [x0]
	cbz	w8, LBB27_4
; %bb.1:
	ldrb	w9, [x0, #1]
	cbz	w9, LBB27_3
; %bb.2:
	mov	w0, #7
	ret
LBB27_3:
	mov	w9, #7
	cmp	w8, #63
	csel	w9, w9, w1, ne
	cmp	w8, #33
	csel	w9, w2, w9, eq
	cmp	w8, #0
	csel	w3, w3, w9, eq
LBB27_4:
	mov	x0, x3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_ann                      ; -- Begin function parse_ann
	.p2align	2
_parse_ann:                             ; @parse_ann
	.cfi_startproc
; %bb.0:
	ldrsb	w8, [x0]
	cbz	w8, LBB28_9
; %bb.1:
	cmp	w8, #33
	b.eq	LBB28_10
; %bb.2:
	cmp	w8, #63
	b.ne	LBB28_12
; %bb.3:
	ldrsb	w8, [x0, #1]
	cbz	w8, LBB28_13
; %bb.4:
	ldrb	w9, [x0, #2]
	cbnz	w9, LBB28_12
; %bb.5:
	cbz	w8, LBB28_13
; %bb.6:
	cmp	w8, #33
	b.eq	LBB28_16
; %bb.7:
	cmp	w8, #63
	b.ne	LBB28_12
; %bb.8:
	mov	w0, #1
	ret
LBB28_9:
	mov	w0, #0
	ret
LBB28_10:
	ldrsb	w8, [x0, #1]
	cbz	w8, LBB28_14
; %bb.11:
	ldrb	w9, [x0, #2]
	cbz	w9, LBB28_15
LBB28_12:
	mov	w0, #7
	ret
LBB28_13:
	mov	w0, #2
	ret
LBB28_14:
	mov	w0, #5
	ret
LBB28_15:
	mov	w9, #5
	mov	w10, #6
	mov	w11, #7
	mov	w12, #4
	cmp	w8, #63
	csel	w11, w11, w12, ne
	cmp	w8, #33
	csel	w10, w10, w11, eq
	cmp	w8, #0
	csel	w0, w9, w10, eq
	ret
LBB28_16:
	mov	w0, #3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_san_status               ; -- Begin function parse_san_status
	.p2align	2
_parse_san_status:                      ; @parse_san_status
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB29_4
; %bb.1:
	ldrsb	w8, [x0]
	cmp	w8, #35
	b.eq	LBB29_5
; %bb.2:
	cmp	w8, #43
	b.ne	LBB29_4
; %bb.3:
	ldrb	w8, [x0, #1]
	cmp	w8, #43
	mov	w8, #1
	cinc	w8, w8, eq
	mov	x9, x8
	strb	w8, [x1]
	and	w0, w9, #0xff
	ret
LBB29_4:
	mov	w8, #0
	mov	w9, #0
	strb	w8, [x1]
	and	w0, w9, #0xff
	ret
LBB29_5:
	mov	w9, #1
	mov	w8, #2
	strb	w8, [x1]
	and	w0, w9, #0xff
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_pawn_capture_san         ; -- Begin function parse_pawn_capture_san
	.p2align	2
_parse_pawn_capture_san:                ; @parse_pawn_capture_san
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
	ldrb	w8, [x0]
	sub	w21, w8, #97
	cmp	w21, #7
	b.ls	LBB30_2
; %bb.1:
	mov	x10, #0
	mov	x11, #0
                                        ; implicit-def: $w20
                                        ; implicit-def: $w22
	b	LBB30_11
LBB30_2:
	mov	x19, x0
	ldrb	w8, [x0, #1]
	sub	w22, w8, #49
	cmp	w22, #8
	cset	w20, lo
	cmp	w22, #7
	b.hi	LBB30_5
; %bb.3:
	ldrb	w9, [x19, #2]
	cbz	w9, LBB30_5
; %bb.4:
	mov	w23, #2
	mov	x8, x9
	cmp	w8, #120
	b.eq	LBB30_6
	b	LBB30_10
LBB30_5:
	mov	w23, #1
	cmp	w8, #120
	b.ne	LBB30_10
LBB30_6:
	add	x24, x19, w23, uxtw
	ldrb	w8, [x24, #1]
	cbz	w8, LBB30_10
; %bb.7:
	ldrb	w8, [x24, #2]
	cbz	w8, LBB30_10
; %bb.8:
	add	x0, x24, #1
	bl	_parse_square
                                        ; kill: def $w0 killed $w0 def $x0
	tbnz	w0, #8, LBB30_15
; %bb.9:
	mov	x10, #0
	mov	x11, #0
	b	LBB30_12
LBB30_10:
	mov	x10, #0
	mov	x11, #0
LBB30_11:
                                        ; implicit-def: $w0
LBB30_12:
                                        ; implicit-def: $w8
LBB30_13:
                                        ; implicit-def: $w9
LBB30_14:
	and	x12, x21, #0xff
	and	w8, w8, #0xff
	orr	x8, x10, x8, lsl #32
	and	x10, x0, #0xff
	orr	x8, x8, x10, lsl #24
	and	x10, x22, #0xff
	orr	x8, x8, x10, lsl #16
	and	x10, x20, #0xff
	orr	x8, x8, x10, lsl #8
	orr	x0, x8, x12
	and	x8, x9, #0xff
	orr	x1, x11, x8, lsl #8
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB30_15:
	ldrsb	w10, [x24, #3]
	cmp	w10, #61
	b.ne	LBB30_20
; %bb.16:
	mov	x10, #0
	ldrsb	w8, [x24, #4]
	sub	w9, w8, #66
	cmp	w9, #16
	b.hi	LBB30_55
; %bb.17:
	mov	w8, #5
Lloh72:
	adrp	x11, lJTI30_1@PAGE
Lloh73:
	add	x11, x11, lJTI30_1@PAGEOFF
	adr	x12, LBB30_14
	ldrb	w13, [x11, x9]
	add	x12, x12, x13, lsl #2
	mov	x11, x10
                                        ; implicit-def: $w9
	br	x12
LBB30_18:
	mov	w8, #8
LBB30_19:
	add	w10, w23, #5
	b	LBB30_31
LBB30_20:
	mov	w8, #0
	mov	w9, #3
	sub	w11, w10, #66
	cmp	w11, #16
	b.hi	LBB30_30
; %bb.21:
	mov	w10, #5
Lloh74:
	adrp	x12, lJTI30_0@PAGE
Lloh75:
	add	x12, x12, lJTI30_0@PAGEOFF
	adr	x13, LBB30_22
	ldrb	w14, [x12, x11]
	add	x13, x13, x14, lsl #2
	br	x13
LBB30_22:
	mov	w10, #8
	b	LBB30_29
LBB30_23:
	mov	w8, #4
	add	w10, w23, #5
	b	LBB30_31
LBB30_24:
	mov	w8, #7
	add	w10, w23, #5
	b	LBB30_31
LBB30_25:
	mov	w8, #6
	add	w10, w23, #5
	b	LBB30_31
LBB30_26:
	mov	w10, #4
	b	LBB30_29
LBB30_27:
	mov	w10, #7
	b	LBB30_29
LBB30_28:
	mov	w10, #6
LBB30_29:
	mov	w9, #4
	mov	x8, x10
LBB30_30:
	add	w10, w9, w23
LBB30_31:
	add	x9, x19, w10, uxtw
	ldrsb	w11, [x9]
	cmp	w11, #35
	b.eq	LBB30_34
; %bb.32:
	cmp	w11, #43
	b.ne	LBB30_35
; %bb.33:
	ldrb	w9, [x9, #1]
	cmp	w9, #43
	mov	w9, #1
	cinc	w9, w9, eq
	mov	x11, x9
	b	LBB30_36
LBB30_34:
	mov	w11, #1
	mov	w9, #2
	b	LBB30_36
LBB30_35:
	mov	w9, #0
	mov	w11, #0
LBB30_36:
	add	w10, w11, w10
	add	x10, x19, w10, uxtb
	ldrsb	w11, [x10]
	cbz	w11, LBB30_45
; %bb.37:
	cmp	w11, #33
	b.eq	LBB30_46
; %bb.38:
	cmp	w11, #63
	b.ne	LBB30_48
; %bb.39:
	ldrsb	w11, [x10, #1]
	cbz	w11, LBB30_49
; %bb.40:
	ldrb	w10, [x10, #2]
	cbnz	w10, LBB30_48
; %bb.41:
	cbz	w11, LBB30_49
; %bb.42:
	cmp	w11, #33
	b.eq	LBB30_56
; %bb.43:
	cmp	w11, #63
	b.ne	LBB30_48
; %bb.44:
	mov	x10, #216172782113783808
	mov	w11, #1
	b	LBB30_14
LBB30_45:
	mov	x10, #216172782113783808
	b	LBB30_14
LBB30_46:
	ldrsb	w11, [x10, #1]
	cbz	w11, LBB30_54
; %bb.47:
	ldrb	w10, [x10, #2]
	cbz	w10, LBB30_50
LBB30_48:
	mov	x10, #0
	mov	w11, #7
	b	LBB30_13
LBB30_49:
	mov	x10, #216172782113783808
	mov	w11, #2
	b	LBB30_14
LBB30_50:
	cbz	w11, LBB30_54
; %bb.51:
	cmp	w11, #33
	b.eq	LBB30_57
; %bb.52:
	cmp	w11, #63
	b.ne	LBB30_48
; %bb.53:
	mov	x10, #216172782113783808
	mov	w11, #4
	b	LBB30_14
LBB30_54:
	mov	x10, #216172782113783808
	mov	w11, #5
	b	LBB30_14
LBB30_55:
                                        ; implicit-def: $w8
	mov	x11, x10
	b	LBB30_13
LBB30_56:
	mov	x10, #216172782113783808
	mov	w11, #3
	b	LBB30_14
LBB30_57:
	mov	x10, #216172782113783808
	mov	w11, #6
	b	LBB30_14
	.loh AdrpAdd	Lloh72, Lloh73
	.loh AdrpAdd	Lloh74, Lloh75
	.cfi_endproc
	.section	__TEXT,__const
lJTI30_0:
	.byte	(LBB30_29-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_22-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_26-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_30-LBB30_22)>>2
	.byte	(LBB30_27-LBB30_22)>>2
	.byte	(LBB30_28-LBB30_22)>>2
lJTI30_1:
	.byte	(LBB30_19-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_18-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_23-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_14-LBB30_14)>>2
	.byte	(LBB30_24-LBB30_14)>>2
	.byte	(LBB30_25-LBB30_14)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_parse_pawn_push_san            ; -- Begin function parse_pawn_push_san
	.p2align	2
_parse_pawn_push_san:                   ; @parse_pawn_push_san
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
	mov	x19, x0
	bl	_parse_square
	tbnz	w0, #8, LBB31_2
; %bb.1:
	mov	x10, #0
	mov	x11, #0
                                        ; implicit-def: $w8
                                        ; implicit-def: $w9
	b	LBB31_34
LBB31_2:
	ldrsb	w9, [x19, #2]
	cmp	w9, #61
	b.ne	LBB31_6
; %bb.3:
	mov	w1, #0
	ldrsb	w8, [x19, #3]
	sub	w9, w8, #66
	cmp	w9, #16
	b.hi	LBB31_41
; %bb.4:
	mov	w10, #4
	mov	w8, #5
Lloh76:
	adrp	x11, lJTI31_1@PAGE
Lloh77:
	add	x11, x11, lJTI31_1@PAGEOFF
	adr	x12, LBB31_5
	ldrb	w13, [x11, x9]
	add	x12, x12, x13, lsl #2
                                        ; implicit-def: $w9
	br	x12
LBB31_5:
	mov	w10, #4
	mov	w8, #8
	b	LBB31_16
LBB31_6:
	mov	w8, #0
	mov	w10, #2
	sub	w11, w9, #66
	cmp	w11, #16
	b.hi	LBB31_16
; %bb.7:
	mov	w9, #5
Lloh78:
	adrp	x12, lJTI31_0@PAGE
Lloh79:
	add	x12, x12, lJTI31_0@PAGEOFF
	adr	x13, LBB31_8
	ldrb	w14, [x12, x11]
	add	x13, x13, x14, lsl #2
	br	x13
LBB31_8:
	mov	w9, #8
	b	LBB31_15
LBB31_9:
	mov	w8, #4
	mov	w10, #4
	b	LBB31_16
LBB31_10:
	mov	w10, #4
	mov	w8, #7
	b	LBB31_16
LBB31_11:
	mov	w10, #4
	mov	w8, #6
	b	LBB31_16
LBB31_12:
	mov	w9, #4
	b	LBB31_15
LBB31_13:
	mov	w9, #7
	b	LBB31_15
LBB31_14:
	mov	w9, #6
LBB31_15:
	mov	w10, #3
	mov	x8, x9
LBB31_16:
	add	x9, x19, w10, uxtw
	ldrsb	w11, [x9]
	cmp	w11, #35
	b.eq	LBB31_20
; %bb.17:
	cmp	w11, #43
	b.ne	LBB31_21
; %bb.18:
	ldrb	w9, [x9, #1]
	cmp	w9, #43
	mov	w9, #1
	cinc	w9, w9, eq
	mov	x11, x9
	add	w10, w11, w10
	add	x10, x19, w10, uxtb
	ldrsb	w11, [x10]
	cbnz	w11, LBB31_22
LBB31_19:
	mov	x10, #144115188075855872
	b	LBB31_34
LBB31_20:
	mov	w11, #1
	mov	w9, #2
	add	w10, w11, w10
	add	x10, x19, w10, uxtb
	ldrsb	w11, [x10]
	cbnz	w11, LBB31_22
	b	LBB31_19
LBB31_21:
	mov	w9, #0
	mov	w11, #0
	add	w10, w11, w10
	add	x10, x19, w10, uxtb
	ldrsb	w11, [x10]
	cbz	w11, LBB31_19
LBB31_22:
	cmp	w11, #33
	b.eq	LBB31_30
; %bb.23:
	cmp	w11, #63
	b.ne	LBB31_32
; %bb.24:
	ldrsb	w11, [x10, #1]
	cbz	w11, LBB31_35
; %bb.25:
	ldrb	w10, [x10, #2]
	cbnz	w10, LBB31_32
; %bb.26:
	cbz	w11, LBB31_35
; %bb.27:
	cmp	w11, #33
	b.eq	LBB31_42
; %bb.28:
	cmp	w11, #63
	b.ne	LBB31_32
; %bb.29:
	mov	x10, #144115188075855872
	mov	w11, #1
	b	LBB31_34
LBB31_30:
	ldrsb	w11, [x10, #1]
	cbz	w11, LBB31_40
; %bb.31:
	ldrb	w10, [x10, #2]
	cbz	w10, LBB31_36
LBB31_32:
	mov	x1, x8
LBB31_33:
	mov	x10, #0
	mov	w11, #7
	mov	x8, x1
LBB31_34:
	and	w8, w8, #0xff
	orr	x8, x10, x8, lsl #40
	and	w10, w0, #0xff
	orr	x0, x8, x10, lsl #32
	and	x8, x9, #0xff
	orr	x1, x11, x8, lsl #8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB31_35:
	mov	x10, #144115188075855872
	mov	w11, #2
	b	LBB31_34
LBB31_36:
	cbz	w11, LBB31_40
; %bb.37:
	cmp	w11, #33
	b.eq	LBB31_43
; %bb.38:
	cmp	w11, #63
	b.ne	LBB31_32
; %bb.39:
	mov	x10, #144115188075855872
	mov	w11, #4
	b	LBB31_34
LBB31_40:
	mov	x10, #144115188075855872
	mov	w11, #5
	b	LBB31_34
LBB31_41:
                                        ; implicit-def: $w9
	b	LBB31_33
LBB31_42:
	mov	x10, #144115188075855872
	mov	w11, #3
	b	LBB31_34
LBB31_43:
	mov	x10, #144115188075855872
	mov	w11, #6
	b	LBB31_34
	.loh AdrpAdd	Lloh76, Lloh77
	.loh AdrpAdd	Lloh78, Lloh79
	.cfi_endproc
	.section	__TEXT,__const
lJTI31_0:
	.byte	(LBB31_15-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_8-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_12-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_16-LBB31_8)>>2
	.byte	(LBB31_13-LBB31_8)>>2
	.byte	(LBB31_14-LBB31_8)>>2
lJTI31_1:
	.byte	(LBB31_16-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_5-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_9-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_33-LBB31_5)>>2
	.byte	(LBB31_10-LBB31_5)>>2
	.byte	(LBB31_11-LBB31_5)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_parse_pawn_san                 ; -- Begin function parse_pawn_san
	.p2align	2
_parse_pawn_san:                        ; @parse_pawn_san
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldrb	w8, [x0, #1]
	cbz	w8, LBB32_4
; %bb.1:
	cmp	w8, #120
	b.eq	LBB32_3
; %bb.2:
	ldrb	w8, [x0, #2]
	cmp	w8, #120
	b.ne	LBB32_5
LBB32_3:
	bl	_parse_pawn_capture_san
	b	LBB32_6
LBB32_4:
	and	x9, x8, #0xffffffffffffff
	orr	x0, x9, x8
	and	x1, x8, #0xffff
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB32_5:
	bl	_parse_pawn_push_san
LBB32_6:
	and	x8, x0, #0xff00000000000000
	and	x9, x0, #0xffffffffffffff
	orr	x0, x9, x8
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_std_san                  ; -- Begin function parse_std_san
	.p2align	2
_parse_std_san:                         ; @parse_std_san
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
	mov	x22, x0
	ldrb	w10, [x22, #1]!
	cbz	w10, LBB33_26
; %bb.1:
	mov	x21, x0
	ldrb	w9, [x0, #2]!
	cbz	w9, LBB33_7
; %bb.2:
	mov	x20, x1
	cmp	w10, #120
	b.ne	LBB33_8
; %bb.3:
	bl	_parse_square
	tbz	w0, #8, LBB33_26
; %bb.4:
	mov	x19, x0
	ldrsb	w8, [x21, #4]
	cmp	w8, #35
	b.eq	LBB33_29
; %bb.5:
	cmp	w8, #43
	b.ne	LBB33_30
; %bb.6:
	ldrb	w8, [x21, #5]
	cmp	w8, #43
	mov	w8, #1
	cinc	w24, w8, eq
	mov	w8, #5
	cinc	w8, w8, eq
	b	LBB33_31
LBB33_7:
	mov	w13, #0
	mov	x8, #0
	b	LBB33_27
LBB33_8:
	cmp	w9, #120
	b.ne	LBB33_15
; %bb.9:
	mov	w13, #0
	mov	x8, #0
	sub	w26, w10, #97
	cmp	w26, #8
	cset	w27, lo
	sub	w22, w10, #49
	cmp	w22, #8
	cset	w25, lo
	cmp	w22, #55
	b.hi	LBB33_48
; %bb.10:
	mov	w9, #1
	lsl	x15, x9, x22
	mov	x16, #255
	movk	x16, #255, lsl #48
	mov	x9, x13
	mov	x23, x8
	mov	x11, x13
	mov	x10, x8
	mov	x19, x13
	mov	x12, x8
	mov	x14, x8
	mov	x24, x13
	tst	x15, x16
	b.eq	LBB33_28
; %bb.11:
	add	x0, x21, #3
	bl	_parse_square
	tbz	w0, #8, LBB33_26
; %bb.12:
	mov	x19, x0
	and	w9, w26, #0xff
	bfi	w27, w26, #8, #24
	and	x8, x27, #0xffff
	and	w11, w22, #0xff
	bfi	w25, w22, #8, #24
	and	x23, x25, #0xffff
	ldrsb	w10, [x21, #5]
	cmp	w10, #35
	b.eq	LBB33_49
; %bb.13:
	cmp	w10, #43
	b.ne	LBB33_50
; %bb.14:
	ldrb	w10, [x21, #6]
	cmp	w10, #43
	mov	w10, #1
	cinc	w24, w10, eq
	mov	w10, #6
	cinc	w10, w10, eq
	b	LBB33_51
LBB33_15:
	ldrb	w8, [x21, #3]
	sub	w10, w10, #97
	and	w25, w10, #0xff
	cmp	w8, #120
	b.ne	LBB33_22
; %bb.16:
	mov	w13, #0
	mov	x8, #0
	cmp	w25, #8
	cset	w22, lo
	sub	w27, w9, #49
	cmp	w27, #8
	cset	w28, lo
	cmp	w25, #7
	b.hi	LBB33_48
; %bb.17:
	and	w26, w27, #0xff
	mov	x9, x13
	mov	x23, x8
	mov	x11, x13
	mov	x10, x8
	mov	x19, x13
	mov	x12, x8
	mov	x14, x8
	mov	x24, x13
	cmp	w26, #7
	b.hi	LBB33_28
; %bb.18:
	add	x0, x21, #4
	bl	_parse_square
	tbz	w0, #8, LBB33_26
; %bb.19:
	mov	x19, x0
	bfi	w22, w25, #8, #8
	bfi	w28, w27, #8, #24
	and	x23, x28, #0xffff
	ldrsb	w8, [x21, #6]
	cmp	w8, #35
	b.eq	LBB33_78
; %bb.20:
	cmp	w8, #43
	b.ne	LBB33_79
; %bb.21:
	ldrb	w8, [x21, #7]
	cmp	w8, #43
	mov	w8, #1
	cinc	w24, w8, eq
	mov	w8, #7
	cinc	w8, w8, eq
	b	LBB33_80
LBB33_22:
	cmp	w25, #8
	mov	w8, #1
	cinc	x9, x8, lo
	ldrb	w9, [x21, x9]
	cinc	w8, w8, lo
	sub	w9, w9, #49
	and	w26, w9, #0xff
	cmp	w9, #8
	cinc	w27, w8, lo
	add	x0, x21, x27
	bl	_parse_square
	tbnz	w0, #8, LBB33_40
; %bb.23:
	mov	w13, #0
	mov	x8, #0
	cmp	w25, #7
	b.hi	LBB33_48
; %bb.24:
	mov	x9, x13
	mov	x23, x8
	mov	x11, x13
	mov	x10, x8
	mov	x19, x13
	mov	x12, x8
	mov	x14, x8
	mov	x24, x13
	cmp	w26, #7
	b.hi	LBB33_28
; %bb.25:
	ldrsb	w8, [x21, #3]
	sub	w8, w8, #48
	cmp	w8, #10
	b.hs	LBB33_71
LBB33_26:
	mov	w13, #0
	mov	x8, #0
	mov	w9, #0
LBB33_27:
	mov	x23, #0
	mov	w11, #0
	mov	x10, #0
	mov	w19, #0
	mov	x12, #0
	mov	x14, #0
	mov	w24, #0
LBB33_28:
	mov	w9, w9
	ubfiz	x15, x19, #48, #8
	lsl	w16, w23, #24
	lsl	w8, w8, #8
	and	x8, x8, #0xff00
	mov	w13, w13
	orr	x9, x10, x9, lsl #16
	orr	x9, x9, x16
	orr	x9, x9, x11, lsl #32
	orr	x9, x9, x12
	orr	x9, x9, x15
	orr	x8, x8, x13
	orr	x0, x8, x9
	and	x8, x24, #0xff
	orr	x1, x14, x8, lsl #8
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB33_29:
	mov	w24, #2
	mov	w8, #5
	b	LBB33_31
LBB33_30:
	mov	w24, #0
	mov	w8, #4
LBB33_31:
	add	x9, x21, x8
	ldrsb	w8, [x9]
	cbz	w8, LBB33_43
; %bb.32:
	cmp	w8, #33
	b.eq	LBB33_44
; %bb.33:
	cmp	w8, #63
	b.ne	LBB33_46
; %bb.34:
	ldrsb	w8, [x9, #1]
	cbz	w8, LBB33_66
; %bb.35:
	ldrb	w9, [x9, #2]
	cbnz	w9, LBB33_46
; %bb.36:
	cbz	w8, LBB33_105
; %bb.37:
	cmp	w8, #33
	b.eq	LBB33_106
; %bb.38:
	cmp	w8, #63
	b.ne	LBB33_46
; %bb.39:
	mov	x8, #0
	mov	w9, #0
	mov	x23, #0
	mov	w11, #0
	b	LBB33_59
LBB33_40:
	mov	x19, x0
	cmp	w26, #8
	cset	w23, lo
	cmp	w25, #8
	cset	w8, lo
	bfi	w23, w26, #8, #8
	bfi	w8, w25, #8, #8
	add	w9, w27, #2
	and	x27, x9, #0xff
	add	x10, x21, x27
	ldrsb	w11, [x10]
	cmp	w11, #35
	b.eq	LBB33_82
LBB33_41:
	cmp	w11, #43
	b.ne	LBB33_68
; %bb.42:
	ldrb	w10, [x10, #1]
	cmp	w10, #43
	mov	w10, #1
	cinc	w24, w10, eq
	mov	x10, x24
	b	LBB33_83
LBB33_43:
	mov	w9, #0
	mov	w11, #0
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	x13, x20
	mov	x23, x8
	mov	x14, x8
	b	LBB33_28
LBB33_44:
	ldrsb	w8, [x9, #1]
	cbz	w8, LBB33_69
; %bb.45:
	ldrb	w9, [x9, #2]
	cbz	w9, LBB33_73
LBB33_46:
	mov	x8, #0
	mov	w9, #0
	mov	x23, #0
	mov	w11, #0
LBB33_47:
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #7
	mov	x13, x20
	b	LBB33_28
LBB33_48:
	mov	x9, x13
	mov	x23, x8
	mov	x11, x13
	mov	x10, x8
	mov	x19, x13
	mov	x12, x8
	mov	x14, x8
	mov	x24, x13
	b	LBB33_28
LBB33_49:
	mov	w24, #2
	mov	w10, #6
	b	LBB33_51
LBB33_50:
	mov	w24, #0
	mov	w10, #5
LBB33_51:
	add	x10, x21, x10
	ldrsb	w14, [x10]
	cbz	w14, LBB33_60
; %bb.52:
	cmp	w14, #33
	b.eq	LBB33_61
; %bb.53:
	cmp	w14, #63
	b.ne	LBB33_47
; %bb.54:
	ldrsb	w12, [x10, #1]
	cbz	w12, LBB33_67
; %bb.55:
	ldrb	w10, [x10, #2]
	cbnz	w10, LBB33_47
; %bb.56:
	cbz	w12, LBB33_67
; %bb.57:
	cmp	w12, #33
	b.eq	LBB33_107
; %bb.58:
	cmp	w12, #63
	b.ne	LBB33_47
LBB33_59:
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #1
	mov	x13, x20
	b	LBB33_28
LBB33_60:
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	x13, x20
	b	LBB33_28
LBB33_61:
	ldrsb	w12, [x10, #1]
	cbz	w12, LBB33_70
; %bb.62:
	ldrb	w10, [x10, #2]
	cbnz	w10, LBB33_47
; %bb.63:
	cbz	w12, LBB33_70
; %bb.64:
	cmp	w12, #33
	b.eq	LBB33_111
; %bb.65:
	cmp	w12, #63
	b.ne	LBB33_47
	b	LBB33_77
LBB33_66:
	mov	x8, #0
	mov	w9, #0
	mov	x23, #0
	mov	w11, #0
LBB33_67:
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #2
	mov	x13, x20
	b	LBB33_28
LBB33_68:
	mov	w24, #0
	mov	w10, #0
	b	LBB33_83
LBB33_69:
	mov	x8, #0
	mov	w9, #0
	mov	x23, #0
	mov	w11, #0
LBB33_70:
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #5
	mov	x13, x20
	b	LBB33_28
LBB33_71:
	mov	x0, x22
	bl	_parse_square
	mov	x8, #0
	tbnz	w0, #8, LBB33_81
; %bb.72:
	mov	w13, #0
	mov	w9, #0
	mov	w11, #0
	mov	w19, #0
	mov	w24, #0
	mov	x23, x8
	mov	x10, x8
	mov	x12, x8
	mov	x14, x8
	b	LBB33_28
LBB33_73:
	cbz	w8, LBB33_108
; %bb.74:
	cmp	w8, #33
	b.eq	LBB33_110
; %bb.75:
	cmp	w8, #63
	b.ne	LBB33_46
; %bb.76:
	mov	x8, #0
	mov	w9, #0
	mov	x23, #0
	mov	w11, #0
LBB33_77:
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #4
	mov	x13, x20
	b	LBB33_28
LBB33_78:
	mov	w24, #2
	mov	w8, #7
	b	LBB33_80
LBB33_79:
	mov	w24, #0
	mov	w8, #6
LBB33_80:
	add	x0, x21, x8
	bl	_parse_ann
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	x13, x20
	mov	x8, x22
	mov	x9, x25
	mov	x11, x26
	mov	w14, w0
	b	LBB33_28
LBB33_81:
	mov	x19, x0
	mov	x9, x27
	mov	x23, x8
	add	x10, x21, x27
	ldrsb	w11, [x10]
	cmp	w11, #35
	b.ne	LBB33_41
LBB33_82:
	mov	w10, #1
	mov	w24, #2
LBB33_83:
	add	w9, w10, w9
	add	x9, x21, w9, uxtb
	ldrsb	w10, [x9]
	cbz	w10, LBB33_92
; %bb.84:
	cmp	w10, #33
	b.eq	LBB33_93
; %bb.85:
	cmp	w10, #63
	b.ne	LBB33_95
; %bb.86:
	ldrsb	w10, [x9, #1]
	cbz	w10, LBB33_97
; %bb.87:
	ldrb	w9, [x9, #2]
	cbnz	w9, LBB33_95
; %bb.88:
	cbz	w10, LBB33_98
; %bb.89:
	cmp	w10, #33
	b.eq	LBB33_112
; %bb.90:
	cmp	w10, #63
	b.ne	LBB33_95
; %bb.91:
	mov	x10, #0
	mov	x12, #72057594037927936
	mov	w14, #1
	b	LBB33_96
LBB33_92:
	mov	x12, #72057594037927936
	mov	x13, x20
	mov	x9, x25
	mov	x11, x26
	mov	x14, x10
	b	LBB33_28
LBB33_93:
	ldrsb	w10, [x9, #1]
	cbz	w10, LBB33_99
; %bb.94:
	ldrb	w9, [x9, #2]
	cbz	w9, LBB33_101
LBB33_95:
	mov	x10, #0
	mov	x12, #72057594037927936
	mov	w14, #7
LBB33_96:
	mov	x13, x20
	mov	x9, x25
	mov	x11, x26
	b	LBB33_28
LBB33_97:
	mov	x10, #0
LBB33_98:
	mov	x12, #72057594037927936
	mov	w14, #2
	b	LBB33_96
LBB33_99:
	mov	x10, #0
LBB33_100:
	mov	x12, #72057594037927936
	mov	w14, #5
	b	LBB33_96
LBB33_101:
	cbz	w10, LBB33_100
; %bb.102:
	cmp	w10, #33
	b.eq	LBB33_113
; %bb.103:
	cmp	w10, #63
	b.ne	LBB33_95
; %bb.104:
	mov	x10, #0
	mov	x12, #72057594037927936
	mov	w14, #4
	b	LBB33_96
LBB33_105:
	mov	w9, #0
	mov	w11, #0
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #2
	b	LBB33_109
LBB33_106:
	mov	x8, #0
	mov	w9, #0
	mov	x23, #0
	mov	w11, #0
LBB33_107:
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #3
	mov	x13, x20
	b	LBB33_28
LBB33_108:
	mov	w9, #0
	mov	w11, #0
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #5
LBB33_109:
	mov	x13, x20
	mov	x23, x8
	b	LBB33_28
LBB33_110:
	mov	x8, #0
	mov	w9, #0
	mov	x23, #0
	mov	w11, #0
LBB33_111:
	mov	x12, #72057594037927936
	mov	x10, #1099511627776
	mov	w14, #6
	mov	x13, x20
	b	LBB33_28
LBB33_112:
	mov	x10, #0
	mov	x12, #72057594037927936
	mov	w14, #3
	b	LBB33_96
LBB33_113:
	mov	x10, #0
	mov	x12, #72057594037927936
	mov	w14, #6
	b	LBB33_96
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_castling_san             ; -- Begin function parse_castling_san
	.p2align	2
_parse_castling_san:                    ; @parse_castling_san
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
	mov	x19, x0
	bl	_strlen
	cmp	x0, #3
	b.lo	LBB34_4
; %bb.1:
	cmp	x0, #5
	b.lo	LBB34_3
; %bb.2:
Lloh80:
	adrp	x1, l_.str.22@PAGE
Lloh81:
	add	x1, x1, l_.str.22@PAGEOFF
	mov	x0, x19
	mov	w2, #5
	bl	_strncmp
	cbz	w0, LBB34_6
LBB34_3:
Lloh82:
	adrp	x1, l_.str.23@PAGE
Lloh83:
	add	x1, x1, l_.str.23@PAGEOFF
	mov	x0, x19
	mov	w2, #3
	bl	_strncmp
	cbz	w0, LBB34_5
LBB34_4:
	mov	x8, #0
	mov	x9, #0
	orr	x0, x9, x8
	mov	x1, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB34_5:
	mov	x8, #288230376151711744
	mov	w9, #1
	orr	x0, x9, x8
	mov	x1, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB34_6:
	mov	x9, #0
	mov	x8, #288230376151711744
	orr	x0, x9, x8
	mov	x1, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh80, Lloh81
	.loh AdrpAdd	Lloh82, Lloh83
	.cfi_endproc
                                        ; -- End function
	.globl	_parse_san_inner                ; -- Begin function parse_san_inner
	.p2align	2
_parse_san_inner:                       ; @parse_san_inner
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
	cbz	x0, LBB35_9
; %bb.1:
	mov	x19, x0
	ldrb	w8, [x0]
	cbz	w8, LBB35_10
; %bb.2:
	cmp	w8, #79
	b.ne	LBB35_11
; %bb.3:
	mov	x0, x19
	bl	_strlen
	cmp	x0, #3
	b.lo	LBB35_7
; %bb.4:
	cmp	x0, #5
	b.lo	LBB35_6
; %bb.5:
Lloh84:
	adrp	x1, l_.str.22@PAGE
Lloh85:
	add	x1, x1, l_.str.22@PAGEOFF
	mov	x0, x19
	mov	w2, #5
	bl	_strncmp
	cbz	w0, LBB35_24
LBB35_6:
Lloh86:
	adrp	x1, l_.str.23@PAGE
Lloh87:
	add	x1, x1, l_.str.23@PAGEOFF
	mov	x0, x19
	mov	w2, #3
	bl	_strncmp
	cbz	w0, LBB35_23
LBB35_7:
	mov	x8, #0
	mov	x9, #0
LBB35_8:
	mov	x1, #0
	orr	x0, x9, x8
	and	x9, x0, #0xffffffffffffff
	orr	x0, x9, x8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB35_9:
	mov	x8, #0
	mov	x1, #0
	and	x9, x0, #0xffffffffffffff
	orr	x0, x9, x8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB35_10:
	mov	x1, x8
	and	x9, x8, #0xffffffffffffff
	orr	x0, x9, x8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB35_11:
	sxtb	w8, w8
	sub	w8, w8, #66
	cmp	w8, #16
	b.hi	LBB35_14
; %bb.12:
	mov	w1, #5
Lloh88:
	adrp	x9, lJTI35_0@PAGE
Lloh89:
	add	x9, x9, lJTI35_0@PAGEOFF
	adr	x10, LBB35_13
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB35_13:
	mov	w1, #8
	b	LBB35_21
LBB35_14:
	ldrb	w8, [x19, #1]
	cbz	w8, LBB35_25
; %bb.15:
	cmp	w8, #120
	b.eq	LBB35_17
; %bb.16:
	ldrb	w8, [x19, #2]
	cmp	w8, #120
	b.ne	LBB35_26
LBB35_17:
	mov	x0, x19
	bl	_parse_pawn_capture_san
	b	LBB35_27
LBB35_18:
	mov	w1, #4
	b	LBB35_21
LBB35_19:
	mov	w1, #7
	b	LBB35_21
LBB35_20:
	mov	w1, #6
LBB35_21:
	mov	x0, x19
	bl	_parse_std_san
LBB35_22:
	and	x8, x0, #0xff00000000000000
	and	x1, x1, #0xffff
	and	x9, x0, #0xffffffffffffff
	orr	x0, x9, x8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB35_23:
	mov	x8, #288230376151711744
	mov	w9, #1
	b	LBB35_8
LBB35_24:
	mov	x9, #0
	mov	x8, #288230376151711744
	b	LBB35_8
LBB35_25:
	mov	x1, x8
	mov	x0, x8
	b	LBB35_28
LBB35_26:
	mov	x0, x19
	bl	_parse_pawn_push_san
LBB35_27:
	and	x8, x0, #0xff00000000000000
LBB35_28:
	and	x9, x0, #0xffffffffffffff
	orr	x0, x9, x8
	and	x1, x1, #0xffff
	b	LBB35_22
	.loh AdrpAdd	Lloh84, Lloh85
	.loh AdrpAdd	Lloh86, Lloh87
	.loh AdrpAdd	Lloh88, Lloh89
	.cfi_endproc
	.section	__TEXT,__const
lJTI35_0:
	.byte	(LBB35_21-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_13-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_18-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_14-LBB35_13)>>2
	.byte	(LBB35_19-LBB35_13)>>2
	.byte	(LBB35_20-LBB35_13)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_parse_san                      ; -- Begin function parse_san
	.p2align	2
_parse_san:                             ; @parse_san
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
	bl	_parse_san_inner
	lsr	x8, x0, #56
	cmp	x8, #0
	cset	w8, eq
	strb	w8, [x19]
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_san_correct                 ; -- Begin function is_san_correct
	.p2align	2
_is_san_correct:                        ; @is_san_correct
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_parse_san_inner
	tst	x0, #0xff00000000000000
	cset	w0, ne
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_san_ann                  ; -- Begin function write_san_ann
	.p2align	2
_write_san_ann:                         ; @write_san_ann
	.cfi_startproc
; %bb.0:
	cmp	w0, #6
	b.hi	LBB38_3
; %bb.1:
	mov	w8, w0
Lloh90:
	adrp	x9, lJTI38_0@PAGE
Lloh91:
	add	x9, x9, lJTI38_0@PAGEOFF
	adr	x10, LBB38_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB38_2:
	mov	w8, #16191
	strh	w8, [x1], #2
	strb	wzr, [x1]
	mov	w0, #1
	ret
LBB38_3:
	mov	w0, #0
	ret
LBB38_4:
	mov	w8, #63
	strb	w8, [x1], #1
LBB38_5:
	strb	wzr, [x1]
	mov	w0, #1
	ret
LBB38_6:
	mov	w8, #8511
	strh	w8, [x1], #2
	strb	wzr, [x1]
	mov	w0, #1
	ret
LBB38_7:
	mov	w8, #16161
	strh	w8, [x1], #2
	strb	wzr, [x1]
	mov	w0, #1
	ret
LBB38_8:
	mov	w8, #33
	strb	w8, [x1], #1
	strb	wzr, [x1]
	mov	w0, #1
	ret
LBB38_9:
	mov	w8, #8481
	strh	w8, [x1], #2
	strb	wzr, [x1]
	mov	w0, #1
	ret
	.loh AdrpAdd	Lloh90, Lloh91
	.cfi_endproc
	.section	__TEXT,__const
lJTI38_0:
	.byte	(LBB38_5-LBB38_2)>>2
	.byte	(LBB38_2-LBB38_2)>>2
	.byte	(LBB38_4-LBB38_2)>>2
	.byte	(LBB38_6-LBB38_2)>>2
	.byte	(LBB38_7-LBB38_2)>>2
	.byte	(LBB38_8-LBB38_2)>>2
	.byte	(LBB38_9-LBB38_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_write_san_promotion            ; -- Begin function write_san_promotion
	.p2align	2
_write_san_promotion:                   ; @write_san_promotion
	.cfi_startproc
; %bb.0:
	cmp	w0, #7
	b.hi	LBB39_3
; %bb.1:
	mov	w8, w0
Lloh92:
	adrp	x9, lJTI39_0@PAGE
Lloh93:
	add	x9, x9, lJTI39_0@PAGEOFF
	adr	x10, LBB39_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB39_2:
	mov	w8, #78
	strb	w8, [x1]
	mov	w0, #1
	sxtb	w0, w0
	ret
LBB39_3:
	mov	w0, #255
LBB39_4:
	sxtb	w0, w0
	ret
LBB39_5:
	mov	w8, #66
	strb	w8, [x1]
	mov	w0, #1
	sxtb	w0, w0
	ret
LBB39_6:
	mov	w8, #82
	strb	w8, [x1]
	mov	w0, #1
	sxtb	w0, w0
	ret
LBB39_7:
	mov	w8, #81
	strb	w8, [x1]
	mov	w0, #1
	sxtb	w0, w0
	ret
	.loh AdrpAdd	Lloh92, Lloh93
	.cfi_endproc
	.section	__TEXT,__const
lJTI39_0:
	.byte	(LBB39_4-LBB39_2)>>2
	.byte	(LBB39_3-LBB39_2)>>2
	.byte	(LBB39_3-LBB39_2)>>2
	.byte	(LBB39_3-LBB39_2)>>2
	.byte	(LBB39_2-LBB39_2)>>2
	.byte	(LBB39_5-LBB39_2)>>2
	.byte	(LBB39_6-LBB39_2)>>2
	.byte	(LBB39_7-LBB39_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_write_san_piece                ; -- Begin function write_san_piece
	.p2align	2
_write_san_piece:                       ; @write_san_piece
	.cfi_startproc
; %bb.0:
	sub	w8, w0, #4
	cmp	w8, #4
	b.hi	LBB40_2
; %bb.1:
	and	x8, x8, #0xff
	lsl	x8, x8, #3
	mov	x9, #16974
	movk	x9, #20818, lsl #16
	movk	x9, #75, lsl #32
	lsr	x8, x9, x8
	strb	w8, [x1]
	mov	w8, #1
	sxtb	w0, w8
	ret
LBB40_2:
	mov	w8, #255
	sxtb	w0, w8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_san_pawn_push            ; -- Begin function write_san_pawn_push
	.p2align	2
_write_san_pawn_push:                   ; @write_san_pawn_push
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
	ubfx	x0, x0, #32, #8
                                        ; kill: def $w0 killed $w0 killed $x0
	bl	_serialize_square
	cbz	w0, LBB41_3
; %bb.1:
	lsr	x8, x20, #40
	sub	w8, w8, #4
	and	w9, w8, #0xff
	cmp	w9, #3
	b.hi	LBB41_4
; %bb.2:
	and	x8, x8, #0xff
	lsl	x8, x8, #3
	mov	w9, #16974
	movk	w9, #20818, lsl #16
	lsr	w8, w9, w8
	strb	w8, [x19, #2]
	mov	w8, #3
	sxtb	w0, w8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB41_3:
	mov	w8, #255
	sxtb	w0, w8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB41_4:
	mov	w8, #2
	sxtb	w0, w8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_san_pawn_capture         ; -- Begin function write_san_pawn_capture
	.p2align	2
_write_san_pawn_capture:                ; @write_san_pawn_capture
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
	cbz	x1, LBB42_3
; %bb.1:
	lsr	x8, x0, #24
	lsr	x19, x0, #32
                                        ; kill: def $w19 killed $w19 killed $x19 def $x19
	add	w9, w0, #97
	strb	w9, [x1]
	tbnz	w0, #8, LBB42_5
; %bb.2:
	mov	w21, #1
	b	LBB42_6
LBB42_3:
	mov	w8, #255
LBB42_4:
	sxtb	w0, w8
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB42_5:
	ubfx	x9, x0, #16, #16
	add	w9, w9, #49
	strb	w9, [x1, #1]
	mov	w21, #2
LBB42_6:
	add	x20, x1, w21, uxtw
	mov	w9, #120
	mov	x1, x20
	strb	w9, [x1], #1
	and	w0, w8, #0xff
	bl	_serialize_square
	add	w8, w21, #3
	and	w9, w19, #0xff
	cmp	w9, #7
	b.hi	LBB42_4
; %bb.7:
	mov	w9, #81
	and	x10, x19, #0xff
Lloh94:
	adrp	x11, lJTI42_0@PAGE
Lloh95:
	add	x11, x11, lJTI42_0@PAGEOFF
	adr	x12, LBB42_4
	ldrb	w13, [x11, x10]
	add	x12, x12, x13, lsl #2
	br	x12
LBB42_8:
	mov	w9, #78
	b	LBB42_11
LBB42_9:
	mov	w9, #66
	b	LBB42_11
LBB42_10:
	mov	w9, #82
LBB42_11:
	strb	w9, [x20, #3]
	mov	w19, #1
LBB42_12:
	add	w8, w19, w8
	sxtb	w0, w8
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh94, Lloh95
	.cfi_endproc
	.section	__TEXT,__const
lJTI42_0:
	.byte	(LBB42_12-LBB42_4)>>2
	.byte	(LBB42_4-LBB42_4)>>2
	.byte	(LBB42_4-LBB42_4)>>2
	.byte	(LBB42_4-LBB42_4)>>2
	.byte	(LBB42_8-LBB42_4)>>2
	.byte	(LBB42_9-LBB42_4)>>2
	.byte	(LBB42_10-LBB42_4)>>2
	.byte	(LBB42_11-LBB42_4)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_write_san_std_move             ; -- Begin function write_san_std_move
	.p2align	2
_write_san_std_move:                    ; @write_san_std_move
	.cfi_startproc
; %bb.0:
	cbz	x1, LBB43_5
; %bb.1:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	sub	w8, w0, #4
	and	w9, w8, #0xff
	cmp	w9, #4
	b.hi	LBB43_3
; %bb.2:
	and	x8, x8, #0xff
	lsl	x8, x8, #3
	mov	x9, #16974
	movk	x9, #20818, lsl #16
	movk	x9, #75, lsl #32
	lsr	x8, x9, x8
	strb	w8, [x1]
LBB43_3:
	tbnz	w0, #8, LBB43_6
; %bb.4:
	mov	w19, #1
	lsr	x8, x0, #48
	tbnz	w0, #24, LBB43_7
	b	LBB43_8
LBB43_5:
	mov	w8, #255
	sxtb	w0, w8
	ret
LBB43_6:
	ubfx	x8, x0, #16, #16
	add	w8, w8, #97
	strb	w8, [x1, #1]
	mov	w19, #2
	lsr	x8, x0, #48
	tbz	w0, #24, LBB43_8
LBB43_7:
	lsr	x9, x0, #32
	add	w9, w9, #49
	strb	w9, [x1, w19, uxtw]
	add	w19, w19, #1
LBB43_8:
	tbz	x0, #40, LBB43_10
; %bb.9:
	mov	w9, #120
	strb	w9, [x1, w19, uxtw]
	add	w19, w19, #1
LBB43_10:
	add	x1, x1, w19, uxtw
	and	w0, w8, #0xff
	bl	_serialize_square
	add	w8, w19, #2
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	sxtb	w0, w8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_san_castling             ; -- Begin function write_san_castling
	.p2align	2
_write_san_castling:                    ; @write_san_castling
	.cfi_startproc
; %bb.0:
	cbz	w0, LBB44_2
; %bb.1:
	mov	w8, #11599
	movk	w8, #79, lsl #16
	str	w8, [x1]
	mov	w0, #3
	ret
LBB44_2:
	mov	w8, #79
	strh	w8, [x1, #4]
	mov	w8, #11599
	movk	w8, #11599, lsl #16
	str	w8, [x1]
	mov	w0, #5
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_san_check_status         ; -- Begin function write_san_check_status
	.p2align	2
_write_san_check_status:                ; @write_san_check_status
	.cfi_startproc
; %bb.0:
	ubfx	x8, x1, #8, #8
	cbz	w8, LBB45_4
; %bb.1:
	cmp	w8, #2
	b.eq	LBB45_5
; %bb.2:
	cmp	w8, #1
	b.ne	LBB45_6
; %bb.3:
	mov	w8, #43
	strb	w8, [x2]
	mov	w8, #1
	sxtb	w0, w8
	ret
LBB45_4:
	lsr	x8, x1, #8
	sxtb	w0, w8
	ret
LBB45_5:
	mov	w8, #35
	strb	w8, [x2]
	mov	w8, #1
	sxtb	w0, w8
	ret
LBB45_6:
	mov	w8, #255
	sxtb	w0, w8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_san                      ; -- Begin function write_san
	.p2align	2
_write_san:                             ; @write_san
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
	lsr	x8, x0, #56
	sub	w8, w8, #1
	cmp	w8, #3
	b.hi	LBB46_7
; %bb.1:
	mov	x20, x2
	mov	x19, x1
	mov	x21, x0
Lloh96:
	adrp	x9, lJTI46_0@PAGE
Lloh97:
	add	x9, x9, lJTI46_0@PAGEOFF
	adr	x10, LBB46_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB46_2:
	cbz	x20, LBB46_41
; %bb.3:
	sub	w8, w21, #4
	and	w9, w8, #0xff
	cmp	w9, #4
	b.hi	LBB46_5
; %bb.4:
	and	x8, x8, #0xff
	lsl	x8, x8, #3
	mov	x9, #16974
	movk	x9, #20818, lsl #16
	movk	x9, #75, lsl #32
	lsr	x8, x9, x8
	strb	w8, [x20]
LBB46_5:
	tbnz	w21, #8, LBB46_18
; %bb.6:
	mov	w22, #1
	lsr	x8, x21, #48
	tbnz	w21, #24, LBB46_19
	b	LBB46_20
LBB46_7:
	mov	w0, #0
	b	LBB46_11
LBB46_8:
	ubfx	x0, x21, #32, #8
                                        ; kill: def $w0 killed $w0 killed $x0
	mov	x1, x20
	bl	_serialize_square
	cbz	w0, LBB46_11
; %bb.9:
	lsr	x8, x21, #40
	sub	w8, w8, #4
	and	w9, w8, #0xff
	cmp	w9, #3
	b.hi	LBB46_27
; %bb.10:
	and	x8, x8, #0xff
	lsl	x8, x8, #3
	mov	w9, #16974
	movk	w9, #20818, lsl #16
	lsr	w8, w9, w8
	strb	w8, [x20, #2]
	mov	w8, #3
	b	LBB46_32
LBB46_11:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB46_12:
	cbz	x20, LBB46_41
; %bb.13:
	lsr	x8, x21, #24
	lsr	x22, x21, #32
                                        ; kill: def $w22 killed $w22 killed $x22 def $x22
	add	w9, w21, #97
	strb	w9, [x20]
	tbnz	w21, #8, LBB46_23
; %bb.14:
	mov	w23, #1
	b	LBB46_24
LBB46_15:
	tbnz	w21, #0, LBB46_17
; %bb.16:
	mov	w8, #79
	strh	w8, [x20, #4]
	mov	w8, #11599
	movk	w8, #11599, lsl #16
	str	w8, [x20]
	mov	w8, #5
	b	LBB46_32
LBB46_17:
	mov	w8, #11599
	movk	w8, #79, lsl #16
	str	w8, [x20]
	mov	w8, #3
	b	LBB46_32
LBB46_18:
	ubfx	x8, x21, #16, #16
	add	w8, w8, #97
	strb	w8, [x20, #1]
	mov	w22, #2
	lsr	x8, x21, #48
	tbz	w21, #24, LBB46_20
LBB46_19:
	lsr	x9, x21, #32
	add	w9, w9, #49
	strb	w9, [x20, w22, uxtw]
	add	w22, w22, #1
LBB46_20:
	tbz	x21, #40, LBB46_22
; %bb.21:
	mov	w9, #120
	strb	w9, [x20, w22, uxtw]
	add	w22, w22, #1
LBB46_22:
	add	x1, x20, w22, uxtw
	and	w0, w8, #0xff
	bl	_serialize_square
	add	w8, w22, #2
	b	LBB46_32
LBB46_23:
	ubfx	x9, x21, #16, #16
	add	w9, w9, #49
	strb	w9, [x20, #1]
	mov	w23, #2
LBB46_24:
	add	x21, x20, w23, uxtw
	mov	w9, #120
	mov	x1, x21
	strb	w9, [x1], #1
	and	w0, w8, #0xff
	bl	_serialize_square
	add	w8, w23, #3
	and	w9, w22, #0xff
	cmp	w9, #7
	b.hi	LBB46_32
; %bb.25:
	mov	w9, #81
	and	x10, x22, #0xff
Lloh98:
	adrp	x11, lJTI46_1@PAGE
Lloh99:
	add	x11, x11, lJTI46_1@PAGEOFF
	adr	x12, LBB46_26
	ldrb	w13, [x11, x10]
	add	x12, x12, x13, lsl #2
	br	x12
LBB46_26:
	mov	w9, #78
	b	LBB46_30
LBB46_27:
	mov	w8, #2
	b	LBB46_32
LBB46_28:
	mov	w9, #66
	b	LBB46_30
LBB46_29:
	mov	w9, #82
LBB46_30:
	strb	w9, [x21, #3]
	mov	w22, #1
LBB46_31:
	add	w8, w22, w8
LBB46_32:
	ubfx	x9, x19, #8, #8
	add	x8, x20, w8, uxtb
	cbz	w9, LBB46_38
; %bb.33:
	cmp	w9, #1
	b.eq	LBB46_36
; %bb.34:
	cmp	w9, #2
	b.ne	LBB46_41
; %bb.35:
	mov	w9, #35
	b	LBB46_37
LBB46_36:
	mov	w9, #43
LBB46_37:
	strb	w9, [x8]
	mov	w9, #1
LBB46_38:
	and	w10, w19, #0xff
	cmp	w10, #6
	b.hi	LBB46_41
; %bb.39:
	add	x8, x8, x9
                                        ; kill: def $w19 killed $w19 killed $x19 def $x19
	and	x9, x19, #0xff
Lloh100:
	adrp	x10, lJTI46_2@PAGE
Lloh101:
	add	x10, x10, lJTI46_2@PAGEOFF
	adr	x11, LBB46_40
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
	br	x11
LBB46_40:
	mov	w9, #16191
	b	LBB46_47
LBB46_41:
	mov	w0, #0
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB46_42:
	mov	w9, #63
	strb	w9, [x8], #1
	b	LBB46_48
LBB46_43:
	mov	w9, #8511
	b	LBB46_47
LBB46_44:
	mov	w9, #16161
	b	LBB46_47
LBB46_45:
	mov	w9, #33
	strb	w9, [x8], #1
	b	LBB46_48
LBB46_46:
	mov	w9, #8481
LBB46_47:
	strh	w9, [x8], #2
LBB46_48:
	strb	wzr, [x8]
	mov	w0, #1
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh96, Lloh97
	.loh AdrpAdd	Lloh98, Lloh99
	.loh AdrpAdd	Lloh100, Lloh101
	.cfi_endproc
	.section	__TEXT,__const
lJTI46_0:
	.byte	(LBB46_2-LBB46_2)>>2
	.byte	(LBB46_8-LBB46_2)>>2
	.byte	(LBB46_12-LBB46_2)>>2
	.byte	(LBB46_15-LBB46_2)>>2
lJTI46_1:
	.byte	(LBB46_31-LBB46_26)>>2
	.byte	(LBB46_32-LBB46_26)>>2
	.byte	(LBB46_32-LBB46_26)>>2
	.byte	(LBB46_32-LBB46_26)>>2
	.byte	(LBB46_26-LBB46_26)>>2
	.byte	(LBB46_28-LBB46_26)>>2
	.byte	(LBB46_29-LBB46_26)>>2
	.byte	(LBB46_30-LBB46_26)>>2
lJTI46_2:
	.byte	(LBB46_48-LBB46_40)>>2
	.byte	(LBB46_40-LBB46_40)>>2
	.byte	(LBB46_42-LBB46_40)>>2
	.byte	(LBB46_43-LBB46_40)>>2
	.byte	(LBB46_44-LBB46_40)>>2
	.byte	(LBB46_45-LBB46_40)>>2
	.byte	(LBB46_46-LBB46_40)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_roundtrip_san                  ; -- Begin function roundtrip_san
	.p2align	2
_roundtrip_san:                         ; @roundtrip_san
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
	bl	_parse_san_inner
	and	x1, x1, #0xffff
	mov	x2, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_write_san
	.cfi_endproc
                                        ; -- End function
	.globl	_get_origin                     ; -- Begin function get_origin
	.p2align	2
_get_origin:                            ; @get_origin
	.cfi_startproc
; %bb.0:
	and	w0, w0, #0xff
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_destination                ; -- Begin function get_destination
	.p2align	2
_get_destination:                       ; @get_destination
	.cfi_startproc
; %bb.0:
	ubfx	w0, w0, #8, #8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_promotes_to                ; -- Begin function get_promotes_to
	.p2align	2
_get_promotes_to:                       ; @get_promotes_to
	.cfi_startproc
; %bb.0:
	and	x8, x0, #0xff000000
	ubfx	x9, x0, #16, #16
	mov	w10, #50331648
	cmp	x8, x10
	csel	w8, w9, wzr, eq
	and	w0, w8, #0xff
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_promotion                   ; -- Begin function is_promotion
	.p2align	2
_is_promotion:                          ; @is_promotion
	.cfi_startproc
; %bb.0:
	and	x8, x0, #0xff000000
	mov	w9, #50331648
	cmp	x8, x9
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_promotes_to                    ; -- Begin function promotes_to
	.p2align	2
_promotes_to:                           ; @promotes_to
	.cfi_startproc
; %bb.0:
	and	x8, x0, #0xff000000
	mov	w9, #50331648
	cmp	x8, x9
	b.ne	LBB52_2
; %bb.1:
	lsr	x8, x0, #8
	and	x0, x8, #0xff00
	b	_piece_to_index
LBB52_2:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_empty_piece
                                        ; kill: def $w0 killed $w0 def $x0
	and	x0, x0, #0xffff
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_piece_to_index
	.cfi_endproc
                                        ; -- End function
	.globl	_error_san                      ; -- Begin function error_san
	.p2align	2
_error_san:                             ; @error_san
	.cfi_startproc
; %bb.0:
	mov	x0, #0
	mov	x1, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Origin {origin} is not a valid square"

l_.str.1:                               ; @.str.1
	.asciz	"Destination {destination} is not a valid square"

l_.str.10:                              ; @.str.10
	.asciz	"0000"

l_.str.11:                              ; @.str.11
	.asciz	"Invalid promotion Move destination {destination}, must be a back rank"

l_.str.12:                              ; @.str.12
	.asciz	"Invalid promotion Move from {origin} to {destination}, not a legal Pawn move"

l_.str.13:                              ; @.str.13
	.asciz	"Invalid Move from and to {origin}, a Piece cannot move to the same Square it currently occupies"

l_.str.14:                              ; @.str.14
	.asciz	"Invalid Move from {origin} to {destination}, illegal for every Piece"

l_.str.15:                              ; @.str.15
	.asciz	"Invalid promotion Move, a Pawn cannot promote to a {promote_to}"

l_.str.16:                              ; @.str.16
	.asciz	"Unknown move type"

l_.str.17:                              ; @.str.17
	.asciz	"Not a legal move: '{uci}'"

l_.str.18:                              ; @.str.18
	.asciz	"Cannot parse empty string: '{uci}'"

l_.str.19:                              ; @.str.19
	.asciz	"UCI must be at least 4 characters long: '{uci}'"

l_.str.20:                              ; @.str.20
	.asciz	"Cannot promote to a Pawn: '{uci}'"

l_.str.21:                              ; @.str.21
	.asciz	"Cannot promote to a King: '{uci}'"

l_.str.22:                              ; @.str.22
	.asciz	"O-O-O"

l_.str.23:                              ; @.str.23
	.asciz	"O-O"

l_str:                                  ; @str
	.asciz	"white occupied"

l_str.24:                               ; @str.24
	.asciz	"black occupied"

l_str.25:                               ; @str.25
	.asciz	"pawns"

l_str.26:                               ; @str.26
	.asciz	"bishops"

l_str.27:                               ; @str.27
	.asciz	"knights"

l_str.28:                               ; @str.28
	.asciz	"rooks"

l_str.29:                               ; @str.29
	.asciz	"queens"

l_str.30:                               ; @str.30
	.asciz	"kings"

.subsections_via_symbols
