*-----------------------------------------------------------
* Title      :q6
* Written by :Mason Cooper
* Date       :28-01-2016
* Description:
*-----------------------------------------------------------
SEG         EQU     $E00000
LEDS        EQU     $E00010
SW          EQU     $E00012
PB          EQU     $E00014
    
START       ORG     $400
            MOVE.B  #$00,LEDS
            MOVE.B  #$6D,SEG
            
LOOP        MOVE.B  SW,D1
            MOVE.B  D1,D0
DELAY       MOVE.B  PB,D2
            NOT.B   D2
            CMP.B   PRES,D2
            BNE     DELAY
            MOVE.B  #$00,SEG
            MOVE.B  D0,LEDS
            MOVE.B  #$39,SEG
DELAY2      MOVE.B  PB,D2
            NOT.B   D2
            CMP.B   PRES,D2
            BNE     DELAY2
            CMP.B   D0,D2
            BEQ     EQUAL
            CMP.B   D0,D2
            BLT     HIGH
            CMP.B   D0,D2
            BGT     LOW
CONT
            BCC     LOOP
            
EQUAL       MOVE.B  #$79,SEG
            BRA     CONT        
            
HIGH        MOVE.B  #$76,SEG
            BRA     CONT
            
LOW         MOVE.B  #$38,SEG
            BRA     CONT
            
PRES        DC.B    $1
HOLD        DS.B    1

    END     START




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
