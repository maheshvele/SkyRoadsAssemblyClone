ALL_REG                 REG     D0-D7/A0-A6
PRINT_STRING_NO_CR      EQU     14
PRINT_NUMBER            EQU     3
KILL_PROGRAM            EQU     9
MOVE_LINE_TRAP          EQU     84

BLACK         EQU          $00000000
RED           EQU          $000000FF
GREEN         EQU          $0000FF00
BLUE          EQU          $00FF0000
WHITE         EQU          $00FFFFFF     

SEGMENT_SIZE            EQU     10
SEGMENT_COLOR           EQU     WHITE

SCORE_DISPLAY_LOCATION_X    EQU    500
SCORE_DISPLAY_LOCATION_Y    EQU   500

SCREEN_WIDTH        EQU     1024
SCREEN_HEIGHT       EQU     768

SET_SCREEN_RESOLUTION_TRAP_CODE EQU     33
PEN_COLOR_TRAP_CODE             EQU     80

renderScore
        movem.l ALL_REG,-(sp)
                
        move.l          64(sp),d1
        
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
        movem.l (sp)+,ALL_REG
        rts


drawSegmentA:
        move.w #SCORE_DISPLAY_LOCATION_X,d1
        move.w #SCORE_DISPLAY_LOCATION_Y,d2
        
        move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d3
        move.w #SCORE_DISPLAY_LOCATION_Y,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueA
        
drawSegmentB:
         move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d1
        move.w  #SCORE_DISPLAY_LOCATION_Y,d2
        
        move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueB

drawSegmentC:
        move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d2
        
        move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueC

drawSegmentD:
         move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d1
        move.w  #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d2
        
        move.w #SCORE_DISPLAY_LOCATION_X,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueD

drawSegmentE:
        move.w #SCORE_DISPLAY_LOCATION_X,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+2*SEGMENT_SIZE,d2
        
        move.w #SCORE_DISPLAY_LOCATION_X,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueE

drawSegmentF:
        move.w #SCORE_DISPLAY_LOCATION_X,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d2
        
        move.w #SCORE_DISPLAY_LOCATION_X,d3
        move.w #SCORE_DISPLAY_LOCATION_Y,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueF

drawSegmentG:
        move.w #SCORE_DISPLAY_LOCATION_X,d1
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d2
        
        move.w #SCORE_DISPLAY_LOCATION_X+SEGMENT_SIZE,d3
        move.w #SCORE_DISPLAY_LOCATION_Y+SEGMENT_SIZE,d4
        
        move.l  #MOVE_LINE_TRAP,d0
        trap    #15              
        bra continueG

START   ORG $1000
        
        move.b  #SET_SCREEN_RESOLUTION_TRAP_CODE,D0
        move.l  #SCREEN_WIDTH,d1
        swap.w  d1
        move.w  #SCREEN_HEIGHT,d1
        
        TRAP    #15

        move.l  #0,-(sp)
        jsr renderScore
        
*        move.l  #1,-(sp)
*        jsr renderScore
*        
*         move.l  #2,-(sp)
*        jsr renderScore
*        
*        move.l  #3,-(sp)
*        jsr renderScore
*        
*         move.l  #4,-(sp)
*        jsr renderScore
*        
*        move.l  #5,-(sp)
*        jsr renderScore
*        
*         move.l  #6,-(sp)
*        jsr renderScore
*        
*        move.l  #7,-(sp)
*        jsr renderScore
*        
*         move.l  #8,-(sp)
*        jsr renderScore
*        
*        move.l  #9,-(sp)
*        jsr renderScore

        move.l  #KILL_PROGRAM,d0
        TRAP    #15

        STOP #$2000

TheSumOfString:
        dc.b 'The Sum of ',0

AndString:
        dc.b ' and ',0

EqualsString:
        dc.b ' equals ',0

CarraigeReturnString:
        dc.b $0a,$0d,0
        
SEVEN_SEGMENT_TABLE    dc.b   $7E,$30,$6D,$79,$33,$5B,$5F,$70,$7F,$7B


        END START







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
