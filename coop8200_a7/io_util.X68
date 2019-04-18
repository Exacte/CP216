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
	
* Finds First empty cluster on a specified disk

F_C_EMPTY   MOVEM.L D0/D1/D2/A1/A2,-(SP)
            MOVE.B  #7,D1
NOT_FULL    MOVE.L  (A1)+,D0
            ADD.B   #$20,POS
            CMP.L   CLU_FULL,D0
            BNE     NOT_F
            DBRA    D1,NOT_FULL
            
            CMP.W   DISK_FULL,D1
            BEQ     ALT_END
            
NOT_F       ROL.L   #8,D0
            ADD.B   #8,POS
            CMP.B   #$FF,D0
            BEQ     NOT_F
            CLR.B   D1

            CMP.B   #$7F,D0
            BLS     END
            CMP.B   #$F0,D0
            BCC     R_BYTE
            
            MOVE.B  D0,D1
            ROR.B   #4,D1
            
            ADD.B   #1,POS
            CMP.B   #$C,D1
            BCS     END
            ADD.B   #1,POS
            CMP.B   #$E,D1
            BCS     END
            ADD.B   #1,POS
            JMP     END
            
            
R_BYTE      ADD.B   #4,POS
            CMP.B   #$F8,D0
            BCS     END
            ADD.B   #1,POS
            CMP.B   #$FC,D0
            BCS     END
            ADD.B   #1,POS
            CMP.B   #$FE,D0
            BCS     END
            ADD.B   #1,POS
            JMP     END
            
END         LEA     CLU_STR,A1
            MOVE.B  POS,D1
            JSR     P_STR
            MOVE.B  #10,D2
            MOVE.B  #15,D0
            TRAP    #15
            JMP     SKIP
            
ALT_END     LEA     C_F_STR,A1
            JSR     P_STR
          
SKIP        MOVEM.L (SP)+,D0/D1/D2/A1/A2
            RTS
            
* Find the length of the first empty cluster set
FEC_SET     MOVEM.L D0/D1/D2/A1/A2,-(SP)
            MOVE.B  #7,D0
N_F         MOVE.L  (A1)+,D0
            CMP.L   CLU_FULL,D0
            BNE     SUB
            DBRA    D1,N_F
            
            CMP.W   DISK_FULL,D1
            BEQ     _END
            
SUB         SUB.W   #4,A1
            CLR.L   D0
            JMP     FIRST_Z

TZ_ADD      ADD.B   #1,D0
            ADD.B   D0,TOTAL
            CMP.B   #$FF,(A1)+
            BEQ     FINISH
            SUB.W   #1,A1
            CMP.B   #$80,(A1)
            BCS     LZ_TEST
            CMP.B   #$80,(A1)
            BCC     FINISH

            
FIRST_Z     MOVE.B  (A1),D1
            CMP.B   #$FF,(A1)+
            BEQ     FIRST_Z
            
            LEA     T_ZERO,A2
            MOVE.B  #7,D0
TZ_TEST     MOVE.B  (A2)+,D2
            CMP.B   D1,D2
            BEQ     TZ_ADD
            DBRA    D0,TZ_TEST
            
            CMP.B   $7F,D1
            BLS     EMB
            
LZ_TEST     LEA     L_ZERO,A2
            MOVE.B  (A1),D1
            MOVE.B  #7,D0
LZ_LOOP     ADD.B   #1,TOTAL
            MOVE.B  (A2)+,D2
            CMP.B   D1,D2
            BLS     FINISH
            DBRA    D0,LZ_LOOP
            
EMB         LEA     Z_ARRAY,A1
            CMP.W   #$BF,D1
            BLS     CALC
            ADD.W   #$5,A1
            CMP.W   #$DF,D1
            BLS     CALC
            ADD.W   #$4,A1
            CMP.W   #$EF,D1
            BLS     CALC
            ADD.W   #$3,A1
            CMP.W   #$F7,D1
            BLS     CALC
            ADD.W   #$2,A1
            CMP.W   #$FB,D1
            BLS     CALC
            ADD.W   #$1,A1
            CMP.W   #$FD,D1
            BLS     CALC
            ADD.W   #$1,A1

CALC        ADD.B   #1,TOTAL
            MOVE.B  (A1)+,D2
            CMP.B   D1,D2
            BHI     CALC
            

FINISH      LEA     ETY_SET_CLU,A1
            MOVE.B  TOTAL,D1
            JSR     P_STR
            MOVE.B  #10,D2
            MOVE.B  #15,D0
            TRAP    #15
            JMP     SKIP_HERE
            
_END        LEA     C_F_STR,A1
            JSR     P_STR
                   
SKIP_HERE   MOVEM.L (SP)+,D0/D1/A1
            RTS


TOT_ETY     MOVEM.L D0/D1/A1,-(SP)
            MOVE.B  #7,D1
SMT         MOVE.L  (A1)+,D0
            ROL.L   #1,D0
            DBRA    D1,SMT
            MOVEM.L (SP)+,D0/D1/A1/A2
            RTS

* Constants and data.
NULL	DC.B	0	Empty string
TA          DC.B    0
TOTAL       DC.B    0
POS         DC.B    $D8
T_ZERO      DC.B    00,$80,$C0,$E0,$F0,$F8,$FC,$FE
L_ZERO      DC.B    $7F,$2F,$1F,$F,7,2,1
Z_ARRAY     DC.B    $90,$88,$84,$82,$81
            DC.B    $C8,$C4,$C2,$C1,$E4,$E2
            DC.B    $E1,$F2,$F1,$F9,$FD
DISK_FULL   DC.W    $FFFF
CLU_FULL    DC.L    $FFFFFFFF
C_F_STR     DC.L    'This Disk is Full!',0
CLU_STR     DC.L    'First avaliable cluster is at: ',0
ETY_SET_CLU DC.L    'The first set of empty clusters is of lenght: ',0



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~














*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
