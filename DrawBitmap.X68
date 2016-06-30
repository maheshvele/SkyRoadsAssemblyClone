*-----------------------------------------------------------
* Program    :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
LEFT_X  EQU     0
WIDTH   EQU     256
TOP_Y   EQU     0
HEIGHT  EQU     384

PEN_COLOR_TRAP_CODE     EQU     80
DRAW_PIXEL_TRAP_CODE    EQU     82
SET_OUTPUT_RESOLUTION_TRAP_CODE EQU     33
OUTPUT_WIDTH        EQU     1024
OUTPUT_HEIGHT       EQU     768
RECT_COLOR EQU $000000ff
;              $XXBBGGRR

SKIPBYTES_FOR_STARTOFDATA EQU   10

OFFSET_X        EQU 0
OFFSET_Y        EQU 0

; LEGEND
; d5 -> Address of start of data in bitmap image
; d6 -> Width of the bitmap in pixels
; d7 -> Height of the bitmap in pixels




renderImage

        ;lea     BitmapImage, a0
        move.l  a0, d0 
        
        addi.l  #SKIPBYTES_FOR_STARTOFDATA, d0
        
        move.l    d0,a1
        move.l    (a1)+,d5 ; d5 now contains start location of data
        
        ;Convert to BigEndian
        ror.w #8,d5
        ror.l #8,d5
        ror.l #8,d5
        ror.w #8,d5
        
        move.l    (a1)+, d6 ; skip this byte 
        
        move.l    (a1)+,d6 ; d6 contains Width of the bitmap
        ;Convert to BigEndian
        ror.w #8,d6
        ror.l #8,d6
        ror.l #8,d6
        ror.w #8,d6       

        move.l    (a1)+,d7 ; d7contains Height of the bitmap
        ;Convert to BigEndian
        ror.w #8,d7
        ror.l #8,d7
        ror.l #8,d7
        ror.w #8,d7         
        
        ; Make sure the input is valid
        cmp.l   (IMAGE_END_X),d6
        blt     continueCode
        
        cmp.l   (IMAGE_END_Y),d7
        blt     continueCode
        
        move.l  (IMAGE_START_X),d0
        cmp.l   (IMAGE_END_X),d0
        bgt     continueCode
        
        move.l  (IMAGE_START_Y),d0
        cmp.l   (IMAGE_END_Y),d0
        bgt     continueCode
                        
        bra drawOffsetBitmap

continueCode:  
        rts         

drawOffsetBitmap:
        
        ; first determine the address of start of image offset
        
        move.l (IMAGE_END_Y),d0
        move.l d7,d1
        sub.l  d0,d1 ; d1-> vertical offset of Image on screen
        
        ; bytes per row (3 * number of pixels in row)
        move.l d6,d0
        add.l d6,d0
        add.l d6,d0
        
        ;offset bytes for padding ( number of pixels in row mod 4)
        move.l d6,d3
        andi.l #3,d3
        add.l  d3,d0
        
        mulu   d0,d1   ; d1 => vertical offset * number of bytes per row
        
        move.l (IMAGE_START_X),d0       
        add.l  (IMAGE_START_X),d0
        add.l  (IMAGE_START_X),d0 ; 3 * number of pixels for x-offset
        
        add.l  d0,d1 ; d1 => add x-Offset 
              
        add.l  d5,d1   ; add the bytes to skip
        
        move.l a0,d0
        add.l  d1,d0
        move.l d0,a0   ; points to start of Image data
        
        ; calculate the offset bytes that needs to be skipped after every row is incremented
        move.l d6,d5
        move.l (IMAGE_START_X),d1
        move.l (IMAGE_END_X),d2

        sub.l   d2,d5 
        add.l   d1,d5 ; (Image Width - Image OffsetEnd) + Image OffsetStart
        
        move.l d5,d0
        add.l  d0,d5
        add.l  d0,d5 ; 3 * number of pixels
      
        
        add.l  d3,d5 ; add the padding bytes
       
        ;d3 -> x counter 
        ;d4 -> y counter
        clr.l d3
        clr.l d4
        
        ; translate the points on screen
        
        move.l  (IMAGE_START_X),d3
        add.l   (SCREEN_OFFSET_X),d3
        
        move.l  (IMAGE_END_Y),d4
        add.l   (SCREEN_OFFSET_Y),d4   
        
        subi.l  #1,d4
        
        move.l  (IMAGE_END_X),d6
        add.l   (SCREEN_OFFSET_X),d6
        
        move.l  (IMAGE_START_Y),d7
        add.l   (SCREEN_OFFSET_Y),d7
                
drawImage:
        ; Set Pencolor from the bitmap image    
        clr.l d1
    
        move.b (a0)+,d1
        lsl.l  #8,d1
        move.b (a0)+,d1 
        lsl.l  #8,d1
        move.b (a0)+,d1   
        
        move.l #PEN_COLOR_TRAP_CODE, d0
        trap   #15
        
        move.l  d3,d1
        move.l  d4,d2
        move.l  #DRAW_PIXEL_TRAP_CODE, d0
        trap    #15

        addi.l  #1,d3
        cmp.l   d6,d3
        bne     drawImage
        
        move.l  a0,d0
        add.l   d5,d0
        move.l  d0,a0 ; add the offset bytes after drawing every row
        
        move.l  (IMAGE_START_X),d3      
        add.l   (SCREEN_OFFSET_X),d3    ; initialize the x value in the new row
        subi.l  #1,d4
        cmp.l   d7,d4
        bge     drawImage     
        bra     continueCode
       

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
