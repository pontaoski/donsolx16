; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

;; constants

.enum ButtonsA
	Right  = 1 << 0
	Left   = 1 << 1
	Down   = 1 << 2
	Up     = 1 << 3
	Start  = 1 << 4
	Select = 1 << 5
	ButY   = 1 << 6
	ButB   = 1 << 7
.endenum

.scope Vera
	AddrLow        = $9F20
	AddrHigh       = $9F21
	AddrBank       = $9F22
	Data0          = $9F23
	CTRL           = $9F25
	IEN            = $9F26
	ISR            = $9F27

	.scope DC
		Video       = $9F29
		HScale      = $9F2A
		VScale      = $9F2B
		Border      = $9F2C
		HStart      = $9F29
		HStop       = $9F2A
		VStart      = $9F2B
		VStop       = $9F2C
	.endscope

	.scope L0
		Config         = $9F2D
		MapBase        = $9F2E
		TileBase       = $9F2F
		HScroll_Low    = $9F30
		HScroll_High   = $9F31
		VScroll_Low    = $9F32
		VScroll_High   = $9F33
	.endscope

	.scope L1
		Config         = $9F34
		MapBase        = $9F35
		TileBase       = $9F36
		HScroll_Low    = $9F37
		HScroll_High   = $9F38
		VScroll_Low    = $9F39
		VScroll_High   = $9F3A
	.endscope
.endscope

.enum LayerConfig
	Bpp1 = $0
	Bpp2 = $1
	Bpp4 = $2
	Bpp8 = $3

	Tile = $0
	Bitmap = $4

	T256COff = $0
	T256COn  = $8

	MapW32  = $0
	MapW64  = $10
	MapW128 = $20
	MapW256 = $30

	MapH32  = $0
	MapH64  = $40
	MapH128 = $80
	MapH256 = $C0
.endenum

.enum TileConfig
	W8  = $0
	W16 = $1
	H8  = $0
	H16 = $2
.endenum

.enum VideoConfig
	Layer0 = 1<<4
	Layer1 = 1<<5
	Sprites = 1<<6
	CurrentField = 1<<7

	OutputOff = $0
	OutputVGA = $1
	OutputNTSC = $2
	OutputRGB = $3
.endenum

.enum SpriteConfig
	; offset 1
	Bpp4 = 0
	Bpp8 = 1<<7

	; offset 6
	HFlip = 1<<0
	VFlip = 1<<1

	ZDepth0 = 0
	ZDepth1 = 1<<2 ; between bg and layer 0
	ZDepth2 = 2<<2 ; between layer 0 and layer 1
	ZDepth3 = 3<<2 ; in front of layer 1

	; offset 7
	Width8  = 0
	Width16 = 1<<4
	Width32 = 2<<4
	Width64 = 3<<4
	Height8  = 0
	Height16 = 1<<6
	Height32 = 2<<6
	Height64 = 3<<6
.endenum

.enum Interrupts
	VSYNC = $1
.endenum

joystick_scan = $FF53
joystick_get = $FF56

; PPUCTRL             = $2000 
; PPUMASK             = $2001 
; PPUSTATUS           = $2002 ; Using BIT PPUSTATUS preserves the previous contents of A.
; SPRADDR             = $2003 
; PPUSCROLL           = $2005 
; PPUADDR             = $2006 
; PPUDATA             = $2007 
; APUCH1VOL           = $4000 ; APU
; APUCH1SWP           = $4001 
; APUCH1FRQ           = $4002 
; APUCH1LEN           = $4003 
; APUCH2VOL           = $4004 
; APUCH2SWP           = $4005 
; APUCH2FRQ           = $4006 
; APUCH2LEN           = $4007 
; APUCH3CNT           = $4008 
; APUCH3SWP           = $4009 
; APUCH3FRQ           = $400a 
; APUCH3LEN           = $400b 
; APUCH4VOL           = $400c 
; APUCH4SWP           = $400d 
; APUCH4FRQ           = $400e 
; APUCH4LEN           = $400f 
SPRDMA              = $4014 
APUCTRL             = $4015 
JOY1                = $4016 
JOY2                = $4017 

;; redraw flags

REQ_HP              = %00000001 
REQ_SP              = %00000010 
REQ_XP              = %00000100 
REQ_RUN             = %00001000 
REQ_CARD1           = %00010000 
REQ_CARD2           = %00100000 
REQ_CARD3           = %01000000 
REQ_CARD4           = %10000000 

;; sprite buffers

.org $0400
	CARDBUF1: .res $40
	CARDBUF2: .res $40
	CARDBUF3: .res $40
	CARDBUF4: .res $40
.reloc

;; variables

	.org $0022
hp_player               : .res 1 ; health points
sp_player               : .res 1 ; shield points
dp_player               : .res 1 ; durability points(max $16)
xp_player               : .res 1 
difficulty_player       : .res 1 
sickness_player         : .res 1 
has_run_player          : .res 1 
length_deck             : .res 1 ; deck
hand_deck               : .res 1 
seed1_deck              : .res 1 ; The seed for the random shuffle(nmi)
seed2_deck              : .res 1 ; The seed for the random shuffle(main)
count_tests             : .res 1 ; tests
card1_room              : .res 1 
card2_room              : .res 1 
card3_room              : .res 1 
card4_room              : .res 1 
timer_room              : .res 1 
auto_room               : .res 1 
id_dialog               : .res 1 ; dialog
cursor_game             : .res 1 
view_game               : .res 1 ; display which mode
hpui_game               : .res 1 
spui_game               : .res 1 
redraws_game            : .res 1 
cursor_splash           : .res 1 
highscore_splash        : .res 1 ; keep highscore
difficulty_splash       : .res 1 ; keep difficulty in highscore
lb_temp                 : .res 1 ; utils
hb_temp                 : .res 1 
id_temp                 : .res 1 
swap_temp				: .res 1
damages_player          : .res 1 ; TODO: check if necessary?
enabled_sound           : .res 1 

;; TODO | cleanup

card_last               : .res 1 
card_last_type          : .res 1 
card_last_value         : .res 1 

;; TODO | merge remaining flags

reqdraw_game            : .res 1 
reqdraw_splash          : .res 1 
reqdraw_cursor          : .res 1 
reqdraw_dialog          : .res 1 
reqdraw_name            : .res 1 
default_irq_vector      : .res 2
previous_input          : .res 1
ptr_src                 : .res 1 
	.reloc

	.org $A9
	CardDeck:
	.reloc
