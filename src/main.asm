; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

;; Main

handleTimer:                   ; when auto_room is 1, do post flip actions
	LDA auto_room
	CMP #$01
	BNE @skip
	DEC auto_room
	JSR flipPost_room
@skip:

handleJoy:
	JSR joystick_scan
	LDA #0
	JSR joystick_get
	CMP previous_input
	STA previous_input

	BNE handleInput

	INC seed1_deck               ; increment seed1 on no input
	JMP __MAIN

handleInput:
	INC seed2_deck               ; increment seed2 on input
	LDX view_game
	CPX #$00
	BNE handleJoyGame
handleJoySplash:
	JSR joystick_scan
	LDA #0
	JSR joystick_get
	TAX

	TXA
	AND #ButtonsA::Right
	BEQ onRight_splash
	TXA
	AND #ButtonsA::Left
	BEQ onLeft_splash
	TXA
	AND #ButtonsA::Start
	BEQ onStart_splash
	TXA
	AND #ButtonsA::ButB
	BEQ onB_splash
	TXA
	AND #ButtonsA::ButY
	BEQ onA_splash
	JMP __MAIN
handleJoyGame:
	JSR joystick_scan
	LDA #0
	JSR joystick_get
	TAX

	TXA
	AND #ButtonsA::Right
	BEQ onRight_game
	TXA
	AND #ButtonsA::Left
	BEQ onLeft_game
	TXA
	AND #ButtonsA::Select
	BEQ onSelect_game
	TXA
	AND #ButtonsA::Start
	BEQ onStart_game
	TXA
	AND #ButtonsA::ButB
	BEQ onB_game
	TXA
	AND #ButtonsA::ButY
	BEQ onA_game

	JMP __MAIN

onRight_splash:
	JSR NextDifficulty_splash
	JMP __MAIN

onLeft_splash:
	JSR PrevDifficulty_splash
	JMP __MAIN

onStart_splash:
	JSR Toggle_sound
	JMP __MAIN

onB_splash:
	LDA cursor_splash
	STA difficulty_player        ; store difficulty
	JSR show_game
	JMP __MAIN

onA_splash:
	LDA cursor_splash
	STA difficulty_player        ; store difficulty
	JSR show_game
	JMP __MAIN

onRight_game:
	INC cursor_game
	LDA cursor_game
	CMP #$04
	BNE @done
	; wrap around
	LDA #$00
	STA cursor_game
@done:
	LDA #$01                     ; request draw for cursor
	STA reqdraw_cursor
	STA reqdraw_name
	JSR Move_sound
	JMP __MAIN

onLeft_game:
	DEC cursor_game
	LDA cursor_game
	CMP #$FF
	BNE @done
	; wrap around
	LDA #$03
	STA cursor_game
@done:
	LDA #$01                     ; request draw for cursor
	STA reqdraw_cursor
	STA reqdraw_name
	JSR Move_sound
	JMP __MAIN

onSelect_game:
	JSR show_splash
	JMP __MAIN

onStart_game:
	JSR Toggle_sound
	JMP __MAIN

onB_game:
	JSR tryRun_player
	JMP __MAIN

onA_game:
	JSR tryFlip_room             ; flip selected card
	JMP __MAIN
