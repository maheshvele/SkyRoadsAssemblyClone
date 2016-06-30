 *-----------------------------------------------------------
* Title      : RenderPlayer
* Written by : Mahesh Velegonda
* Date       : 10/4/2014
* Description: Code to Render player is taken care here
*-----------------------------------------------------------

renderObstacle1   
        movem.l ALL_REG,-(sp)
        
        ;set pen color
        move.l  #$00000000,d1
        move.b  #80,d0
        trap    #15
                     
        ;set fill color
        move.l  #$0000FF00,d1
        move.b  #81,d0
        trap    #15
        
        move.l   OBSTACLE1_TOP_X,d1
        move.l   OBSTACLE1_TOP_Y,d2
        move.l   OBSTACLE1_BOTTOM_X,d3
        move.l   OBSTACLE1_BOTTOM_Y,d4
        
        move.l  #DRAW_FILLED_RECTANGLE_TRAP,d0
        trap    #15
        
        move.b #DUMP_SCREEN_BUFFER,d0
        trap   #15
        
        movem.l (sp)+,ALL_REG
        rts
        
renderObstacle2   
        movem.l ALL_REG,-(sp)
        
        ;set pen color
        move.l  #$00000000,d1
        move.b  #80,d0
        trap    #15
                     
        ;set fill color
        move.l  #$0000FF00,d1
        move.b  #81,d0
        trap    #15
        
        move.l   OBSTACLE2_TOP_X,d1
        move.l   OBSTACLE2_TOP_Y,d2
        move.l   OBSTACLE2_BOTTOM_X,d3
        move.l   OBSTACLE2_BOTTOM_Y,d4
        
        move.l  #DRAW_FILLED_RECTANGLE_TRAP,d0
        trap    #15
        
        move.b #DUMP_SCREEN_BUFFER,d0
        trap   #15
        
        movem.l (sp)+,ALL_REG
        rts
        
invalidateObstacle1:

    lea BackGroundImage,a0
    
    movem.l ALL_REG,-(sp)
    
    move.l  #0,(SCREEN_OFFSET_X)
    move.l  #0,(SCREEN_OFFSET_Y)
    
    move.l  INVAL1_TOP_X,d1
    move.l  INVAL1_TOP_Y,d2
        
    move.l  d1,(IMAGE_START_X)
    move.l  d2,(IMAGE_START_Y)
        
    move.l  INVAL1_BOTTOM_X,d1
    move.l  INVAL1_BOTTOM_Y,d2
    
    move.l  d1,(IMAGE_END_X)
    move.l  d2,(IMAGE_END_Y)
    
    jsr     renderImage
    
    move.b #DUMP_SCREEN_BUFFER,d0
    trap   #15
   
    movem.l (sp)+,ALL_REG
    rts
    
invalidateObstacle2:

    lea BackGroundImage,a0
    
    movem.l ALL_REG,-(sp)
    
    move.l  #0,(SCREEN_OFFSET_X)
    move.l  #0,(SCREEN_OFFSET_Y)
    
    move.l  INVAL2_TOP_X,d1
    move.l  INVAL2_TOP_Y,d2
        
    move.l  d1,(IMAGE_START_X)
    move.l  d2,(IMAGE_START_Y)
        
    move.l  INVAL2_BOTTOM_X,d1
    move.l  INVAL2_BOTTOM_Y,d2
    
    move.l  d1,(IMAGE_END_X)
    move.l  d2,(IMAGE_END_Y)
    
    jsr     renderImage
    
    move.b #DUMP_SCREEN_BUFFER,d0
    trap   #15
               
    movem.l (sp)+,ALL_REG
    rts

    
           


































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
