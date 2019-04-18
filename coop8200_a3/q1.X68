*-----------------------------------------------------------
* Title      :q1
* Written by :Mason Cooper
* Date       :28-01-2016
* Description:Infinitely rotates a binary(01011001) number through LED's
*-----------------------------------------------------------
LEDS        EQU     $E00010

    
START       ORG    $400
            MOVE.B #$59,D0
            
LOOP        MOVE.B D0,LEDS
            MOVE.L #$FFFFF,D1
DELAY       SUBI.L #1,D1
            BNE    DELAY
            ROR.B  #1,D0
            MOVE.B D0,LEDS
            BNE    LOOP
    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
