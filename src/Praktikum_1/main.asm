;
; Lauflichter.asm
;
; Created: 24.10.2018 10:46
; Author : ss5200s und mw9884s
;

.include "m8def.inc"    ; Prozessordefinitionen laden
.org 0x000        ; Reset Vector
    rjmp start

start:
    ldi r16, LOW( RAMEND )
    out SPL, r16
    ldi r16, HIGH( RAMEND )
    out SPH, r16

    ;PC0 PC1 PC2 als Output
    ldi r16,0b00000111
    out DDRC, r16

    ldi r17,0b00000001        ;r17 laden
    ldi r21,0b00000100
    ldi r22,0b00000001    

main:
    out PORTC, r17
    rcall delay
    rjmp runleft    

runleft:
    lsl r17
    out PORTC, r17
    rcall delay    
    cp r17,r21
    breq runright
    rjmp runleft

runright:
    lsr r17
    out PORTC, r17
    rcall delay
    cp r17,r22
    breq runleft
    rjmp runright

; Delay of 200ms for 3.6MHz Atmega8
delay:
    ldi  r18, 4
    ldi  r19, 168
    ldi  r20, 12
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    ret

 
