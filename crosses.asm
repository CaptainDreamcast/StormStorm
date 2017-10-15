draw_missed_crosses:
				lda #0
				sta CurrentEnemy
				
				lda #0
				sta TestPosition
				
				lda		#100
                ldb     #-100           				              
                jsr     Moveto_d   
				
draw_missed_crosses_loop
				lda CurrentEnemy
				cmpa EnemiesMissed
				beq  draw_missed_crosses_over
				
				jsr draw_single_missed_cross
				
				inc CurrentEnemy
				lda TestPosition
				adda #30
				sta TestPosition
				jmp draw_missed_crosses_loop			

draw_missed_crosses_over

				lda		#-100
                ldb     #100           				              
                jsr     Moveto_d   

				rts
				
draw_single_missed_cross
				lda		#0
                ldb     TestPosition             				              
                jsr     Moveto_d               
                                              

                ldx     #cross_list
                jsr     Draw_VLc         

				lda		#0
                ldb     TestPosition  
				nega
				negb
                jsr     Moveto_d    

				rts