*-----------------------------------------------------------
* Title      : sevenSegmentDisplay
* Written by : Mahesh Velegonda
* Date       : 10/2/2014
* Description: This file reads the score as a number
*              and displays it in the seven segment 
*              display format
*-----------------------------------------------------------

updateScoreNow:
        move.l  #0,SCORE_COUNTER
        move.l  ACTUAL_SCORE,d1
        addi.l  #1,d1
        move.l  d1,ACTUAL_SCORE
        
        ;wipe out previous score
        jsr wipeOutPrevScore
        
        move.l  d1,d2
        divu    #10,d2
        move.l  d2,d3
        
        asr.l   #8,d3
        asr.l   #8,d3
        
        move.l  d3,-(sp)
        move.l  #SCORE_ONES_LOCATION_X,-(sp)
        jsr displayScore
        add #8,sp

        swap    d2
        asr.l   #8,d2
        asr.l   #8,d2
 
        divu    #10,d2
        move.l  d2,d3  

        asr.l   #8,d3
        asr.l   #8,d3

        move.l  d3,-(sp)
        move.l  #SCORE_TENS_LOCATION_X,-(sp)
        jsr displayScore
        add #8,sp
        
        swap    d2
        asr.l   #8,d2
        asr.l   #8,d2
        
        divu    #10,d2
        move.l  d2,d3
        
        asr.l   #8,d3
        asr.l   #8,d3
        
        move.l  d3,-(sp)
        move.l  #SCORE_HUNDREDS_LOCATION_X,-(sp)
        jsr     displayScore
        add     #8,sp
        
        swap    d2
        asr.l   #8,d2
        asr.l   #8,d2
        
        divu    #10,d2
        move.l  d2,d3
        
        asr.l   #8,d3
        asr.l   #8,d3
        
        move.l  d3,-(sp)
        move.l  #SCORE_THOUSANDS_LOCATION_X,-(sp)
        jsr     displayScore
        add     #8,sp
        
        movem.l (sp)+,ALL_REG
        rts


updateScore:
        movem.l ALL_REG,-(sp)
        
        move.l  SCORE_COUNTER,d1
        addi.l  #1,d1
        move.l  d1,SCORE_COUNTER
        
        move.l  d1,d2
        asr.l   #8,d2
        ;asr.l   #4,d2
        
        cmpi.l  #1,d2
        beq     updateScoreNow
               
        movem.l (sp)+,ALL_REG
        rts


displayScore
        movem.l ALL_REG,-(sp)
                
        move.l          68(sp),d1
        move.l          64(sp),d7
        
      ;load effective address off the seven segment display table      
        lea SEVEN_SEGMENT_TABLE, a1
        move.b          (a1,d1),d5
        
        ; set pen color
        move.l #SEGMENT_COLOR,d1
        move.l #PEN_COLOR_TRAP_CODE,d0
        trap #15
                
        ;and with the appropriate segment and draw the seven segment display
        move.b          d5,d6
        andi.b          #$40,d6
        bne             drawSegmentA

continueA:        
        move.b          d5,d6
        andi.b          #$20,d6
        bne             drawSegmentB

continueB:   
        move.b          d5,d6
        andi.b          #$10,d6
        bne             drawSegmentC

continueC:       
        move.b          d5,d6
        andi.b          #$8,d6
        bne             drawSegmentD

continueD:               
        move.b          d5,d6
        andi.b          #$4,d6
        bne             drawSegmentE

continueE:       
        move.b          d5,d6
        andi.b          #$2,d6
        bne             drawSegmentF

continueF:       
        move.b          d5,d6
        andi.b          #$1,d6
        bne             drawSegmentG
       
continueG:
        
         move.b #DUMP_SCREEN_BUFFER,d0
         trap   #15
    

        movem.l (sp)+,ALL_REG
        rts

drawSegmentA:
        
        move.w  d7,d1
        move.w #SCORE_DISPLAY_LOCATION_Y,d2
        
        move.w  d7,d0
        addi.w  #SEGMENT_SIZE,d0
        move.w  d0,d3
        move.w #SCORE_DISPLAY_LOCATION_Y,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueA
        
drawSegmentB:
        move.w d7,d0
        addi.w  #SEGMENT_SIZE,d0
        move.w  d0,d1
        move.w  #SCORE_DISPLAY_LOCATION_Y,d2
        
        move.w  d7,d0
        addi.w  #SEGMENT_SIZE,d0
        move.w  d0,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueB

drawSegmentC:
        move.w  d7,d0
        addi.w  #SEGMENT_SIZE,d0
        move.w  d0,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d2
        
        ;move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d3
        move.w  d7,d0
        addi.w  #SEGMENT_SIZE,d0
        move.w  d0,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueC

drawSegmentD:
       ; move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d1
        move.w   d7,d0
        addi.w    #SEGMENT_SIZE,d0
        move.w    d0,d1
        move.w  #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d2
        
        move.w  d7,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueD

drawSegmentE:
        move.w d7,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d2
        
        move.w d7,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueE

drawSegmentF:
        move.w d7,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d2
        
        move.w d7,d3
        move.w #SCORE_DISPLAY_LOCATION_Y,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueF

drawSegmentG:
        move.w d7,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d2
        
        move.w  d7,d0
        addi.w  #SEGMENT_SIZE,d0
        move.w  d0,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueG





wipeOutPrevScore:
        movem.l ALL_REG,-(sp)
        
        ; a filled rectange in the score area
        move.l  #$00353E44,d2
                
        move.l  d2,d1
        move.b  #80,d0
        trap    #15
        
        move.l  d2,d1
        move.l  #81,d0
        trap    #15
        
        move.l  #130,d1
        move.l  #705,d2
        move.l  #250,d3
        move.l  #740,d4
        
        move.l  #DRAW_FILLED_RECTANGLE_TRAP,d0
        trap    #15
        
        move.b #DUMP_SCREEN_BUFFER,d0
        trap   #15
                
        movem.l (sp)+,ALL_REG
        rts







































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
