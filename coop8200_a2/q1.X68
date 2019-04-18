*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

START       ORG     $400

            MOVE.B  num1,D0
            MOVE.B  num2,D1
            SUB.B   D1,D0
            MOVE.B  D0,num1
            STOP    #$1000
    
num1        DC.B    $FF
num2        DC.B    $CC
            END     START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
