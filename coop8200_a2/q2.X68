*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

START       ORG     $400

            MOVE.W  num1,D0
            MOVE.W  num2,D1
            ADD.W   D1,D0
            STOP    #$1000
    
num1        DC.W    $00FF
num2        DC.W    -255
            END     START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
