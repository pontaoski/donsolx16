; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

;; room

enter_room:                    ;
	JSR pullCard_deck            ; pull card1
	LDY hand_deck
	TYA 
	STA card1_room
	JSR pullCard_deck            ; pull card2
	LDY hand_deck
	TYA 
	STA card2_room
	JSR pullCard_deck            ; pull card3
	LDY hand_deck
	TYA 
	STA card3_room
	JSR pullCard_deck            ; pull card4
	LDY hand_deck
	TYA 
	STA card4_room
	; etcs
	JSR updateBuffers_room
	JSR updateExperience_player  ; update experience
	; need redraws
	LDA #$01
	STA reqdraw_name
	; new draws
	LDA #%11111111
	STA redraws_game
	; JSR Enter_sound
	RTS 

;; flip card from the table, used in controls when press

tryFlip_room:                  ;
	LDA hp_player
	CMP #$00
	BEQ @skip
	; when player is alive
	LDX cursor_game              ; load card at cursor position
	LDA card1_room, x
	CMP #$36
	BEQ @skip
	; when card is not flipped
	JSR flipCard_room
@skip:                         ;
	RTS 

flipCard_room:                 ; (x:card_pos) ->
	TAY                          ; pick card
	JSR pickCard_deck
	LDA #$36                     ; flip card
	STA card1_room, x
@done:                         ; post flipping a card
	JSR updateBuffers_room       ; update card buffers
	JSR updateExperience_player  ; update experience
	JSR updateScore_splash
	; need redraws
	LDA #%11111111               ; TODO | be more selective with the redraw, don't redraw all cards if not needed!
	STA redraws_game
	; start timer
	LDA #$20                     ; timer length before running flipPost_room
	STA timer_room
@skip:
	RTS 

flipPost_room:                 ;
	; check if player is alive
	LDA hp_player
	CMP #$00
	BEQ @death
	; check if player reached end of deck
	LDA xp_player
	CMP #$36
	BEQ @complete
	; check if all cards are flipped
	JSR loadCardsLeft_room       ; stores in regX
	CPX #$00
	BEQ @proceed
	RTS 
@death:                        ;
	RTS 
@proceed:                      ;
	LDA #$00
	STA has_run_player
	JSR enter_room               ;
	RTS 
@complete:                     ;
	LDA #$10                     ; dialog:victory
	JSR show_dialog
	JSR updateDifficulty_splash
	RTS 

;; return non-flipped cards back to the end of the deck

returnCards_room:              ;
	LDY #$00                     ; increment
@loop:
	LDA card1_room, y
	CMP #$36
	BEQ @skip
	JSR returnCard_deck          ; warning: write on regX
@skip:
	INY 
	CPY #$04
	BNE @loop
	RTS 

;; count enemy cards left in play

loadEnemiesLeft_room:          ; () -> x:count
	LDX #$00                     ; count
	LDY #$00                     ; increment
@loop:
	LDA card1_room, y
	CMP #$20
	BCC @skip                    ; heart/diamonds
	CMP #$36
	BEQ @skip                    ; don't count flipped cards
	INX 
@skip:
	INY 
	CPY #$04
	BNE @loop
	RTS 

;; count cards left in play

loadCardsLeft_room:            ; () -> x:count
	LDX #$00                     ; count
	LDY #$00                     ; increment
@loop:
	LDA card1_room, y
	CMP #$36
	BEQ @skip
	INX 
@skip:
	INY 
	CPY #$04
	BNE @loop
	RTS 

;; notes

	; Form a 16-bit address contained in the given location, AND the one
	; following.  Add to that address the contents of the Y register.
	; Fetch the value stored at that address.
	;   LDA ($B4),Y  where Y contains 6
	; If $B4 contains $EE AND $B5 contains $12 then the value at memory
	; location $12EE + Y (6) = $12F4 is fetched AND put in the accumulator.

.macro UpdateBuffers card, buffer
	.scope
		STZ id_temp
		LDY card
		LDA cards_offset_low, y
		STA lb_temp
		LDA cards_offset_high, y
		STA hb_temp
	@loop:
		LDY id_temp
		LDA (lb_temp), y
		STA buffer, y
		INC id_temp
		LDA id_temp
		CMP #$36
		BNE @loop
	.endscope
.endmacro

updateBuffers_room:
	UpdateBuffers card1_room, CARDBUF1
	UpdateBuffers card2_room, CARDBUF2
	UpdateBuffers card3_room, CARDBUF3
	UpdateBuffers card4_room, CARDBUF4

	RTS
