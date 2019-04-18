*-----------------------------------------------------------
* Program Number: Q1
* Written by    : Mason Cooper
* Date Created  : 2016-02-09
* Description   : 
*-----------------------------------------------------------
START	ORG	$400	Start of program area

            LEA     DATA,A0
            LEA     PRMPT,A1
            MOVE.B  _DATA,D2
            JSR     P_PRMPTL
            LEA     MSG,A1
LOOP        JSR     P_STR
            JSR     STR_FUNCT
            
            TST.B   D0
            BEQ     LOOP
            
END_TEST    
            RTS
	SIMHALT		Stop execution 

PRMPT       DC.L    'Enter a 8-bit unsigned numbers: ',0
MSG         DC.L    'Enter a Function name(print, sum, end): ',0
PRINT       DC.W    'print',0
SUM         DC.W    'sum',0
END         DC.W    'end',0
DATA	DS.B    5    
_DATA       DC.B    5

*-----------------------------------------------------------

	INCLUDE	'io_util.x68'

	END	START	End of program and entry





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~









*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
