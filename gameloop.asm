gameloop
	jsr init_general
	lda #0
	sta CurrentScreen

gameloop_mainloop ; TODO: find out how to jump to locations stored in memory

	lda CurrentScreen
	cmpa #0
	bne which_screen_0_over
	jsr logoscreen
	jmp gameloop_mainloop
which_screen_0_over

	lda CurrentScreen
	cmpa #1
	bne which_screen_1_over
	jsr titlescreen
	jmp gameloop_mainloop
which_screen_1_over
	
	lda CurrentScreen
	cmpa #2
	bne which_screen_2_over
	jsr gamescreen
	jmp gameloop_mainloop
which_screen_2_over

	lda CurrentScreen
	cmpa #3
	bne which_screen_3_over
	jsr gameoverscreen
	jmp gameloop_mainloop
which_screen_3_over
	
	jmp gameloop_mainloop
	
	
	include "gamescreen.asm"
	include "logoscreen.asm"
	include "titlescreen.asm"
	include "gameoverscreen.asm"