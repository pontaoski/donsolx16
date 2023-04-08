
;; Game

show_game:                     ;
	LDA #$01
	STA reqdraw_game
	STA reqdraw_cursor
	STA view_game                ; set view
	JSR restart_game             ; restart
	RTS 

restart_game:                  ;
	JSR init_deck                ; deck
	; JSR shuffle_deck
	JSR reset_player             ; player
	JSR enter_room
	LDA #$0D
	CLC 
	ADC difficulty_player        ; reflect difficulty
	JSR show_dialog              ; dialog:difficulty
	RTS 

interpolateStats_game:         ;
	LDA spui_game                ;
	CMP sp_player                ; sprite x
	BEQ @skip
	BCC @incShield
	DEC spui_game                ; when less
	JMP @redrawShield
@incShield:                    ;
	INC spui_game
@redrawShield:                 ;
	LDA redraws_game             ; request redraw
	ORA #REQ_SP
	STA redraws_game
	RTS 
@skip:                         ;
	LDA hpui_game                ; interpolate health
	CMP hp_player                ; sprite x
	BEQ @done
	BCC @incHealth
	DEC hpui_game
	JMP @redrawHealth
@incHealth:                    ;
	INC hpui_game
@redrawHealth:                 ;
	LDA redraws_game             ; request redraw
	ORA #REQ_HP
	STA redraws_game
@done:                         ;
	RTS 

redrawScreen_game:             ;
	; remove flag
	LDA #$00
	STA reqdraw_game
	JSR stop_renderer
	JSR load_game
	JSR loadInterface_game
	JSR loadAttributes_game
	JSR start_renderer
	jmp (default_irq_vector) 

load_game:
	ZERO_VRAM Map0VRAM, 1790
	RTS 

loadInterface_game:
	; HP
	LDA #$12
	STA_TILE 3,8
	LDA #$1A
	STA Vera::Data0
	STZ Vera::Data0

	; SP
	LDA #$1D
	STA_TILE 10,8
	LDA #$1A
	STA Vera::Data0
	STZ Vera::Data0

	; XP
	LDA #$22
	STA_TILE 17,8
	LDA #$1A
	STA Vera::Data0
	STZ Vera::Data0

	RTS 

loadAttributes_game:
	; TODO: initialize palettes
	RTS 

redrawCursor_game:             ;
	; remove flag
	LDA #$00
	STA reqdraw_cursor
	; setup
	LDA #$B0
	STA $0200                    ; (part1)set tile.y pos
	LDA #$13
	STA $0201                    ; (part1)set tile.id
	LDA #$00
	STA $0202                    ; (part1)set tile.attribute[off]
	LDX cursor_game
	LDA selections_game, x
	STA $0203                    ; set tile.x pos
	JSR sprites_renderer
@done:                         ;
	jmp (default_irq_vector) 

;; redraw

redrawHealth_game:             ;
	; remove flag
	LDA redraws_game
	EOR #REQ_HP
	STA redraws_game
	LDY hpui_game

	; digits
	LDA number_high, y
	STA_TILE 7,8
	LDA number_low, y
	STA Vera::Data0
	STZ Vera::Data0

	; progress bar
			LDA healthbarpos, y          ; regA has sprite offset
			TAY                          ; regY has sprite offset
			LDX #$00
		@loop:                         ;
			LDA #$01
			STA Vera::AddrHigh
			LDA healthbaroffset, x
			STA Vera::AddrLow
			LDA progressbar, y           ; regA has sprite id
			STA Vera::Data0
			INY 
			INX 
			CPX #$06
			BNE @loop

	LDA sickness_player
	CMP #$01
	BNE @false
	; sickness icon
	LDA #$3F
	STA_TILE 5,8
	JMP @done
@false:
	LDA #$00
	STA_TILE 5,8
@done:                         ;
	JSR fix_renderer
	jmp (default_irq_vector) 

;; shield value

redrawShield_game:             ;
	; remove flag
	LDA redraws_game
	EOR #REQ_SP
	STA redraws_game
	LDY spui_game

	; digits
	LDA number_high, y
	STA_TILE 14,8
	LDA number_low, y
	STA Vera::Data0
	STZ Vera::Data0

	; progress bar
			LDA shieldbarpos, y          ; regA has sprite offset
			TAY                          ; regY has sprite offset
			LDX #$00
		@loop:                         ;
			LDA #$01
			STA Vera::AddrHigh
			LDA shieldbaroffset, x
			STA Vera::AddrLow
			LDA progressbar, y           ; regA has sprite id
			STA Vera::Data0
			INY 
			INX 
			CPX #$06
			BNE @loop

	; durability
	LDX dp_player
	LDA card_glyphs, x
	STA_TILE 12,8

	JSR fix_renderer
	jmp (default_irq_vector) 

;; experience value

redrawExperience_game:         ;
	; remove flag
	LDA redraws_game
	EOR #REQ_XP
	STA redraws_game
	LDY xp_player

	; digits
	LDA number_high, y
	STA_TILE 21,8
	LDA number_low, y
	STA Vera::Data0
	STZ Vera::Data0

	; progress bar
			LDA experiencebarpos, y      ; regA has sprite offset
			TAY                          ; regY has sprite offset
			LDX #$00
		@loop:                         ;
			LDA #$01
			STA Vera::AddrHigh
			LDA experiencebaroffset, x
			STA Vera::AddrLow
			LDA progressbar, y           ; regA has sprite id
			STA Vera::Data0
			INY 
			INX 
			CPX #$06
			BNE @loop

	JSR fix_renderer
	jmp (default_irq_vector) 

redrawRun_game:                ;
	; remove flag
	LDA redraws_game
	EOR #REQ_RUN
	STA redraws_game
; 	JSR stop_renderer
; 	LDA length_deck              ; don't display the run butto on first hand
; 	CMP #$31                     ; deck is $36 - 4(first hand)
; 	BEQ @hide
; 	JSR loadRun_player           ; load canRun in regA
; 	CMP #$01
; 	BNE @hide
; 	LDA length_deck              ; Can't run the last room
; 	CMP #$00
; 	BEQ @hide
; @show:                         ; RUN: $1c,$1f,$18
; 	BIT PPUSTATUS                ; read PPU status to reset the high/low latch
; 	LDA #$21
; 	STA PPUADDR                  ; write the high byte
; 	LDA #$18
; 	STA PPUADDR                  ; write the low byte
; 	LDA #$6D                     ; Button(B)
; 	STA PPUDATA
; 	LDA #$00                     ; Blank
; 	STA PPUDATA
; 	LDA #$1C                     ; R
; 	STA PPUDATA
; 	LDA #$1F                     ; U
; 	STA PPUDATA
; 	LDA #$18                     ; N
; 	STA PPUDATA
; 	JSR start_renderer
; 	jmp (default_irq_vector) 
; @hide:                         ;
; 	BIT PPUSTATUS                ; read PPU status to reset the high/low latch
; 	LDA #$21
; 	STA PPUADDR                  ; write the high byte
; 	LDA #$18
; 	STA PPUADDR                  ; write the low byte
; 	LDA #$00                     ; R
; 	STA PPUDATA
; 	STA PPUDATA
; 	STA PPUDATA
; 	STA PPUDATA
; 	STA PPUDATA
	JSR start_renderer
	jmp (default_irq_vector) 

redrawName_game:               ;
	; remove trigger
	LDA #$00
	STA reqdraw_name

	PREPARE_TILE 3, 10
	LDX #0
@loop:                         ;
	LDY #$01                     ; load card id
	; load card name
	LDY cursor_game
	LDA card1_room, y
	TAY 
	LDA card_names_offset_lb,y
	STA lb_temp
	LDA card_names_offset_hb,y
	STA hb_temp
	TYA 
	STX id_temp
	CLC 
	ADC id_temp
	TAY 
	LDA (lb_temp), y             ; load value at 16-bit address from (lb_temp + hb_temp) + y
	; draw tile
	STA Vera::Data0
	STZ Vera::Data0
	INX 
	CPX #$10
	BNE @loop
	JSR fix_renderer
	jmp (default_irq_vector) 

;; to merge into a single routine

.macro DrawCard request, highbuf, lowbuf, tilebuf
	; remove flag
	LDA redraws_game
	EOR #request
	STA redraws_game
	JSR stop_renderer
 	LDX #$00
@loop:
	LDA highbuf, x
	STA Vera::AddrHigh
	LDA lowbuf, x
	STA Vera::AddrLow
	LDA tilebuf, x
	STA Vera::Data0
	INX
	CPX #$36
	BNE @loop
	JSR start_renderer
	jmp (default_irq_vector) 
.endmacro

redrawCard1_game:
	DrawCard REQ_CARD1, card1pos_high, card1pos_low, CARDBUF1

redrawCard2_game:
	DrawCard REQ_CARD2, card2pos_high, card2pos_low, CARDBUF2

redrawCard3_game:
	DrawCard REQ_CARD3, card3pos_high, card3pos_low, CARDBUF3

redrawCard4_game:
	DrawCard REQ_CARD4, card4pos_high, card4pos_low, CARDBUF4

animateTimer_game:             ; when timer reaches 0, set auto_room flag to 1
	LDA timer_room
	CMP #$00
	BEQ @skip
	; check timer is done
	CMP #$01
	BEQ @run
	DEC timer_room
	RTS 
@run:                          ;
	LDA #$01
	STA auto_room
@skip:                         ;
	RTS 
