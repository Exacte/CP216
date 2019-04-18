*-----------------------------------------------------------
* Program Number: Q1
* Written by    : Mason Cooper
* Date Created  : 2016-02-05
* Description   : Take user inputed string and returns the length.
*-----------------------------------------------------------
START	ORG	$400	Start of program area

            MOVE.B  #$03,D0
LOOP        LEA	MSG,A1
            JSR	P_STR
            JSR     P_STR_LEN
            LEA     OUT,A1
            JSR     P_NUM
            JSR     P_CRLF
            SUB.B   #1,D0
            BNE     LOOP

	SIMHALT		Stop execution 

MSG	DC.L	'Enter a String: ',0
OUT         DC.L    'The String length is: ',0

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
