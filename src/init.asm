TilesBaseVRAM = $00800
PaletteBaseVRAM = $1FA00
IRQVector = $0314

initGfx:
	; reset vera
	lda #$80
	sta Vera::CTRL ; $9F25

	; zero out vram
	ZERO_VRAM Map0VRAM, 2048

	RAM2VRAM Tiles, (TilesBaseVRAM-2), TILES_SIZE
	RAM2VRAM Palette, (PaletteBaseVRAM-2), PALETTE_SIZE

	; set up display scaling
	lda #64 ; 128/64 = 2x scaling
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
	sta Vera::DC::Border ; $9F2C

	; enable display
	lda #(VideoConfig::Layer1 | VideoConfig::OutputVGA)
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

