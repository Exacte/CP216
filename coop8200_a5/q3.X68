*-----------------------------------------------------------
* Program Number: Q2
* Written by    : Mason Cooper
* Date Created  : 2016-02-09
* Description   : 
*-----------------------------------------------------------
    START:      ORG     $400
            LEA     MSG,A1
            JSR     P_STR
            LEA     COUNT1,A0
            LEA     WORDS1,A1
            LEA     WORD_L1,A2
            JSR     GET_WORDS
            
            LEA     INIT,A1
            JSR     P_STR
            LEA     COUNT2,A0
            LEA     WORDS2,A1
            LEA     WORD_L2,A2
            JSR     GET_WORDS
            
            LEA     INIT,A1
            JSR     P_STR
            LEA     COUNT3,A0
            LEA     WORDS3,A1
            LEA     WORD_L3,A2
            JSR     GET_WORDS
            
            SIMHALT

MSG        DC.B    'Enter a series of words: ',0
COUNT1      DC.B    0
WORDS1      DS.B    30
WORD_L1     DS.B    10
COUNT2      DC.B    0
WORDS2      DS.B    30
WORD_L2     DS.B    10
COUNT3      DC.B    0
WORDS3      DS.B    30
WORD_L3     DS.B    10
*-----------------------------------------------------------

	INCLUDE	'io_util_q3.x68'
	
            END	START	End of program and entry





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~8~





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
