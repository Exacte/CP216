*-----------------------------------------------------------
* Title      : Drawing Lines
* Written by : Mason Cooper
* Date       : 03-06-2016
* Description: 
*-----------------------------------------------------------
   ORG    $1000  
START:                  

        MOVE.L  #$00,D1
        JSR  SB_CLR
    


* Horizontal line
        MOVE.L   #100,D1
        MOVE.L   #10,D2
        MOVE.L   #100,D3
        MOVE.L   #5,D4
        MOVE.L   #$FF,D5
        JSR      DRAW_HLINE
        
* Vertical line
        MOVE.L   #100,D1
        MOVE.L   #10,D2
        MOVE.L   #100,D3
        MOVE.L   #5,D4
        MOVE.L   #$FF00,D5
        JSR      DRAW_VLINE
        
* Diagonal l-r line
        MOVE.L   #100,D1
        MOVE.L   #10,D2
        MOVE.L   #100,D3
        MOVE.L   #5,D4
        MOVE.L   #$FF0000,D5
        JSR      DRAW_DLR_LINE
        

* Diangonal r-l line
        MOVE.L   #210,D1
        MOVE.L   #10,D2
        MOVE.L   #100,D3
        MOVE.L   #5,D4
        MOVE.L   #$FF00FF,D5
        JSR      DRAW_DRL_LINE
        
        
* draw horizontal line
        MOVE.L   #100,D1
        MOVE.L   #110,D2
        MOVE.L   #105,D3
        MOVE.L   #5,D4
        MOVE.L   #$FFFF00,D5
        JSR      DRAW_HLINE
        
* draw vertical line

        MOVE.L   #200,D1
        MOVE.L   #10,D2
        MOVE.L   #100,D3
        MOVE.L   #5,D4
        MOVE.L   #$00FFFF,D5
        JSR      DRAW_VLINE
       
* display
        JSR  SB_DSP

EXIT


    SIMHALT             ; halt simulator

DRAW_HLINE
    
        MOVEM.L     D0/A0,-(SP)
        LEA.L    SB,A0
        LSL.L    #2,D1
        ADDA.L   D1,A0
        MULU     #SB_W,D2
        LSL.L    #2,D2
        ADDA.L   D2,A0
        MOVE.L   #SB_W,D2
        LSL.L    #2,D2
        
HWLOOP  MOVE.L   D3,D0
        MOVE.L   A0,A1
HHLOOP  MOVE.L   D5,(A0)+
        DBRA     D0,HHLOOP
        MOVE.L   A1,A0    
        ADDA.L   D2,A0
        DBRA     D4,HWLOOP
        MOVEM.L	(SP)+,D0/A0
        RTS
   
DRAW_VLINE  MOVEM.L D0/A0,-(SP)
        LEA.L    SB,A0
        LSL.L    #2,D1
        ADDA.L   D1,A0
        MULU     #SB_W,D2
        LSL.L    #2,D2
        ADDA.L   D2,A0
        MOVE.L   #SB_W,D2
        LSL.L    #2,D2
        
VHLOOP  MOVE.L   D4,D0
        MOVE.L   A0,A1
VWLOOP  MOVE.L   D5,(A0)+
        DBRA     D0,VWLOOP
        MOVE.L   A1,A0    
        ADDA.L   D2,A0
        DBRA     D3,VHLOOP
        MOVEM.L	(SP)+,D0/A0
        RTS

DRAW_DLR_LINE   MOVEM.L D0/A0,-(SP)
        LEA.L    SB,A0
        LSL.L    #2,D1
        ADDA.L   D1,A0
        MULU     #SB_W,D2
        LSL.L    #2,D2
        ADDA.L   D2,A0
        MOVE.L   #SB_W,D2
        LSL.L    #2,D2
        
LRHLOOP  MOVE.L   D4,D0
         MOVE.L   A0,A1
LRWLOOP  MOVE.L   D5,(A0)+
        DBRA     D0,LRWLOOP
        MOVE.L   A1,A0      
        ADDA.L   D2,A0
        ADDA.L   #4,A0
    
        DBRA     D3,LRHLOOP
        MOVEM.L	(SP)+,D0/A0
        RTS
    
DRAW_DRL_LINE   MOVEM.L D0/A0,-(SP)
        LEA.L    SB,A0
        LSL.L    #2,D1
        ADDA.L   D1,A0
        MULU     #SB_W,D2
        LSL.L    #2,D2
        ADDA.L   D2,A0
        MOVE.L   #SB_W,D2
        LSL.L    #2,D2

RLHLOOP  MOVE.L   D4,D0
        MOVE.L   A0,A1
RLWLOOP  MOVE.L   D5,-(A0)
        DBRA     D0,RLWLOOP
        MOVEA.L  A1,A0   
        ADDA.L   D2,A0
        SUBA.L   #4,A0
    
        DBRA     D3,RLHLOOP
        MOVEM.L	(SP)+,D0/A0
        RTS
    
    
     INCLUDE "buffer.X68"

 

      END    START        ; last line of source









*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
