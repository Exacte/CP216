*-----------------------------------------------------------
* Title      :Q3
* Written by :Mason Cooper
* Date       :2016-01-22
* Description:Divison by 2^x
*-----------------------------------------------------------

START       ORG     $400

            MOVE.B  num,D0
            MOVE.B  shift,D1
            ASR.B   D1,D0
            MOVE.B  D0,result
            STOP    #$1000
    
num         DC.B    $8
shift       DC.B    $2
result      DS.B    1
            END     START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
