gameoverscreen:

        jsr     init_screen_time
        lda     #3
        sta     EnemiesMissed

gameoverscreen_loop:

        jsr     update_drawing
        jsr     draw_missed_crosses
        jsr     draw_gameover_score
        jsr     draw_gameover

        jsr     update_screen_time

        jsr     read_button1_flank
        cmpa    #0
        bne     gameoverscreen_shutdown

        jmp     gameoverscreen_loop

gameoverscreen_shutdown
        lda     #1
        sta     CurrentScreen
        rts


draw_gameover	
        lda     #40                      
        ldb     #-65                   
        jsr     Moveto_d      

        ldu     #gameover_string     
        jsr     Print_Str_yx  

        lda     #0                      
        ldb     #-115                   
        jsr     Moveto_d    
        ldu     #enemies_killed_string    
        jsr     Print_Str_yx  
        
        rts
	
draw_gameover_score
        lda     #0                      
        ldb     #20                   
        jsr     Moveto_d      

        lda     #0
        ldb     #0
        ldu     #Score   
        jsr     Print_Str_d  

        rts

gameover_string: 
        db      0, 0, "GAME OVER", $80
				
enemies_killed_string: 
        db      0, 0, "STORMS STORMED:", $80
				
				