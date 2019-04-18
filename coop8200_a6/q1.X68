*-----------------------------------------------------------
* Title      : BCD to ASCII
* Written by : Mason Cooper
* Date       : 02-28-2016
* Description: Takes a signed BCD and converts it to ASCII then prints it to the screen
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
            MOVE.L  NUM1,D1
            JSR     P_BCD
            JSR     P_CRLF
            MOVE.L  NUM2,D1
            JSR     P_BCD
            
            

    SIMHALT             ; halt simulator

* Put variables and constants here
NUM1        DC.L    $567890
NUM2        DC.L    $123450

    INCLUDE	'io_util.x68'
            
    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
