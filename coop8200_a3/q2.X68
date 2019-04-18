*-----------------------------------------------------------
* Title      :q2
* Written by :Mason Cooper
* Date       :28-01-2016
* Description:Infinitely takes input from swites and displays it on the LED's
*-----------------------------------------------------------
LEDS        EQU     $E00010
SW          EQU     $E00012
    
START       ORG     $400
            MOVE.B  #$FF,D0
            
LOOP        MOVE.B  SW,D1
            MOVE.B  D1,D0
            MOVE.B  D0,LEDS
            BCC     LOOP
    END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
