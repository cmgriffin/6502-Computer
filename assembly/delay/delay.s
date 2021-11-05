LCD_STR_BASE=$0 ; 2 bytes (pointer)
DELAY_BASE=$2 ; 2 bytes (pointer)
DELAY_LONG=$10 ; 4 bytes
NUMBER=$14 ; 1 byte

VIA_PORTB = $6000
VIA_PORTA = $6001
VIA_DDRB = $6002
VIA_DDRA = $6003

LCD_EN = $80
LCD_RW = $40
LCD_RS = $20
LCD_COLS = 16
MON_PIN = $1



    .org $8000              ; program start location as seen by cpu
reset:
    ldx #$ff                ; load the stack pointer
    txs
    jsr lcd_init

    lda #MON_PIN
    tsb VIA_DDRA 


 loop:

    lda #delay_val1 & $ff      ; low address byte
    sta DELAY_BASE        ; store low byte first
    lda #delay_val1>>8         ; high address byte
    sta DELAY_BASE + 1    ; store hight byte
    jsr test_delay

    lda #delay_val2 & $ff      ; low address byte
    sta DELAY_BASE        ; store low byte first
    lda #delay_val2>>8         ; high address byte
    sta DELAY_BASE + 1    ; store hight byte
    jsr test_delay


    jmp loop        ; loop forever


text: .asciiz "n = "
n1=2000
delay_val1: .byte n1&$ff, (n1>>8)&$ff, (n1>>16)&$ff, (n1>>24)&$ff
n2=1000
delay_val2: .byte n2&$ff, (n2>>8)&$ff, (n2>>16)&$ff, (n2>>24)&$ff

test_delay:
    pha
    lda #MON_PIN
    tsb VIA_PORTA
    jsr delay
    lda #MON_PIN
    trb VIA_PORTA
    pla
    rts

; cycles =  n* 22 + 52
delay:                  ; jsr absolute (6 cycles)
    pha                 ; stack (3 cycles)
    phy                 ; stack (3 cycles)
    ldy #$1             ; immediate (2 cycles)
    ; 14 cycles
delay0: ; load the variable with the delay value
    lda (DELAY_BASE),Y    ; get val from base + Y (5 cycles)
    sta DELAY_LONG,Y    ; zp indexed y (4 cycles)
    dey                 ; implied (2 cycles)

    bne delay0          ;  pc relative (3,2 cycles)
    ; 27 cycles
delay1:
    sec                 ; implied (2 cycles)
    lda DELAY_LONG      ; zp (3 cycles)
    sbc #$01            ; immediate (2)
    sta DELAY_LONG      ; zp (3 cycles)   
    lda DELAY_LONG+1 
    sbc #$00
    sta DELAY_LONG+1

    ora DELAY_LONG+1    ; zp (3 cycles)
    bne delay1          ; pc rel (3) -1
    ply                 ; stack (3 cycles)
    pla                 ; stack (3 cycles)
    rts                 ; jsr absolute (7 cycles)
    ; n * 22 + 11

; ; cycles =  n* 46 + 90
; delay:                  ; jsr absolute (7 cycles)
;     pha                 ; stack (3 cycles)
;     tya                 ; implied (2 cycles)
;     pha                 ; stack (3 cycles)
;     ldy #$3             ; immediate (2 cycles)
;     ; 17 cycles
; delay0: ; load the variable with the delay value
;     lda (DELAY_BASE),Y    ; get val from base + Y (5 cycles)
;     sta DELAY_LONG,Y    ; abs indexed x (5 cycles)
;     dey                 ; implied (2 cycles)

;     bne delay0          ;  pc relative (3,3,3,2 cycles)
;     ; 55 cycles
; delay1:
;     sec                 ; implied (2 cycles)
;     lda DELAY_LONG      ; zp (3 cycles)
;     sbc #$01            ; immediate (2)
;     sta DELAY_LONG      ; zp (3 cycles)   
;     lda DELAY_LONG+1 
;     sbc #$00
;     sta DELAY_LONG+1
;     lda DELAY_LONG+2
;     sbc #$00
;     sta DELAY_LONG+2
;     lda DELAY_LONG+3
;     sbc #$00
;     sta DELAY_LONG+3
    
;     ora DELAY_LONG+1    ; zp (3 cycles)
;     ora DELAY_LONG+2    ; zp (3 cycles)
;     ora DELAY_LONG+3    ; zp (3 cycles)
;     bne delay1          ; pc rel (3) -1
;     pla                 ; stack (3 cycles)
;     tay                 ; implied (2 cycles)
;     pla                 ; stack (3 cycles)
;     rts                 ; jsr absolute (7 cycles)
;     ; n * 46 + 14


lcd_init:
    pha
    ; configure the VIA ports2
    lda #(LCD_EN | LCD_RS | LCD_RW)
    trb VIA_PORTA 
    
    lda #(LCD_EN | LCD_RS | LCD_RW)
    tsb VIA_DDRA ; E, RW, RS to out put mode 

    lda #$ff
    sta VIA_DDRB ; data pins to output mode

    ; LCD initialization sequence
    lda #$38        ; Set 8-bit mode; 2-line display; 5x8 font
    jsr lcd_write_instr
    lda #$0c        ; Display on; cursor off; blink off
    jsr lcd_write_instr
    lda #$06        ; Increment and shift cursor; don't shift display
    jsr lcd_write_instr
    lda #$01        ; clear the display
    jsr lcd_write_instr
    
    pla
    rts

; LCD Clearing routine
lcd_clear:
    pha
    lda #$01        ; clear the display
    jsr lcd_write_instr
    pla
    rts

; Print 2 digit hex number to display
; registers preserved except y
lcd_print_hex:
    pha
    lsr A ; shift high nibble into low nibble
    lsr A
    lsr A
    lsr A
    tay
    lda HEX_ASCII_TABLE, Y
    jsr lcd_print
    pla
    pha
    and #$0f
    tay
    lda HEX_ASCII_TABLE, Y
    jsr lcd_print
    pla
    rts

; Lookup table for HEX to ASCII
HEX_ASCII_TABLE	.text "0123456789ABCDEF"

; Print a string in memory to the LCD
; preserves registers
; memory location LCD_STR_BASE points to beginning of string to print
lcd_string:
    pha
    tya
    pha

    ldy #$00
lcd_string0:
    lda (LCD_STR_BASE),Y    ; get char from base + Y
    BEQ lcd_string1         ; if char == null then string is finished printing
    jsr lcd_print           ; print the char
    iny                     ; advance to the next char
    bne lcd_string0         ; continue looping if Y hasn't rolled over

lcd_string1:
    pla
    tya
    pla
    rts

; prints a char to the LCD that is stored in A
; moves to new line if \n is detected
lcd_print:
    pha
    cmp #$0A
    beq to_line2        ; if a == \n: move to row 2

    jsr lcd_wait ; wait for the lcd to be ready for a command
    sta VIA_PORTB ; put the data out on the bus
    lda #LCD_RS
    tsb VIA_PORTA ; set RS (data register)
    lda #LCD_EN
    tsb VIA_PORTA ; set EN
    trb VIA_PORTA ; clear EN

    jsr lcd_read_instr  ; get address data
    and #$7f            ; mask out the busy flag
    cmp #LCD_COLS       ; see what line we are on
    bne print_done        ; if col == LCD_COLS: move to row 2

to_line2:
    lda #$C0    
    jsr lcd_write_instr

print_done:
    pla
    rts


; reads instruction register contents into A
lcd_read_instr:
    stz VIA_DDRB ; DDRB to input mode
    lda #LCD_RW ; RW high (reading)
    tsb VIA_PORTA 
    lda #LCD_RS ; RS low (instruction register)
    trb VIA_PORTA
    lda #LCD_EN
    trb VIA_PORTA ; clear enable
    lda #LCD_EN
    tsb VIA_PORTA ; set enable
    lda VIA_PORTB ; fetch the data
    pha
    lda #LCD_EN
    trb VIA_PORTA ; set enable
    pla
    rts

; write the instr in a to lcd
lcd_write_instr:
    jsr lcd_wait ; wait for the lcd to be ready for a command
    sta VIA_PORTB ; put the data out on the bus
    lda #LCD_RS
    trb VIA_PORTA  ; clear RS (instruction register)
    lda #LCD_EN
    tsb VIA_PORTA ; set EN
    trb VIA_PORTA ; clear EN
    rts

lcd_wait:
    pha
    stz VIA_DDRB ; DDRB to input mode
    lda #LCD_RW ; RW high (reading)
    tsb VIA_PORTA 
    lda #LCD_RS ; RS low (instruction register)
    trb VIA_PORTA
lcd_wait_loop
    lda #LCD_EN
    trb VIA_PORTA ; clear enable
    lda #LCD_EN
    tsb VIA_PORTA ; set enable
    lda VIA_PORTB
    and #$80        ; test if the busy flag is set
    bne lcd_wait_loop
    
    ; clean up 
    lda #(LCD_RW | LCD_EN)
    trb VIA_PORTA
    
    lda #$ff
    sta VIA_DDRB ; DDRB back to output mode
    pla             ; pull previous a value 
    rts

    .org $fffc      ; reset vector location
    .word reset
    .word $0000     ; extra byte to fill EEPROM