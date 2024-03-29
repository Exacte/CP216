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
	
GET_WORDS   MOVEM.L D0/A1,-(SP)
GET_THEWORD JSR     STR_FUNCT
            MOVE.B  (A2)+,D1
            ADD.B   #1,(A0)
            CMP.B   #0,D1
            BNE     GET_THEWORD
            
OUTPUT      LEA     NUMWORDS,A1
            SUB.B   #1,(A0)
            MOVE.B  (A0),D1
            JSR     P_NUM
            JSR     P_CRLF
            JSR     P_LIST
            MOVEM.L (SP)+,D0/A1
            RTS
            
P_LIST      MOVEM.L D0-D2/A1-A0,-(SP)
PRINT_LOOP  MOVEQ	#3,D0
            MOVE.B  (A0)+,D1	
	TRAP	#15
            LEA     NULL,A1
            MOVEQ	#14,D0	
	TRAP	#15
            SUB.B   #1,D2
            BNE     PRINT_LOOP
            JSR     P_CRLF
            MOVEM.L (SP)+,D0-D2/A1-A0             Restore D0 and A1
            RTS


* Constants and data.
NULL	DC.B	0	Empty string
COM	DC.L	',',0
NUMWORDS    DC.B    'Amount of words entered: ',0


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
