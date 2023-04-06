
;; Cart

	.INCLUDE "head.asm"

;; include sprites

	.org $8000

Sprites:
	.incbin "sprite.chr"
	.org $C000

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
