
;; Sound

Enable_sound:
	; LDA #%00000111               ; ch1 + ch2 + ch3
	; STA APUCTRL
	; LDA #$01
	; STA enabled_sound
	; JSR Potion_sound
	; LDA #$11                     ; dialog:sound-on
	; JSR show_dialog
	RTS 

Disable_sound:
	; turn off
	; LDA #%00000000               ; mute all
	; STA APUCTRL
	; LDA #$00
	; STA enabled_sound
	; LDA #$12                     ; dialog:sound-off
	; JSR show_dialog
	RTS 

Toggle_sound:
	; LDA enabled_sound
	; CMP #$01
	; BEQ Disable_sound
	; JSR Enable_sound
	RTS 

Move_sound:
	; LDA #%10011001
	; STA APUCH1VOL
	; LDA #%11110001
	; STA APUCH1SWP
	; LDA #$d3
	; STA APUCH1FRQ
	; LDA #%01111001
	; STA APUCH1LEN
	RTS 

MoveAlt_sound:
	; LDA #%10011001
	; STA APUCH1VOL
	; LDA #%11110001
	; STA APUCH1SWP
	; LDA #$e4
	; STA APUCH1FRQ
	; LDA #%01101001
	; STA APUCH1LEN
	RTS 

Enter_sound:
	; LDA #%11011101
	; STA APUCH1VOL
	; LDA #%10111011
	; STA APUCH1SWP
	; LDA #$e4
	; STA APUCH1FRQ
	; LDA #%01101001
	; STA APUCH1LEN
	RTS 

;; Items ch2

Shield_sound:                  ; $1ab = C3
	; LDA #%11011101
	; STA APUCH1VOL
	; LDA #%10111010
	; STA APUCH1SWP
	; LDA #$c4
	; STA APUCH1FRQ
	; LDA #%01101001
	; STA APUCH1LEN
	RTS 

ShieldError_sound:             ; $25c = G2#
	; LDA #%10011001
	; STA APUCH2VOL
	; LDA #%11010111
	; STA APUCH2SWP
	; LDA #$92
	; STA APUCH2FRQ
	; LDA #%01101011
	; STA APUCH2LEN
	RTS 

Potion_sound:                  ; $1ab = C3
	; LDA #%10011001
	; STA APUCH1VOL
	; LDA #%11110001
	; STA APUCH1SWP
	; LDA #$34
	; STA APUCH1FRQ
	; LDA #%01101001
	; STA APUCH1LEN
	RTS 

PotionError_sound:             ; $25c = G2#
	; LDA #%10011001
	; STA APUCH2VOL
	; LDA #%10110101
	; STA APUCH2SWP
	; LDA #$92
	; STA APUCH2FRQ
	; LDA #%01101001
	; STA APUCH2LEN
	RTS 

;; Enemy ch4

EnemyGood_sound:               ; $3f8 = A2
	; LDA #<$3f8
	; STA APUCH4LEN
	; LDA #>$3f8
	; STA APUCH4FRQ
	; LDA #%11000100
	; STA APUCH4VOL
	RTS 

EnemyMedium_sound:             ; $389 = B2
	; LDA #%11011101
	; STA APUCH1VOL
	; LDA #%01101011
	; STA APUCH1SWP
	; LDA #$f4
	; STA APUCH1FRQ
	; LDA #%00111101
	; STA APUCH1LEN
	RTS 

EnemyBad_sound:                ; $326 = D2#
	; LDA #%10011000
	; STA APUCH2VOL
	; LDA #%11010101
	; STA APUCH2SWP
	; LDA #$04
	; STA APUCH2FRQ
	; LDA #%01101001
	; STA APUCH2LEN
	RTS 

;; Escape ch3

Escape_sound:                  ; $356 = C2
	; LDA #<$356
	; STA APUCH3FRQ
	; LDA #>$356
	; STA APUCH3LEN
	; LDA #%00010000
	; STA APUCH3CNT
	RTS 

EscapeError_sound:             ; $2ce = E2#
	; LDA #<$2c3
	; STA APUCH3FRQ
	; LDA #>$2c3
	; STA APUCH3LEN
	; LDA #%00010000
	; STA APUCH3CNT
	RTS 

Death_sound:                   ; $4b8 = G1#
	; LDA #<$4b8
	; STA APUCH3FRQ
	; LDA #>$4b8
	; STA APUCH3LEN
	; LDA #%01111000
	; STA APUCH3CNT
	RTS 
