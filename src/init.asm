
;; init

	SEI                          ; disable IRQs
	CLD                          ; disable decimal mode
	LDX #$40
	STX JOY2                     ; disable APU frame IRQ
	LDX #$FF
	TXS                          ; Set up stack
	INX                          ; now X = 0
	STX PPUCTRL                  ; disable NMI
	STX PPUMASK                  ; disable rendering
	STX $4010                    ; disable DMC IRQs
@vwait1:                       ; First wait for vblank to make sure PPU is ready
	BIT PPUSTATUS
	BPL @vwait1
@clear:                        ;
	LDA #$00
	STA $0000, x
	STA $0100, x
	STA $0300, x
	STA $0400, x
	STA $0500, x
	STA $0600, x
	STA $0700, x
	LDA #$FE
	STA $0200, x                 ; move all sprites off screen
	INX 
	BNE @clear
@vwait2:                       ; Second wait for vblank, PPU is ready after this
	BIT PPUSTATUS
	BPL @vwait2

;; Init

Clear_vram_loop:
	STA PPUDATA
	STA PPUDATA
	STA PPUDATA
	STA PPUDATA
	STA PPUDATA
	STA PPUDATA
	STA PPUDATA
	STA PPUDATA
	DEY 
	BNE Clear_vram_loop
	DEX 
	BNE Clear_vram_loop
	;load sprite base

	LDA #$00
	STA PPUADDR
	LDA #$00
	STA PPUADDR

Load_sprites:
	LDA #Sprites&255
	STA ptr_src
	LDA #Sprites/256
	STA ptr_src+1
	LDY #0                       ; starting index into the first page
	STY PPUMASK                  ; turn off rendering just in case
	STY PPUADDR                  ; load the destination address into the PPU
	STY PPUADDR
	LDX #32                      ; number of 256-byte pages to copy

Loop:
	LDA (ptr_src),y              ; copy one byte
	STA PPUDATA
	INY 
	BNE Loop                     ; repeat until we finish the page
	INC ptr_src+1                ; go to the next page
	DEX 
	BNE Loop                     ; repeat until we've copied enough pages

loadPalette:                   ; [skip]
	BIT PPUSTATUS
	LDA #$3F
	STA PPUADDR
	LDA #$00
	STA PPUADDR
	LDX #$00
@loop:                         ;
	LDA palettes, x
	STA PPUDATA
	INX 
	CPX #$20
	BNE @loop
	JSR show_splash
	JSR start_renderer

;; Run tests

	JSR Enable_sound
	; JSR run_tests
