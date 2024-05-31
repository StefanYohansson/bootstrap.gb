MACRO put
	ld a, \2
	ld \1, a
endm

MACRO ldx
	rept _NARG
	ld \1, a
	shift
	endr
endm

MACRO farcall
	rst FarCall
	db  bank(\1)
	dw  \1
endm

MACRO callback
	ld a, bank(\1)
	ld hl, \1
	call Callback
endm

MACRO task
	ld a, bank(\1)
	ld de, \1
	call CreateTask
endm

MACRO fill
	ld hl, \1
	ld bc, \2
.loop\@
	ld [hl], \3
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop\@
endm


MACRO RGB
	db (\1) + (\2) << 5 + (\3) << 10
endm


MACRO enum_start
	if _NARG
DEF __enum__ = \1
	else
DEF __enum__ = 0
	endc
endm

MACRO enum
	rept _NARG
DEF \1 = __enum__
DEF __enum__ = __enum__ + 1
	shift
	endr
endm
