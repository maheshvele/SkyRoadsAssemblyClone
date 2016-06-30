*-----------------------------------------------------------
* Title      : Game Variables
* Written by : Mahesh Velegonda
* Date       : 10/2/2014
* Description: This file contains all the variables used in the game
*-----------------------------------------------------------
;Initialize Player Position

initializeGame:
    movem.l ALL_REG,-(sp)
    
    move.l #OBSTACLE_START_TOP_X+1,OBSTACLE1_TOP_X 
    
    move.l  #500,(PLAYER_POSITION_X)
    move.l  #600,(PLAYER_POSITION_Y)

resetLoop:  
        jsr     updateObstacle1
        
        move.l  RESET_TIMER,d0
        addi.l  #1,d0
        move.l  d0,RESET_TIMER
        
        move.l  d0,d1
        asr.l   #8,d1
        asr.l   #8,d1
        
        cmpi.l  #1,d1 
        bne     resetLoop
        move.l  #0,RESET_TIMER
        
        
    movem.l (sp)+,ALL_REG
    rts





















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
