; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

;; client


;; renderer

start_renderer:                ;
	; LDA #%10010000               ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	; STA PPUCTRL
	; LDA #%00011000               ; enable sprites, enable background, no clipping on left side
	; STA PPUMASK
	; LDA #$00                     ; No background scrolling
	; STA PPUADDR
	; STA PPUADDR
	; STA PPUSCROLL
	; STA PPUSCROLL
	RTS 

stop_renderer:                 ;
	; LDA #%10000000               ; disable NMI, sprites from Pattern Table 0
	; STA PPUCTRL
	; LDA #%00000000               ; disable sprites
	; STA PPUMASK
	RTS 

fix_renderer:                  ;
	; BIT PPUSTATUS
	; LDA #$00                     ; No background scrolling
	; STA PPUADDR
	; STA PPUADDR
	; STA PPUSCROLL
	; STA PPUSCROLL
	RTS 

sprites_renderer:              ; TODO: figure out why this is needed..
	; LDA #$00
	; STA SPRADDR                  ; set the low byte (00) of the RAM address
	; LDA #$02
	; STA SPRDMA                   ; set the high byte (02) of the RAM address, start the transfer
	RTS 

;; dialog

show_dialog:                   ; (a:id_dialog)
	STA id_dialog
	LDA #$01                     ; request update
	STA reqdraw_dialog
	RTS 

redraw_dialog:                 ;
	; remove flag
	LDA #$00
	STA reqdraw_dialog

	PREPARE_TILE 3,24
	LDX #0
@loop:                         ;
	LDY id_dialog
	LDA dialogs_offset_low,y
	STA lb_temp
	LDA dialogs_offset_high,y
	STA hb_temp
	TYA 
	STX id_temp
	CLC 
	ADC id_temp
	TAY 
	LDA (lb_temp), y             ; load value at 16-bit address from (lb_temp + hb_temp) + y
	STA Vera::Data0
	STZ Vera::Data0
	INX 
	CPX #$18
	BNE @loop
	JSR fix_renderer
	jmp (default_irq_vector) 
