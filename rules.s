	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 0
	.globl	_add_from_bitboard_old          ; -- Begin function add_from_bitboard_old
	.p2align	2
_add_from_bitboard_old:                 ; @add_from_bitboard_old
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
	cbz	x1, LBB0_5
; %bb.1:
	mov	x19, x3
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
	mov	x24, #0
                                        ; implicit-def: $x23
	b	LBB0_3
LBB0_2:                                 ;   in Loop: Header=BB0_3 Depth=1
	add	x24, x24, #1
	cmp	x24, #64
	b.eq	LBB0_5
LBB0_3:                                 ; =>This Inner Loop Header: Depth=1
	lsr	x8, x21, x24
	tbz	w8, #0, LBB0_2
; %bb.4:                                ;   in Loop: Header=BB0_3 Depth=1
	ldrb	w25, [x19]
	add	w8, w25, #1
	strb	w8, [x19]
	and	w1, w24, #0xff
	mov	x0, x22
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x23, x0, #0, #16
	mov	x0, x23
	bl	_generic_move
	str	w0, [x20, x25, lsl  #2]
	b	LBB0_2
LBB0_5:
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_add_from_bitboard              ; -- Begin function add_from_bitboard
	.p2align	2
_add_from_bitboard:                     ; @add_from_bitboard
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
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
	neg	x8, x1
	ands	x8, x8, x1
	b.eq	LBB1_154
; %bb.1:
	mov	w9, #2147483647
	mov	w11, #134217727
	mov	w16, #536870911
	mov	w7, #2
	mov	x19, #140737488355327
	mov	x20, #549755813887
	mov	x21, #34359738367
	mov	x22, #8589934591
	mov	x27, #137438953471
	mov	x15, #8796093022207
	mov	x4, #2199023255551
	mov	x13, #35184372088831
	mov	x14, #36028797018963967
	mov	x17, #2251799813685247
	mov	x5, #562949953421311
	mov	x28, #9007199254740991
	mov	x26, #576460752303423487
	mov	x24, #144115188075855871
	mov	x25, #2305843009213693951
Lloh0:
	adrp	x30, lJTI1_0@PAGE
Lloh1:
	add	x30, x30, lJTI1_0@PAGEOFF
	b	LBB1_4
LBB1_2:                                 ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #255
LBB1_3:                                 ;   in Loop: Header=BB1_4 Depth=1
	ldrb	w10, [x3]
	add	w12, w10, #1
	strb	w12, [x3]
	add	x10, x2, x10, lsl #2
	strb	w0, [x10]
	strb	w23, [x10, #1]
	strb	w7, [x10, #3]
	eor	x1, x8, x1
	neg	x8, x1
	ands	x8, x1, x8
	b.eq	LBB1_154
LBB1_4:                                 ; =>This Inner Loop Header: Depth=1
	cmp	x8, x9
	b.gt	LBB1_10
; %bb.5:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #8, lsl #12                 ; =32768
	b.ge	LBB1_17
; %bb.6:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #127
	b.gt	LBB1_29
; %bb.7:                                ;   in Loop: Header=BB1_4 Depth=1
	sub	x10, x8, #1
	cmp	x10, #63
	b.hi	LBB1_119
; %bb.8:                                ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #0
	adr	x6, LBB1_2
	ldrh	w12, [x30, x10, lsl  #1]
	add	x6, x6, x12, lsl #2
	br	x6
LBB1_9:                                 ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #1
	b	LBB1_3
LBB1_10:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x19
	b.gt	LBB1_23
; %bb.11:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x20
	b.gt	LBB1_34
; %bb.12:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x21
	b.gt	LBB1_49
; %bb.13:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x22
	b.gt	LBB1_77
; %bb.14:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #-2147483648
	cmp	x8, x10
	b.eq	LBB1_126
; %bb.15:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #4294967296
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.16:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #32
	b	LBB1_3
LBB1_17:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #2048, lsl #12              ; =8388608
	b.ge	LBB1_39
; %bb.18:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #128, lsl #12               ; =524288
	b.ge	LBB1_53
; %bb.19:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #32, lsl #12                ; =131072
	b.ge	LBB1_80
; %bb.20:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #8, lsl #12                 ; =32768
	b.eq	LBB1_127
; %bb.21:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #16, lsl #12                ; =65536
	b.ne	LBB1_2
; %bb.22:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #16
	b	LBB1_3
LBB1_23:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x14
	b.gt	LBB1_44
; %bb.24:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x17
	b.gt	LBB1_57
; %bb.25:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x5
	b.gt	LBB1_83
; %bb.26:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #140737488355328
	cmp	x8, x10
	b.eq	LBB1_128
; %bb.27:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #281474976710656
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.28:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #48
	b	LBB1_3
LBB1_29:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #2047
	b.gt	LBB1_61
; %bb.30:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #511
	b.gt	LBB1_86
; %bb.31:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #128
	b.eq	LBB1_129
; %bb.32:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #256
	b.ne	LBB1_2
; %bb.33:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #8
	b	LBB1_3
LBB1_34:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x15
	b.gt	LBB1_65
; %bb.35:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x4
	b.gt	LBB1_89
; %bb.36:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #549755813888
	cmp	x8, x10
	b.eq	LBB1_130
; %bb.37:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #1099511627776
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.38:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #40
	b	LBB1_3
LBB1_39:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x11
	b.gt	LBB1_69
; %bb.40:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #33554431
	cmp	x8, x10
	b.gt	LBB1_92
; %bb.41:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #2048, lsl #12              ; =8388608
	b.eq	LBB1_131
; %bb.42:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #16777216
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.43:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #24
	b	LBB1_3
LBB1_44:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x26
	b.gt	LBB1_73
; %bb.45:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x24
	b.gt	LBB1_95
; %bb.46:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #36028797018963968
	cmp	x8, x10
	b.eq	LBB1_132
; %bb.47:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #72057594037927936
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.48:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #56
	b	LBB1_3
LBB1_49:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x27
	b.gt	LBB1_98
; %bb.50:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #34359738368
	cmp	x8, x10
	b.eq	LBB1_133
; %bb.51:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #68719476736
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.52:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #36
	b	LBB1_3
LBB1_53:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #512, lsl #12               ; =2097152
	b.ge	LBB1_101
; %bb.54:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #128, lsl #12               ; =524288
	b.eq	LBB1_134
; %bb.55:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #256, lsl #12               ; =1048576
	b.ne	LBB1_2
; %bb.56:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #20
	b	LBB1_3
LBB1_57:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x28
	b.gt	LBB1_104
; %bb.58:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #2251799813685248
	cmp	x8, x10
	b.eq	LBB1_135
; %bb.59:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #4503599627370496
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.60:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #52
	b	LBB1_3
LBB1_61:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #2, lsl #12                 ; =8192
	b.ge	LBB1_107
; %bb.62:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #2048
	b.eq	LBB1_136
; %bb.63:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #1, lsl #12                 ; =4096
	b.ne	LBB1_2
; %bb.64:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #12
	b	LBB1_3
LBB1_65:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x13
	b.gt	LBB1_110
; %bb.66:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #8796093022208
	cmp	x8, x10
	b.eq	LBB1_137
; %bb.67:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #17592186044416
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.68:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #44
	b	LBB1_3
LBB1_69:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x16
	b.gt	LBB1_113
; %bb.70:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #134217728
	cmp	x8, x10
	b.eq	LBB1_138
; %bb.71:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #268435456
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.72:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #28
	b	LBB1_3
LBB1_73:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, x25
	b.gt	LBB1_116
; %bb.74:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #576460752303423488
	cmp	x8, x10
	b.eq	LBB1_139
; %bb.75:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #1152921504606846976
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.76:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #60
	b	LBB1_3
LBB1_77:                                ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #8589934592
	cmp	x8, x10
	b.eq	LBB1_140
; %bb.78:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #17179869184
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.79:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #34
	b	LBB1_3
LBB1_80:                                ;   in Loop: Header=BB1_4 Depth=1
	b.eq	LBB1_141
; %bb.81:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #64, lsl #12                ; =262144
	b.ne	LBB1_2
; %bb.82:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #18
	b	LBB1_3
LBB1_83:                                ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #562949953421312
	cmp	x8, x10
	b.eq	LBB1_142
; %bb.84:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #1125899906842624
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.85:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #50
	b	LBB1_3
LBB1_86:                                ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #512
	b.eq	LBB1_143
; %bb.87:                               ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #1024
	b.ne	LBB1_2
; %bb.88:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #10
	b	LBB1_3
LBB1_89:                                ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #2199023255552
	cmp	x8, x10
	b.eq	LBB1_144
; %bb.90:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #4398046511104
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.91:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #42
	b	LBB1_3
LBB1_92:                                ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #33554432
	cmp	x8, x10
	b.eq	LBB1_145
; %bb.93:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #67108864
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.94:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #26
	b	LBB1_3
LBB1_95:                                ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #144115188075855872
	cmp	x8, x10
	b.eq	LBB1_146
; %bb.96:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #288230376151711744
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.97:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #58
	b	LBB1_3
LBB1_98:                                ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #137438953472
	cmp	x8, x10
	b.eq	LBB1_147
; %bb.99:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #274877906944
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.100:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #38
	b	LBB1_3
LBB1_101:                               ;   in Loop: Header=BB1_4 Depth=1
	b.eq	LBB1_148
; %bb.102:                              ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #1024, lsl #12              ; =4194304
	b.ne	LBB1_2
; %bb.103:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #22
	b	LBB1_3
LBB1_104:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #9007199254740992
	cmp	x8, x10
	b.eq	LBB1_149
; %bb.105:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #18014398509481984
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.106:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #54
	b	LBB1_3
LBB1_107:                               ;   in Loop: Header=BB1_4 Depth=1
	b.eq	LBB1_150
; %bb.108:                              ;   in Loop: Header=BB1_4 Depth=1
	cmp	x8, #4, lsl #12                 ; =16384
	b.ne	LBB1_2
; %bb.109:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #14
	b	LBB1_3
LBB1_110:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #35184372088832
	cmp	x8, x10
	b.eq	LBB1_151
; %bb.111:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #70368744177664
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.112:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #46
	b	LBB1_3
LBB1_113:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #536870912
	cmp	x8, x10
	b.eq	LBB1_152
; %bb.114:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w10, #1073741824
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.115:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #30
	b	LBB1_3
LBB1_116:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #2305843009213693952
	cmp	x8, x10
	b.eq	LBB1_153
; %bb.117:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #4611686018427387904
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.118:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #62
	b	LBB1_3
LBB1_119:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	x10, #-9223372036854775808
	cmp	x8, x10
	b.ne	LBB1_2
; %bb.120:                              ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #63
	b	LBB1_3
LBB1_121:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #2
	b	LBB1_3
LBB1_122:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #3
	b	LBB1_3
LBB1_123:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #4
	b	LBB1_3
LBB1_124:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #5
	b	LBB1_3
LBB1_125:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #6
	b	LBB1_3
LBB1_126:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #31
	b	LBB1_3
LBB1_127:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #15
	b	LBB1_3
LBB1_128:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #47
	b	LBB1_3
LBB1_129:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #7
	b	LBB1_3
LBB1_130:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #39
	b	LBB1_3
LBB1_131:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #23
	b	LBB1_3
LBB1_132:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #55
	b	LBB1_3
LBB1_133:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #35
	b	LBB1_3
LBB1_134:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #19
	b	LBB1_3
LBB1_135:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #51
	b	LBB1_3
LBB1_136:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #11
	b	LBB1_3
LBB1_137:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #43
	b	LBB1_3
LBB1_138:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #27
	b	LBB1_3
LBB1_139:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #59
	b	LBB1_3
LBB1_140:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #33
	b	LBB1_3
LBB1_141:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #17
	b	LBB1_3
LBB1_142:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #49
	b	LBB1_3
LBB1_143:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #9
	b	LBB1_3
LBB1_144:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #41
	b	LBB1_3
LBB1_145:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #25
	b	LBB1_3
LBB1_146:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #57
	b	LBB1_3
LBB1_147:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #37
	b	LBB1_3
LBB1_148:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #21
	b	LBB1_3
LBB1_149:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #53
	b	LBB1_3
LBB1_150:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #13
	b	LBB1_3
LBB1_151:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #45
	b	LBB1_3
LBB1_152:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #29
	b	LBB1_3
LBB1_153:                               ;   in Loop: Header=BB1_4 Depth=1
	mov	w23, #61
	b	LBB1_3
LBB1_154:
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh0, Lloh1
	.cfi_endproc
	.section	__TEXT,__const
	.p2align	1, 0x0
lJTI1_0:
	.short	(LBB1_3-LBB1_2)>>2
	.short	(LBB1_9-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_121-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_122-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_123-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_124-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_2-LBB1_2)>>2
	.short	(LBB1_125-LBB1_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_add_from_bitboard_white_promotes ; -- Begin function add_from_bitboard_white_promotes
	.p2align	2
_add_from_bitboard_white_promotes:      ; @add_from_bitboard_white_promotes
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
	str	x1, [sp, #8]                    ; 8-byte Folded Spill
	cbz	x1, LBB2_5
; %bb.1:
	mov	x19, x3
	mov	x20, x2
	mov	x22, x0
	mov	w28, #56
                                        ; implicit-def: $x23
                                        ; implicit-def: $x24
                                        ; implicit-def: $x25
                                        ; implicit-def: $x26
	b	LBB2_3
LBB2_2:                                 ;   in Loop: Header=BB2_3 Depth=1
	add	x28, x28, #1
	cmp	x28, #64
	b.eq	LBB2_5
LBB2_3:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	lsr	x8, x8, x28
	tbz	w8, #0, LBB2_2
; %bb.4:                                ;   in Loop: Header=BB2_3 Depth=1
	ldrb	w21, [x19]
	add	w8, w21, #1
	strb	w8, [x19]
	and	w27, w28, #0xff
	mov	x0, x22
	mov	x1, x27
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x24, x0, #0, #16
	mov	x0, x24
	mov	w1, #7
	bl	_promotion_move
	str	w0, [x20, x21, lsl  #2]
	ldrb	w21, [x19]
	add	w8, w21, #1
	strb	w8, [x19]
	mov	x0, x22
	mov	x1, x27
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x26, x0, #0, #16
	mov	x0, x26
	mov	w1, #6
	bl	_promotion_move
	str	w0, [x20, x21, lsl  #2]
	ldrb	w21, [x19]
	add	w8, w21, #1
	strb	w8, [x19]
	mov	x0, x22
	mov	x1, x27
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x25, x0, #0, #16
	mov	x0, x25
	mov	w1, #5
	bl	_promotion_move
	str	w0, [x20, x21, lsl  #2]
	ldrb	w21, [x19]
	add	w8, w21, #1
	strb	w8, [x19]
	mov	x0, x22
	mov	x1, x27
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x23, x0, #0, #16
	mov	x0, x23
	mov	w1, #4
	bl	_promotion_move
	str	w0, [x20, x21, lsl  #2]
	b	LBB2_2
LBB2_5:
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
	.globl	_add_from_bitboard_black_promotes ; -- Begin function add_from_bitboard_black_promotes
	.p2align	2
_add_from_bitboard_black_promotes:      ; @add_from_bitboard_black_promotes
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
	str	x1, [sp, #8]                    ; 8-byte Folded Spill
	cbz	x1, LBB3_5
; %bb.1:
	mov	x19, x3
	mov	x20, x2
	mov	x22, x0
	mov	x28, #0
                                        ; implicit-def: $x23
                                        ; implicit-def: $x24
                                        ; implicit-def: $x25
                                        ; implicit-def: $x26
	b	LBB3_3
LBB3_2:                                 ;   in Loop: Header=BB3_3 Depth=1
	add	x28, x28, #1
	cmp	x28, #8
	b.eq	LBB3_5
LBB3_3:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	lsr	x8, x8, x28
	tbz	w8, #0, LBB3_2
; %bb.4:                                ;   in Loop: Header=BB3_3 Depth=1
	ldrb	w21, [x19]
	add	w8, w21, #1
	strb	w8, [x19]
	and	w27, w28, #0xff
	mov	x0, x22
	mov	x1, x27
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x24, x0, #0, #16
	mov	x0, x24
	mov	w1, #7
	bl	_promotion_move
	str	w0, [x20, x21, lsl  #2]
	ldrb	w21, [x19]
	add	w8, w21, #1
	strb	w8, [x19]
	mov	x0, x22
	mov	x1, x27
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x26, x0, #0, #16
	mov	x0, x26
	mov	w1, #6
	bl	_promotion_move
	str	w0, [x20, x21, lsl  #2]
	ldrb	w21, [x19]
	add	w8, w21, #1
	strb	w8, [x19]
	mov	x0, x22
	mov	x1, x27
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x25, x0, #0, #16
	mov	x0, x25
	mov	w1, #5
	bl	_promotion_move
	str	w0, [x20, x21, lsl  #2]
	ldrb	w21, [x19]
	add	w8, w21, #1
	strb	w8, [x19]
	mov	x0, x22
	mov	x1, x27
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	bfxil	x23, x0, #0, #16
	mov	x0, x23
	mov	w1, #4
	bl	_promotion_move
	str	w0, [x20, x21, lsl  #2]
	b	LBB3_2
LBB3_5:
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
	.globl	_nw_pawn_attack                 ; -- Begin function nw_pawn_attack
	.p2align	2
_nw_pawn_attack:                        ; @nw_pawn_attack
	.cfi_startproc
; %bb.0:
	and	x8, x1, x0, lsl #9
	and	x0, x8, #0xfefefefefefefefe
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_sw_pawn_attack                 ; -- Begin function sw_pawn_attack
	.p2align	2
_sw_pawn_attack:                        ; @sw_pawn_attack
	.cfi_startproc
; %bb.0:
	and	x8, x1, x0, lsr #7
	and	x0, x8, #0xfefefefefefefefe
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_ne_pawn_attack                 ; -- Begin function ne_pawn_attack
	.p2align	2
_ne_pawn_attack:                        ; @ne_pawn_attack
	.cfi_startproc
; %bb.0:
	and	x8, x1, x0, lsl #7
	and	x0, x8, #0x7f7f7f7f7f7f7f7f
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_se_pawn_attack                 ; -- Begin function se_pawn_attack
	.p2align	2
_se_pawn_attack:                        ; @se_pawn_attack
	.cfi_startproc
; %bb.0:
	and	x8, x1, x0, lsr #9
	and	x0, x8, #0x7f7f7f7f7f7f7f7f
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_white_pawn_attack_mask         ; -- Begin function white_pawn_attack_mask
	.p2align	2
_white_pawn_attack_mask:                ; @white_pawn_attack_mask
	.cfi_startproc
; %bb.0:
	lsl	x8, x0, #9
	and	x8, x8, #0xfefefefefefefefe
	lsl	x9, x0, #7
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x9
	and	x0, x8, x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_black_pawn_attack_mask         ; -- Begin function black_pawn_attack_mask
	.p2align	2
_black_pawn_attack_mask:                ; @black_pawn_attack_mask
	.cfi_startproc
; %bb.0:
	lsr	x8, x0, #7
	and	x8, x8, #0xfefefefefefefefe
	lsr	x9, x0, #9
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x9
	and	x0, x8, x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_pawn_attack_mask               ; -- Begin function pawn_attack_mask
	.p2align	2
_pawn_attack_mask:                      ; @pawn_attack_mask
	.cfi_startproc
; %bb.0:
	lsr	x8, x0, #7
	and	x8, x8, #0xfefefefefefefefe
	lsr	x9, x0, #9
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x9
	and	x8, x8, x2
	cmp	w1, #1
	lsl	x9, x0, #9
	and	x9, x9, #0xfefefefefefefefe
	lsl	x10, x0, #7
	and	x10, x10, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x10
	and	x9, x9, x2
	csel	x9, xzr, x9, ne
	cmp	w1, #0
	csel	x0, x8, x9, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_white_pawn_push_mask           ; -- Begin function white_pawn_push_mask
	.p2align	2
_white_pawn_push_mask:                  ; @white_pawn_push_mask
	.cfi_startproc
; %bb.0:
	lsl	x8, x0, #8
	and	w9, w8, w1
	lsl	w9, w9, #8
	and	x9, x9, #0xff000000
	orr	x8, x9, x8
	and	x0, x8, x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_black_pawn_push_mask           ; -- Begin function black_pawn_push_mask
	.p2align	2
_black_pawn_push_mask:                  ; @black_pawn_push_mask
	.cfi_startproc
; %bb.0:
	lsr	x8, x0, #8
	and	x9, x8, x1
	lsr	x9, x9, #8
	and	x9, x9, #0xff00000000
	orr	x8, x9, x8
	and	x0, x8, x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_knight_attack_mask             ; -- Begin function knight_attack_mask
	.p2align	2
_knight_attack_mask:                    ; @knight_attack_mask
	.cfi_startproc
; %bb.0:
	lsl	x8, x0, #15
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	lsl	x9, x0, #17
	and	x9, x9, #0xfefefefefefefefe
	orr	x8, x8, x9
	lsr	x9, x0, #17
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x9
	lsr	x9, x0, #15
	and	x9, x9, #0xfefefefefefefefe
	orr	x8, x8, x9
	lsl	x9, x0, #6
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	lsl	x9, x0, #10
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	lsr	x9, x0, #10
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	lsr	x9, x0, #6
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	and	x0, x8, x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_king_attack_mask               ; -- Begin function king_attack_mask
	.p2align	2
_king_attack_mask:                      ; @king_attack_mask
	.cfi_startproc
; %bb.0:
	lsr	x8, x0, #1
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	lsl	x9, x0, #1
	and	x9, x9, #0xfefefefefefefefe
	lsl	x10, x0, #7
	and	x10, x10, #0x7f7f7f7f7f7f7f7f
	lsr	x11, x0, #9
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	lsl	x12, x0, #9
	and	x12, x12, #0xfefefefefefefefe
	lsr	x13, x0, #7
	and	x13, x13, #0xfefefefefefefefe
	orr	x8, x9, x8
	orr	x8, x8, x11
	orr	x8, x8, x12
	orr	x8, x8, x10
	orr	x8, x8, x13
	orr	x8, x8, x0, lsr #8
	orr	x8, x8, x0, lsl #8
	and	x0, x8, x1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_north_sliding_mask             ; -- Begin function north_sliding_mask
	.p2align	2
_north_sliding_mask:                    ; @north_sliding_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB15_3
; %bb.1:
	mov	x8, x0
	mov	x0, #0
LBB15_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x1, x8, lsl #8
	orr	x0, x8, x0
	ands	x8, x8, x2
	b.ne	LBB15_2
LBB15_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_south_sliding_mask             ; -- Begin function south_sliding_mask
	.p2align	2
_south_sliding_mask:                    ; @south_sliding_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB16_3
; %bb.1:
	mov	x8, x0
	mov	x0, #0
LBB16_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x1, x8, lsr #8
	orr	x0, x8, x0
	ands	x8, x8, x2
	b.ne	LBB16_2
LBB16_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_west_sliding_mask              ; -- Begin function west_sliding_mask
	.p2align	2
_west_sliding_mask:                     ; @west_sliding_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB17_3
; %bb.1:
	mov	x8, x0
	mov	x0, #0
	and	x9, x1, #0x7f7f7f7f7f7f7f7f
LBB17_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x9, x8, lsr #1
	orr	x0, x8, x0
	ands	x8, x8, x2
	b.ne	LBB17_2
LBB17_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_east_sliding_mask              ; -- Begin function east_sliding_mask
	.p2align	2
_east_sliding_mask:                     ; @east_sliding_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB18_3
; %bb.1:
	mov	x8, x0
	mov	x0, #0
	and	x9, x1, #0xfefefefefefefefe
LBB18_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x9, x8, lsl #1
	orr	x0, x8, x0
	ands	x8, x8, x2
	b.ne	LBB18_2
LBB18_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_ne_sliding_mask                ; -- Begin function ne_sliding_mask
	.p2align	2
_ne_sliding_mask:                       ; @ne_sliding_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB19_3
; %bb.1:
	mov	x8, x0
	mov	x0, #0
	mov	x9, #-72340172838076674
	movk	x9, #65024
	and	x9, x1, x9
LBB19_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x9, x8, lsl #9
	orr	x0, x8, x0
	ands	x8, x8, x2
	b.ne	LBB19_2
LBB19_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_nw_sliding_mask                ; -- Begin function nw_sliding_mask
	.p2align	2
_nw_sliding_mask:                       ; @nw_sliding_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB20_3
; %bb.1:
	mov	x8, x0
	mov	x0, #0
	mov	x9, #9187201950435737471
	movk	x9, #32512
	and	x9, x1, x9
LBB20_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x9, x8, lsl #7
	orr	x0, x8, x0
	ands	x8, x8, x2
	b.ne	LBB20_2
LBB20_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_se_sliding_mask                ; -- Begin function se_sliding_mask
	.p2align	2
_se_sliding_mask:                       ; @se_sliding_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB21_3
; %bb.1:
	mov	x8, x0
	mov	x0, #0
	mov	x9, #-72340172838076674
	movk	x9, #254, lsl #48
	and	x9, x1, x9
LBB21_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x9, x8, lsr #7
	orr	x0, x8, x0
	ands	x8, x8, x2
	b.ne	LBB21_2
LBB21_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_sw_sliding_mask                ; -- Begin function sw_sliding_mask
	.p2align	2
_sw_sliding_mask:                       ; @sw_sliding_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB22_3
; %bb.1:
	mov	x8, x0
	mov	x0, #0
	mov	x9, #9187201950435737471
	movk	x9, #127, lsl #48
	and	x9, x1, x9
LBB22_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x9, x8, lsr #9
	orr	x0, x8, x0
	ands	x8, x8, x2
	b.ne	LBB22_2
LBB22_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_vertical_attack_mask           ; -- Begin function vertical_attack_mask
	.p2align	2
_vertical_attack_mask:                  ; @vertical_attack_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB23_5
; %bb.1:
	mov	x8, #0
	mov	x9, x0
LBB23_2:                                ; =>This Inner Loop Header: Depth=1
	and	x9, x1, x9, lsl #8
	orr	x8, x9, x8
	ands	x9, x9, x2
	b.ne	LBB23_2
LBB23_3:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x1, x0, lsr #8
	orr	x9, x10, x9
	ands	x0, x10, x2
	b.ne	LBB23_3
; %bb.4:
	orr	x0, x9, x8
LBB23_5:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_horizontal_attack_mask         ; -- Begin function horizontal_attack_mask
	.p2align	2
_horizontal_attack_mask:                ; @horizontal_attack_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB24_6
; %bb.1:
	mov	x8, #0
	and	x9, x1, #0x7f7f7f7f7f7f7f7f
	mov	x10, x0
LBB24_2:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x9, x10, lsr #1
	orr	x8, x10, x8
	ands	x10, x10, x2
	b.ne	LBB24_2
; %bb.3:
	mov	x9, #0
	and	x10, x1, #0xfefefefefefefefe
LBB24_4:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x10, x0, lsl #1
	orr	x9, x11, x9
	ands	x0, x11, x2
	b.ne	LBB24_4
; %bb.5:
	orr	x0, x9, x8
LBB24_6:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_sliding_attack_mask            ; -- Begin function sliding_attack_mask
	.p2align	2
_sliding_attack_mask:                   ; @sliding_attack_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB25_10
; %bb.1:
	mov	x9, #0
	mov	x8, x0
LBB25_2:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x1, x8, lsl #8
	orr	x9, x8, x9
	ands	x8, x8, x2
	b.ne	LBB25_2
; %bb.3:
	mov	x10, #0
	mov	x8, x0
LBB25_4:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x1, x8, lsr #8
	orr	x10, x8, x10
	ands	x8, x8, x2
	b.ne	LBB25_4
; %bb.5:
	orr	x9, x10, x9
	and	x10, x1, #0x7f7f7f7f7f7f7f7f
	mov	x11, x0
LBB25_6:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x10, x11, lsr #1
	orr	x8, x11, x8
	ands	x11, x11, x2
	b.ne	LBB25_6
; %bb.7:
	mov	x10, #0
	and	x11, x1, #0xfefefefefefefefe
LBB25_8:                                ; =>This Inner Loop Header: Depth=1
	and	x12, x11, x0, lsl #1
	orr	x10, x12, x10
	ands	x0, x12, x2
	b.ne	LBB25_8
; %bb.9:
	orr	x8, x8, x9
	orr	x0, x8, x10
LBB25_10:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_ascending_attack_mask          ; -- Begin function ascending_attack_mask
	.p2align	2
_ascending_attack_mask:                 ; @ascending_attack_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB26_6
; %bb.1:
	mov	x8, #0
	mov	x9, #-72340172838076674
	movk	x9, #65024
	and	x9, x1, x9
	mov	x10, x0
LBB26_2:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x9, x10, lsl #9
	orr	x8, x10, x8
	ands	x10, x10, x2
	b.ne	LBB26_2
; %bb.3:
	mov	x9, #0
	mov	x10, #9187201950435737471
	movk	x10, #127, lsl #48
	and	x10, x1, x10
LBB26_4:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x10, x0, lsr #9
	orr	x9, x11, x9
	ands	x0, x11, x2
	b.ne	LBB26_4
; %bb.5:
	orr	x0, x9, x8
LBB26_6:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_descending_attack_mask         ; -- Begin function descending_attack_mask
	.p2align	2
_descending_attack_mask:                ; @descending_attack_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB27_6
; %bb.1:
	mov	x8, #0
	mov	x9, #9187201950435737471
	movk	x9, #32512
	and	x9, x1, x9
	mov	x10, x0
LBB27_2:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x9, x10, lsl #7
	orr	x8, x10, x8
	ands	x10, x10, x2
	b.ne	LBB27_2
; %bb.3:
	mov	x9, #0
	mov	x10, #-72340172838076674
	movk	x10, #254, lsl #48
	and	x10, x1, x10
LBB27_4:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x10, x0, lsr #7
	orr	x9, x11, x9
	ands	x0, x11, x2
	b.ne	LBB27_4
; %bb.5:
	orr	x0, x9, x8
LBB27_6:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_diagonal_attack_mask           ; -- Begin function diagonal_attack_mask
	.p2align	2
_diagonal_attack_mask:                  ; @diagonal_attack_mask
	.cfi_startproc
; %bb.0:
	cbz	x0, LBB28_10
; %bb.1:
	mov	x9, #0
	mov	x8, #-72340172838076674
	movk	x8, #65024
	and	x8, x1, x8
	mov	x10, x0
LBB28_2:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x8, x10, lsl #9
	orr	x9, x10, x9
	ands	x10, x10, x2
	b.ne	LBB28_2
; %bb.3:
	mov	x8, #9187201950435737471
	movk	x8, #127, lsl #48
	and	x8, x1, x8
	mov	x11, x0
LBB28_4:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x8, x11, lsr #9
	orr	x10, x11, x10
	ands	x11, x11, x2
	b.ne	LBB28_4
; %bb.5:
	mov	x8, #0
	orr	x9, x10, x9
	mov	x10, #9187201950435737471
	movk	x10, #32512
	and	x10, x1, x10
	mov	x11, x0
LBB28_6:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x10, x11, lsl #7
	orr	x8, x11, x8
	ands	x11, x11, x2
	b.ne	LBB28_6
; %bb.7:
	mov	x10, #0
	mov	x11, #-72340172838076674
	movk	x11, #254, lsl #48
	and	x11, x1, x11
LBB28_8:                                ; =>This Inner Loop Header: Depth=1
	and	x12, x11, x0, lsr #7
	orr	x10, x12, x10
	ands	x0, x12, x2
	b.ne	LBB28_8
; %bb.9:
	orr	x8, x8, x9
	orr	x0, x8, x10
LBB28_10:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_pin_mask_from                  ; -- Begin function pin_mask_from
	.p2align	2
_pin_mask_from:                         ; @pin_mask_from
	.cfi_startproc
; %bb.0:
	and	x8, x1, x0
	tst	x2, x0
	ccmp	x8, #0, #4, ne
	csinv	x0, x0, xzr, ne
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_make_ep_bb                     ; -- Begin function make_ep_bb
	.p2align	2
_make_ep_bb:                            ; @make_ep_bb
	.cfi_startproc
; %bb.0:
	lsl	x8, x0, #55
	mov	w9, #1
	lsl	x9, x9, x0
	and	x0, x9, x8, asr #63
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_make_pinned_mask               ; -- Begin function make_pinned_mask
	.p2align	2
_make_pinned_mask:                      ; @make_pinned_mask
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	cmp	w2, #1
	mov	w9, #56
	mov	w10, #48
	csel	x9, x10, x9, eq
	ldr	x10, [x8, x9]
	ldr	x9, [x8]
	and	x12, x9, x10
	orr	x9, x12, x3
	tst	x9, x1
	b.eq	LBB31_23
; %bb.1:
	cmp	w2, #1
	mov	w9, #48
	mov	w11, #56
	csel	x9, x11, x9, eq
	ldr	x13, [x8, x9]
	ldp	x11, x9, [x8, #16]
	ldp	x14, x8, [x8, #32]
	orr	x9, x14, x9
	orr	x14, x11, x14
	and	x11, x9, x13
	and	x9, x14, x13
	and	x8, x8, x10
	orr	x10, x13, x10
	mvn	x10, x10
	tst	x12, x1
	b.eq	LBB31_12
; %bb.2:
	ldrh	w12, [x0, #10]
	tbz	w12, #8, LBB31_12
; %bb.3:
	lsl	x13, x12, #55
	mov	w14, #1
	lsl	x12, x14, x12
	and	x15, x12, x13, asr #63
	cmp	w2, #1
	lsr	x12, x1, #7
	and	x12, x12, #0xfefefefefefefefe
	lsr	x13, x1, #9
	and	x13, x13, #0x7f7f7f7f7f7f7f7f
	orr	x13, x12, x13
	lsl	x12, x15, #8
	lsl	x14, x1, #9
	and	x14, x14, #0xfefefefefefefefe
	lsl	x16, x1, #7
	and	x16, x16, #0x7f7f7f7f7f7f7f7f
	orr	x14, x14, x16
	lsr	x16, x15, #8
	csel	x12, x12, x16, ne
	csel	x13, x13, x14, ne
	tst	x15, x13
	b.eq	LBB31_12
; %bb.4:
	orr	x13, x10, x1
	orr	x13, x13, x12
	bic	x13, x13, x15
	cbz	x11, LBB31_40
; %bb.5:
	mov	x14, #0
	cbz	x12, LBB31_11
; %bb.6:
	mov	x16, x12
LBB31_7:                                ; =>This Inner Loop Header: Depth=1
	lsr	x16, x16, #1
	and	x16, x16, #0x7f7f7f7f7f7f7f7f
	orr	x14, x16, x14
	ands	x16, x16, x13
	b.ne	LBB31_7
; %bb.8:
	mov	x17, x12
LBB31_9:                                ; =>This Inner Loop Header: Depth=1
	lsl	x17, x17, #1
	and	x17, x17, #0xfefefefefefefefe
	orr	x16, x17, x16
	ands	x17, x17, x13
	b.ne	LBB31_9
; %bb.10:
	orr	x14, x16, x14
LBB31_11:
	and	x16, x14, x11
	tst	x14, x8
	ccmp	x16, #0, #4, ne
	csinv	x14, x14, xzr, ne
	mvn	x15, x15
	cbnz	x9, LBB31_41
	b	LBB31_53
LBB31_12:
	mov	x0, #-1
	cbz	x11, LBB31_26
LBB31_13:
	cbz	x1, LBB31_24
; %bb.14:
	mov	x12, #0
	mov	x13, x1
LBB31_15:                               ; =>This Inner Loop Header: Depth=1
	lsl	x13, x13, #8
	orr	x12, x13, x12
	ands	x13, x13, x10
	b.ne	LBB31_15
; %bb.16:
	mov	x14, #0
	mov	x13, x1
LBB31_17:                               ; =>This Inner Loop Header: Depth=1
	lsr	x13, x13, #8
	orr	x14, x13, x14
	ands	x13, x13, x10
	b.ne	LBB31_17
; %bb.18:
	orr	x12, x14, x12
	and	x14, x12, x11
	tst	x12, x8
	ccmp	x14, #0, #4, ne
	csinv	x12, x12, xzr, ne
	mov	x14, x1
LBB31_19:                               ; =>This Inner Loop Header: Depth=1
	lsr	x14, x14, #1
	and	x14, x14, #0x7f7f7f7f7f7f7f7f
	orr	x13, x14, x13
	ands	x14, x14, x10
	b.ne	LBB31_19
; %bb.20:
	mov	x15, x1
LBB31_21:                               ; =>This Inner Loop Header: Depth=1
	lsl	x15, x15, #1
	and	x15, x15, #0xfefefefefefefefe
	orr	x14, x15, x14
	ands	x15, x15, x10
	b.ne	LBB31_21
; %bb.22:
	orr	x13, x14, x13
	b	LBB31_25
LBB31_23:
	mov	x0, #-1
	ret
LBB31_24:
	mov	x13, #0
	mov	x12, #-1
LBB31_25:
	and	x11, x13, x11
	tst	x13, x8
	ccmp	x11, #0, #4, ne
	csinv	x11, x13, xzr, ne
	and	x11, x12, x11
	and	x0, x11, x0
LBB31_26:
	cbz	x9, LBB31_39
; %bb.27:
	cbz	x1, LBB31_37
; %bb.28:
	mov	x11, #0
	mov	x12, #-72340172838076674
	movk	x12, #65024
	mov	x13, x1
LBB31_29:                               ; =>This Inner Loop Header: Depth=1
	and	x13, x12, x13, lsl #9
	orr	x11, x13, x11
	ands	x13, x13, x10
	b.ne	LBB31_29
; %bb.30:
	mov	x14, #0
	mov	x12, #9187201950435737471
	movk	x12, #127, lsl #48
	mov	x13, x1
LBB31_31:                               ; =>This Inner Loop Header: Depth=1
	and	x13, x12, x13, lsr #9
	orr	x14, x13, x14
	ands	x13, x13, x10
	b.ne	LBB31_31
; %bb.32:
	mov	x12, #0
	mov	x13, #9187201950435737471
	movk	x13, #32512
	orr	x11, x14, x11
	and	x14, x11, x9
	tst	x11, x8
	ccmp	x14, #0, #4, ne
	csinv	x11, x11, xzr, ne
	mov	x14, x1
LBB31_33:                               ; =>This Inner Loop Header: Depth=1
	and	x14, x13, x14, lsl #7
	orr	x12, x14, x12
	ands	x14, x14, x10
	b.ne	LBB31_33
; %bb.34:
	mov	x13, #0
	mov	x14, #-72340172838076674
	movk	x14, #254, lsl #48
LBB31_35:                               ; =>This Inner Loop Header: Depth=1
	and	x15, x14, x1, lsr #7
	orr	x13, x15, x13
	ands	x1, x15, x10
	b.ne	LBB31_35
; %bb.36:
	orr	x10, x13, x12
	b	LBB31_38
LBB31_37:
	mov	x10, #0
	mov	x11, #-1
LBB31_38:
	and	x9, x10, x9
	tst	x10, x8
	ccmp	x9, #0, #4, ne
	csinv	x8, x10, xzr, ne
	and	x8, x11, x8
	and	x0, x8, x0
LBB31_39:
	ret
LBB31_40:
	mov	x14, #-1
	mvn	x15, x15
	cbz	x9, LBB31_53
LBB31_41:
	cbz	x12, LBB31_51
; %bb.42:
	mov	x16, #0
	mov	x17, #-72340172838076674
	movk	x17, #65024
	mov	x0, x12
LBB31_43:                               ; =>This Inner Loop Header: Depth=1
	and	x0, x17, x0, lsl #9
	orr	x16, x0, x16
	ands	x0, x0, x13
	b.ne	LBB31_43
; %bb.44:
	mov	x2, #0
	mov	x17, #9187201950435737471
	movk	x17, #127, lsl #48
	mov	x0, x12
LBB31_45:                               ; =>This Inner Loop Header: Depth=1
	and	x0, x17, x0, lsr #9
	orr	x2, x0, x2
	ands	x0, x0, x13
	b.ne	LBB31_45
; %bb.46:
	mov	x17, #0
	mov	x0, #9187201950435737471
	movk	x0, #32512
	orr	x16, x2, x16
	and	x2, x16, x9
	tst	x16, x8
	ccmp	x2, #0, #4, ne
	csinv	x16, x16, xzr, ne
	mov	x2, x12
LBB31_47:                               ; =>This Inner Loop Header: Depth=1
	and	x2, x0, x2, lsl #7
	orr	x17, x2, x17
	ands	x2, x2, x13
	b.ne	LBB31_47
; %bb.48:
	mov	x0, #0
	mov	x2, #-72340172838076674
	movk	x2, #254, lsl #48
LBB31_49:                               ; =>This Inner Loop Header: Depth=1
	and	x12, x2, x12, lsr #7
	orr	x0, x12, x0
	ands	x12, x12, x13
	b.ne	LBB31_49
; %bb.50:
	orr	x12, x0, x17
	b	LBB31_52
LBB31_51:
	mov	x16, #-1
LBB31_52:
	and	x13, x12, x9
	tst	x12, x8
	ccmp	x13, #0, #4, ne
	csinv	x12, x12, xzr, ne
	and	x12, x16, x12
	and	x14, x12, x14
LBB31_53:
	cmn	x14, #1
	csinv	x0, x15, xzr, ne
	cbnz	x11, LBB31_13
	b	LBB31_26
	.cfi_endproc
                                        ; -- End function
	.globl	_make_attack_mask               ; -- Begin function make_attack_mask
	.p2align	2
_make_attack_mask:                      ; @make_attack_mask
	.cfi_startproc
; %bb.0:
	mov	x8, #-72340172838076674
	movk	x8, #65024
	mov	x10, #9187201950435737471
	movk	x10, #32512
	mov	x9, #-72340172838076674
	movk	x9, #254, lsl #48
	mov	x11, #9187201950435737471
	movk	x11, #127, lsl #48
	ldr	x14, [x0]
	cmp	w1, #1
	mov	w12, #56
	mov	w13, #48
	csel	x15, x12, x13, eq
	ldr	x16, [x14, x15]
	csel	x12, x13, x12, eq
	ldr	x12, [x14, x12]
	ldp	x3, x0, [x14]
	ldp	x17, x13, [x14, #16]
	and	x15, x13, x12
	ldr	x13, [x14, #40]
	bic	x16, x16, x13
	orr	x2, x16, x12
	ands	x16, x3, x12
	b.eq	LBB32_2
; %bb.1:
	and	x3, x9, x16, lsr #7
	and	x4, x11, x16, lsr #9
	orr	x3, x3, x4
	cmp	w1, #1
	and	x4, x8, x16, lsl #9
	and	x16, x10, x16, lsl #7
	orr	x16, x4, x16
	csel	x16, xzr, x16, ne
	cmp	w1, #0
	csel	x16, x3, x16, eq
LBB32_2:
	ldr	x1, [x14, #32]
	and	x17, x17, x12
	and	x0, x0, x12
	mvn	x14, x2
	cbz	x15, LBB32_11
; %bb.3:
	mov	x2, #0
	mov	x3, x15
LBB32_4:                                ; =>This Inner Loop Header: Depth=1
	lsl	x3, x3, #8
	orr	x2, x3, x2
	ands	x3, x3, x14
	b.ne	LBB32_4
; %bb.5:
	mov	x4, x15
LBB32_6:                                ; =>This Inner Loop Header: Depth=1
	lsr	x4, x4, #8
	orr	x3, x4, x3
	ands	x4, x4, x14
	b.ne	LBB32_6
; %bb.7:
	mov	x5, x15
LBB32_8:                                ; =>This Inner Loop Header: Depth=1
	lsr	x5, x5, #1
	and	x5, x5, #0x7f7f7f7f7f7f7f7f
	orr	x4, x5, x4
	ands	x5, x5, x14
	b.ne	LBB32_8
LBB32_9:                                ; =>This Inner Loop Header: Depth=1
	lsl	x15, x15, #1
	and	x15, x15, #0xfefefefefefefefe
	orr	x5, x15, x5
	ands	x15, x15, x14
	b.ne	LBB32_9
; %bb.10:
	orr	x15, x2, x16
	orr	x15, x15, x3
	orr	x15, x15, x4
	orr	x16, x15, x5
LBB32_11:
	and	x15, x1, x12
	lsl	x1, x0, #15
	and	x1, x1, #0x7f7f7f7f7f7f7f7f
	lsl	x2, x0, #17
	and	x2, x2, #0xfefefefefefefefe
	orr	x1, x1, x2
	lsr	x2, x0, #17
	and	x2, x2, #0x7f7f7f7f7f7f7f7f
	orr	x1, x1, x2
	lsr	x2, x0, #15
	and	x2, x2, #0xfefefefefefefefe
	orr	x1, x1, x2
	lsl	x2, x0, #6
	and	x2, x2, #0x3f3f3f3f3f3f3f3f
	orr	x1, x1, x2
	lsl	x2, x0, #10
	and	x2, x2, #0xfcfcfcfcfcfcfcfc
	orr	x1, x1, x2
	lsr	x2, x0, #10
	and	x2, x2, #0x3f3f3f3f3f3f3f3f
	orr	x1, x1, x2
	lsr	x2, x0, #6
	and	x2, x2, #0xfcfcfcfcfcfcfcfc
	orr	x1, x1, x2
	orr	x1, x1, x16
	cmp	x0, #0
	csel	x16, x16, x1, eq
	cbz	x17, LBB32_20
; %bb.12:
	mov	x0, #0
	mov	x1, x17
LBB32_13:                               ; =>This Inner Loop Header: Depth=1
	and	x1, x8, x1, lsl #9
	orr	x0, x1, x0
	ands	x1, x1, x14
	b.ne	LBB32_13
; %bb.14:
	mov	x2, x17
LBB32_15:                               ; =>This Inner Loop Header: Depth=1
	and	x2, x11, x2, lsr #9
	orr	x1, x2, x1
	ands	x2, x2, x14
	b.ne	LBB32_15
; %bb.16:
	mov	x3, x17
LBB32_17:                               ; =>This Inner Loop Header: Depth=1
	and	x3, x10, x3, lsl #7
	orr	x2, x3, x2
	ands	x3, x3, x14
	b.ne	LBB32_17
LBB32_18:                               ; =>This Inner Loop Header: Depth=1
	and	x17, x9, x17, lsr #7
	orr	x3, x17, x3
	ands	x17, x17, x14
	b.ne	LBB32_18
; %bb.19:
	orr	x16, x0, x16
	orr	x16, x16, x1
	orr	x16, x16, x2
	orr	x16, x16, x3
LBB32_20:
	cbz	x15, LBB32_37
; %bb.21:
	mov	x17, #0
	mov	x0, x15
LBB32_22:                               ; =>This Inner Loop Header: Depth=1
	lsl	x0, x0, #8
	orr	x17, x0, x17
	ands	x0, x0, x14
	b.ne	LBB32_22
; %bb.23:
	mov	x1, x15
LBB32_24:                               ; =>This Inner Loop Header: Depth=1
	lsr	x1, x1, #8
	orr	x0, x1, x0
	ands	x1, x1, x14
	b.ne	LBB32_24
; %bb.25:
	mov	x2, x15
LBB32_26:                               ; =>This Inner Loop Header: Depth=1
	lsr	x2, x2, #1
	and	x2, x2, #0x7f7f7f7f7f7f7f7f
	orr	x1, x2, x1
	ands	x2, x2, x14
	b.ne	LBB32_26
; %bb.27:
	mov	x3, x15
LBB32_28:                               ; =>This Inner Loop Header: Depth=1
	lsl	x3, x3, #1
	and	x3, x3, #0xfefefefefefefefe
	orr	x2, x3, x2
	ands	x3, x3, x14
	b.ne	LBB32_28
; %bb.29:
	mov	x4, x15
LBB32_30:                               ; =>This Inner Loop Header: Depth=1
	and	x4, x8, x4, lsl #9
	orr	x3, x4, x3
	ands	x4, x4, x14
	b.ne	LBB32_30
; %bb.31:
	mov	x5, x15
LBB32_32:                               ; =>This Inner Loop Header: Depth=1
	and	x5, x11, x5, lsr #9
	orr	x4, x5, x4
	ands	x5, x5, x14
	b.ne	LBB32_32
; %bb.33:
	mov	x6, x15
LBB32_34:                               ; =>This Inner Loop Header: Depth=1
	and	x6, x10, x6, lsl #7
	orr	x5, x6, x5
	ands	x6, x6, x14
	b.ne	LBB32_34
LBB32_35:                               ; =>This Inner Loop Header: Depth=1
	and	x15, x9, x15, lsr #7
	orr	x6, x15, x6
	ands	x15, x15, x14
	b.ne	LBB32_35
; %bb.36:
	orr	x14, x17, x16
	orr	x14, x14, x0
	orr	x14, x14, x1
	orr	x14, x14, x2
	orr	x14, x14, x3
	orr	x14, x14, x4
	orr	x14, x14, x5
	orr	x16, x14, x6
LBB32_37:
	and	x12, x13, x12
	lsr	x13, x12, #8
	lsr	x14, x12, #1
	and	x14, x14, #0x7f7f7f7f7f7f7f7f
	lsl	x15, x12, #1
	and	x15, x15, #0xfefefefefefefefe
	and	x10, x10, x12, lsl #7
	and	x11, x11, x12, lsr #9
	and	x8, x8, x12, lsl #9
	and	x9, x9, x13, lsl #1
	orr	x14, x14, x15
	orr	x11, x14, x11
	orr	x8, x11, x8
	orr	x8, x8, x10
	orr	x8, x8, x9
	orr	x8, x8, x16
	orr	x8, x8, x13
	orr	x0, x8, x12, lsl #8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_quiescent                   ; -- Begin function is_quiescent
	.p2align	2
_is_quiescent:                          ; @is_quiescent
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
	ldrb	w8, [x0, #8]
	cmp	w8, #1
	cset	w1, ne
	ldr	x19, [x0]
	mov	w8, #56
	mov	w9, #48
	csel	x20, x9, x8, eq
	bl	_make_attack_mask
	ldr	x8, [x19, x20]
	tst	x8, x0
	cset	w0, ne
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count_backwards_pawns          ; -- Begin function count_backwards_pawns
	.p2align	2
_count_backwards_pawns:                 ; @count_backwards_pawns
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ldr	x9, [x8]
	ldp	x10, x8, [x8, #48]
	and	x10, x10, x9
	and	x8, x8, x9
	lsl	x9, x10, #9
	and	x9, x9, #0xfefefefefefefefe
	lsl	x11, x10, #7
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x11
	lsr	x11, x8, #7
	and	x11, x11, #0xfefefefefefefefe
	lsr	x12, x8, #9
	and	x12, x12, #0x7f7f7f7f7f7f7f7f
	orr	x11, x11, x12
	cmp	w1, #1
	lsl	x12, x9, #8
	orr	x13, x11, x10, lsl #8
	lsr	x11, x11, #8
	orr	x9, x9, x8, lsr #8
	csel	x9, x13, x9, ne
	csel	x11, x12, x11, ne
	csel	x8, x8, x10, ne
	bic	x9, x11, x9
	and	x0, x9, x8
	b	_count_bits
	.cfi_endproc
                                        ; -- End function
	.globl	_count_doubled_pawns            ; -- Begin function count_doubled_pawns
	.p2align	2
_count_doubled_pawns:                   ; @count_doubled_pawns
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ldr	x9, [x8]
	cmp	w1, #1
	mov	w10, #56
	mov	w11, #48
	csel	x10, x11, x10, eq
	ldr	x8, [x8, x10]
	and	x8, x8, x9
	neg	x9, x8
	ands	x10, x8, x9
	b.eq	LBB35_8
; %bb.1:
	mov	w9, #0
LBB35_2:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB35_3 Depth 2
                                        ;     Child Loop BB35_5 Depth 2
	mov	x11, #0
	mov	x12, x10
LBB35_3:                                ;   Parent Loop BB35_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x12, x12, #8
	orr	x11, x12, x11
	cbnz	x12, LBB35_3
; %bb.4:                                ;   in Loop: Header=BB35_2 Depth=1
	mov	x13, x10
LBB35_5:                                ;   Parent Loop BB35_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x14, x13, #8
	orr	x12, x14, x12
	cmp	x13, #255
	mov	x13, x14
	b.hi	LBB35_5
; %bb.6:                                ;   in Loop: Header=BB35_2 Depth=1
	eor	x8, x10, x8
	orr	x10, x12, x11
	tst	x10, x8
	cinc	w9, w9, ne
	neg	x10, x8
	ands	x10, x8, x10
	b.ne	LBB35_2
; %bb.7:
	and	w0, w9, #0xff
	ret
LBB35_8:
	and	w0, wzr, #0xff
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count_isolated_pawns           ; -- Begin function count_isolated_pawns
	.p2align	2
_count_isolated_pawns:                  ; @count_isolated_pawns
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ldr	x9, [x8]
	cmp	w1, #1
	mov	w10, #56
	mov	w11, #48
	csel	x10, x11, x10, eq
	ldr	x8, [x8, x10]
	and	x8, x8, x9
	neg	x9, x8
	ands	x10, x8, x9
	b.eq	LBB36_8
; %bb.1:
	mov	w9, #0
	and	x11, x8, #0x7f7f7f7f7f7f7f7f
	and	x12, x8, #0xfefefefefefefefe
LBB36_2:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB36_3 Depth 2
                                        ;     Child Loop BB36_5 Depth 2
	mov	x13, #0
	mov	x14, x10
LBB36_3:                                ;   Parent Loop BB36_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x14, x14, #8
	orr	x13, x14, x13
	cbnz	x14, LBB36_3
; %bb.4:                                ;   in Loop: Header=BB36_2 Depth=1
	mov	x15, x10
LBB36_5:                                ;   Parent Loop BB36_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x16, x15, #8
	orr	x14, x16, x14
	cmp	x15, #255
	mov	x15, x16
	b.hi	LBB36_5
; %bb.6:                                ;   in Loop: Header=BB36_2 Depth=1
	orr	x13, x13, x10
	orr	x13, x13, x14
	tst	x12, x13, lsl #1
	cinc	w14, w9, eq
	tst	x11, x13, lsr #1
	csel	w9, w9, w14, ne
	eor	x8, x10, x8
	neg	x10, x8
	ands	x10, x8, x10
	b.ne	LBB36_2
; %bb.7:
	and	w0, w9, #0xff
	ret
LBB36_8:
	and	w0, wzr, #0xff
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_net_isolated_pawns             ; -- Begin function net_isolated_pawns
	.p2align	2
_net_isolated_pawns:                    ; @net_isolated_pawns
	.cfi_startproc
; %bb.0:
	ldr	x9, [x0]
	ldr	x10, [x9]
	ldr	x8, [x9, #48]
	and	x11, x8, x10
	neg	x8, x11
	ands	x12, x11, x8
	b.eq	LBB37_15
; %bb.1:
	mov	w8, #0
	and	x13, x11, #0x7f7f7f7f7f7f7f7f
	and	x14, x11, #0xfefefefefefefefe
LBB37_2:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB37_3 Depth 2
                                        ;     Child Loop BB37_5 Depth 2
	mov	x15, #0
	mov	x16, x12
LBB37_3:                                ;   Parent Loop BB37_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x16, x16, #8
	orr	x15, x16, x15
	cbnz	x16, LBB37_3
; %bb.4:                                ;   in Loop: Header=BB37_2 Depth=1
	mov	x17, x12
LBB37_5:                                ;   Parent Loop BB37_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x0, x17, #8
	orr	x16, x0, x16
	cmp	x17, #255
	mov	x17, x0
	b.hi	LBB37_5
; %bb.6:                                ;   in Loop: Header=BB37_2 Depth=1
	orr	x15, x15, x12
	orr	x15, x15, x16
	tst	x14, x15, lsl #1
	cinc	w16, w8, eq
	tst	x13, x15, lsr #1
	csel	w8, w8, w16, ne
	eor	x11, x11, x12
	neg	x12, x11
	ands	x12, x11, x12
	b.ne	LBB37_2
; %bb.7:
	ldr	x9, [x9, #56]
	and	x9, x9, x10
	neg	x10, x9
	ands	x11, x9, x10
	b.eq	LBB37_16
LBB37_8:
	mov	w10, #0
	and	x12, x9, #0x7f7f7f7f7f7f7f7f
	and	x13, x9, #0xfefefefefefefefe
LBB37_9:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB37_10 Depth 2
                                        ;     Child Loop BB37_12 Depth 2
	mov	x14, #0
	mov	x15, x11
LBB37_10:                               ;   Parent Loop BB37_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x15, x15, #8
	orr	x14, x15, x14
	cbnz	x15, LBB37_10
; %bb.11:                               ;   in Loop: Header=BB37_9 Depth=1
	mov	x16, x11
LBB37_12:                               ;   Parent Loop BB37_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x17, x16, #8
	orr	x15, x17, x15
	cmp	x16, #255
	mov	x16, x17
	b.hi	LBB37_12
; %bb.13:                               ;   in Loop: Header=BB37_9 Depth=1
	orr	x14, x14, x11
	orr	x14, x14, x15
	tst	x13, x14, lsl #1
	cinc	w15, w10, eq
	tst	x12, x14, lsr #1
	csel	w10, w10, w15, ne
	eor	x9, x9, x11
	neg	x11, x9
	ands	x11, x9, x11
	b.ne	LBB37_9
; %bb.14:
	sub	w8, w8, w10
	sxtb	w0, w8
	ret
LBB37_15:
	mov	w8, #0
	ldr	x9, [x9, #56]
	and	x9, x9, x10
	neg	x10, x9
	ands	x11, x9, x10
	b.ne	LBB37_8
LBB37_16:
	mov	w10, #0
	sub	w8, w8, w10
	sxtb	w0, w8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_net_doubled_pawns              ; -- Begin function net_doubled_pawns
	.p2align	2
_net_doubled_pawns:                     ; @net_doubled_pawns
	.cfi_startproc
; %bb.0:
	ldr	x9, [x0]
	ldr	x10, [x9]
	ldr	x8, [x9, #48]
	and	x11, x8, x10
	neg	x8, x11
	ands	x12, x11, x8
	b.eq	LBB38_15
; %bb.1:
	mov	w8, #0
LBB38_2:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB38_3 Depth 2
                                        ;     Child Loop BB38_5 Depth 2
	mov	x13, #0
	mov	x14, x12
LBB38_3:                                ;   Parent Loop BB38_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x14, x14, #8
	orr	x13, x14, x13
	cbnz	x14, LBB38_3
; %bb.4:                                ;   in Loop: Header=BB38_2 Depth=1
	mov	x15, x12
LBB38_5:                                ;   Parent Loop BB38_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x16, x15, #8
	orr	x14, x16, x14
	cmp	x15, #255
	mov	x15, x16
	b.hi	LBB38_5
; %bb.6:                                ;   in Loop: Header=BB38_2 Depth=1
	eor	x11, x11, x12
	orr	x12, x14, x13
	tst	x12, x11
	cinc	w8, w8, ne
	neg	x12, x11
	ands	x12, x11, x12
	b.ne	LBB38_2
; %bb.7:
	ldr	x9, [x9, #56]
	and	x9, x9, x10
	neg	x10, x9
	ands	x11, x9, x10
	b.eq	LBB38_16
LBB38_8:
	mov	w10, #0
LBB38_9:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB38_10 Depth 2
                                        ;     Child Loop BB38_12 Depth 2
	mov	x12, #0
	mov	x13, x11
LBB38_10:                               ;   Parent Loop BB38_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x13, x13, #8
	orr	x12, x13, x12
	cbnz	x13, LBB38_10
; %bb.11:                               ;   in Loop: Header=BB38_9 Depth=1
	mov	x14, x11
LBB38_12:                               ;   Parent Loop BB38_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x15, x14, #8
	orr	x13, x15, x13
	cmp	x14, #255
	mov	x14, x15
	b.hi	LBB38_12
; %bb.13:                               ;   in Loop: Header=BB38_9 Depth=1
	eor	x9, x9, x11
	orr	x11, x13, x12
	tst	x11, x9
	cinc	w10, w10, ne
	neg	x11, x9
	ands	x11, x9, x11
	b.ne	LBB38_9
; %bb.14:
	sub	w8, w8, w10
	sxtb	w0, w8
	ret
LBB38_15:
	mov	w8, #0
	ldr	x9, [x9, #56]
	and	x9, x9, x10
	neg	x10, x9
	ands	x11, x9, x10
	b.ne	LBB38_8
LBB38_16:
	mov	w10, #0
	sub	w8, w8, w10
	sxtb	w0, w8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_net_backwards_pawns            ; -- Begin function net_backwards_pawns
	.p2align	2
_net_backwards_pawns:                   ; @net_backwards_pawns
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
	ldr	x8, [x0]
	ldr	x9, [x8]
	ldp	x10, x8, [x8, #48]
	and	x10, x10, x9
	and	x8, x8, x9
	lsl	x9, x10, #9
	and	x9, x9, #0xfefefefefefefefe
	lsl	x11, x10, #7
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x11
	lsr	x11, x8, #7
	and	x11, x11, #0xfefefefefefefefe
	lsr	x12, x8, #9
	and	x12, x12, #0x7f7f7f7f7f7f7f7f
	orr	x11, x11, x12
	lsr	x12, x11, #8
	orr	x13, x9, x8, lsr #8
	bic	x12, x12, x13
	and	x0, x12, x10
	lsl	x9, x9, #8
	orr	x10, x11, x10, lsl #8
	bic	x9, x9, x10
	and	x19, x9, x8
	bl	_count_bits
	mov	x20, x0
	mov	x0, x19
	bl	_count_bits
	sub	w8, w20, w0
	sxtb	w0, w8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_non_check_info                 ; -- Begin function non_check_info
	.p2align	2
_non_check_info:                        ; @non_check_info
	.cfi_startproc
; %bb.0:
	mov	x9, #-1
	stp	x9, x9, [x8]
	strb	wzr, [x8, #16]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_in_check_with_attacker_mask    ; -- Begin function in_check_with_attacker_mask
	.p2align	2
_in_check_with_attacker_mask:           ; @in_check_with_attacker_mask
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0, #40]
	cmp	w1, #1
	mov	w9, #56
	mov	w10, #48
	csel	x9, x10, x9, eq
	ldr	x9, [x0, x9]
	and	x8, x8, x9
	tst	x8, x2
	cset	w0, ne
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_update_info                    ; -- Begin function update_info
	.p2align	2
_update_info:                           ; @update_info
	.cfi_startproc
; %bb.0:
	tst	x2, x1
	b.eq	LBB42_3
; %bb.1:
	ldrb	w9, [x0, #16]
	add	w9, w9, #1
	and	w10, w9, #0xff
	strb	w9, [x0, #16]
	cmp	w10, #2
	b.lo	LBB42_4
; %bb.2:
	stp	xzr, xzr, [x0]
LBB42_3:
	ldr	q0, [x0]
	str	q0, [x8]
	ldr	x9, [x0, #16]
	str	x9, [x8, #16]
	ret
LBB42_4:
	stp	x1, x1, [x0]
	ldr	q0, [x0]
	str	q0, [x8]
	ldr	x9, [x0, #16]
	str	x9, [x8, #16]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_make_check_info                ; -- Begin function make_check_info
	.p2align	2
_make_check_info:                       ; @make_check_info
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	ldr	x9, [x0]
	cmp	w1, #1
	mov	w10, #48
	mov	w11, #56
	csel	x12, x11, x10, eq
	csel	x10, x10, x11, eq
	ldr	x15, [x9, x10]
	ldr	x3, [x9, x12]
	ldr	x10, [x9, #40]
	mov	x11, #-1
	stp	x11, x11, [x8]
	strb	wzr, [x8, #16]
	and	x11, x15, x2
	tst	x11, x10
	b.eq	LBB43_34
; %bb.1:
	and	x11, x10, x15
	ldp	x10, x12, [x9]
	and	x14, x12, x3
	ldp	x12, x13, [x9, #16]
	ldr	x9, [x9, #32]
	orr	x13, x9, x13
	and	x16, x13, x3
	orr	x13, x9, x12
	mvn	x12, x15
	mov	w9, #1
	ands	x10, x10, x3
	b.eq	LBB43_35
; %bb.2:
	and	x17, x12, x11, lsl #9
	and	x17, x17, #0xfefefefefefefefe
	tst	x10, x17
	cset	w2, ne
	csinv	x17, x17, xzr, ne
	and	x4, x12, x11, lsl #7
	and	x4, x4, #0x7f7f7f7f7f7f7f7f
	cinc	w5, w9, ne
	csel	x6, x4, xzr, eq
	tst	x10, x4
	csel	w2, w2, w5, eq
	csel	x17, x17, x6, eq
	and	x4, x12, x11, lsr #7
	and	x4, x4, #0xfefefefefefefefe
	tst	x10, x4
	cset	w5, ne
	csinv	x4, x4, xzr, ne
	and	x6, x12, x11, lsr #9
	and	x6, x6, #0x7f7f7f7f7f7f7f7f
	cinc	w7, w9, ne
	csel	x19, x6, xzr, eq
	tst	x10, x6
	csel	w5, w5, w7, eq
	csel	x4, x4, x19, eq
	cmp	w1, #0
	csel	w1, w2, w5, ne
	csel	x17, x17, x4, ne
	stp	x17, x17, [x8]
	strb	w1, [x8, #16]
	and	x13, x13, x3
	orr	x15, x3, x15
	cbz	x14, LBB43_4
LBB43_3:
	lsl	x2, x11, #15
	and	x2, x2, #0x7f7f7f7f7f7f7f7f
	tst	w1, #0xff
	csel	x3, x2, xzr, eq
	tst	x14, x2
	cinc	w1, w1, ne
	csel	x17, x17, x3, eq
	lsl	x2, x11, #17
	and	x2, x2, #0xfefefefefefefefe
	tst	w1, #0xff
	csel	x3, x2, xzr, eq
	tst	x14, x2
	cinc	w1, w1, ne
	csel	x17, x17, x3, eq
	lsr	x2, x11, #17
	and	x2, x2, #0x7f7f7f7f7f7f7f7f
	tst	w1, #0xff
	csel	x3, x2, xzr, eq
	tst	x14, x2
	cinc	w1, w1, ne
	csel	x17, x17, x3, eq
	lsr	x2, x11, #15
	and	x2, x2, #0xfefefefefefefefe
	tst	w1, #0xff
	csel	x3, x2, xzr, eq
	tst	x14, x2
	cinc	w1, w1, ne
	csel	x17, x17, x3, eq
	lsl	x2, x11, #6
	and	x2, x2, #0x3f3f3f3f3f3f3f3f
	tst	w1, #0xff
	csel	x3, x2, xzr, eq
	tst	x14, x2
	cinc	w1, w1, ne
	csel	x17, x17, x3, eq
	lsl	x2, x11, #10
	and	x2, x2, #0xfcfcfcfcfcfcfcfc
	tst	w1, #0xff
	csel	x3, x2, xzr, eq
	tst	x14, x2
	cinc	w1, w1, ne
	csel	x17, x17, x3, eq
	lsr	x2, x11, #10
	and	x2, x2, #0x3f3f3f3f3f3f3f3f
	tst	w1, #0xff
	csel	x3, x2, xzr, eq
	tst	x14, x2
	csel	x17, x17, x3, eq
	cinc	w1, w1, ne
	lsr	x2, x11, #6
	and	x2, x2, #0xfcfcfcfcfcfcfcfc
	tst	w1, #0xff
	csel	x3, x2, xzr, eq
	tst	x14, x2
	csel	x17, x17, x3, eq
	cinc	w1, w1, ne
	stp	x17, x17, [x8]
	strb	w1, [x8, #16]
LBB43_4:
	ldrh	w14, [x0, #10]
	mvn	x15, x15
	cbz	x16, LBB43_18
; %bb.5:
	mov	x0, #0
	cbz	x11, LBB43_8
; %bb.6:
	mov	x2, x11
LBB43_7:                                ; =>This Inner Loop Header: Depth=1
	lsl	x2, x2, #8
	and	x3, x2, x12
	orr	x0, x3, x0
	ands	x2, x2, x15
	b.ne	LBB43_7
LBB43_8:
	add	w2, w1, #1
	and	w2, w2, #0xff
	cmp	w2, #1
	csel	x2, xzr, x0, hi
	tst	x0, x16
	csel	x17, x17, x2, eq
	cinc	w0, w1, ne
	stp	x17, x17, [x8]
	strb	w0, [x8, #16]
	mov	x1, #0
	cbz	x11, LBB43_11
; %bb.9:
	mov	x2, x11
LBB43_10:                               ; =>This Inner Loop Header: Depth=1
	lsr	x2, x2, #8
	and	x3, x2, x12
	orr	x1, x3, x1
	ands	x2, x2, x15
	b.ne	LBB43_10
LBB43_11:
	add	w2, w0, #1
	and	w2, w2, #0xff
	cmp	w2, #1
	csel	x2, xzr, x1, hi
	tst	x1, x16
	csel	x17, x17, x2, eq
	cinc	w0, w0, ne
	mov	x1, #0
	cbz	x11, LBB43_14
; %bb.12:
	and	x2, x12, #0xfefefefefefefefe
	mov	x3, x11
LBB43_13:                               ; =>This Inner Loop Header: Depth=1
	and	x3, x2, x3, lsl #1
	orr	x1, x3, x1
	ands	x3, x3, x15
	b.ne	LBB43_13
LBB43_14:
	add	w2, w0, #1
	and	w2, w2, #0xff
	cmp	w2, #1
	csel	x2, xzr, x1, hi
	tst	x1, x16
	csel	x17, x17, x2, eq
	cinc	w0, w0, ne
	mov	x1, #0
	cbz	x11, LBB43_17
; %bb.15:
	and	x2, x12, #0x7f7f7f7f7f7f7f7f
	mov	x3, x11
LBB43_16:                               ; =>This Inner Loop Header: Depth=1
	and	x3, x2, x3, lsr #1
	orr	x1, x3, x1
	ands	x3, x3, x15
	b.ne	LBB43_16
LBB43_17:
	add	w2, w0, #1
	and	w2, w2, #0xff
	cmp	w2, #1
	csel	x2, xzr, x1, hi
	tst	x1, x16
	csel	x17, x17, x2, eq
	cinc	w1, w0, ne
	stp	x17, x17, [x8]
	strb	w1, [x8, #16]
LBB43_18:
	cbz	x13, LBB43_32
; %bb.19:
	mov	x16, #0
	cbz	x11, LBB43_22
; %bb.20:
	mov	x0, #-72340172838076674
	movk	x0, #65024
	and	x0, x12, x0
	mov	x2, x11
LBB43_21:                               ; =>This Inner Loop Header: Depth=1
	and	x2, x0, x2, lsl #9
	orr	x16, x2, x16
	ands	x2, x2, x15
	b.ne	LBB43_21
LBB43_22:
	add	w0, w1, #1
	and	w0, w0, #0xff
	cmp	w0, #1
	csel	x0, xzr, x16, hi
	tst	x16, x13
	csel	x16, x17, x0, eq
	cinc	w17, w1, ne
	stp	x16, x16, [x8]
	strb	w17, [x8, #16]
	mov	x0, #0
	cbz	x11, LBB43_25
; %bb.23:
	mov	x1, #9187201950435737471
	movk	x1, #32512
	and	x1, x12, x1
	mov	x2, x11
LBB43_24:                               ; =>This Inner Loop Header: Depth=1
	and	x2, x1, x2, lsl #7
	orr	x0, x2, x0
	ands	x2, x2, x15
	b.ne	LBB43_24
LBB43_25:
	add	w1, w17, #1
	and	w1, w1, #0xff
	cmp	w1, #1
	csel	x1, xzr, x0, hi
	tst	x0, x13
	csel	x16, x16, x1, eq
	cinc	w17, w17, ne
	mov	x0, #0
	cbz	x11, LBB43_28
; %bb.26:
	mov	x1, #-72340172838076674
	movk	x1, #254, lsl #48
	and	x1, x12, x1
	mov	x2, x11
LBB43_27:                               ; =>This Inner Loop Header: Depth=1
	and	x2, x1, x2, lsr #7
	orr	x0, x2, x0
	ands	x2, x2, x15
	b.ne	LBB43_27
LBB43_28:
	add	w1, w17, #1
	and	w1, w1, #0xff
	cmp	w1, #1
	csel	x1, xzr, x0, hi
	tst	x0, x13
	csel	x0, x16, x1, eq
	cinc	w16, w17, ne
	mov	x17, #0
	cbz	x11, LBB43_31
; %bb.29:
	mov	x1, #9187201950435737471
	movk	x1, #127, lsl #48
	and	x12, x12, x1
LBB43_30:                               ; =>This Inner Loop Header: Depth=1
	and	x11, x12, x11, lsr #9
	orr	x17, x11, x17
	ands	x11, x11, x15
	b.ne	LBB43_30
LBB43_31:
	add	w11, w16, #1
	and	w11, w11, #0xff
	cmp	w11, #1
	csel	x11, xzr, x17, hi
	tst	x17, x13
	csel	x17, x0, x11, eq
	cinc	w11, w16, ne
	stp	x17, x17, [x8]
	strb	w11, [x8, #16]
LBB43_32:
	cbz	x10, LBB43_34
; %bb.33:
	lsl	x10, x14, #55
	lsl	x9, x9, x14
	and	x9, x9, x10, asr #63
	orr	x9, x17, x9
	str	x9, [x8, #8]
LBB43_34:
	ldp	x20, x19, [sp], #16             ; 16-byte Folded Reload
	ret
LBB43_35:
	mov	w1, #0
	mov	x17, #-1
	and	x13, x13, x3
	orr	x15, x3, x15
	cbnz	x14, LBB43_3
	b	LBB43_4
	.cfi_endproc
                                        ; -- End function
	.globl	_kingside_castling_mask         ; -- Begin function kingside_castling_mask
	.p2align	2
_kingside_castling_mask:                ; @kingside_castling_mask
	.cfi_startproc
; %bb.0:
	lsl	x8, x0, #1
	and	x8, x8, #0xfefefefefefefefe
	lsl	x9, x0, #2
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	orn	x10, x1, x2
	tst	x8, x10
	csel	x0, x9, xzr, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_queenside_castling_mask        ; -- Begin function queenside_castling_mask
	.p2align	2
_queenside_castling_mask:               ; @queenside_castling_mask
	.cfi_startproc
; %bb.0:
	lsr	x8, x0, #1
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	lsr	x9, x0, #2
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	lsr	x10, x0, #3
	bic	x10, x10, x2
	orr	x8, x8, x9
	orn	x11, x1, x2
	and	x8, x8, x11
	and	x10, x10, #0x1f1f1f1f1f1f1f1f
	orr	x8, x8, x10
	cmp	x8, #0
	csel	x0, x9, xzr, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count_moves                    ; -- Begin function count_moves
	.p2align	2
_count_moves:                           ; @count_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #240
	.cfi_def_cfa_offset 240
	stp	x28, x27, [sp, #144]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #160]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #176]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #192]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #208]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #224]            ; 16-byte Folded Spill
	add	x29, sp, #224
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
	mov	x20, x3
	stur	x2, [x29, #-104]                ; 8-byte Folded Spill
	ldr	x8, [x0]
	stur	w1, [x29, #-108]                ; 4-byte Folded Spill
	cmp	w1, #1
	b.ne	LBB46_4
; %bb.1:
	ldr	x10, [x8]
	ldp	x24, x9, [x8, #48]
	and	x10, x10, x24
	str	x10, [sp, #80]                  ; 8-byte Folded Spill
	ldrb	w11, [x0, #9]
	ubfx	w10, w11, #1, #1
	tbz	w11, #0, LBB46_5
LBB46_2:
	ldrb	w11, [x20, #16]
	cmp	w11, #0
	cset	w12, eq
	stur	w12, [x29, #-84]                ; 4-byte Folded Spill
	tbnz	w10, #0, LBB46_7
; %bb.3:
	stur	wzr, [x29, #-88]                ; 4-byte Folded Spill
	neg	x10, x24
	mov	w28, #0
	ands	x23, x24, x10
	b.ne	LBB46_9
	b	LBB46_62
LBB46_4:
	str	xzr, [sp, #80]                  ; 8-byte Folded Spill
	ldrb	w11, [x0, #9]
	ubfx	w10, w11, #3, #1
	ldp	x9, x24, [x8, #48]
	tbnz	w11, #2, LBB46_2
LBB46_5:
	cbz	w10, LBB46_8
; %bb.6:
	stur	wzr, [x29, #-84]                ; 4-byte Folded Spill
	ldrb	w11, [x20, #16]
LBB46_7:
	cmp	w11, #0
	cset	w10, eq
	stur	w10, [x29, #-88]                ; 4-byte Folded Spill
	neg	x10, x24
	mov	w28, #0
	ands	x23, x24, x10
	b.ne	LBB46_9
	b	LBB46_62
LBB46_8:
	stur	xzr, [x29, #-88]                ; 8-byte Folded Spill
	neg	x10, x24
	mov	w28, #0
	ands	x23, x24, x10
	b.eq	LBB46_62
LBB46_9:
	str	x0, [sp, #104]                  ; 8-byte Folded Spill
	ldrh	w10, [x0, #10]
	lsl	x11, x10, #55
	mov	w12, #1
	lsl	x10, x12, x10
	and	x10, x10, x11, asr #63
	orr	x11, x9, x24
	mvn	x25, x11
	orr	x9, x10, x9
	str	x9, [sp, #64]                   ; 8-byte Folded Spill
	mvn	x21, x24
	mov	x17, #-72340172838076674
	movk	x17, #65024
	mov	x0, #9187201950435737471
	movk	x0, #32512
	mov	x1, #-72340172838076674
	movk	x1, #254, lsl #48
	mov	x2, #9187201950435737471
	movk	x2, #127, lsl #48
	ldp	x10, x9, [x8, #32]
	ldp	x13, x12, [x8, #16]
	ldp	x8, x14, [x8]
	ldur	x16, [x29, #-104]               ; 8-byte Folded Reload
	orr	x15, x24, x16
	mvn	x15, x15
	stur	x15, [x29, #-96]                ; 8-byte Folded Spill
	orr	x22, x11, x16
	and	x11, x11, #0x1f1f1f1f1f1f1f1f
	str	x11, [sp, #88]                  ; 8-byte Folded Spill
	and	x19, x21, #0x7f7f7f7f7f7f7f7f
	and	x26, x21, #0xfefefefefefefefe
	and	x11, x21, x17
	str	x11, [sp, #40]                  ; 8-byte Folded Spill
	and	x11, x21, x2
	str	x11, [sp, #32]                  ; 8-byte Folded Spill
	and	x11, x21, x0
	str	x11, [sp, #24]                  ; 8-byte Folded Spill
	and	x11, x21, x1
	and	x27, x24, x9
	and	x8, x24, x8
	str	x8, [sp, #96]                   ; 8-byte Folded Spill
	and	x8, x24, x14
	str	x8, [sp, #56]                   ; 8-byte Folded Spill
	and	x8, x24, x12
	str	x8, [sp, #48]                   ; 8-byte Folded Spill
	and	x8, x24, x13
	stp	x8, x11, [sp, #8]               ; 16-byte Folded Spill
	and	x8, x24, x10
	str	x8, [sp]                        ; 8-byte Folded Spill
	str	x20, [sp, #72]                  ; 8-byte Folded Spill
	b	LBB46_15
LBB46_10:                               ;   in Loop: Header=BB46_15 Depth=1
	ldr	x9, [sp, #56]                   ; 8-byte Folded Reload
	tst	x9, x23
	b.eq	LBB46_25
; %bb.11:                               ;   in Loop: Header=BB46_15 Depth=1
	lsl	x9, x23, #15
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	lsl	x10, x23, #17
	and	x10, x10, #0xfefefefefefefefe
	orr	x9, x9, x10
	lsr	x10, x23, #17
	and	x10, x10, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x10
	lsr	x10, x23, #15
	and	x10, x10, #0xfefefefefefefefe
	orr	x9, x9, x10
	lsl	x10, x23, #6
	and	x10, x10, #0x3f3f3f3f3f3f3f3f
	orr	x9, x9, x10
	lsl	x10, x23, #10
	and	x10, x10, #0xfcfcfcfcfcfcfcfc
	orr	x9, x9, x10
	lsr	x10, x23, #10
	and	x10, x10, #0x3f3f3f3f3f3f3f3f
	orr	x9, x9, x10
	lsr	x10, x23, #6
	and	x10, x10, #0xfcfcfcfcfcfcfcfc
	orr	x9, x9, x10
	and	x9, x9, x21
LBB46_12:                               ;   in Loop: Header=BB46_15 Depth=1
	and	x0, x9, x8
LBB46_13:                               ;   in Loop: Header=BB46_15 Depth=1
	bl	_count_bits
	add	w28, w0, w28
LBB46_14:                               ;   in Loop: Header=BB46_15 Depth=1
	eor	x24, x23, x24
	neg	x8, x24
	ands	x23, x24, x8
	b.eq	LBB46_62
LBB46_15:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB46_27 Depth 2
                                        ;     Child Loop BB46_29 Depth 2
                                        ;     Child Loop BB46_31 Depth 2
                                        ;     Child Loop BB46_33 Depth 2
                                        ;     Child Loop BB46_36 Depth 2
                                        ;     Child Loop BB46_38 Depth 2
                                        ;     Child Loop BB46_40 Depth 2
                                        ;     Child Loop BB46_42 Depth 2
                                        ;     Child Loop BB46_46 Depth 2
                                        ;     Child Loop BB46_48 Depth 2
                                        ;     Child Loop BB46_50 Depth 2
                                        ;     Child Loop BB46_52 Depth 2
                                        ;     Child Loop BB46_54 Depth 2
                                        ;     Child Loop BB46_56 Depth 2
                                        ;     Child Loop BB46_58 Depth 2
                                        ;     Child Loop BB46_60 Depth 2
	tst	x27, x23
	b.eq	LBB46_20
; %bb.16:                               ;   in Loop: Header=BB46_15 Depth=1
	lsr	x10, x23, #8
	lsr	x8, x23, #1
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	lsl	x9, x23, #1
	and	x9, x9, #0xfefefefefefefefe
	mov	x11, #9187201950435737471
	movk	x11, #32512
	and	x11, x11, x23, lsl #7
	mov	x12, #9187201950435737471
	movk	x12, #127, lsl #48
	and	x12, x12, x23, lsr #9
	mov	x13, #-72340172838076674
	movk	x13, #65024
	and	x13, x13, x23, lsl #9
	mov	x14, #-72340172838076674
	movk	x14, #254, lsl #48
	and	x14, x14, x10, lsl #1
	orr	x12, x13, x12
	orr	x11, x12, x11
	orr	x11, x11, x14
	orr	x10, x11, x10
	orr	x10, x10, x23, lsl #8
	orr	x10, x10, x8
	orr	x10, x10, x9
	ldur	x11, [x29, #-96]                ; 8-byte Folded Reload
	and	x0, x10, x11
	ldur	w10, [x29, #-84]                ; 4-byte Folded Reload
	cbz	w10, LBB46_18
; %bb.17:                               ;   in Loop: Header=BB46_15 Depth=1
	lsl	x10, x23, #2
	and	x10, x10, #0xfcfcfcfcfcfcfcfc
	orr	x9, x9, x10
	tst	x9, x22
	csel	x9, x10, xzr, eq
	orr	x0, x0, x9
LBB46_18:                               ;   in Loop: Header=BB46_15 Depth=1
	ldur	w9, [x29, #-88]                 ; 4-byte Folded Reload
	cbz	w9, LBB46_13
; %bb.19:                               ;   in Loop: Header=BB46_15 Depth=1
	lsr	x9, x23, #2
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	and	x8, x8, x22
	ldr	x10, [sp, #88]                  ; 8-byte Folded Reload
	and	x10, x10, x23, lsr #3
	orr	x8, x8, x10
	cmp	x8, #0
	csel	x8, x9, xzr, eq
	orr	x0, x0, x8
	b	LBB46_13
LBB46_20:                               ;   in Loop: Header=BB46_15 Depth=1
	ldr	x0, [sp, #104]                  ; 8-byte Folded Reload
	mov	x1, x23
	ldur	w2, [x29, #-108]                ; 4-byte Folded Reload
	ldur	x3, [x29, #-104]                ; 8-byte Folded Reload
	bl	_make_pinned_mask
	ldr	x8, [x20]
	and	x8, x8, x0
	ldr	x9, [sp, #96]                   ; 8-byte Folded Reload
	tst	x9, x23
	b.eq	LBB46_10
; %bb.21:                               ;   in Loop: Header=BB46_15 Depth=1
	ldr	x9, [x20, #8]
	ldr	x10, [sp, #80]                  ; 8-byte Folded Reload
	tst	x23, x10
	b.eq	LBB46_23
; %bb.22:                               ;   in Loop: Header=BB46_15 Depth=1
	lsl	x10, x23, #8
	and	w11, w10, w25
	lsl	w11, w11, #8
	and	x11, x11, #0xff000000
	orr	x10, x11, x10
	and	x10, x10, x25
	and	x8, x10, x8
	mov	x10, #-72340172838076674
	movk	x10, #65024
	and	x10, x10, x23, lsl #9
	mov	x11, #9187201950435737471
	movk	x11, #32512
	and	x11, x11, x23, lsl #7
	orr	x10, x10, x11
	and	x9, x10, x9
	ldr	x10, [sp, #64]                  ; 8-byte Folded Reload
	and	x9, x9, x10
	orr	x8, x9, x8
	and	x0, x8, x0
	and	x20, x23, #0xff000000000000
	b	LBB46_24
LBB46_23:                               ;   in Loop: Header=BB46_15 Depth=1
	lsr	x10, x23, #8
	and	x11, x10, x25
	lsr	x11, x11, #8
	and	x11, x11, #0xff00000000
	orr	x10, x11, x10
	and	x10, x10, x25
	and	x8, x10, x8
	mov	x10, #-72340172838076674
	movk	x10, #254, lsl #48
	and	x10, x10, x23, lsr #7
	mov	x11, #9187201950435737471
	movk	x11, #127, lsl #48
	and	x11, x11, x23, lsr #9
	orr	x10, x10, x11
	and	x9, x10, x9
	ldr	x10, [sp, #64]                  ; 8-byte Folded Reload
	and	x9, x9, x10
	orr	x8, x9, x8
	and	x0, x8, x0
	and	x20, x23, #0xff00
LBB46_24:                               ;   in Loop: Header=BB46_15 Depth=1
	bl	_count_bits
	add	w8, w0, w28
	add	w9, w28, w0, lsl #2
	cmp	x20, #0
	ldr	x20, [sp, #72]                  ; 8-byte Folded Reload
	csel	w28, w8, w9, eq
	b	LBB46_14
LBB46_25:                               ;   in Loop: Header=BB46_15 Depth=1
	ldr	x9, [sp, #48]                   ; 8-byte Folded Reload
	tst	x9, x23
	b.eq	LBB46_34
; %bb.26:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x9, #0
	mov	x10, x23
LBB46_27:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x10, x10, #8
	and	x11, x10, x21
	orr	x9, x11, x9
	ands	x10, x10, x25
	b.ne	LBB46_27
; %bb.28:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x11, x23
LBB46_29:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x11, x11, #8
	and	x12, x11, x21
	orr	x10, x12, x10
	ands	x11, x11, x25
	b.ne	LBB46_29
; %bb.30:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x12, x23
LBB46_31:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x12, x19, x12, lsr #1
	orr	x11, x12, x11
	ands	x12, x12, x25
	b.ne	LBB46_31
; %bb.32:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x13, x23
LBB46_33:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x13, x26, x13, lsl #1
	orr	x12, x13, x12
	ands	x13, x13, x25
	b.ne	LBB46_33
	b	LBB46_43
LBB46_34:                               ;   in Loop: Header=BB46_15 Depth=1
	ldr	x9, [sp, #8]                    ; 8-byte Folded Reload
	tst	x9, x23
	b.eq	LBB46_44
; %bb.35:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x9, #0
	mov	x10, x23
	ldp	x12, x11, [sp, #32]             ; 16-byte Folded Reload
	ldp	x14, x13, [sp, #16]             ; 16-byte Folded Reload
LBB46_36:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x10, x11, x10, lsl #9
	orr	x9, x10, x9
	ands	x10, x10, x25
	b.ne	LBB46_36
; %bb.37:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x11, x23
LBB46_38:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x12, x11, lsr #9
	orr	x10, x11, x10
	ands	x11, x11, x25
	b.ne	LBB46_38
; %bb.39:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x12, x23
LBB46_40:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x12, x13, x12, lsl #7
	orr	x11, x12, x11
	ands	x12, x12, x25
	b.ne	LBB46_40
; %bb.41:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x13, x23
LBB46_42:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x13, x14, x13, lsr #7
	orr	x12, x13, x12
	ands	x13, x13, x25
	b.ne	LBB46_42
LBB46_43:                               ;   in Loop: Header=BB46_15 Depth=1
	orr	x9, x10, x9
	orr	x9, x9, x11
	orr	x9, x9, x12
	b	LBB46_12
LBB46_44:                               ;   in Loop: Header=BB46_15 Depth=1
	ldr	x9, [sp]                        ; 8-byte Folded Reload
	tst	x9, x23
	ldp	x12, x11, [sp, #32]             ; 16-byte Folded Reload
	ldp	x14, x13, [sp, #16]             ; 16-byte Folded Reload
	b.eq	LBB46_14
; %bb.45:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x9, #0
	mov	x10, x23
LBB46_46:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x10, x11, x10, lsl #9
	orr	x9, x10, x9
	ands	x10, x10, x25
	b.ne	LBB46_46
; %bb.47:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x11, x23
LBB46_48:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x12, x11, lsr #9
	orr	x10, x11, x10
	ands	x11, x11, x25
	b.ne	LBB46_48
; %bb.49:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x12, x23
LBB46_50:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x12, x13, x12, lsl #7
	orr	x11, x12, x11
	ands	x12, x12, x25
	b.ne	LBB46_50
; %bb.51:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x13, x23
LBB46_52:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x13, x14, x13, lsr #7
	orr	x12, x13, x12
	ands	x13, x13, x25
	b.ne	LBB46_52
; %bb.53:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x14, x23
LBB46_54:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x14, x14, #8
	and	x15, x14, x21
	orr	x13, x15, x13
	ands	x14, x14, x25
	b.ne	LBB46_54
; %bb.55:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x15, x23
LBB46_56:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x15, x15, #8
	and	x16, x15, x21
	orr	x14, x16, x14
	ands	x15, x15, x25
	b.ne	LBB46_56
; %bb.57:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x16, x23
LBB46_58:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x16, x19, x16, lsr #1
	orr	x15, x16, x15
	ands	x16, x16, x25
	b.ne	LBB46_58
; %bb.59:                               ;   in Loop: Header=BB46_15 Depth=1
	mov	x17, x23
LBB46_60:                               ;   Parent Loop BB46_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x17, x26, x17, lsl #1
	orr	x16, x17, x16
	ands	x17, x17, x25
	b.ne	LBB46_60
; %bb.61:                               ;   in Loop: Header=BB46_15 Depth=1
	orr	x9, x10, x9
	orr	x9, x9, x11
	orr	x9, x9, x12
	orr	x9, x9, x13
	orr	x9, x9, x14
	orr	x9, x9, x15
	orr	x9, x9, x16
	b	LBB46_12
LBB46_62:
	and	w0, w28, #0xff
	ldp	x29, x30, [sp, #224]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #208]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #192]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #176]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #160]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #144]            ; 16-byte Folded Reload
	add	sp, sp, #240
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_inner_knight_dest_bb           ; -- Begin function inner_knight_dest_bb
	.p2align	2
_inner_knight_dest_bb:                  ; @inner_knight_dest_bb
	.cfi_startproc
; %bb.0:
	lsl	x8, x0, #15
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	lsl	x9, x0, #17
	and	x9, x9, #0xfefefefefefefefe
	orr	x8, x8, x9
	lsr	x9, x0, #17
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x9
	lsr	x9, x0, #15
	and	x9, x9, #0xfefefefefefefefe
	orr	x8, x8, x9
	lsl	x9, x0, #6
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	lsl	x9, x0, #10
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	lsr	x9, x0, #10
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	lsr	x9, x0, #6
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	and	x9, x2, x1
	and	x0, x9, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_inner_rook_dest_bb             ; -- Begin function inner_rook_dest_bb
	.p2align	2
_inner_rook_dest_bb:                    ; @inner_rook_dest_bb
	.cfi_startproc
; %bb.0:
	mov	x8, #0
	cbz	x0, LBB48_10
; %bb.1:
	mov	x9, x0
LBB48_2:                                ; =>This Inner Loop Header: Depth=1
	and	x9, x1, x9, lsl #8
	orr	x8, x9, x8
	ands	x9, x9, x2
	b.ne	LBB48_2
; %bb.3:
	mov	x10, x0
LBB48_4:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x1, x10, lsr #8
	orr	x9, x10, x9
	ands	x10, x10, x2
	b.ne	LBB48_4
; %bb.5:
	and	x11, x1, #0x7f7f7f7f7f7f7f7f
	mov	x12, x0
LBB48_6:                                ; =>This Inner Loop Header: Depth=1
	and	x12, x11, x12, lsr #1
	orr	x10, x12, x10
	ands	x12, x12, x2
	b.ne	LBB48_6
; %bb.7:
	mov	x11, #0
	and	x12, x1, #0xfefefefefefefefe
LBB48_8:                                ; =>This Inner Loop Header: Depth=1
	and	x13, x12, x0, lsl #1
	orr	x11, x13, x11
	ands	x0, x13, x2
	b.ne	LBB48_8
; %bb.9:
	orr	x8, x9, x8
	orr	x8, x8, x10
	orr	x8, x8, x11
LBB48_10:
	and	x0, x8, x3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_inner_bishop_dest_bb           ; -- Begin function inner_bishop_dest_bb
	.p2align	2
_inner_bishop_dest_bb:                  ; @inner_bishop_dest_bb
	.cfi_startproc
; %bb.0:
	mov	x8, #0
	cbz	x0, LBB49_10
; %bb.1:
	mov	x9, #-72340172838076674
	movk	x9, #65024
	and	x9, x1, x9
	mov	x10, x0
LBB49_2:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x9, x10, lsl #9
	orr	x8, x10, x8
	ands	x10, x10, x2
	b.ne	LBB49_2
; %bb.3:
	mov	x9, #0
	mov	x10, #9187201950435737471
	movk	x10, #127, lsl #48
	and	x10, x1, x10
	mov	x11, x0
LBB49_4:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x10, x11, lsr #9
	orr	x9, x11, x9
	ands	x11, x11, x2
	b.ne	LBB49_4
; %bb.5:
	mov	x10, #0
	mov	x11, #9187201950435737471
	movk	x11, #32512
	and	x11, x1, x11
	mov	x12, x0
LBB49_6:                                ; =>This Inner Loop Header: Depth=1
	and	x12, x11, x12, lsl #7
	orr	x10, x12, x10
	ands	x12, x12, x2
	b.ne	LBB49_6
; %bb.7:
	mov	x11, #0
	mov	x12, #-72340172838076674
	movk	x12, #254, lsl #48
	and	x12, x1, x12
LBB49_8:                                ; =>This Inner Loop Header: Depth=1
	and	x13, x12, x0, lsr #7
	orr	x11, x13, x11
	ands	x0, x13, x2
	b.ne	LBB49_8
; %bb.9:
	orr	x8, x9, x8
	orr	x8, x8, x10
	orr	x8, x8, x11
LBB49_10:
	and	x0, x8, x3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_inner_queen_dest_bb            ; -- Begin function inner_queen_dest_bb
	.p2align	2
_inner_queen_dest_bb:                   ; @inner_queen_dest_bb
	.cfi_startproc
; %bb.0:
	mov	x8, #0
	cbz	x0, LBB50_18
; %bb.1:
	mov	x9, #-72340172838076674
	movk	x9, #65024
	and	x9, x1, x9
	mov	x10, x0
LBB50_2:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x9, x10, lsl #9
	orr	x8, x10, x8
	ands	x10, x10, x2
	b.ne	LBB50_2
; %bb.3:
	mov	x9, #9187201950435737471
	movk	x9, #127, lsl #48
	and	x9, x1, x9
	mov	x11, x0
LBB50_4:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x9, x11, lsr #9
	orr	x10, x11, x10
	ands	x11, x11, x2
	b.ne	LBB50_4
; %bb.5:
	mov	x9, #9187201950435737471
	movk	x9, #32512
	and	x9, x1, x9
	mov	x12, x0
LBB50_6:                                ; =>This Inner Loop Header: Depth=1
	and	x12, x9, x12, lsl #7
	orr	x11, x12, x11
	ands	x12, x12, x2
	b.ne	LBB50_6
; %bb.7:
	mov	x9, #-72340172838076674
	movk	x9, #254, lsl #48
	and	x9, x1, x9
	mov	x13, x0
LBB50_8:                                ; =>This Inner Loop Header: Depth=1
	and	x13, x9, x13, lsr #7
	orr	x12, x13, x12
	ands	x13, x13, x2
	b.ne	LBB50_8
; %bb.9:
	mov	x9, #0
	orr	x8, x10, x8
	orr	x8, x8, x11
	orr	x8, x8, x12
	mov	x10, x0
LBB50_10:                               ; =>This Inner Loop Header: Depth=1
	and	x10, x1, x10, lsl #8
	orr	x9, x10, x9
	ands	x10, x10, x2
	b.ne	LBB50_10
; %bb.11:
	mov	x11, x0
LBB50_12:                               ; =>This Inner Loop Header: Depth=1
	and	x11, x1, x11, lsr #8
	orr	x10, x11, x10
	ands	x11, x11, x2
	b.ne	LBB50_12
; %bb.13:
	and	x12, x1, #0x7f7f7f7f7f7f7f7f
	mov	x13, x0
LBB50_14:                               ; =>This Inner Loop Header: Depth=1
	and	x13, x12, x13, lsr #1
	orr	x11, x13, x11
	ands	x13, x13, x2
	b.ne	LBB50_14
; %bb.15:
	mov	x12, #0
	and	x13, x1, #0xfefefefefefefefe
LBB50_16:                               ; =>This Inner Loop Header: Depth=1
	and	x14, x13, x0, lsl #1
	orr	x12, x14, x12
	ands	x0, x14, x2
	b.ne	LBB50_16
; %bb.17:
	orr	x8, x9, x8
	orr	x8, x8, x10
	orr	x8, x8, x11
	orr	x8, x8, x12
LBB50_18:
	and	x0, x8, x3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_inner_king_dest_bb             ; -- Begin function inner_king_dest_bb
	.p2align	2
_inner_king_dest_bb:                    ; @inner_king_dest_bb
	.cfi_startproc
; %bb.0:
	bic	x8, x3, x5
	lsr	x9, x0, #1
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	lsl	x10, x0, #1
	and	x10, x10, #0xfefefefefefefefe
	lsl	x11, x0, #7
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	lsr	x12, x0, #9
	and	x12, x12, #0x7f7f7f7f7f7f7f7f
	lsl	x13, x0, #9
	and	x13, x13, #0xfefefefefefefefe
	lsr	x14, x0, #7
	and	x14, x14, #0xfefefefefefefefe
	orr	x12, x13, x12
	orr	x11, x12, x11
	orr	x11, x11, x14
	orr	x11, x11, x0, lsr #8
	orr	x11, x11, x0, lsl #8
	orr	x11, x11, x9
	orr	x11, x11, x10
	and	x8, x8, x11
	lsl	x11, x0, #2
	and	x11, x11, #0xfcfcfcfcfcfcfcfc
	orr	x10, x10, x11
	orn	x12, x5, x4
	tst	x12, x10
	csel	x10, x11, xzr, eq
	orr	x10, x8, x10
	cmp	w1, #0
	csel	x8, x8, x10, eq
	lsr	x10, x0, #2
	and	x10, x10, #0x3f3f3f3f3f3f3f3f
	lsr	x11, x0, #3
	bic	x11, x11, x4
	orr	x9, x9, x10
	and	x9, x12, x9
	and	x11, x11, #0x1f1f1f1f1f1f1f1f
	orr	x9, x9, x11
	cmp	x9, #0
	csel	x9, x10, xzr, eq
	orr	x9, x8, x9
	cmp	w2, #0
	csel	x0, x8, x9, eq
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_inner_white_pawn_dest_bb       ; -- Begin function inner_white_pawn_dest_bb
	.p2align	2
_inner_white_pawn_dest_bb:              ; @inner_white_pawn_dest_bb
	.cfi_startproc
; %bb.0:
	lsl	x8, x0, #8
	and	w9, w8, w2
	lsl	w9, w9, #8
	and	x9, x9, #0xff000000
	orr	x8, x9, x8
	and	x8, x8, x4
	and	x8, x8, x2
	lsl	x9, x0, #9
	and	x9, x9, #0xfefefefefefefefe
	lsl	x10, x0, #7
	and	x10, x10, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x10
	and	x9, x9, x1
	and	x9, x9, x5
	orr	x8, x8, x9
	and	x0, x8, x3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_inner_black_pawn_dest_bb       ; -- Begin function inner_black_pawn_dest_bb
	.p2align	2
_inner_black_pawn_dest_bb:              ; @inner_black_pawn_dest_bb
	.cfi_startproc
; %bb.0:
	lsr	x8, x0, #8
	and	x9, x8, x2
	lsr	x9, x9, #8
	and	x9, x9, #0xff00000000
	orr	x8, x9, x8
	and	x8, x8, x4
	and	x8, x8, x2
	lsr	x9, x0, #7
	and	x9, x9, #0xfefefefefefefefe
	lsr	x10, x0, #9
	and	x10, x10, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x10
	and	x9, x9, x1
	and	x9, x9, x5
	orr	x8, x8, x9
	and	x0, x8, x3
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_has_moves                      ; -- Begin function has_moves
	.p2align	2
_has_moves:                             ; @has_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #256
	.cfi_def_cfa_offset 256
	stp	x28, x27, [sp, #160]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #176]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #192]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #208]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #224]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #240]            ; 16-byte Folded Spill
	add	x29, sp, #240
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
	mov	x15, x3
	stp	x0, x2, [x29, #-104]            ; 16-byte Folded Spill
	mov	x17, x1
	ldr	x8, [x0]
	ldr	x11, [x8]
	ldrb	w10, [x0, #9]
	cmp	w1, #1
	b.ne	LBB54_4
; %bb.1:
	ldp	x26, x9, [x8, #48]
	and	x11, x26, x11
	and	x11, x11, #0xffffffffffffff
	stur	x11, [x29, #-112]               ; 8-byte Folded Spill
	ubfx	w11, w10, #1, #1
	tbz	w10, #0, LBB54_5
LBB54_2:
	ldrb	w10, [x15, #16]
	cmp	w10, #0
	cset	w12, eq
	str	w12, [sp, #108]                 ; 4-byte Folded Spill
	tbnz	w11, #0, LBB54_7
; %bb.3:
	str	wzr, [sp, #104]                 ; 4-byte Folded Spill
	neg	x10, x26
	ands	x23, x26, x10
	b.ne	LBB54_9
	b	LBB54_43
LBB54_4:
	ldp	x9, x26, [x8, #48]
	and	x11, x26, x11
	and	x11, x11, #0xffffffffffffff00
	stur	x11, [x29, #-112]               ; 8-byte Folded Spill
	ubfx	w11, w10, #3, #1
	tbnz	w10, #2, LBB54_2
LBB54_5:
	cbz	w11, LBB54_8
; %bb.6:
	str	wzr, [sp, #108]                 ; 4-byte Folded Spill
	ldrb	w10, [x15, #16]
LBB54_7:
	cmp	w10, #0
	cset	w10, eq
	str	w10, [sp, #104]                 ; 4-byte Folded Spill
	neg	x10, x26
	ands	x23, x26, x10
	b.ne	LBB54_9
	b	LBB54_43
LBB54_8:
	str	xzr, [sp, #104]                 ; 8-byte Folded Spill
	neg	x10, x26
	ands	x23, x26, x10
	b.eq	LBB54_43
LBB54_9:
	ldur	x10, [x29, #-104]               ; 8-byte Folded Reload
	ldrh	w10, [x10, #10]
	lsl	x11, x10, #55
	mov	w12, #1
	lsl	x10, x12, x10
	and	x10, x10, x11, asr #63
	orr	x11, x9, x26
	mvn	x24, x11
	orr	x9, x10, x9
	str	x9, [sp, #88]                   ; 8-byte Folded Spill
	mvn	x25, x26
	mov	x0, #-72340172838076674
	movk	x0, #65024
	mov	x1, #9187201950435737471
	movk	x1, #32512
	mov	x2, #-72340172838076674
	movk	x2, #254, lsl #48
	mov	x3, #9187201950435737471
	movk	x3, #127, lsl #48
	ldp	x10, x9, [x8, #32]
	ldr	x13, [x8, #8]
	ldp	x8, x12, [x8, #16]
	ldur	x16, [x29, #-96]                ; 8-byte Folded Reload
	orr	x14, x26, x16
	mvn	x14, x14
	str	x14, [sp, #96]                  ; 8-byte Folded Spill
	orr	x14, x11, x16
	and	x11, x11, #0x1f1f1f1f1f1f1f1f
	str	x11, [sp, #72]                  ; 8-byte Folded Spill
	and	x11, x25, #0x7f7f7f7f7f7f7f7f
	str	x11, [sp, #32]                  ; 8-byte Folded Spill
	and	x11, x25, #0xfefefefefefefefe
	and	x19, x25, x0
	and	x21, x25, x3
	and	x22, x25, x1
	and	x28, x25, x2
	and	x9, x26, x9
	stp	x14, x9, [sp, #112]             ; 16-byte Folded Spill
	and	x9, x26, x13
	str	x9, [sp, #80]                   ; 8-byte Folded Spill
	and	x9, x26, x12
	stp	x9, x22, [sp, #40]              ; 16-byte Folded Spill
	and	x8, x26, x8
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	and	x8, x26, x10
	str	x8, [sp]                        ; 8-byte Folded Spill
	stp	x21, x19, [sp, #56]             ; 16-byte Folded Spill
	stp	x28, x11, [sp, #16]             ; 16-byte Folded Spill
	b	LBB54_12
LBB54_10:                               ;   in Loop: Header=BB54_12 Depth=1
	ldr	x8, [x15, #8]
	cmp	w20, #1
	and	x9, x21, x24
	lsr	x9, x9, #8
	and	x9, x9, #0xff00000000
	orr	x9, x9, x21
	and	x9, x9, x24
	and	x9, x9, x3
	mov	x10, #-72340172838076674
	movk	x10, #254, lsl #48
	and	x10, x10, x23, lsr #7
	orr	x10, x10, x19
	and	x10, x10, x8
	ldr	x12, [sp, #88]                  ; 8-byte Folded Reload
	and	x10, x10, x12
	orr	x9, x10, x9
	and	x9, x9, x0
	lsl	x10, x23, #8
	and	w11, w10, w24
	lsl	w11, w11, #8
	and	x11, x11, #0xff000000
	orr	x10, x11, x10
	and	x10, x10, x24
	and	x10, x10, x3
	orr	x11, x22, x28
	and	x8, x11, x8
	and	x8, x8, x12
	orr	x8, x8, x10
	and	x8, x8, x0
	csel	x0, x9, x8, ne
	mov	x17, x20
	cbnz	x0, LBB54_42
LBB54_11:                               ;   in Loop: Header=BB54_12 Depth=1
	eor	x26, x23, x26
	neg	x8, x26
	ands	x23, x26, x8
	b.eq	LBB54_43
LBB54_12:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB54_23 Depth 2
                                        ;     Child Loop BB54_25 Depth 2
                                        ;     Child Loop BB54_27 Depth 2
                                        ;     Child Loop BB54_29 Depth 2
                                        ;     Child Loop BB54_32 Depth 2
                                        ;     Child Loop BB54_34 Depth 2
                                        ;     Child Loop BB54_36 Depth 2
                                        ;     Child Loop BB54_38 Depth 2
	lsr	x21, x23, #8
	mov	x8, #9187201950435737471
	movk	x8, #127, lsl #48
	and	x19, x8, x23, lsr #9
	mov	x8, #-72340172838076674
	movk	x8, #65024
	and	x22, x8, x23, lsl #9
	mov	x8, #9187201950435737471
	movk	x8, #32512
	and	x28, x8, x23, lsl #7
	ldr	x8, [sp, #120]                  ; 8-byte Folded Reload
	tst	x8, x23
	b.eq	LBB54_18
; %bb.13:                               ;   in Loop: Header=BB54_12 Depth=1
	lsr	x8, x23, #1
	and	x9, x8, #0x7f7f7f7f7f7f7f7f
	lsl	x8, x23, #1
	and	x10, x8, #0xfefefefefefefefe
	mov	x8, #-72340172838076674
	movk	x8, #254, lsl #48
	and	x8, x8, x21, lsl #1
	orr	x11, x19, x22
	orr	x11, x11, x28
	orr	x8, x11, x8
	orr	x8, x8, x21
	orr	x8, x8, x23, lsl #8
	orr	x8, x8, x9
	orr	x8, x8, x10
	ldr	x11, [sp, #96]                  ; 8-byte Folded Reload
	and	x8, x8, x11
	ldr	w11, [sp, #108]                 ; 4-byte Folded Reload
	cbz	w11, LBB54_15
; %bb.14:                               ;   in Loop: Header=BB54_12 Depth=1
	lsl	x11, x23, #2
	and	x11, x11, #0xfcfcfcfcfcfcfcfc
	orr	x10, x10, x11
	ldr	x12, [sp, #112]                 ; 8-byte Folded Reload
	tst	x10, x12
	csel	x10, x11, xzr, eq
	orr	x8, x8, x10
LBB54_15:                               ;   in Loop: Header=BB54_12 Depth=1
	ldr	w10, [sp, #104]                 ; 4-byte Folded Reload
	cbz	w10, LBB54_17
; %bb.16:                               ;   in Loop: Header=BB54_12 Depth=1
	lsr	x10, x23, #2
	and	x10, x10, #0x3f3f3f3f3f3f3f3f
	orr	x9, x9, x10
	ldr	x11, [sp, #112]                 ; 8-byte Folded Reload
	and	x9, x9, x11
	ldr	x11, [sp, #72]                  ; 8-byte Folded Reload
	and	x11, x11, x23, lsr #3
	orr	x9, x9, x11
	cmp	x9, #0
	csel	x9, x10, xzr, eq
	orr	x8, x8, x9
LBB54_17:                               ;   in Loop: Header=BB54_12 Depth=1
	cbnz	x8, LBB54_42
LBB54_18:                               ;   in Loop: Header=BB54_12 Depth=1
	ldp	x0, x3, [x29, #-104]            ; 16-byte Folded Reload
	mov	x1, x23
	mov	x20, x17
	mov	x2, x17
	mov	x27, x15
	bl	_make_pinned_mask
	mov	x15, x27
	ldr	x8, [x27]
	and	x3, x8, x0
	ldur	x8, [x29, #-112]                ; 8-byte Folded Reload
	tst	x23, x8
	b.ne	LBB54_10
; %bb.19:                               ;   in Loop: Header=BB54_12 Depth=1
	ldr	x8, [sp, #80]                   ; 8-byte Folded Reload
	tst	x8, x23
	b.eq	LBB54_21
; %bb.20:                               ;   in Loop: Header=BB54_12 Depth=1
	lsl	x8, x23, #15
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	lsl	x9, x23, #17
	and	x9, x9, #0xfefefefefefefefe
	orr	x8, x8, x9
	lsr	x9, x23, #17
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x9
	lsr	x9, x23, #15
	and	x9, x9, #0xfefefefefefefefe
	orr	x8, x8, x9
	lsl	x9, x23, #6
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	lsl	x9, x23, #10
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	lsr	x9, x23, #10
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	lsr	x9, x23, #6
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	and	x8, x8, x25
	and	x0, x8, x3
	mov	x17, x20
	cbz	x0, LBB54_11
	b	LBB54_42
LBB54_21:                               ;   in Loop: Header=BB54_12 Depth=1
	ldp	x8, x22, [sp, #40]              ; 16-byte Folded Reload
	tst	x8, x23
	mov	x17, x20
	ldp	x21, x19, [sp, #56]             ; 16-byte Folded Reload
	b.eq	LBB54_30
; %bb.22:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x8, #0
	mov	x9, x23
LBB54_23:                               ;   Parent Loop BB54_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x9, x9, #8
	and	x10, x9, x25
	orr	x8, x10, x8
	ands	x9, x9, x24
	b.ne	LBB54_23
; %bb.24:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x10, x23
	ldp	x13, x12, [sp, #24]             ; 16-byte Folded Reload
LBB54_25:                               ;   Parent Loop BB54_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x10, x10, #8
	and	x11, x10, x25
	orr	x9, x11, x9
	ands	x10, x10, x24
	b.ne	LBB54_25
; %bb.26:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x11, x23
LBB54_27:                               ;   Parent Loop BB54_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x12, x11, lsr #1
	orr	x10, x11, x10
	ands	x11, x11, x24
	b.ne	LBB54_27
; %bb.28:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x12, x23
LBB54_29:                               ;   Parent Loop BB54_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x12, x13, x12, lsl #1
	orr	x11, x12, x11
	ands	x12, x12, x24
	b.ne	LBB54_29
	b	LBB54_39
LBB54_30:                               ;   in Loop: Header=BB54_12 Depth=1
	ldp	x8, x28, [sp, #8]               ; 16-byte Folded Reload
	tst	x8, x23
	b.eq	LBB54_40
; %bb.31:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x8, #0
	mov	x9, x23
LBB54_32:                               ;   Parent Loop BB54_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x9, x19, x9, lsl #9
	orr	x8, x9, x8
	ands	x9, x9, x24
	b.ne	LBB54_32
; %bb.33:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x10, x23
LBB54_34:                               ;   Parent Loop BB54_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x10, x21, x10, lsr #9
	orr	x9, x10, x9
	ands	x10, x10, x24
	b.ne	LBB54_34
; %bb.35:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x11, x23
LBB54_36:                               ;   Parent Loop BB54_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x22, x11, lsl #7
	orr	x10, x11, x10
	ands	x11, x11, x24
	b.ne	LBB54_36
; %bb.37:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x12, x23
LBB54_38:                               ;   Parent Loop BB54_12 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x12, x28, x12, lsr #7
	orr	x11, x12, x11
	ands	x12, x12, x24
	b.ne	LBB54_38
LBB54_39:                               ;   in Loop: Header=BB54_12 Depth=1
	orr	x8, x9, x8
	orr	x8, x8, x10
	orr	x8, x8, x11
	and	x0, x8, x3
	cbz	x0, LBB54_11
	b	LBB54_42
LBB54_40:                               ;   in Loop: Header=BB54_12 Depth=1
	ldr	x8, [sp]                        ; 8-byte Folded Reload
	tst	x8, x23
	b.eq	LBB54_11
; %bb.41:                               ;   in Loop: Header=BB54_12 Depth=1
	mov	x0, x23
	mov	x1, x25
	mov	x2, x24
	bl	_inner_queen_dest_bb
	mov	x17, x20
	mov	x15, x27
	cbz	x0, LBB54_11
LBB54_42:
	mov	w0, #1
	b	LBB54_44
LBB54_43:
	mov	w0, #0
LBB54_44:
	ldp	x29, x30, [sp, #240]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #224]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #208]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #192]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #176]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #160]            ; 16-byte Folded Reload
	add	sp, sp, #256
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function generate_moves
lCPI55_0:
	.quad	131072                          ; 0x20000
	.quad	32768                           ; 0x8000
lCPI55_1:
	.quad	64                              ; 0x40
	.quad	1024                            ; 0x400
lCPI55_2:
	.quad	-17                             ; 0xffffffffffffffef
	.quad	-15                             ; 0xfffffffffffffff1
lCPI55_3:
	.quad	-10                             ; 0xfffffffffffffff6
	.quad	-6                              ; 0xfffffffffffffffa
lCPI55_4:
	.quad	4557430888798830336             ; 0x3f3f3f3f3f3f3f00
	.quad	-217020518514230272             ; 0xfcfcfcfcfcfcfc00
lCPI55_5:
	.quad	-72340172838141952              ; 0xfefefefefefe0000
	.quad	9187201950435704832             ; 0x7f7f7f7f7f7f0000
lCPI55_6:
	.quad	17802464409370431               ; 0x3f3f3f3f3f3f3f
	.quad	71209857637481724               ; 0xfcfcfcfcfcfcfc
lCPI55_7:
	.quad	140185576636287                 ; 0x7f7f7f7f7f7f
	.quad	280371153272574                 ; 0xfefefefefefe
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_generate_moves
	.p2align	2
_generate_moves:                        ; @generate_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #400
	.cfi_def_cfa_offset 400
	stp	x28, x27, [sp, #304]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #320]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #336]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #352]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #368]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #384]            ; 16-byte Folded Spill
	add	x29, sp, #384
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
	stur	x5, [x29, #-104]                ; 8-byte Folded Spill
	mov	x20, x4
	stp	x0, x2, [x29, #-144]            ; 16-byte Folded Spill
	stur	w1, [x29, #-156]                ; 4-byte Folded Spill
	sturb	wzr, [x29, #-89]
	ldr	x9, [x0]
	ldr	x12, [x9]
	ldrb	w11, [x0, #9]
	cmp	w1, #1
	stur	x3, [x29, #-152]                ; 8-byte Folded Spill
	b.ne	LBB55_4
; %bb.1:
	ldp	x8, x10, [x9, #48]
	and	x12, x8, x12
	and	x12, x12, #0xffffffffffffff
	stur	x12, [x29, #-168]               ; 8-byte Folded Spill
	ubfx	w12, w11, #1, #1
	tbz	w11, #0, LBB55_5
LBB55_2:
	ldrb	w11, [x3, #16]
	cmp	w11, #0
	cset	w13, eq
	stur	w13, [x29, #-124]               ; 4-byte Folded Spill
	tbnz	w12, #0, LBB55_7
; %bb.3:
	stur	wzr, [x29, #-128]               ; 4-byte Folded Spill
	b	LBB55_9
LBB55_4:
	ldp	x10, x8, [x9, #48]
	and	x12, x8, x12
	and	x12, x12, #0xffffffffffffff00
	stur	x12, [x29, #-168]               ; 8-byte Folded Spill
	ubfx	w12, w11, #3, #1
	tbnz	w11, #2, LBB55_2
LBB55_5:
	cbz	w12, LBB55_8
; %bb.6:
	stur	wzr, [x29, #-124]               ; 4-byte Folded Spill
	ldrb	w11, [x3, #16]
LBB55_7:
	cmp	w11, #0
	cset	w11, eq
	stur	w11, [x29, #-128]               ; 4-byte Folded Spill
	b	LBB55_9
LBB55_8:
	stur	xzr, [x29, #-128]               ; 8-byte Folded Spill
LBB55_9:
	mov	x24, #0
	mov	x21, #-72340172838076674
	movk	x21, #65024
	mov	x17, #9187201950435737471
	movk	x17, #32512
	mov	x0, #-72340172838076674
	movk	x0, #254, lsl #48
	mov	x1, #9187201950435737471
	movk	x1, #127, lsl #48
	ldur	x11, [x29, #-144]               ; 8-byte Folded Reload
	ldrh	w11, [x11, #10]
	lsl	x12, x11, #55
	ldp	x14, x13, [x9, #8]
	mov	w2, #1
	lsl	x11, x2, x11
	ldp	x15, x16, [x9, #24]
	and	x11, x11, x12, asr #63
	orr	x23, x10, x8
	ldr	x9, [x9, #40]
	mvn	x25, x23
	orr	x10, x11, x10
	stur	x10, [x29, #-184]               ; 8-byte Folded Spill
	mvn	x26, x8
	ldur	x11, [x29, #-136]               ; 8-byte Folded Reload
	orr	x10, x8, x11
	mvn	x10, x10
	stur	x10, [x29, #-120]               ; 8-byte Folded Spill
	orr	x10, x23, x11
	stur	x10, [x29, #-112]               ; 8-byte Folded Spill
	and	x10, x23, #0x1f1f1f1f1f1f1f1f
	stur	x10, [x29, #-176]               ; 8-byte Folded Spill
	mov	x10, #9187201950435737471
	bic	x28, x10, x8
	mov	x10, #-72340172838076674
	bic	x22, x10, x8
	bic	x10, x21, x8
	str	x10, [sp, #40]                  ; 8-byte Folded Spill
	bic	x10, x1, x8
	str	x10, [sp, #32]                  ; 8-byte Folded Spill
	bic	x10, x17, x8
	str	x10, [sp, #24]                  ; 8-byte Folded Spill
	bic	x10, x0, x8
	str	x10, [sp, #16]                  ; 8-byte Folded Spill
	and	x19, x8, x9
	and	x9, x8, x14
	str	x9, [sp, #192]                  ; 8-byte Folded Spill
	and	x9, x8, x15
	str	x9, [sp, #56]                   ; 8-byte Folded Spill
	and	x9, x8, x13
	str	x9, [sp, #48]                   ; 8-byte Folded Spill
Lloh2:
	adrp	x9, lCPI55_0@PAGE
Lloh3:
	ldr	q0, [x9, lCPI55_0@PAGEOFF]
	str	q0, [sp, #176]                  ; 16-byte Folded Spill
Lloh4:
	adrp	x9, lCPI55_1@PAGE
Lloh5:
	ldr	q0, [x9, lCPI55_1@PAGEOFF]
	str	q0, [sp, #160]                  ; 16-byte Folded Spill
Lloh6:
	adrp	x9, lCPI55_2@PAGE
Lloh7:
	ldr	q0, [x9, lCPI55_2@PAGEOFF]
	str	q0, [sp, #144]                  ; 16-byte Folded Spill
	and	x8, x8, x16
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
Lloh8:
	adrp	x8, lCPI55_3@PAGE
Lloh9:
	ldr	q0, [x8, lCPI55_3@PAGEOFF]
	str	q0, [sp, #128]                  ; 16-byte Folded Spill
Lloh10:
	adrp	x8, lCPI55_4@PAGE
Lloh11:
	ldr	q0, [x8, lCPI55_4@PAGEOFF]
	str	q0, [sp, #112]                  ; 16-byte Folded Spill
Lloh12:
	adrp	x8, lCPI55_5@PAGE
Lloh13:
	ldr	q0, [x8, lCPI55_5@PAGEOFF]
	str	q0, [sp, #96]                   ; 16-byte Folded Spill
Lloh14:
	adrp	x8, lCPI55_6@PAGE
Lloh15:
	ldr	q0, [x8, lCPI55_6@PAGEOFF]
	str	q0, [sp, #80]                   ; 16-byte Folded Spill
Lloh16:
	adrp	x8, lCPI55_7@PAGE
Lloh17:
	ldr	q0, [x8, lCPI55_7@PAGEOFF]
	str	q0, [sp, #64]                   ; 16-byte Folded Spill
	b	LBB55_14
LBB55_10:                               ;   in Loop: Header=BB55_14 Depth=1
	orr	x8, x9, x8
	orr	x8, x8, x10
	orr	x8, x8, x11
	and	x1, x8, x3
LBB55_11:                               ;   in Loop: Header=BB55_14 Depth=1
	and	w0, w24, #0xff
	sub	x3, x29, #89
	ldur	x2, [x29, #-104]                ; 8-byte Folded Reload
	bl	_add_from_bitboard
LBB55_12:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	w2, #1
LBB55_13:                               ;   in Loop: Header=BB55_14 Depth=1
	add	x24, x24, #1
	cmp	x24, #64
	b.eq	LBB55_46
LBB55_14:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB55_30 Depth 2
                                        ;     Child Loop BB55_32 Depth 2
                                        ;     Child Loop BB55_34 Depth 2
                                        ;     Child Loop BB55_35 Depth 2
                                        ;     Child Loop BB55_38 Depth 2
                                        ;     Child Loop BB55_40 Depth 2
                                        ;     Child Loop BB55_42 Depth 2
                                        ;     Child Loop BB55_43 Depth 2
	lsl	x27, x2, x24
	and	x8, x27, x20
	and	x9, x27, x23
	cmp	x8, #0
	ccmp	x9, #0, #4, ne
	b.eq	LBB55_13
; %bb.15:                               ;   in Loop: Header=BB55_14 Depth=1
	tst	x19, x27
	b.eq	LBB55_20
; %bb.16:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	w8, #256
	lsl	x10, x8, x24
	lsr	x11, x27, #8
	lsr	x8, x27, #1
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	mov	w9, #2
	lsl	x9, x9, x24
	and	x9, x9, #0xfefefefefefefefe
	mov	w12, #128
	lsl	x12, x12, x24
	mov	x13, #9187201950435737471
	movk	x13, #32512
	and	x12, x12, x13
	mov	x13, #9187201950435737471
	movk	x13, #127, lsl #48
	and	x13, x13, x27, lsr #9
	mov	w14, #512
	lsl	x14, x14, x24
	and	x14, x14, x21
	mov	x15, #-72340172838076674
	movk	x15, #254, lsl #48
	and	x15, x15, x11, lsl #1
	orr	x10, x14, x10
	orr	x10, x10, x12
	orr	x10, x10, x13
	orr	x10, x10, x15
	orr	x10, x10, x11
	orr	x10, x10, x9
	orr	x10, x10, x8
	ldur	x11, [x29, #-120]               ; 8-byte Folded Reload
	and	x1, x10, x11
	ldur	w10, [x29, #-124]               ; 4-byte Folded Reload
	cbz	w10, LBB55_18
; %bb.17:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	w10, #4
	lsl	x10, x10, x24
	and	x10, x10, #0xfcfcfcfcfcfcfcfc
	orr	x9, x9, x10
	ldur	x11, [x29, #-112]               ; 8-byte Folded Reload
	tst	x9, x11
	csel	x9, x10, xzr, eq
	orr	x1, x1, x9
LBB55_18:                               ;   in Loop: Header=BB55_14 Depth=1
	ldur	w9, [x29, #-128]                ; 4-byte Folded Reload
	cbz	w9, LBB55_11
; %bb.19:                               ;   in Loop: Header=BB55_14 Depth=1
	lsr	x9, x27, #2
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	ldur	x10, [x29, #-112]               ; 8-byte Folded Reload
	and	x8, x8, x10
	ldur	x10, [x29, #-176]               ; 8-byte Folded Reload
	and	x10, x10, x27, lsr #3
	orr	x8, x8, x10
	cmp	x8, #0
	csel	x8, x9, xzr, eq
	orr	x1, x1, x8
	b	LBB55_11
LBB55_20:                               ;   in Loop: Header=BB55_14 Depth=1
	ldp	x0, x3, [x29, #-144]            ; 16-byte Folded Reload
	mov	x1, x27
	ldur	w21, [x29, #-156]               ; 4-byte Folded Reload
	mov	x2, x21
	bl	_make_pinned_mask
	ldur	x9, [x29, #-152]                ; 8-byte Folded Reload
	ldr	x8, [x9]
	and	x3, x8, x0
	ldur	x8, [x29, #-168]                ; 8-byte Folded Reload
	tst	x27, x8
	b.eq	LBB55_24
; %bb.21:                               ;   in Loop: Header=BB55_14 Depth=1
	ldr	x8, [x9, #8]
	cmp	w21, #1
	b.ne	LBB55_26
; %bb.22:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	w9, #256
	lsl	x9, x9, x24
	and	w10, w9, w25
	lsl	w10, w10, #8
	and	x10, x10, #0xff000000
	orr	x9, x10, x9
	and	x9, x9, x25
	and	x9, x9, x3
	mov	w10, #512
	lsl	x10, x10, x24
	mov	x21, #-72340172838076674
	movk	x21, #65024
	and	x10, x10, x21
	mov	w11, #128
	lsl	x11, x11, x24
	mov	x12, #9187201950435737471
	movk	x12, #32512
	and	x11, x11, x12
	orr	x10, x10, x11
	and	x8, x10, x8
	ldur	x10, [x29, #-184]               ; 8-byte Folded Reload
	and	x8, x8, x10
	orr	x8, x8, x9
	and	x1, x8, x0
	tst	x27, #0xff000000000000
	b.eq	LBB55_11
; %bb.23:                               ;   in Loop: Header=BB55_14 Depth=1
	and	w0, w24, #0xff
	sub	x3, x29, #89
	ldur	x2, [x29, #-104]                ; 8-byte Folded Reload
	bl	_add_from_bitboard_white_promotes
	b	LBB55_12
LBB55_24:                               ;   in Loop: Header=BB55_14 Depth=1
	ldr	x8, [sp, #192]                  ; 8-byte Folded Reload
	tst	x8, x27
	b.eq	LBB55_28
; %bb.25:                               ;   in Loop: Header=BB55_14 Depth=1
	dup.2d	v0, x24
	ldp	q3, q1, [sp, #160]              ; 32-byte Folded Reload
	ushl.2d	v1, v1, v0
	dup.2d	v2, x27
	ushl.2d	v0, v3, v0
	ldp	q4, q3, [sp, #128]              ; 32-byte Folded Reload
	ushl.2d	v3, v2, v3
	ushl.2d	v2, v2, v4
	ldr	q4, [sp, #112]                  ; 16-byte Folded Reload
	and.16b	v0, v0, v4
	ldr	q4, [sp, #96]                   ; 16-byte Folded Reload
	and.16b	v1, v1, v4
	ldr	q4, [sp, #80]                   ; 16-byte Folded Reload
	and.16b	v2, v2, v4
	ldr	q4, [sp, #64]                   ; 16-byte Folded Reload
	and.16b	v3, v3, v4
	orr.16b	v0, v1, v0
	ext.16b	v1, v0, v0, #8
	orr.8b	v0, v0, v1
	fmov	x8, d0
	orr.16b	v0, v3, v2
	ext.16b	v1, v0, v0, #8
	orr.8b	v0, v0, v1
	fmov	x9, d0
	orr	x8, x8, x9
	and	x8, x8, x26
	and	x1, x8, x3
	and	w0, w24, #0xff
	sub	x3, x29, #89
	ldur	x2, [x29, #-104]                ; 8-byte Folded Reload
	bl	_add_from_bitboard
	mov	x21, #-72340172838076674
	movk	x21, #65024
	b	LBB55_12
LBB55_26:                               ;   in Loop: Header=BB55_14 Depth=1
	lsr	x9, x27, #8
	and	x10, x9, x25
	lsr	x10, x10, #8
	and	x10, x10, #0xff00000000
	orr	x9, x10, x9
	and	x9, x9, x25
	and	x9, x9, x3
	mov	x10, #-72340172838076674
	movk	x10, #254, lsl #48
	and	x10, x10, x27, lsr #7
	mov	x11, #9187201950435737471
	movk	x11, #127, lsl #48
	and	x11, x11, x27, lsr #9
	orr	x10, x10, x11
	and	x8, x10, x8
	ldur	x10, [x29, #-184]               ; 8-byte Folded Reload
	and	x8, x8, x10
	orr	x8, x8, x9
	and	x1, x8, x0
	tst	x27, #0xff00
	mov	x21, #-72340172838076674
	movk	x21, #65024
	b.eq	LBB55_11
; %bb.27:                               ;   in Loop: Header=BB55_14 Depth=1
	and	w0, w24, #0xff
	sub	x3, x29, #89
	ldur	x2, [x29, #-104]                ; 8-byte Folded Reload
	bl	_add_from_bitboard_black_promotes
	b	LBB55_12
LBB55_28:                               ;   in Loop: Header=BB55_14 Depth=1
	ldr	x8, [sp, #56]                   ; 8-byte Folded Reload
	tst	x8, x27
	b.eq	LBB55_36
; %bb.29:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	x8, #0
	mov	x9, x27
LBB55_30:                               ;   Parent Loop BB55_14 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x9, x9, #8
	and	x10, x9, x26
	orr	x8, x10, x8
	ands	x9, x9, x25
	b.ne	LBB55_30
; %bb.31:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	x10, x27
	mov	x21, #-72340172838076674
	movk	x21, #65024
LBB55_32:                               ;   Parent Loop BB55_14 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x10, x10, #8
	and	x11, x10, x26
	orr	x9, x11, x9
	ands	x10, x10, x25
	b.ne	LBB55_32
; %bb.33:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	x11, x27
LBB55_34:                               ;   Parent Loop BB55_14 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x28, x11, lsr #1
	orr	x10, x11, x10
	ands	x11, x11, x25
	b.ne	LBB55_34
LBB55_35:                               ;   Parent Loop BB55_14 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x12, x22, x27, lsl #1
	orr	x11, x12, x11
	ands	x27, x12, x25
	b.ne	LBB55_35
	b	LBB55_10
LBB55_36:                               ;   in Loop: Header=BB55_14 Depth=1
	ldr	x8, [sp, #48]                   ; 8-byte Folded Reload
	tst	x8, x27
	mov	x21, #-72340172838076674
	movk	x21, #65024
	b.eq	LBB55_44
; %bb.37:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	x8, #0
	mov	x9, x27
	ldr	x10, [sp, #40]                  ; 8-byte Folded Reload
LBB55_38:                               ;   Parent Loop BB55_14 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x9, x10, x9, lsl #9
	orr	x8, x9, x8
	ands	x9, x9, x25
	b.ne	LBB55_38
; %bb.39:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	x10, x27
	ldp	x12, x11, [sp, #24]             ; 16-byte Folded Reload
	ldr	x13, [sp, #16]                  ; 8-byte Folded Reload
LBB55_40:                               ;   Parent Loop BB55_14 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x10, x11, x10, lsr #9
	orr	x9, x10, x9
	ands	x10, x10, x25
	b.ne	LBB55_40
; %bb.41:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	x11, x27
LBB55_42:                               ;   Parent Loop BB55_14 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x11, x12, x11, lsl #7
	orr	x10, x11, x10
	ands	x11, x11, x25
	b.ne	LBB55_42
LBB55_43:                               ;   Parent Loop BB55_14 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x12, x13, x27, lsr #7
	orr	x11, x12, x11
	ands	x27, x12, x25
	b.ne	LBB55_43
	b	LBB55_10
LBB55_44:                               ;   in Loop: Header=BB55_14 Depth=1
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	tst	x8, x27
	mov	w2, #1
	b.eq	LBB55_13
; %bb.45:                               ;   in Loop: Header=BB55_14 Depth=1
	mov	x0, x27
	mov	x1, x26
	mov	x2, x25
	bl	_inner_queen_dest_bb
	mov	x1, x0
	b	LBB55_11
LBB55_46:
	ldurb	w0, [x29, #-89]
	ldp	x29, x30, [sp, #384]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #368]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #352]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #336]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #320]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #304]            ; 16-byte Folded Reload
	add	sp, sp, #400
	ret
	.loh AdrpLdr	Lloh16, Lloh17
	.loh AdrpAdrp	Lloh14, Lloh16
	.loh AdrpLdr	Lloh14, Lloh15
	.loh AdrpAdrp	Lloh12, Lloh14
	.loh AdrpLdr	Lloh12, Lloh13
	.loh AdrpAdrp	Lloh10, Lloh12
	.loh AdrpLdr	Lloh10, Lloh11
	.loh AdrpAdrp	Lloh8, Lloh10
	.loh AdrpLdr	Lloh8, Lloh9
	.loh AdrpLdr	Lloh6, Lloh7
	.loh AdrpAdrp	Lloh4, Lloh6
	.loh AdrpLdr	Lloh4, Lloh5
	.loh AdrpAdrp	Lloh2, Lloh4
	.loh AdrpLdr	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
	.globl	_ext_get_pinned_mask            ; -- Begin function ext_get_pinned_mask
	.p2align	2
_ext_get_pinned_mask:                   ; @ext_get_pinned_mask
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
	ldrb	w21, [x0, #8]
	cmp	w21, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x3, x0
	mov	w8, #1
	lsl	x1, x8, x19
	mov	x0, x20
	mov	x2, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_make_pinned_mask
	.cfi_endproc
                                        ; -- End function
	.globl	_ext_get_attack_mask            ; -- Begin function ext_get_attack_mask
	.p2align	2
_ext_get_attack_mask:                   ; @ext_get_attack_mask
	.cfi_startproc
; %bb.0:
	ldrb	w8, [x0, #8]
	cmp	w8, #1
	cset	w1, ne
	b	_make_attack_mask
	.cfi_endproc
                                        ; -- End function
	.globl	_piece_attack_mask              ; -- Begin function piece_attack_mask
	.p2align	2
_piece_attack_mask:                     ; @piece_attack_mask
	.cfi_startproc
; %bb.0:
	ubfx	w8, w0, #8, #8
	sub	w8, w8, #3
	cmp	w8, #5
	b.hi	LBB58_41
; %bb.1:
Lloh18:
	adrp	x9, lJTI58_0@PAGE
Lloh19:
	add	x9, x9, lJTI58_0@PAGEOFF
	adr	x10, LBB58_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB58_2:
	lsr	x8, x1, #7
	and	x8, x8, #0xfefefefefefefefe
	lsr	x9, x1, #9
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x9
	lsl	x9, x1, #9
	and	x9, x9, #0xfefefefefefefefe
	lsl	x10, x1, #7
	and	x10, x10, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x10
	and	x10, x0, #0xff
	and	x8, x8, x2
	and	x9, x9, x2
	cmp	x10, #1
	csel	x0, x8, x9, ne
	ret
LBB58_3:
	lsl	x8, x1, #15
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	lsl	x9, x1, #17
	and	x9, x9, #0xfefefefefefefefe
	orr	x8, x8, x9
	lsr	x9, x1, #17
	and	x9, x9, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x9
	lsr	x9, x1, #15
	and	x9, x9, #0xfefefefefefefefe
	orr	x8, x8, x9
	lsl	x9, x1, #6
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	lsl	x9, x1, #10
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	lsr	x9, x1, #10
	and	x9, x9, #0x3f3f3f3f3f3f3f3f
	orr	x8, x8, x9
	lsr	x9, x1, #6
	and	x9, x9, #0xfcfcfcfcfcfcfcfc
	orr	x8, x8, x9
	and	x0, x8, x2
	ret
LBB58_4:
	cbz	x1, LBB58_41
; %bb.5:
	mov	x8, #0
	mov	x9, #-72340172838076674
	movk	x9, #65024
	and	x9, x2, x9
	mov	x10, x1
LBB58_6:                                ; =>This Inner Loop Header: Depth=1
	and	x10, x9, x10, lsl #9
	orr	x8, x10, x8
	ands	x10, x10, x3
	b.ne	LBB58_6
; %bb.7:
	mov	x9, #0
	mov	x10, #9187201950435737471
	movk	x10, #127, lsl #48
	and	x10, x2, x10
	mov	x11, x1
LBB58_8:                                ; =>This Inner Loop Header: Depth=1
	and	x11, x10, x11, lsr #9
	orr	x9, x11, x9
	ands	x11, x11, x3
	b.ne	LBB58_8
; %bb.9:
	mov	x10, #0
	mov	x11, #9187201950435737471
	movk	x11, #32512
	and	x11, x2, x11
	mov	x12, x1
LBB58_10:                               ; =>This Inner Loop Header: Depth=1
	and	x12, x11, x12, lsl #7
	orr	x10, x12, x10
	ands	x12, x12, x3
	b.ne	LBB58_10
; %bb.11:
	mov	x11, #0
	mov	x12, #-72340172838076674
	movk	x12, #254, lsl #48
	and	x12, x2, x12
LBB58_12:                               ; =>This Inner Loop Header: Depth=1
	and	x13, x12, x1, lsr #7
	orr	x11, x13, x11
	ands	x1, x13, x3
	b.ne	LBB58_12
	b	LBB58_22
LBB58_13:
	cbz	x1, LBB58_41
; %bb.14:
	mov	x8, #0
	mov	x9, x1
LBB58_15:                               ; =>This Inner Loop Header: Depth=1
	and	x9, x2, x9, lsl #8
	orr	x8, x9, x8
	ands	x9, x9, x3
	b.ne	LBB58_15
; %bb.16:
	mov	x10, x1
LBB58_17:                               ; =>This Inner Loop Header: Depth=1
	and	x10, x2, x10, lsr #8
	orr	x9, x10, x9
	ands	x10, x10, x3
	b.ne	LBB58_17
; %bb.18:
	and	x11, x2, #0x7f7f7f7f7f7f7f7f
	mov	x12, x1
LBB58_19:                               ; =>This Inner Loop Header: Depth=1
	and	x12, x11, x12, lsr #1
	orr	x10, x12, x10
	ands	x12, x12, x3
	b.ne	LBB58_19
; %bb.20:
	mov	x11, #0
	and	x12, x2, #0xfefefefefefefefe
LBB58_21:                               ; =>This Inner Loop Header: Depth=1
	and	x13, x12, x1, lsl #1
	orr	x11, x13, x11
	ands	x1, x13, x3
	b.ne	LBB58_21
LBB58_22:
	orr	x8, x9, x8
	orr	x8, x8, x10
	orr	x0, x8, x11
	ret
LBB58_23:
	cbz	x1, LBB58_41
; %bb.24:
	mov	x9, #0
	mov	x8, x1
LBB58_25:                               ; =>This Inner Loop Header: Depth=1
	and	x8, x2, x8, lsl #8
	orr	x9, x8, x9
	ands	x8, x8, x3
	b.ne	LBB58_25
; %bb.26:
	mov	x10, #0
	mov	x8, x1
LBB58_27:                               ; =>This Inner Loop Header: Depth=1
	and	x8, x2, x8, lsr #8
	orr	x10, x8, x10
	ands	x8, x8, x3
	b.ne	LBB58_27
; %bb.28:
	mov	x11, #0
	and	x8, x2, #0x7f7f7f7f7f7f7f7f
	mov	x12, x1
LBB58_29:                               ; =>This Inner Loop Header: Depth=1
	and	x12, x8, x12, lsr #1
	orr	x11, x12, x11
	ands	x12, x12, x3
	b.ne	LBB58_29
; %bb.30:
	and	x8, x2, #0xfefefefefefefefe
	mov	x13, x1
LBB58_31:                               ; =>This Inner Loop Header: Depth=1
	and	x13, x8, x13, lsl #1
	orr	x12, x13, x12
	ands	x13, x13, x3
	b.ne	LBB58_31
; %bb.32:
	mov	x8, #0
	orr	x9, x10, x9
	orr	x9, x9, x11
	orr	x9, x9, x12
	mov	x10, #-72340172838076674
	movk	x10, #65024
	and	x10, x2, x10
	mov	x11, x1
LBB58_33:                               ; =>This Inner Loop Header: Depth=1
	and	x11, x10, x11, lsl #9
	orr	x8, x11, x8
	ands	x11, x11, x3
	b.ne	LBB58_33
; %bb.34:
	mov	x10, #0
	mov	x11, #9187201950435737471
	movk	x11, #127, lsl #48
	and	x11, x2, x11
	mov	x12, x1
LBB58_35:                               ; =>This Inner Loop Header: Depth=1
	and	x12, x11, x12, lsr #9
	orr	x10, x12, x10
	ands	x12, x12, x3
	b.ne	LBB58_35
; %bb.36:
	mov	x11, #0
	mov	x12, #9187201950435737471
	movk	x12, #32512
	and	x12, x2, x12
	mov	x13, x1
LBB58_37:                               ; =>This Inner Loop Header: Depth=1
	and	x13, x12, x13, lsl #7
	orr	x11, x13, x11
	ands	x13, x13, x3
	b.ne	LBB58_37
; %bb.38:
	mov	x12, #0
	mov	x13, #-72340172838076674
	movk	x13, #254, lsl #48
	and	x13, x2, x13
LBB58_39:                               ; =>This Inner Loop Header: Depth=1
	and	x14, x13, x1, lsr #7
	orr	x12, x14, x12
	ands	x1, x14, x3
	b.ne	LBB58_39
; %bb.40:
	orr	x8, x8, x9
	orr	x8, x8, x10
	orr	x8, x8, x11
	orr	x0, x8, x12
	ret
LBB58_41:
	mov	x0, #0
	ret
LBB58_42:
	lsr	x8, x1, #1
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	lsl	x9, x1, #1
	and	x9, x9, #0xfefefefefefefefe
	lsl	x10, x1, #7
	and	x10, x10, #0x7f7f7f7f7f7f7f7f
	lsr	x11, x1, #9
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	lsl	x12, x1, #9
	and	x12, x12, #0xfefefefefefefefe
	lsr	x13, x1, #7
	and	x13, x13, #0xfefefefefefefefe
	orr	x8, x8, x9
	orr	x8, x8, x11
	orr	x8, x8, x12
	orr	x8, x8, x10
	orr	x8, x8, x13
	orr	x8, x8, x1, lsr #8
	orr	x8, x8, x1, lsl #8
	and	x0, x8, x2
	ret
	.loh AdrpAdd	Lloh18, Lloh19
	.cfi_endproc
	.section	__TEXT,__const
lJTI58_0:
	.byte	(LBB58_2-LBB58_2)>>2
	.byte	(LBB58_3-LBB58_2)>>2
	.byte	(LBB58_4-LBB58_2)>>2
	.byte	(LBB58_13-LBB58_2)>>2
	.byte	(LBB58_23-LBB58_2)>>2
	.byte	(LBB58_42-LBB58_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_possible_pawn_origins          ; -- Begin function possible_pawn_origins
	.p2align	2
_possible_pawn_origins:                 ; @possible_pawn_origins
	.cfi_startproc
; %bb.0:
	lsl	x8, x1, #8
	lsl	x9, x1, #9
	and	x9, x9, #0xfefefefefefefefe
	mov	x10, #9187201950435737471
	movk	x10, #32512
	and	x10, x10, x8, lsr #1
	orr	x9, x10, x9
	and	x10, x8, x2
	lsl	x10, x10, #8
	and	x10, x10, #0xff000000000000
	tst	w3, #0x1
	csel	x9, x9, x10, ne
	orr	x8, x9, x8
	lsr	x9, x1, #8
	lsl	x10, x9, #1
	and	x10, x10, #0xfefefefefefefefe
	lsr	x11, x1, #9
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	orr	x10, x10, x11
	and	w11, w9, w2
	lsr	w11, w11, #8
	and	x11, x11, #0xff00
	tst	w3, #0x1
	csel	x10, x10, x11, ne
	orr	x9, x10, x9
	cmp	w0, #1
	csel	x0, x8, x9, ne
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_determine_origin               ; -- Begin function determine_origin
	.p2align	2
_determine_origin:                      ; @determine_origin
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #448
	.cfi_def_cfa_offset 448
	stp	x28, x27, [sp, #352]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #368]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #384]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #400]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #416]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #432]            ; 16-byte Folded Spill
	add	x29, sp, #432
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
	mov	x21, x5
	mov	x24, x4
	mov	x23, x3
	str	w2, [sp, #28]                   ; 4-byte Folded Spill
	mov	x27, x1
	mov	x22, x0
Lloh20:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh21:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh22:
	ldr	x8, [x8]
	stur	x8, [x29, #-96]
	ldr	x0, [x0]
	ldp	x19, x20, [x0, #48]
	ldrb	w28, [x22, #8]
	cmp	x28, #1
	csel	x26, x20, x19, eq
	mov	w8, w1
	mov	x25, x28
	bfi	x25, x8, #8, #8
	mov	x1, x25
	bl	_get_piece_bb
	ands	x13, x0, x24
	b.eq	LBB60_4
; %bb.1:
	mov	w8, #1
	lsl	x24, x8, x23
	orr	x8, x20, x19
	mvn	x3, x8
	cmp	w27, #3
	b.ne	LBB60_5
; %bb.2:
	mov	w8, w23
	ldrh	w9, [x22, #10]
	lsl	x10, x9, #55
	mov	w11, #1
	lsl	x9, x11, x9
	and	x9, x9, x10, asr #63
	orr	x26, x9, x26
	mov	w9, #256
	lsl	x9, x9, x8
	mov	w10, #512
	lsl	x10, x10, x8
	and	x10, x10, #0xfefefefefefefefe
	mov	w11, #128
	lsl	x8, x11, x8
	and	x8, x8, #0x7f7f7f7f7f7f7f7f
	orr	x8, x8, x10
	and	x10, x9, x3
	lsl	x10, x10, #8
	and	x10, x10, #0xff000000000000
	ldr	w12, [sp, #28]                  ; 4-byte Folded Reload
	tst	w12, #0x1
	csel	x8, x8, x10, ne
	orr	x8, x8, x9
	lsr	x9, x24, #8
	lsl	x10, x9, #1
	and	x10, x10, #0xfefefefefefefefe
	lsr	x11, x24, #9
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	orr	x10, x10, x11
	and	w11, w9, w3
	lsr	w11, w11, #8
	and	x11, x11, #0xff00
	tst	w12, #0x1
	csel	x10, x10, x11, ne
	orr	x9, x10, x9
	cmp	w28, #1
	csel	x0, x8, x9, ne
	mov	x28, x21
	mov	x20, x23
	tst	x26, x24
	cset	w8, eq
	eor	w8, w8, w12
	tbnz	w8, #0, LBB60_6
LBB60_3:
	add	x19, sp, #80
	add	x1, sp, #80
	mov	x0, x27
	bl	_write_name
	add	x21, sp, #56
	add	x1, sp, #56
	mov	x0, x20
	bl	_serialize_square
	stp	x19, x21, [sp]
Lloh23:
	adrp	x1, l_.str.3@PAGE
Lloh24:
	add	x1, x1, l_.str.3@PAGEOFF
	b	LBB60_14
LBB60_4:
	add	x19, sp, #80
	add	x1, sp, #80
	mov	x0, x27
	bl	_write_name
	add	x1, sp, #56
	mov	x0, x23
	bl	_serialize_square
	ldrb	w8, [x22, #8]
Lloh25:
	adrp	x9, l_.str.2@PAGE
Lloh26:
	add	x9, x9, l_.str.2@PAGEOFF
Lloh27:
	adrp	x10, l_.str.1@PAGE
Lloh28:
	add	x10, x10, l_.str.1@PAGEOFF
	cmp	w8, #1
	csel	x8, x10, x9, eq
	stp	x8, x19, [sp]
Lloh29:
	adrp	x1, l_.str@PAGE
Lloh30:
	add	x1, x1, l_.str@PAGEOFF
	mov	x0, x21
	b	LBB60_15
LBB60_5:
	mov	x0, x25
	mov	x1, x24
	mov	x2, #-1
	mov	x19, x13
	bl	_piece_attack_mask
	mov	x13, x19
	mov	x28, x21
	mov	x20, x23
	ldr	w12, [sp, #28]                  ; 4-byte Folded Reload
	tst	x26, x24
	cset	w8, eq
	eor	w8, w8, w12
	tbz	w8, #0, LBB60_3
LBB60_6:
	ands	x0, x0, x13
	b.eq	LBB60_13
; %bb.7:
	bl	_bitboard_to_square
	tbnz	w0, #8, LBB60_18
; %bb.8:
	ldrb	w23, [x22, #8]
	cmp	w23, #1
	cset	w1, ne
	mov	x0, x22
	bl	_make_attack_mask
	mov	x24, x0
	add	x8, sp, #56
	mov	x0, x22
	mov	x1, x23
	mov	x2, x24
	bl	_make_check_info
	ldr	x0, [x22]
	mov	x21, x27
	mov	x1, x27
	bl	_get_piece_type_bb
	mov	x4, x0
	ldur	q0, [sp, #56]
	str	q0, [sp, #32]
	ldr	x8, [sp, #72]
	str	x8, [sp, #48]
	add	x3, sp, #32
	add	x5, sp, #80
	mov	x0, x22
	mov	x1, x23
	mov	x2, x24
	bl	_generate_moves
	mov	x22, #0
	cbz	w0, LBB60_19
; %bb.9:
	add	x25, sp, #80
	mov	w26, #1
                                        ; implicit-def: $x23
                                        ; implicit-def: $x24
	mov	w27, w0
	b	LBB60_11
LBB60_10:                               ;   in Loop: Header=BB60_11 Depth=1
	add	x25, x25, #4
	subs	x27, x27, #1
	b.eq	LBB60_19
LBB60_11:                               ; =>This Inner Loop Header: Depth=1
	ldr	w19, [x25]
	and	x8, x24, #0xffffffff00000000
	orr	x24, x8, x19
	mov	x0, x24
	bl	_get_destination
	cmp	w0, w20
	b.ne	LBB60_10
; %bb.12:                               ;   in Loop: Header=BB60_11 Depth=1
	and	x8, x23, #0xffffffff00000000
	orr	x23, x8, x19
	mov	x0, x23
	bl	_get_origin
                                        ; kill: def $w0 killed $w0 def $x0
	lsl	x8, x26, x0
	orr	x22, x8, x22
	b	LBB60_10
LBB60_13:
	add	x19, sp, #80
	add	x1, sp, #80
	mov	x0, x27
	bl	_write_name
	add	x21, sp, #56
	add	x1, sp, #56
	mov	x0, x20
	bl	_serialize_square
	stp	x19, x21, [sp]
Lloh31:
	adrp	x1, l_.str.4@PAGE
Lloh32:
	add	x1, x1, l_.str.4@PAGEOFF
LBB60_14:
	mov	x0, x28
LBB60_15:
	bl	_sprintf
	mov	w8, #0
                                        ; implicit-def: $w23
LBB60_16:
	ldur	x9, [x29, #-96]
Lloh33:
	adrp	x10, ___stack_chk_guard@GOTPAGE
Lloh34:
	ldr	x10, [x10, ___stack_chk_guard@GOTPAGEOFF]
Lloh35:
	ldr	x10, [x10]
	cmp	x10, x9
	b.ne	LBB60_22
; %bb.17:
	and	w0, w23, #0xff
	bfi	w0, w8, #8, #8
	ldp	x29, x30, [sp, #432]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #416]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #400]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #384]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #368]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #352]            ; 16-byte Folded Reload
	add	sp, sp, #448
	ret
LBB60_18:
	mov	x23, x0
	ubfx	w8, w0, #8, #8
	b	LBB60_16
LBB60_19:
	mov	x0, x22
	bl	_bitboard_to_square
	mov	x23, x0
	tbnz	w0, #8, LBB60_21
; %bb.20:
	add	x19, sp, #80
	add	x1, sp, #80
	mov	x0, x21
	bl	_write_name
	add	x21, sp, #56
	add	x1, sp, #56
	mov	x0, x20
	bl	_serialize_square
	stp	x19, x21, [sp]
Lloh36:
	adrp	x1, l_.str.5@PAGE
Lloh37:
	add	x1, x1, l_.str.5@PAGEOFF
	mov	x0, x28
	bl	_sprintf
	mov	w8, #0
	b	LBB60_16
LBB60_21:
	ubfx	w8, w23, #8, #8
	b	LBB60_16
LBB60_22:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh20, Lloh21, Lloh22
	.loh AdrpAdd	Lloh23, Lloh24
	.loh AdrpAdd	Lloh29, Lloh30
	.loh AdrpAdd	Lloh27, Lloh28
	.loh AdrpAdd	Lloh25, Lloh26
	.loh AdrpAdd	Lloh31, Lloh32
	.loh AdrpLdrGotLdr	Lloh33, Lloh34, Lloh35
	.loh AdrpAdd	Lloh36, Lloh37
	.cfi_endproc
                                        ; -- End function
	.globl	_generate_piece_moves           ; -- Begin function generate_piece_moves
	.p2align	2
_generate_piece_moves:                  ; @generate_piece_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
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
	mov	x19, x2
	mov	x20, x1
	mov	x21, x0
	ldrb	w22, [x0, #8]
	cmp	w22, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x23, x0
	add	x8, sp, #24
	mov	x0, x21
	mov	x1, x22
	mov	x2, x23
	bl	_make_check_info
	ldr	x0, [x21]
	mov	x1, x20
	bl	_get_piece_type_bb
	mov	x4, x0
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x21
	mov	x1, x22
	mov	x2, x23
	mov	x5, x19
	bl	_generate_moves
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_san_pawn_push_to_move          ; -- Begin function san_pawn_push_to_move
	.p2align	2
_san_pawn_push_to_move:                 ; @san_pawn_push_to_move
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
	mov	x5, x2
	mov	x19, x1
	ubfx	x3, x1, #32, #8
	mov	w1, #3
	mov	w2, #0
                                        ; kill: def $w3 killed $w3 killed $x3
	mov	x4, #-1
	bl	_determine_origin
	tbnz	w0, #8, LBB62_2
; %bb.1:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_error_move
LBB62_2:
	lsr	x8, x19, #32
	and	x20, x19, #0xff0000000000
	and	w0, w0, #0xff
	and	w1, w8, #0xff
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	and	x0, x0, #0xffff
	cbz	x20, LBB62_4
; %bb.3:
	lsr	x8, x19, #40
	and	w1, w8, #0xff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_promotion_move
LBB62_4:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_generic_move
	.cfi_endproc
                                        ; -- End function
	.globl	_san_pawn_capture_to_move       ; -- Begin function san_pawn_capture_to_move
	.p2align	2
_san_pawn_capture_to_move:              ; @san_pawn_capture_to_move
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
	mov	x5, x2
	mov	x19, x1
	mov	x8, #72340172838076673
	lsl	x8, x8, x1
	lsr	x9, x1, #13
	and	x9, x9, #0x7f8
	mov	w10, #255
	lsl	x9, x10, x9
	tst	x1, #0x100
	csinv	x9, x9, xzr, ne
	and	x4, x9, x8
	ubfx	x3, x1, #24, #8
	mov	w1, #3
	mov	w2, #1
                                        ; kill: def $w3 killed $w3 killed $x3
	bl	_determine_origin
	tbnz	w0, #8, LBB63_2
; %bb.1:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_error_move
LBB63_2:
	lsr	x8, x19, #24
	and	x20, x19, #0xff00000000
	and	w0, w0, #0xff
	and	w1, w8, #0xff
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	and	x0, x0, #0xffff
	cbz	x20, LBB63_4
; %bb.3:
	lsr	x8, x19, #32
	and	w1, w8, #0xff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_promotion_move
LBB63_4:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_generic_move
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function san_std_to_move
lCPI64_0:
	.quad	256                             ; 0x100
	.quad	16777216                        ; 0x1000000
lCPI64_1:
	.quad	-16                             ; 0xfffffffffffffff0
	.quad	-29                             ; 0xffffffffffffffe3
lCPI64_2:
	.quad	255                             ; 0xff
	.quad	2040                            ; 0x7f8
lCPI64_3:
	.quad	72340172838076673               ; 0x101010101010101
	.quad	255                             ; 0xff
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_san_std_to_move
	.p2align	2
_san_std_to_move:                       ; @san_std_to_move
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
	mov	x5, x2
	mov	x19, x1
	dup.2d	v0, x1
Lloh38:
	adrp	x8, lCPI64_0@PAGE
Lloh39:
	ldr	q1, [x8, lCPI64_0@PAGEOFF]
	and.16b	v1, v0, v1
Lloh40:
	adrp	x8, lCPI64_1@PAGE
Lloh41:
	ldr	q2, [x8, lCPI64_1@PAGEOFF]
	ushl.2d	v0, v0, v2
	cmeq.2d	v1, v1, #0
Lloh42:
	adrp	x8, lCPI64_2@PAGE
Lloh43:
	ldr	q2, [x8, lCPI64_2@PAGEOFF]
	and.16b	v0, v0, v2
Lloh44:
	adrp	x8, lCPI64_3@PAGE
Lloh45:
	ldr	q2, [x8, lCPI64_3@PAGEOFF]
	ushl.2d	v0, v2, v0
	orr.16b	v0, v0, v1
	dup.2d	v1, v0[1]
	and.16b	v0, v0, v1
	fmov	x4, d0
	ubfx	x2, x1, #40, #1
	and	w1, w19, #0xff
	ubfx	x3, x19, #48, #8
                                        ; kill: def $w2 killed $w2 killed $x2
                                        ; kill: def $w3 killed $w3 killed $x3
	bl	_determine_origin
	tbnz	w0, #8, LBB64_2
; %bb.1:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_error_move
LBB64_2:
	lsr	x8, x19, #48
	and	w0, w0, #0xff
	and	w1, w8, #0xff
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	and	x0, x0, #0xffff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_generic_move
	.loh AdrpLdr	Lloh44, Lloh45
	.loh AdrpAdrp	Lloh42, Lloh44
	.loh AdrpLdr	Lloh42, Lloh43
	.loh AdrpAdrp	Lloh40, Lloh42
	.loh AdrpLdr	Lloh40, Lloh41
	.loh AdrpAdrp	Lloh38, Lloh40
	.loh AdrpLdr	Lloh38, Lloh39
	.cfi_endproc
                                        ; -- End function
	.globl	_san_castling_to_move           ; -- Begin function san_castling_to_move
	.p2align	2
_san_castling_to_move:                  ; @san_castling_to_move
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldrb	w8, [x0, #8]
	mov	w9, #62
	mov	w10, #6
	cmp	w8, #1
	csel	w8, w10, w9, eq
	mov	w9, #58
	mov	w10, #2
	csel	w9, w10, w9, eq
	mov	w10, #60
	mov	w11, #4
	csel	w0, w11, w10, eq
	cmp	w1, #0
	csel	w1, w8, w9, ne
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	and	x0, x0, #0xffff
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_generic_move
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function san_to_move
lCPI66_0:
	.quad	256                             ; 0x100
	.quad	16777216                        ; 0x1000000
lCPI66_1:
	.quad	-16                             ; 0xfffffffffffffff0
	.quad	-29                             ; 0xffffffffffffffe3
lCPI66_2:
	.quad	255                             ; 0xff
	.quad	2040                            ; 0x7f8
lCPI66_3:
	.quad	72340172838076673               ; 0x101010101010101
	.quad	255                             ; 0xff
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_san_to_move
	.p2align	2
_san_to_move:                           ; @san_to_move
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
	mov	x5, x3
	lsr	x8, x1, #56
	sub	w8, w8, #1
	cmp	w8, #3
	b.hi	LBB66_4
; %bb.1:
	mov	x19, x1
Lloh46:
	adrp	x9, lJTI66_0@PAGE
Lloh47:
	add	x9, x9, lJTI66_0@PAGEOFF
	adr	x10, LBB66_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB66_2:
	dup.2d	v0, x19
Lloh48:
	adrp	x8, lCPI66_0@PAGE
Lloh49:
	ldr	q1, [x8, lCPI66_0@PAGEOFF]
	and.16b	v1, v0, v1
Lloh50:
	adrp	x8, lCPI66_1@PAGE
Lloh51:
	ldr	q2, [x8, lCPI66_1@PAGEOFF]
	ushl.2d	v0, v0, v2
	cmeq.2d	v1, v1, #0
Lloh52:
	adrp	x8, lCPI66_2@PAGE
Lloh53:
	ldr	q2, [x8, lCPI66_2@PAGEOFF]
	and.16b	v0, v0, v2
Lloh54:
	adrp	x8, lCPI66_3@PAGE
Lloh55:
	ldr	q2, [x8, lCPI66_3@PAGEOFF]
	ushl.2d	v0, v2, v0
	orr.16b	v0, v0, v1
	dup.2d	v1, v0[1]
	and.16b	v0, v0, v1
	fmov	x4, d0
	ubfx	x2, x19, #40, #1
	and	w1, w19, #0xff
	ubfx	x3, x19, #48, #8
                                        ; kill: def $w2 killed $w2 killed $x2
                                        ; kill: def $w3 killed $w3 killed $x3
	bl	_determine_origin
	tbz	w0, #8, LBB66_9
; %bb.3:
	lsr	x8, x19, #48
	and	w0, w0, #0xff
	and	w1, w8, #0xff
	b	LBB66_11
LBB66_4:
	mov	w8, #16723
	movk	w8, #78, lsl #16
	str	w8, [x5, #8]
Lloh56:
	adrp	x8, l_.str.6@PAGE
Lloh57:
	add	x8, x8, l_.str.6@PAGEOFF
Lloh58:
	ldr	x8, [x8]
	str	x8, [x5]
	b	LBB66_9
LBB66_5:
	ubfx	x3, x19, #32, #8
	mov	w1, #3
	mov	w2, #0
                                        ; kill: def $w3 killed $w3 killed $x3
	mov	x4, #-1
	bl	_determine_origin
	tbz	w0, #8, LBB66_9
; %bb.6:
	lsr	x8, x19, #32
	and	x20, x19, #0xff0000000000
	and	w0, w0, #0xff
	and	w1, w8, #0xff
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	and	x0, x0, #0xffff
	cbz	x20, LBB66_12
; %bb.7:
	lsr	x8, x19, #40
	and	w1, w8, #0xff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_promotion_move
LBB66_8:
	mov	x8, #72340172838076673
	lsl	x8, x8, x19
	lsr	x9, x19, #13
	and	x9, x9, #0x7f8
	mov	w10, #255
	lsl	x9, x10, x9
	tst	x19, #0x100
	csinv	x9, x9, xzr, ne
	and	x4, x9, x8
	ubfx	x3, x19, #24, #8
	mov	w1, #3
	mov	w2, #1
                                        ; kill: def $w3 killed $w3 killed $x3
	bl	_determine_origin
	tbnz	w0, #8, LBB66_13
LBB66_9:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_error_move
LBB66_10:
	ldrb	w8, [x0, #8]
	mov	w9, #62
	mov	w10, #6
	cmp	w8, #1
	csel	w8, w10, w9, eq
	mov	w9, #58
	mov	w10, #2
	csel	w9, w10, w9, eq
	mov	w10, #60
	mov	w11, #4
	csel	w0, w11, w10, eq
	tst	x19, #0x1
	csel	w1, w9, w8, eq
LBB66_11:
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	and	x0, x0, #0xffff
LBB66_12:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_generic_move
LBB66_13:
	lsr	x8, x19, #24
	and	x20, x19, #0xff00000000
	and	w0, w0, #0xff
	and	w1, w8, #0xff
	bl	_move_body
                                        ; kill: def $w0 killed $w0 def $x0
	and	x0, x0, #0xffff
	cbz	x20, LBB66_12
; %bb.14:
	lsr	x8, x19, #32
	and	w1, w8, #0xff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_promotion_move
	.loh AdrpAdd	Lloh46, Lloh47
	.loh AdrpLdr	Lloh54, Lloh55
	.loh AdrpAdrp	Lloh52, Lloh54
	.loh AdrpLdr	Lloh52, Lloh53
	.loh AdrpAdrp	Lloh50, Lloh52
	.loh AdrpLdr	Lloh50, Lloh51
	.loh AdrpAdrp	Lloh48, Lloh50
	.loh AdrpLdr	Lloh48, Lloh49
	.loh AdrpAddLdr	Lloh56, Lloh57, Lloh58
	.cfi_endproc
	.section	__TEXT,__const
lJTI66_0:
	.byte	(LBB66_2-LBB66_2)>>2
	.byte	(LBB66_5-LBB66_2)>>2
	.byte	(LBB66_8-LBB66_2)>>2
	.byte	(LBB66_10-LBB66_2)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_san_str_to_move                ; -- Begin function san_str_to_move
	.p2align	2
_san_str_to_move:                       ; @san_str_to_move
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
	mov	x20, x3
	mov	x19, x2
	mov	x8, x1
	mov	x21, x0
	add	x1, sp, #15
	mov	x0, x8
	bl	_parse_san
	ldrb	w8, [sp, #15]
	cbz	w8, LBB67_3
; %bb.1:
	mov	w8, #1
	strb	w8, [x19]
	bl	_error_move
	lsr	w8, w0, #24
LBB67_2:
	bfi	w0, w8, #24, #8
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB67_3:
	mov	x3, x0
	and	x2, x1, #0xffff
	mov	x0, x21
	mov	x1, x3
	mov	x3, x20
	bl	_san_to_move
	lsr	w8, w0, #24
	cmp	w8, #1
	b.ne	LBB67_2
; %bb.4:
	strb	w8, [x19]
	bfi	w0, w8, #24, #8
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_promotion_to_san               ; -- Begin function promotion_to_san
	.p2align	2
_promotion_to_san:                      ; @promotion_to_san
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
	mov	x19, x1
	ubfx	x23, x1, #8, #8
	mov	w24, #1
	lsl	x20, x24, x1
	ldr	x8, [x0]
	ldp	x25, x26, [x8, #48]
	ldr	x8, [x8]
	cmp	x23, #7
	b.ls	LBB68_4
; %bb.1:
	cmp	x23, #56
	b.lo	LBB68_9
; %bb.2:
	and	x8, x8, x20
	and	x8, x8, x25
	tst	x8, #0xff000000000000
	b.eq	LBB68_9
; %bb.3:
	mov	w0, #3
	bl	_white_piece
                                        ; kill: def $w0 killed $w0 def $x0
	mov	x27, x26
	b	LBB68_6
LBB68_4:
	and	w8, w8, w20
	and	w8, w8, w26
	tst	x8, #0xff00
	b.eq	LBB68_9
; %bb.5:
	mov	w0, #3
	bl	_black_piece
                                        ; kill: def $w0 killed $w0 def $x0
	mov	x27, x25
LBB68_6:
	lsr	x21, x19, #8
	lsr	x22, x19, #16
	lsl	x24, x24, x21
	orr	x25, x26, x25
	and	x0, x0, #0xffff
	mov	x1, x20
	mov	x2, #-1
	mov	x3, #-1
	bl	_piece_attack_mask
	tst	x25, x24
	b.eq	LBB68_11
LBB68_7:
	and	x8, x0, x27
	tst	x8, x24
	b.eq	LBB68_9
; %bb.8:
	and	w0, w19, #0xff
	bl	_file_char_of_square
	mov	x8, #0
	mov	x9, #0
	mov	x12, #0
	mov	x1, #0
	and	w10, w0, #0xff
	sub	w0, w10, #97
	mov	x11, #216172782113783808
	mov	x10, x21
	mov	x21, x22
	mov	x22, #0
	b	LBB68_10
LBB68_9:
	bl	_error_san
	and	x8, x0, #0xffffffffffffff00
	and	x9, x0, #0xffffffffffff0000
	lsr	x10, x0, #24
	lsr	x21, x0, #32
	lsr	x22, x0, #40
	and	x12, x0, #0xffff000000000000
	and	x11, x0, #0xff00000000000000
LBB68_10:
	and	x12, x12, #0xff000000000000
	ubfiz	x13, x22, #40, #8
	lsl	w10, w10, #24
	and	x9, x9, #0xff0000
	and	x8, x8, #0xff00
	bfxil	x8, x0, #0, #8
	orr	x8, x8, x9
	orr	x8, x8, x10
	bfi	x8, x21, #32, #8
	orr	x8, x8, x12
	orr	x8, x8, x11
	orr	x0, x8, x13
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB68_11:
	cmp	x23, #7
	b.hi	LBB68_13
; %bb.12:
	lsr	x8, x20, #8
	cmp	x24, x8
	b.eq	LBB68_15
LBB68_13:
	cmp	x23, #8
	b.lo	LBB68_7
; %bb.14:
	and	x8, x19, #0xff
	mov	w9, #256
	lsl	x8, x9, x8
	cmp	x24, x8
	b.ne	LBB68_7
LBB68_15:
	mov	x0, #0
	mov	x8, #0
	mov	x9, #0
	mov	x10, #0
	mov	x12, #0
	mov	x1, #0
	mov	x11, #144115188075855872
	b	LBB68_10
	.cfi_endproc
                                        ; -- End function
	.globl	_pawn_generic_to_san            ; -- Begin function pawn_generic_to_san
	.p2align	2
_pawn_generic_to_san:                   ; @pawn_generic_to_san
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
	lsr	x19, x1, #8
	ldr	x8, [x0]
	mov	w10, #48
	ldp	x9, x11, [x8, #48]
	orr	x9, x11, x9
	mov	w11, #56
	mvn	x9, x9
	cmp	w2, #1
	csel	x10, x11, x10, eq
	ldr	x10, [x8, x10]
	mov	w11, #1
	lsl	x8, x11, x19
	ldrh	w12, [x0, #10]
	lsl	x13, x12, #55
	lsl	x12, x11, x12
	and	x12, x12, x13, asr #63
	orr	x10, x12, x10
	and	x12, x10, x8
	b.ne	LBB69_3
; %bb.1:
	and	x11, x1, #0xff
	cbz	x12, LBB69_6
; %bb.2:
	mov	w9, #512
	lsl	x9, x9, x11
	and	x9, x9, #0xfefefefefefefefe
	mov	w12, #128
	lsl	x11, x12, x11
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x11
	and	x8, x8, x9
	tst	x8, x10
	b.ne	LBB69_5
	b	LBB69_9
LBB69_3:
	lsl	x11, x11, x1
	cbz	x12, LBB69_8
; %bb.4:
	lsr	x9, x11, #7
	and	x9, x9, #0xfefefefefefefefe
	lsr	x11, x11, #9
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x11
	and	x8, x8, x9
	tst	x8, x10
	b.eq	LBB69_9
LBB69_5:
	and	w0, w1, #0xff
	bl	_file_char_of_square
	mov	x12, #0
	mov	x11, #0
	mov	x10, #0
	mov	x9, #0
	mov	x1, #0
	and	w8, w0, #0xff
	sub	w0, w8, #97
	mov	x8, #216172782113783808
	mov	x13, x19
	mov	x19, #0
	b	LBB69_10
LBB69_6:
	mov	w10, #256
	lsl	x10, x10, x11
	and	w11, w10, w9
	lsl	w11, w11, #8
	and	x11, x11, #0xff000000
	orr	x10, x11, x10
	and	x9, x10, x9
	tst	x9, x8
	b.eq	LBB69_9
LBB69_7:
	mov	x0, #0
	mov	x12, #0
	mov	x11, #0
	mov	x13, #0
	mov	x10, #0
	mov	x9, #0
	mov	x1, #0
	mov	x8, #144115188075855872
	b	LBB69_10
LBB69_8:
	lsr	x10, x11, #8
	and	x11, x10, x9
	lsr	x11, x11, #8
	and	x11, x11, #0xff00000000
	orr	x10, x11, x10
	and	x9, x10, x9
	tst	x9, x8
	b.ne	LBB69_7
LBB69_9:
	bl	_error_san
	lsr	x13, x0, #24
	lsr	x19, x0, #32
	and	x8, x0, #0xff00000000000000
	and	x9, x0, #0xff000000000000
	and	x10, x0, #0xff0000000000
	and	x11, x0, #0xff0000
	and	x12, x0, #0xff00
	and	x1, x1, #0xffff
LBB69_10:
	ubfiz	x14, x19, #32, #8
	lsl	w13, w13, #24
	and	x15, x0, #0xff
	orr	x12, x15, x12
	orr	x11, x12, x11
	orr	x10, x11, x10
	orr	x10, x10, x13
	orr	x9, x10, x9
	orr	x9, x9, x14
	orr	x0, x9, x8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_other_generic_to_san           ; -- Begin function other_generic_to_san
	.p2align	2
_other_generic_to_san:                  ; @other_generic_to_san
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
	lsr	x24, x1, #8
	lsr	x19, x2, #8
	ldr	x21, [x0]
	mov	w8, #1
	lsl	x1, x8, x24
	lsl	x26, x8, x20
	ldp	x8, x9, [x21, #48]
	orr	x10, x9, x8
	mvn	x3, x10
	and	x10, x2, #0xff
	cmp	x10, #1
	csel	x8, x9, x8, eq
	tst	x8, x1
	cset	w25, ne
	and	x22, x2, #0xffff
	mov	x0, x22
	mov	x2, #-1
	bl	_piece_attack_mask
	mov	x23, x0
	mov	x0, x21
	mov	x1, x22
	bl	_get_piece_bb
	and	x23, x0, x23
	cmp	x26, x23
	b.ne	LBB70_2
; %bb.1:
	mov	x10, #0
	mov	x8, #0
	mov	x9, #0
	mov	x21, #0
	mov	x1, #0
	mov	x11, #72057594037927936
	b	LBB70_10
LBB70_2:
	tst	x23, x26
	b.eq	LBB70_5
; %bb.3:
	mov	w22, #-97
	and	w21, w20, #0xff
	mov	x0, x21
	bl	_file_bb_of_square
	and	x27, x0, x23
	and	w0, w24, #0xff
	bl	_rank_bb_of_square
	cmp	x27, x26
	b.ne	LBB70_6
; %bb.4:
	mov	x0, x21
	bl	_file_char_of_square
	mov	x9, #0
	mov	x21, #0
	mov	x1, #0
	add	w8, w22, w0, uxtb
	mov	x11, #72057594037927936
	b	LBB70_9
LBB70_5:
	bl	_error_san
	mov	x19, x0
	lsr	x8, x0, #16
	lsr	x21, x0, #32
	lsr	x25, x0, #40
	lsr	x24, x0, #48
	and	x11, x0, #0xff00000000000000
	and	x1, x1, #0xffff
	and	x9, x0, #0xff000000
	and	x10, x0, #0xff00
	b	LBB70_10
LBB70_6:
	and	x23, x0, x23
	mov	x0, x21
	bl	_rank_char_of_square
	add	w8, w22, w0, uxtb
	add	w21, w8, #48
	cmp	x23, x26
	b.ne	LBB70_8
; %bb.7:
	mov	x10, #0
	mov	x8, #0
	mov	x1, #0
	mov	x11, #72057594037927936
	mov	w9, #16777216
	b	LBB70_10
LBB70_8:
	and	w0, w20, #0xff
	bl	_file_char_of_square
	mov	x1, #0
	add	w8, w22, w0, uxtb
	mov	x11, #72057594037927936
	mov	w9, #16777216
LBB70_9:
	mov	w10, #256
LBB70_10:
	ubfiz	x12, x24, #48, #8
	orr	x11, x11, x12
	and	w12, w25, #0xff
	orr	x11, x11, x12, lsl #40
	ubfiz	x12, x21, #32, #8
	orr	x11, x11, x12
	lsl	w8, w8, #16
	and	x8, x8, #0xff0000
	orr	x9, x11, x9
	and	x11, x19, #0xff
	orr	x8, x9, x8
	orr	x9, x11, x10
	orr	x0, x9, x8
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_generic_to_san                 ; -- Begin function generic_to_san
	.p2align	2
_generic_to_san:                        ; @generic_to_san
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
	mov	x20, x1
	mov	x19, x0
	ldr	x0, [x0]
	and	w1, w20, #0xff
	bl	_get_piece_at
                                        ; kill: def $w0 killed $w0 def $x0
	ubfx	w8, w0, #8, #8
	cmp	w8, #3
	b.eq	LBB71_3
; %bb.1:
	cbnz	w8, LBB71_4
; %bb.2:
	bl	_error_san
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB71_3:
	and	x1, x20, #0xffff
	and	w2, w0, #0xff
	mov	x0, x19
	bl	_pawn_generic_to_san
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB71_4:
	and	x1, x20, #0xffff
	and	x2, x0, #0xffff
	mov	x0, x19
	bl	_other_generic_to_san
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_castling_to_san                ; -- Begin function castling_to_san
	.p2align	2
_castling_to_san:                       ; @castling_to_san
	.cfi_startproc
; %bb.0:
	mov	w8, #5
	tst	w0, w8
	cset	w8, ne
	orr	x0, x8, #0x400000000000000
	mov	x1, #0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_move_to_san_inner              ; -- Begin function move_to_san_inner
	.p2align	2
_move_to_san_inner:                     ; @move_to_san_inner
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
	mov	x21, x1
	mov	x19, x0
	and	x0, x1, #0xffffffff
	mov	x1, x19
	bl	_get_castling_type
	cbz	w0, LBB73_2
; %bb.1:
	mov	x1, #0
	mov	w8, #5
	tst	w0, w8
	cset	w8, ne
	orr	x0, x8, #0x400000000000000
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB73_2:
	ubfx	x8, x21, #24, #8
	cmp	w8, #2
	b.eq	LBB73_5
; %bb.3:
	cmp	w8, #3
	b.ne	LBB73_8
; %bb.4:
	and	x1, x21, #0xffffff
	mov	x0, x19
	bl	_promotion_to_san
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB73_5:
	and	x20, x21, #0xffff
	ldr	x0, [x19]
	and	w1, w21, #0xff
	bl	_get_piece_at
                                        ; kill: def $w0 killed $w0 def $x0
	ubfx	w8, w0, #8, #8
	cmp	w8, #3
	b.eq	LBB73_9
; %bb.6:
	cbnz	w8, LBB73_10
; %bb.7:
	bl	_error_san
	and	x1, x1, #0xffff
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB73_8:
	bl	_error_san
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB73_9:
	and	w2, w0, #0xff
	mov	x0, x19
	mov	x1, x20
	bl	_pawn_generic_to_san
	and	x1, x1, #0xffff
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB73_10:
	and	x2, x0, #0xffff
	mov	x0, x19
	mov	x1, x20
	bl	_other_generic_to_san
	and	x1, x1, #0xffff
	and	x1, x1, #0xffff
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_status_of_app                  ; -- Begin function status_of_app
	.p2align	2
_status_of_app:                         ; @status_of_app
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x1
	mov	x1, x0
	mov	x8, sp
	stur	x8, [x29, #-32]
	sub	x0, x29, #32
	bl	_copy_into
	and	x1, x19, #0xffffffff
	sub	x0, x29, #32
	bl	_apply_move
	sub	x0, x29, #32
	mov	x1, #0
	mov	w2, #0
	bl	_get_status
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_status                     ; -- Begin function get_status
	.p2align	2
_get_status:                            ; @get_status
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
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
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
	ldrb	w22, [x0, #8]
	cmp	w22, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x23, x0
	add	x8, sp, #24
	mov	x0, x19
	mov	x1, x22
	mov	x2, x23
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x19
	mov	x1, x22
	mov	x2, x23
	bl	_has_moves
	ldrb	w8, [sp, #40]
	cmp	w8, #0
	cset	w22, ne
	cbz	w0, LBB75_11
; %bb.1:
	cbz	x21, LBB75_4
; %bb.2:
	cbz	w20, LBB75_4
; %bb.3:
	mov	x0, x19
	mov	x1, x21
	mov	x2, x20
	bl	_get_repetition_outcome
	orr	w22, w0, w22
LBB75_4:
	mov	x0, x19
	bl	_can_claim_fifty
	orr	w8, w22, #0x8
	cmp	w0, #0
	csel	w8, w8, w22, ne
	ldrh	w9, [x19, #12]
	orr	w10, w8, #0x10
	cmp	w9, #149
	csel	w20, w10, w8, hi
	ldr	x19, [x19]
	ldr	x8, [x19]
	cbnz	x8, LBB75_12
; %bb.5:
	ldr	x8, [x19, #24]
	cbnz	x8, LBB75_12
; %bb.6:
	ldr	x8, [x19, #32]
	cbnz	x8, LBB75_12
; %bb.7:
	ldp	x8, x0, [x19, #8]
	cbz	x0, LBB75_13
; %bb.8:
	cbnz	x8, LBB75_12
; %bb.9:
	bl	_count_bits
	cmp	w0, #2
	b.lo	LBB75_14
; %bb.10:
	ldr	x8, [x19, #16]
	mov	x9, #21930
	movk	x9, #21930, lsl #16
	movk	x9, #21930, lsl #32
	movk	x9, #21930, lsl #48
	and	x9, x8, x9
	mov	x10, #43605
	movk	x10, #43605, lsl #16
	movk	x10, #43605, lsl #32
	movk	x10, #43605, lsl #48
	tst	x8, x10
	ccmp	x9, #0, #4, ne
	b.ne	LBB75_12
	b	LBB75_14
LBB75_11:
	orr	w20, w22, #0x2
LBB75_12:
	mov	x0, x20
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB75_13:
	mov	x0, x8
	bl	_count_bits
	cmp	w0, #2
	b.hs	LBB75_12
LBB75_14:
	orr	w20, w20, #0x4
	b	LBB75_12
	.cfi_endproc
                                        ; -- End function
	.globl	_move_to_san                    ; -- Begin function move_to_san
	.p2align	2
_move_to_san:                           ; @move_to_san
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x0
	and	x20, x1, #0xffffffff
	mov	x1, x20
	bl	_move_to_san_inner
	mov	x21, x0
	mov	x8, sp
	stur	x8, [x29, #-48]
	sub	x0, x29, #48
	mov	x1, x19
	bl	_copy_into
	sub	x0, x29, #48
	mov	x1, x20
	bl	_apply_move
	sub	x0, x29, #48
	mov	x1, #0
	mov	w2, #0
	bl	_get_status
	tst	w0, #0x2
	mov	w8, #512
	mov	w9, #256
	csel	x8, x9, x8, eq
	tst	w0, #0x1
	csel	x1, xzr, x8, eq
	mov	x0, x21
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_move_to_san_str                ; -- Begin function move_to_san_str
	.p2align	2
_move_to_san_str:                       ; @move_to_san_str
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x2
	mov	x20, x0
	and	x21, x1, #0xffffffff
	mov	x1, x21
	bl	_move_to_san_inner
	mov	x22, x0
	mov	x8, sp
	stur	x8, [x29, #-48]
	sub	x0, x29, #48
	mov	x1, x20
	bl	_copy_into
	sub	x0, x29, #48
	mov	x1, x21
	bl	_apply_move
	sub	x0, x29, #48
	mov	x1, #0
	mov	w2, #0
	bl	_get_status
	tst	w0, #0x2
	mov	w8, #512
	mov	w9, #256
	csel	x8, x9, x8, eq
	tst	w0, #0x1
	csel	x1, xzr, x8, eq
	mov	x0, x22
	mov	x2, x19
	bl	_write_san
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_in_check                       ; -- Begin function in_check
	.p2align	2
_in_check:                              ; @in_check
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
	ldrb	w8, [x0, #8]
	cmp	w8, #1
	cset	w1, ne
	mov	w8, #56
	mov	w9, #48
	csel	x20, x9, x8, eq
	bl	_make_attack_mask
	ldr	x8, [x19]
	ldr	x9, [x8, #40]
	ldr	x8, [x8, x20]
	and	x9, x9, x0
	tst	x9, x8
	cset	w0, ne
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_opponent_in_check              ; -- Begin function opponent_in_check
	.p2align	2
_opponent_in_check:                     ; @opponent_in_check
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
	ldrb	w8, [x0, #8]
	cmp	w8, #1
	cset	w1, eq
	mov	w8, #48
	mov	w9, #56
	csel	x20, x9, x8, eq
	bl	_make_attack_mask
	ldr	x8, [x19]
	ldr	x9, [x8, #40]
	ldr	x8, [x8, x20]
	and	x9, x9, x0
	tst	x9, x8
	cset	w0, ne
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_checkers                   ; -- Begin function get_checkers
	.p2align	2
_get_checkers:                          ; @get_checkers
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x0
	ldrb	w20, [x0, #8]
	cmp	w20, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x2, x0
	add	x8, sp, #8
	mov	x0, x19
	mov	x1, x20
	bl	_make_check_info
	ldrb	w0, [sp, #24]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_stalemate                   ; -- Begin function is_stalemate
	.p2align	2
_is_stalemate:                          ; @is_stalemate
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
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
	mov	x19, x0
	ldrb	w20, [x0, #8]
	cmp	w20, #1
	cset	w1, ne
	mov	w8, #56
	mov	w9, #48
	csel	x21, x9, x8, eq
	bl	_make_attack_mask
	ldr	x8, [x19]
	ldr	x9, [x8, #40]
	ldr	x8, [x8, x21]
	and	x8, x9, x8
	tst	x8, x0
	b.eq	LBB81_2
; %bb.1:
	mov	w0, #0
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
LBB81_2:
	mov	x2, x0
	mov	x8, #-1
	stp	x8, x8, [sp, #8]
	strb	wzr, [sp, #24]
	add	x3, sp, #8
	mov	x0, x19
	mov	x1, x20
	bl	_count_moves
	cmp	w0, #0
	cset	w0, eq
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_checkmate                   ; -- Begin function is_checkmate
	.p2align	2
_is_checkmate:                          ; @is_checkmate
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
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
	mov	x19, x0
	ldrb	w20, [x0, #8]
	cmp	w20, #1
	cset	w1, ne
	mov	w8, #56
	mov	w9, #48
	csel	x22, x9, x8, eq
	bl	_make_attack_mask
	ldr	x8, [x19]
	ldr	x9, [x8, #40]
	ldr	x8, [x8, x22]
	and	x8, x9, x8
	tst	x8, x0
	b.eq	LBB82_2
; %bb.1:
	mov	x21, x0
	add	x8, sp, #24
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_count_moves
	cmp	w0, #0
	cset	w0, eq
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
LBB82_2:
	mov	w0, #0
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_repetition_outcome         ; -- Begin function get_repetition_outcome
	.p2align	2
_get_repetition_outcome:                ; @get_repetition_outcome
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #160
	.cfi_def_cfa_offset 160
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
	mov	w22, #0
	cmp	w2, #3
	b.lo	LBB83_10
; %bb.1:
	mov	x20, x0
	ldrh	w23, [x0, #12]
	cmp	w23, #3
	b.lo	LBB83_10
; %bb.2:
	mov	x21, x2
	mov	x19, x1
	mov	x8, sp
	str	x8, [sp, #64]
	add	x0, sp, #64
	mov	x1, x20
	bl	_copy_into
	mov	w22, #0
	sub	w8, w21, #1
	tbnz	w8, #15, LBB83_10
; %bb.3:
	sxth	w24, w8
	mov	w25, #1
	mov	w26, #14
                                        ; implicit-def: $x21
	b	LBB83_6
LBB83_4:                                ;   in Loop: Header=BB83_6 Depth=1
	orr	w22, w22, #0x20
LBB83_5:                                ;   in Loop: Header=BB83_6 Depth=1
	sub	w8, w24, #1
	sxth	w24, w8
	tbnz	w8, #15, LBB83_10
LBB83_6:                                ; =>This Inner Loop Header: Depth=1
	and	x8, x24, #0xffff
	madd	x8, x8, x26, x19
	ldr	x1, [x8]
	ldrh	w9, [x8, #12]
	ldr	w8, [x8, #8]
	bfi	x8, x9, #32, #16
	and	x9, x21, #0xffff000000000000
	orr	x21, x9, x8
	add	x0, sp, #64
	mov	x2, x21
	bl	_undo_move
	sub	w8, w23, #1
	tst	w23, #0xffff
	csel	w23, wzr, w8, eq
	ldrh	w8, [sp, #76]
	cmp	w8, w23, uxth
	b.ne	LBB83_10
; %bb.7:                                ;   in Loop: Header=BB83_6 Depth=1
	add	x0, sp, #64
	mov	x1, x20
	bl	_boards_legally_equal
	add	w25, w25, w0
	and	w8, w25, #0xff
	cmp	w8, #3
	b.eq	LBB83_4
; %bb.8:                                ;   in Loop: Header=BB83_6 Depth=1
	cmp	w8, #5
	b.ne	LBB83_5
; %bb.9:
	orr	w22, w22, #0x40
LBB83_10:
	and	w0, w22, #0xff
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #160
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_insufficient_material       ; -- Begin function is_insufficient_material
	.p2align	2
_is_insufficient_material:              ; @is_insufficient_material
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
	ldr	x8, [x19]
	cbz	x8, LBB84_2
; %bb.1:
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB84_2:
	ldr	x8, [x19, #24]
	cbz	x8, LBB84_4
; %bb.3:
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB84_4:
	ldr	x8, [x19, #32]
	cbz	x8, LBB84_6
; %bb.5:
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB84_6:
	ldp	x8, x0, [x19, #8]
	cbz	x0, LBB84_9
; %bb.7:
	cbz	x8, LBB84_10
; %bb.8:
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB84_9:
	mov	x0, x8
	bl	_count_bits
	cmp	w0, #2
	cset	w0, lo
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB84_10:
	bl	_count_bits
	cmp	w0, #2
	b.hs	LBB84_12
; %bb.11:
	mov	w0, #1
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB84_12:
	ldr	x8, [x19, #16]
	mov	x9, #21930
	movk	x9, #21930, lsl #16
	movk	x9, #21930, lsl #32
	movk	x9, #21930, lsl #48
	tst	x8, x9
	cset	w9, eq
	mov	x10, #43605
	movk	x10, #43605, lsl #16
	movk	x10, #43605, lsl #32
	movk	x10, #43605, lsl #48
	tst	x8, x10
	cset	w8, eq
	orr	w0, w9, w8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_can_claim_fifty                ; -- Begin function can_claim_fifty
	.p2align	2
_can_claim_fifty:                       ; @can_claim_fifty
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
	sub	sp, sp, #464
Lloh59:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh60:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh61:
	ldr	x8, [x8]
	stur	x8, [x29, #-72]
	ldrh	w8, [x0, #12]
	cmp	w8, #99
	b.hs	LBB85_2
; %bb.1:
	mov	w0, #0
	ldur	x8, [x29, #-72]
Lloh62:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh63:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh64:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB85_8
	b	LBB85_13
LBB85_2:
	b.ne	LBB85_6
; %bb.3:
	mov	x19, x0
	ldrb	w20, [x0, #8]
	cmp	w20, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x21, x0
	add	x8, sp, #32
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_make_check_info
	ldr	q0, [sp, #32]
	str	q0, [sp]
	ldr	x8, [sp, #48]
	str	x8, [sp, #16]
	mov	x3, sp
	add	x5, sp, #56
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	mov	x4, #-1
	bl	_generate_moves
	cbz	w0, LBB85_7
; %bb.4:
	mov	x21, x0
	ldr	w20, [sp, #56]
	mov	x0, x19
	mov	x1, x20
	bl	_apply_move
	mov	x3, x0
	ldrh	w22, [x19, #12]
	and	x2, x1, #0xffffffffffff
	mov	x0, x19
	mov	x1, x3
	bl	_undo_move
	cmp	w22, #100
	b.ne	LBB85_9
; %bb.5:
	mov	w0, #1
	ldur	x8, [x29, #-72]
Lloh65:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh66:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh67:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB85_8
	b	LBB85_13
LBB85_6:
	mov	w0, #1
LBB85_7:
	ldur	x8, [x29, #-72]
Lloh68:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh69:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh70:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB85_13
LBB85_8:
	add	sp, sp, #464
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #80             ; 16-byte Folded Reload
	ret
LBB85_9:
	mov	w21, w21
	mov	w8, #1
	add	x22, sp, #56
LBB85_10:                               ; =>This Inner Loop Header: Depth=1
	mov	x23, x8
	cmp	x21, x8
	b.eq	LBB85_12
; %bb.11:                               ;   in Loop: Header=BB85_10 Depth=1
	ldr	w8, [x22, x23, lsl  #2]
	and	x9, x20, #0xffffffff00000000
	orr	x20, x9, x8
	mov	x0, x19
	mov	x1, x20
	bl	_apply_move
	mov	x3, x0
	ldrh	w24, [x19, #12]
	and	x2, x1, #0xffffffffffff
	mov	x0, x19
	mov	x1, x3
	bl	_undo_move
	add	x8, x23, #1
	cmp	w24, #100
	b.ne	LBB85_10
LBB85_12:
	cmp	x23, x21
	cset	w0, lo
	ldur	x8, [x29, #-72]
Lloh71:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh72:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh73:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB85_8
LBB85_13:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh59, Lloh60, Lloh61
	.loh AdrpLdrGotLdr	Lloh62, Lloh63, Lloh64
	.loh AdrpLdrGotLdr	Lloh65, Lloh66, Lloh67
	.loh AdrpLdrGotLdr	Lloh68, Lloh69, Lloh70
	.loh AdrpLdrGotLdr	Lloh71, Lloh72, Lloh73
	.cfi_endproc
                                        ; -- End function
	.globl	_generate_legal_moves           ; -- Begin function generate_legal_moves
	.p2align	2
_generate_legal_moves:                  ; @generate_legal_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
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
	mov	x19, x1
	mov	x20, x0
	ldrb	w21, [x0, #8]
	cmp	w21, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x22, x0
	add	x8, sp, #24
	mov	x0, x20
	mov	x1, x21
	mov	x2, x22
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x20
	mov	x1, x21
	mov	x2, x22
	mov	x4, #-1
	mov	x5, x19
	bl	_generate_moves
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_is_draw                        ; -- Begin function is_draw
	.p2align	2
_is_draw:                               ; @is_draw
	.cfi_startproc
; %bb.0:
	mov	x8, x0
	tst	w0, #0x2
	ccmp	w0, #2, #0, ne
	cset	w9, lo
	mov	w0, #1
	tst	w8, #0xc
	b.ne	LBB87_2
; %bb.1:
	ubfx	w8, w8, #5, #1
	cmp	w9, #0
	csel	w0, w0, w8, eq
LBB87_2:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_apply_status               ; -- Begin function get_apply_status
	.p2align	2
_get_apply_status:                      ; @get_apply_status
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
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
	add	x8, sp, #16
	str	x8, [sp]
	mov	x0, sp
	bl	_copy_into
	and	x1, x22, #0xffffffff
	mov	x0, x21
	bl	_apply_move
	mov	x0, x21
	mov	x1, x20
	mov	x2, x19
	bl	_get_status
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count_legal_moves              ; -- Begin function count_legal_moves
	.p2align	2
_count_legal_moves:                     ; @count_legal_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
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
	mov	x19, x0
	ldrb	w20, [x0, #8]
	cmp	w20, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x21, x0
	add	x8, sp, #24
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_count_moves
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_has_legal_moves                ; -- Begin function has_legal_moves
	.p2align	2
_has_legal_moves:                       ; @has_legal_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
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
	mov	x19, x0
	ldrb	w20, [x0, #8]
	cmp	w20, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x21, x0
	add	x8, sp, #24
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_has_moves
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_net_mobility                   ; -- Begin function net_mobility
	.p2align	2
_net_mobility:                          ; @net_mobility
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
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
	mov	x19, x0
	mov	w1, #0
	bl	_make_attack_mask
	mov	x20, x0
	add	x8, sp, #24
	mov	x0, x19
	mov	w1, #1
	mov	x2, x20
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x19
	mov	w1, #1
	mov	x2, x20
	bl	_count_moves
	mov	x20, x0
	mov	x0, x19
	mov	w1, #1
	bl	_make_attack_mask
	mov	x21, x0
	add	x8, sp, #24
	mov	x0, x19
	mov	w1, #0
	mov	x2, x21
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x19
	mov	w1, #0
	mov	x2, x21
	bl	_count_moves
	sub	w0, w20, w0
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count_pseudolegal_moves        ; -- Begin function count_pseudolegal_moves
	.p2align	2
_count_pseudolegal_moves:               ; @count_pseudolegal_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldrb	w1, [x0, #8]
	mov	x8, #-1
	stp	x8, x8, [sp, #8]
	strb	wzr, [sp, #24]
	add	x3, sp, #8
	mov	x2, #0
	bl	_count_moves
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_generate_legal_move_hashes     ; -- Begin function generate_legal_move_hashes
	.p2align	2
_generate_legal_move_hashes:            ; @generate_legal_move_hashes
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
	sub	sp, sp, #1088
	mov	x19, x1
	mov	x20, x0
Lloh74:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh75:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh76:
	ldr	x8, [x8]
	stur	x8, [x29, #-56]
	ldrb	w21, [x0, #8]
	cmp	w21, #1
	cset	w1, ne
	bl	_make_attack_mask
	mov	x22, x0
	add	x8, sp, #32
	mov	x0, x20
	mov	x1, x21
	mov	x2, x22
	bl	_make_check_info
	ldr	q0, [sp, #32]
	str	q0, [sp]
	ldr	x8, [sp, #48]
	str	x8, [sp, #16]
	mov	x3, sp
	add	x5, sp, #56
	mov	x0, x20
	mov	x1, x21
	mov	x2, x22
	mov	x4, #-1
	bl	_generate_moves
	mov	x20, x0
	cbz	w0, LBB93_3
; %bb.1:
	mov	w22, w20
	add	x23, sp, #56
                                        ; implicit-def: $x21
LBB93_2:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [x23], #4
	and	x9, x21, #0xffffffff00000000
	orr	x21, x9, x8
	mov	x0, x21
	bl	_hash_move
	str	x0, [x19], #8
	subs	x22, x22, #1
	b.ne	LBB93_2
LBB93_3:
	ldur	x8, [x29, #-56]
Lloh77:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh78:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh79:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB93_5
; %bb.4:
	mov	x0, x20
	add	sp, sp, #1088
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB93_5:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh74, Lloh75, Lloh76
	.loh AdrpLdrGotLdr	Lloh77, Lloh78, Lloh79
	.cfi_endproc
                                        ; -- End function
	.globl	_generate_pseudolegal_moves     ; -- Begin function generate_pseudolegal_moves
	.p2align	2
_generate_pseudolegal_moves:            ; @generate_pseudolegal_moves
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x5, x1
	ldrb	w1, [x0, #8]
	mov	x8, #-1
	stp	x8, x8, [sp, #8]
	strb	wzr, [sp, #24]
	add	x3, sp, #8
	mov	x2, #0
	mov	x4, #-1
	bl	_generate_moves
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_perft                          ; -- Begin function perft
	.p2align	2
_perft:                                 ; @perft
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
	sub	sp, sp, #1088
Lloh80:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh81:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh82:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	cbz	w1, LBB95_3
; %bb.1:
	mov	x19, x0
	subs	w22, w1, #1
	b.ne	LBB95_4
; %bb.2:
	ldrb	w20, [x19, #8]
	cmp	w20, #1
	cset	w1, ne
	mov	x0, x19
	bl	_make_attack_mask
	mov	x21, x0
	add	x8, sp, #56
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_make_check_info
	ldur	q0, [sp, #56]
	str	q0, [sp, #32]
	ldr	x8, [sp, #72]
	str	x8, [sp, #48]
	add	x3, sp, #32
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_count_moves
	mov	w20, w0
	b	LBB95_7
LBB95_3:
	mov	w20, #1
	b	LBB95_7
LBB95_4:
	ldrb	w20, [x19, #8]
	cmp	w20, #1
	cset	w1, ne
	mov	x0, x19
	bl	_make_attack_mask
	mov	x21, x0
	add	x8, sp, #32
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_make_check_info
	ldr	q0, [sp, #32]
	str	q0, [sp]
	ldr	x8, [sp, #48]
	str	x8, [sp, #16]
	mov	x3, sp
	add	x5, sp, #56
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	mov	x4, #-1
	bl	_generate_moves
	mov	x20, #0
	cbz	w0, LBB95_7
; %bb.5:
	add	x25, sp, #56
	and	w21, w22, #0xff
                                        ; implicit-def: $x22
	mov	w26, w0
LBB95_6:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [x25], #4
	and	x9, x22, #0xffffffff00000000
	orr	x22, x9, x8
	mov	x0, x19
	mov	x1, x22
	bl	_apply_move
	mov	x23, x0
	mov	x24, x1
	mov	x0, x19
	mov	x1, x21
	bl	_perft
	add	x20, x0, x20
	and	x2, x24, #0xffffffffffff
	mov	x0, x19
	mov	x1, x23
	bl	_undo_move
	subs	x26, x26, #1
	b.ne	LBB95_6
LBB95_7:
	ldur	x8, [x29, #-88]
Lloh83:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh84:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh85:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB95_9
; %bb.8:
	mov	x0, x20
	add	sp, sp, #1088
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB95_9:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh80, Lloh81, Lloh82
	.loh AdrpLdrGotLdr	Lloh83, Lloh84, Lloh85
	.cfi_endproc
                                        ; -- End function
	.globl	_pseudo_perft                   ; -- Begin function pseudo_perft
	.p2align	2
_pseudo_perft:                          ; @pseudo_perft
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
	sub	sp, sp, #1056
Lloh86:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh87:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh88:
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	cbz	w1, LBB96_3
; %bb.1:
	mov	x19, x0
	subs	w21, w1, #1
	b.ne	LBB96_4
; %bb.2:
	ldrb	w1, [x19, #8]
	mov	x8, #-1
	stp	x8, x8, [sp, #24]
	strb	wzr, [sp, #40]
	add	x3, sp, #24
	mov	x0, x19
	mov	x2, #0
	bl	_count_moves
	mov	w20, w0
	b	LBB96_7
LBB96_3:
	mov	w20, #1
	b	LBB96_7
LBB96_4:
	ldrb	w1, [x19, #8]
	mov	x8, #-1
	stp	x8, x8, [sp]
	strb	wzr, [sp, #16]
	mov	x3, sp
	add	x5, sp, #24
	mov	x0, x19
	mov	x2, #0
	mov	x4, #-1
	bl	_generate_moves
	mov	x20, #0
	cbz	w0, LBB96_7
; %bb.5:
	add	x25, sp, #24
	and	w21, w21, #0xff
                                        ; implicit-def: $x22
	mov	w26, w0
LBB96_6:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [x25], #4
	and	x9, x22, #0xffffffff00000000
	orr	x22, x9, x8
	mov	x0, x19
	mov	x1, x22
	bl	_apply_move
	mov	x23, x0
	mov	x24, x1
	mov	x0, x19
	mov	x1, x21
	bl	_pseudo_perft
	add	x20, x0, x20
	and	x2, x24, #0xffffffffffff
	mov	x0, x19
	mov	x1, x23
	bl	_undo_move
	subs	x26, x26, #1
	b.ne	LBB96_6
LBB96_7:
	ldur	x8, [x29, #-88]
Lloh89:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh90:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh91:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB96_9
; %bb.8:
	mov	x0, x20
	add	sp, sp, #1056
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB96_9:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh86, Lloh87, Lloh88
	.loh AdrpLdrGotLdr	Lloh89, Lloh90, Lloh91
	.cfi_endproc
                                        ; -- End function
	.globl	_randomize_board                ; -- Begin function randomize_board
	.p2align	2
_randomize_board:                       ; @randomize_board
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
	sub	sp, sp, #1088
	mov	x19, x0
Lloh92:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh93:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh94:
	ldr	x8, [x8]
	stur	x8, [x29, #-56]
	bl	_random
	mov	x8, #55051
	movk	x8, #28835, lsl #16
	movk	x8, #2621, lsl #32
	movk	x8, #41943, lsl #48
	smulh	x8, x0, x8
	add	x8, x8, x0
	lsr	x9, x8, #63
	lsr	x8, x8, #6
	add	w8, w8, w9
	mov	w9, #100
	msub	w8, w8, w9, w0
	tst	x8, #0xff
	b.eq	LBB97_3
; %bb.1:
	ldrb	w20, [x19, #8]
	cmp	w20, #1
	cset	w1, ne
	mov	x0, x19
	bl	_make_attack_mask
	mov	x21, x0
	add	x8, sp, #32
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	bl	_make_check_info
	ldr	q0, [sp, #32]
	str	q0, [sp]
	ldr	x8, [sp, #48]
	str	x8, [sp, #16]
	add	x22, sp, #56
	mov	x3, sp
	add	x5, sp, #56
	mov	x0, x19
	mov	x1, x20
	mov	x2, x21
	mov	x4, #-1
	bl	_generate_moves
	cbz	w0, LBB97_3
; %bb.2:
	mov	x20, x0
	bl	_random
	mov	w8, w20
	sdiv	x8, x0, x8
	msub	w8, w8, w20, w0
	and	x8, x8, #0xff
	ldr	w1, [x22, x8, lsl  #2]
	mov	x0, x19
	bl	_apply_move
	mov	x0, x19
	bl	_randomize_board
LBB97_3:
	ldur	x8, [x29, #-56]
Lloh95:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh96:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh97:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB97_5
; %bb.4:
	add	sp, sp, #1088
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #64             ; 16-byte Folded Reload
	ret
LBB97_5:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh92, Lloh93, Lloh94
	.loh AdrpLdrGotLdr	Lloh95, Lloh96, Lloh97
	.cfi_endproc
                                        ; -- End function
	.globl	_board_openness                 ; -- Begin function board_openness
	.p2align	2
_board_openness:                        ; @board_openness
	.cfi_startproc
; %bb.0:
	movi	d0, #0000000000000000
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_shannon_evaluation             ; -- Begin function shannon_evaluation
	.p2align	2
_shannon_evaluation:                    ; @shannon_evaluation
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #144
	.cfi_def_cfa_offset 144
	stp	x28, x27, [sp, #48]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #112]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #128]            ; 16-byte Folded Spill
	add	x29, sp, #128
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
	mov	x19, x0
	bl	_get_status
	mov	w9, #3
	bics	wzr, w9, w0
	b.ne	LBB99_2
; %bb.1:
	ldrb	w8, [x19, #8]
	cmp	w8, #1
	mov	w8, #-20000
	cneg	w0, w8, ne
	b	LBB99_22
LBB99_2:
	mov	x8, x0
	mov	w0, #0
	tst	w8, #0x2
	ccmp	w8, #2, #0, ne
	cset	w9, lo
	tst	w8, #0xc
	b.ne	LBB99_22
; %bb.3:
	cbz	w9, LBB99_22
; %bb.4:
	tbnz	w8, #5, LBB99_22
; %bb.5:
	mov	x0, x19
	mov	w1, #7
	bl	_net_piece_type
	mov	x22, x0
	mov	x0, x19
	mov	w1, #6
	bl	_net_piece_type
	mov	x23, x0
	mov	w28, #500
	mov	x0, x19
	mov	w1, #5
	bl	_net_piece_type
	mov	x20, x0
	mov	x0, x19
	mov	w1, #4
	bl	_net_piece_type
	mov	x21, x0
	mov	x0, x19
	mov	w1, #3
	bl	_net_piece_type
	mov	x24, x0
	mov	w27, #100
	ldr	x8, [x19]
	ldr	x9, [x8]
	ldp	x10, x8, [x8, #48]
	and	x10, x10, x9
	and	x8, x8, x9
	lsl	x9, x10, #9
	and	x9, x9, #0xfefefefefefefefe
	lsl	x11, x10, #7
	and	x11, x11, #0x7f7f7f7f7f7f7f7f
	orr	x9, x9, x11
	lsr	x11, x8, #7
	and	x11, x11, #0xfefefefefefefefe
	lsr	x12, x8, #9
	and	x12, x12, #0x7f7f7f7f7f7f7f7f
	orr	x11, x11, x12
	lsr	x12, x11, #8
	orr	x13, x9, x8, lsr #8
	bic	x12, x12, x13
	and	x0, x12, x10
	lsl	x9, x9, #8
	orr	x10, x11, x10, lsl #8
	bic	x9, x9, x10
	and	x25, x9, x8
	bl	_count_bits
	mov	x26, x0
	mov	x0, x25
	bl	_count_bits
	sub	w10, w26, w0
	ldr	x9, [x19]
	ldr	x11, [x9]
	ldr	x8, [x9, #48]
	and	x12, x8, x11
	neg	x8, x12
	ands	x13, x12, x8
	b.eq	LBB99_12
; %bb.6:
	mov	w8, #0
LBB99_7:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB99_8 Depth 2
                                        ;     Child Loop BB99_10 Depth 2
	mov	x14, #0
	mov	x15, x13
LBB99_8:                                ;   Parent Loop BB99_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x15, x15, #8
	orr	x14, x15, x14
	cbnz	x15, LBB99_8
; %bb.9:                                ;   in Loop: Header=BB99_7 Depth=1
	mov	x16, x13
LBB99_10:                               ;   Parent Loop BB99_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x17, x16, #8
	orr	x15, x17, x15
	cmp	x16, #255
	mov	x16, x17
	b.hi	LBB99_10
; %bb.11:                               ;   in Loop: Header=BB99_7 Depth=1
	eor	x12, x12, x13
	orr	x13, x15, x14
	tst	x13, x12
	cinc	w8, w8, ne
	neg	x13, x12
	ands	x13, x12, x13
	b.ne	LBB99_7
	b	LBB99_13
LBB99_12:
	mov	w8, #0
LBB99_13:
	mov	w12, #900
	mul	w25, w22, w12
	mul	w26, w23, w28
	mul	w24, w24, w27
	sxtb	w10, w10
	ldr	x9, [x9, #56]
	and	x9, x9, x11
	neg	x11, x9
	ands	x12, x9, x11
	b.eq	LBB99_20
; %bb.14:
	mov	w11, #0
LBB99_15:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB99_16 Depth 2
                                        ;     Child Loop BB99_18 Depth 2
	mov	x13, #0
	mov	x14, x12
LBB99_16:                               ;   Parent Loop BB99_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsl	x14, x14, #8
	orr	x13, x14, x13
	cbnz	x14, LBB99_16
; %bb.17:                               ;   in Loop: Header=BB99_15 Depth=1
	mov	x15, x12
LBB99_18:                               ;   Parent Loop BB99_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	x16, x15, #8
	orr	x14, x16, x14
	cmp	x15, #255
	mov	x15, x16
	b.hi	LBB99_18
; %bb.19:                               ;   in Loop: Header=BB99_15 Depth=1
	eor	x9, x9, x12
	orr	x12, x14, x13
	tst	x12, x9
	cinc	w11, w11, ne
	neg	x12, x9
	ands	x12, x9, x12
	b.ne	LBB99_15
	b	LBB99_21
LBB99_20:
	mov	w11, #0
LBB99_21:
	sub	w8, w8, w11
	add	w22, w10, w8, sxtb
	mov	x0, x19
	bl	_net_isolated_pawns
	add	w27, w22, w0
	mov	w28, #50
	mov	x0, x19
	mov	w1, #0
	bl	_make_attack_mask
	mov	x22, x0
	add	x8, sp, #24
	mov	x0, x19
	mov	w1, #1
	mov	x2, x22
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x19
	mov	w1, #1
	mov	x2, x22
	bl	_count_moves
	mov	x22, x0
	mov	x0, x19
	mov	w1, #1
	bl	_make_attack_mask
	mov	x23, x0
	add	x8, sp, #24
	mov	x0, x19
	mov	w1, #0
	mov	x2, x23
	bl	_make_check_info
	ldur	q0, [sp, #24]
	str	q0, [sp]
	ldr	x8, [sp, #40]
	str	x8, [sp, #16]
	mov	x3, sp
	mov	x0, x19
	mov	w1, #0
	mov	x2, x23
	bl	_count_moves
	sub	w8, w22, w0
	mov	w9, #10
	add	w10, w21, w20
	mov	w11, #300
	add	w12, w26, w25
	add	w12, w12, w24
	madd	w10, w10, w11, w12
	madd	w10, w27, w28, w10
	madd	w0, w8, w9, w10
LBB99_22:
	ldp	x29, x30, [sp, #128]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #112]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #144
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_ext_piece_attacks              ; -- Begin function ext_piece_attacks
	.p2align	2
_ext_piece_attacks:                     ; @ext_piece_attacks
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
	bl	_index_to_piece
                                        ; kill: def $w0 killed $w0 def $x0
	mov	w8, #1
	lsl	x1, x8, x19
	and	x0, x0, #0xffff
	mov	x2, #-1
	mov	x3, #-1
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_piece_attack_mask
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"%s has no %s to move"

l_.str.1:                               ; @.str.1
	.asciz	"White"

l_.str.2:                               ; @.str.2
	.asciz	"Black"

l_.str.3:                               ; @.str.3
	.asciz	"A %s moving to %s is not a capture"

l_.str.4:                               ; @.str.4
	.asciz	"%s moving to %s is not legal"

l_.str.5:                               ; @.str.5
	.asciz	"Ambigious origin for %s moving to %s"

l_.str.6:                               ; @.str.6
	.asciz	"Invalid SAN"

.subsections_via_symbols
