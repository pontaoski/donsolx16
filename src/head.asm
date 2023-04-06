;; constants

PPUCTRL             = $2000 
PPUMASK             = $2001 
PPUSTATUS           = $2002 ; Using BIT PPUSTATUS preserves the previous contents of A.
SPRADDR             = $2003 
PPUSCROLL           = $2005 
PPUADDR             = $2006 
PPUDATA             = $2007 
APUCH1VOL           = $4000 ; APU
APUCH1SWP           = $4001 
APUCH1FRQ           = $4002 
APUCH1LEN           = $4003 
APUCH2VOL           = $4004 
APUCH2SWP           = $4005 
APUCH2FRQ           = $4006 
APUCH2LEN           = $4007 
APUCH3CNT           = $4008 
APUCH3SWP           = $4009 
APUCH3FRQ           = $400a 
APUCH3LEN           = $400b 
APUCH4VOL           = $400c 
APUCH4SWP           = $400d 
APUCH4FRQ           = $400e 
APUCH4LEN           = $400f 
SPRDMA              = $4014 
APUCTRL             = $4015 
JOY1                = $4016 
JOY2                = $4017 
BUTTON_RIGHT        = $01 
BUTTON_LEFT         = $02 
BUTTON_DOWN         = $04 
BUTTON_UP           = $08 
BUTTON_START        = $10 
BUTTON_SELECT       = $20 
BUTTON_B            = $40 
BUTTON_A            = $80 

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

CARDBUF1            = $0300 
CARDBUF2            = $0340 
CARDBUF3            = $0380 
CARDBUF4            = $03c0 

;; variables

	.org $0000
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
down_input              : .res 1 
last_input              : .res 1 
next_input              : .res 1 
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
ptr_src                 : .res 1 
	.reloc
