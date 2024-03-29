; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

;; TABLES

;; $30 -> white | $16 -> red | $3B -> cyan | $2D -> dark grey

;; Attributes

attributes_game:               ;
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %11000000, %11110000, %10100000, %10100000, %00000000, %00000000
	.byte %00000000, %00000100, %00000001, %00001011, %00000000, %00001111, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000

;; Cursor

selections_game_lo:
	.byte <($2c*2),<($64*2),<($9c*2),<($d4*2)

selections_game_hi:
	.byte >($2c*2),>($64*2),>($9c*2),>($d4*2)

;; Number Positions

number_high:                   ;
	.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	.byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$02
	.byte $03,$03,$03,$03,$03,$03,$03,$03,$03,$03
	.byte $04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.byte $05,$05,$05,$05,$05,$05,$05,$05,$05,$05
	.byte $06,$06,$06,$06,$06,$06,$06,$06,$06,$06

number_low:                    ;
	.byte $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a
	.byte $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a
	.byte $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a
	.byte $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a
	.byte $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a
	.byte $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a

;; Progress Bars

progressbar:                   ;
	.byte $60,$61,$61,$61,$61,$62 ; $00
	.byte $67,$61,$61,$61,$61,$62 ; $06
	.byte $64,$63,$61,$61,$61,$62 ; $0c
	.byte $64,$65,$63,$61,$61,$62 ; $12
	.byte $64,$65,$65,$63,$61,$62 ; $18
	.byte $64,$65,$65,$65,$63,$62 ; $1E
	.byte $64,$65,$65,$65,$65,$66 ; $24

healthbaroffset:               ;
	.byte $86,$88,$8A,$8C,$8E,$90,$92

healthbarpos:                  ;
	.byte $00,$06,$06,$06,$06,$0c,$0c,$0c,$0c,$12,$12
	.byte $12,$12,$18,$18,$18,$18,$1E,$1E,$1E,$24,$24

shieldbaroffset:               ;
	.byte $94,$96,$98,$9A,$9C,$9E,$A0

shieldbarpos:                  ;
	.byte $00,$06,$06,$0c,$0c,$12
	.byte $12,$18,$18,$1E,$1E,$24

experiencebaroffset:           ;
	.byte $A2,$A4,$A6,$A8,$AA,$AC,$AE

experiencebarpos:              ;
	.byte $00,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06
	.byte $0c,$0c,$0c,$0c,$0c,$0c,$0c,$0c,$0c,$0c,$0c,$0c,$12
	.byte $12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$18,$18
	.byte $18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$1E,$1E,$1E
	.byte $1E,$1E,$24,$24

;; Cards

card_types:                    ;
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; hearts
	.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; diamonds
	.byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; spades
	.byte $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03 ; clovers
	.byte $04,$04,$05 ; joker

card_values:                   ;
	.byte $0b,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0b,$0b ; heart
	.byte $0b,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0b,$0b ; diamonds
	.byte $11,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0d,$0f ; spades
	.byte $11,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0d,$0f ; clovers
	.byte $15,$15,$00 ; joker

card_glyphs:                   ;
	.byte $00,$02,$03,$04,$05,$06,$07,$08,$09,$0a
	.byte $22,$14,$20,$1b,$00,$15,$08,$0b,$00,$00
	.byte $00,$0e,$00

;; Card Positions

card1pos_high:
card2pos_high:
card3pos_high:
card4pos_high:
	.byte $03,$03,$03,$03,$03,$03
	.byte $03,$03,$03,$03,$03,$03
	.byte $03,$03,$03,$03,$03,$03
	.byte $03,$03,$03,$03,$03,$03

	.byte $04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$04
	.byte $04,$04,$04,$04,$04,$04

	.byte $05,$05,$05,$05,$05,$05

card1pos_low:
	.byte $06,$08,$0A,$0C,$0E,$10
	.byte $46,$48,$4A,$4C,$4E,$50
	.byte $86,$88,$8A,$8C,$8E,$90
	.byte $C6,$C8,$CA,$CC,$CE,$D0

	.byte $06,$08,$0A,$0C,$0E,$10
	.byte $46,$48,$4A,$4C,$4E,$50
	.byte $86,$88,$8A,$8C,$8E,$90
	.byte $C6,$C8,$CA,$CC,$CE,$D0

	.byte $06,$08,$0A,$0C,$0E,$10

card2pos_low:
	.byte $14,$16,$18,$1A,$1C,$1E
	.byte $54,$56,$58,$5A,$5C,$5E
	.byte $94,$96,$98,$9A,$9C,$9E
	.byte $D4,$D6,$D8,$DA,$DC,$DE

	.byte $14,$16,$18,$1A,$1C,$1E
	.byte $54,$56,$58,$5A,$5C,$5E
	.byte $94,$96,$98,$9A,$9C,$9E
	.byte $D4,$D6,$D8,$DA,$DC,$DE

	.byte $14,$16,$18,$1A,$1C,$1E

card3pos_low:
	.byte $22,$24,$26,$28,$2A,$2C
	.byte $62,$64,$66,$68,$6A,$6C
	.byte $A2,$A4,$A6,$A8,$AA,$AC
	.byte $E2,$E4,$E6,$E8,$EA,$EC

	.byte $22,$24,$26,$28,$2A,$2C
	.byte $62,$64,$66,$68,$6A,$6C
	.byte $A2,$A4,$A6,$A8,$AA,$AC
	.byte $E2,$E4,$E6,$E8,$EA,$EC

	.byte $22,$24,$26,$28,$2A,$2C

card4pos_low:
	.byte $30,$32,$34,$36,$38,$3A
	.byte $70,$72,$74,$76,$78,$7A
	.byte $B0,$B2,$B4,$B6,$B8,$BA
	.byte $F0,$F2,$F4,$F6,$F8,$FA

	.byte $30,$32,$34,$36,$38,$3A
	.byte $70,$72,$74,$76,$78,$7A
	.byte $B0,$B2,$B4,$B6,$B8,$BA
	.byte $F0,$F2,$F4,$F6,$F8,$FA

	.byte $30,$32,$34,$36,$38,$3A

;; Dialog

dialogs:
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; clear 00
	.byte $23,$33,$39,$00,$2a,$29,$29,$30,$00,$37,$2d,$27,$2f,$69,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; sickness 01
	.byte $23,$33,$39,$36,$00,$37,$2c,$2d,$29,$30,$28,$00,$26,$36,$33,$2f,$29,$68,$00,$00,$00,$00,$00,$00 ; shieldbreak 02
	.byte $23,$33,$39,$00,$28,$2d,$29,$28,$69,$00,$6d,$00,$1e,$36,$3d,$00,$25,$2b,$25,$2d,$32,$69,$00,$00 ; death 03
	.byte $23,$33,$39,$00,$27,$25,$32,$32,$33,$38,$00,$36,$39,$32,$00,$25,$3b,$25,$3d,$69,$00,$00,$00,$00 ; cannot_run 04
	.byte $23,$33,$39,$00,$2a,$33,$39,$32,$28,$00,$25,$00,$37,$2c,$2d,$29,$30,$28,$69,$00,$00,$00,$00,$00 ; shield 05
	.byte $23,$33,$39,$00,$28,$36,$25,$32,$2f,$00,$25,$00,$34,$33,$38,$2d,$33,$32,$69,$00,$00,$00,$00,$00 ; potion 06
	.byte $23,$33,$39,$00,$3b,$25,$37,$38,$29,$28,$00,$25,$00,$34,$33,$38,$2d,$33,$32,$68,$00,$00,$00,$00 ; wastedpotion 07
	.byte $19,$3b,$68,$00,$23,$33,$39,$00,$32,$29,$29,$28,$00,$25,$00,$37,$2c,$2d,$29,$30,$28,$69,$00,$00 ; unshielded 08
	.byte $23,$33,$39,$00,$29,$32,$38,$29,$36,$29,$28,$00,$38,$2c,$29,$00,$36,$33,$33,$31,$69,$00,$00,$00 ; attack 09
	.byte $23,$33,$39,$00,$26,$30,$33,$27,$2f,$29,$28,$00,$38,$2c,$29,$00,$25,$38,$38,$25,$27,$2f,$69,$00 ; shielded 0a
	.byte $23,$33,$39,$00,$37,$39,$36,$3a,$2d,$3a,$29,$28,$00,$38,$2c,$29,$00,$26,$25,$38,$38,$30,$29,$69 ; damages 0b
	.byte $23,$33,$39,$00,$36,$25,$32,$00,$25,$3b,$25,$3d,$69,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; run 0c
	.byte $0f,$25,$37,$3d,$00,$17,$33,$28,$29,$00,$6c,$00,$1d,$29,$30,$29,$27,$38,$00,$27,$25,$36,$28,$69 ; easy mode 0d
	.byte $18,$33,$36,$31,$25,$30,$00,$6c,$00,$1d,$29,$30,$29,$27,$38,$00,$27,$25,$36,$28,$69,$00,$00,$00 ; normal mode 0e
	.byte $12,$25,$36,$28,$00,$17,$33,$28,$29,$00,$6c,$00,$1d,$29,$30,$29,$27,$38,$00,$27,$25,$36,$28,$69 ; hard mode 0f
	.byte $20,$2d,$27,$38,$33,$36,$3d,$00,$6d,$00,$16,$29,$25,$3a,$29,$00,$28,$39,$32,$2b,$29,$33,$32,$69 ; victory 10
	.byte $1d,$33,$39,$32,$28,$37,$00,$19,$18,$3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; sound:ON 11
	.byte $1d,$33,$39,$32,$28,$37,$00,$19,$10,$10,$3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; sound:OFF 12

;; dialogs map

dialogs_offset_low:
	.byte <(dialogs+($17* 0)),<(dialogs+($17* 1)),<(dialogs+($17* 2)),<(dialogs+($17* 3)),<(dialogs+($17* 4)),<(dialogs+($17* 5))
	.byte <(dialogs+($17* 6)),<(dialogs+($17* 7)),<(dialogs+($17* 8)),<(dialogs+($17* 9)),<(dialogs+($17*10)),<(dialogs+($17*11))
	.byte <(dialogs+($17*12)),<(dialogs+($17*13)),<(dialogs+($17*14)),<(dialogs+($17*15)),<(dialogs+($17*16)),<(dialogs+($17*17))
	.byte <(dialogs+($17*18))

dialogs_offset_high:
	.byte >(dialogs+($17* 0)),>(dialogs+($17* 1)),>(dialogs+($17* 2)),>(dialogs+($17* 3)),>(dialogs+($17* 4)),>(dialogs+($17* 5))
	.byte >(dialogs+($17* 6)),>(dialogs+($17* 7)),>(dialogs+($17* 8)),>(dialogs+($17* 9)),>(dialogs+($17*10)),>(dialogs+($17*11))
	.byte >(dialogs+($17*12)),>(dialogs+($17*13)),>(dialogs+($17*14)),>(dialogs+($17*15)),>(dialogs+($17*16)),>(dialogs+($17*17))
	.byte >(dialogs+($17*18))

;; cards

cards:                         ; [skip]
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$52,$86,$86,$86,$87,$85,$e8,$e4,$e5,$e9,$87,$85,$ec,$e0,$e1,$ed,$87,$85,$f8,$f5,$f6,$fb,$87,$85,$86,$f9,$fa,$86,$87,$85,$fc,$fd,$fe,$ff,$87,$89,$ee,$eb,$ea,$ef,$8b ; heart1
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$46,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$42,$86,$86,$87,$85,$86,$86,$42,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart2
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$47,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$42,$86,$86,$87,$85,$86,$86,$42,$86,$87,$85,$86,$42,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart3
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$48,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$42,$86,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart4
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$49,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$86,$42,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart5
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$4a,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart6
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$4b,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$86,$42,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart7
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$4c,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart8
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$4d,$86,$86,$86,$87,$85,$86,$86,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart9
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$4e,$86,$86,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$85,$86,$42,$42,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; heart10
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$4f,$86,$86,$86,$87,$85,$e8,$e4,$e5,$e9,$87,$85,$ec,$e0,$e1,$ed,$87,$85,$f8,$8e,$8f,$fb,$87,$85,$86,$c2,$c3,$86,$87,$85,$fc,$c0,$c7,$ff,$87,$89,$ee,$9e,$9e,$ef,$8b ; heart11
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$50,$86,$86,$86,$87,$85,$e8,$e4,$e5,$e9,$87,$85,$ec,$e0,$e1,$ed,$87,$85,$f8,$8c,$8d,$fb,$87,$85,$86,$c2,$c3,$86,$87,$85,$fc,$c0,$c1,$ff,$87,$89,$ee,$c4,$c5,$ef,$8b ; heart12
	.byte $81,$82,$82,$82,$82,$83,$85,$42,$86,$86,$86,$87,$85,$51,$86,$86,$86,$87,$85,$e8,$e4,$e5,$e9,$87,$85,$ec,$e0,$e1,$ed,$87,$85,$f8,$9c,$9d,$fb,$87,$85,$86,$f9,$fa,$86,$87,$85,$fc,$bc,$bd,$ff,$87,$89,$ee,$be,$bf,$ef,$8b ; heart13
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$52,$86,$86,$86,$87,$85,$86,$f0,$f3,$86,$87,$85,$f0,$f1,$f2,$f3,$87,$85,$f4,$f5,$f6,$f7,$87,$85,$86,$f9,$fa,$86,$87,$85,$fc,$fd,$fe,$ff,$87,$89,$ee,$eb,$ea,$ef,$8b ; diamond1
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$46,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$43,$86,$86,$87,$85,$86,$86,$43,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond2
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$47,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$43,$86,$86,$87,$85,$86,$86,$43,$86,$87,$85,$86,$43,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond3
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$48,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$43,$86,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond4
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$49,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$86,$43,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond5
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$4a,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond6
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$4b,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$86,$43,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond7
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$4c,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond8
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$4d,$86,$86,$86,$87,$85,$86,$86,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond9
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$4e,$86,$86,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$85,$86,$43,$43,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; diamond10
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$4f,$86,$86,$86,$87,$85,$86,$f0,$f3,$86,$87,$85,$f0,$f1,$f2,$f3,$87,$85,$f4,$8e,$8f,$f7,$87,$85,$86,$c2,$c3,$86,$87,$85,$fc,$c0,$c7,$ff,$87,$89,$ee,$9e,$9e,$ef,$8b ; diamond11
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$50,$86,$86,$86,$87,$85,$86,$f0,$f3,$86,$87,$85,$f0,$f1,$f2,$f3,$87,$85,$f4,$8c,$8d,$f7,$87,$85,$86,$c2,$c3,$86,$87,$85,$fc,$c0,$c1,$ff,$87,$89,$ee,$c4,$c5,$ef,$8b ; diamond12
	.byte $81,$82,$82,$82,$82,$83,$85,$43,$86,$86,$86,$87,$85,$51,$86,$86,$86,$87,$85,$86,$f0,$f3,$86,$87,$85,$f0,$f1,$f2,$f3,$87,$85,$f4,$9c,$9d,$f7,$87,$85,$86,$f9,$fa,$86,$87,$85,$fc,$bc,$bd,$ff,$87,$89,$ee,$be,$bf,$ef,$8b ; diamond13
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$52,$86,$86,$86,$87,$85,$86,$d0,$d3,$86,$87,$85,$d0,$d1,$d2,$d3,$87,$85,$d4,$d5,$d6,$d7,$87,$85,$86,$d9,$da,$86,$87,$85,$dc,$dd,$de,$df,$87,$89,$e6,$e2,$e3,$e7,$8b ; spade1
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$46,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$40,$86,$87,$85,$86,$40,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade2
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$47,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$40,$86,$87,$85,$86,$40,$86,$86,$87,$85,$86,$86,$40,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade3
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$48,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$86,$40,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade4
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$49,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$86,$40,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade5
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$4a,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade6
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$4b,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade7
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$4c,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade8
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$4d,$86,$86,$86,$87,$85,$86,$40,$86,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade9
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$4e,$86,$86,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$85,$86,$40,$40,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; spade10
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$4f,$86,$86,$86,$87,$85,$86,$d0,$d3,$86,$87,$85,$d0,$d1,$d2,$d3,$87,$85,$d4,$56,$57,$d7,$87,$85,$86,$5e,$5f,$86,$87,$85,$dc,$ce,$cf,$df,$87,$89,$e6,$9f,$9f,$e7,$8b ; spade11
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$50,$86,$86,$86,$87,$85,$86,$d0,$d3,$86,$87,$85,$d0,$d1,$d2,$d3,$87,$85,$d4,$5a,$5b,$d7,$87,$85,$86,$5e,$5f,$86,$87,$85,$dc,$ce,$c9,$df,$87,$89,$e6,$cc,$cd,$e7,$8b ; spade12
	.byte $81,$82,$82,$82,$82,$83,$85,$40,$86,$86,$86,$87,$85,$51,$86,$86,$86,$87,$85,$86,$d0,$d3,$86,$87,$85,$d0,$d1,$d2,$d3,$87,$85,$d4,$58,$59,$d7,$87,$85,$86,$5c,$5d,$86,$87,$85,$dc,$54,$55,$df,$87,$89,$e6,$88,$c8,$e7,$8b ; spade13
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$52,$86,$86,$86,$87,$85,$86,$d8,$db,$86,$87,$85,$d8,$d1,$d2,$db,$87,$85,$d4,$d5,$d6,$d7,$87,$85,$86,$d9,$da,$86,$87,$85,$dc,$dd,$de,$df,$87,$89,$e6,$e2,$e3,$e7,$8b ; clover1
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$46,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$41,$86,$86,$87,$85,$86,$86,$41,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover2
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$47,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$41,$86,$86,$87,$85,$86,$86,$41,$86,$87,$85,$86,$41,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover3
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$48,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$41,$86,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover4
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$49,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$86,$41,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover5
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$4a,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover6
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$4b,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$86,$41,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover7
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$4c,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover8
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$4d,$86,$86,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$40,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$86,$41,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover9
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$4e,$86,$86,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$85,$86,$41,$41,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; clover10
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$4f,$86,$86,$86,$87,$85,$86,$d8,$db,$86,$87,$85,$d8,$d1,$d2,$db,$87,$85,$d4,$56,$57,$d7,$87,$85,$86,$ca,$cb,$86,$87,$85,$dc,$ce,$cf,$df,$87,$89,$e6,$9f,$9f,$e7,$8b ; clover11
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$50,$86,$86,$86,$87,$85,$86,$d8,$db,$86,$87,$85,$d8,$d1,$d2,$db,$87,$85,$d4,$5a,$5b,$d7,$87,$85,$86,$ca,$cb,$86,$87,$85,$dc,$ce,$c9,$df,$87,$89,$e6,$cc,$cd,$e7,$8b ; clover12
	.byte $81,$82,$82,$82,$82,$83,$85,$41,$86,$86,$86,$87,$85,$51,$86,$86,$86,$87,$85,$86,$d8,$db,$86,$87,$85,$d8,$d1,$d2,$db,$87,$85,$d4,$58,$59,$d7,$87,$85,$86,$5c,$5d,$86,$87,$85,$dc,$54,$55,$df,$87,$89,$e6,$88,$c8,$e7,$8b ; clover13
	.byte $81,$82,$82,$82,$82,$83,$85,$53,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$78,$79,$7a,$7b,$87,$85,$7c,$7d,$7e,$7f,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; joker1
	.byte $81,$82,$82,$82,$82,$83,$85,$53,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$85,$70,$71,$72,$73,$87,$85,$74,$75,$76,$77,$87,$85,$86,$86,$86,$86,$87,$85,$86,$86,$86,$86,$87,$89,$8a,$8a,$8a,$8a,$8b ; joker2
	.byte $91,$92,$92,$92,$92,$93,$95,$96,$96,$96,$96,$97,$95,$96,$96,$96,$96,$97,$95,$96,$96,$96,$96,$97,$95,$96,$96,$96,$96,$97,$95,$96,$96,$96,$96,$97,$95,$96,$96,$96,$96,$97,$95,$96,$96,$96,$96,$97,$99,$9a,$9a,$9a,$9a,$9b ; blank

;; cards map

cards_offset_low:              ;
	.byte <(cards+($36* 0)),<(cards+($36* 1)),<(cards+($36* 2)),<(cards+($36* 3)),<(cards+($36* 4)),<(cards+($36* 5)),<(cards+($36* 6)),<(cards+($36* 7)),<(cards+($36* 8)),<(cards+($36* 9))
	.byte <(cards+($36*10)),<(cards+($36*11)),<(cards+($36*12)),<(cards+($36*13)),<(cards+($36*14)),<(cards+($36*15)),<(cards+($36*16)),<(cards+($36*17)),<(cards+($36*18)),<(cards+($36*19))
	.byte <(cards+($36*20)),<(cards+($36*21)),<(cards+($36*22)),<(cards+($36*23)),<(cards+($36*24)),<(cards+($36*25)),<(cards+($36*26)),<(cards+($36*27)),<(cards+($36*28)),<(cards+($36*29))
	.byte <(cards+($36*30)),<(cards+($36*31)),<(cards+($36*32)),<(cards+($36*33)),<(cards+($36*34)),<(cards+($36*35)),<(cards+($36*36)),<(cards+($36*37)),<(cards+($36*38)),<(cards+($36*39))
	.byte <(cards+($36*40)),<(cards+($36*41)),<(cards+($36*42)),<(cards+($36*43)),<(cards+($36*44)),<(cards+($36*45)),<(cards+($36*46)),<(cards+($36*47)),<(cards+($36*48)),<(cards+($36*49))
	.byte <(cards+($36*50)),<(cards+($36*51)),<(cards+($36*52)),<(cards+($36*53)),<(cards+($36*54)),<(cards+($36*55))

cards_offset_high:             ;
	.byte >(cards+($36* 0)),>(cards+($36* 1)),>(cards+($36* 2)),>(cards+($36* 3)),>(cards+($36* 4)),>(cards+($36* 5)),>(cards+($36* 6)),>(cards+($36* 7)),>(cards+($36* 8)),>(cards+($36* 9))
	.byte >(cards+($36*10)),>(cards+($36*11)),>(cards+($36*12)),>(cards+($36*13)),>(cards+($36*14)),>(cards+($36*15)),>(cards+($36*16)),>(cards+($36*17)),>(cards+($36*18)),>(cards+($36*19))
	.byte >(cards+($36*20)),>(cards+($36*21)),>(cards+($36*22)),>(cards+($36*23)),>(cards+($36*24)),>(cards+($36*25)),>(cards+($36*26)),>(cards+($36*27)),>(cards+($36*28)),>(cards+($36*29))
	.byte >(cards+($36*30)),>(cards+($36*31)),>(cards+($36*32)),>(cards+($36*33)),>(cards+($36*34)),>(cards+($36*35)),>(cards+($36*36)),>(cards+($36*37)),>(cards+($36*38)),>(cards+($36*39))
	.byte >(cards+($36*40)),>(cards+($36*41)),>(cards+($36*42)),>(cards+($36*43)),>(cards+($36*44)),>(cards+($36*45)),>(cards+($36*46)),>(cards+($36*47)),>(cards+($36*48)),>(cards+($36*49))
	.byte >(cards+($36*50)),>(cards+($36*51)),>(cards+($36*52)),>(cards+($36*53)),>(cards+($36*54)),>(cards+($36*55))

;; card names

card_names:                    ; [skip]
	.byte $21,$2c,$2d,$38,$29,$00,$17,$25,$2b,$29,$00,$02,$02,$00,$00,$00 ; White Mage 11
	.byte $1d,$31,$25,$30,$30,$00,$1a,$33,$38,$2d,$33,$32,$00,$03,$00,$00 ; Small Potion 2
	.byte $1d,$31,$25,$30,$30,$00,$1a,$33,$38,$2d,$33,$32,$00,$04,$00,$00 ; Small Potion 3
	.byte $17,$29,$28,$2d,$39,$31,$00,$1a,$33,$38,$2d,$33,$32,$00,$05,$00 ; Medium Potion 4
	.byte $17,$29,$28,$2d,$39,$31,$00,$1a,$33,$38,$2d,$33,$32,$00,$06,$00 ; Medium Potion 5
	.byte $16,$25,$36,$2b,$29,$00,$1a,$33,$38,$2d,$33,$32,$00,$07,$00,$00 ; Large Potion 6
	.byte $16,$25,$36,$2b,$29,$00,$1a,$33,$38,$2d,$33,$32,$00,$08,$00,$00 ; Large Potion 7
	.byte $1d,$39,$34,$29,$36,$00,$1a,$33,$38,$2d,$33,$32,$00,$09,$00,$00 ; Super Potion 8
	.byte $1d,$39,$34,$29,$36,$00,$1a,$33,$38,$38,$33,$32,$00,$0a,$00,$00 ; Super Potion 9
	.byte $1d,$39,$34,$29,$36,$00,$1a,$33,$38,$2d,$33,$32,$00,$02,$01,$00 ; Super Potion 10
	.byte $21,$2c,$2d,$38,$29,$00,$17,$25,$2b,$29,$00,$02,$02,$00,$00,$00 ; White Mage 11
	.byte $21,$2c,$2d,$38,$29,$00,$17,$25,$2b,$29,$00,$02,$02,$00,$00,$00 ; White Mage 11
	.byte $21,$2c,$2d,$38,$29,$00,$17,$25,$2b,$29,$00,$02,$02,$00,$00,$00 ; White Mage 11
	.byte $1c,$29,$28,$00,$31,$25,$2b,$29,$00,$02,$02,$00,$00,$00,$00,$00 ; Red Mage 11
	.byte $0c,$39,$27,$2f,$30,$29,$36,$00,$03,$00,$00,$00,$00,$00,$00,$00 ; Buckler 2
	.byte $0c,$39,$27,$2f,$30,$29,$36,$00,$04,$00,$00,$00,$00,$00,$00,$00 ; Buckler 3
	.byte $15,$2d,$38,$29,$00,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Kite 4
	.byte $15,$2d,$38,$29,$00,$06,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Kite 5
	.byte $12,$29,$25,$38,$29,$36,$00,$07,$00,$00,$00,$00,$00,$00,$00,$00 ; Heater 6
	.byte $12,$29,$25,$38,$29,$36,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00 ; Heater 7
	.byte $1e,$33,$3b,$29,$36,$00,$1d,$2c,$2d,$29,$30,$28,$00,$09,$00,$00 ; Tower Shield 8
	.byte $1e,$33,$3b,$29,$36,$00,$1d,$2c,$2d,$29,$30,$28,$00,$0a,$00,$00 ; Tower Shield 9
	.byte $1e,$33,$3b,$29,$36,$00,$1d,$2c,$2d,$29,$30,$28,$00,$02,$01,$00 ; Tower Shield 10
	.byte $1c,$29,$28,$00,$31,$25,$2b,$29,$00,$02,$02,$00,$00,$00,$00,$00 ; Red Mage 11
	.byte $1c,$29,$28,$00,$31,$25,$2b,$29,$00,$02,$02,$00,$00,$00,$00,$00 ; Red Mage 11
	.byte $1c,$29,$28,$00,$31,$25,$2b,$29,$00,$02,$02,$00,$00,$00,$00,$00 ; Red Mage 11
	.byte $0f,$31,$34,$36,$29,$37,$37,$00,$02,$08,$00,$00,$00,$00,$00,$00 ; Empress 17
	.byte $1d,$30,$2d,$31,$29,$00,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Slime 2
	.byte $1e,$39,$32,$32,$29,$30,$29,$36,$00,$04,$00,$00,$00,$00,$00,$00 ; Tunneler 3
	.byte $10,$2d,$29,$32,$28,$00,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Fiend 4
	.byte $0e,$36,$25,$2f,$29,$00,$06,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Drake 5
	.byte $1d,$34,$29,$27,$38,$29,$36,$00,$07,$00,$00,$00,$00,$00,$00,$00 ; Specter 6
	.byte $21,$36,$25,$2d,$38,$2c,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00 ; Ghost 7
	.byte $0f,$30,$29,$31,$29,$32,$38,$25,$30,$00,$09,$00,$00,$00,$00,$00 ; Elemental 8
	.byte $21,$2d,$38,$27,$2c,$00,$0a,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Witch 9
	.byte $10,$25,$31,$2d,$30,$2d,$25,$36,$00,$02,$01,$00,$00,$00,$00,$00 ; Familiar 10
	.byte $0d,$33,$32,$37,$33,$36,$38,$00,$02,$02,$00,$00,$00,$00,$00,$00 ; Consort 11
	.byte $1b,$39,$29,$29,$32,$00,$02,$04,$00,$00,$00,$00,$00,$00,$00,$00 ; Queen 13
	.byte $1c,$29,$2b,$32,$25,$32,$38,$00,$02,$06,$00,$00,$00,$00,$00,$00 ; Regnant 15
	.byte $0f,$31,$34,$36,$29,$37,$37,$00,$02,$08,$00,$00,$00,$00,$00,$00 ; Empress 17
	.byte $1c,$25,$38,$00,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Rat 2
	.byte $0c,$25,$38,$00,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Bat 3
	.byte $13,$31,$34,$00,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Imp 4
	.byte $11,$33,$26,$30,$2d,$32,$00,$06,$00,$00,$00,$00,$00,$00,$00,$00 ; Goblin 5
	.byte $19,$36,$27,$00,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Orc 6
	.byte $19,$2b,$36,$29,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Ogre 7
	.byte $0c,$29,$2c,$33,$30,$28,$29,$36,$00,$09,$00,$00,$00,$00,$00,$00 ; Beholder 8
	.byte $17,$29,$28,$39,$37,$25,$00,$0a,$00,$00,$00,$00,$00,$00,$00,$00 ; Medusa 9
	.byte $0e,$29,$31,$33,$32,$00,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00 ; Demon 10
	.byte $0d,$33,$32,$37,$33,$36,$38,$00,$02,$02,$00,$00,$00,$00,$00,$00 ; Consort 11
	.byte $1b,$39,$29,$29,$32,$00,$02,$04,$00,$00,$00,$00,$00,$00,$00,$00 ; Queen 13
	.byte $1c,$29,$2b,$32,$25,$32,$38,$00,$02,$06,$00,$00,$00,$00,$00,$00 ; Regnant 15
	.byte $1c,$29,$28,$00,$0e,$33,$32,$37,$33,$30,$00,$03,$02,$00,$00,$00 ; Red Donsol 21
	.byte $0c,$30,$25,$27,$2f,$00,$0e,$33,$32,$37,$33,$30,$00,$03,$02,$00 ; Black Donsol 21
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; Blank

card_names_offset_lb:          ;
	.byte <(card_names+($0f* 0)),<(card_names+($0f* 1)),<(card_names+($0f* 2)),<(card_names+($0f* 3)),<(card_names+($0f* 4)),<(card_names+($0f* 5)),<(card_names+($0f* 6)),<(card_names+($0f* 7)),<(card_names+($0f* 8)),<(card_names+($0f* 9))
	.byte <(card_names+($0f*10)),<(card_names+($0f*11)),<(card_names+($0f*12)),<(card_names+($0f*13)),<(card_names+($0f*14)),<(card_names+($0f*15)),<(card_names+($0f*16)),<(card_names+($0f*17)),<(card_names+($0f*18)),<(card_names+($0f*19))
	.byte <(card_names+($0f*20)),<(card_names+($0f*21)),<(card_names+($0f*22)),<(card_names+($0f*23)),<(card_names+($0f*24)),<(card_names+($0f*25)),<(card_names+($0f*26)),<(card_names+($0f*27)),<(card_names+($0f*28)),<(card_names+($0f*29))
	.byte <(card_names+($0f*30)),<(card_names+($0f*31)),<(card_names+($0f*32)),<(card_names+($0f*33)),<(card_names+($0f*34)),<(card_names+($0f*35)),<(card_names+($0f*36)),<(card_names+($0f*37)),<(card_names+($0f*38)),<(card_names+($0f*39))
	.byte <(card_names+($0f*40)),<(card_names+($0f*41)),<(card_names+($0f*42)),<(card_names+($0f*43)),<(card_names+($0f*44)),<(card_names+($0f*45)),<(card_names+($0f*46)),<(card_names+($0f*47)),<(card_names+($0f*48)),<(card_names+($0f*49))
	.byte <(card_names+($0f*50)),<(card_names+($0f*51)),<(card_names+($0f*52)),<(card_names+($0f*53)),<(card_names+($0f*54)),<(card_names+($0f*55))

card_names_offset_hb:          ;
	.byte >(card_names+($0f* 0)),>(card_names+($0f* 1)),>(card_names+($0f* 2)),>(card_names+($0f* 3)),>(card_names+($0f* 4)),>(card_names+($0f* 5)),>(card_names+($0f* 6)),>(card_names+($0f* 7)),>(card_names+($0f* 8)),>(card_names+($0f* 9))
	.byte >(card_names+($0f*10)),>(card_names+($0f*11)),>(card_names+($0f*12)),>(card_names+($0f*13)),>(card_names+($0f*14)),>(card_names+($0f*15)),>(card_names+($0f*16)),>(card_names+($0f*17)),>(card_names+($0f*18)),>(card_names+($0f*19))
	.byte >(card_names+($0f*20)),>(card_names+($0f*21)),>(card_names+($0f*22)),>(card_names+($0f*23)),>(card_names+($0f*24)),>(card_names+($0f*25)),>(card_names+($0f*26)),>(card_names+($0f*27)),>(card_names+($0f*28)),>(card_names+($0f*29))
	.byte >(card_names+($0f*30)),>(card_names+($0f*31)),>(card_names+($0f*32)),>(card_names+($0f*33)),>(card_names+($0f*34)),>(card_names+($0f*35)),>(card_names+($0f*36)),>(card_names+($0f*37)),>(card_names+($0f*38)),>(card_names+($0f*39))
	.byte >(card_names+($0f*40)),>(card_names+($0f*41)),>(card_names+($0f*42)),>(card_names+($0f*43)),>(card_names+($0f*44)),>(card_names+($0f*45)),>(card_names+($0f*46)),>(card_names+($0f*47)),>(card_names+($0f*48)),>(card_names+($0f*49))
	.byte >(card_names+($0f*50)),>(card_names+($0f*51)),>(card_names+($0f*52)),>(card_names+($0f*53)),>(card_names+($0f*54)),>(card_names+($0f*55))

;; splash

selections_splash_lo:
	.byte <(6 * 16),<(12 * 16),<(20 * 16)

selections_splash_hi:
	.byte >(6 * 16),>(12 * 16),>(20 * 16)

SplashMap:                   ; [skip]
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$98,$98,$98,$98,$98,$98,$98,$98,$98,$98,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a9,$aa,$a9,$aa,$a9,$aa,$a9,$aa,$a9,$aa,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a5,$a4,$a5,$a4,$a5,$a5,$a4,$a5,$a4,$a5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a5,$00,$a5,$00,$a5,$a5,$00,$a5,$00,$a5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a5,$96,$a5,$96,$a5,$a5,$96,$a5,$96,$a5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$aa,$a9,$aa,$a9,$aa,$a9,$aa,$a9,$aa,$a9,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$b1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a5,$a5,$a5,$a5,$a5,$a5,$a5,$a5,$a5,$a5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a7,$a7,$a5,$a7,$a5,$a5,$a5,$a5,$a3,$a5,$a3,$a3,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$b8,$b1,$b5,$b9,$b1,$b5,$b8,$b2,$b5,$b9,$b1,$90,$b9,$b1,$b5,$b3,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$ba,$00,$ba,$ba,$00,$ba,$ba,$00,$ba,$b6,$b1,$b5,$ba,$00,$ba,$ba,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$ba,$00,$ba,$ba,$00,$ba,$ba,$00,$ba,$b3,$00,$ba,$ba,$00,$ba,$ba,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$b0,$b1,$bb,$b6,$b1,$bb,$b0,$00,$b4,$b6,$b1,$bb,$b6,$b1,$bb,$b6,$b1,$90,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a1,$a1,$a5,$a1,$a9,$b1,$b1,$a9,$a0,$a5,$a0,$a0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a5,$a4,$a5,$aa,$a6,$a6,$aa,$a5,$a4,$a5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a5,$00,$a5,$aa,$00,$00,$aa,$a5,$00,$a5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a8,$a5,$96,$a5,$aa,$00,$00,$aa,$a5,$96,$a5,$a8,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$ac,$ab,$ab,$ab,$ab,$af,$ae,$ae,$af,$ab,$ab,$ab,$ab,$ad,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ab,$af,$af,$ab,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ab,$ab,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$0f,$25,$37,$3d,$00,$00,$18,$33,$36,$31,$25,$30,$00,$00,$12,$25,$36,$28,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
SplashMap_end:
	SPLASH_MAP_SIZE = SplashMap_end - SplashMap

attributes_splash:             ;
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
	.byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
