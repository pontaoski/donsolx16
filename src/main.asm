
;; Main

handleTimer:                   ; when auto_room is 1, do post flip actions
	LDA auto_room
	CMP #$01
	BNE @skip
	DEC auto_room
	JSR flipPost_room
@skip:                         ;

;; skip if no input

handleJoy:                     ;
	LDA next_input
	CMP #$00
	BNE releaseJoy
	INC seed1_deck               ; increment seed1
	JMP __MAIN

;; release input, store in regA

releaseJoy:                    ;
	LDA next_input
	LDX #$00                     ; release
	STX next_input
	INC seed2_deck               ; increment seed2 on input

checkJoy:                      ;
	LDX view_game
	CPX #$00
	BNE @game
@splash:                       ;
	CMP BUTTON_RIGHT
	BEQ onRight_splash
	CMP BUTTON_LEFT
	BEQ onLeft_splash
	CMP BUTTON_START
	BEQ onStart_splash
	CMP BUTTON_B
	BEQ onB_splash
	CMP BUTTON_A
	BEQ onA_splash
	JMP __MAIN
@game:                         ;
	CMP BUTTON_RIGHT
	BEQ onRight_game
	CMP BUTTON_LEFT
	BEQ onLeft_game
	CMP BUTTON_SELECT
	BEQ onSelect_game
	CMP BUTTON_START
	BEQ onStart_game
	CMP BUTTON_B
	BEQ onB_game
	CMP BUTTON_A
	BEQ onA_game
	JMP __MAIN

onRight_splash:                ;
	JSR NextDifficulty_splash
	JMP __MAIN

onLeft_splash:
	JSR PrevDifficulty_splash
	JMP __MAIN

onStart_splash:                ;
	JSR Toggle_sound
	JMP __MAIN

onB_splash:
	LDA cursor_splash
	STA difficulty_player        ; store difficulty
	JSR show_game
	JMP __MAIN

onA_splash:                    ;
	LDA cursor_splash
	STA difficulty_player        ; store difficulty
	JSR show_game
	JMP __MAIN

onRight_game:                  ;
	INC cursor_game
	LDA cursor_game
	CMP #$04
	BNE @done
	; wrap around
	LDA #$00
	STA cursor_game
@done:                         ;
	LDA #$01                     ; request draw for cursor
	STA reqdraw_cursor
	STA reqdraw_name
	JSR Move_sound
	JMP __MAIN

onLeft_game:                   ;
	DEC cursor_game
	LDA cursor_game
	CMP #$FF
	BNE @done
	; wrap around
	LDA #$03
	STA cursor_game
@done:                         ;
	LDA #$01                     ; request draw for cursor
	STA reqdraw_cursor
	STA reqdraw_name
	JSR Move_sound
	JMP __MAIN

onSelect_game:                 ;
	JSR show_splash
	JMP __MAIN

onStart_game:                  ;
	JSR Toggle_sound
	JMP __MAIN

onB_game:                      ;
	JSR tryRun_player
	JMP __MAIN

onA_game:                      ;
	JSR tryFlip_room             ; flip selected card
	JMP __MAIN
