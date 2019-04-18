*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

            LEA     MSG1,A1
            JSR     P_STR
            LEA     ARRAY,A1
        
TOP         JSR     STR_FUNCT
            ADD.L   D1,A1
            CMP.B   #0,D1
            BNE     TOP
        
            JSR     P_LIST

    SIMHALT             ; halt simulator

* Put variables and constants here
ARRAY   DS.B  110
MSG1    DC.B  'Enter a new word: ', 0

            INCLUDE	'io_util.x68'

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
