*-----------------------------------------------------------
* Title      : InputHandler
* Written by : Mahesh Velegonda
* Date       : 10/2/2014
* Description: This file has the code that handles input 
*-----------------------------------------------------------


GET_USER_INPUT_COMMAND   EQU     19

KEY_LEFT_INPUT           EQU     $25

KEY_RIGHT_INPUT          EQU     $27

KEY_SPACE_INPUT          EQU     $20

KEY_UP_INPUT             EQU    $26
    
        
handleInput

        movem.l ALL_REG,-(sp)
      
        move.l  #$26202725,d1
        move.b  #GET_USER_INPUT_COMMAND,d0
        TRAP    #15
        
        andi.b  #$FF,d1
        bne     handleLeftInput
        move.l  #0,LEFT_KEY_COUNTER
        move.b  #1,LEFT_NOT_PRESSED

continueLeftInput:    
    
        asr.l   #8,d1
        andi.b  #$FF,d1
        bne     handleRightInput
        move.l  #0,RIGHT_KEY_COUNTER
        move.b  #1,RIGHT_NOT_PRESSED

continueRightInput:
        
        asr.l   #8,d1
        andi.b  #$FF,d1
        bne     handleSpaceInput
       ; move.l  #0,LEFT_KEY_COUNTER
        move.b  #1,SPACE_NOT_PRESSED
        
continueSpaceInput:
        asr.l   #8,d1
        andi.b  #$FF,d1
        bne     handleUpInput
        move.b  #1,UP_NOT_PRESSED
        

aroundNoInput:

        movem.l (sp)+,ALL_REG
        rts

incrementLeftCounter:
        move.l  LEFT_KEY_COUNTER,d2
        addi.l  #PLAYER_SPEED,d2
        move.l  d2,LEFT_KEY_COUNTER
        
        bra     continueLeftInput
     
*        movem.l (sp)+,ALL_REG
*        rts
        
incrementRightCounter:
        move.l  RIGHT_KEY_COUNTER,d2
        addi.l  #PLAYER_SPEED,d2
        move.l  d2,RIGHT_KEY_COUNTER
        
        bra continueRightInput
        
*        movem.l (sp)+,ALL_REG
*        rts
        
handleLeftInput:
    move.b  LEFT_NOT_PRESSED,d0
    beq     incrementLeftCounter
    
    move.b  #0,LEFT_NOT_PRESSED
    move.l  LEFT_KEY_COUNTER,d2
    addi.l  #PLAYER_SPEED,d2
    move.l  d2,LEFT_KEY_COUNTER
    
    bra continueLeftInput             
*    movem.l (sp)+,ALL_REG
*    rts

handleRightInput:
    move.b  RIGHT_NOT_PRESSED,d0
    beq     incrementRightCounter
    
    move.b  #0,RIGHT_NOT_PRESSED
    move.l  RIGHT_KEY_COUNTER,d2
    addi.l  #PLAYER_SPEED,d2
    move.l  d2,RIGHT_KEY_COUNTER
    
    bra continueRightInput
    
*    movem.l (sp)+,ALL_REG
*    rts

handleSpaceInput:
    move.b  SPACE_NOT_PRESSED,d0
    beq     continueSpaceInput
       
    move.l  IN_AIR,d5
    cmpi.l  #1,d5
    beq     continueSpaceInput
       
    move.b  #0,SPACE_NOT_PRESSED 
    move.l  #JUMP_MAGNITUDE,d4
    move.l  d4,PREVIOUS_SPEED
    move.l  #1,IN_AIR
    bra continueSpaceInput
    

handleUpInput:
    move.b  UP_NOT_PRESSED,d0
    beq     aroundNoInput
    
    move.b  #0,UP_NOT_PRESSED

    
    movem.l (sp)+,ALL_REG
    rts























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
