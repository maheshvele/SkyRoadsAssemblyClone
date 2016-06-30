 *-----------------------------------------------------------
* Title      : MoveObstacle
* Written by : Mahesh Velegonda
* Date       : 10/4/2014
* Description: Code to Move the player is taken care here
*-----------------------------------------------------------
initializeObstacle1:
        move.l #OBSTACLE_START_TOP_X,OBSTACLE1_TOP_X   
        move.l #OBSTACLE_START_TOP_Y,OBSTACLE1_TOP_Y      
        move.l #OBSTACLE_START_BOTTOM_X,OBSTACLE1_BOTTOM_X  
        move.l #OBSTACLE_START_BOTTOM_Y,OBSTACLE1_BOTTOM_Y 
        
        ;jsr renderObstacle1
   
         movem.l (sp)+,ALL_REG
         rts
 
 ;Draw Obstacle for the index
 
updateObstacle1:
    movem.l     ALL_REG,-(sp)
    
    ; check if we need to draw this obstacle
    
    move.l  OBSTACLE1_TOP_X,d1
    cmpi.l  #OBSTACLE_START_TOP_X,d1
    bne     continueUpdate1
    
    movem.l (sp)+,ALL_REG
    rts
    
continueUpdate1:
    move.l  OBSTACLE1_COUNTER,d1
    move.l  d1,d2
    asr.l   #OBSTACLE_SPEED_FRACTION,d2
    
    cmpi.l  #1,d2
    beq     moveObstacle1
    addi.l  #1,d1
    move.l  d1,OBSTACLE1_COUNTER
    
    movem.l (sp)+,ALL_REG
    rts
    
moveObstacle1:
 
   move.l   #0,OBSTACLE1_COUNTER
   
   move.l   OBSTACLE1_TOP_X,d1
   move.l   OBSTACLE1_TOP_Y,d2
   move.l   OBSTACLE1_BOTTOM_X,d3
   move.l   OBSTACLE1_BOTTOM_Y,d4
   
   ;Introduce Randomness here
   
   subi.l   #2,d1
   addi.l   #2,d2
   addi.l   #2,d3
   addi.l   #2,d4
   
   ; update the positions in the memory 
   move.l   d1,OBSTACLE1_TOP_X
   move.l   d2,OBSTACLE1_TOP_Y
   move.l   d3,OBSTACLE1_BOTTOM_X
   move.l   d4,OBSTACLE1_BOTTOM_Y
   
   cmpi.l   #GROUND+60,d4
   bgt      initializeObstacle1
   
   jsr renderObstacle1
  
   movem.l (sp)+,ALL_REG
   rts

*-----------------------------------------------------------
*-----------------------------------------------------------
 initializeObstacle2:
        move.l #OBSTACLE_START_TOP_X,OBSTACLE2_TOP_X   
        move.l #OBSTACLE_START_TOP_Y,OBSTACLE2_TOP_Y      
        move.l #OBSTACLE_START_BOTTOM_X,OBSTACLE2_BOTTOM_X  
        move.l #OBSTACLE_START_BOTTOM_Y,OBSTACLE2_BOTTOM_Y 
        
        ;jsr renderObstacle2
   
         movem.l (sp)+,ALL_REG
         rts
 
 ;Draw Obstacle for the index
 
updateObstacle2:
    movem.l     ALL_REG,-(sp)
    
    ; check if we need to draw this obstacle
    
    move.l  OBSTACLE2_TOP_X,d1
    cmpi.l  #OBSTACLE_START_TOP_X,d1
    bne     continueUpdate2
    
    movem.l (sp)+,ALL_REG
    rts
    
continueUpdate2:
    move.l  OBSTACLE2_COUNTER,d1
    move.l  d1,d2
    asr.l   #OBSTACLE_SPEED_FRACTION,d2
    
    cmpi.l  #1,d2
    beq     moveObstacle2
    addi.l  #1,d1
    move.l  d1,OBSTACLE2_COUNTER
    
    movem.l (sp)+,ALL_REG
    rts
    
moveObstacle2:
 
   move.l   #0,OBSTACLE2_COUNTER
   
   move.l   OBSTACLE2_TOP_X,d1
   move.l   OBSTACLE2_TOP_Y,d2
   move.l   OBSTACLE2_BOTTOM_X,d3
   move.l   OBSTACLE2_BOTTOM_Y,d4
   
   ;Introduce Randomness here
   
   subi.l   #2,d1
   addi.l   #2,d2
   addi.l   #2,d3
   addi.l   #2,d4
   
   ; update the positions in the memory 
   move.l   d1,OBSTACLE2_TOP_X
   move.l   d2,OBSTACLE2_TOP_Y
   move.l   d3,OBSTACLE2_BOTTOM_X
   move.l   d4,OBSTACLE2_BOTTOM_Y
   
   cmpi.l   #GROUND+60,d4
   bgt      initializeObstacle2
   
   jsr renderObstacle2
  
   movem.l (sp)+,ALL_REG
   rts
    
    
    
    
    
     
















































































    
    
    
    
    
     


















































































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
