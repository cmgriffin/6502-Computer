PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E = $80
RW = $40
RS = $20

    .org $8000 ; program start location as seen by cpu

reset:
    ; configure the 6522 pins direction 
    lda #$ff ; LCD module data pins to output
    sta DDRB
    lda #$e0 ; LCD module control pins to output 
    sta DDRA

    lda #$28 ; set 8-bit mode with 2 lines
    sta PORTB
    lda #0 ; clear RS/RW/E
    sta PORTA
    lda #E ; toggle the E signal
    sta PORTA
    lda #0 ; clear RS/RW/E
    sta PORTA

    lda #$0e ; Display on, cursor on
    sta PORTB
    lda #0 ; clear RS/RW/E
    sta PORTA
    lda #E ; toggle the E signal
    sta PORTA
    lda #0 ; clear RS/RW/E
    sta PORTA

    lda #$06 ; Increment and shift cursor each time
    sta PORTB
    lda #0 ; clear RS/RW/E
    sta PORTA
    lda #E ; toggle the E signal
    sta PORTA
    lda #0 ; clear RS/RW/E
    sta PORTA

    lda #"H"
    sta PORTB
    lda #RS ; set RS
    sta PORTA
    lda #(E | RS) ; toggle the E signal keeping RS set
    sta PORTA
    lda #RS ; clear E keeping RS set
    sta PORTA

loop:
    jmp loop ; loop forever

    .org $fffc ; reset vector location
    .word reset
    .word $0000 ; extra byte to fill EEPROM