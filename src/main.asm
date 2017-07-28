include "constants.asm"


START_TILE = $80 ; This maps to vChars1.

; All values are in tiles.
IMAGE_WIDTH = 10
IMAGE_HEIGHT = 4
IMAGE_X = 5
IMAGE_Y = 7


section "Main", rom0

Main::
	call .Setup
.loop
	call WaitVBlank
	jr .loop

.Setup:
	ld bc, .Graphics
	ld de, vChars1
	ld a, IMAGE_WIDTH * IMAGE_HEIGHT
	call QueueGfx

	callback .DrawTilemap

	call .SetPalette

	ret

.DrawTilemap:
	ld hl, vBGMap0 + BG_WIDTH * IMAGE_Y + IMAGE_X
	ld a, START_TILE
	ld b, IMAGE_HEIGHT
	ld c, IMAGE_WIDTH
	jp DrawTilemapRect

.Graphics:
	INCBIN "gfx/hello_world.2bpp"

.SetPalette:
	ld a, %11100100 ; quaternary: 3210
	ld [rOBP0], a
	ld [rOBP1], a
	ld [rBGP], a
	ret

