*-----------------------------------------------------------
* Title      : Login
* Written by : Mason Cooper
* Date       : 03-05-2016
* Description: 
*-----------------------------------------------------------
    ORG    $1000
    
START:                  
        LEA	    P_I,A1    
	    JSR	    P_STR         
	    LEA     FNAMEI,A1     
	    JSR     G_STR         
	    JSR     FOPENR   	  
        TST.W   D0            
        BNE     EXIT


        LEA	    P_O,A1   
	    JSR	    P_STR         
	    LEA     FNAMEO,A1     
	    JSR     G_STR         
	    JSR     FOPENW   	  
	    TST.W   D0           
        BNE     EXIT

READ_L  MOVE   #READ_SIZE, D2 
        ADDQ   #2,D2
        JSR    FREAD          
        CMP.W  #1,D0
        BEQ    EOF

        MOVE  #WRITE_SIZE,D1
        MOVE  #32,D0
        LEA   DATAO,A2
CLR_L   MOVE.B D0,(A2)+ 
        DBRA  D1,CLR_L
        
     
        LEA DATAO,A2            
        LEA DATAI,A1          
        ADDA.L #02,A1         
FN_L    MOVE.B (A1)+,D0
        CMPI.B #' ',D0        
        BEQ  FN_L
        SUBA.L #3,A1           
        CMPA.L #DATAI,A1      
        BGE   POS
        MOVE  #'x',D0         
        MOVE  #3,D1
          
B_L     MOVE.B D0,(A2)+
        SUBQ   #1,D1
        ADDA.L #1,A1        
        CMPA.L #DATAI,A1
        BMI    B_L
        BRA    N_L
POS     MOVE #3,D1

N_L     MOVE.B (A1)+,D0
        JSR  TOLOWER
        MOVE.B D0,(A2)+
        DBRA D1,N_L
        

        LEA DATAI,A1             
        ADDA.L #64,A1          
        MOVE #3,D1
ID_L    MOVE.B (A1)+,D0
        MOVE.B D0,(A2)+
        DBRA D1,ID_L
        

        LEA DATAI,A1          
        ADDA.L #2,A2                 
        MOVE #READ_SIZE,D1    
        SUBQ #1,D1
        
WRITE_L MOVE.B (A1)+,D0
        MOVE.B D0,(A2)+
        DBRA D1,WRITE_L
        MOVE #CR,D0           
        MOVE.B D0,(A2)+
        MOVE #LF,D0
        MOVE.B D0,(A2)+
        MOVE #WRITE_SIZE,D2    
        ADDQ #2,D2
        JSR FWRITE 
        BRA READ_L
        
EOF     JSR    FCLOSER
        JSR    FCLOSEW  

EXIT


    SIMHALT             ; halt simulator
    
P_I     DC.B	'Enter a input file name: ',0
P_O     DC.B	'Enter a output file name: ',0  

FOPENR  MOVE.L  #51,D0
        LEA     FNAMEI,A1
        TRAP    #15
        TST.W   D0
        BNE     F_ERR1
        MOVE.L  D1,FID_I
        RTS
        

FOPENW  MOVE.L  #52,D0
        LEA     FNAMEO,A1
        TRAP    #15
        TST.W   D0
        BNE     F_ERR1
        MOVE.L  D1,FID_O
        RTS
     
F_ERR1  LEA	    FMSG1,A1
	    JSR	    P_STR
	    RTS

FREAD   MOVE.L  #53,D0
        MOVE.L  FID_I,D1
        LEA     DATAI,A1
        TRAP    #15
        TST.W   D0
        BEQ     RD_RTN
        CMP.B   #1,D0
        BNE     RD_RTN         
        BNE     F_ERR2
RD_RTN  RTS
        
F_ERR2  LEA	    FMSG2,A1
	    JSR	    P_STR
        RTS
        


FWRITE  MOVE.L  #54,D0
        MOVE.L  FID_O,D1
        LEA     DATAO,A1

        TRAP    #15
        TST.W   D0        
        BNE     F_ERR3 
        RTS
        
F_ERR3  LEA	    FMSG3,A1
	    JSR	    P_STR
        RTS

FCLOSER	MOVE.L  #56,D0
        MOVE.L  FID_I,D1
        TRAP    #15
        TST.W   D0
        BNE     F_ERR4
        RTS
        
FCLOSEW	MOVE.L  #56,D0
        MOVE.L  FID_O,D1
        TRAP    #15
        TST.W   D0
        BNE     F_ERR4
        RTS

F_ERR4  LEA	    FMSG3,A1
	    JSR	    P_STR

TOLOWER  CMPI.B  #'a',D0
         BHS    LOWER
         CMPI.B  #'A',D0
         BHS    UPPER    
         CMPI.B  #'Z',D0
         BLS    UPPER
         CMPI.B  #'z',D0
         BLS    LOWER
         
RTNX     MOVE   #'x',D0
         RTS
         
UPPER    CMPI.B  #'A',D0
         BLO    RTNX 
         CMPI.B  #'Z',D0
         BHI    RTNX
         ORI.B  #$20,D0
         RTS
         
LOWER    CMP.B  #'a',D0
         BLO    RTNX 
         CMP.B  #'z',D0
         BHI    RTNX
         RTS
         
CMP_LP  SUBQ   #1,D1
    BNE    CMP_LP


P_STR	MOVEM.L	D0,-(SP)
	MOVEQ	#13,D0
	TRAP	#15
	MOVEM.L	(SP)+,D0
	RTS

G_STR	MOVEM.L	D0,-(SP)
	MOVEQ	#2,D0	
    TRAP	#15
	MOVEM.L	(SP)+,D0
	RTS   

P_NUM	MOVEM.L	D0,-(SP)
	MOVEQ	#3,D0
    TRAP	#15
	MOVEM.L	(SP)+,D0
	RTS  

G_NUM	MOVEM.L	D0,-(SP)
	MOVEQ	#4,D0
    TRAP	#15
	MOVEM.L	(SP)+,D0
	RTS  

P_CRLF	MOVEM.L	D0/A1,-(SP)
	MOVEQ.L	#13,D0
	LEA	NULL,A1
	TRAP	#15
	MOVEM.L	(SP)+,D0/A1
	RTS

G_CHAR	MOVEM.L	D0,-(SP)
	MOVEQ	#5,D0
    TRAP	#15
	MOVEM.L	(SP)+,D0
	RTS

P_CHAR	MOVEM.L	D0,-(SP)
	MOVEQ	#6,D0
    TRAP	#15
	MOVEM.L	(SP)+,D0
	RTS  

FMSG1 	DC.B	'Cannot open file',0
FMSG2 	DC.B	'Cannot read file',0
FMSG3 	DC.B	'Cannot write file',0
FMSG4 	DC.B	'Cannot close file',0
NULL	DC.B	0
FNAMEI  DS.B    80
FNAMEO  DS.B    80
FID_I   DS.L    1
FID_O   DS.L    1
B_SIZE      EQU    2048         
CR          EQU    13            
LF          EQU    10            
READ_SIZE   EQU    68  
WRITE_SIZE  EQU    78  

        org     $2000
DATAI   DS.B    B_SIZE
DATAO   DS.B    B_SIZE

        END    START








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
