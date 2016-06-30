 *-----------------------------------------------------------
* Title      : MoveObstacle
* Written by : Mahesh Velegonda
* Date       : 10/4/2014
* Description: Code to Move the player is taken care here
*-----------------------------------------------------------
     
incrementGapCounter1:
    addi.l  #1,d1
    move.l  d1,INVAL1_TOP_X
    
    movem.l (sp)+,ALL_REG
    rts
     
gapGenerator1:
    
    movem.l ALL_REG,-(sp)
    
    move.l  GENERATE_GAP_COUNTER_SMALL,d0
    move.l  d0,d1
    asr.l   #8,d1
    asr.l   #2,d1

    cmpi.l  #1,d1
    beq     generateGap1
    
    addi.l  #1,d0
    move.l  d0,GENERATE_GAP_COUNTER_SMALL
    movem.l (sp)+,ALL_REG
    rts

generateGap1:
    
    move.l  #0,GENERATE_GAP_COUNTER_SMALL
   
    move.l  INVAL1_TOP_X,d1
    cmpi.l  #OBSTACLE_START_TOP_X,d1
    beq     incrementGapCounter1
    
    movem.l (sp)+,ALL_REG
    rts
    
startNextObstacle1:
    move.l  OBSTACLE1_TOP_X,d1
    move.l  d1,d2
    
    cmpi.l  #OBSTACLE_START_TOP_X,d2
    bne     returnObstacleGenerator1
    
    addi.l  #1,d1
    move.l  d1,OBSTACLE1_TOP_X
    
    movem.l (sp)+,ALL_REG   
    rts

nextObstacleGenerator1:

    movem.l ALL_REG,-(sp)
    
    move.l  INVAL1_TOP_Y,d1

    cmpi.l  #OBSTACLE_START_TOP_Y+30,d1
    bgt     startNextObstacle1

returnObstacleGenerator1:
    movem.l (sp)+,ALL_REG   
    rts
    
    
    
incrementGapCounter2:
    addi.l  #1,d1
    move.l  d1,INVAL2_TOP_X
    
    movem.l (sp)+,ALL_REG
    rts
     
gapGenerator2:
    
    movem.l ALL_REG,-(sp)
    
    move.l  GENERATE_GAP_COUNTER_BIG,d0
    move.l  d0,d1
    asr.l   #6,d1
    asr.l   #2,d1

    cmpi.l  #1,d1
    beq     generateGap2
    
    addi.l  #1,d0
    move.l  d0,GENERATE_GAP_COUNTER_BIG
    movem.l (sp)+,ALL_REG
    rts

generateGap2:
    
    move.l  #0,GENERATE_GAP_COUNTER_BIG
   
    move.l  INVAL2_TOP_X,d1
    cmpi.l  #OBSTACLE_START_TOP_X,d1
    beq     incrementGapCounter2
    
    movem.l (sp)+,ALL_REG
    rts
    
startNextObstacle2:
    move.l  OBSTACLE2_TOP_X,d1
    move.l  d1,d2
    
    cmpi.l  #OBSTACLE_START_TOP_X,d2
    bne     returnObstacleGenerator2
    
    addi.l  #1,d1
    move.l  d1,OBSTACLE2_TOP_X
    
    movem.l (sp)+,ALL_REG   
    rts

nextObstacleGenerator2:

    movem.l ALL_REG,-(sp)
    
    move.l  INVAL2_TOP_Y,d1

    cmpi.l  #OBSTACLE_START_TOP_Y+30,d1
    bgt     startNextObstacle2

returnObstacleGenerator2:
    movem.l (sp)+,ALL_REG   
    rts
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
