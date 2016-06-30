*-----------------------------------------------------------
* Title      : Geometry Wars
* Written by : Mahesh Velegonda
* Date       : 10/2/2014
* Description: Geometry wars clone in Assembly.
*-----------------------------------------------------------
    ; first instruction of program

    INCLUDE     "GameVariables.x68"
    INCLUDE     "ScoreRenderer.x68"
    INCLUDE     "DrawBitmap.x68"
    INCLUDE     "InputHandler.x68"
    INCLUDE     "MovePlayer.x68"
    INCLUDE     "RenderPlayer.x68"
    INCLUDE     "MoveObstacle.x68"
    INCLUDE     "InvalidateObstacle.x68"
    INCLUDE     "RenderObstacle.x68"
    INCLUDE     "ObstacleGenerator.x68"
    INCLUDE     "UpdateScore.x68"
    INCLUDE     "CollisionDetection.x68"
    INCLUDE     "GetRandomVal.x68"
            
START  ORG    $1000

*        lea     SOUNDSTRING,a1
*        move.l  #0,d1
*        move.l  #0,d2
*        move.l  #73,d0
*        TRAP    #15
 
    *   set output screen resolution    
        move.b  #SET_SCREEN_RESOLUTION_TRAP_CODE,D0
        move.l  #SCREEN_WIDTH,d1
        swap.w  d1
        move.w  #SCREEN_HEIGHT,d1
        trap    #15
        
        *******************************************  
        
        move.l  #400,(SCREEN_OFFSET_X)
        move.l  #200,(SCREEN_OFFSET_Y)
        
        move.l  #0,(IMAGE_START_X)
        move.l  #0,(IMAGE_START_Y)
        
        move.l  #239,(IMAGE_END_X)
        move.l  #71,(IMAGE_END_Y)
        
        lea     LoadingImage,a0
        jsr     renderImage
                   
        *******************************************  
        
        move.l  #0,(SCREEN_OFFSET_X)
        move.l  #0,(SCREEN_OFFSET_Y)
        
        move.l  #0,(IMAGE_START_X)
        move.l  #0,(IMAGE_START_Y)
        
        move.l  #1024,(IMAGE_END_X)
        move.l  #768,(IMAGE_END_Y)

        
        lea     BackGroundImage,a0
        
        ; Draw the image in the second buffer
        move.b  #SET_SCREEN_BUFFER_MODE,d0
        move.l  #ENABLE_DOUBLE_BUFFER_MODE,d1
        trap    #15
                
        jsr renderImage

        *********************************************
        
        move.b  #DUMP_SCREEN_BUFFER,d0
        trap    #15
        
*        move.b  #SET_SCREEN_BUFFER_MODE,d0
*        move.l  #DISBALE_DOUBLE_BUFFER_MODE,d1
*        trap    #15
*                
        ;set pen color
        move.l  #$00ffffff,d1
        move.b  #80,d0
        trap    #15
        
        ;set fill color
        move.l  #$00AAAAAA,d1
        move.b  #81,d0
        trap    #15

;Initialize Player Position
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

        move.l #OBSTACLE_START_TOP_X,OBSTACLE1_TOP_X   
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
        
        move.l  #0,SCORE_COUNTER
        move.l  #0,ACTUAL_SCORE
        
        
        move.l  #5,PLAYER_LIVES
        move.l  #0,COLLISION_COUNTER
        move.l  #0,RESET_TIMER
        
        move.l  PLAYER_LIVES,d5
        move.l  d5,-(sp)
        move.l  #PLAYER_LIVES_LOCATION_X,-(sp)
        jsr     displayScore
        add     #8,sp
        
initializeGame:
    
    move.l #OBSTACLE_START_TOP_X+1,OBSTACLE1_TOP_X 
    
    move.l  #500,(PLAYER_POSITION_X)
    move.l  #600,(PLAYER_POSITION_Y)
    
  
    jsr     getRandomLongIntoD6
    move.l  d6,d1
    andi.l   #$00FFFFFF,d1 
    move.l  d1,PLAYER_FILL_COLOR

resetLoop:  
        jsr     updateObstacle1
        
        move.l  RESET_TIMER,d0
        addi.l  #1,d0
        move.l  d0,RESET_TIMER
        
        move.l  d0,d1
        asr.l   #8,d1
        asr.l   #8,d1
        asr.l   #4,d1
        
        cmpi.l  #1,d1 
        bne     resetLoop
        move.l  #0,RESET_TIMER
        
gameLoop:
         jsr handleInput
         jsr gapGenerator1
         jsr nextObstacleGenerator1
*         jsr gapGenerator2
*         jsr nextObstacleGenerator2
         jsr updateObstacle1
         jsr updateObstacle2
         jsr updateInval1
         jsr updateInval2
         jsr updatePlayerPosition
         jsr renderPlayer
         jsr updateScore
         jsr collisionDetection
         
         move.l PLAYER_LIVES,d0
         cmpi.l #0,d0
         bne gameLoop

 ;display game over screen
      *******************************************  
        
        move.l  #400,(SCREEN_OFFSET_X)
        move.l  #200,(SCREEN_OFFSET_Y)
        
        move.l  #0,(IMAGE_START_X)
        move.l  #0,(IMAGE_START_Y)
        
        move.l  #239,(IMAGE_END_X)
        move.l  #71,(IMAGE_END_Y)
        
        lea     GameOverScreen,a0
        jsr     renderImage
        
        move.b  #DUMP_SCREEN_BUFFER,d0
        trap    #15
                
        move.l #KILL_PROGRAM, d0
        TRAP    #15
        
        STOP    #$2000
    
    

LoadingImage        INCBIN  "Images/loading.bmp"
BackGroundImage     INCBIN  "Images/backGround.bmp" 
BackGroundImage2    INCBIN  "Images/background_withObstacle.bmp"
GameOverScreen      INCBIN  "Images/gameOver.bmp"
     
SCREEN_OFFSET_X         ds.l  1
SCREEN_OFFSET_Y         ds.l  1 

IMAGE_START_X    ds.l   1
IMAGE_START_Y    ds.l   1

IMAGE_END_X      ds.l   1
IMAGE_END_Y      ds.l   1

PLAYER_POSITION_X      ds.l     1
PLAYER_POSITION_Y      ds.l     1

SOUNDSTRING         dc.b    'Sounds/backGroundMusic.wav',0

HAVE_HAD_NO_INPUT      ds.b     1

LEFT_NOT_PRESSED        ds.b    1
RIGHT_NOT_PRESSED       ds.b    1
SPACE_NOT_PRESSED       ds.b    1
UP_NOT_PRESSED       ds.b    1

LEFT_KEY_COUNTER        ds.l    1
RIGHT_KEY_COUNTER       ds.l    1

INPUT_COUNTER          ds.b     1

YDELTA                 ds.l     1
YDELTA_COUNTER         ds.l     1
CURRENT_SPEED          ds.l     1
PREVIOUS_SPEED         ds.l     1

OBSTACLE1_COUNTER        ds.l    1
OBSTACLE2_COUNTER        ds.l    1
INVAL1_COUNTER           ds.l    1
INVAL2_COUNTER           ds.l    1


OBSTACLE_START_X        ds.l    1
OBSTACLE_START_Y        ds.l    1
OBSTACLE_START_WIDTH    ds.l    1
OBSTACLE_START_HEIGHT   ds.l    1

OBSTACLE1_TOP_X      ds.l    1
OBSTACLE1_TOP_Y      ds.l    1
OBSTACLE1_BOTTOM_X  ds.l    1
OBSTACLE1_BOTTOM_Y  ds.l    1

OBSTACLE2_TOP_X      ds.l    1
OBSTACLE2_TOP_Y      ds.l    1
OBSTACLE2_BOTTOM_X  ds.l    1
OBSTACLE2_BOTTOM_Y  ds.l    1

INVAL1_TOP_X        ds.l    1
INVAL1_TOP_Y        ds.l    1
INVAL1_BOTTOM_X     ds.l    1
INVAL1_BOTTOM_Y     ds.l    1

INVAL2_TOP_X        ds.l    1
INVAL2_TOP_Y        ds.l    1
INVAL2_BOTTOM_X     ds.l    1
INVAL2_BOTTOM_Y     ds.l    1


OBSTACLE_INVAL_START_X        ds.l    1
OBSTACLE_INVAL_START_Y        ds.l    1
OBSTACLE_INVAL_START_WIDTH    ds.l    1
OBSTACLE_INVAL_START_HEIGHT   ds.l    1

OBSTACLE_INVAL_CURRENT_TOP_X      ds.l    1
OBSTACLE_INVAL_CURRENT_TOP_Y      ds.l    1
OBSTACLE_INVAL_CURRENT_BOTTOM_X  ds.l    1
OBSTACLE_INVAL_CURRENT_BOTTOM_Y  ds.l    1

GENERATE_GAP_COUNTER_SMALL            ds.l    1
GENERATE_GAP_COUNTER_BIG              ds.l    1

SCORE_COUNTER               ds.l    1
ACTUAL_SCORE                ds.l    1

PLAYER_LIVES                ds.l    1
COLLISION_COUNTER           ds.l    1  
RESET_TIMER                 ds.l    1


RANDOMVAL           ds.l    1   
TEMPRANDOMLONG  ds.l    1
     
PLAYER_FILL_COLOR           ds.l    1

IN_AIR                      ds.l    1
  

*SOUNDSING                   dc.b    'Sounds/backGroundMusic.wav',0

SEVEN_SEGMENT_TABLE    dc.b   $7E,$30,$6D,$79,$33,$5B,$5F,$70,$7F,$7B





* Put variables and constants here

    END    START        ; last line of source






















































































































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
