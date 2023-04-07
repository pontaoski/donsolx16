TilesBaseVRAM = $00800
Map0VRAM = $00000

initGfx:
	RAM2VRAM Tiles, TilesBaseVRAM, TILES_SIZE
	; RAM2VRAM Palette, ???, PALETTE_SIZE

	; set up display scaling
	lda #48 ; 128/64 = 2x scaling
	sta Vera::DC::HScale
	sta Vera::DC::VScale

	; configure layer 0
		; general config

		lda #(LayerConfig::MapW32 | LayerConfig::MapH32 | LayerConfig::Tile | LayerConfig::Bpp2)
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
	sta Vera::DC::Border

	; enable display
	lda #(VideoConfig::Layer1)
	sta Vera::DC::Video

	; prod some things
	lda #$10
	sta Vera::AddrBank
	stz Vera::AddrHigh
	stz Vera::AddrLow

	stz Vera::Data0
	stz Vera::Data0

	lda #$1
	sta Vera::Data0
	stz Vera::Data0

	lda #$2
	sta Vera::Data0
	stz Vera::Data0

initLogic:
	JSR show_splash
	JSR start_renderer

initAudio:
	; JSR Enable_sound

