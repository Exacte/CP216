*-----------------------------------------------------------
* Title      :Q4
* Written by :Mason Cooper
* Date       :2016-01-22
* Description:Divides a laced word into two
*-----------------------------------------------------------

START       ORG     $400

            LEA     LACED,A0
            LEA     S1,A1
            LEA     S2,A2
            MOVE.B  (A0)+,(A1)+
            MOVE.B  (A0)+,(A2)+
            MOVE.B  (A0)+,(A1)+
            MOVE.B  (A0)+,(A2)+
            MOVE.B  (A0)+,(A1)+
            MOVE.B  (A0)+,(A2)+
            MOVE.B  (A0)+,(A1)+
            MOVE.B  (A0)+,(A2)+
            
            STOP    #$1000
    
LACED       DC.L    'FeRaEsDy',0
S1          DS.L    1
S2          DS.L    1
            END     START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
