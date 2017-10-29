update_paddle:
        lda     #-100                      ; to 0 (y)
        ldb     #0                      ; to 0 (x)
        jsr     Moveto_d                ; move the vector beam the
        ; relative position
                                
        lda	PaddlePositionY
        ldb     PaddlePositionX                   ; to 0 (x)

        jsr     Moveto_d                ; move the vector beam the
        ; relative position

        ldx     #paddle_list				; load the address of the to be
        ; drawn vector list to X

        jsr     Draw_VLc                ; draw the line now
                        
        lda	PaddlePositionY
        ldb     PaddlePositionX     
        nega
        negb
        jsr     Moveto_d               

        lda     #100                      
        ldb     #0                     
        jsr     Moveto_d      

        jsr     Joy_Digital             ; read joystick positions
        lda     Vec_Joy_1_X             ; load joystick 1 position
        ; X to A
        beq     no_x_movement           ; if zero, than no x position
        bmi     left_move               ; if negative, than left
        ; otherwise right
right_move:
        lda 	PaddlePositionX
        cmpa  	#80
        bgt	no_x_movement
        lda	#3
        sta 	PaddleVelocityX
        jmp	after_move

left_move:
        lda 	PaddlePositionX
        cmpa  	#-80
        blt	no_x_movement
        lda	#-3
        sta 	PaddleVelocityX
        jmp	after_move
				
no_x_movement:
        lda 	#0
        sta 	PaddleVelocityX
after_move:

        lda 	PaddlePositionX
        adda	PaddleVelocityX
        sta 	PaddlePositionX

button_check:	
        lda 	PaddleIsJumping
        bne	no_button_press
        jsr 	Read_Btns
        lda 	Vec_Button_1_1
        beq 	no_button_press
        inc 	PaddleIsJumping
        lda 	#15
        sta	PaddleVelocityY

no_button_press:				
jumping_update:
        lda 	PaddleIsJumping
        beq 	jumping_update_over

        lda	PaddlePositionY
        adda	PaddleVelocityY
        sta	PaddlePositionY

        dec 	PaddleVelocityY
has_final_velocity:

        lda 	PaddlePositionY
        cmpa 	#0
        blt	reset_jump
        jmp 	jumping_update_over
reset_jump:
        lda	#0
        sta 	PaddleIsJumping
        sta	PaddlePositionY
        sta	PaddleVelocityY
				
jumping_update_over:								   
        rts