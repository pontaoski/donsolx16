; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

;; deck: Create a deck of 54($36) cards, from zeropage $80

init_deck:                     ;
 	LDA #$35                     ; set deck length
 	STA length_deck
	LDX #$00
@loop:                         ;
	TXA 
	STA CardDeck, x                   ; fill the deck with cards(ordered)
	INX 
	CPX #$36
	BNE @loop
	RTS 

;; take last card from the deck

pullCard_deck:                 ;
	LDA length_deck
	CMP #$00
	BEQ @finished
	; when cards are left
	LDA CardDeck
	STA hand_deck
	JSR shift_deck
	RTS 
@finished:                     ;
	LDA #$36
	STA hand_deck
	RTS 

;; return card to deck

returnCard_deck:               ; (a:card_id)
	LDX length_deck
	INX 
	STA CardDeck, x
	INC length_deck
	RTS 

;; Shift deck forward by 1

shift_deck:                    ;
	DEC length_deck
	LDX #$00
@loop:                         ;
	TXA 
	TAY 
	INY 
	LDA CardDeck, y
	STA CardDeck, x
	INX 
	; experiment
	TXA 
	SBC #$01
	CMP length_deck              ;
	BNE @loop
@done:                         ;
	RTS 

;; Pick card from the deck

pickCard_deck:                 ; (y:card_id)
	TYA                          ; transfer from Y to A
	; check if card is flipped
	CMP #$36                     ; if card is $36(flipped)
	BEQ @done                    ; skip selection
	; load card data
	LDA card_types, y
	STA card_last_type           ; load type
	LDA card_values, y
	STA card_last_value          ; load value
	; branch types
	LDA card_types, y
@heart:                        ;
	CMP #$00
	BNE @diamond
	JSR pickPotion_deck
	JSR addSickness_player
	RTS 
@diamond:                      ;
	CMP #$01
	BNE @enemies
	JSR pickShield_deck
	JSR removeSickness_player
	RTS 
@enemies:                      ;
	JSR pickEnemy_deck
	JSR removeSickness_player
@done:                         ;
	RTS 

;; turn(potion)

pickPotion_deck:               ;
	; check for potion sickness
	LDA sickness_player
	CMP #$01
	BNE @tryWaste
	; when sick
	LDA #$01                     ; dialog:sickness
	JSR show_dialog
	JSR PotionError_sound
	RTS 
@tryWaste:                     ;
	LDA hp_player
	CMP #$15
	BNE @heal
	; when already full health
	LDA #$07                     ; dialog:potion
	JSR show_dialog
	JSR PotionError_sound
	RTS 
@heal:                         ;
	LDA hp_player
	CLC 
	ADC card_last_value
	STA hp_player
	; specials
	JSR clampHealth_player
	LDA #$06                     ; dialog:potion
	JSR show_dialog
	JSR Potion_sound
	RTS 

;; turn(shield)

pickShield_deck:               ;
	LDA card_last_value
	STA sp_player
	LDA #$16                     ; max durability is $15+1
	STA dp_player
	LDA #$05                     ; dialog: shield
	JSR show_dialog
	JSR Shield_sound
	RTS 

;; turn(attack)

pickEnemy_deck:                ;
	; check if can block
	LDA sp_player
	CMP #$00
	BNE @blocking
	LDA #$08                     ; dialog:unshielded
	JSR show_dialog
	; load damages(unblocked)
	LDA card_last_value
	STA damages_player
	JSR runDamages
	JSR EnemyBad_sound
	RTS 
@blocking:                     ;
	; check if shield breaking
	LDA card_last_value
	CMP dp_player
	BCC @shielded
	LDA #$02                     ; dialog:shield break
	JSR show_dialog
	; break shield
	LDA #$00
	STA sp_player
	STA dp_player
	; load damages(unblocked)
	LDA card_last_value
	STA damages_player
	JSR runDamages
	JSR ShieldError_sound
	RTS 
@shielded:                     ;
	; check for overflow
	LDA card_last_value
	CMP sp_player
	BCC @blocked
	LDA #$0B                     ; dialog:damages
	JSR show_dialog
	; load damages(partial)
	LDA card_last_value
	SEC 
	SBC sp_player                ; damages is now stored in A
	STA damages_player
	JSR runDamages
	; damage shield
	LDA card_last_value
	STA dp_player
	JSR EnemyMedium_sound
	RTS 
@blocked:                      ;
	; damage shield
	LDA card_last_value
	STA dp_player
	LDA #$0A                     ; dialog:blocked
	JSR show_dialog
	JSR EnemyGood_sound
	RTS 

;; damages

runDamages:                    ;
	; check if killing
	LDA damages_player
	CMP hp_player
	BCC @survive
	LDA #$00
	STA hp_player
	STA sp_player
	LDA #$03                     ; dialog:death
	JSR show_dialog
	JSR Death_sound
	RTS                          ; stop attack phase
@survive:                      ;
	LDA hp_player
	SEC 
	SBC damages_player
	STA hp_player
	RTS 

;; Shuffle

.macro POKE seed
	pha
	lda seed
	beq @doEor
	asl
	bcc @noEor
@doEor:
	eor #$1d
@noEor:
	sta seed
	pla
	rts
.endmacro

poke_seed1:
	POKE seed1_deck
poke_seed2:
	POKE seed2_deck

seed1_between:
	jsr poke_seed1
@ensureX:
	; ensure x <= seed1_deck
	cpx seed1_deck
	beq @ensureY
	bcs seed1_between
@ensureY:
	; ensure seed1_deck <= y
	cpy seed1_deck
	beq @done
	bcc seed1_between
@done:
	rts

shuffle_deck:
	; initial shuffle
	ldx #$00

@loop:
	ldy #$35
	jsr seed1_between

	ldy CardDeck, x
	sty swap_temp

	phx
		ldx seed1_deck
		ldy CardDeck, x
		lda swap_temp
		sta CardDeck, x
	plx

	sty CardDeck, x

	inx
	cpx #$36
	bne @loop

	RTS
