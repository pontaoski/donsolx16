;; Startup

.SEGMENT "STARTUP"
.SEGMENT "INIT"
.SEGMENT "ONCE"
	jmp __INIT

;; Cart

	.INCLUDE "head.asm"
	.INCLUDE "macros.asm"

;; include sprites

Tiles:
	.incbin "../data/tiles.bin"
Tiles_end:
	TILES_SIZE = Tiles_end - Tiles

Palette:
	.incbin "../data/tiles.bin.PAL"
Palette_end:
	PALETTE_SIZE = Palette_end - Palette

;; init

__INIT:                        ;
	.INCLUDE "init.asm"

;; jump back to Forever, infinite loop

__MAIN:                        ;
	.INCLUDE "main.asm"
	JMP __MAIN

;; NMI

__NMI:                         ;
	.INCLUDE "nmi.asm"            ;
	RTI                          ; return from interrupt

;; includes

	.INCLUDE "sound.asm"
	.INCLUDE "helpers.asm"
	.INCLUDE "splash.asm"
	.INCLUDE "game.asm"
	.INCLUDE "deck.asm"
	.INCLUDE "player.asm"
	.INCLUDE "room.asm"
	.INCLUDE "tests.asm"
	.INCLUDE "tables.asm"

;; vectors

;	.pad $FFFA
;	.dw __NMI
;	.dw __INIT
;	.dw 0
