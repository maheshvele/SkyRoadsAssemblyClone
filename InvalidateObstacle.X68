 *-----------------------------------------------------------
* Title      : MoveObstacle
* Written by : Mahesh Velegonda
* Date       : 10/4/2014
* Description: Code to Move the player is taken care here
*-----------------------------------------------------------
initializeInval1:
        move.l #OBSTACLE_START_TOP_X,INVAL1_TOP_X   
        move.l #OBSTACLE_START_TOP_Y,INVAL1_TOP_Y      
        move.l #OBSTACLE_START_BOTTOM_X,INVAL1_BOTTOM_X  
        move.l #OBSTACLE_START_TOP_Y+2,INVAL1_BOTTOM_Y 
        
        ;jsr renderInval1
        jsr invalidateObstacle1
   
         movem.l (sp)+,ALL_REG
         rts
 
 ;Draw Obstacle for the index
 
updateInval1:
    movem.l     ALL_REG,-(sp)
    
    ; check if we need to draw this obstacle
    
    move.l  INVAL1_TOP_X,d1
    cmpi.l  #OBSTACLE_START_TOP_X,d1
    bne     continueInvalUpdate1
    
    movem.l (sp)+,ALL_REG
    rts
    
continueInvalUpdate1:
    move.l  INVAL1_COUNTER,d1
    move.l  d1,d2
    asr.l   #OBSTACLE_SPEED_FRACTION,d2
    
    cmpi.l  #1,d2
    beq     moveInval1
    addi.l  #1,d1
    move.l  d1,INVAL1_COUNTER
    
    movem.l (sp)+,ALL_REG
    rts
    
moveInval1:
 
   move.l   #0,INVAL1_COUNTER
   
   move.l   INVAL1_TOP_X,d1
   move.l   INVAL1_TOP_Y,d2
   move.l   INVAL1_BOTTOM_X,d3
   move.l   INVAL1_BOTTOM_Y,d4
   
   ;Introduce Randomness here
   
   subi.l   #2,d1
   addi.l   #2,d2
   addi.l   #2,d3
   addi.l   #2,d4
   
   ; update the positions in the memory 
   move.l   d1,INVAL1_TOP_X
   move.l   d2,INVAL1_TOP_Y
   move.l   d3,INVAL1_BOTTOM_X
   move.l   d4,INVAL1_BOTTOM_Y
   
   cmpi.l   #GROUND+60,d4
   bgt      initializeInval1
   
   jsr  invalidateObstacle1  
   movem.l (sp)+,ALL_REG
   rts

 *-----------------------------------------------------------
* Title      : MoveObstacle
* Written by : Mahesh Velegonda
* Date       : 10/4/2014
* Description: Code to Move the player is taken care here
*-----------------------------------------------------------
 initializeInval2:
        move.l #OBSTACLE_START_TOP_X,INVAL2_TOP_X   
        move.l #OBSTACLE_START_TOP_Y,INVAL2_TOP_Y      
        move.l #OBSTACLE_START_BOTTOM_X,INVAL2_BOTTOM_X  
        move.l #OBSTACLE_START_TOP_Y+2,INVAL2_BOTTOM_Y 
        
        ;jsr renderInval2
         jsr  invalidateObstacle2
   
         movem.l (sp)+,ALL_REG
         rts
 
 ;Draw Obstacle for the index
 
updateInval2:
    movem.l     ALL_REG,-(sp)
    
    ; check if we need to draw this obstacle
    
    move.l  INVAL2_TOP_X,d1
    cmpi.l  #OBSTACLE_START_TOP_X,d1
    bne     continueInvalUpdate2
    
    movem.l (sp)+,ALL_REG
    rts
    
continueInvalUpdate2:
    move.l  INVAL2_COUNTER,d1
    move.l  d1,d2
    asr.l   #OBSTACLE_SPEED_FRACTION,d2
    
    cmpi.l  #1,d2
    beq     moveInval2
    addi.l  #1,d1
    move.l  d1,INVAL2_COUNTER
    
    movem.l (sp)+,ALL_REG
    rts
    
moveInval2:
 
   move.l   #0,INVAL2_COUNTER
   
   move.l   INVAL2_TOP_X,d1
   move.l   INVAL2_TOP_Y,d2
   move.l   INVAL2_BOTTOM_X,d3
   move.l   INVAL2_BOTTOM_Y,d4
   
   ;Introduce Randomness here
   
   subi.l   #2,d1
   addi.l   #2,d2
   addi.l   #2,d3
   addi.l   #2,d4
   
   ; update the positions in the memory 
   move.l   d1,INVAL2_TOP_X
   move.l   d2,INVAL2_TOP_Y
   move.l   d3,INVAL2_BOTTOM_X
   move.l   d4,INVAL2_BOTTOM_Y
   
   cmpi.l   #GROUND+60,d4
   bgt      initializeInval2
   
  jsr  invalidateObstacle2 
  
   movem.l (sp)+,ALL_REG
   rts
    
    
    
    
    
     
















































































    
    
    
    
    
     



























































































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
