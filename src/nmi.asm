
;; NMI

; we only care about VSYNC IRQs
ensureVera:
	lda Vera::ISR
	and Interrupts::VSYNC
	bne @done
	jmp sendView
@done:
	jmp (default_irq_vector)

;; route screens

sendView:
	LDX view_game
	CPX #$00
	BNE viewGame

viewSplash:
@splashScreen:
	LDA reqdraw_splash           ; splash-screen
	CMP #$01
	BNE @splashCursor
	JMP redrawScreen_splash
@splashCursor:
	LDA reqdraw_cursor           ; splash-cursor
	CMP #$01
	BNE @done
	JMP redrawCursor_splash
@done:
	jmp (default_irq_vector)

viewGame:
	JSR animateTimer_game
	JSR interpolateStats_game
@checkReqGame:
	LDA reqdraw_game
	CMP #$01
	BNE @checkReqSP
	JMP redrawScreen_game
@checkReqSP:
	LDA redraws_game
	AND REQ_SP
	BEQ @checkReqHP
	JMP redrawShield_game
@checkReqHP:
	LDA redraws_game
	AND REQ_HP
	BEQ @checkReqCursor
	JMP redrawHealth_game
@checkReqCursor:
	LDA reqdraw_cursor
	CMP #$01
	BNE @checkName
	JMP redrawCursor_game
@checkName:
	LDA reqdraw_name
	CMP #$01
	BNE @checkReqCard1
	JMP redrawName_game
@checkReqCard1:
	LDA redraws_game
	AND REQ_CARD1
	BEQ @checkReqCard2
	JMP redrawCard1_game
@checkReqCard2:
	LDA redraws_game
	AND REQ_CARD2
	BEQ @checkReqCard3
	JMP redrawCard2_game
@checkReqCard3:
	LDA redraws_game
	AND REQ_CARD3
	BEQ @checkReqCard4
	JMP redrawCard3_game
@checkReqCard4:
	LDA redraws_game
	AND REQ_CARD4
	BEQ @checkReqXP
	JMP redrawCard4_game
@checkReqXP:
	LDA redraws_game
	AND REQ_XP
	BEQ @checkReqRun
	JMP redrawExperience_game
@checkReqRun:
	LDA redraws_game
	AND REQ_RUN
	BEQ @checkReqDialog
	JMP redrawRun_game
@checkReqDialog:
	LDA reqdraw_dialog
	CMP #$01
	BNE @done
	JMP redraw_dialog
@done:
	jmp (default_irq_vector)
