*-----------------------------------------------------------
* Title      : File termination
* Written by : Mason Cooper
* Date       : 02-28-2016
* Description:
*-----------------------------------------------------------
START:	ORG     $1000

        LEA     INPUT,A1
        MOVEQ   #14,D0
        TRAP    #15
        MOVEQ   #2,D0
        TRAP    #15
        MOVEQ   #51,D0
        TRAP    #15
        
        MOVE.L  #53,D0        Set up read file
        MOVE.L  FID,D1        Set the file ID
        LEA     DT,A1       Get address of data buffer
        MOVE.L  #B_SIZE,D2    Set data buffer size
        TRAP    #15           Read from the file
        TST.W   D0            Test for errors or EOF (non-0)


        



		SIMHALT	
B_SIZE  EQU     2048          Size of buffer
DT      DS.B    B_SIZE
INPUT   DC.B    'Input a source filename: ',0
BUFFER  DS.B    2048
FNAMEI  DS.B    80            Input file name
FID     DS.L    1             Input file ID


		END		START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
