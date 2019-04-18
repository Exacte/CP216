*-----------------------------------------------------------
* Program    : io_util
* Written by : David Brown
* Date       : 2016-01-25
* Description: Printing utilities
*
* Three registers have special functions:
* D0 contains the task code telling the simulator the type
*	of I/O to perform
* D1 contains either the data or the length of the data
*	involved in I/O depending on the task
* A1 contains the address of strings to be input or output
*	or the path of the file to be used in I/O
*-----------------------------------------------------------
* Prints the prompt at A1 and reads a number into D1.
P_PRMPT     MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ.L	#18,D0	Set up prompt and read number into D1.L
	TRAP	#15
	MOVEM.L	(SP)+,D0	Restore D0
	RTS
	
P_PRMPTL    MOVEM.L D0-D2/A0,-(SP)
STORE_LOOP  JSR     P_PRMPT
            MOVE.B  D1,(A0)+
            SUB.B   #1,D2
            BNE     STORE_LOOP
            MOVEM.L (SP)+,D0-D2/A0
            RTS
            
P_LIST      MOVEM.L D0-D2/A1-A0,-(SP)
PRINT_LOOP  MOVEQ	#3,D0
            MOVE.B  (A0)+,D1	
	TRAP	#15
            LEA     COM,A1
            MOVEQ	#14,D0	
	TRAP	#15
            SUB.B   #1,D2
            BNE     PRINT_LOOP
            JSR     P_CRLF
            MOVEM.L (SP)+,D0-D2/A1-A0             Restore D0 and A1
            RTS
            
P_LSUM      MOVEM.L D0-D2/A1-A0,-(SP)
            MOVE.B  #0,D2
            LEA     SLM,A1
            JSR     P_PRMPT
SUM_LOOP    MOVE.B  (A0)+,D0
            ADD.B   D0,D2
            SUB.B   #1,D1
            BNE     SUM_LOOP
            MOVE.B  D2,D1
            LEA     SLR,A1
            JSR     P_NUM
            JSR     P_CRLF
            MOVEM.L (SP)+,D0-D2/A1-A0             Restore D0 and A1
            RTS
            
END_F       MOVE.L A1,-(SP)
            LEA     ENDM,A1
            JSR     P_STR
            MOVE.B  #01,D0
            MOVE.L (SP)+,A1
            RTS
            
* Prints the prompt at A1 and reads a string into D1.
STR_FUNCT   MOVEM.L D0/A1,-(SP)             Preserve D0 and A1
            MOVEQ.L #2,D0                   Set up to read string into A1 and length into D1.L
            TRAP    #15
            MOVE.L  A1,A2                     
            MOVEM.L (SP)+,D0/A1             Restore D0 and A1
            RTS

* Prints the mesage at A1 and the value at D1
P_NUM	MOVEM.L	D0/A1,-(SP)	Preserve D0
	MOVEQ	#17,D0	Set up to print D1.L without CR/LF
	TRAP	#15	Print the number
	MOVEM.L	(SP)+,D0/A1	Restore D0
	RTS
	
* Prints a string with CR/LF
P_STR	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#13,D0	Set up to print string at A1 with CR/LF
	TRAP	#15	Print the string
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

* Prints a CR/LF
P_CRLF	MOVEM.L	D0/A1,-(SP)	Preserve D0 and A1
	MOVEQ.L	#13,D0	Set up print with CRLF
	LEA	NULL,A1	Set null string
	TRAP	#15
	MOVEM.L	(SP)+,D0/A1	Restore D0 and A1
	RTS
	
P_GETC      MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#5,D0	Read a single ASCII char. into A1
	TRAP	#15	
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

P_DEFINEC   MOVEM.L D0/A1,-(SP)
            MOVEA.L #C_ARRAY,A1
            MOVE.B  NULL,D2
COMP        ADD.B   #$01,D2
            CMP.B   (A1)+,D1
            BGT     COMP
            
            LEA     OTH,A1
            BTST.B  D2,#$55
            BEQ     PRINT_
            
            LEA     UPP,A1
            BTST.B  D2,#4
            BEQ     PRINT_
            
            LEA     LOW,A1
            BTST.B  D2,#6
            BEQ     PRINT_

            LEA     NUM,A1
            BTST.B  D2,#2
            BEQ     PRINT_            

PRINT_      MOVEQ   #13,D0
            TRAP    #15

            MOVEM.L (SP)+,D0/A1
            RTS   

GET_WORDS   MOVEM.L D0/A1,-(SP)
GET_THEWORD JSR     STR_FUNCT
            ADD.L   D1,A1
            ADD.B   #1,(A0)
            CMP.B   #0,D1
            BNE     GET_THEWORD
            
OUTPUT      LEA     NUMWORDS,A1
            SUB.B   #1,(A0)
            MOVE.B  (A0),D1
            JSR     P_NUM
            JSR     P_CRLF 
            MOVEM.L (SP)+,D0/A1
            RTS

* Constants and data.
NULL	DC.B	0	Empty string
TA          DC.B    0
C_ARRAY     DC.B    $2F,$39,$40,$5A,$60,$7A,$7F
COM         DC.L    ',',0
OTH         DC.L    ' This is not a # or a char!',0
NUM         DC.L    ' This is a number!',0
UPP         DC.L    ' This is a upper case letter!',0
LOW         DC.L    ' This is  a lower case letter!',0
SLM         DC.L    'How many elements would you like to sum? ',0
SLR         DC.L    'The sum is: ',0
ENDM        DC.L    'Programming Ending.',0
NUMWORDS    DC.B    'Amount of words entered: ',0


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
