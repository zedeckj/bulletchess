	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_token_is                       ; -- Begin function token_is
	.p2align	2
_token_is:                              ; @token_is
	.cfi_startproc
; %bb.0:
	mov	x8, x0
	mov	w0, #0
	cbz	x8, LBB0_3
; %bb.1:
	cbz	x1, LBB0_3
; %bb.2:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x8, #8]
	bl	_strcmp
	cmp	w0, #0
	cset	w0, eq
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
LBB0_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_start_def_ctx                  ; -- Begin function start_def_ctx
	.p2align	2
_start_def_ctx:                         ; @start_def_ctx
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
	mov	w0, #72
	bl	_malloc
	str	x19, [x0]
	mov	w8, #1
	dup.2d	v0, x8
	stur	q0, [x0, #8]
	stp	xzr, xzr, [x0, #24]
	strb	wzr, [x0, #40]
	stp	xzr, xzr, [x0, #56]
	str	xzr, [x0, #48]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_start_context                  ; -- Begin function start_context
	.p2align	2
_start_context:                         ; @start_context
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
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
	mov	w0, #72
	bl	_malloc
	str	x22, [x0]
	mov	w8, #1
	dup.2d	v0, x8
	stur	q0, [x0, #8]
	stp	x21, x20, [x0, #48]
	stp	xzr, xzr, [x0, #24]
	strb	w19, [x0, #40]
	str	xzr, [x0, #64]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_start_op_ctx                   ; -- Begin function start_op_ctx
	.p2align	2
_start_op_ctx:                          ; @start_op_ctx
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
	mov	w0, #72
	bl	_malloc
	str	x20, [x0]
	mov	w8, #1
	dup.2d	v0, x8
	stur	q0, [x0, #8]
	stp	xzr, xzr, [x0, #24]
	strb	wzr, [x0, #40]
	stp	xzr, xzr, [x0, #56]
	str	x19, [x0, #48]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_start_delim_ctx                ; -- Begin function start_delim_ctx
	.p2align	2
_start_delim_ctx:                       ; @start_delim_ctx
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
	mov	x21, x0
	mov	w0, #72
	bl	_malloc
	str	x21, [x0]
	mov	w8, #1
	dup.2d	v0, x8
	stur	q0, [x0, #8]
	stp	xzr, x20, [x0, #48]
	stp	xzr, xzr, [x0, #24]
	strb	w19, [x0, #40]
	str	xzr, [x0, #64]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_free_token_list                ; -- Begin function free_token_list
	.p2align	2
_free_token_list:                       ; @free_token_list
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
Lloh0:
	adrp	x0, l_str@PAGE
Lloh1:
	add	x0, x0, l_str@PAGEOFF
	bl	_puts
	cbz	x19, LBB5_4
; %bb.1:
	ldr	x20, [x19]
	cbz	x20, LBB5_3
; %bb.2:
	ldr	x0, [x20, #8]
	bl	_free
	ldr	x0, [x20]
	bl	_free
	mov	x0, x20
	bl	_free
LBB5_3:
	ldr	x0, [x19, #8]
	bl	_free_token_list
	mov	x0, x19
	bl	_free
LBB5_4:
Lloh2:
	adrp	x0, l_str.3@PAGE
Lloh3:
	add	x0, x0, l_str.3@PAGEOFF
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_puts
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
	.globl	_free_token                     ; -- Begin function free_token
	.p2align	2
_free_token:                            ; @free_token
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB6_2
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
	mov	x19, x0
	ldr	x0, [x0, #8]
	bl	_free
	ldr	x0, [x19]
	bl	_free
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_free
LBB6_2:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_end_context                    ; -- Begin function end_context
	.p2align	2
_end_context:                           ; @end_context
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
	ldr	x0, [x0, #64]
	bl	_free_token_list
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_free
	.cfi_endproc
                                        ; -- End function
	.globl	_pop_token                      ; -- Begin function pop_token
	.p2align	2
_pop_token:                             ; @pop_token
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
	cbz	x0, LBB8_3
; %bb.1:
	mov	x20, x0
	ldr	x0, [x0, #64]
	cbz	x0, LBB8_3
; %bb.2:
	ldp	x19, x21, [x0]
	bl	_free
	str	x21, [x20, #64]
	mov	x0, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB8_3:
	mov	x19, #0
	mov	x0, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_untoken                        ; -- Begin function untoken
	.p2align	2
_untoken:                               ; @untoken
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
	mov	w0, #16
	bl	_malloc
	ldr	x8, [x19, #64]
	stp	x20, x8, [x0]
	str	x0, [x19, #64]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_write_loc                      ; -- Begin function write_loc
	.p2align	2
_write_loc:                             ; @write_loc
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB10_3
; %bb.1:
	cbz	x1, LBB10_3
; %bb.2:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	q0, [x0]
	ldr	x8, [x0, #16]
	str	x8, [sp, #16]
	str	q0, [sp]
Lloh4:
	adrp	x8, l_.str.2@PAGE
Lloh5:
	add	x8, x8, l_.str.2@PAGEOFF
	mov	x0, x1
	mov	x1, x8
	bl	_sprintf
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB10_3:
	mov	w0, #0
	ret
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc
                                        ; -- End function
	.globl	_new_token                      ; -- Begin function new_token
	.p2align	2
_new_token:                             ; @new_token
	.cfi_startproc
; %bb.0:
	cbz	x1, LBB11_2
; %bb.1:
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
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
	strb	wzr, [x0, x1]
	mov	w0, #16
	bl	_malloc
	mov	x22, x0
	add	x0, x21, #1
	bl	_malloc
	stp	x20, x0, [x22]
	mov	x1, x19
	bl	_strcpy
	mov	x0, x22
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB11_2:
	mov	x0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_oneof                       ; -- Begin function is_oneof
	.p2align	2
_is_oneof:                              ; @is_oneof
	.cfi_startproc
; %bb.0:
	cbz	x1, LBB12_4
; %bb.1:
	and	w8, w0, #0xff
LBB12_2:                                ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x1], #1
	cmp	w9, #0
	ccmp	w9, w8, #4, ne
	b.ne	LBB12_2
; %bb.3:
	cmp	w9, #0
	cset	w0, ne
	ret
LBB12_4:
	mov	w0, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_use_whitespace                 ; -- Begin function use_whitespace
	.p2align	2
_use_whitespace:                        ; @use_whitespace
	.cfi_startproc
; %bb.0:
	mov	x8, x0
	mov	w0, #0
	sub	w8, w8, #9
	cmp	w8, #23
	b.hi	LBB13_8
; %bb.1:
Lloh6:
	adrp	x9, lJTI13_0@PAGE
Lloh7:
	add	x9, x9, lJTI13_0@PAGEOFF
	adr	x10, LBB13_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB13_2:
	ldr	x8, [x1, #16]
	add	x8, x8, #1
	b	LBB13_6
LBB13_3:
	ldr	x8, [x1, #8]
	add	x8, x8, #1
	str	x8, [x1, #8]
	b	LBB13_7
LBB13_4:
	ldr	x8, [x1, #8]
	add	x8, x8, #1
	str	x8, [x1, #8]
LBB13_5:
	mov	w8, #1
LBB13_6:
	str	x8, [x1, #16]
LBB13_7:
	ldr	x8, [x1, #24]
	add	x8, x8, #1
	str	x8, [x1, #24]
	mov	w0, #1
LBB13_8:
	ret
	.loh AdrpAdd	Lloh6, Lloh7
	.cfi_endproc
	.section	__TEXT,__const
lJTI13_0:
	.byte	(LBB13_2-LBB13_2)>>2
	.byte	(LBB13_4-LBB13_2)>>2
	.byte	(LBB13_3-LBB13_2)>>2
	.byte	(LBB13_3-LBB13_2)>>2
	.byte	(LBB13_5-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_8-LBB13_2)>>2
	.byte	(LBB13_2-LBB13_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_fskip_whitespace               ; -- Begin function fskip_whitespace
	.p2align	2
_fskip_whitespace:                      ; @fskip_whitespace
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
	mov	x20, x1
	mov	x19, x0
	mov	w21, #1
Lloh8:
	adrp	x22, lJTI14_0@PAGE
Lloh9:
	add	x22, x22, lJTI14_0@PAGEOFF
	b	LBB14_4
LBB14_1:                                ;   in Loop: Header=BB14_4 Depth=1
	ldr	x8, [x20, #8]
	add	x8, x8, #1
	str	x8, [x20, #8]
LBB14_2:                                ;   in Loop: Header=BB14_4 Depth=1
	str	x21, [x20, #16]
LBB14_3:                                ;   in Loop: Header=BB14_4 Depth=1
	ldr	x8, [x20, #24]
	add	x8, x8, #1
	str	x8, [x20, #24]
LBB14_4:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x19
	bl	_getc
	sxtb	w0, w0
	sub	w8, w0, #9
	cmp	w8, #23
	b.hi	LBB14_8
; %bb.5:                                ;   in Loop: Header=BB14_4 Depth=1
	adr	x9, LBB14_1
	ldrb	w10, [x22, x8]
	add	x9, x9, x10, lsl #2
	br	x9
LBB14_6:                                ;   in Loop: Header=BB14_4 Depth=1
	ldr	x8, [x20, #16]
	add	x8, x8, #1
	str	x8, [x20, #16]
	b	LBB14_3
LBB14_7:                                ;   in Loop: Header=BB14_4 Depth=1
	ldr	x8, [x20, #8]
	add	x8, x8, #1
	str	x8, [x20, #8]
	b	LBB14_3
LBB14_8:
	mov	x1, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_ungetc
	.loh AdrpAdd	Lloh8, Lloh9
	.cfi_endproc
	.section	__TEXT,__const
lJTI14_0:
	.byte	(LBB14_6-LBB14_1)>>2
	.byte	(LBB14_1-LBB14_1)>>2
	.byte	(LBB14_7-LBB14_1)>>2
	.byte	(LBB14_7-LBB14_1)>>2
	.byte	(LBB14_2-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_8-LBB14_1)>>2
	.byte	(LBB14_6-LBB14_1)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_skip_whitespace                ; -- Begin function skip_whitespace
	.p2align	2
_skip_whitespace:                       ; @skip_whitespace
	.cfi_startproc
; %bb.0:
	ldr	x8, [x1, #24]
	ldrb	w11, [x0, x8]
	cbz	w11, LBB15_9
; %bb.1:
	add	x8, x8, #1
Lloh10:
	adrp	x9, lJTI15_0@PAGE
Lloh11:
	add	x9, x9, lJTI15_0@PAGEOFF
	mov	w10, #1
	b	LBB15_5
LBB15_2:                                ;   in Loop: Header=BB15_5 Depth=1
	ldr	x11, [x1, #8]
	add	x11, x11, #1
	str	x11, [x1, #8]
LBB15_3:                                ;   in Loop: Header=BB15_5 Depth=1
	str	x10, [x1, #16]
LBB15_4:                                ;   in Loop: Header=BB15_5 Depth=1
	str	x8, [x1, #24]
	ldrb	w11, [x0, x8]
	add	x8, x8, #1
	cbz	w11, LBB15_9
LBB15_5:                                ; =>This Inner Loop Header: Depth=1
	sxtb	w11, w11
	sub	w11, w11, #9
	cmp	w11, #23
	b.hi	LBB15_9
; %bb.6:                                ;   in Loop: Header=BB15_5 Depth=1
	adr	x12, LBB15_2
	ldrb	w13, [x9, x11]
	add	x12, x12, x13, lsl #2
	br	x12
LBB15_7:                                ;   in Loop: Header=BB15_5 Depth=1
	ldr	x11, [x1, #16]
	add	x11, x11, #1
	str	x11, [x1, #16]
	b	LBB15_4
LBB15_8:                                ;   in Loop: Header=BB15_5 Depth=1
	ldr	x11, [x1, #8]
	add	x11, x11, #1
	str	x11, [x1, #8]
	b	LBB15_4
LBB15_9:
	ret
	.loh AdrpAdd	Lloh10, Lloh11
	.cfi_endproc
	.section	__TEXT,__const
lJTI15_0:
	.byte	(LBB15_7-LBB15_2)>>2
	.byte	(LBB15_2-LBB15_2)>>2
	.byte	(LBB15_8-LBB15_2)>>2
	.byte	(LBB15_8-LBB15_2)>>2
	.byte	(LBB15_3-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_9-LBB15_2)>>2
	.byte	(LBB15_7-LBB15_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_copy_loc                       ; -- Begin function copy_loc
	.p2align	2
_copy_loc:                              ; @copy_loc
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
	mov	w0, #24
	bl	_malloc
	ldr	q0, [x19]
	str	q0, [x0]
	ldr	x8, [x19, #16]
	str	x8, [x0, #16]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_process_delim_char             ; -- Begin function process_delim_char
	.p2align	2
_process_delim_char:                    ; @process_delim_char
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
	mov	x20, x5
	mov	x19, x2
	cmp	w0, #92
	b.ne	LBB17_3
; %bb.1:
	ldrb	w8, [x4]
	cbnz	w8, LBB17_3
; %bb.2:
	mov	w8, #1
	strb	w8, [x4]
	ldr	q0, [x1, #16]
	dup.2d	v1, x8
	add.2d	v0, v0, v1
	str	q0, [x1, #16]
	mov	x0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB17_3:
	ldr	x8, [x3]
	add	x9, x8, #1
	str	x9, [x3]
	strb	w0, [x19, x8]
	sub	w8, w0, #9
	cmp	w8, #23
	b.hi	LBB17_13
; %bb.4:
Lloh12:
	adrp	x9, lJTI17_0@PAGE
Lloh13:
	add	x9, x9, lJTI17_0@PAGEOFF
	adr	x10, LBB17_5
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB17_5:
	ldr	x8, [x1, #16]
	add	x8, x8, #1
	b	LBB17_9
LBB17_6:
	ldr	x8, [x1, #8]
	add	x8, x8, #1
	str	x8, [x1, #8]
	b	LBB17_10
LBB17_7:
	ldr	x8, [x1, #8]
	add	x8, x8, #1
	str	x8, [x1, #8]
LBB17_8:
	mov	w8, #1
LBB17_9:
	str	x8, [x1, #16]
LBB17_10:
	ldr	x8, [x1, #24]
	add	x8, x8, #1
	str	x8, [x1, #24]
LBB17_11:
	strb	wzr, [x4]
LBB17_12:
	mov	x0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB17_13:
	ldr	q0, [x1, #16]
	mov	w8, #1
	dup.2d	v1, x8
	add.2d	v0, v0, v1
	str	q0, [x1, #16]
	cmp	w0, w6
	b.ne	LBB17_11
; %bb.14:
	ldrb	w8, [x4]
	cbnz	w8, LBB17_11
; %bb.15:
	ldr	x22, [x3]
	cbz	x22, LBB17_12
; %bb.16:
	strb	wzr, [x19, x22]
	mov	w0, #16
	bl	_malloc
	mov	x21, x0
	add	x0, x22, #1
	bl	_malloc
	stp	x20, x0, [x21]
	mov	x1, x19
	bl	_strcpy
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh12, Lloh13
	.cfi_endproc
	.section	__TEXT,__const
lJTI17_0:
	.byte	(LBB17_5-LBB17_5)>>2
	.byte	(LBB17_7-LBB17_5)>>2
	.byte	(LBB17_6-LBB17_5)>>2
	.byte	(LBB17_6-LBB17_5)>>2
	.byte	(LBB17_8-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_13-LBB17_5)>>2
	.byte	(LBB17_5-LBB17_5)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_delim_stok                     ; -- Begin function delim_stok
	.p2align	2
_delim_stok:                            ; @delim_stok
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
	sub	sp, sp, #1024
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
Lloh14:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh15:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh16:
	ldr	x8, [x8]
	stur	x8, [x29, #-72]
	ldr	x23, [x1, #24]
	add	x8, x23, #1
	str	x8, [x1, #24]
	add	x25, x0, x23
	ldrb	w8, [x25]
	strb	w8, [sp, #16]
	strb	wzr, [sp, #15]
	mov	w0, #24
	bl	_malloc
	mov	x19, x0
	ldr	q0, [x21]
	str	q0, [x0]
	ldr	x8, [x21, #16]
	str	x8, [x0, #16]
	add	x8, x8, #1
	str	x8, [x21, #16]
	mov	w24, #1
	str	x24, [sp]
	ldrb	w8, [x25, #1]
	cbz	w8, LBB18_5
; %bb.1:
	add	x9, x23, x22
	add	x23, x9, #2
LBB18_2:                                ; =>This Inner Loop Header: Depth=1
	sxtb	w0, w8
	add	x2, sp, #16
	mov	x3, sp
	add	x4, sp, #15
	mov	x1, x21
	mov	x5, x19
	mov	x6, x20
	bl	_process_delim_char
	cbnz	x0, LBB18_6
; %bb.3:                                ;   in Loop: Header=BB18_2 Depth=1
	ldrb	w8, [x23], #1
	cbnz	w8, LBB18_2
; %bb.4:
	ldr	x24, [sp]
	cbz	x24, LBB18_8
LBB18_5:
	add	x8, sp, #16
	strb	wzr, [x8, x24]
	mov	w0, #16
	bl	_malloc
	mov	x22, x0
	add	x0, x24, #1
	bl	_malloc
	stp	x19, x0, [x22]
	add	x1, sp, #16
	bl	_strcpy
	ldur	x8, [x29, #-72]
Lloh17:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh18:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh19:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB18_7
	b	LBB18_9
LBB18_6:
	mov	x22, x0
	ldur	x8, [x29, #-72]
Lloh20:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh21:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh22:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB18_9
LBB18_7:
	mov	x0, x22
	add	sp, sp, #1024
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
LBB18_8:
	mov	x22, #0
	ldur	x8, [x29, #-72]
Lloh23:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh24:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh25:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB18_7
LBB18_9:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh14, Lloh15, Lloh16
	.loh AdrpLdrGotLdr	Lloh17, Lloh18, Lloh19
	.loh AdrpLdrGotLdr	Lloh20, Lloh21, Lloh22
	.loh AdrpLdrGotLdr	Lloh23, Lloh24, Lloh25
	.cfi_endproc
                                        ; -- End function
	.globl	_delim_ftok                     ; -- Begin function delim_ftok
	.p2align	2
_delim_ftok:                            ; @delim_ftok
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-80]!           ; 16-byte Folded Spill
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
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	sub	sp, sp, #1024
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
Lloh26:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh27:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh28:
	ldr	x8, [x8]
	stur	x8, [x29, #-72]
	bl	_getc
	strb	w0, [sp, #16]
	strb	wzr, [sp, #15]
	mov	w0, #24
	bl	_malloc
	mov	x19, x0
	ldr	q0, [x21]
	str	q0, [x0]
	ldr	x8, [x21, #16]
	str	x8, [x0, #16]
	add	x8, x8, #1
	str	x8, [x21, #16]
	mov	w8, #1
	str	x8, [sp]
	mov	w24, #-16777216
LBB19_1:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x22
	bl	_getc
	lsl	w8, w0, #24
	cmp	w8, w24
	ccmp	w8, #0, #4, ne
	b.eq	LBB19_4
; %bb.2:                                ;   in Loop: Header=BB19_1 Depth=1
	sxtb	w0, w0
	add	x2, sp, #16
	mov	x3, sp
	add	x4, sp, #15
	mov	x1, x21
	mov	x5, x19
	mov	x6, x20
	bl	_process_delim_char
	cbz	x0, LBB19_1
; %bb.3:
	mov	x23, x0
	ldur	x8, [x29, #-72]
Lloh29:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh30:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh31:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB19_6
	b	LBB19_8
LBB19_4:
	ldr	x20, [sp]
	cbz	x20, LBB19_7
; %bb.5:
	add	x8, sp, #16
	strb	wzr, [x8, x20]
	mov	w0, #16
	bl	_malloc
	mov	x23, x0
	add	x0, x20, #1
	bl	_malloc
	stp	x19, x0, [x23]
	add	x1, sp, #16
	bl	_strcpy
	ldur	x8, [x29, #-72]
Lloh32:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh33:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh34:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB19_8
LBB19_6:
	mov	x0, x23
	add	sp, sp, #1024
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #80             ; 16-byte Folded Reload
	ret
LBB19_7:
	mov	x23, #0
	ldur	x8, [x29, #-72]
Lloh35:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh36:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh37:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB19_6
LBB19_8:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh26, Lloh27, Lloh28
	.loh AdrpLdrGotLdr	Lloh29, Lloh30, Lloh31
	.loh AdrpLdrGotLdr	Lloh32, Lloh33, Lloh34
	.loh AdrpLdrGotLdr	Lloh35, Lloh36, Lloh37
	.cfi_endproc
                                        ; -- End function
	.globl	_process_char                   ; -- Begin function process_char
	.p2align	2
_process_char:                          ; @process_char
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
	mov	x24, x5
	mov	x20, x4
	mov	x21, x3
	mov	x19, x2
	mov	x23, x1
	mov	x22, x0
	ldr	x8, [x1, #48]
	cbz	x8, LBB20_6
LBB20_1:                                ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x8], #1
	cbz	w9, LBB20_3
; %bb.2:                                ;   in Loop: Header=BB20_1 Depth=1
	cmp	w9, w22, uxtb
	b.ne	LBB20_1
LBB20_3:
	cbz	w9, LBB20_6
; %bb.4:
	ldr	x8, [x21]
	cbz	x8, LBB20_11
; %bb.5:
	mov	w9, #1
	strb	w9, [x24]
	strb	wzr, [x19, x8]
	ldr	x22, [x21]
	cbnz	x22, LBB20_12
	b	LBB20_13
LBB20_6:
	tbnz	w22, #31, LBB20_9
; %bb.7:
Lloh38:
	adrp	x8, __DefaultRuneLocale@GOTPAGE
Lloh39:
	ldr	x8, [x8, __DefaultRuneLocale@GOTPAGEOFF]
	add	x8, x8, w22, uxtw #2
	ldr	w8, [x8, #60]
	and	w0, w8, #0x4000
	cbz	w0, LBB20_10
LBB20_8:
	mov	w8, #1
	strb	w8, [x24]
	ldr	x8, [x21]
	strb	wzr, [x19, x8]
	ldr	x22, [x21]
	cbnz	x22, LBB20_12
	b	LBB20_13
LBB20_9:
	mov	x0, x22
	mov	w1, #16384
	bl	___maskrune
	cbnz	w0, LBB20_8
LBB20_10:
	ldr	q0, [x23, #16]
	mov	w8, #1
	dup.2d	v1, x8
	add.2d	v0, v0, v1
	str	q0, [x23, #16]
	ldr	x8, [x21]
	add	x9, x8, #1
	str	x9, [x21]
	strb	w22, [x19, x8]
	b	LBB20_13
LBB20_11:
	ldr	q0, [x23, #16]
	mov	w8, #1
	dup.2d	v1, x8
	add.2d	v0, v0, v1
	str	q0, [x23, #16]
	strb	w22, [x19]
	str	x8, [x21]
	strb	wzr, [x19, x8]
	ldr	x22, [x21]
	cbz	x22, LBB20_13
LBB20_12:
	strb	wzr, [x19, x22]
	mov	w0, #16
	bl	_malloc
	mov	x21, x0
	add	x0, x22, #1
	bl	_malloc
	stp	x20, x0, [x21]
	mov	x1, x19
	bl	_strcpy
	mov	x0, x21
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB20_13:
	mov	x0, #0
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh38, Lloh39
	.cfi_endproc
                                        ; -- End function
	.globl	_check_ptr                      ; -- Begin function check_ptr
	.p2align	2
_check_ptr:                             ; @check_ptr
	.cfi_startproc
; %bb.0:
	mov	x8, x0
	cmp	x0, #0
	ccmp	x1, #0, #4, ne
	cset	w0, ne
	b.eq	LBB21_3
; %bb.1:
	ldr	x9, [x1, #32]
	cmp	x9, x8
	b.eq	LBB21_3
; %bb.2:
	stp	xzr, x8, [x1, #24]
LBB21_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_matching_delim                 ; -- Begin function matching_delim
	.p2align	2
_matching_delim:                        ; @matching_delim
	.cfi_startproc
; %bb.0:
	cbz	x1, LBB22_7
; %bb.1:
	ldrb	w10, [x1]
	cbz	w10, LBB22_7
; %bb.2:
	and	w9, w0, #0xff
	mov	w8, #1
	b	LBB22_4
LBB22_3:                                ;   in Loop: Header=BB22_4 Depth=1
	ldrb	w10, [x1, x8]
	add	x8, x8, #1
	cbz	w10, LBB22_7
LBB22_4:                                ; =>This Inner Loop Header: Depth=1
	cmp	w10, w9
	b.ne	LBB22_3
; %bb.5:                                ;   in Loop: Header=BB22_4 Depth=1
	sub	w10, w8, #1
	tbnz	w10, #0, LBB22_3
; %bb.6:
	ldrb	w8, [x1, w8, uxtw]
	sxtb	w0, w8
	ret
LBB22_7:
	sxtb	w0, wzr
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_stoken                         ; -- Begin function stoken
	.p2align	2
_stoken:                                ; @stoken
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
	sub	sp, sp, #1024
Lloh40:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh41:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh42:
	ldr	x8, [x8]
	stur	x8, [x29, #-56]
	cbz	x1, LBB23_33
; %bb.1:
	mov	x19, x1
	mov	x20, x0
	ldr	x0, [x1, #64]
	cbz	x0, LBB23_5
; %bb.2:
	ldp	x22, x21, [x0]
	bl	_free
	str	x21, [x19, #64]
	cbz	x22, LBB23_5
; %bb.3:
	ldur	x8, [x29, #-56]
Lloh43:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh44:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh45:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB23_34
LBB23_4:
	mov	x0, x22
	add	sp, sp, #1024
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB23_5:
	cbz	x20, LBB23_33
; %bb.6:
	ldr	x8, [x19, #32]
	cmp	x8, x20
	b.eq	LBB23_8
; %bb.7:
	stp	xzr, x20, [x19, #24]
LBB23_8:
	ldrb	w8, [x20]
	cbz	w8, LBB23_33
; %bb.9:
	str	xzr, [sp, #8]
	ldr	x23, [x19, #24]
	ldrb	w22, [x20, x23]
	cbz	w22, LBB23_19
; %bb.10:
	add	x8, x23, #1
Lloh46:
	adrp	x9, lJTI23_0@PAGE
Lloh47:
	add	x9, x9, lJTI23_0@PAGEOFF
	mov	w10, #1
	b	LBB23_14
LBB23_11:                               ;   in Loop: Header=BB23_14 Depth=1
	ldr	x11, [x19, #8]
	add	x11, x11, #1
	str	x11, [x19, #8]
LBB23_12:                               ;   in Loop: Header=BB23_14 Depth=1
	str	x10, [x19, #16]
LBB23_13:                               ;   in Loop: Header=BB23_14 Depth=1
	str	x8, [x19, #24]
	ldrb	w22, [x20, x8]
	add	x8, x8, #1
	cbz	w22, LBB23_18
LBB23_14:                               ; =>This Inner Loop Header: Depth=1
	sxtb	w11, w22
	sub	w11, w11, #9
	cmp	w11, #23
	b.hi	LBB23_18
; %bb.15:                               ;   in Loop: Header=BB23_14 Depth=1
	adr	x12, LBB23_11
	ldrb	w13, [x9, x11]
	add	x12, x12, x13, lsl #2
	br	x12
LBB23_16:                               ;   in Loop: Header=BB23_14 Depth=1
	ldr	x11, [x19, #16]
	add	x11, x11, #1
	str	x11, [x19, #16]
	b	LBB23_13
LBB23_17:                               ;   in Loop: Header=BB23_14 Depth=1
	ldr	x11, [x19, #8]
	add	x11, x11, #1
	str	x11, [x19, #8]
	b	LBB23_13
LBB23_18:
	sub	x23, x8, #1
LBB23_19:
	mov	w0, #24
	bl	_malloc
	mov	x21, x0
	ldr	q0, [x19]
	str	q0, [x0]
	ldr	x8, [x19, #16]
	str	x8, [x0, #16]
	ldr	x8, [x19, #56]
	cbz	x8, LBB23_27
; %bb.20:
	ldrb	w10, [x8]
	cbz	w10, LBB23_27
; %bb.21:
	mov	w9, #1
	b	LBB23_23
LBB23_22:                               ;   in Loop: Header=BB23_23 Depth=1
	ldrb	w10, [x8, x9]
	add	x9, x9, #1
	cbz	w10, LBB23_27
LBB23_23:                               ; =>This Inner Loop Header: Depth=1
	and	w10, w10, #0xff
	cmp	w10, w22, uxtb
	b.ne	LBB23_22
; %bb.24:                               ;   in Loop: Header=BB23_23 Depth=1
	sub	w10, w9, #1
	tbnz	w10, #0, LBB23_22
; %bb.25:
	ldrb	w8, [x8, w9, uxtw]
	cbz	w8, LBB23_27
; %bb.26:
	sxtb	w2, w8
	mov	x0, x20
	mov	x1, x19
	bl	_delim_stok
	mov	x22, x0
	ldur	x8, [x29, #-56]
Lloh48:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh49:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh50:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB23_4
	b	LBB23_34
LBB23_27:
	tst	w22, #0xff
	b.eq	LBB23_33
; %bb.28:
	add	x8, x23, x20
	add	x20, x8, #1
LBB23_29:                               ; =>This Inner Loop Header: Depth=1
	sxtb	w0, w22
	add	x2, sp, #16
	add	x3, sp, #8
	add	x5, sp, #7
	mov	x1, x19
	mov	x4, x21
	bl	_process_char
	cbnz	x0, LBB23_35
; %bb.30:                               ;   in Loop: Header=BB23_29 Depth=1
	ldrb	w22, [x20], #1
	cbnz	w22, LBB23_29
; %bb.31:
	ldr	x19, [sp, #8]
	cbz	x19, LBB23_33
; %bb.32:
	add	x8, sp, #16
	strb	wzr, [x8, x19]
	mov	w0, #16
	bl	_malloc
	mov	x22, x0
	add	x0, x19, #1
	bl	_malloc
	stp	x21, x0, [x22]
	add	x1, sp, #16
	bl	_strcpy
	ldur	x8, [x29, #-56]
Lloh51:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh52:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh53:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB23_4
	b	LBB23_34
LBB23_33:
	mov	x22, #0
	ldur	x8, [x29, #-56]
Lloh54:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh55:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh56:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB23_4
LBB23_34:
	bl	___stack_chk_fail
LBB23_35:
	mov	x22, x0
	ldur	x8, [x29, #-56]
Lloh57:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh58:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh59:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB23_4
	b	LBB23_34
	.loh AdrpLdrGotLdr	Lloh40, Lloh41, Lloh42
	.loh AdrpLdrGotLdr	Lloh43, Lloh44, Lloh45
	.loh AdrpAdd	Lloh46, Lloh47
	.loh AdrpLdrGotLdr	Lloh48, Lloh49, Lloh50
	.loh AdrpLdrGotLdr	Lloh51, Lloh52, Lloh53
	.loh AdrpLdrGotLdr	Lloh54, Lloh55, Lloh56
	.loh AdrpLdrGotLdr	Lloh57, Lloh58, Lloh59
	.cfi_endproc
	.section	__TEXT,__const
lJTI23_0:
	.byte	(LBB23_16-LBB23_11)>>2
	.byte	(LBB23_11-LBB23_11)>>2
	.byte	(LBB23_17-LBB23_11)>>2
	.byte	(LBB23_17-LBB23_11)>>2
	.byte	(LBB23_12-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_18-LBB23_11)>>2
	.byte	(LBB23_16-LBB23_11)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_ftoken                         ; -- Begin function ftoken
	.p2align	2
_ftoken:                                ; @ftoken
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
	sub	sp, sp, #1024
Lloh60:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh61:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh62:
	ldr	x8, [x8]
	stur	x8, [x29, #-56]
	cbz	x1, LBB24_16
; %bb.1:
	mov	x20, x1
	mov	x19, x0
	ldr	x0, [x1, #64]
	cbz	x0, LBB24_3
; %bb.2:
	ldp	x22, x21, [x0]
	bl	_free
	str	x21, [x20, #64]
	cbnz	x22, LBB24_17
LBB24_3:
	cbz	x19, LBB24_16
; %bb.4:
	ldr	x8, [x20, #32]
	cmp	x8, x19
	b.eq	LBB24_6
; %bb.5:
	stp	xzr, x19, [x20, #24]
LBB24_6:
	str	xzr, [sp, #8]
	mov	x0, x19
	mov	x1, x20
	bl	_fskip_whitespace
	mov	w0, #24
	bl	_malloc
	mov	x21, x0
	ldr	q0, [x20]
	str	q0, [x0]
	ldr	x8, [x20, #16]
	str	x8, [x0, #16]
	mov	x0, x19
	bl	_getc
	mov	x22, x0
	mov	x1, x19
	bl	_ungetc
	ldr	x8, [x20, #56]
	cbz	x8, LBB24_14
; %bb.7:
	ldrb	w11, [x8]
	cbz	w11, LBB24_14
; %bb.8:
	and	w10, w22, #0xff
	mov	w9, #1
	b	LBB24_10
LBB24_9:                                ;   in Loop: Header=BB24_10 Depth=1
	ldrb	w11, [x8, x9]
	add	x9, x9, #1
	cbz	w11, LBB24_14
LBB24_10:                               ; =>This Inner Loop Header: Depth=1
	cmp	w11, w10
	b.ne	LBB24_9
; %bb.11:                               ;   in Loop: Header=BB24_10 Depth=1
	sub	w11, w9, #1
	tbnz	w11, #0, LBB24_9
; %bb.12:
	ldrb	w8, [x8, w9, uxtw]
	cbz	w8, LBB24_14
; %bb.13:
	sxtb	w2, w8
	mov	x0, x19
	mov	x1, x20
	bl	_delim_ftok
	mov	x22, x0
	b	LBB24_17
LBB24_14:
	mov	x0, x19
	bl	_getc
	mov	x23, x0
	add	w8, w0, #1
	cmp	w8, #2
	b.hs	LBB24_19
; %bb.15:
	mov	x0, x23
	mov	x1, x19
	bl	_ungetc
LBB24_16:
	mov	x22, #0
LBB24_17:
	ldur	x8, [x29, #-56]
Lloh63:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh64:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh65:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB24_25
; %bb.18:
	mov	x0, x22
	add	sp, sp, #1024
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB24_19:                               ; =>This Inner Loop Header: Depth=1
	strb	wzr, [sp, #7]
	sxtb	w0, w23
	add	x2, sp, #16
	add	x3, sp, #8
	add	x5, sp, #7
	mov	x1, x20
	mov	x4, x21
	bl	_process_char
	cbnz	x0, LBB24_23
; %bb.20:                               ;   in Loop: Header=BB24_19 Depth=1
	mov	x0, x19
	bl	_getc
	mov	x23, x0
	add	w8, w0, #1
	cmp	w8, #2
	b.hs	LBB24_19
; %bb.21:
	ldr	x20, [sp, #8]
	mov	x0, x23
	mov	x1, x19
	bl	_ungetc
	cbz	x20, LBB24_16
; %bb.22:
	add	x8, sp, #16
	strb	wzr, [x8, x20]
	mov	w0, #16
	bl	_malloc
	mov	x22, x0
	add	x0, x20, #1
	bl	_malloc
	stp	x21, x0, [x22]
	add	x1, sp, #16
	bl	_strcpy
	b	LBB24_17
LBB24_23:
	mov	x22, x0
	ldrb	w8, [sp, #7]
	cbz	w8, LBB24_17
; %bb.24:
	mov	x0, x23
	mov	x1, x19
	bl	_ungetc
	b	LBB24_17
LBB24_25:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh60, Lloh61, Lloh62
	.loh AdrpLdrGotLdr	Lloh63, Lloh64, Lloh65
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str.2:                               ; @.str.2
	.asciz	"%s:%ld:%ld"

l_str:                                  ; @str
	.asciz	"freeing tok list"

l_str.3:                                ; @str.3
	.asciz	"done"

.subsections_via_symbols
