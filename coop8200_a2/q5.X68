*-----------------------------------------------------------
* Title      :Q5
* Written by :Mason Cooper
* Date       :2016-01-22
* Description:Converts luarier ID from upper case to lower case
*-----------------------------------------------------------

START       ORG     $400

            LEA     ID,A0
            LEA     S1,A1
            MOVE.B  TL,D0
            MOVE.B  HOLD,D1
            MOVE.B  (A0)+,D1
            ADD.B   D0,D1
            MOVE.B  D1,(A1)+
            MOVE.B  (A0)+,D1
            ADD.B   D0,D1
            MOVE.B  D1,(A1)+
            MOVE.B  (A0)+,D1
            ADD.B   D0,D1
            MOVE.B  D1,(A1)+
            MOVE.B  (A0)+,D1
            ADD.B   D0,D1
            MOVE.B  D1,(A1)+
            MOVE.B  (A0)+,(A1)+
            MOVE.B  (A0)+,(A1)+
            MOVE.B  (A0)+,(A1)+
            MOVE.B  (A0)+,(A1)+
            STOP    #$1000
    
ID          DC.L    'COOP8200',0
TL          DC.B    32
S1          DS.L    1
HOLD        DS.B    1
            END     START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
