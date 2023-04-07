Map0VRAM = $00000

.macro FOREVER
   .scope
      forever:
         jmp forever
   .endscope
.endmacro

.macro TARGET_SPRITE_AUTOINCR addr
   stz Vera::CTRL
   ldx #($10 | (addr>>16))
   stx Vera::AddrBank
   ldx #>addr
   stx Vera::AddrHigh
   ldx #<addr
   stx Vera::AddrLow
.endmacro

.macro STA_TILE tx, ty
   .scope
      Address = ty*32*2 + tx*2
      stz Vera::CTRL
      ldx #($10 | (Address>>16))
      stx Vera::AddrBank
      ldx #>Address
      stx Vera::AddrHigh
      ldx #<Address
      stx Vera::AddrLow
      sta Vera::Data0
      stz Vera::Data0
   .endscope
.endmacro

.macro ZERO_VRAM vram_addr, num_bytes
   .scope
      ; set data port 0 to start writing to VRAM address
      stz Vera::CTRL
      lda #($10 | (vram_addr>>16)) ; stride = 1
      sta Vera::AddrBank
      lda #>vram_addr
      sta Vera::AddrHigh
      lda #<vram_addr
      sta Vera::AddrLow

      ; use index pointers to compare with number of bytes to copy
      ldx #0
      ldy #0
   vram_loop:
      stz Vera::Data0
      iny
      cpx #>num_bytes ; last page yet?
      beq check_end
      cpy #0
      bne vram_loop ; not on last page, Y non-zero
      inx ; next page
      bra vram_loop
   check_end:
      cpy #<num_bytes ; last byte of last page?
      bne vram_loop ; last page, before last byte
   .endscope
.endmacro

.macro RAM2VRAM ram_addr, vram_addr, num_bytes
   .scope
      ; set data port 0 to start writing to VRAM address
      stz Vera::CTRL
      lda #($10 | (vram_addr>>16)) ; stride = 1
      sta Vera::AddrBank
      lda #>vram_addr
      sta Vera::AddrHigh
      lda #<vram_addr
      sta Vera::AddrLow
       ; ZP pointer = start of video data in CPU RAM
      lda #<ram_addr
      sta $30
      lda #>ram_addr
      sta $30+1
      ; use index pointers to compare with number of bytes to copy
      ldx #0
      ldy #0
   vram_loop:
      lda ($30),y
      sta Vera::Data0
      iny
      cpx #>num_bytes ; last page yet?
      beq check_end
      cpy #0
      bne vram_loop ; not on last page, Y non-zero
      inx ; next page
      inc $30+1
      bra vram_loop
   check_end:
      cpy #<num_bytes ; last byte of last page?
      bne vram_loop ; last page, before last byte
   .endscope
.endmacro

.macro RAM2VRAM_PAD ram_addr, vram_addr, num_bytes
   .scope
      ; set data port 0 to start writing to VRAM address
      stz Vera::CTRL
      lda #($10 | (vram_addr>>16)) ; stride = 1
      sta Vera::AddrBank
      lda #>vram_addr
      sta Vera::AddrHigh
      lda #<vram_addr
      sta Vera::AddrLow
       ; ZP pointer = start of video data in CPU RAM
      lda #<ram_addr
      sta $30
      lda #>ram_addr
      sta $30+1
      ; use index pointers to compare with number of bytes to copy
      ldx #0
      ldy #0
   vram_loop:
      lda ($30),y
      sta Vera::Data0
      stz Vera::Data0
      iny
      cpx #>num_bytes ; last page yet?
      beq check_end
      cpy #0
      bne vram_loop ; not on last page, Y non-zero
      inx ; next page
      inc $30+1
      bra vram_loop
   check_end:
      cpy #<num_bytes ; last byte of last page?
      bne vram_loop ; last page, before last byte
   .endscope
.endmacro
