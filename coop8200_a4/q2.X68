*-----------------------------------------------------------
* Program Number: Q1
* Written by    : Mason Cooper
* Date Created  : 2016-02-05
* Description   : Take user inputed string and returns the length.
*-----------------------------------------------------------
START	ORG	$400	Start of program area
                 
LOOP        LEA     MSG,A1
            JSR     P_STR
            JSR     P_GETC
            JSR     P_DEFINEC        
            CMP     ECOND,D1
            BNE     LOOP

	SIMHALT		Stop execution 

ECOND       DC.W	$23
MSG         DC.L    'Enter a single character: ',0

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
