	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_alloc_err                      ; -- Begin function alloc_err
	.p2align	2
_alloc_err:                             ; @alloc_err
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-64]!           ; 16-byte Folded Spill
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
	.cfi_offset w27, -56
	.cfi_offset w28, -64
	sub	sp, sp, #544
	mov	x19, x1
Lloh0:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh1:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh2:
	ldr	x8, [x8]
	stur	x8, [x29, #-56]
	cbz	x2, LBB0_3
; %bb.1:
	mov	x20, x2
	ldr	x0, [x2]
	add	x22, sp, #36
	add	x1, sp, #36
	bl	_write_loc
	add	x0, sp, #36
	bl	_strlen
	mov	x21, x0
	mov	x0, x19
	bl	_strlen
	add	x8, x21, x0
	add	x0, x8, #100
	bl	_malloc
	mov	x21, x0
	ldr	x8, [x20, #8]
	stp	x19, x8, [sp, #8]
	str	x22, [sp]
Lloh3:
	adrp	x1, l_.str@PAGE
Lloh4:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x20
	bl	_free_token
	ldur	x8, [x29, #-56]
Lloh5:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh6:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh7:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB0_4
LBB0_2:
	mov	x0, x21
	add	sp, sp, #544
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #64             ; 16-byte Folded Reload
	ret
LBB0_3:
	add	x22, sp, #36
	add	x1, sp, #36
	bl	_write_loc
	add	x0, sp, #36
	bl	_strlen
	mov	x20, x0
	mov	x0, x19
	bl	_strlen
	add	x8, x20, x0
	add	x0, x8, #100
	bl	_malloc
	mov	x21, x0
	stp	x22, x19, [sp]
Lloh8:
	adrp	x1, l_.str.1@PAGE
Lloh9:
	add	x1, x1, l_.str.1@PAGEOFF
	bl	_sprintf
	ldur	x8, [x29, #-56]
Lloh10:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh11:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh12:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB0_2
LBB0_4:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh0, Lloh1, Lloh2
	.loh AdrpLdrGotLdr	Lloh5, Lloh6, Lloh7
	.loh AdrpAdd	Lloh3, Lloh4
	.loh AdrpLdrGotLdr	Lloh10, Lloh11, Lloh12
	.loh AdrpAdd	Lloh8, Lloh9
	.cfi_endproc
                                        ; -- End function
	.globl	_strip_str                      ; -- Begin function strip_str
	.p2align	2
_strip_str:                             ; @strip_str
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
	add	x1, x1, #1
	bl	_strcpy
	bl	_strlen
	add	x8, x19, x0
	sturb	wzr, [x8, #-1]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_make_dst_dict                  ; -- Begin function make_dst_dict
	.p2align	2
_make_dst_dict:                         ; @make_dst_dict
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
	mov	x20, x3
	mov	x22, x2
	mov	x19, x1
	mov	x23, x0
	mov	w0, #20
	bl	_new_dict
	mov	x21, x0
	ldr	x2, [x23]
Lloh13:
	adrp	x1, l_.str.2@PAGE
Lloh14:
	add	x1, x1, l_.str.2@PAGEOFF
	bl	_dict_add
	ldr	x2, [x23, #8]
Lloh15:
	adrp	x1, l_.str.3@PAGE
Lloh16:
	add	x1, x1, l_.str.3@PAGEOFF
	mov	x0, x21
	bl	_dict_add
Lloh17:
	adrp	x1, l_.str.4@PAGE
Lloh18:
	add	x1, x1, l_.str.4@PAGEOFF
	mov	x0, x21
	mov	x2, x22
	bl	_dict_add
	ldr	x2, [x23, #24]
Lloh19:
	adrp	x1, l_.str.5@PAGE
Lloh20:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x21
	bl	_dict_add
	ldr	x2, [x23, #32]
Lloh21:
	adrp	x1, l_.str.6@PAGE
Lloh22:
	add	x1, x1, l_.str.6@PAGEOFF
	mov	x0, x21
	bl	_dict_add
	ldr	x2, [x23, #40]
Lloh23:
	adrp	x1, l_.str.7@PAGE
Lloh24:
	add	x1, x1, l_.str.7@PAGEOFF
	mov	x0, x21
	bl	_dict_add
Lloh25:
	adrp	x1, l_.str.8@PAGE
Lloh26:
	add	x1, x1, l_.str.8@PAGEOFF
	mov	x0, x21
	mov	x2, x20
	bl	_dict_add
Lloh27:
	adrp	x1, l_.str.9@PAGE
Lloh28:
	add	x1, x1, l_.str.9@PAGEOFF
	mov	x0, x21
	mov	x2, x19
	bl	_dict_add
	mov	x0, x21
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh27, Lloh28
	.loh AdrpAdd	Lloh25, Lloh26
	.loh AdrpAdd	Lloh23, Lloh24
	.loh AdrpAdd	Lloh21, Lloh22
	.loh AdrpAdd	Lloh19, Lloh20
	.loh AdrpAdd	Lloh17, Lloh18
	.loh AdrpAdd	Lloh15, Lloh16
	.loh AdrpAdd	Lloh13, Lloh14
	.cfi_endproc
                                        ; -- End function
	.globl	_pgntoken                       ; -- Begin function pgntoken
	.p2align	2
_pgntoken:                              ; @pgntoken
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
	bl	_ftoken
	cbz	x0, LBB3_5
; %bb.1:
	ldr	x8, [x0, #8]
	ldrb	w8, [x8]
	cmp	w8, #59
	b.ne	LBB3_5
; %bb.2:
	ldr	x8, [x0]
	ldr	x21, [x8, #8]
LBB3_3:                                 ; =>This Inner Loop Header: Depth=1
	bl	_free_token
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
	cbz	x0, LBB3_5
; %bb.4:                                ;   in Loop: Header=BB3_3 Depth=1
	ldr	x8, [x0]
	ldr	x8, [x8, #8]
	cmp	x8, x21
	b.ls	LBB3_3
LBB3_5:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_add_tag_pair                   ; -- Begin function add_tag_pair
	.p2align	2
_add_tag_pair:                          ; @add_tag_pair
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-64]!           ; 16-byte Folded Spill
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
	.cfi_offset w27, -56
	.cfi_offset w28, -64
	sub	sp, sp, #544
	mov	x22, x4
	mov	x21, x2
	mov	x19, x1
	mov	x20, x0
Lloh29:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh30:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh31:
	ldr	x8, [x8]
	stur	x8, [x29, #-56]
	cbz	x1, LBB4_3
; %bb.1:
	ldr	x0, [x19, #8]
	bl	_strlen
	cmp	x0, #255
	b.lo	LBB4_3
; %bb.2:
	ldr	x0, [x19]
	add	x21, sp, #36
	add	x1, sp, #36
	bl	_write_loc
	add	x0, sp, #36
	bl	_strlen
	add	x0, x0, #153
	bl	_malloc
	mov	x20, x0
	ldr	x9, [x19, #8]
Lloh32:
	adrp	x8, l_.str.10@PAGE
Lloh33:
	add	x8, x8, l_.str.10@PAGEOFF
	stp	x8, x9, [sp, #8]
	str	x21, [sp]
Lloh34:
	adrp	x1, l_.str@PAGE
Lloh35:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x19
	bl	_free_token
	b	LBB4_6
LBB4_3:
	ldr	x1, [x20, #8]
	mov	x0, x21
	bl	_dict_remove
	cbz	x0, LBB4_5
; %bb.4:
	mov	x21, x0
	ldr	x1, [x20, #8]
	mov	x0, x22
	mov	x2, x19
	bl	_dict_add
	ldr	x8, [x19, #8]
	add	x1, x8, #1
	add	x19, sp, #36
	add	x0, sp, #36
	mov	w2, #255
	bl	_strncpy
	add	x0, sp, #36
	bl	_strlen
	add	x8, x19, x0
	sturb	wzr, [x8, #-1]
	add	x1, sp, #36
	mov	x0, x21
	mov	w2, #255
	bl	_strncpy
	mov	x0, x20
	bl	_free_token
LBB4_5:
	mov	x20, #0
LBB4_6:
	ldur	x8, [x29, #-56]
Lloh36:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh37:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh38:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB4_8
; %bb.7:
	mov	x0, x20
	add	sp, sp, #544
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #64             ; 16-byte Folded Reload
	ret
LBB4_8:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh29, Lloh30, Lloh31
	.loh AdrpAdd	Lloh34, Lloh35
	.loh AdrpAdd	Lloh32, Lloh33
	.loh AdrpLdrGotLdr	Lloh36, Lloh37, Lloh38
	.cfi_endproc
                                        ; -- End function
	.globl	_read_tag_pair                  ; -- Begin function read_tag_pair
	.p2align	2
_read_tag_pair:                         ; @read_tag_pair
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
	sub	sp, sp, #544
	mov	x20, x4
	mov	x22, x3
	mov	x21, x2
	mov	x23, x1
	mov	x24, x0
Lloh39:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh40:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh41:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	bl	_ftoken
	cbz	x0, LBB5_6
; %bb.1:
	mov	x19, x0
	ldr	x8, [x0, #8]
	ldrb	w8, [x8]
	cmp	w8, #59
	b.ne	LBB5_8
; %bb.2:
	ldr	x8, [x19]
	ldr	x25, [x8, #8]
	mov	x0, x19
	bl	_free_token
	mov	x0, x24
	mov	x1, x23
	bl	_ftoken
	cbz	x0, LBB5_6
; %bb.3:
	mov	x19, x0
LBB5_4:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x19]
	ldr	x8, [x8, #8]
	cmp	x8, x25
	b.hi	LBB5_8
; %bb.5:                                ;   in Loop: Header=BB5_4 Depth=1
	mov	x0, x19
	bl	_free_token
	mov	x0, x24
	mov	x1, x23
	bl	_ftoken
	mov	x19, x0
	cbnz	x0, LBB5_4
LBB5_6:
	ldur	x8, [x29, #-88]
Lloh42:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh43:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh44:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB5_32
; %bb.7:
Lloh45:
	adrp	x1, l_.str.15@PAGE
Lloh46:
	add	x1, x1, l_.str.15@PAGEOFF
	mov	x0, x23
	mov	x2, x22
	add	sp, sp, #544
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	b	_alloc_err
LBB5_8:
	mov	x0, x22
	bl	_free_token
	mov	x0, x24
	mov	x1, x23
	bl	_ftoken
	cbz	x0, LBB5_14
; %bb.9:
	mov	x22, x0
	ldr	x8, [x0, #8]
	ldrb	w8, [x8]
	cmp	w8, #59
	b.ne	LBB5_16
; %bb.10:
	ldr	x8, [x22]
	ldr	x25, [x8, #8]
	mov	x0, x22
	bl	_free_token
	mov	x0, x24
	mov	x1, x23
	bl	_ftoken
	cbz	x0, LBB5_14
; %bb.11:
	mov	x22, x0
LBB5_12:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x22]
	ldr	x8, [x8, #8]
	cmp	x8, x25
	b.hi	LBB5_15
; %bb.13:                               ;   in Loop: Header=BB5_12 Depth=1
	mov	x0, x22
	bl	_free_token
	mov	x0, x24
	mov	x1, x23
	bl	_ftoken
	mov	x22, x0
	cbnz	x0, LBB5_12
LBB5_14:
	ldr	x0, [x19]
	add	x21, sp, #36
	add	x1, sp, #36
	bl	_write_loc
	add	x0, sp, #36
	bl	_strlen
	add	x0, x0, #126
	bl	_malloc
	mov	x20, x0
	ldr	x9, [x19, #8]
Lloh47:
	adrp	x8, l_.str.11@PAGE
Lloh48:
	add	x8, x8, l_.str.11@PAGEOFF
	stp	x8, x9, [sp, #8]
	str	x21, [sp]
Lloh49:
	adrp	x1, l_.str@PAGE
Lloh50:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x19
	b	LBB5_26
LBB5_15:
	ldr	x8, [x22, #8]
	ldrb	w8, [x8]
LBB5_16:
	cmp	w8, #34
	b.ne	LBB5_24
; %bb.17:
	mov	x0, x24
	mov	x1, x23
	bl	_ftoken
	cbz	x0, LBB5_23
; %bb.18:
	mov	x25, x0
	ldr	x8, [x0, #8]
	ldrb	w8, [x8]
	cmp	w8, #59
	b.ne	LBB5_28
; %bb.19:
	ldr	x8, [x25]
	ldr	x26, [x8, #8]
	mov	x0, x25
	bl	_free_token
	mov	x0, x24
	mov	x1, x23
	bl	_ftoken
	cbz	x0, LBB5_23
; %bb.20:
	mov	x25, x0
LBB5_21:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x25]
	ldr	x8, [x8, #8]
	cmp	x8, x26
	b.hi	LBB5_28
; %bb.22:                               ;   in Loop: Header=BB5_21 Depth=1
	mov	x0, x25
	bl	_free_token
	mov	x0, x24
	mov	x1, x23
	bl	_ftoken
	mov	x25, x0
	cbnz	x0, LBB5_21
LBB5_23:
	mov	x0, x19
	bl	_free_token
	ldr	x0, [x22]
	add	x19, sp, #36
	add	x1, sp, #36
	bl	_write_loc
	add	x0, sp, #36
	bl	_strlen
	add	x0, x0, #125
	bl	_malloc
	mov	x20, x0
	ldr	x8, [x22, #8]
	str	x8, [sp, #16]
Lloh51:
	adrp	x8, l_.str.12@PAGE
Lloh52:
	add	x8, x8, l_.str.12@PAGEOFF
	b	LBB5_25
LBB5_24:
	mov	x0, x19
	bl	_free_token
	ldr	x0, [x22]
	add	x19, sp, #36
	add	x1, sp, #36
	bl	_write_loc
	add	x0, sp, #36
	bl	_strlen
	add	x0, x0, #126
	bl	_malloc
	mov	x20, x0
	ldr	x8, [x22, #8]
	str	x8, [sp, #16]
Lloh53:
	adrp	x8, l_.str.14@PAGE
Lloh54:
	add	x8, x8, l_.str.14@PAGEOFF
LBB5_25:
	stp	x19, x8, [sp]
Lloh55:
	adrp	x1, l_.str@PAGE
Lloh56:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x22
LBB5_26:
	bl	_free_token
	ldur	x8, [x29, #-88]
Lloh57:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh58:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh59:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB5_32
; %bb.27:
	mov	x0, x20
	add	sp, sp, #544
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB5_28:
Lloh60:
	adrp	x1, l_.str.13@PAGE
Lloh61:
	add	x1, x1, l_.str.13@PAGEOFF
	mov	x0, x25
	bl	_token_is
	cbz	w0, LBB5_31
; %bb.29:
	ldur	x8, [x29, #-88]
Lloh62:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh63:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh64:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB5_32
; %bb.30:
	mov	x0, x19
	mov	x1, x22
	mov	x2, x21
	mov	x4, x20
	add	sp, sp, #544
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	b	_add_tag_pair
LBB5_31:
	mov	x0, x19
	bl	_free_token
	mov	x0, x22
	bl	_free_token
	ldr	x0, [x25]
	add	x19, sp, #36
	add	x1, sp, #36
	bl	_write_loc
	add	x0, sp, #36
	bl	_strlen
	add	x0, x0, #125
	bl	_malloc
	mov	x20, x0
	ldr	x9, [x25, #8]
Lloh65:
	adrp	x8, l_.str.12@PAGE
Lloh66:
	add	x8, x8, l_.str.12@PAGEOFF
	stp	x8, x9, [sp, #8]
	str	x19, [sp]
Lloh67:
	adrp	x1, l_.str@PAGE
Lloh68:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x25
	b	LBB5_26
LBB5_32:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh39, Lloh40, Lloh41
	.loh AdrpLdrGotLdr	Lloh42, Lloh43, Lloh44
	.loh AdrpAdd	Lloh45, Lloh46
	.loh AdrpAdd	Lloh49, Lloh50
	.loh AdrpAdd	Lloh47, Lloh48
	.loh AdrpAdd	Lloh51, Lloh52
	.loh AdrpAdd	Lloh53, Lloh54
	.loh AdrpAdd	Lloh55, Lloh56
	.loh AdrpLdrGotLdr	Lloh57, Lloh58, Lloh59
	.loh AdrpAdd	Lloh60, Lloh61
	.loh AdrpLdrGotLdr	Lloh62, Lloh63, Lloh64
	.loh AdrpAdd	Lloh67, Lloh68
	.loh AdrpAdd	Lloh65, Lloh66
	.cfi_endproc
                                        ; -- End function
	.globl	_dict_free_toks                 ; -- Begin function dict_free_toks
	.p2align	2
_dict_free_toks:                        ; @dict_free_toks
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
	bl	_dict_values
	mov	x20, x0
	ldr	x8, [x19, #8]
	cbz	x8, LBB6_3
; %bb.1:
	mov	x21, #0
LBB6_2:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x0, [x20, x21, lsl  #3]
	bl	_free_token
	add	x21, x21, #1
	ldr	x8, [x19, #8]
	cmp	x21, x8
	b.lo	LBB6_2
LBB6_3:
	mov	x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_free
	.cfi_endproc
                                        ; -- End function
	.globl	_ensure_tags_exists             ; -- Begin function ensure_tags_exists
	.p2align	2
_ensure_tags_exists:                    ; @ensure_tags_exists
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-64]!           ; 16-byte Folded Spill
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
	.cfi_offset w27, -56
	.cfi_offset w28, -64
	sub	sp, sp, #784
	mov	x19, x1
Lloh69:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh70:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh71:
	ldr	x8, [x8]
	stur	x8, [x29, #-56]
	ldr	x21, [x0]
	cbz	x21, LBB7_4
; %bb.1:
	mov	x20, x2
	add	x22, x0, #8
LBB7_2:                                 ; =>This Inner Loop Header: Depth=1
	mov	x0, x19
	mov	x1, x21
	bl	_dict_remove
	cbnz	x0, LBB7_5
; %bb.3:                                ;   in Loop: Header=BB7_2 Depth=1
	ldr	x21, [x22], #8
	cbnz	x21, LBB7_2
LBB7_4:
	mov	x20, #0
	b	LBB7_6
LBB7_5:
Lloh72:
	adrp	x3, l_.str.16@PAGE
Lloh73:
	add	x3, x3, l_.str.16@PAGEOFF
	str	x21, [sp]
	add	x21, sp, #21
	add	x0, sp, #21
	mov	w1, #0
	mov	w2, #255
	bl	___sprintf_chk
	add	x22, sp, #276
	add	x1, sp, #276
	mov	x0, x20
	bl	_write_loc
	add	x0, sp, #276
	bl	_strlen
	mov	x20, x0
	add	x0, sp, #21
	bl	_strlen
	add	x8, x20, x0
	add	x0, x8, #100
	bl	_malloc
	mov	x20, x0
	stp	x22, x21, [sp]
Lloh74:
	adrp	x1, l_.str.1@PAGE
Lloh75:
	add	x1, x1, l_.str.1@PAGEOFF
	bl	_sprintf
LBB7_6:
	mov	x0, x19
	bl	_dict_free
	ldur	x8, [x29, #-56]
Lloh76:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh77:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh78:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB7_8
; %bb.7:
	mov	x0, x20
	add	sp, sp, #784
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #64             ; 16-byte Folded Reload
	ret
LBB7_8:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh69, Lloh70, Lloh71
	.loh AdrpAdd	Lloh74, Lloh75
	.loh AdrpAdd	Lloh72, Lloh73
	.loh AdrpLdrGotLdr	Lloh76, Lloh77, Lloh78
	.cfi_endproc
                                        ; -- End function
	.globl	_transform_tags                 ; -- Begin function transform_tags
	.p2align	2
_transform_tags:                        ; @transform_tags
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
	sub	sp, sp, #928
	mov	x24, x4
	mov	x21, x3
	mov	x19, x2
	mov	x20, x1
	mov	x22, x0
	add	x26, sp, #416
Lloh79:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh80:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh81:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
Lloh82:
	adrp	x1, l_.str.9@PAGE
Lloh83:
	add	x1, x1, l_.str.9@PAGEOFF
	bl	_dict_remove
	cbz	x0, LBB8_6
; %bb.1:
	mov	x23, x0
	ldr	x8, [x0, #8]
	add	x1, x8, #1
	add	x25, sp, #161
	add	x0, sp, #161
	mov	w2, #255
	bl	___strcpy_chk
	add	x0, sp, #161
	bl	_strlen
	add	x8, x25, x0
	sturb	wzr, [x8, #-1]
	ldr	x1, [x21, #16]
	add	x0, sp, #161
	add	x2, sp, #33
	bl	_parse_fen
	cbz	x0, LBB8_9
; %bb.2:
	mov	x25, x0
	mov	x0, x22
	bl	_dict_values
	mov	x19, x0
	ldr	x8, [x22, #8]
	cbz	x8, LBB8_5
; %bb.3:
	mov	x20, #0
LBB8_4:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x0, [x19, x20, lsl  #3]
	bl	_free_token
	add	x20, x20, #1
	ldr	x8, [x22, #8]
	cmp	x20, x8
	b.lo	LBB8_4
LBB8_5:
	mov	x0, x19
	bl	_free
	ldr	x0, [x23]
	add	x20, sp, #416
	add	x1, sp, #416
	bl	_write_loc
	add	x0, sp, #416
	bl	_strlen
	mov	x19, x0
	mov	x0, x25
	bl	_strlen
	add	x8, x19, x0
	add	x0, x8, #100
	bl	_malloc
	mov	x19, x0
	ldr	x8, [x23, #8]
	stp	x25, x8, [sp, #8]
	str	x20, [sp]
Lloh84:
	adrp	x1, l_.str@PAGE
Lloh85:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x23
	bl	_free_token
	b	LBB8_18
LBB8_6:
Lloh86:
	adrp	x8, l_.str.17@PAGE
Lloh87:
	add	x8, x8, l_.str.17@PAGEOFF
	ldp	q0, q1, [x8]
	stp	q0, q1, [x26]
	ldr	q0, [x8, #32]
	str	q0, [x26, #32]
	ldur	q0, [x8, #41]
	stur	q0, [x26, #41]
	ldr	x1, [x21, #16]
	add	x0, sp, #416
	add	x2, sp, #161
	bl	_parse_fen
Lloh88:
	adrp	x1, l_.str.8@PAGE
Lloh89:
	add	x1, x1, l_.str.8@PAGEOFF
	mov	x0, x22
	bl	_dict_remove
	cbz	x0, LBB8_10
LBB8_7:
	mov	x23, x0
	ldr	x1, [x0, #8]
	mov	x0, x24
	bl	_dict_lookup
	cbz	x0, LBB8_12
; %bb.8:
	ldrb	w8, [x0]
	b	LBB8_13
LBB8_9:
	mov	x0, x23
	bl	_free_token
Lloh90:
	adrp	x1, l_.str.8@PAGE
Lloh91:
	add	x1, x1, l_.str.8@PAGEOFF
	mov	x0, x22
	bl	_dict_remove
	cbnz	x0, LBB8_7
LBB8_10:
	ldr	x8, [x21]
	mov	w9, #3
	strb	w9, [x8, #48]
Lloh92:
	adrp	x1, l_.str.4@PAGE
Lloh93:
	add	x1, x1, l_.str.4@PAGEOFF
	mov	x0, x22
	bl	_dict_remove
	cbnz	x0, LBB8_14
LBB8_11:
	ldr	x8, [x21]
	strb	wzr, [x8, #16]
	strb	wzr, [x8, #20]
	strb	wzr, [x8, #22]
	b	LBB8_17
LBB8_12:
	mov	w8, #3
LBB8_13:
	ldr	x9, [x21]
	strb	w8, [x9, #48]
	mov	x0, x23
	bl	_free_token
Lloh94:
	adrp	x1, l_.str.4@PAGE
Lloh95:
	add	x1, x1, l_.str.4@PAGEOFF
	mov	x0, x22
	bl	_dict_remove
	cbz	x0, LBB8_11
LBB8_14:
	mov	x22, x0
	ldr	x8, [x0, #8]
	add	x1, x8, #1
	add	x23, sp, #416
	add	x0, sp, #416
	mov	w2, #255
	bl	___strcpy_chk
	add	x0, sp, #416
	bl	_strlen
	add	x8, x23, x0
	sturb	wzr, [x8, #-1]
	ldr	x21, [x21]
	add	x0, x21, #16
	add	x1, sp, #416
	mov	w2, #46
	bl	_parse_date
	cbz	x0, LBB8_16
; %bb.15:
	strb	wzr, [x21, #16]
	strb	wzr, [x21, #20]
	strb	wzr, [x21, #22]
LBB8_16:
	mov	x0, x22
	bl	_free_token
LBB8_17:
Lloh96:
	adrp	x8, l___const.transform_tags.tags@PAGE
Lloh97:
	add	x8, x8, l___const.transform_tags.tags@PAGEOFF
	ldp	q0, q1, [x8]
	stp	q0, q1, [x26]
	ldr	q0, [x8, #32]
	str	q0, [x26, #32]
	add	x0, sp, #416
	mov	x1, x20
	mov	x2, x19
	bl	_ensure_tags_exists
	mov	x19, x0
LBB8_18:
	ldur	x8, [x29, #-88]
Lloh98:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh99:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh100:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB8_20
; %bb.19:
	mov	x0, x19
	add	sp, sp, #928
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB8_20:
	bl	___stack_chk_fail
	.loh AdrpAdd	Lloh82, Lloh83
	.loh AdrpLdrGotLdr	Lloh79, Lloh80, Lloh81
	.loh AdrpAdd	Lloh84, Lloh85
	.loh AdrpAdd	Lloh88, Lloh89
	.loh AdrpAdd	Lloh86, Lloh87
	.loh AdrpAdd	Lloh90, Lloh91
	.loh AdrpAdd	Lloh92, Lloh93
	.loh AdrpAdd	Lloh94, Lloh95
	.loh AdrpAdd	Lloh96, Lloh97
	.loh AdrpLdrGotLdr	Lloh98, Lloh99, Lloh100
	.cfi_endproc
                                        ; -- End function
	.globl	_read_tagss                     ; -- Begin function read_tagss
	.p2align	2
_read_tagss:                            ; @read_tagss
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
	sub	sp, sp, #544
	mov	x21, x4
	mov	x23, x3
	mov	x24, x2
	mov	x22, x1
	mov	x25, x0
Lloh101:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh102:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh103:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	mov	w0, #20
	bl	_new_dict
	mov	x19, x0
Lloh104:
	adrp	x26, l_.str.18@PAGE
Lloh105:
	add	x26, x26, l_.str.18@PAGEOFF
LBB9_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB9_5 Depth 2
	mov	x0, x25
	mov	x1, x24
	bl	_ftoken
	cbz	x0, LBB9_15
; %bb.2:                                ;   in Loop: Header=BB9_1 Depth=1
	mov	x20, x0
	ldr	x8, [x0, #8]
	ldrb	w8, [x8]
	cmp	w8, #59
	b.ne	LBB9_7
; %bb.3:                                ;   in Loop: Header=BB9_1 Depth=1
	ldr	x8, [x20]
	ldr	x27, [x8, #8]
	mov	x0, x20
	bl	_free_token
	mov	x0, x25
	mov	x1, x24
	bl	_ftoken
	cbz	x0, LBB9_15
; %bb.4:                                ;   in Loop: Header=BB9_1 Depth=1
	mov	x20, x0
LBB9_5:                                 ;   Parent Loop BB9_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [x20]
	ldr	x8, [x8, #8]
	cmp	x8, x27
	b.hi	LBB9_7
; %bb.6:                                ;   in Loop: Header=BB9_5 Depth=2
	mov	x0, x20
	bl	_free_token
	mov	x0, x25
	mov	x1, x24
	bl	_ftoken
	mov	x20, x0
	cbnz	x0, LBB9_5
	b	LBB9_15
LBB9_7:                                 ;   in Loop: Header=BB9_1 Depth=1
	mov	x0, x20
	mov	x1, x26
	bl	_token_is
	cbz	w0, LBB9_13
; %bb.8:                                ;   in Loop: Header=BB9_1 Depth=1
	mov	x0, x25
	mov	x1, x24
	mov	x2, x22
	mov	x3, x20
	mov	x4, x19
	bl	_read_tag_pair
	cbz	x0, LBB9_1
; %bb.9:
	mov	x27, x0
	mov	x0, x22
	bl	_dict_free
	mov	x0, x19
	bl	_dict_values
	mov	x20, x0
	ldr	x8, [x19, #8]
	cbz	x8, LBB9_12
; %bb.10:
	mov	x21, #0
LBB9_11:                                ; =>This Inner Loop Header: Depth=1
	ldr	x0, [x20, x21, lsl  #3]
	bl	_free_token
	add	x21, x21, #1
	ldr	x8, [x19, #8]
	cmp	x21, x8
	b.lo	LBB9_11
LBB9_12:
	mov	x0, x20
	bl	_free
	ldur	x8, [x29, #-88]
Lloh106:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh107:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh108:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB9_21
	b	LBB9_22
LBB9_13:
Lloh109:
	adrp	x1, l_.str.19@PAGE
Lloh110:
	add	x1, x1, l_.str.19@PAGEOFF
	mov	x0, x20
	bl	_token_is
	cbz	w0, LBB9_17
; %bb.14:
	mov	x0, x20
	mov	x1, x24
	bl	_untoken
LBB9_15:
	ldur	x8, [x29, #-88]
Lloh111:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh112:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh113:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB9_22
; %bb.16:
	mov	x0, x19
	mov	x1, x22
	mov	x2, x24
	mov	x3, x23
	mov	x4, x21
	add	sp, sp, #544
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	b	_transform_tags
LBB9_17:
	mov	x0, x22
	bl	_dict_free
	mov	x0, x19
	bl	_dict_values
	mov	x21, x0
	ldr	x8, [x19, #8]
	cbz	x8, LBB9_20
; %bb.18:
	mov	x22, #0
LBB9_19:                                ; =>This Inner Loop Header: Depth=1
	ldr	x0, [x21, x22, lsl  #3]
	bl	_free_token
	add	x22, x22, #1
	ldr	x8, [x19, #8]
	cmp	x22, x8
	b.lo	LBB9_19
LBB9_20:
	mov	x0, x21
	bl	_free
	ldr	x0, [x20]
	add	x19, sp, #36
	add	x1, sp, #36
	bl	_write_loc
	add	x0, sp, #36
	bl	_strlen
	add	x0, x0, #156
	bl	_malloc
	mov	x27, x0
	ldr	x9, [x20, #8]
Lloh114:
	adrp	x8, l_.str.20@PAGE
Lloh115:
	add	x8, x8, l_.str.20@PAGEOFF
	stp	x8, x9, [sp, #8]
	str	x19, [sp]
Lloh116:
	adrp	x1, l_.str@PAGE
Lloh117:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x20
	bl	_free_token
	ldur	x8, [x29, #-88]
Lloh118:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh119:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh120:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB9_22
LBB9_21:
	mov	x0, x27
	add	sp, sp, #544
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB9_22:
	bl	___stack_chk_fail
	.loh AdrpAdd	Lloh104, Lloh105
	.loh AdrpLdrGotLdr	Lloh101, Lloh102, Lloh103
	.loh AdrpLdrGotLdr	Lloh106, Lloh107, Lloh108
	.loh AdrpAdd	Lloh109, Lloh110
	.loh AdrpLdrGotLdr	Lloh111, Lloh112, Lloh113
	.loh AdrpLdrGotLdr	Lloh118, Lloh119, Lloh120
	.loh AdrpAdd	Lloh116, Lloh117
	.loh AdrpAdd	Lloh114, Lloh115
	.cfi_endproc
                                        ; -- End function
	.globl	_read_turn_number               ; -- Begin function read_turn_number
	.p2align	2
_read_turn_number:                      ; @read_turn_number
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
	sub	sp, sp, #848
	mov	x19, x3
                                        ; kill: def $w2 killed $w2 def $x2
	mov	x21, x1
	mov	x20, x0
Lloh121:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh122:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh123:
	ldr	x8, [x8]
	stur	x8, [x29, #-56]
	str	x2, [sp]
Lloh124:
	adrp	x3, l_.str.21@PAGE
Lloh125:
	add	x3, x3, l_.str.21@PAGEOFF
	add	x0, sp, #330
	mov	w1, #0
	mov	w2, #10
	bl	___sprintf_chk
	cbz	x21, LBB10_11
; %bb.1:
	add	x1, sp, #330
	mov	x0, x21
	bl	_token_is
	cbz	w0, LBB10_9
; %bb.2:
Lloh126:
	adrp	x21, l_.str.23@PAGE
Lloh127:
	add	x21, x21, l_.str.23@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
	mov	x22, x0
	cbz	x0, LBB10_7
LBB10_3:
	ldr	x8, [x22, #8]
	ldrb	w8, [x8]
	cmp	w8, #59
	b.ne	LBB10_7
; %bb.4:
	ldr	x8, [x22]
	ldr	x23, [x8, #8]
LBB10_5:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x22
	bl	_free_token
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
	mov	x22, x0
	cbz	x0, LBB10_7
; %bb.6:                                ;   in Loop: Header=BB10_5 Depth=1
	ldr	x8, [x22]
	ldr	x8, [x8, #8]
	cmp	x8, x23
	b.ls	LBB10_5
LBB10_7:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x22
	mov	x1, x21
	bl	_token_is
	tbz	w0, #0, LBB10_12
; %bb.8:                                ;   in Loop: Header=BB10_7 Depth=1
	mov	x0, x22
	bl	_free_token
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
	mov	x22, x0
	cbnz	x0, LBB10_3
	b	LBB10_7
LBB10_9:
	ldr	x0, [x21, #8]
	bl	_atoi
	cbz	w0, LBB10_11
; %bb.10:
	add	x8, sp, #330
Lloh128:
	adrp	x3, l_.str.22@PAGE
Lloh129:
	add	x3, x3, l_.str.22@PAGEOFF
	str	x8, [sp]
	add	x20, sp, #30
	add	x0, sp, #30
	mov	w1, #0
	mov	w2, #300
	bl	___sprintf_chk
	ldr	x0, [x21]
	add	x22, sp, #340
	add	x1, sp, #340
	bl	_write_loc
	add	x0, sp, #340
	bl	_strlen
	mov	x19, x0
	add	x0, sp, #30
	bl	_strlen
	add	x8, x19, x0
	add	x0, x8, #100
	bl	_malloc
	mov	x19, x0
	ldr	x8, [x21, #8]
	stp	x20, x8, [sp, #8]
	str	x22, [sp]
Lloh130:
	adrp	x1, l_.str@PAGE
Lloh131:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x21
	bl	_free_token
	b	LBB10_13
LBB10_11:
	mov	x19, #0
	mov	x1, #0
	b	LBB10_14
LBB10_12:
	mov	x0, x22
	mov	x1, x19
	bl	_untoken
	mov	x19, #0
LBB10_13:
	mov	w1, #1
LBB10_14:
	ldur	x8, [x29, #-56]
Lloh132:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh133:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh134:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB10_16
; %bb.15:
	mov	x0, x19
	add	sp, sp, #848
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB10_16:
	bl	___stack_chk_fail
	.loh AdrpAdd	Lloh124, Lloh125
	.loh AdrpLdrGotLdr	Lloh121, Lloh122, Lloh123
	.loh AdrpAdd	Lloh126, Lloh127
	.loh AdrpAdd	Lloh130, Lloh131
	.loh AdrpAdd	Lloh128, Lloh129
	.loh AdrpLdrGotLdr	Lloh132, Lloh133, Lloh134
	.cfi_endproc
                                        ; -- End function
	.globl	_read_move_tok                  ; -- Begin function read_move_tok
	.p2align	2
_read_move_tok:                         ; @read_move_tok
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
	sub	sp, sp, #944
	mov	x21, x2
Lloh135:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh136:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh137:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	cbz	x0, LBB11_7
; %bb.1:
	mov	x19, x0
	mov	x20, #0
	ldr	x0, [x0, #8]
	ldrsb	w8, [x0]
	cmp	w8, #36
	b.eq	LBB11_11
; %bb.2:
	cmp	w8, #40
	b.eq	LBB11_11
; %bb.3:
	mov	x26, x1
	mov	x1, x20
	cmp	w8, #123
	b.eq	LBB11_9
; %bb.4:
	mov	x23, x7
	mov	x22, x6
	mov	x27, x5
	mov	x25, x4
	mov	x24, x3
	add	x1, sp, #35
	bl	_parse_san
	ldrb	w8, [sp, #35]
	cbz	w8, LBB11_13
; %bb.5:
	ldr	x1, [x19, #8]
	mov	x0, x27
	bl	_dict_lookup
	cbz	x0, LBB11_17
; %bb.6:
	mov	x20, #0
	mov	w1, #1
	ldur	x8, [x29, #-88]
Lloh138:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh139:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh140:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB11_10
	b	LBB11_12
LBB11_7:
	add	x19, sp, #436
	add	x1, sp, #436
	mov	x0, x21
	bl	_write_loc
	add	x0, sp, #436
	bl	_strlen
	add	x0, x0, #139
	bl	_malloc
	mov	x20, x0
Lloh141:
	adrp	x8, l_.str.24@PAGE
Lloh142:
	add	x8, x8, l_.str.24@PAGEOFF
	stp	x19, x8, [sp]
Lloh143:
	adrp	x1, l_.str.1@PAGE
Lloh144:
	add	x1, x1, l_.str.1@PAGEOFF
	bl	_sprintf
LBB11_8:
	mov	x1, #0
LBB11_9:
	ldur	x8, [x29, #-88]
Lloh145:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh146:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh147:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB11_12
LBB11_10:
	mov	x0, x20
	add	sp, sp, #944
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB11_11:
	mov	x1, x20
	ldur	x8, [x29, #-88]
Lloh148:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh149:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh150:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB11_10
LBB11_12:
	bl	___stack_chk_fail
LBB11_13:
	mov	x4, x0
	ldr	x20, [x29, #16]
	ldrb	w9, [x25]
	eor	w8, w9, #0x1
	cbnz	w9, LBB11_15
; %bb.14:
	ldr	w9, [x24]
	add	w9, w9, #1
	str	w9, [x24]
LBB11_15:
	strb	w8, [x25]
	and	x2, x1, #0xffff
	add	x25, sp, #336
	add	x3, sp, #336
	mov	x0, x20
	mov	x1, x4
	bl	_san_to_move
	lsr	w26, w0, #24
	cmp	w26, #1
	b.ne	LBB11_19
; %bb.16:
	add	x21, sp, #36
	add	x1, sp, #36
	mov	x0, x20
	bl	_make_fen
	mov	x0, x20
	bl	_print_board
Lloh151:
	adrp	x3, l_.str.26@PAGE
Lloh152:
	add	x3, x3, l_.str.26@PAGEOFF
	stp	x21, x25, [sp]
	add	x21, sp, #136
	add	x0, sp, #136
	mov	w1, #0
	mov	w2, #200
	bl	___sprintf_chk
	ldr	x0, [x19]
	add	x22, sp, #436
	add	x1, sp, #436
	bl	_write_loc
	add	x0, sp, #436
	bl	_strlen
	mov	x20, x0
	add	x0, sp, #136
	bl	_strlen
	add	x8, x20, x0
	add	x0, x8, #100
	bl	_malloc
	mov	x20, x0
	ldr	x8, [x19, #8]
	stp	x21, x8, [sp, #8]
	str	x22, [sp]
Lloh153:
	adrp	x1, l_.str@PAGE
Lloh154:
	add	x1, x1, l_.str@PAGEOFF
	bl	_sprintf
	mov	x0, x19
	bl	_free_token
	b	LBB11_8
LBB11_17:
	ldr	w2, [x24]
	mov	x0, x26
	mov	x1, x19
	mov	x3, x21
	bl	_read_turn_number
	cbz	x0, LBB11_22
; %bb.18:
	mov	x20, x0
	b	LBB11_8
LBB11_19:
	mov	x24, x0
	mov	w1, w0
	mov	x0, x20
	bl	_apply_move
	ldrh	w8, [x23]
	cmp	x8, #600
	b.ne	LBB11_21
; %bb.20:
Lloh155:
	adrp	x1, l_.str.27@PAGE
Lloh156:
	add	x1, x1, l_.str.27@PAGEOFF
	mov	x0, x21
	mov	x2, x19
	bl	_alloc_err
	mov	x20, x0
	b	LBB11_8
LBB11_21:
	mov	x20, #0
	add	w9, w8, #1
	strh	w9, [x23]
	add	x8, x22, x8, lsl #2
	lsr	w9, w24, #16
	strb	w9, [x8, #2]
	strh	w24, [x8]
	strb	w26, [x8, #3]
	b	LBB11_8
LBB11_22:
	tbnz	w1, #0, LBB11_24
; %bb.23:
Lloh157:
	adrp	x1, l_.str.25@PAGE
Lloh158:
	add	x1, x1, l_.str.25@PAGEOFF
	mov	x0, x21
	mov	x2, x19
	bl	_alloc_err
	mov	x20, x0
	b	LBB11_8
LBB11_24:
	mov	x20, #0
	b	LBB11_8
	.loh AdrpLdrGotLdr	Lloh135, Lloh136, Lloh137
	.loh AdrpLdrGotLdr	Lloh138, Lloh139, Lloh140
	.loh AdrpAdd	Lloh143, Lloh144
	.loh AdrpAdd	Lloh141, Lloh142
	.loh AdrpLdrGotLdr	Lloh145, Lloh146, Lloh147
	.loh AdrpLdrGotLdr	Lloh148, Lloh149, Lloh150
	.loh AdrpAdd	Lloh153, Lloh154
	.loh AdrpAdd	Lloh151, Lloh152
	.loh AdrpAdd	Lloh155, Lloh156
	.loh AdrpAdd	Lloh157, Lloh158
	.cfi_endproc
                                        ; -- End function
	.globl	_read_moves                     ; -- Begin function read_moves
	.p2align	2
_read_moves:                            ; @read_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #176
	.cfi_def_cfa_offset 176
	stp	x26, x25, [sp, #96]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #112]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #128]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #144]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #160]            ; 16-byte Folded Spill
	add	x29, sp, #160
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
	mov	x19, x5
	mov	x21, x4
	mov	x20, x3
	mov	x22, x2
	mov	x23, x0
	sturh	wzr, [x29, #-66]
	mov	w8, #1
	sturb	w8, [x29, #-67]
	stur	w8, [x29, #-72]
	add	x8, sp, #24
	str	x8, [sp, #8]
	add	x26, sp, #8
	add	x0, sp, #8
	bl	_copy_into
LBB12_1:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB12_4 Depth 2
	mov	x0, x23
	mov	x1, x21
	bl	_ftoken
	mov	x24, x0
	cbz	x0, LBB12_6
; %bb.2:                                ;   in Loop: Header=BB12_1 Depth=1
	ldr	x8, [x24, #8]
	ldrb	w8, [x8]
	cmp	w8, #59
	b.ne	LBB12_6
; %bb.3:                                ;   in Loop: Header=BB12_1 Depth=1
	ldr	x8, [x24]
	ldr	x25, [x8, #8]
LBB12_4:                                ;   Parent Loop BB12_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x0, x24
	bl	_free_token
	mov	x0, x23
	mov	x1, x21
	bl	_ftoken
	mov	x24, x0
	cbz	x0, LBB12_6
; %bb.5:                                ;   in Loop: Header=BB12_4 Depth=2
	ldr	x8, [x24]
	ldr	x8, [x8, #8]
	cmp	x8, x25
	b.ls	LBB12_4
LBB12_6:                                ;   in Loop: Header=BB12_1 Depth=1
	str	x26, [sp]
	sub	x3, x29, #72
	sub	x4, x29, #67
	sub	x7, x29, #66
	mov	x0, x24
	mov	x1, x23
	mov	x2, x21
	mov	x5, x19
	mov	x6, x22
	bl	_read_move_tok
	cbnz	x0, LBB12_9
; %bb.7:                                ;   in Loop: Header=BB12_1 Depth=1
	mov	x25, x1
	mov	x0, x24
	bl	_free_token
	tbz	w25, #0, LBB12_1
; %bb.8:
	ldurh	w8, [x29, #-66]
	strh	w8, [x20]
	mov	x0, x19
	bl	_dict_free
	mov	x0, #0
LBB12_9:
	ldp	x29, x30, [sp, #160]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #144]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #128]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #112]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #96]             ; 16-byte Folded Reload
	add	sp, sp, #176
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_read_pgn_inner                 ; -- Begin function read_pgn_inner
	.p2align	2
_read_pgn_inner:                        ; @read_pgn_inner
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
	sub	sp, sp, #784
	mov	x21, x2
	mov	x19, x1
	mov	x20, x0
Lloh159:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh160:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh161:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	ldr	x23, [x2]
	mov	w0, #20
	bl	_new_dict
	mov	x22, x0
	ldr	x2, [x23]
Lloh162:
	adrp	x1, l_.str.2@PAGE
Lloh163:
	add	x1, x1, l_.str.2@PAGEOFF
	bl	_dict_add
	ldr	x2, [x23, #8]
Lloh164:
	adrp	x1, l_.str.3@PAGE
Lloh165:
	add	x1, x1, l_.str.3@PAGEOFF
	mov	x0, x22
	bl	_dict_add
Lloh166:
	adrp	x1, l_.str.4@PAGE
Lloh167:
	add	x1, x1, l_.str.4@PAGEOFF
	add	x2, sp, #11
	mov	x0, x22
	bl	_dict_add
	ldr	x2, [x23, #24]
Lloh168:
	adrp	x1, l_.str.5@PAGE
Lloh169:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x22
	bl	_dict_add
	ldr	x2, [x23, #32]
Lloh170:
	adrp	x1, l_.str.6@PAGE
Lloh171:
	add	x1, x1, l_.str.6@PAGEOFF
	mov	x0, x22
	bl	_dict_add
	ldr	x2, [x23, #40]
Lloh172:
	adrp	x1, l_.str.7@PAGE
Lloh173:
	add	x1, x1, l_.str.7@PAGEOFF
	mov	x0, x22
	bl	_dict_add
Lloh174:
	adrp	x1, l_.str.8@PAGE
Lloh175:
	add	x1, x1, l_.str.8@PAGEOFF
	add	x2, sp, #266
	mov	x0, x22
	bl	_dict_add
Lloh176:
	adrp	x1, l_.str.9@PAGE
Lloh177:
	add	x1, x1, l_.str.9@PAGEOFF
	add	x2, sp, #521
	mov	x0, x22
	bl	_dict_add
	mov	w8, #256
	movk	w8, #770, lsl #16
	str	w8, [sp, #4]
	mov	w0, #20
	bl	_new_dict
	mov	x23, x0
Lloh178:
	adrp	x1, l_.str.28@PAGE
Lloh179:
	add	x1, x1, l_.str.28@PAGEOFF
	add	x26, sp, #4
	add	x2, sp, #4
	bl	_dict_add
	orr	x24, x26, #0x1
Lloh180:
	adrp	x1, l_.str.29@PAGE
Lloh181:
	add	x1, x1, l_.str.29@PAGEOFF
	mov	x0, x23
	mov	x2, x24
	bl	_dict_add
	orr	x25, x26, #0x2
Lloh182:
	adrp	x1, l_.str.30@PAGE
Lloh183:
	add	x1, x1, l_.str.30@PAGEOFF
	mov	x0, x23
	mov	x2, x25
	bl	_dict_add
	orr	x26, x26, #0x3
Lloh184:
	adrp	x1, l_.str.31@PAGE
Lloh185:
	add	x1, x1, l_.str.31@PAGEOFF
	mov	x0, x23
	mov	x2, x26
	bl	_dict_add
Lloh186:
	adrp	x1, l_.str.32@PAGE
Lloh187:
	add	x1, x1, l_.str.32@PAGEOFF
	add	x2, sp, #4
	mov	x0, x23
	bl	_dict_add
Lloh188:
	adrp	x1, l_.str.33@PAGE
Lloh189:
	add	x1, x1, l_.str.33@PAGEOFF
	mov	x0, x23
	mov	x2, x24
	bl	_dict_add
Lloh190:
	adrp	x1, l_.str.34@PAGE
Lloh191:
	add	x1, x1, l_.str.34@PAGEOFF
	mov	x0, x23
	mov	x2, x25
	bl	_dict_add
Lloh192:
	adrp	x1, l_.str.35@PAGE
Lloh193:
	add	x1, x1, l_.str.35@PAGEOFF
	mov	x0, x23
	mov	x2, x26
	bl	_dict_add
	mov	x0, x20
	mov	x1, x22
	mov	x2, x19
	mov	x3, x21
	mov	x4, x23
	bl	_read_tagss
	cbnz	x0, LBB13_2
; %bb.1:
	ldp	x2, x1, [x21, #8]
	add	x3, x21, #24
	mov	x0, x20
	mov	x4, x19
	mov	x5, x23
	bl	_read_moves
LBB13_2:
	ldur	x8, [x29, #-88]
Lloh194:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh195:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh196:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB13_4
; %bb.3:
	add	sp, sp, #784
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB13_4:
	bl	___stack_chk_fail
	.loh AdrpAdd	Lloh192, Lloh193
	.loh AdrpAdd	Lloh190, Lloh191
	.loh AdrpAdd	Lloh188, Lloh189
	.loh AdrpAdd	Lloh186, Lloh187
	.loh AdrpAdd	Lloh184, Lloh185
	.loh AdrpAdd	Lloh182, Lloh183
	.loh AdrpAdd	Lloh180, Lloh181
	.loh AdrpAdd	Lloh178, Lloh179
	.loh AdrpAdd	Lloh176, Lloh177
	.loh AdrpAdd	Lloh174, Lloh175
	.loh AdrpAdd	Lloh172, Lloh173
	.loh AdrpAdd	Lloh170, Lloh171
	.loh AdrpAdd	Lloh168, Lloh169
	.loh AdrpAdd	Lloh166, Lloh167
	.loh AdrpAdd	Lloh164, Lloh165
	.loh AdrpAdd	Lloh162, Lloh163
	.loh AdrpLdrGotLdr	Lloh159, Lloh160, Lloh161
	.loh AdrpLdrGotLdr	Lloh194, Lloh195, Lloh196
	.cfi_endproc
                                        ; -- End function
	.globl	_skip_to_next                   ; -- Begin function skip_to_next
	.p2align	2
_skip_to_next:                          ; @skip_to_next
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
	mov	x19, x0
	ldp	x21, x20, [x0]
	ldr	x22, [x20, #8]
	mov	x0, x21
	mov	x1, x20
	bl	_ftoken
	cbz	x0, LBB14_7
LBB14_1:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB14_2 Depth 2
	ldp	x9, x8, [x0]
	ldrb	w8, [x8]
	ldr	x23, [x9, #8]
	cmp	w8, #59
	b.ne	LBB14_5
LBB14_2:                                ;   Parent Loop BB14_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	bl	_free_token
	mov	x0, x21
	mov	x1, x20
	bl	_ftoken
	cbz	x0, LBB14_7
; %bb.3:                                ;   in Loop: Header=BB14_2 Depth=2
	ldr	x8, [x0]
	ldr	x9, [x8, #8]
	cmp	x9, x23
	b.ls	LBB14_2
; %bb.4:                                ;   in Loop: Header=BB14_1 Depth=1
	ldr	x8, [x0, #8]
	ldrb	w8, [x8]
	mov	x23, x9
LBB14_5:                                ;   in Loop: Header=BB14_1 Depth=1
	add	x9, x22, #1
	cmp	w8, #91
	ccmp	x23, x9, #0, eq
	b.hi	LBB14_8
; %bb.6:                                ;   in Loop: Header=BB14_1 Depth=1
	bl	_free_token
	ldp	x21, x20, [x19]
	mov	x0, x21
	mov	x1, x20
	bl	_ftoken
	mov	x22, x23
	cbnz	x0, LBB14_1
LBB14_7:
	ldr	x1, [x19, #8]
	mov	x0, #0
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	b	_untoken
LBB14_8:
	ldr	x1, [x19, #8]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	b	_untoken
	.cfi_endproc
                                        ; -- End function
	.globl	_next_pgn                       ; -- Begin function next_pgn
	.p2align	2
_next_pgn:                              ; @next_pgn
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
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
	ldp	x22, x23, [x0]
	mov	x0, x22
	mov	x1, x23
	bl	_ftoken
	cbz	x0, LBB15_6
; %bb.1:
	ldr	x8, [x0, #8]
	ldrb	w8, [x8]
	cmp	w8, #59
	b.ne	LBB15_7
; %bb.2:
	ldr	x8, [x0]
	ldr	x24, [x8, #8]
	bl	_free_token
	mov	x0, x22
	mov	x1, x23
	bl	_ftoken
	cbz	x0, LBB15_6
LBB15_3:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x0]
	ldr	x8, [x8, #8]
	cmp	x8, x24
	b.hi	LBB15_7
; %bb.4:                                ;   in Loop: Header=BB15_3 Depth=1
	bl	_free_token
	mov	x0, x22
	mov	x1, x23
	bl	_ftoken
	cbnz	x0, LBB15_3
; %bb.5:
	mov	w0, #2
	b	LBB15_9
LBB15_6:
	mov	w0, #2
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB15_7:
	ldr	x1, [x19, #8]
	bl	_untoken
	ldp	x0, x1, [x19]
	mov	x2, x21
	bl	_read_pgn_inner
	cbz	x0, LBB15_9
; %bb.8:
	mov	x21, x0
	mov	x0, x20
	mov	x1, x21
	mov	w2, #300
	bl	_strncpy
	mov	x0, x21
	bl	_free
	mov	x0, x19
	bl	_skip_to_next
	mov	w0, #1
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB15_9:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_open_pgn                       ; -- Begin function open_pgn
	.p2align	2
_open_pgn:                              ; @open_pgn
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
	mov	w0, #16
	bl	_malloc
	mov	x20, x0
Lloh197:
	adrp	x1, l_.str.36@PAGE
Lloh198:
	add	x1, x1, l_.str.36@PAGEOFF
	mov	x0, x19
	bl	_fopen
	str	x0, [x20]
Lloh199:
	adrp	x1, l_.str.37@PAGE
Lloh200:
	add	x1, x1, l_.str.37@PAGEOFF
Lloh201:
	adrp	x2, l_.str.38@PAGE
Lloh202:
	add	x2, x2, l_.str.38@PAGEOFF
	mov	x0, x19
	mov	w3, #92
	bl	_start_context
	str	x0, [x20, #8]
	mov	x0, x20
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh201, Lloh202
	.loh AdrpAdd	Lloh199, Lloh200
	.loh AdrpAdd	Lloh197, Lloh198
	.cfi_endproc
                                        ; -- End function
	.globl	_close_pgn                      ; -- Begin function close_pgn
	.p2align	2
_close_pgn:                             ; @close_pgn
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
	ldr	x0, [x0]
	bl	_fclose
	ldr	x0, [x19, #8]
	bl	_end_context
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_free
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"<%s>: Error When Parsing PGN: %s, got %s"

l_.str.1:                               ; @.str.1
	.asciz	"<%s>: Error When Parsing PGN: %s"

l_.str.2:                               ; @.str.2
	.asciz	"Event"

l_.str.3:                               ; @.str.3
	.asciz	"Site"

l_.str.4:                               ; @.str.4
	.asciz	"Date"

l_.str.5:                               ; @.str.5
	.asciz	"Round"

l_.str.6:                               ; @.str.6
	.asciz	"White"

l_.str.7:                               ; @.str.7
	.asciz	"Black"

l_.str.8:                               ; @.str.8
	.asciz	"Result"

l_.str.9:                               ; @.str.9
	.asciz	"FEN"

l_.str.10:                              ; @.str.10
	.asciz	"Tag value is too long, must be at most 255 characters"

l_.str.11:                              ; @.str.11
	.asciz	"Missing value for tag pair"

l_.str.12:                              ; @.str.12
	.asciz	"Tag pair missing ending ]"

l_.str.13:                              ; @.str.13
	.asciz	"]"

l_.str.14:                              ; @.str.14
	.asciz	"Tag value must be a string"

l_.str.15:                              ; @.str.15
	.asciz	"No tag name given"

l_.str.16:                              ; @.str.16
	.asciz	"Missing tag pair for %s"

l_.str.17:                              ; @.str.17
	.asciz	"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @__const.transform_tags.tags
l___const.transform_tags.tags:
	.quad	l_.str.3
	.quad	l_.str.2
	.quad	l_.str.5
	.quad	l_.str.6
	.quad	l_.str.7
	.quad	0

	.section	__TEXT,__cstring,cstring_literals
l_.str.18:                              ; @.str.18
	.asciz	"["

l_.str.19:                              ; @.str.19
	.asciz	"1"

l_.str.20:                              ; @.str.20
	.asciz	"Expected a tag pair or the beginning of a Movetext block"

l_.str.21:                              ; @.str.21
	.asciz	"%d"

l_.str.22:                              ; @.str.22
	.asciz	"Expected the move number %s"

l_.str.23:                              ; @.str.23
	.asciz	"."

l_.str.24:                              ; @.str.24
	.asciz	"Unexpected end of file after last token"

l_.str.25:                              ; @.str.25
	.asciz	"Invalid move found"

l_.str.26:                              ; @.str.26
	.asciz	"Could not read move for the position %s, %s"

l_.str.27:                              ; @.str.27
	.asciz	"Too many moves in game, can only store 600"

l_.str.28:                              ; @.str.28
	.asciz	"1/2-1/2"

l_.str.29:                              ; @.str.29
	.asciz	"1-0"

l_.str.30:                              ; @.str.30
	.asciz	"0-1"

l_.str.31:                              ; @.str.31
	.asciz	"*"

l_.str.32:                              ; @.str.32
	.asciz	"\"1/2-1/2\""

l_.str.33:                              ; @.str.33
	.asciz	"\"1-0\""

l_.str.34:                              ; @.str.34
	.asciz	"\"0-1\""

l_.str.35:                              ; @.str.35
	.asciz	"\"*\""

l_.str.36:                              ; @.str.36
	.asciz	"r"

l_.str.37:                              ; @.str.37
	.asciz	";[].*()<>"

l_.str.38:                              ; @.str.38
	.asciz	"\"\"{}"

.subsections_via_symbols
