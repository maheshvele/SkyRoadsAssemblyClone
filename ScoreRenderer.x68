*-----------------------------------------------------------
* Title      : sevenSegmentDisplay
* Written by : Mahesh Velegonda
* Date       : 10/2/2014
* Description: This file reads the score as a number
*              and displays it in the seven segment 
*              display format
*-----------------------------------------------------------

renderScore
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
                
        ;and with the appropriate segment and draw1 the seven segment display
        move.b          d5,d6
        andi.b          #$40,d6
        bne             draw1SegmentA

continue1A:        
        move.b          d5,d6
        andi.b          #$20,d6
        bne             draw1SegmentB

continue1B:   
        move.b          d5,d6
        andi.b          #$10,d6
        bne             draw1SegmentC

continue1C:       
        move.b          d5,d6
        andi.b          #$8,d6
        bne             draw1SegmentD

continue1D:               
        move.b          d5,d6
        andi.b          #$4,d6
        bne             draw1SegmentE

continue1E:       
        move.b          d5,d6
        andi.b          #$2,d6
        bne             draw1SegmentF

continue1F:       
        move.b          d5,d6
        andi.b          #$1,d6
        bne             draw1SegmentG
       
continue1G:
        
         move.b #DUMP_SCREEN_BUFFER,d0
         trap   #15
    

        movem.l (sp)+,ALL_REG
        rts

draw1SegmentA:
        
        move.w  d7,d1
        move.w #SCORE_DISPLAY_LOCATION_Y,d2
        
        move.w  d7,d0
        addi.w  #SEGMENT_SIZE,d0
        move.w  d0,d3
        move.w #SCORE_DISPLAY_LOCATION_Y,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continue1A
        
draw1SegmentB:
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
        bra continue1B

draw1SegmentC:
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
        bra continue1C

draw1SegmentD:
       ; move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d1
        move.w   d7,d0
        addi.w    #SEGMENT_SIZE,d0
        move.w    d0,d1
        move.w  #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d2
        
        move.w  d7,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continue1D

draw1SegmentE:
        move.w d7,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d2
        
        move.w d7,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continue1E

draw1SegmentF:
        move.w d7,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d2
        
        move.w d7,d3
        move.w #SCORE_DISPLAY_LOCATION_Y,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continue1F

draw1SegmentG:
        move.w d7,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d2
        
        move.w  d7,d0
        addi.w  #SEGMENT_SIZE,d0
        move.w  d0,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continue1G















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
