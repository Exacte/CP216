*-----------------------------------------------------------
* Title      : binary to BCD
* Written by : Mason Cooper
* Date       : 02-28-2016
* Description: converts binary to bcd
*-----------------------------------------------------------
* additional deliverable: 11000011010100000 to 11110100001000111111

START:  ORG     $1000
        MOVE.L  #$0001E23A,D0

        MOVEQ   #0,D2      
        MOVEQ   #7,D5
LOOP
        DIVU    #10,D0
        MOVE.L  D0,D1
        AND.L   #$FFFF,D0
        CLR.W   D1
        ADD.L   D1,D2
        ROR.L   #4,D2
        DBRA    D5,LOOP        
        ROL.L   #8,D2
        ROL.L   #8,D2
        MOVE.L  D2,D1
        JSR     P_BCD
        
        
            SIMHALT
        
        INCLUDE 'io_util.x68'    
        
	END	START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
