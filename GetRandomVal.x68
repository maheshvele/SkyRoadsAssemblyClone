
seedRandomNumber
        movem.l ALL_REG,-(sp)
        clr.l   d6
        move.b  #GET_TIME_COMMAND,d0
        TRAP    #15
        move.l  d1,d6
        mulu    #LARGE_NUMBER,d6
        move.l  d6,RANDOMVAL
        movem.l (sp)+,ALL_REG
        rts

getRandomLongIntoD6
        movem.l d0,-(sp)
        movem.l d1,-(sp)
        move.l  RANDOMVAL,d6
        mulu    #LARGE_NUMBER,d6
        move.l  #31,d0
        TRAP    #15
        mulu    d1,d6
        bcs     nocarry
        add.l   #1,d6
nocarry
        move.l  d6,RANDOMVAL
        movem.l (sp)+,d1
        movem.l (sp)+,d0
        rts


getRandomByteIntoD6
        movem.l ALL_REG,-(sp)
        jsr     getRandomLongIntoD6
        move.b  #GET_TIME_COMMAND,d0
        TRAP    #15
        andi    #7,d1
        lsr     d1,d6
        move.l  d6,TEMPRANDOMLONG
        movem.l (sp)+,ALL_REG
        move.l  TEMPRANDOMLONG,d6
        rts
        
*getRandomLongIntoD6
        movem.l ALL_REG,-(sp)
        jsr     getRandomByteIntoD6
        move.b  d6,d5
        jsr     getRandomByteIntoD6
        lsl.l   #8,d5
        move.b  d6,d5
        jsr     getRandomByteIntoD6
        lsl.l   #8,d5
        move.b  d6,d5
        jsr     getRandomByteIntoD6
        lsl.l   #8,d5
        move.b  d6,d5
        move.l  d5,TEMPRANDOMLONG
        movem.l (sp)+,ALL_REG
        move.l  TEMPRANDOMLONG,d6
        rts

setRandomFillColor
        movem.l ALL_REG,-(sp)
        jsr     getRandomLongIntoD6
        move.l  d6,d1
        andi.l   #$00FFFFFF,d1

        move.b  #81,d0
        TRAP    #15
        movem.l (sp)+,ALL_REG
        rts
                





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
