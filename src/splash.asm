
;; splash

show_splash:                   ;
	LDA #$00
	STA view_game                ; set view
	LDA #$01
	STA reqdraw_splash
	STA reqdraw_cursor
	RTS 

;; controls

NextDifficulty_splash:
	INC cursor_splash
	LDA cursor_splash
	CMP #$03
	BNE @done
	; wrap around
	LDA #$00
	STA cursor_splash
@done:                         ;
	LDA #$01                     ; request draw for cursor
	STA reqdraw_cursor
	JSR MoveAlt_sound
	RTS 

PrevDifficulty_splash:
	DEC cursor_splash
	LDA cursor_splash
	CMP #$FF
	BNE @done
	; wrap around
	LDA #$02
	STA cursor_splash
@done:
	LDA #$01                     ; request draw for cursor
	STA reqdraw_cursor
	JSR MoveAlt_sound
	RTS 

redrawCursor_splash:           ;
	; remove flag
	LDA #$00
	STA reqdraw_cursor
	; setup
	LDA #$C8
	STA $0200                    ; (part1)set tile.y pos
	LDA #$12
	STA $0201                    ; (part1)set tile.id
	LDA #$00
	STA $0202                    ; (part1)set tile.attribute[off]
	LDX cursor_splash
	LDA selections_splash, x
	STA $0203                    ; set tile.x pos
	JSR sprites_renderer
@done:                         ;
	RTI 

redrawScreen_splash:           ;
	; remove flag
	LDA #$00
	STA reqdraw_splash
	; when needs redraw
	JSR stop_renderer
	JSR load_splash
	JSR loadAttributes_splash
	JSR addScore_splash
	JSR addNecomedre_splash
	JSR addPolycat_splash
	JSR start_renderer
@done:
	RTI 

;; load background table

load_splash:                   ;
	BIT PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$00
	STA PPUADDR
	LDA #<data_splash
	STA lb_temp
	LDA #>data_splash
	STA hb_temp
	LDX #$00
	LDY #$00
@loop:                         ;
	LDA (lb_temp), y
	STA PPUDATA
	INY 
	CPY #$00
	BNE @loop
	INC hb_temp
	INX 
	CPX #$04
	BNE @loop
	RTS 

;; load attribute table

loadAttributes_splash:         ;
	BIT PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$C0
	STA PPUADDR
	LDX #$00
@loop:                         ;
	LDA attributes_splash, x
	STA PPUDATA
	INX 
	CPX #$40
	BNE @loop
	RTS 

addScore_splash:               ;
	BIT PPUSTATUS                ; draw score on splash
	LDA #$20
	STA PPUADDR
	LDA #$EF
	STA PPUADDR
	LDX #$00
	LDX highscore_splash         ; digit 1
	LDA number_high, x
	STA PPUDATA
	LDA number_low, x
	STA PPUDATA
	RTS 

addNecomedre_splash:           ; $6a,$6b,$6e
	LDA difficulty_splash
	CMP #$00
	BEQ @skip
	BIT PPUSTATUS                ; draw score on splash
	; head
	LDA #$22
	STA PPUADDR
	LDA #$48
	STA PPUADDR
	LDA #$6A
	STA PPUDATA
	; torso
	LDA #$22
	STA PPUADDR
	LDA #$68
	STA PPUADDR
	LDA #$6B
	STA PPUDATA
	; legs
	LDA #$22
	STA PPUADDR
	LDA #$88
	STA PPUADDR
	LDA #$6E
	STA PPUDATA
@skip:                         ;
	RTS 

addPolycat_splash:             ; $6a,$6b,$6e
	LDA difficulty_splash
	CMP #$00
	BEQ @skip
	CMP #$01
	BEQ @skip
	BIT PPUSTATUS                ; draw score on splash
	; head
	LDA #$22
	STA PPUADDR
	LDA #$77
	STA PPUADDR
	LDA #$80
	STA PPUDATA
	; torso
	LDA #$22
	STA PPUADDR
	LDA #$98
	STA PPUADDR
	LDA #$94
	STA PPUDATA
	; legs
	LDA #$22
	STA PPUADDR
	LDA #$97
	STA PPUADDR
	LDA #$84
	STA PPUDATA
@skip:                         ;
	RTS 

updateScore_splash:            ;
	LDA xp_player                ; load xp
	CMP highscore_splash
	BCC @done
	STA highscore_splash         ; store highscore
@done:
	RTS 

updateDifficulty_splash:       ;
	LDA difficulty_player        ; load difficulty
	CMP difficulty_splash
	BCC @done
	STA difficulty_splash        ; store difficulty
@done:
	RTS 
