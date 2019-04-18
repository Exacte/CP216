*-----------------------------------------------------------
* Program    : Assignment #1 base program
* Written by : Dr. Nora Znotinas
* Description: subtract two numbers
* Input: num1, num2
* Output: answer
* Registers: D0, D1 - store input so num1/2 not trashed
*-----------------------------------------------------------
START   ORG     $1000
        MOVE.L  num1,D0         ;get first value
        MOVE.L  num2,D1         ;get second value
        SUB.b   D0,D1           ; subract the numbers
        MOVE.L  D1,answer       ; and store result
        MOVE.L  num2,D1         ;get second value
        SUB.W   D0,D1           ; subract the numbers
        MOVE.L  D1,answer2       ; and store result
        MOVE.L  num2,D1         ;get second value
        SUB.L   D0,D1           ; subract the numbers
        MOVE.L  D1,answer3       ; and store result
        STOP    #$2700
num1    DC.L    $12003425
num2    DC.L    $4512374A
answer  DS.L    1
answer2  DS.L    1
answer3  DS.L    1
        END     START
*----------------------------------------------------------- 

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
