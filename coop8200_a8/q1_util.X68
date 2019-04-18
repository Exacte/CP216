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
STR_FUNC    MOVEM.L D0,-(SP)                Preserve D0 and A1
            MOVEA.L 4(SP),A1
            MOVEA.L (A1)+,A1
            MOVEQ.L #2,D0                   Set up to read string into A1 and length into D1.L
            TRAP    #15                     
            MOVEM.L (SP)+,D0                Restore D0 and A1
            RTS
	
* Prints a string with CR/LF
P_STR	MOVEM.L D0,-(SP)	Preserve D0
	MOVEQ	#14,D0	Set up to print string at A1 with CR/LF
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
	
* Error Detection
ERR_DET     MOVEM.L D0/D2,-(SP)
            MOVE.B  (A2),D2
            MOVE.B  (A1),D1
            MOVE.B  (A0),D0
                       
            CMP.B   #1,D1
            BCS     ERR 
            CMP.B   D1,D0
            BCS     ERR
            
            SUB.B   #1,D1
            SUB.B   D1,D0
            CMP.B   D0,D2
            BLS     END         
	ADD.B   #1,ERR_CODE
	
ERR         ADD.B   #1,ERR_CODE
END	MOVE.B  ERR_CODE,D1
            CLR.B   ERR_CODE
            MOVEM.L (SP)+,D0/D2
	RTS
	
* Prints Error Message
ERR_P       MOVEM.L D0,-(SP)
            LEA     ERR_MSG_1,A1
            CMP.B   #1,D1
            BEQ     P_ERR
            LEA     ERR_MSG_2,A1          
P_ERR       JSR     P_STR
            MOVEM.L (SP)+,D0
            RTS
            
* Cipher's a string
CIPHER      MOVEM.L D0/D1,-(SP)
            MOVE.B  (A1),D1
            MOVE.L  A0,A1
            SUB.B   #1,D1
            ADD.W   D1,A0
            
ENCRYPT     MOVE.B  (A2),D1
LETTER_CHK  CMP.B   #$41,(A0)
            BCS     CONT
            CMP.B   #$5A,(A0)
            BLS     ENC_LOOP
            
            CMP.B   #$7A,(A0)
            BHI     CONT
            CMP.B   #$61,(A0)
            BCC     ENC_LOOP
            JMP     CONT
            
ENC_LOOP    MOVE.B  #$D,D0
ROT         CMP.B   #$5A,(A0)
            BEQ     UPP_ROT
            CMP.B   #$7A,(A0)
            BEQ     LOW_ROT
            JMP     SKP
            
UPP_ROT     MOVE.B  #$40,(A0)
            JMP     SKP
LOW_ROT     MOVE.B  #$60,(A0)
            
SKP         ADD.B   #1,(A0)
            SUB.B   #1,D0
            BNE     ROT
            
CONT        ADD.W   #1,A0
            SUB.B   #1,D1
            BNE     LETTER_CHK
            
            MOVEM.L (SP)+,D0/D1
            RTS
            
* Constants and data.
NULL	DC.B	0	Empty string
TA          DC.B    0
ERR_CODE    DC.B    0
ERR_MSG_1   DC.L    'Encryption starting point out of bounds!',0
ERR_MSG_2   DC.L    'Encryption length exceeds the bounds!',0



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
