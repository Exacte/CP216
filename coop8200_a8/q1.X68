*-----------------------------------------------------------
* Title      : ROT13 With registers
* Written by : Mason Cooper
* Date       : 2016-03-13
* Description: Encrypts a string using ROT13 given the starting position,
* and the length to be encrypted. varibales are passed via registers
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
            
            LEA     STR_LEN,A0
            LEA     ENC_STR,A1
            LEA     ENC_LEN,A2
            JSR     ERR_DET
            ADDA.L  #12,SP
            
            CMP.B   #0,D1
            BEQ     NXT
            JSR     ERR_P
            JSR     P_CRLF
            BRA     ENCRYPTOR
            
NXT         LEA     STR_HOLD,A0
            LEA     ENC_STR,A1
            LEA     ENC_LEN,A2
            JSR     CIPHER
            
            JSR     P_STR
            JSR     P_CRLF
            BRA     ENCRYPTOR
            
FIN         LEA     BYE,A1
            JSR     P_STR
    SIMHALT

* Put variables and constants here
BYE         DC.L    'Goodbye!',0
STR_P       DC.L    'Enter a string: ',0
ENCRYPT_P   DC.L    'Enter a strating position for the encryption: ',0
ENCRYPT_L   DC.L    'Enter length to be encrypted: ',0
STR_LEN     DS.B    1
ENC_STR     DS.B    1
ENC_LEN     DS.B    1
STR_HOLD    DS.L    80


    INCLUDE 'q1_util.x68'

    END    START







*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
