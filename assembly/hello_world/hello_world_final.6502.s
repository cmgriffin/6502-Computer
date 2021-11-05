LCD_STR_BASE=$0

VIA_PORTB = $6000
VIA_PORTA = $6001
VIA_DDRB = $6002
VIA_DDRA = $6003

LCD_EN = $80
LCD_RW = $40
LCD_RS = $20
LCD_COLS = 16



    .org $8000              ; program start location as seen by cpu
reset:
    ldx #$ff                ; load the stack pointer
    txs
    jsr lcd_init

    lda #message & $ff      ; low address byte
    sta LCD_STR_BASE        ; store low byte first
    lda #message>>8         ; high address byte
    sta LCD_STR_BASE + 1    ; store hight byte
    jsr lcd_string          ; print the string

loop 
    jmp loop        ; loop forever

message: .text "  Hello World!  "
         .asciiz " 65c02 Computer "

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