*-----------------------------------------------------------*
* Title      : RenderPlayer                                 *
* Written by : Mahesh Velegonda                             *
* Date       : 10/4/2014                                    *
* Description: Code to Move the player is taken care here   *
*-----------------------------------------------------------*
continue1:

    cmpi.l  #GROUND,INVAL1_TOP_Y
    bgt     continue2
    
*    cmpi.l  #GROUND,INVAL2_TOP_Y
*    bgt     continue2
*    
    movem.l (sp)+,ALL_REG
    rts
    
continue2:
    cmpi.l  #GROUND,OBSTACLE1_BOTTOM_Y
    blt    continue3
    
*    cmpi.l  #GROUND,OBSTACLE2_BOTTOM_Y
*    blt    continue3
    
    movem.l (sp)+,ALL_REG
    rts   
    
continue3:

    move.l  COLLISION_COUNTER,d0
    addi.l  #1,d0
    move.l  d0,COLLISION_COUNTER
    
    move.l  d0,d1
    asr.l   #6,d1
    
    cmpi.l  #1,d1
    beq     continue4
    
    movem.l (sp)+,ALL_REG
    rts
    
continue5:
    movem.l (sp)+,ALL_REG
    rts
    
continue4:
    move.l  #0,COLLISION_COUNTER
        
    ; Player lost life
    move.l  PLAYER_LIVES,d5
    cmpi.l  #0,d5
    beq     continue5
    
    sub.l  #1,d5
    move.l  d5,PLAYER_LIVES
    
    ;resetGame
    
    wipeOutPrevLives:        
        ; a filled rectange in the score area
        move.l  #$00353E44,d2
                
        move.l  d2,d1
        move.b  #80,d0
        trap    #15
        
        move.l  d2,d1
        move.l  #81,d0
        trap    #15
        
        move.l  #910,d1
        move.l  #705,d2
        move.l  #940,d3
        move.l  #740,d4
        
        move.l  #DRAW_FILLED_RECTANGLE_TRAP,d0
        trap    #15
        
        move.b #DUMP_SCREEN_BUFFER,d0
        trap   #15
        
        move.l  d5,-(sp)
        move.l  #PLAYER_LIVES_LOCATION_X,-(sp)
        jsr     displayScore
        add     #8,sp
  
 initializeGame1:     
        move.l  #500,(PLAYER_POSITION_X)
        move.l  #500,(PLAYER_POSITION_Y)
        
        move.l  #0,LEFT_KEY_COUNTER
        move.l  #0,RIGHT_KEY_COUNTER
        move.l  #0,PREVIOUS_SPEED
        move.l  #0,YDELTA
        move.l  #0,OBSTACLE1_COUNTER
        move.l  #0,OBSTACLE2_COUNTER
        
        move.b  #1,LEFT_NOT_PRESSED  
        move.b  #1,RIGHT_NOT_PRESSED
        move.b  #1,SPACE_NOT_PRESSED
        move.b  #1,UP_NOT_PRESSED

        move.l #OBSTACLE_START_TOP_X+1,OBSTACLE1_TOP_X   
        move.l #OBSTACLE_START_TOP_Y,OBSTACLE1_TOP_Y      
        move.l #OBSTACLE_START_BOTTOM_X,OBSTACLE1_BOTTOM_X  
        move.l #OBSTACLE_START_BOTTOM_Y,OBSTACLE1_BOTTOM_Y 
        
        move.l #OBSTACLE_START_TOP_X,OBSTACLE2_TOP_X   
        move.l #OBSTACLE_START_TOP_Y,OBSTACLE2_TOP_Y      
        move.l #OBSTACLE_START_BOTTOM_X,OBSTACLE2_BOTTOM_X  
        move.l #OBSTACLE_START_BOTTOM_Y,OBSTACLE2_BOTTOM_Y 
        
        move.l #OBSTACLE_START_TOP_X,INVAL1_TOP_X   
        move.l #OBSTACLE_START_TOP_Y,INVAL1_TOP_Y      
        move.l #OBSTACLE_START_BOTTOM_X,INVAL1_BOTTOM_X  
        move.l #OBSTACLE_START_TOP_Y+2,INVAL1_BOTTOM_Y 

        move.l #OBSTACLE_START_TOP_X,INVAL2_TOP_X   
        move.l #OBSTACLE_START_TOP_Y,INVAL2_TOP_Y      
        move.l #OBSTACLE_START_BOTTOM_X,INVAL2_BOTTOM_X  
        move.l #OBSTACLE_START_TOP_Y+2,INVAL2_BOTTOM_Y 
        
        move.l #0,GENERATE_GAP_COUNTER_SMALL
        move.l #0,GENERATE_GAP_COUNTER_BIG
        move.l  #0,COLLISION_COUNTER
        move.l  #0,RESET_TIMER    
        
        jsr     getRandomLongIntoD6
        move.l  d6,d1
        andi.l   #$00FFFFFF,d1 
        move.l  d1,PLAYER_FILL_COLOR


resetLoop1:  
        jsr     updateObstacle1
        
        move.l  RESET_TIMER,d0
        addi.l  #1,d0
        move.l  d0,RESET_TIMER
        
        move.l  d0,d1
        asr.l   #8,d1
        asr.l   #8,d1
        asr.l   #4,d1
        
        cmpi.l  #1,d1 
        bne     resetLoop1
        move.l  #0,RESET_TIMER
                      
        movem.l (sp)+,ALL_REG
        rts

    
collisionDetection:
    
    movem.l ALL_REG,-(sp)
    
    move.l  PLAYER_POSITION_Y,d0
    cmpi.l  #GROUND,d0
    beq     continue1
    
    cmpi.l  #GROUND-1,d0
    beq     continue1
    
    cmpi.l  #GROUND-2,d0
    beq     continue1
    
    cmpi.l  #GROUND-3,d0
    beq     continue1
        
    cmpi.l  #GROUND-4,d0
    beq     continue1
    
    cmpi.l  #GROUND-5,d0
    beq     continue1
    
    cmpi.l  #GROUND-6,d0
    beq     continue1
    
    cmpi.l  #GROUND-7,d0
    beq     continue1
    
    cmpi.l  #GROUND-8,d0
    beq     continue1
    
    cmpi.l  #GROUND-9,d0
    beq     continue1
    
    movem.l (sp)+,ALL_REG
    rts
    
















































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
