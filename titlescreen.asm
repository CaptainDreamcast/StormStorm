titlescreen:
	
	jsr init_screen_time
	jsr init_title_stars
	
titlescreen_loop:

	jsr update_drawing
	jsr draw_title
	jsr draw_title_stars
	
	jsr update_screen_time
	
	jsr 	read_button1_flank
	cmpa 	#0
	bne	    titlescreen_shutdown
	
	jmp titlescreen_loop

titlescreen_shutdown
	lda #2
	sta CurrentScreen
	rts
	
	
draw_title  	
				lda     #40                      
                ldb     #-75                   
                jsr     Moveto_d      

				ldu     #storm_storm_string     
                jsr     Print_Str_yx  
				
				lda     #0                      
                ldb     #-90                   
                jsr     Moveto_d    
				ldu     #press_start_string     
                jsr     Print_Str_yx  
				
				lda     #-20                      
                ldb     #-55                   
                jsr     Moveto_d    
				ldu     #to_start_string     
                jsr     Print_Str_yx  
			
				
				
	rts
	
	

storm_storm_string: 
                db 0, 0, "STORM STORM", $80
				
press_start_string: 
                db 0, 0, "PRESS BUTTON 1", $80
				
to_start_string: 
                db 0, 0, "TO START", $80
				
				
	include 'stars.asm'