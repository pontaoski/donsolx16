
;; Tests

run_tests:                     ; [skip]
	LDA #$43
	STA count_tests
	JSR potion_tests
	JSR sickness_tests
	JSR shield_tests
	JSR attack_tests
	JSR death_tests
	JSR testAttackShieldBlock
	JSR testAttackShieldOverflow
	JSR testAttackShieldOverflowDeath
	JSR break_tests
	JSR testAttackShieldBreakDeath
	JSR reset_player
	RTS 

pass_tests:                    ;
	BIT PPUSTATUS                ; read PPU status to reset the high/low latch
	LDA #$20
	STA PPUADDR                  ; write the high byte
	LDA count_tests
	STA PPUADDR                  ; write the low byte
	LDA #$6A
	STA PPUDATA
	LDA #$00                     ; No background scrolling
	STA PPUSCROLL
	STA PPUSCROLL
	INC count_tests
	RTS 

fail_tests:                    ;
	LDX count_tests
	BIT PPUSTATUS                ; read PPU status to reset the high/low latch
	LDA #$20
	STA PPUADDR                  ; write the high byte
	LDA count_tests
	STA PPUADDR                  ; write the low byte
	LDA #$6B
	STA PPUDATA
	LDA #$00                     ; No background scrolling
	STA PPUSCROLL
	STA PPUSCROLL
	INC count_tests
	RTS 

;; Drink 3hp | Shield is 0sp | Health is 21hp

potion_tests:                  ;
	JSR reset_player
	; take some dammage
	LDA #$10
	STA hp_player
	; pick
	LDY #$02                     ; Hearts 3
	JSR pickCard_deck
	; test health
	LDA hp_player
	CMP #$13                     ; health = $13(18)
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Drink 5hp | Drink 6hp | Shield is 0sp | Health is 9hp

sickness_tests:                ;
	JSR reset_player
	; take some dammage
	LDA #$04
	STA hp_player
	; drink two potions
	LDY #$04                     ; Hearts 5
	JSR pickCard_deck
	LDY #$05                     ; Hearts 6
	JSR pickCard_deck
	; test health
	LDA hp_player
	CMP #$09                     ; health = $09(09)[4hp + 5hp]
	BNE @fail
	; test sickness
	LDA sickness_player
	CMP #$01                     ; sickness = true
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Equip 2sp | Shield is 2sp | Health is 21hp

shield_tests:                  ;
	JSR reset_player
	; pick
	LDY #$0E                     ; Diamonds 2
	JSR pickCard_deck
	; test health
	LDA sp_player
	CMP #$02                     ; shield = $02(02)
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Attack 6ap | Loose 6hp | Shield is 0sp | Health is 15hp

attack_tests:                  ;
	JSR reset_player
	; pick
	LDY #$1F                     ; Spades 6
	JSR pickCard_deck
	; test health
	LDA hp_player
	CMP #$0F                     ; shield = $0f(15)
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Attack 6ap | Loose 6hp | Shield is 0sp | Health is 0hp

death_tests:                   ;
	JSR reset_player
	; Lower health
	LDA #$04
	STA hp_player
	; pick
	LDY #$1F                     ; Spades 6
	JSR pickCard_deck
	; test health
	LDA hp_player
	CMP #$00                     ; health = $00(00)
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Equip 6sp | Attack 4ap | Loose 0hp | Shield is 6dp | Health is 18hp

testAttackShieldBlock:         ;
	JSR reset_player
	; pick
	LDY #$12                     ; Diamond 6
	JSR pickCard_deck
	LDY #$1D                     ; Spades 4
	JSR pickCard_deck
	; loose 3hp
	LDA hp_player
	CMP #$15
	BNE @fail
	; shield durability 6
	LDA dp_player
	CMP #$04
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Equip 3sp | Attack 6ap | Loose 3hp | Shield is 6dp | Health is 18hp

testAttackShieldOverflow:      ;
	JSR reset_player
	; pick
	LDY #$0F                     ; Diamond 3
	JSR pickCard_deck
	LDY #$1F                     ; Spades 6
	JSR pickCard_deck
	; loose 3hp
	LDA hp_player
	CMP #$12
	BNE @fail
	; shield durability 6
	LDA dp_player
	CMP #$06
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Equip 3sp | Attack 6ap | Loose 3hp | Shield is 6dp | Health is 18hp

testAttackShieldOverflowDeath: ;
	JSR reset_player
	; Lower health
	LDA #$02
	STA hp_player
	; pick
	LDY #$0F                     ; Diamond 3
	JSR pickCard_deck
	LDY #$1F                     ; Spades 6
	JSR pickCard_deck
	; loose 3hp
	LDA hp_player
	CMP #$00
	BNE @fail
	; shield durability 6
	LDA dp_player
	CMP #$06
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Equip 4sp | Attack 3ap | Loose 0hp | Attack 4ap | Shield breaks | Loose 4hp | Shield is 0dp | Health is 17hp

break_tests:                   ;
	JSR reset_player
	; pick
	LDY #$10                     ; Diamond 4
	JSR pickCard_deck
	LDY #$1C                     ; Spades 3
	JSR pickCard_deck
	LDY #$1D                     ; Spades 4
	JSR pickCard_deck
	; loose 4hp
	LDA hp_player
	CMP #$11
	BNE @fail
	; shield durability 0
	LDA dp_player
	CMP #$00
	BNE @fail
	; shield 0
	LDA sp_player
	CMP #$00
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 

;; Equip 4sp | Attack 3ap | Loose 0hp | Attack 4ap | Shield breaks | Loose 4hp | Shield is 0dp | Health is 17hp

testAttackShieldBreakDeath:    ;
	JSR reset_player
	; Lower health
	LDA #$02
	STA hp_player
	; pick
	LDY #$10                     ; Diamond 4
	JSR pickCard_deck
	LDY #$1C                     ; Spades 3
	JSR pickCard_deck
	LDY #$1D                     ; Spades 4
	JSR pickCard_deck
	; loose 4hp
	LDA hp_player
	CMP #$00
	BNE @fail
	; shield durability 0
	LDA dp_player
	CMP #$00
	BNE @fail
	; shield 0
	LDA sp_player
	CMP #$00
	BNE @fail
	; pass
	JSR pass_tests
	RTS 
@fail:                         ;
	JSR fail_tests
	RTS 
