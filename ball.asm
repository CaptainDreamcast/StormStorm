update_ball:
	
				lda 	BallIsInUpperHalf
				cmpa 	#0
				bne		after_ball_upper_half_1	
				lda 	#-99
				ldb 	#0
				jsr     Moveto_d

after_ball_upper_half_1:

				lda		BallPositionY
                ldb 	BallPositionX
				                
                jsr     Moveto_d                ; move the vector beam the

				ldx     #ball_list				; load the address of the to be
                                                ; drawn vector list to X
 
                jsr     Draw_VLc                ; draw the line now
				
				lda		BallPositionY
                ldb     BallPositionX                 ; to 0 (x)
				nega
				negb
								
                jsr     Moveto_d                ; move the vector beam the
				
				lda 	BallIsInUpperHalf
				cmpa 	#0
				bne		after_ball_upper_half_2	
				lda 	#99
				ldb 	#0
				jsr     Moveto_d
				
after_ball_upper_half_2:
				
				lda		BallPositionX
				adda	BallVelocityX
				sta 	BallPositionX
				
				cmpa 	#-80
				bgt		ball_second_x_check
				lda		#-80
				sta		BallPositionX
				jmp 	after_ball_x_move
				
ball_second_x_check
				lda 	BallPositionX
				cmpa 	#80
				blt		after_ball_x_move
				lda		#80
				sta		BallPositionX
				
after_ball_x_move
				
				lda		BallPositionY
				adda	BallVelocityY
				sta 	BallPositionY
				
				lda		BallVelocityY
				adda	BallAccelerationY
				sta 	BallVelocityY			
				
				lda 	BallIsInUpperHalf
				cmpa 	#0
				bne		after_ball_upper_half_3	
				
				lda 	BallPositionY
				cmpa 	#99
				blt		after_ball_half_update
				lda 	#1
				sta 	BallIsInUpperHalf
				lda		BallPositionY
				adda	#-99
				sta 	BallPositionY
				jmp		after_ball_half_update
				
after_ball_upper_half_3:
				lda 	BallPositionY
				cmpa 	#-1
				bgt		after_ball_half_update
				lda 	#0
				sta 	BallIsInUpperHalf
				lda		BallPositionY
				adda	#99
				sta 	BallPositionY

after_ball_half_update:			
			
				
				jsr ball_paddle_interaction
				
				rts
				
				
				
ball_paddle_interaction
				lda 	BallIsInUpperHalf
				cmpa 	#0
				bne		after_ball_paddle_interaction	
						
				lda 	BallPositionY
				cmpa	#1
				bgt		after_ball_paddle_interaction
				lda		#0
				sta 	BallVelocityX
				sta 	BallVelocityY
				lda 	#1
				sta 	BallPositionY
				
				
				lda 	BallPositionX
				adda 	#-32
				cmpa 	PaddlePositionX
				bgt 	after_ball_paddle_interaction
				
				lda 	BallPositionX
				adda 	#32
				cmpa 	PaddlePositionX
				blt 	after_ball_paddle_interaction
				
				lda 	PaddleVelocityY
				cmpa 	#0
				blt 	after_ball_paddle_interaction
				
				lda 	PaddlePositionY
				suba	BallPositionY
				cmpa	#100
				bgt 	after_ball_paddle_interaction
				
				lda		BallPositionY
				cmpa 	PaddlePositionY
				bge		after_ball_paddle_interaction
				lda 	PaddleVelocityY
				adda	#5
				sta 	BallVelocityY
				
				lda 	PaddleVelocityX
				sta 	BallVelocityX
				
after_ball_paddle_interaction:
				rts