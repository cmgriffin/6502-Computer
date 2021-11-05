; blink.6502.s
; rotates starting value continuously through LEDs connected 6522 PB0-7
; The effect will only be visually noticable with a very slow or single stepped clock

    .org $8000 ; program start location as seen by cpu

reset:
    lda #$ff ; 6522 DDRB to output mode
    sta $6002

    lda #$50 ; starting value to PORTB
    sta $6000 

loop:
    ror ; rotate right 
    sta $6000 ; new rotated value to PORTB

    jmp loop ; loop forever

    .org $fffc ; reset vector location
    .word reset
    .word $0000 ; extra byte to fill EEPROM