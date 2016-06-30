 *-----------------------------------------------------------
* Title      : RenderPlayer
* Written by : Mahesh Velegonda
* Date       : 10/4/2014
* Description: Code to Render player is taken care here
*-----------------------------------------------------------

; Render Player Stationary

renderPlayer   
    movem.l ALL_REG,-(sp)
    
  
    
    move.l  #SET_PEN_COLOR_TRAP,d0
    move.l  #$000000FF,d1
    trap    #15
    
    move.l  #SET_FILL_COLOR_TRAP,d0
    move.l  PLAYER_FILL_COLOR,d1
    trap    #15
    
    move.l  (PLAYER_POSITION_X),d1
    move.l  (PLAYER_POSITION_Y),d2
    move.l  (PLAYER_POSITION_X),d3
    addi.l  #PLAYER_WIDTH,d3
    move.l  (PLAYER_POSITION_Y),d4
    addi.l  #PLAYER_HEIGHT,d4

    move.l  #DRAW_FILLED_RECTANGLE_TRAP,d0
    trap    #15
    
    move.b #DUMP_SCREEN_BUFFER,d0
    trap   #15
    
    movem.l (sp)+,ALL_REG
    rts
*
invalidatePlayer:
    movem.l ALL_REG, -(sp)
    
    
    lea BackGroundImage2,a0
    
    move.l  #0,(SCREEN_OFFSET_X)
    move.l  #0,(SCREEN_OFFSET_Y)
    
    move.l  PLAYER_POSITION_X,d1
    move.l  PLAYER_POSITION_Y,d2
        
    move.l  d1,(IMAGE_START_X)
    move.l  d2,(IMAGE_START_Y)
        
    addi.l  #PLAYER_WIDTH+2,d1
    addi.l  #PLAYER_HEIGHT+2,d2
    
    move.l  d1,(IMAGE_END_X)
    move.l  d2,(IMAGE_END_Y)
    
    jsr     renderImage
    
    move.b #DUMP_SCREEN_BUFFER,d0
    trap   #15
   
    movem.l (sp)+,ALL_REG
    rts

    
; Render Player Jump

; Render Player Left

; Render Player Right





























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
