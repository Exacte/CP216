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
P_PRMPT   MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ.L	#18,D0	Set up prompt and read number into D1.L
	TRAP	#15
	MOVEM.L	(SP)+,D0	Restore D0
	RTS

* Prints the prompt at A1 and reads a string into D1.
P_STR_LEN   MOVEM.L D0/A1,-(SP)             Preserve D0 and A1
            LEA	TA,A1                   Move throw away variable pointer to A1
            MOVEQ.L #2,D0                   Set up to read string into A1 and length into D1.L
            TRAP    #15                     
            MOVEM.L (SP)+,D0/A1             Restore D0 and A1
            RTS

* Prints the mesage at A1 and the value at D1
P_NUM	MOVEM.L	D0,-(SP)	Preserve D0
	MOVEQ	#17,D0	Set up to print D1.L without CR/LF
	TRAP	#15	Print the number
	MOVEM.L	(SP)+,D0	Restore D0
	RTS
	
* Prints a string with CR/LF
P_STR	MOVEM.L D0,-(SP)	Preserve D0
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

* Prints a signed BCD number
P_BCD       MOVEM.L D0/D1/D2/A0/A1,-(SP)
            MOVE.L  D1,HOLD
            LEA     HOLD,A0
            LEA     UNPCKD,A1
            MOVE.L  D1,D2
N_TST_LOOP  ADD.B   #1,LEN
            LSR.L   #4,D2
            CMP.L   END_CHK,D2
            BGT     N_TST_LOOP
            
            CMP.L   #5,D2
            BLT     HERE

            LEA     HOLD+4,A0
            MOVE.B  #2,D2
            
NBCD_LOOP   NBCD    -(A0)
            DBRA    D2,NBCD_LOOP
            MOVE.W  #$FD,(A1)+
            
HERE        CLR.L   D2
            MOVE.B  #3,D2

UNPCK_LOOP  CLR.L   D1
            MOVE.B  (A0)+,D1
            LSL.W   #4,D1
            LSR.B   #4,D1
            MOVE.W  D1,(A1)+
            DBRA    D2,UNPCK_LOOP
            
            CLR.L   D1
            CLR.L   D2
            LEA     UNPCKD,A1
            ADD.L   #1,A1
            ADD.B   #1,LEN
            MOVE.B  LEN,D2
ASCII_LOOP  MOVE.B  (A1)+,D1
            ADD.B   #$30,D1
            MOVEQ.L	#6,D0
	TRAP	#15
            DBRA    D2,ASCII_LOOP
            MOVE.B  #0,LEN
            
            MOVEM.L (SP)+,D0/D1/D2/A0/A1
            RTS          


* Constants and data.
NULL	DC.B	0	Empty string
TA          DC.B    0
END_CHK     DC.L    $10
LEN         DC.B    0
POS         DC.B    8
HOLD        DS.B    6
UNPCKD      DS.W    4

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~








*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
