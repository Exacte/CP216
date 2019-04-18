*-----------------------------------------------------------
* Title      : Bit Maps
* Written by : Mason Cooper
* Date       : 03-01-2016
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:
            LEA     Disk1,A1
            JSR     F_C_EMPTY
            LEA     Disk1,A1
            JSR     FEC_SET


    SIMHALT

* Variables and constants
Bitmap  EQU    *
Disk1   DC.L   $FFFFFFF0,$0FC8FEDF,$00001111,$22223333
        DC.L   $FFFFFFFF,$FFFF000F,$FF000000,$00000000
Disk2   DC.L   $FFFFFFFF,$FFFFFF00,$00000000,$FFFF8000
        DC.L   $0F021234,$00004321,$00001111,$22223333
Disk3   DC.L   $FF800000,$00FFFFFF,$FFFFFFFF,$22003333
        DC.L   $00000000,$F8007FF0,$0000AAAA,$FF004660
Disk4   DC.L   $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
        DC.L   $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF
Disk5   DC.L   $00000000,$00000000,$00000000,$00000000
        DC.L   $00000000,$00000000,$00000000,$00000000

    INCLUDE 'io_util.x68'

    END    START







*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
