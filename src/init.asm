; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

TilesBaseVRAM = $00800
PaletteBaseVRAM = $1FA00
IRQVector = $0314

SpritesVRAM = $1FC00
MouseSprite = SpritesVRAM
SplashCursorSprite = MouseSprite + 8
GameCursorSprite = SplashCursorSprite + 8

initGfx:
	; zero out vram
	ZERO_VRAM Map0VRAM, 1790
	ZERO_VRAM SpritesVRAM, 2048

	RAM2VRAM Tiles, (TilesBaseVRAM-2), TILES_SIZE
	RAM2VRAM Palette, (PaletteBaseVRAM-2), PALETTE_SIZE

	; set up display scaling
	lda #64 ; 128/64 = 2x scaling
	sta Vera::DC0::HScale
	sta Vera::DC0::VScale

	; dcsel = 1
	lda #(1 << 1)
	sta Vera::CTRL

	; mask out the right edge of the screen
	lda #($D)
	sta Vera::DC1::HStart

	lda #($8A)
	sta Vera::DC1::HStop

	; dcsel = 0
	lda #(0 << 1)
	sta Vera::CTRL

	JSR initSplashSprites

	; configure layer 0
		; general config

		lda #(LayerConfig::MapW32 | LayerConfig::MapH32 | LayerConfig::Tile | LayerConfig::Bpp4)
		sta Vera::L0::Config

		; configure map
		lda #(Map0VRAM>>9)
		sta Vera::L0::MapBase

		; configure tiles
		lda #(TilesBaseVRAM>>9 | TileConfig::W8 | TileConfig::H8)
		sta Vera::L0::TileBase

		; reset scrolling
		stz Vera::L0::HScroll_Low
		stz Vera::L0::HScroll_High

		stz Vera::L0::VScroll_Low
		stz Vera::L0::VScroll_High

	; set background to black
	lda #0
	sta Vera::DC0::Border ; $9F2C

	; enable display
	lda Vera::DC0::Video
	and #%1111
	ora #(VideoConfig::Sprites | VideoConfig::Layer0)
	sta Vera::DC0::Video

	; hook into vera irq
		sei

		; back up kernal handler
   		lda IRQVector
   		sta default_irq_vector
   		lda IRQVector+1
   		sta default_irq_vector+1

		; overwrite RAM vectors
		lda #<__NMI
		sta IRQVector
		lda #>__NMI
		sta IRQVector+1

		; tell vera we want vsync interrupts only
		lda #(Interrupts::VSYNC)
		sta Vera::IEN

		cli

initMouse:
	LDA #$FF
	LDX #32
	LDY #30
	JSR mouse_config

initLogic:
	JSR show_splash
	JSR start_renderer

initAudio:
	; JSR Enable_sound

initDone:
	JMP __MAIN

initSplashSprites:
; configure splash cursor sprite
	TARGET_SPRITE_AUTOINCR SplashCursorSprite
	lda #( ($02A40 >> 5) & $FF )
	sta Vera::Data0 ; set address of gfx
	lda #( ($02A40 >> 13) & $F )
	sta Vera::Data0
	stz Vera::Data0 ; zero out X
	stz Vera::Data0
	stz Vera::Data0 ; zero out Y
	stz Vera::Data0
	lda #(SpriteConfig::ZDepth2)
	sta Vera::Data0
	lda #(SpriteConfig::Width8 | SpriteConfig::Height8)
	sta Vera::Data0

; configure game cursor sprite
	TARGET_SPRITE_AUTOINCR GameCursorSprite
	lda #( ($02A60 >> 5) & $FF )
	sta Vera::Data0 ; set address of gfx
	lda #( ($02A60 >> 13) & $F )
	sta Vera::Data0
	stz Vera::Data0 ; zero out X
	stz Vera::Data0
	stz Vera::Data0 ; zero out Y
	stz Vera::Data0
	lda #(SpriteConfig::ZDepth0)
	sta Vera::Data0
	lda #(SpriteConfig::Width8 | SpriteConfig::Height8)
	sta Vera::Data0

; configure mouse sprite
	TARGET_SPRITE_AUTOINCR MouseSprite
	lda #( ($02840 >> 5) & $FF )
	sta Vera::Data0 ; set address of gfx
	lda #( ($02840 >> 13) & $F )
	sta Vera::Data0
	stz Vera::Data0 ; zero out X
	stz Vera::Data0
	stz Vera::Data0 ; zero out Y
	stz Vera::Data0
	lda #(SpriteConfig::ZDepth2)
	sta Vera::Data0
	lda #(SpriteConfig::Width8 | SpriteConfig::Height8)
	sta Vera::Data0

	rts

