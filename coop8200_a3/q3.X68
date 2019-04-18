*-----------------------------------------------------------
* Title      :q3
* Written by :Mason Cooper
* Date       :28-01-2016
* Description:Infinitely takes input from push buttons and displays it on the LED's
*-----------------------------------------------------------
LEDS        EQU     $E00010
PB          EQU     $E00014
    
START       ORG     $400
            MOVE.B  #$00,D0
            
LOOP        MOVE.B  PB,D1
            NOT.B   D1
            MOVE.B  D1,D0
            MOVE.B  D0,LEDS
            BCC     LOOP
    END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
