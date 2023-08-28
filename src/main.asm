; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

;; Main

.macro Compare16bit num1, num2
	.local @ope
	lda num1+1
	cmp #>num2
	bne @ope
	lda num1
	cmp #<num2
@ope:
.endmacro

handleTimer:                   ; when auto_room is 1, do post flip actions
	LDA auto_room
	CMP #$01
	BNE @skip
	DEC auto_room
	JSR flipPost_room
@skip:

handleJoy:
	LDX #mouse_x
	JSR mouse_get

	CMP past_mouse_btn
	BNE @storeMouse
	STZ mouse_btn
	STA past_mouse_btn
	BRA @goToHandleMouse

@storeMouse:
	STA mouse_btn
	STA past_mouse_btn

@goToHandleMouse:
	JMP handleMouse

backToJoy:
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

handleMouse:
	LDX view_game
	CPX #$00
	BEQ handleMouseSplash
	JMP handleMouseGame

handleMouseSplash:
	Compare16bit mouse_y, (25 * 16)
	BCC @done
	Compare16bit mouse_y, (26 * 16)
	BCS @done

@leftButton:
	Compare16bit mouse_x, (12 * 16)
	BCS @middleButton

    LDA #$00
    STA cursor_splash
    LDA #$01
    STA reqdraw_cursor
    JSR MoveAlt_sound

    LDA mouse_btn
    CMP #0
    BEQ @done
    JMP mouseStartGame

@middleButton:
	Compare16bit mouse_x, (20 * 16)
	BCS @rightButton

    LDA #$01
    STA cursor_splash
    LDA #$01
    STA reqdraw_cursor
    JSR MoveAlt_sound

    LDA mouse_btn
    CMP #0
    BEQ @done
    JMP mouseStartGame

@rightButton:
    LDA #$02
    STA cursor_splash
    LDA #$01
    STA reqdraw_cursor
    JSR MoveAlt_sound

    LDA mouse_btn
    CMP #0
    BEQ @done
    JMP mouseStartGame

@done:
	JMP backToJoy

mouseStartGame:
	LDA cursor_splash
	STA difficulty_player
	JSR show_game
	JMP __MAIN

handleMouseGame:

@topRow:
	Compare16bit mouse_y, (6 * 16)
	BCC @midRow
	Compare16bit mouse_y, (7 * 16)
	BCS @midRow

	Compare16bit mouse_x, (24 * 16)
	BCC @topRowDone
	Compare16bit mouse_x, (29 * 16)
	BCS @topRowDone

    LDA mouse_btn
    CMP #0
    BEQ @topRowDone

	JSR tryRun_player
	JMP __MAIN

@topRowDone:
	JMP backToJoy

@midRow:
	Compare16bit mouse_y, (12 * 16)
	BCC @midRowDoneBranchAid
	Compare16bit mouse_y, (21 * 16)
	BCS @midRowDone

@midRowOne:
	Compare16bit mouse_x, (3 * 16)
	BCC @midRowDone

	Compare16bit mouse_x, (9 * 16)
	BCS @midRowTwo

	LDA #0
	JMP midRowHover

@midRowTwo:
	Compare16bit mouse_x, (10 * 16)
	BCC @midRowDone

	Compare16bit mouse_x, (16 * 16)
	BCS @midRowThree

	LDA #1
	JMP midRowHover

@midRowDoneBranchAid:
	BRA @midRowDone

@midRowThree:
	Compare16bit mouse_x, (17 * 16)
	BCC @midRowDone

	Compare16bit mouse_x, (23 * 16)
	BCS @midRowFour

	LDA #2
	JMP midRowHover

@midRowFour:
	Compare16bit mouse_x, (24 * 16)
	BCC @midRowDone

	Compare16bit mouse_x, (30 * 16)
	BCS @midRowDone

	LDA #3
	JMP midRowHover

@midRowDone:
	JMP backToJoy

midRowHover:
	CMP cursor_game
	BNE @midRowHoverNow

    LDA mouse_btn
    CMP #0
    BEQ @midRowDone

	JSR tryFlip_room
	JMP __MAIN

@midRowDone:
	JMP backToJoy

@midRowHoverNow:
	STA cursor_game
	LDA #1
	STA reqdraw_cursor
	STA reqdraw_name
	JSR Move_sound
	JMP __MAIN