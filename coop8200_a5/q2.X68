*-----------------------------------------------------------
* Program Number: Q3
* Written by    : Mason Cooper
* Date Created  : 2016-02-09
* Description   : 
*-----------------------------------------------------------

START:      ORG     $400
            LEA     MSG,A1
            JSR     P_STR
            LEA     COUNT1,A0
            LEA     WORDS1,A1
            JSR     GET_WORDS
            
            LEA     INIT,A1
            JSR     P_STR
            LEA     COUNT2,A0
            LEA     WORDS2,A1
            JSR     GET_WORDS
            
            LEA     INIT,A1
            JSR     P_STR
            LEA     COUNT3,A0
            LEA     WORDS3,A1
            JSR     GET_WORDS
            
            SIMHALT

MSG        DC.B    'Enter a series of words: ',0
COUNT1      DC.B    0
WORDS1      DS.B    30
COUNT2      DC.B    0
WORDS2      DS.B    30
COUNT3      DC.B    0
WORDS3      DS.B    30
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
