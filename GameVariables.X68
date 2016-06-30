*-----------------------------------------------------------
* Title      : Game Variables
* Written by : Mahesh Velegonda
* Date       : 10/2/2014
* Description: This file contains all the variables used in the game
*-----------------------------------------------------------

ALL_REG                 REG     D0-D7/A0-A6
PRINT_STRING_NO_CR      EQU     14
PRINT_NUMBER            EQU     3
KILL_PROGRAM            EQU     9
MOVE_LINE_TRAP          EQU     84

BLACK                   EQU          $00000000
RED                     EQU          $000000FF
GREEN                   EQU          $0000FF00
BLUE                    EQU          $00FF0000  
WHITE                   EQU          $00FFFFFF   

SEGMENT_SIZE            EQU     10
SEGMENT_COLOR           EQU     WHITE

SCORE_ONES_LOCATION_X       EQU     230
SCORE_TENS_LOCATION_X       EQU     215
SCORE_HUNDREDS_LOCATION_X   EQU     200
SCORE_THOUSANDS_LOCATION_X  EQU     185
SCORE_DISPLAY_LOCATION_Y    EQU     714
PLAYER_LIVES_LOCATION_X     EQU     912

SCREEN_WIDTH                EQU     1024
SCREEN_HEIGHT               EQU     768

SET_SCREEN_RESOLUTION_TRAP_CODE     EQU     33
PEN_COLOR_TRAP_CODE                 EQU     80

SET_SCREEN_BUFFER_MODE      EQU     92     
ENABLE_DOUBLE_BUFFER_MODE          EQU     17
DISBALE_DOUBLE_BUFFER_MODE         EQU     16

DUMP_SCREEN_BUFFER          EQU     94

PLAYER_WIDTH                EQU     30
PLAYER_HEIGHT               EQU     10

SET_PEN_COLOR_TRAP      EQU     80
SET_FILL_COLOR_TRAP     EQU     81

DRAW_FILLED_RECTANGLE_TRAP      EQU     87
DRAW_UNFILLED_RECTANGLE_TRAP    EQU     89

PLAYER_SPEED                    EQU     5

GROUND                          EQU     620
GRAVITY                         EQU     1

OBSTACLE_START_TOP_X            EQU     480
OBSTACLE_START_TOP_Y            EQU     500
OBSTACLE_START_BOTTOM_X         EQU     520
OBSTACLE_START_BOTTOM_Y         EQU     520

OBSTACLE_SPEED_FRACTION         EQU     4

JUMP_MAGNITUDE                  EQU     16
    

GET_TIME_COMMAND        equ     8

LARGE_NUMBER            equ     $5678
LARGE_NUMBER1           equ     $1234































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
