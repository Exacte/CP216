*-----------------------------------------------------------
* Title      :q4
* Written by :Mason Cooper
* Date       :28-01-2016
* Description:Infinitely takes input from swites and waits for push button input to displays it on the LED's
*-----------------------------------------------------------
LEDS        EQU     $E00010
SW          EQU     $E00012
PB          EQU     $E00014
    
START       ORG     $400
            MOVE.B  #$00,D0
            MOVE.B  D0,LEDS
            
LOOP        MOVE.B  SW,D1
            MOVE.B  D1,D0
DELAY       MOVE.B  PB,D2
            NOT.B   D2
            BLE     DELAY
            MOVE.B  D0,LEDS
            BCC     LOOP
    END     START



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
