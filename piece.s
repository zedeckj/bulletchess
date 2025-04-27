	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_get_rook_val                   ; -- Begin function get_rook_val
	.p2align	2
_get_rook_val:                          ; @get_rook_val
	.cfi_startproc
; %bb.0:
	mov	w0, #6
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_knight_val                 ; -- Begin function get_knight_val
	.p2align	2
_get_knight_val:                        ; @get_knight_val
	.cfi_startproc
; %bb.0:
	mov	w0, #4
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_pawn_val                   ; -- Begin function get_pawn_val
	.p2align	2
_get_pawn_val:                          ; @get_pawn_val
	.cfi_startproc
; %bb.0:
	mov	w0, #3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_queen_val                  ; -- Begin function get_queen_val
	.p2align	2
_get_queen_val:                         ; @get_queen_val
	.cfi_startproc
; %bb.0:
	mov	w0, #7
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_king_val                   ; -- Begin function get_king_val
	.p2align	2
_get_king_val:                          ; @get_king_val
	.cfi_startproc
; %bb.0:
	mov	w0, #8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_bishop_val                 ; -- Begin function get_bishop_val
	.p2align	2
_get_bishop_val:                        ; @get_bishop_val
	.cfi_startproc
; %bb.0:
	mov	w0, #5
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_empty_val                  ; -- Begin function get_empty_val
	.p2align	2
_get_empty_val:                         ; @get_empty_val
	.cfi_startproc
; %bb.0:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_error_val                  ; -- Begin function get_error_val
	.p2align	2
_get_error_val:                         ; @get_error_val
	.cfi_startproc
; %bb.0:
	mov	w0, #9
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_white_val                  ; -- Begin function get_white_val
	.p2align	2
_get_white_val:                         ; @get_white_val
	.cfi_startproc
; %bb.0:
	mov	w0, #1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_black_val                  ; -- Begin function get_black_val
	.p2align	2
_get_black_val:                         ; @get_black_val
	.cfi_startproc
; %bb.0:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_piece_is_type                  ; -- Begin function piece_is_type
	.p2align	2
_piece_is_type:                         ; @piece_is_type
	.cfi_startproc
; %bb.0:
	ubfx	x8, x0, #8, #24
	cmp	w1, w8, uxtb
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_piece_is_color                 ; -- Begin function piece_is_color
	.p2align	2
_piece_is_color:                        ; @piece_is_color
	.cfi_startproc
; %bb.0:
	cmp	w1, w0, uxtb
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_same_color                     ; -- Begin function same_color
	.p2align	2
_same_color:                            ; @same_color
	.cfi_startproc
; %bb.0:
	eor	w8, w1, w0
	tst	x8, #0xff
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_same_type                      ; -- Begin function same_type
	.p2align	2
_same_type:                             ; @same_type
	.cfi_startproc
; %bb.0:
	eor	w8, w1, w0
	tst	x8, #0xff00
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_pieces_equal                   ; -- Begin function pieces_equal
	.p2align	2
_pieces_equal:                          ; @pieces_equal
	.cfi_startproc
; %bb.0:
	ubfx	w8, w0, #8, #8
	ubfx	w9, w1, #8, #8
	orr	w10, w8, w9
	mov	w11, #1
	eor	w12, w1, w0
	tst	x12, #0xff
	ccmp	w8, w9, #0, eq
	cset	w8, eq
	cmp	w10, #0
	csel	w0, w11, w8, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_hash_piece                     ; -- Begin function hash_piece
	.p2align	2
_hash_piece:                            ; @hash_piece
	.cfi_startproc
; %bb.0:
	lsr	x8, x0, #8
	lsl	w9, w0, #4
	and	x9, x9, #0xff0
	add	x0, x9, w8, uxtb
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_error_piece                    ; -- Begin function error_piece
	.p2align	2
_error_piece:                           ; @error_piece
	.cfi_startproc
; %bb.0:
	mov	w0, #2304
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_empty_piece                    ; -- Begin function empty_piece
	.p2align	2
_empty_piece:                           ; @empty_piece
	.cfi_startproc
; %bb.0:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_white_piece                    ; -- Begin function white_piece
	.p2align	2
_white_piece:                           ; @white_piece
	.cfi_startproc
; %bb.0:
	mov	w8, #1
	bfi	w8, w0, #8, #8
	mov	x0, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_black_piece                    ; -- Begin function black_piece
	.p2align	2
_black_piece:                           ; @black_piece
	.cfi_startproc
; %bb.0:
	lsl	w0, w0, #8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_piece_is_empty                 ; -- Begin function piece_is_empty
	.p2align	2
_piece_is_empty:                        ; @piece_is_empty
	.cfi_startproc
; %bb.0:
	tst	x0, #0xff
	cset	w0, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_piece_to_index                 ; -- Begin function piece_to_index
	.p2align	2
_piece_to_index:                        ; @piece_to_index
	.cfi_startproc
; %bb.0:
	tst	x0, #0xff00
	b.eq	LBB21_4
; %bb.1:
	tst	x0, #0xff
	mov	w8, #6
	csel	w8, w8, wzr, eq
	ubfx	w9, w0, #8, #8
	sub	w9, w9, #3
	cmp	w9, #5
	b.hi	LBB21_4
; %bb.2:
Lloh0:
	adrp	x10, lJTI21_0@PAGE
Lloh1:
	add	x10, x10, lJTI21_0@PAGEOFF
	adr	x11, LBB21_3
	ldrb	w12, [x10, x9]
	add	x11, x11, x12, lsl #2
	br	x11
LBB21_3:
	orr	w0, w8, #0x1
	ret
LBB21_4:
	mov	w0, #0
	ret
LBB21_5:
	add	w0, w8, #2
	ret
LBB21_6:
	add	w0, w8, #3
	ret
LBB21_7:
	add	w0, w8, #4
	ret
LBB21_8:
	add	w0, w8, #5
	ret
LBB21_9:
	add	w0, w8, #6
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
	.section	__TEXT,__const
lJTI21_0:
	.byte	(LBB21_3-LBB21_3)>>2
	.byte	(LBB21_5-LBB21_3)>>2
	.byte	(LBB21_6-LBB21_3)>>2
	.byte	(LBB21_7-LBB21_3)>>2
	.byte	(LBB21_8-LBB21_3)>>2
	.byte	(LBB21_9-LBB21_3)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_index_to_piece                 ; -- Begin function index_to_piece
	.p2align	2
_index_to_piece:                        ; @index_to_piece
	.cfi_startproc
; %bb.0:
	cbz	w0, LBB22_2
; %bb.1:
	sub	w8, w0, #1
	mov	w9, #43691
	movk	w9, #43690, lsl #16
	umull	x9, w8, w9
	lsr	x9, x9, #34
	mov	w10, #6
	msub	w8, w9, w10, w8
	add	w9, w8, #1
	add	w8, w8, #3
	cmp	w9, w0
	cset	w0, eq
	bfi	w0, w8, #8, #24
	ret
LBB22_2:
	bfc	w0, #8, #24
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_piece_from_symbol              ; -- Begin function piece_from_symbol
	.p2align	2
_piece_from_symbol:                     ; @piece_from_symbol
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
	bl	___toupper
	sxtb	w8, w0
	sub	w11, w8, #45
	cmp	w11, #37
	b.hi	LBB23_3
; %bb.1:
	mov	w0, #0
	mov	w10, #0
	mov	w9, #3
Lloh2:
	adrp	x12, lJTI23_0@PAGE
Lloh3:
	add	x12, x12, lJTI23_0@PAGEOFF
	adr	x13, LBB23_2
	ldrb	w14, [x12, x11]
	add	x13, x13, x14, lsl #2
	br	x13
LBB23_2:
	mov	w9, #5
	b	LBB23_9
LBB23_3:
	mov	w0, #0
	mov	w10, #9
LBB23_4:
	bfi	w0, w10, #8, #4
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB23_5:
	mov	w9, #8
	b	LBB23_9
LBB23_6:
	mov	w9, #7
	b	LBB23_9
LBB23_7:
	mov	w9, #6
	b	LBB23_9
LBB23_8:
	mov	w9, #4
LBB23_9:
	cmp	w8, w19
	cset	w0, eq
	mov	x10, x9
	bfi	w0, w10, #8, #4
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
	.section	__TEXT,__const
lJTI23_0:
	.byte	(LBB23_4-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_2-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_5-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_8-LBB23_2)>>2
	.byte	(LBB23_3-LBB23_2)>>2
	.byte	(LBB23_9-LBB23_2)>>2
	.byte	(LBB23_6-LBB23_2)>>2
	.byte	(LBB23_7-LBB23_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_piece_from_string              ; -- Begin function piece_from_string
	.p2align	2
_piece_from_string:                     ; @piece_from_string
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0]
	cbz	w8, LBB24_2
; %bb.1:
	ldrb	w9, [x0, #1]
	cbz	w9, LBB24_3
LBB24_2:
	mov	w0, #2304
	ret
LBB24_3:
	sxtb	w0, w8
	b	_piece_from_symbol
	.cfi_endproc
                                        ; -- End function
	.globl	_piece_type_symbol              ; -- Begin function piece_type_symbol
	.p2align	2
_piece_type_symbol:                     ; @piece_type_symbol
	.cfi_startproc
; %bb.0:
                                        ; kill: def $w0 killed $w0 def $x0
	cmp	w0, #8
	b.hi	LBB25_2
; %bb.1:
	sxtb	x8, w0
Lloh4:
	adrp	x9, l_switch.table.piece_symbol@PAGE
Lloh5:
	add	x9, x9, l_switch.table.piece_symbol@PAGEOFF
	ldrb	w8, [x9, x8]
	sxtb	w0, w8
	ret
LBB25_2:
	mov	w8, #63
	sxtb	w0, w8
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc
                                        ; -- End function
	.globl	_piece_symbol                   ; -- Begin function piece_symbol
	.p2align	2
_piece_symbol:                          ; @piece_symbol
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ubfx	x9, x0, #8, #8
	and	x8, x0, #0xff
	cmp	w9, #8
	b.hi	LBB26_2
; %bb.1:
	lsr	x9, x0, #8
	sxtb	x9, w9
Lloh6:
	adrp	x10, l_switch.table.piece_symbol@PAGE
Lloh7:
	add	x10, x10, l_switch.table.piece_symbol@PAGEOFF
	ldrb	w0, [x10, x9]
	cmp	x8, #1
	b.eq	LBB26_3
	b	LBB26_4
LBB26_2:
	mov	w0, #63
	cmp	x8, #1
	b.ne	LBB26_4
LBB26_3:
	bl	___toupper
LBB26_4:
	sxtb	w0, w0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh6, Lloh7
	.cfi_endproc
                                        ; -- End function
	.globl	_write_name                     ; -- Begin function write_name
	.p2align	2
_write_name:                            ; @write_name
	.cfi_startproc
; %bb.0:
	sub	w8, w0, #3
	cmp	w8, #5
	b.hi	LBB27_3
; %bb.1:
Lloh8:
	adrp	x9, lJTI27_0@PAGE
Lloh9:
	add	x9, x9, lJTI27_0@PAGEOFF
	adr	x10, LBB27_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB27_2:
	strb	wzr, [x1, #4]
	mov	w8, #24912
	movk	w8, #28279, lsl #16
	str	w8, [x1]
	ret
LBB27_3:
	mov	x8, #28245
	movk	x8, #28267, lsl #16
	movk	x8, #30575, lsl #32
	movk	x8, #110, lsl #48
	str	x8, [x1]
	ret
LBB27_4:
	mov	w8, #26727
	movk	w8, #116, lsl #16
	stur	w8, [x1, #3]
	mov	w8, #28235
	movk	w8, #26473, lsl #16
	str	w8, [x1]
	ret
LBB27_5:
	mov	w8, #28520
	movk	w8, #112, lsl #16
	stur	w8, [x1, #3]
	mov	w8, #26946
	movk	w8, #26739, lsl #16
	str	w8, [x1]
	ret
LBB27_6:
	strb	wzr, [x1, #4]
	mov	w8, #28498
	movk	w8, #27503, lsl #16
	str	w8, [x1]
	ret
LBB27_7:
	mov	w8, #110
	strh	w8, [x1, #4]
	mov	w8, #30033
	movk	w8, #25957, lsl #16
	str	w8, [x1]
	ret
LBB27_8:
	strb	wzr, [x1, #4]
	mov	w8, #26955
	movk	w8, #26478, lsl #16
	str	w8, [x1]
	ret
	.loh AdrpAdd	Lloh8, Lloh9
	.cfi_endproc
	.section	__TEXT,__const
lJTI27_0:
	.byte	(LBB27_2-LBB27_2)>>2
	.byte	(LBB27_4-LBB27_2)>>2
	.byte	(LBB27_5-LBB27_2)>>2
	.byte	(LBB27_6-LBB27_2)>>2
	.byte	(LBB27_7-LBB27_2)>>2
	.byte	(LBB27_8-LBB27_2)>>2
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Pawn"

l_.str.1:                               ; @.str.1
	.asciz	"Bishop"

l_.str.2:                               ; @.str.2
	.asciz	"Knight"

l_.str.3:                               ; @.str.3
	.asciz	"Rook"

l_.str.4:                               ; @.str.4
	.asciz	"Queen"

l_.str.5:                               ; @.str.5
	.asciz	"King"

	.section	__TEXT,__const
l_switch.table.piece_symbol:            ; @switch.table.piece_symbol
	.ascii	"-??pnbrqk"

.subsections_via_symbols
