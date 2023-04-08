
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

	; set x pos
	TARGET_SPRITE_AUTOINCR (SplashCursorSprite+2)
	LDX cursor_splash
	LDA selections_splash, x
	STA Vera::Data0
	STZ Vera::Data0

	; set y pos
	LDA #$C8
	STA Vera::Data0
	STZ Vera::Data0
@done:                         ;
	jmp (default_irq_vector) 

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
	jmp (default_irq_vector) 

;; load background table

load_splash:                   ;
	RAM2VRAM_PAD SplashMap, Map0VRAM, SPLASH_MAP_SIZE
	RTS 

;; load attribute table

loadAttributes_splash:         ;
; 	BIT PPUSTATUS
; 	LDA #$23
; 	STA PPUADDR
; 	LDA #$C0
; 	STA PPUADDR
; 	LDX #$00
; @loop:                         ;
; 	LDA attributes_splash, x
; 	STA PPUDATA
; 	INX 
; 	CPX #$40
; 	BNE @loop
	RTS 

addScore_splash:               ;
	lda number_high, x
	STA_TILE 16,7
	lda number_low, x
	STA_TILE 15,7
	RTS 

addNecomedre_splash:           ; $6a,$6b,$6e
; 	LDA difficulty_splash
; 	CMP #$00
; 	BEQ @skip
; 	BIT PPUSTATUS                ; draw score on splash
; 	; head
; 	LDA #$22
; 	STA PPUADDR
; 	LDA #$48
; 	STA PPUADDR
; 	LDA #$6A
; 	STA PPUDATA
; 	; torso
; 	LDA #$22
; 	STA PPUADDR
; 	LDA #$68
; 	STA PPUADDR
; 	LDA #$6B
; 	STA PPUDATA
; 	; legs
; 	LDA #$22
; 	STA PPUADDR
; 	LDA #$88
; 	STA PPUADDR
; 	LDA #$6E
; 	STA PPUDATA
; @skip:                         ;
	RTS 

addPolycat_splash:             ; $6a,$6b,$6e
; 	LDA difficulty_splash
; 	CMP #$00
; 	BEQ @skip
; 	CMP #$01
; 	BEQ @skip
; 	BIT PPUSTATUS                ; draw score on splash
; 	; head
; 	LDA #$22
; 	STA PPUADDR
; 	LDA #$77
; 	STA PPUADDR
; 	LDA #$80
; 	STA PPUDATA
; 	; torso
; 	LDA #$22
; 	STA PPUADDR
; 	LDA #$98
; 	STA PPUADDR
; 	LDA #$94
; 	STA PPUDATA
; 	; legs
; 	LDA #$22
; 	STA PPUADDR
; 	LDA #$97
; 	STA PPUADDR
; 	LDA #$84
; 	STA PPUDATA
; @skip:                         ;
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
