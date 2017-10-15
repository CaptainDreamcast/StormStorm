gamescreen:
				lda		#0
				sta		PaddlePositionX
				sta		PaddlePositionY
				sta		PaddleVelocityX
				sta		PaddleVelocityY
				sta 	PaddleIsJumping
				sta 	EnemiesMissed
				
				sta 	BallIsInUpperHalf	
				sta 	BallPositionX	
				sta 	BallPositionY
				sta		BallVelocityX				
				sta		BallVelocityY
				sta 	NextUsedParticle
				
				lda 	#1
				sta 	ScreenIsActive
				
				lda 	#-1
				sta 	BallAccelerationY
				sta 	EnemyVelocityX
				
				ldu 	#Vec_Default_Stk
				stu		StackPointer 
				
				ldx 	#Score
				jsr Clear_Score
				
				jsr load_enemies
				jsr load_particles
				jsr init_screen_time
	
gamescreen_loop:
				jsr 	update_drawing
			
				
				jsr 	draw_game_score
				jsr 	draw_missed_crosses
				jsr 	update_enemies
				jsr 	update_ball
				jsr 	update_particles
				jsr 	update_paddle
				jsr 	update_screen_time
				jsr 	update_gamescreen_time
			
				lda 	ScreenIsActive
				cmpa 	#0
				beq		gamescreen_shutdown
                jmp     gamescreen_loop                    
				
gamescreen_shutdown

				rts
Crash:
				jsr     Wait_Recal
				jmp Crash

draw_game_score
	lda     #0                      
    ldb     #0                   
    jsr     Moveto_d      

	lda #110
	ldb #20
	ldu     #Score   
    jsr     Print_Str_d  
	
	rts
				
				
				include "crosses.asm"
				include "particles.asm"
				include "enemies.asm"
				include "ball.asm"
				include "paddle.asm"
				

				
				

				
;***************************************************************************

paddle_list:
                db 2                           ; number of vectors - 1
                db  0,  -32
				db  0,  64
				db  0,  -32

ball_list:
                db 4                           ; number of vectors - 1
                db  0,  10
                db  20,  0
				db	0, -20
				db	-20, 0
				db  0,  10

enemy_list:
                db 4                           ; number of vectors - 1
                db  0,  10
                db  20,  0
				db	0, -20
				db	-20, 0
				db  0,  10

cross_list:
                db 5                       ; number of vectors - 1
                db  20,  20
                db  -10,  -10
				db  10,  -10
				db  -20,  20
				db  10,  -10
				db  -10,  -10


particle_offset_list:
				db 0, 10