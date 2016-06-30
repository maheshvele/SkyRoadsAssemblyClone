 *-----------------------------------------------------------
* Title      : RenderPlayer
* Written by : Mahesh Velegonda
* Date       : 10/4/2014
* Description: Code to Move the player is taken care here
*-----------------------------------------------------------

************** HORIZONTAL MOVEMENT **************************
moveLeft:

    move.l  #0,LEFT_KEY_COUNTER
    subi.l  #1,d1
    blt     continueLeft
    jsr  invalidatePlayer
    move.l  d1,PLAYER_POSITION_X
    bra     continueLeft
    
    
moveRight:
    move.l  #0,RIGHT_KEY_COUNTER
    addi.l  #1,d1
    move.l  d1,d3
    addi.l  #PLAYER_WIDTH,d3
    cmpi.l  #SCREEN_WIDTH,d3    
    bgt     continueRight
    jsr invalidatePlayer
    move.l  d1,PLAYER_POSITION_X
    bra     continueRight

resetYDelta:
    move.l  #0,YDELTA
    movem.l (sp)+,ALL_REG
    rts  

updatePlayerPosition   
    movem.l ALL_REG,-(sp)
    
    move.l  PLAYER_POSITION_X,d1
    move.l  LEFT_KEY_COUNTER,d2
    asr.l   #2,d2 
;
    cmpi.l  #1,d2
    beq     moveLeft
   
continueLeft:

    move.l  PLAYER_POSITION_X,d1
    move.l  RIGHT_KEY_COUNTER,d2
    asr.l   #2,d2
    
    cmpi.l  #1,d2
    beq     moveRight

continueRight:        
   
**************** VERTICAL MOVEMENT **************************  
gravityStart:
    
    clr.l   d1
    clr.l   d2
    clr.l   d3
    
    ; Update the velocity and displacement only in specific 
    ; intervals
    
    move.l  YDELTA_COUNTER,d1
    move.l  d1,d2
    asr.l   #4,d2
    
    cmpi.l  #1,d2
    beq     updateYDelta
    addi.l  #1,d1
    move.l  d1,YDELTA_COUNTER
    
    movem.l (sp)+,ALL_REG
    rts

    
updateYDelta:  
   move.l   #0,YDELTA
   move.l   #0,YDELTA_COUNTER
   ; move.l  CURRENT_SPEED,d1
    move.l  PREVIOUS_SPEED,d2    
    move.l  #GRAVITY,d3
    
    ; Update the currentspeed
    move.l  d2,d1
    sub.l   d3,d1
    move.l  d1,CURRENT_SPEED
    
    ; Update the displacement
    add.l   d1,d2
    asr.l   #1,d2
    move.l  d2,YDELTA
    
    ;Update the previous speed
    move.l  d1,PREVIOUS_SPEED
    
    move.l  PLAYER_POSITION_Y,d1
  ;  asr.l   #8,d2
    sub.l   d2,d1
    
    cmpi.l  #GROUND,d1
    bgt     continueYDelta
    jsr     invalidatePlayer
    move.l  d1,PLAYER_POSITION_Y

continueYDelta:
    ;cmpi.l  #1,d2
   ; bge     resetYDelta 
   move.l   #0,IN_AIR
    movem.l (sp)+,ALL_REG
    rts
    


























































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
