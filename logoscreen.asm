logoscreen:
	
	jsr init_screen_time
	
logoscreen_loop:

	jsr update_drawing
	jsr draw_logo

	jsr update_screen_time
	
	lda ScreenSeconds
	cmpa #3
	beq logoscreen_shutdown

	jsr 	read_button1_flank
	cmpa 	#0
	bne	    logoscreen_shutdown
	
	jmp logoscreen_loop

logoscreen_shutdown
	lda #1
	sta CurrentScreen
	rts
	
	
draw_logo

				lda     #0                  
				ldb     #-10                     
                jsr     Moveto_d                
                               

                ldx     #logo_left_list			
				jsr     Draw_VLc		         
				
				lda     #0                      
                ldb     #10                   
                jsr     Moveto_d      


				lda     #0                  
				ldb     #10                     
                jsr     Moveto_d                
                               

                ldx     #logo_right_list			
				jsr     Draw_VLc		         
				
				lda     #0                      
                ldb     #-10                   
                jsr     Moveto_d      

				
				lda     #-20                      
                ldb     #-40                   
                jsr     Moveto_d      

				ldu     #dogma_string     
                jsr     Print_Str_yx  

				lda     #-40                      
                ldb     #-58                   
                jsr     Moveto_d      

				ldu     #presents_string     
                jsr     Print_Str_yx  				
				
				
	rts
	
	
logo_left_list:
                db 2                           ; number of vectors - 1
                db  60,  -60
				db  60,  60
				db  -120,  0

logo_right_list:
                db 2                           ; number of vectors - 1
                db  60,  60
				db  60,  -60
				db  -120,  0

dogma_string: 
                db 0, 0, "DOGMA", $80
				
presents_string: 
                db 0, 0, "PRESENTS", $80