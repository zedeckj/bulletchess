	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_test_str                       ; -- Begin function test_str
	.p2align	2
_test_str:                              ; @test_str
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
	mov	x19, x1
	cbz	x0, LBB0_3
; %bb.1:
	mov	x21, x0
	ldr	x20, [x0, #8]
	mov	x0, x20
	mov	x1, x19
	bl	_strcmp
	cbnz	w0, LBB0_4
; %bb.2:
	mov	x0, x21
	bl	_free_token
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB0_3:
Lloh0:
	adrp	x8, ___stderrp@GOTPAGE
Lloh1:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh2:
	ldr	x0, [x8]
	str	x19, [sp]
Lloh3:
	adrp	x1, l_.str@PAGE
Lloh4:
	add	x1, x1, l_.str@PAGEOFF
	b	LBB0_5
LBB0_4:
Lloh5:
	adrp	x8, ___stderrp@GOTPAGE
Lloh6:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh7:
	ldr	x0, [x8]
	stp	x20, x19, [sp]
Lloh8:
	adrp	x1, l_.str.1@PAGE
Lloh9:
	add	x1, x1, l_.str.1@PAGEOFF
LBB0_5:
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh3, Lloh4
	.loh AdrpLdrGotLdr	Lloh0, Lloh1, Lloh2
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpLdrGotLdr	Lloh5, Lloh6, Lloh7
	.cfi_endproc
                                        ; -- End function
	.globl	_test_full                      ; -- Begin function test_full
	.p2align	2
_test_full:                             ; @test_full
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #192
	.cfi_def_cfa_offset 192
	stp	x22, x21, [sp, #144]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #160]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #176]            ; 16-byte Folded Spill
	add	x29, sp, #176
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x1
Lloh10:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh11:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh12:
	ldr	x8, [x8]
	stur	x8, [x29, #-40]
	cbz	x0, LBB1_6
; %bb.1:
	mov	x21, x2
	mov	x20, x0
	ldr	x0, [x0]
	add	x1, sp, #36
	bl	_write_loc
	cbz	w0, LBB1_7
; %bb.2:
	add	x22, sp, #36
	add	x0, sp, #36
	mov	x1, x21
	bl	_strcmp
	cbnz	w0, LBB1_8
; %bb.3:
	ldr	x21, [x20, #8]
	mov	x0, x21
	mov	x1, x19
	bl	_strcmp
	cbnz	w0, LBB1_9
; %bb.4:
	mov	x0, x20
	bl	_free_token
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
	ldur	x8, [x29, #-40]
Lloh13:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh14:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh15:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB1_11
; %bb.5:
	ldp	x29, x30, [sp, #176]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #160]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #144]            ; 16-byte Folded Reload
	add	sp, sp, #192
	ret
LBB1_6:
Lloh16:
	adrp	x8, ___stderrp@GOTPAGE
Lloh17:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh18:
	ldr	x0, [x8]
	str	x19, [sp]
Lloh19:
	adrp	x1, l_.str.2@PAGE
Lloh20:
	add	x1, x1, l_.str.2@PAGEOFF
	b	LBB1_10
LBB1_7:
Lloh21:
	adrp	x8, ___stderrp@GOTPAGE
Lloh22:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh23:
	ldr	x3, [x8]
Lloh24:
	adrp	x0, l_.str.3@PAGE
Lloh25:
	add	x0, x0, l_.str.3@PAGEOFF
	mov	w1, #35
	mov	w2, #1
	bl	_fwrite
	mov	w0, #1
	bl	_exit
LBB1_8:
	mov	x0, x20
	mov	x1, x19
	bl	_test_str
Lloh26:
	adrp	x8, ___stderrp@GOTPAGE
Lloh27:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh28:
	ldr	x0, [x8]
	ldr	x8, [x20, #8]
	stp	x22, x21, [sp, #8]
	str	x8, [sp]
Lloh29:
	adrp	x1, l_.str.4@PAGE
Lloh30:
	add	x1, x1, l_.str.4@PAGEOFF
	b	LBB1_10
LBB1_9:
Lloh31:
	adrp	x8, ___stderrp@GOTPAGE
Lloh32:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh33:
	ldr	x0, [x8]
	stp	x21, x19, [sp]
Lloh34:
	adrp	x1, l_.str.1@PAGE
Lloh35:
	add	x1, x1, l_.str.1@PAGEOFF
LBB1_10:
	bl	_fprintf
	mov	w0, #1
	bl	_exit
LBB1_11:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh10, Lloh11, Lloh12
	.loh AdrpLdrGotLdr	Lloh13, Lloh14, Lloh15
	.loh AdrpAdd	Lloh19, Lloh20
	.loh AdrpLdrGotLdr	Lloh16, Lloh17, Lloh18
	.loh AdrpAdd	Lloh24, Lloh25
	.loh AdrpLdrGotLdr	Lloh21, Lloh22, Lloh23
	.loh AdrpAdd	Lloh29, Lloh30
	.loh AdrpLdrGotLdr	Lloh26, Lloh27, Lloh28
	.loh AdrpAdd	Lloh34, Lloh35
	.loh AdrpLdrGotLdr	Lloh31, Lloh32, Lloh33
	.cfi_endproc
                                        ; -- End function
	.globl	_test_null                      ; -- Begin function test_null
	.p2align	2
_test_null:                             ; @test_null
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	cbnz	x0, LBB2_2
; %bb.1:
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
LBB2_2:
Lloh36:
	adrp	x8, ___stderrp@GOTPAGE
Lloh37:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh38:
	ldr	x8, [x8]
	ldr	x9, [x0, #8]
	str	x9, [sp]
Lloh39:
	adrp	x1, l_.str.5@PAGE
Lloh40:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh39, Lloh40
	.loh AdrpLdrGotLdr	Lloh36, Lloh37, Lloh38
	.cfi_endproc
                                        ; -- End function
	.globl	_test_basic                     ; -- Begin function test_basic
	.p2align	2
_test_basic:                            ; @test_basic
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
Lloh41:
	adrp	x0, l_.str.7@PAGE
Lloh42:
	add	x0, x0, l_.str.7@PAGEOFF
Lloh43:
	adrp	x1, l_.str.8@PAGE
Lloh44:
	add	x1, x1, l_.str.8@PAGEOFF
	bl	_start_op_ctx
	mov	x19, x0
Lloh45:
	adrp	x20, l_.str.6@PAGE
Lloh46:
	add	x20, x20, l_.str.6@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh47:
	adrp	x1, l_.str.9@PAGE
Lloh48:
	add	x1, x1, l_.str.9@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh49:
	adrp	x21, l_.str.10@PAGE
Lloh50:
	add	x21, x21, l_.str.10@PAGEOFF
	mov	x1, x21
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh51:
	adrp	x1, l_.str.11@PAGE
Lloh52:
	add	x1, x1, l_.str.11@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh53:
	adrp	x1, l_.str.12@PAGE
Lloh54:
	add	x1, x1, l_.str.12@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh55:
	adrp	x1, l_.str.13@PAGE
Lloh56:
	add	x1, x1, l_.str.13@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
	mov	x1, x21
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh57:
	adrp	x1, l_.str.14@PAGE
Lloh58:
	add	x1, x1, l_.str.14@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
	cbnz	x0, LBB3_2
; %bb.1:
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	b	_end_context
LBB3_2:
Lloh59:
	adrp	x8, ___stderrp@GOTPAGE
Lloh60:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh61:
	ldr	x8, [x8]
	ldr	x9, [x0, #8]
	str	x9, [sp]
Lloh62:
	adrp	x1, l_.str.5@PAGE
Lloh63:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh57, Lloh58
	.loh AdrpAdd	Lloh55, Lloh56
	.loh AdrpAdd	Lloh53, Lloh54
	.loh AdrpAdd	Lloh51, Lloh52
	.loh AdrpAdd	Lloh49, Lloh50
	.loh AdrpAdd	Lloh47, Lloh48
	.loh AdrpAdd	Lloh45, Lloh46
	.loh AdrpAdd	Lloh43, Lloh44
	.loh AdrpAdd	Lloh41, Lloh42
	.loh AdrpAdd	Lloh62, Lloh63
	.loh AdrpLdrGotLdr	Lloh59, Lloh60, Lloh61
	.cfi_endproc
                                        ; -- End function
	.globl	_test1                          ; -- Begin function test1
	.p2align	2
_test1:                                 ; @test1
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
Lloh64:
	adrp	x0, l_.str.16@PAGE
Lloh65:
	add	x0, x0, l_.str.16@PAGEOFF
Lloh66:
	adrp	x1, l_.str.17@PAGE
Lloh67:
	add	x1, x1, l_.str.17@PAGEOFF
	bl	_start_op_ctx
	mov	x19, x0
Lloh68:
	adrp	x20, l_.str.15@PAGE
Lloh69:
	add	x20, x20, l_.str.15@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh70:
	adrp	x21, l_.str.18@PAGE
Lloh71:
	add	x21, x21, l_.str.18@PAGEOFF
Lloh72:
	adrp	x2, l_.str.19@PAGE
Lloh73:
	add	x2, x2, l_.str.19@PAGEOFF
	mov	x1, x21
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh74:
	adrp	x1, l_.str.12@PAGE
Lloh75:
	add	x1, x1, l_.str.12@PAGEOFF
Lloh76:
	adrp	x2, l_.str.20@PAGE
Lloh77:
	add	x2, x2, l_.str.20@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh78:
	adrp	x2, l_.str.21@PAGE
Lloh79:
	add	x2, x2, l_.str.21@PAGEOFF
	mov	x1, x21
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh80:
	adrp	x1, l_.str.10@PAGE
Lloh81:
	add	x1, x1, l_.str.10@PAGEOFF
Lloh82:
	adrp	x2, l_.str.22@PAGE
Lloh83:
	add	x2, x2, l_.str.22@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh84:
	adrp	x1, l_.str.11@PAGE
Lloh85:
	add	x1, x1, l_.str.11@PAGEOFF
Lloh86:
	adrp	x2, l_.str.23@PAGE
Lloh87:
	add	x2, x2, l_.str.23@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh88:
	adrp	x1, l_.str.24@PAGE
Lloh89:
	add	x1, x1, l_.str.24@PAGEOFF
Lloh90:
	adrp	x2, l_.str.25@PAGE
Lloh91:
	add	x2, x2, l_.str.25@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh92:
	adrp	x21, l_.str.26@PAGE
Lloh93:
	add	x21, x21, l_.str.26@PAGEOFF
Lloh94:
	adrp	x2, l_.str.27@PAGE
Lloh95:
	add	x2, x2, l_.str.27@PAGEOFF
	mov	x1, x21
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh96:
	adrp	x1, l_.str.28@PAGE
Lloh97:
	add	x1, x1, l_.str.28@PAGEOFF
Lloh98:
	adrp	x2, l_.str.29@PAGE
Lloh99:
	add	x2, x2, l_.str.29@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh100:
	adrp	x2, l_.str.30@PAGE
Lloh101:
	add	x2, x2, l_.str.30@PAGEOFF
	mov	x1, x21
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
	cbnz	x0, LBB4_2
; %bb.1:
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	b	_end_context
LBB4_2:
Lloh102:
	adrp	x8, ___stderrp@GOTPAGE
Lloh103:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh104:
	ldr	x8, [x8]
	ldr	x9, [x0, #8]
	str	x9, [sp]
Lloh105:
	adrp	x1, l_.str.5@PAGE
Lloh106:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh100, Lloh101
	.loh AdrpAdd	Lloh98, Lloh99
	.loh AdrpAdd	Lloh96, Lloh97
	.loh AdrpAdd	Lloh94, Lloh95
	.loh AdrpAdd	Lloh92, Lloh93
	.loh AdrpAdd	Lloh90, Lloh91
	.loh AdrpAdd	Lloh88, Lloh89
	.loh AdrpAdd	Lloh86, Lloh87
	.loh AdrpAdd	Lloh84, Lloh85
	.loh AdrpAdd	Lloh82, Lloh83
	.loh AdrpAdd	Lloh80, Lloh81
	.loh AdrpAdd	Lloh78, Lloh79
	.loh AdrpAdd	Lloh76, Lloh77
	.loh AdrpAdd	Lloh74, Lloh75
	.loh AdrpAdd	Lloh72, Lloh73
	.loh AdrpAdd	Lloh70, Lloh71
	.loh AdrpAdd	Lloh68, Lloh69
	.loh AdrpAdd	Lloh66, Lloh67
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpAdd	Lloh105, Lloh106
	.loh AdrpLdrGotLdr	Lloh102, Lloh103, Lloh104
	.cfi_endproc
                                        ; -- End function
	.globl	_test2                          ; -- Begin function test2
	.p2align	2
_test2:                                 ; @test2
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
Lloh107:
	adrp	x0, l_.str.33@PAGE
Lloh108:
	add	x0, x0, l_.str.33@PAGEOFF
Lloh109:
	adrp	x1, l_.str.34@PAGE
Lloh110:
	add	x1, x1, l_.str.34@PAGEOFF
	bl	_start_op_ctx
	mov	x19, x0
Lloh111:
	adrp	x20, l_.str.31@PAGE
Lloh112:
	add	x20, x20, l_.str.31@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh113:
	adrp	x1, l_.str.35@PAGE
Lloh114:
	add	x1, x1, l_.str.35@PAGEOFF
Lloh115:
	adrp	x2, l_.str.36@PAGE
Lloh116:
	add	x2, x2, l_.str.36@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh117:
	adrp	x1, l_.str.37@PAGE
Lloh118:
	add	x1, x1, l_.str.37@PAGEOFF
Lloh119:
	adrp	x2, l_.str.38@PAGE
Lloh120:
	add	x2, x2, l_.str.38@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh121:
	adrp	x1, l_.str.9@PAGE
Lloh122:
	add	x1, x1, l_.str.9@PAGEOFF
Lloh123:
	adrp	x2, l_.str.39@PAGE
Lloh124:
	add	x2, x2, l_.str.39@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
	cbnz	x0, LBB5_3
; %bb.1:
	adrp	x21, _tests@PAGE
	ldr	w8, [x21, _tests@PAGEOFF]
	add	w8, w8, #1
	str	w8, [x21, _tests@PAGEOFF]
Lloh125:
	adrp	x20, l_.str.32@PAGE
Lloh126:
	add	x20, x20, l_.str.32@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh127:
	adrp	x1, l_.str.28@PAGE
Lloh128:
	add	x1, x1, l_.str.28@PAGEOFF
Lloh129:
	adrp	x2, l_.str.40@PAGE
Lloh130:
	add	x2, x2, l_.str.40@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh131:
	adrp	x1, l_.str.41@PAGE
Lloh132:
	add	x1, x1, l_.str.41@PAGEOFF
Lloh133:
	adrp	x2, l_.str.42@PAGE
Lloh134:
	add	x2, x2, l_.str.42@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh135:
	adrp	x1, l_.str.43@PAGE
Lloh136:
	add	x1, x1, l_.str.43@PAGEOFF
Lloh137:
	adrp	x2, l_.str.44@PAGE
Lloh138:
	add	x2, x2, l_.str.44@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
	cbnz	x0, LBB5_3
; %bb.2:
	ldr	w8, [x21, _tests@PAGEOFF]
	add	w8, w8, #1
	str	w8, [x21, _tests@PAGEOFF]
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	b	_end_context
LBB5_3:
Lloh139:
	adrp	x8, ___stderrp@GOTPAGE
Lloh140:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh141:
	ldr	x8, [x8]
	ldr	x9, [x0, #8]
	str	x9, [sp]
Lloh142:
	adrp	x1, l_.str.5@PAGE
Lloh143:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh123, Lloh124
	.loh AdrpAdd	Lloh121, Lloh122
	.loh AdrpAdd	Lloh119, Lloh120
	.loh AdrpAdd	Lloh117, Lloh118
	.loh AdrpAdd	Lloh115, Lloh116
	.loh AdrpAdd	Lloh113, Lloh114
	.loh AdrpAdd	Lloh111, Lloh112
	.loh AdrpAdd	Lloh109, Lloh110
	.loh AdrpAdd	Lloh107, Lloh108
	.loh AdrpAdd	Lloh137, Lloh138
	.loh AdrpAdd	Lloh135, Lloh136
	.loh AdrpAdd	Lloh133, Lloh134
	.loh AdrpAdd	Lloh131, Lloh132
	.loh AdrpAdd	Lloh129, Lloh130
	.loh AdrpAdd	Lloh127, Lloh128
	.loh AdrpAdd	Lloh125, Lloh126
	.loh AdrpAdd	Lloh142, Lloh143
	.loh AdrpLdrGotLdr	Lloh139, Lloh140, Lloh141
	.cfi_endproc
                                        ; -- End function
	.globl	_test3                          ; -- Begin function test3
	.p2align	2
_test3:                                 ; @test3
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
Lloh144:
	adrp	x0, l_.str.46@PAGE
Lloh145:
	add	x0, x0, l_.str.46@PAGEOFF
Lloh146:
	adrp	x20, l_.str.10@PAGE
Lloh147:
	add	x20, x20, l_.str.10@PAGEOFF
	mov	x1, x20
	bl	_start_op_ctx
	mov	x19, x0
Lloh148:
	adrp	x21, l_.str.45@PAGE
Lloh149:
	add	x21, x21, l_.str.45@PAGEOFF
	mov	x0, x21
	mov	x1, x19
	bl	_stoken
Lloh150:
	adrp	x1, l_.str.47@PAGE
Lloh151:
	add	x1, x1, l_.str.47@PAGEOFF
Lloh152:
	adrp	x2, l_.str.48@PAGE
Lloh153:
	add	x2, x2, l_.str.48@PAGEOFF
	bl	_test_full
	mov	x0, x21
	mov	x1, x19
	bl	_stoken
Lloh154:
	adrp	x2, l_.str.49@PAGE
Lloh155:
	add	x2, x2, l_.str.49@PAGEOFF
	mov	x1, x20
	bl	_test_full
	mov	x0, x21
	mov	x1, x19
	bl	_stoken
Lloh156:
	adrp	x1, l_.str.9@PAGE
Lloh157:
	add	x1, x1, l_.str.9@PAGEOFF
Lloh158:
	adrp	x2, l_.str.50@PAGE
Lloh159:
	add	x2, x2, l_.str.50@PAGEOFF
	bl	_test_full
	mov	x0, x21
	mov	x1, x19
	bl	_stoken
	cbnz	x0, LBB6_2
; %bb.1:
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	b	_end_context
LBB6_2:
Lloh160:
	adrp	x8, ___stderrp@GOTPAGE
Lloh161:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh162:
	ldr	x8, [x8]
	ldr	x9, [x0, #8]
	str	x9, [sp]
Lloh163:
	adrp	x1, l_.str.5@PAGE
Lloh164:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh158, Lloh159
	.loh AdrpAdd	Lloh156, Lloh157
	.loh AdrpAdd	Lloh154, Lloh155
	.loh AdrpAdd	Lloh152, Lloh153
	.loh AdrpAdd	Lloh150, Lloh151
	.loh AdrpAdd	Lloh148, Lloh149
	.loh AdrpAdd	Lloh146, Lloh147
	.loh AdrpAdd	Lloh144, Lloh145
	.loh AdrpAdd	Lloh163, Lloh164
	.loh AdrpLdrGotLdr	Lloh160, Lloh161, Lloh162
	.cfi_endproc
                                        ; -- End function
	.globl	_test4                          ; -- Begin function test4
	.p2align	2
_test4:                                 ; @test4
	.cfi_startproc
; %bb.0:
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
Lloh165:
	adrp	x0, l_.str.52@PAGE
Lloh166:
	add	x0, x0, l_.str.52@PAGEOFF
Lloh167:
	adrp	x1, l_.str.53@PAGE
Lloh168:
	add	x1, x1, l_.str.53@PAGEOFF
	mov	w2, #92
	bl	_start_delim_ctx
	mov	x19, x0
Lloh169:
	adrp	x20, l_.str.51@PAGE
Lloh170:
	add	x20, x20, l_.str.51@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh171:
	adrp	x1, l_.str.54@PAGE
Lloh172:
	add	x1, x1, l_.str.54@PAGEOFF
Lloh173:
	adrp	x2, l_.str.55@PAGE
Lloh174:
	add	x2, x2, l_.str.55@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh175:
	adrp	x1, l_.str.56@PAGE
Lloh176:
	add	x1, x1, l_.str.56@PAGEOFF
Lloh177:
	adrp	x2, l_.str.57@PAGE
Lloh178:
	add	x2, x2, l_.str.57@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh179:
	adrp	x1, l_.str.58@PAGE
Lloh180:
	add	x1, x1, l_.str.58@PAGEOFF
Lloh181:
	adrp	x2, l_.str.59@PAGE
Lloh182:
	add	x2, x2, l_.str.59@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh183:
	adrp	x1, l_.str.60@PAGE
Lloh184:
	add	x1, x1, l_.str.60@PAGEOFF
Lloh185:
	adrp	x2, l_.str.61@PAGE
Lloh186:
	add	x2, x2, l_.str.61@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
	cbnz	x0, LBB7_2
; %bb.1:
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
	mov	x0, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	b	_end_context
LBB7_2:
Lloh187:
	adrp	x8, ___stderrp@GOTPAGE
Lloh188:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh189:
	ldr	x8, [x8]
	ldr	x9, [x0, #8]
	str	x9, [sp]
Lloh190:
	adrp	x1, l_.str.5@PAGE
Lloh191:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh185, Lloh186
	.loh AdrpAdd	Lloh183, Lloh184
	.loh AdrpAdd	Lloh181, Lloh182
	.loh AdrpAdd	Lloh179, Lloh180
	.loh AdrpAdd	Lloh177, Lloh178
	.loh AdrpAdd	Lloh175, Lloh176
	.loh AdrpAdd	Lloh173, Lloh174
	.loh AdrpAdd	Lloh171, Lloh172
	.loh AdrpAdd	Lloh169, Lloh170
	.loh AdrpAdd	Lloh167, Lloh168
	.loh AdrpAdd	Lloh165, Lloh166
	.loh AdrpAdd	Lloh190, Lloh191
	.loh AdrpLdrGotLdr	Lloh187, Lloh188, Lloh189
	.cfi_endproc
                                        ; -- End function
	.globl	_test5                          ; -- Begin function test5
	.p2align	2
_test5:                                 ; @test5
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
Lloh192:
	adrp	x0, l_.str.63@PAGE
Lloh193:
	add	x0, x0, l_.str.63@PAGEOFF
Lloh194:
	adrp	x1, l_.str.64@PAGE
Lloh195:
	add	x1, x1, l_.str.64@PAGEOFF
	mov	w2, #0
	bl	_start_delim_ctx
	mov	x19, x0
Lloh196:
	adrp	x20, l_.str.62@PAGE
Lloh197:
	add	x20, x20, l_.str.62@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh198:
	adrp	x2, l_.str.65@PAGE
Lloh199:
	add	x2, x2, l_.str.65@PAGEOFF
	mov	x1, x20
	bl	_test_full
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_end_context
	.loh AdrpAdd	Lloh198, Lloh199
	.loh AdrpAdd	Lloh196, Lloh197
	.loh AdrpAdd	Lloh194, Lloh195
	.loh AdrpAdd	Lloh192, Lloh193
	.cfi_endproc
                                        ; -- End function
	.globl	_test6                          ; -- Begin function test6
	.p2align	2
_test6:                                 ; @test6
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
Lloh200:
	adrp	x0, l_.str.67@PAGE
Lloh201:
	add	x0, x0, l_.str.67@PAGEOFF
Lloh202:
	adrp	x1, l_.str.64@PAGE
Lloh203:
	add	x1, x1, l_.str.64@PAGEOFF
	mov	w2, #92
	bl	_start_delim_ctx
	mov	x19, x0
Lloh204:
	adrp	x0, l_.str.66@PAGE
Lloh205:
	add	x0, x0, l_.str.66@PAGEOFF
	mov	x1, x19
	bl	_stoken
Lloh206:
	adrp	x1, l_.str.68@PAGE
Lloh207:
	add	x1, x1, l_.str.68@PAGEOFF
Lloh208:
	adrp	x2, l_.str.69@PAGE
Lloh209:
	add	x2, x2, l_.str.69@PAGEOFF
	bl	_test_full
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_end_context
	.loh AdrpAdd	Lloh208, Lloh209
	.loh AdrpAdd	Lloh206, Lloh207
	.loh AdrpAdd	Lloh204, Lloh205
	.loh AdrpAdd	Lloh202, Lloh203
	.loh AdrpAdd	Lloh200, Lloh201
	.cfi_endproc
                                        ; -- End function
	.globl	_test7                          ; -- Begin function test7
	.p2align	2
_test7:                                 ; @test7
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
Lloh210:
	adrp	x0, l_.str.71@PAGE
Lloh211:
	add	x0, x0, l_.str.71@PAGEOFF
Lloh212:
	adrp	x1, l_.str.72@PAGE
Lloh213:
	add	x1, x1, l_.str.72@PAGEOFF
	mov	w2, #0
	bl	_start_delim_ctx
	mov	x19, x0
Lloh214:
	adrp	x20, l_.str.70@PAGE
Lloh215:
	add	x20, x20, l_.str.70@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh216:
	adrp	x1, l_.str.9@PAGE
Lloh217:
	add	x1, x1, l_.str.9@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh218:
	adrp	x1, l_.str.73@PAGE
Lloh219:
	add	x1, x1, l_.str.73@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh220:
	adrp	x1, l_.str.74@PAGE
Lloh221:
	add	x1, x1, l_.str.74@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh222:
	adrp	x1, l_.str.75@PAGE
Lloh223:
	add	x1, x1, l_.str.75@PAGEOFF
	bl	_test_str
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_end_context
	.loh AdrpAdd	Lloh222, Lloh223
	.loh AdrpAdd	Lloh220, Lloh221
	.loh AdrpAdd	Lloh218, Lloh219
	.loh AdrpAdd	Lloh216, Lloh217
	.loh AdrpAdd	Lloh214, Lloh215
	.loh AdrpAdd	Lloh212, Lloh213
	.loh AdrpAdd	Lloh210, Lloh211
	.cfi_endproc
                                        ; -- End function
	.globl	_test8                          ; -- Begin function test8
	.p2align	2
_test8:                                 ; @test8
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
Lloh224:
	adrp	x19, l_.str.76@PAGE
Lloh225:
	add	x19, x19, l_.str.76@PAGEOFF
Lloh226:
	adrp	x1, l_.str.77@PAGE
Lloh227:
	add	x1, x1, l_.str.77@PAGEOFF
	mov	x0, x19
	bl	_fopen
	mov	x20, x0
Lloh228:
	adrp	x21, l_.str.78@PAGE
Lloh229:
	add	x21, x21, l_.str.78@PAGEOFF
Lloh230:
	adrp	x2, l_.str.53@PAGE
Lloh231:
	add	x2, x2, l_.str.53@PAGEOFF
	mov	x0, x19
	mov	x1, x21
	mov	w3, #0
	bl	_start_context
	mov	x19, x0
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh232:
	adrp	x1, l_.str.79@PAGE
Lloh233:
	add	x1, x1, l_.str.79@PAGEOFF
Lloh234:
	adrp	x2, l_.str.80@PAGE
Lloh235:
	add	x2, x2, l_.str.80@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh236:
	adrp	x2, l_.str.81@PAGE
Lloh237:
	add	x2, x2, l_.str.81@PAGEOFF
	mov	x1, x21
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh238:
	adrp	x1, l_.str.82@PAGE
Lloh239:
	add	x1, x1, l_.str.82@PAGEOFF
Lloh240:
	adrp	x2, l_.str.83@PAGE
Lloh241:
	add	x2, x2, l_.str.83@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh242:
	adrp	x1, l_.str.84@PAGE
Lloh243:
	add	x1, x1, l_.str.84@PAGEOFF
Lloh244:
	adrp	x2, l_.str.85@PAGE
Lloh245:
	add	x2, x2, l_.str.85@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh246:
	adrp	x1, l_.str.86@PAGE
Lloh247:
	add	x1, x1, l_.str.86@PAGEOFF
Lloh248:
	adrp	x2, l_.str.87@PAGE
Lloh249:
	add	x2, x2, l_.str.87@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh250:
	adrp	x1, l_.str.88@PAGE
Lloh251:
	add	x1, x1, l_.str.88@PAGEOFF
Lloh252:
	adrp	x2, l_.str.89@PAGE
Lloh253:
	add	x2, x2, l_.str.89@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh254:
	adrp	x1, l_.str.90@PAGE
Lloh255:
	add	x1, x1, l_.str.90@PAGEOFF
Lloh256:
	adrp	x2, l_.str.91@PAGE
Lloh257:
	add	x2, x2, l_.str.91@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh258:
	adrp	x1, l_.str.92@PAGE
Lloh259:
	add	x1, x1, l_.str.92@PAGEOFF
Lloh260:
	adrp	x2, l_.str.93@PAGE
Lloh261:
	add	x2, x2, l_.str.93@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
Lloh262:
	adrp	x1, l_.str.94@PAGE
Lloh263:
	add	x1, x1, l_.str.94@PAGEOFF
Lloh264:
	adrp	x2, l_.str.95@PAGE
Lloh265:
	add	x2, x2, l_.str.95@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_ftoken
	cbnz	x0, LBB11_2
; %bb.1:
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	b	_end_context
LBB11_2:
Lloh266:
	adrp	x8, ___stderrp@GOTPAGE
Lloh267:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh268:
	ldr	x8, [x8]
	ldr	x9, [x0, #8]
	str	x9, [sp]
Lloh269:
	adrp	x1, l_.str.5@PAGE
Lloh270:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh264, Lloh265
	.loh AdrpAdd	Lloh262, Lloh263
	.loh AdrpAdd	Lloh260, Lloh261
	.loh AdrpAdd	Lloh258, Lloh259
	.loh AdrpAdd	Lloh256, Lloh257
	.loh AdrpAdd	Lloh254, Lloh255
	.loh AdrpAdd	Lloh252, Lloh253
	.loh AdrpAdd	Lloh250, Lloh251
	.loh AdrpAdd	Lloh248, Lloh249
	.loh AdrpAdd	Lloh246, Lloh247
	.loh AdrpAdd	Lloh244, Lloh245
	.loh AdrpAdd	Lloh242, Lloh243
	.loh AdrpAdd	Lloh240, Lloh241
	.loh AdrpAdd	Lloh238, Lloh239
	.loh AdrpAdd	Lloh236, Lloh237
	.loh AdrpAdd	Lloh234, Lloh235
	.loh AdrpAdd	Lloh232, Lloh233
	.loh AdrpAdd	Lloh230, Lloh231
	.loh AdrpAdd	Lloh228, Lloh229
	.loh AdrpAdd	Lloh226, Lloh227
	.loh AdrpAdd	Lloh224, Lloh225
	.loh AdrpAdd	Lloh269, Lloh270
	.loh AdrpLdrGotLdr	Lloh266, Lloh267, Lloh268
	.cfi_endproc
                                        ; -- End function
	.globl	_test9                          ; -- Begin function test9
	.p2align	2
_test9:                                 ; @test9
	.cfi_startproc
; %bb.0:
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
Lloh271:
	adrp	x0, l_.str.97@PAGE
Lloh272:
	add	x0, x0, l_.str.97@PAGEOFF
	bl	_start_def_ctx
	mov	x19, x0
Lloh273:
	adrp	x0, l_.str.96@PAGE
Lloh274:
	add	x0, x0, l_.str.96@PAGEOFF
	mov	x1, #0
	bl	_stoken
	cbnz	x0, LBB12_2
; %bb.1:
	adrp	x8, _tests@PAGE
	ldr	w9, [x8, _tests@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _tests@PAGEOFF]
Lloh275:
	adrp	x20, l_.str.96@PAGE
Lloh276:
	add	x20, x20, l_.str.96@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
	mov	x1, x19
	bl	_untoken
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh277:
	adrp	x1, l_.str.98@PAGE
Lloh278:
	add	x1, x1, l_.str.98@PAGEOFF
Lloh279:
	adrp	x2, l_.str.99@PAGE
Lloh280:
	add	x2, x2, l_.str.99@PAGEOFF
	bl	_test_full
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh281:
	adrp	x1, l_.str.100@PAGE
Lloh282:
	add	x1, x1, l_.str.100@PAGEOFF
Lloh283:
	adrp	x2, l_.str.101@PAGE
Lloh284:
	add	x2, x2, l_.str.101@PAGEOFF
	bl	_test_full
	mov	x0, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	b	_end_context
LBB12_2:
Lloh285:
	adrp	x8, ___stderrp@GOTPAGE
Lloh286:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh287:
	ldr	x8, [x8]
	ldr	x9, [x0, #8]
	str	x9, [sp]
Lloh288:
	adrp	x1, l_.str.5@PAGE
Lloh289:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #1
	bl	_exit
	.loh AdrpAdd	Lloh273, Lloh274
	.loh AdrpAdd	Lloh271, Lloh272
	.loh AdrpAdd	Lloh283, Lloh284
	.loh AdrpAdd	Lloh281, Lloh282
	.loh AdrpAdd	Lloh279, Lloh280
	.loh AdrpAdd	Lloh277, Lloh278
	.loh AdrpAdd	Lloh275, Lloh276
	.loh AdrpAdd	Lloh288, Lloh289
	.loh AdrpLdrGotLdr	Lloh285, Lloh286, Lloh287
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
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
	bl	_test_basic
	bl	_test1
	bl	_test2
	bl	_test3
	bl	_test4
Lloh290:
	adrp	x0, l_.str.63@PAGE
Lloh291:
	add	x0, x0, l_.str.63@PAGEOFF
Lloh292:
	adrp	x19, l_.str.64@PAGE
Lloh293:
	add	x19, x19, l_.str.64@PAGEOFF
	mov	x1, x19
	mov	w2, #0
	bl	_start_delim_ctx
	mov	x20, x0
Lloh294:
	adrp	x21, l_.str.62@PAGE
Lloh295:
	add	x21, x21, l_.str.62@PAGEOFF
	mov	x0, x21
	mov	x1, x20
	bl	_stoken
Lloh296:
	adrp	x2, l_.str.65@PAGE
Lloh297:
	add	x2, x2, l_.str.65@PAGEOFF
	mov	x1, x21
	bl	_test_full
	mov	x0, x20
	bl	_end_context
Lloh298:
	adrp	x0, l_.str.67@PAGE
Lloh299:
	add	x0, x0, l_.str.67@PAGEOFF
	mov	x1, x19
	mov	w2, #92
	bl	_start_delim_ctx
	mov	x19, x0
Lloh300:
	adrp	x0, l_.str.66@PAGE
Lloh301:
	add	x0, x0, l_.str.66@PAGEOFF
	mov	x1, x19
	bl	_stoken
Lloh302:
	adrp	x1, l_.str.68@PAGE
Lloh303:
	add	x1, x1, l_.str.68@PAGEOFF
Lloh304:
	adrp	x2, l_.str.69@PAGE
Lloh305:
	add	x2, x2, l_.str.69@PAGEOFF
	bl	_test_full
	mov	x0, x19
	bl	_end_context
Lloh306:
	adrp	x0, l_.str.71@PAGE
Lloh307:
	add	x0, x0, l_.str.71@PAGEOFF
Lloh308:
	adrp	x1, l_.str.72@PAGE
Lloh309:
	add	x1, x1, l_.str.72@PAGEOFF
	mov	w2, #0
	bl	_start_delim_ctx
	mov	x19, x0
Lloh310:
	adrp	x20, l_.str.70@PAGE
Lloh311:
	add	x20, x20, l_.str.70@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh312:
	adrp	x1, l_.str.9@PAGE
Lloh313:
	add	x1, x1, l_.str.9@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh314:
	adrp	x1, l_.str.73@PAGE
Lloh315:
	add	x1, x1, l_.str.73@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh316:
	adrp	x1, l_.str.74@PAGE
Lloh317:
	add	x1, x1, l_.str.74@PAGEOFF
	bl	_test_str
	mov	x0, x20
	mov	x1, x19
	bl	_stoken
Lloh318:
	adrp	x1, l_.str.75@PAGE
Lloh319:
	add	x1, x1, l_.str.75@PAGEOFF
	bl	_test_str
	mov	x0, x19
	bl	_end_context
	bl	_test8
	bl	_test9
Lloh320:
	adrp	x8, _tests@PAGE
Lloh321:
	ldr	w8, [x8, _tests@PAGEOFF]
	str	x8, [sp]
Lloh322:
	adrp	x0, l_.str.102@PAGE
Lloh323:
	add	x0, x0, l_.str.102@PAGEOFF
	bl	_printf
	mov	w0, #0
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.loh AdrpAdd	Lloh322, Lloh323
	.loh AdrpLdr	Lloh320, Lloh321
	.loh AdrpAdd	Lloh318, Lloh319
	.loh AdrpAdd	Lloh316, Lloh317
	.loh AdrpAdd	Lloh314, Lloh315
	.loh AdrpAdd	Lloh312, Lloh313
	.loh AdrpAdd	Lloh310, Lloh311
	.loh AdrpAdd	Lloh308, Lloh309
	.loh AdrpAdd	Lloh306, Lloh307
	.loh AdrpAdd	Lloh304, Lloh305
	.loh AdrpAdd	Lloh302, Lloh303
	.loh AdrpAdd	Lloh300, Lloh301
	.loh AdrpAdd	Lloh298, Lloh299
	.loh AdrpAdd	Lloh296, Lloh297
	.loh AdrpAdd	Lloh294, Lloh295
	.loh AdrpAdd	Lloh292, Lloh293
	.loh AdrpAdd	Lloh290, Lloh291
	.cfi_endproc
                                        ; -- End function
	.globl	_tests                          ; @tests
.zerofill __DATA,__common,_tests,4,2
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Expected %s but got an empty token\n"

l_.str.1:                               ; @.str.1
	.asciz	"Token has string %s but expected %s\n"

l_.str.2:                               ; @.str.2
	.asciz	"Expected the token %s but got null\n"

l_.str.3:                               ; @.str.3
	.asciz	"Could not format location of token\n"

l_.str.4:                               ; @.str.4
	.asciz	"Token %s has location `%s` but expected `%s`\n"

l_.str.5:                               ; @.str.5
	.asciz	"Expected empty token but got %s\n"

l_.str.6:                               ; @.str.6
	.asciz	"1+10 * 100+x"

l_.str.7:                               ; @.str.7
	.asciz	"test_basic"

l_.str.8:                               ; @.str.8
	.asciz	"+*"

l_.str.9:                               ; @.str.9
	.asciz	"1"

l_.str.10:                              ; @.str.10
	.asciz	"+"

l_.str.11:                              ; @.str.11
	.asciz	"10"

l_.str.12:                              ; @.str.12
	.asciz	"*"

l_.str.13:                              ; @.str.13
	.asciz	"100"

l_.str.14:                              ; @.str.14
	.asciz	"x"

l_.str.15:                              ; @.str.15
	.asciz	"(*(+ 10 20)2)"

l_.str.16:                              ; @.str.16
	.asciz	"test1"

l_.str.17:                              ; @.str.17
	.asciz	"+*()"

l_.str.18:                              ; @.str.18
	.asciz	"("

l_.str.19:                              ; @.str.19
	.asciz	"test1:1:1"

l_.str.20:                              ; @.str.20
	.asciz	"test1:1:2"

l_.str.21:                              ; @.str.21
	.asciz	"test1:1:3"

l_.str.22:                              ; @.str.22
	.asciz	"test1:1:4"

l_.str.23:                              ; @.str.23
	.asciz	"test1:1:6"

l_.str.24:                              ; @.str.24
	.asciz	"20"

l_.str.25:                              ; @.str.25
	.asciz	"test1:1:9"

l_.str.26:                              ; @.str.26
	.asciz	")"

l_.str.27:                              ; @.str.27
	.asciz	"test1:1:11"

l_.str.28:                              ; @.str.28
	.asciz	"2"

l_.str.29:                              ; @.str.29
	.asciz	"test1:1:12"

l_.str.30:                              ; @.str.30
	.asciz	"test1:1:13"

l_.str.31:                              ; @.str.31
	.asciz	"[/ 1"

l_.str.32:                              ; @.str.32
	.asciz	"2 3]"

l_.str.33:                              ; @.str.33
	.asciz	"test2"

l_.str.34:                              ; @.str.34
	.asciz	"/[]"

l_.str.35:                              ; @.str.35
	.asciz	"["

l_.str.36:                              ; @.str.36
	.asciz	"test2:1:1"

l_.str.37:                              ; @.str.37
	.asciz	"/"

l_.str.38:                              ; @.str.38
	.asciz	"test2:1:2"

l_.str.39:                              ; @.str.39
	.asciz	"test2:1:4"

l_.str.40:                              ; @.str.40
	.asciz	"test2:1:5"

l_.str.41:                              ; @.str.41
	.asciz	"3"

l_.str.42:                              ; @.str.42
	.asciz	"test2:1:7"

l_.str.43:                              ; @.str.43
	.asciz	"]"

l_.str.44:                              ; @.str.44
	.asciz	"test2:1:8"

l_.str.45:                              ; @.str.45
	.asciz	"12345 +\n1"

l_.str.46:                              ; @.str.46
	.asciz	"test3"

l_.str.47:                              ; @.str.47
	.asciz	"12345"

l_.str.48:                              ; @.str.48
	.asciz	"test3:1:1"

l_.str.49:                              ; @.str.49
	.asciz	"test3:1:7"

l_.str.50:                              ; @.str.50
	.asciz	"test3:2:1"

l_.str.51:                              ; @.str.51
	.asciz	"one two \"three \\\" four\" more"

l_.str.52:                              ; @.str.52
	.asciz	"test4"

l_.str.53:                              ; @.str.53
	.asciz	"\"\""

l_.str.54:                              ; @.str.54
	.asciz	"one"

l_.str.55:                              ; @.str.55
	.asciz	"test4:1:1"

l_.str.56:                              ; @.str.56
	.asciz	"two"

l_.str.57:                              ; @.str.57
	.asciz	"test4:1:5"

l_.str.58:                              ; @.str.58
	.asciz	"\"three \" four\""

l_.str.59:                              ; @.str.59
	.asciz	"test4:1:9"

l_.str.60:                              ; @.str.60
	.asciz	"more"

l_.str.61:                              ; @.str.61
	.asciz	"test4:1:25"

l_.str.62:                              ; @.str.62
	.asciz	"^single\ntoken^"

l_.str.63:                              ; @.str.63
	.asciz	"test5"

l_.str.64:                              ; @.str.64
	.asciz	"^^"

l_.str.65:                              ; @.str.65
	.asciz	"test5:1:1"

l_.str.66:                              ; @.str.66
	.asciz	"^single\\^\ntoken^"

l_.str.67:                              ; @.str.67
	.asciz	"test6"

l_.str.68:                              ; @.str.68
	.asciz	"^single^\ntoken^"

l_.str.69:                              ; @.str.69
	.asciz	"test6:1:1"

l_.str.70:                              ; @.str.70
	.asciz	"1 .2 ^3^ 4. ^5 6^ 7"

l_.str.71:                              ; @.str.71
	.asciz	"test7"

l_.str.72:                              ; @.str.72
	.asciz	"^^.."

l_.str.73:                              ; @.str.73
	.asciz	".2 ^3^ 4."

l_.str.74:                              ; @.str.74
	.asciz	"^5 6^"

l_.str.75:                              ; @.str.75
	.asciz	"7"

l_.str.76:                              ; @.str.76
	.asciz	"Makefile"

l_.str.77:                              ; @.str.77
	.asciz	"r"

l_.str.78:                              ; @.str.78
	.asciz	":"

l_.str.79:                              ; @.str.79
	.asciz	"all"

l_.str.80:                              ; @.str.80
	.asciz	"Makefile:1:1"

l_.str.81:                              ; @.str.81
	.asciz	"Makefile:1:4"

l_.str.82:                              ; @.str.82
	.asciz	"#"

l_.str.83:                              ; @.str.83
	.asciz	"Makefile:2:2"

l_.str.84:                              ; @.str.84
	.asciz	"\"Compile for testing\""

l_.str.85:                              ; @.str.85
	.asciz	"Makefile:2:4"

l_.str.86:                              ; @.str.86
	.asciz	"cc"

l_.str.87:                              ; @.str.87
	.asciz	"Makefile:3:2"

l_.str.88:                              ; @.str.88
	.asciz	"-W"

l_.str.89:                              ; @.str.89
	.asciz	"Makefile:3:5"

l_.str.90:                              ; @.str.90
	.asciz	"*.c"

l_.str.91:                              ; @.str.91
	.asciz	"Makefile:3:8"

l_.str.92:                              ; @.str.92
	.asciz	"-o"

l_.str.93:                              ; @.str.93
	.asciz	"Makefile:3:12"

l_.str.94:                              ; @.str.94
	.asciz	"test"

l_.str.95:                              ; @.str.95
	.asciz	"Makefile:3:15"

l_.str.96:                              ; @.str.96
	.asciz	"foo bar baz"

l_.str.97:                              ; @.str.97
	.asciz	"test9"

l_.str.98:                              ; @.str.98
	.asciz	"foo"

l_.str.99:                              ; @.str.99
	.asciz	"test9:1:1"

l_.str.100:                             ; @.str.100
	.asciz	"bar"

l_.str.101:                             ; @.str.101
	.asciz	"test9:1:5"

l_.str.102:                             ; @.str.102
	.asciz	"All %d tests passed\n"

.subsections_via_symbols
