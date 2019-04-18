*-----------------------------------------------------------
* Title      : ROT13 with stack frames
* Written by : Mason Cooper
* Date       : 2016-03-13
* Description: Encrypts a string using ROT13 given the starting position,
* and the length to be encrypted. varibales are passed using a stack frame
*-----------------------------------------------------------
    ORG    $1000
START:
ENCRYPTOR   LEA     STR_P,A1
            JSR     P_STR
            JSR     STR_FUNC
            DC.L    STR_HOLD
            CMP.B   #0,STR_HOLD
            BEQ     FIN
            MOVE.B  D1,STR_LEN
            
            LEA     ENCRYPT_P,A1
            JSR     P_PRMPT
            MOVE.B  D1,ENC_STR
            
            LEA     ENCRYPT_L,A1
            JSR     P_PRMPT
            MOVE.B  D1,ENC_LEN
            
            PEA     STR_LEN
            PEA     ENC_STR
            PEA     ENC_LEN
            PEA     ERR_CODE
            JSR     ERR_DET
            ADDA.L  #16,SP
            
            CMP.B   #0,ERR_CODE
            BEQ     NXT
            JSR     ERR_P
            DC.L    ERR_CODE
            JSR     P_CRLF
            BRA     ENCRYPTOR
            
NXT         PEA     ENC_STR
            PEA     ENC_LEN
            PEA     STR_HOLD
            JSR     CIPHER
            
            JSR     P_STR
            JSR     P_CRLF
            BRA     ENCRYPTOR
            
FIN         LEA     BYE,A1
            JSR     P_STR
    SIMHALT

* Put variables and constants here
ERR_CODE    DC.B    0
BYE         DC.L    'Goodbye!',0
STR_P       DC.L    'Enter a string: ',0
ENCRYPT_P   DC.L    'Enter a strating position for the encryption: ',0
ENCRYPT_L   DC.L    'Enter length to be encrypted: ',0
STR_LEN     DS.B    1
ENC_STR     DS.B    1
ENC_LEN     DS.B    1
STR_HOLD    DS.L    80


    INCLUDE 'q3_util.x68'

    END    START




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
