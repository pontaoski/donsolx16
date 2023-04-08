; SPDX-FileCopyrightText: 2017 Hundredrabbits
; SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
;
; SPDX-License-Identifier: MIT

TilesBaseVRAM = $00800
PaletteBaseVRAM = $1FA00
IRQVector = $0314

SpritesVRAM = $1FC00
SplashCursorSprite = SpritesVRAM
GameCursorSprite = SplashCursorSprite + 8

initGfx:
	; reset vera
	lda #$80
	sta Vera::CTRL ; $9F25

	; zero out vram
	ZERO_VRAM Map0VRAM, 1790
	ZERO_VRAM SpritesVRAM, 2048

	RAM2VRAM Tiles, (TilesBaseVRAM-2), TILES_SIZE
	RAM2VRAM Palette, (PaletteBaseVRAM-2), PALETTE_SIZE

	; set up display scaling
	lda #64 ; 128/64 = 2x scaling
	sta Vera::DC::HScale
	sta Vera::DC::VScale

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
	sta Vera::DC::Border ; $9F2C

	; enable display
	lda #(VideoConfig::Sprites | VideoConfig::Layer0 | VideoConfig::OutputVGA)
	sta Vera::DC::Video

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

initLogic:
	JSR show_splash
	JSR start_renderer

initAudio:
	; JSR Enable_sound

