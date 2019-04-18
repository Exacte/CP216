*-----------------------------------------------------------
* Title      :q5
* Written by :Mason Cooper
* Date       :296-01-2016
* Description:Car brake lights
*-----------------------------------------------------------
LEDS        EQU     $E00010
SW          EQU     $E00012
PB          EQU     $E00014
    
START       ORG     $400
            MOVE.B  #$00,D0
            MOVE.B  D0,LEDS
            
LOOP        MOVE.B  SW,D2
            MOVE.B  PB,D1
            MOVE.B  #$00,D0
            
            MOVE.B  PB,D1
            NOT.B   D1
            CMP.B   BON,D1
            BEQ     BRAKE
            
            MOVE.B  D0,LEDS
            
            CMP.B   LEFT,D2
            BEQ     LEFTT
            
            CMP.B   RIGHT,D2
            BEQ     RIGHTT
            
            BRA     LOOP
            
RIGHTT      ADD.B   #$4,D0
            MOVE.B  D0,LEDS
            JSR     DELAY
            NOP
            ADD.B   #$2,D0
            MOVE.B  D0,LEDS
            JSR     DELAY
            NOP
            ADD.B   #$1,D0
            MOVE.B  D0,LEDS
            JSR     DELAY
            NOP
            SUB.B   #$7,D0
            MOVE.B  D0,LEDS
            JSR     DELAY
            NOP
            BRA     LOOP


LEFTT       ADD.B   #$20,D0
            MOVE.B  D0,LEDS
            JSR     DELAY
            NOP
            ADD.B   #$40,D0
            MOVE.B  D0,LEDS
            JSR     DELAY
            NOP
            ADD.B   #$80,D0
            MOVE.B  D0,LEDS
            JSR     DELAY
            NOP
            SUB.B   #$E0,D0
            MOVE.B  D0,LEDS
            JSR     DELAY
            NOP
            BRA     LOOP   

BRAKE       CMP.B   LEFT,D2
            BEQ     BRAKEL
            
            CMP.B   RIGHT,D2
            BEQ     BRAKER
            
            MOVE.B  #$E7,LEDS
            BRA     LOOP    

BRAKEL      ADD.B   #$07,D0
            BRA     LEFTT

BRAKER      ADD.B   #$E0,D0
            BRA     RIGHTT
            
DELAY       MOVE.L  #$AAAA0,D3
DELAYING    SUBI.L  #1,D3
            BNE     DELAYING
            RTS

LEFT        DC.B    $2
RIGHT       DC.B    $1
BON         DC.B    $1

    END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
