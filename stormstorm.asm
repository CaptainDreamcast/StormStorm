;***************************************************************************
; DEFINE SECTION
;***************************************************************************
                INCLUDE "VECTREX.I"
; start of vectrex memory with cartridge name...

PositionX     EQU   $C880

                ORG     0
;***************************************************************************
; HEADER SECTION
;***************************************************************************
                DB      "g GCE NOT ", $80       ; 'g' is copyright sign
                DW      music1                  ; music from the rom
                DB      $F8, $50, $20, -$50     ; height, width, rel y, rel x
                                                ; (from 0,0)
                DB      "STORM STORM",$80  ; some game information,
                                                ; ending with $80
                DB      0                       ; end of game header
;***************************************************************************
; CODE SECTION
;***************************************************************************
; here the cartridge program starts off
init:
				LDA		#0
				STA		PositionX

main:
                JSR     Wait_Recal              ; Vectrex BIOS recalibration
                LDA     #$80                    ; scaling factor of $80 to A
                STA     VIA_t1_cnt_lo           ; move to time 1 lo, this
                                                ; means scaling
                LDA     #-50                      ; to 0 (y)
                LDB     #127                      ; to 0 (x)
                JSR     Moveto_d                ; move the vector beam the
                                                ; relative position
                JSR     Intensity_5F            ; Sets the intensity of the
                                                ; vector beam to $5f
                LDX     #floor_list				; load the address of the to be
                                                ; drawn vector list to X

			    JSR     Draw_VLc                ; draw the line now

				;LDA     #$FF                    ; scaling factor of $80 to A
                ;STA     VIA_t1_cnt_lo           ; move to time 1 lo, this
                                                ; means scaling

                LDA     #0                      ; to 0 (y)
                LDB     #30                      ; to 0 (x)
				                
                JSR     Moveto_d                ; move the vector beam the
                                                ; relative position

                LDX     #door_list				; load the address of the to be

                JSR     Draw_VLc                ; draw the line now

                LDA     #0                      ; to 0 (y)
                LDB     #80                      ; to 0 (x)
				                
                JSR     Moveto_d                ; move the vector beam the
                                                ; relative position

                LDX     #door_list				; load the address of the to be
                                                ; drawn vector list to X
                                                ; drawn vector list to X	
				
                JSR     Draw_VLc                ; draw the line now

                LDA     #0                      ; to 0 (y)
                LDB     #-115                   ; to 0 (x)
				                
                JSR     Moveto_d                ; move the vector beam the
                                               ; relative position


				LDU     #not_string     ; display no y string
                JSR     Print_Str_yx            ; using string function
				LDU     #goal_string1     ; display no y string
                JSR     Print_Str_yx            ; using string function
				LDU     #goal_string2     ; display no y string
                JSR     Print_Str_yx            ; using string function

				LDA		#-50
                LDB     PositionX                   ; to 0 (x)
				                
                JSR     Moveto_d                ; move the vector beam the
                                               ; relative position

                LDX     #sprite_list				; load the address of the to be
                                                ; drawn vector list to X
                                                ; drawn vector list to X	
				
                JSR     Draw_VLc                ; draw the line now

				JSR     Joy_Digital             ; read joystick positions
                LDA     Vec_Joy_1_X             ; load joystick 1 position
                                                ; X to A
                BEQ     no_x_movement           ; if zero, than no x position
                BMI     left_move               ; if negative, than left
                                                ; otherwise right
right_move:
				INC		PositionX
				LDA		PositionX
				CMPA	#45
				BEQ		Crash
				JMP		no_x_movement

left_move:
				DEC		PositionX
				LDA		PositionX
				CMPA	#-45
				BEQ		Crash
no_x_movement:
x_done:

                BRA     main                    ; and repeat forever
;***************************************************************************
Crash:
				JSR     Wait_Recal
				JMP Crash

;***************************************************************************
SPRITE_BLOW_UP EQU 14
SPRITE_BLOW_UP2 EQU 7
floor_list:
                DB 1                           ; number of vectors - 1
                DB  0,  -128
                DB  0,  -128

door_list:
                DB 2                           ; number of vectors - 1
                DB  75,  0
                DB  0,  60
				DB	-75, 0

sprite_list:
                DB 12                          ; number of vectors - 1
                DB  SPRITE_BLOW_UP,  SPRITE_BLOW_UP
                DB  -1 * SPRITE_BLOW_UP,  SPRITE_BLOW_UP
				DB	SPRITE_BLOW_UP, -1 * SPRITE_BLOW_UP
				DB	SPRITE_BLOW_UP, 0
				DB	0, -1 * SPRITE_BLOW_UP
				DB	0, 2 * SPRITE_BLOW_UP
				DB	0, -1 * SPRITE_BLOW_UP
				DB	SPRITE_BLOW_UP2, 0
				DB	0, SPRITE_BLOW_UP2
				DB	SPRITE_BLOW_UP2, 0
				DB	0, -2*SPRITE_BLOW_UP2
				DB	-1 * SPRITE_BLOW_UP2, 0
				DB	0, SPRITE_BLOW_UP2

not_string:
                DB 110, -80,"NOT", $80
goal_string1:
                DB 40, -100,"GOAL", $80
goal_string2:
                DB 40, 50,"GOAL", $80


;***************************************************************************
                END main
;***************************************************************************
