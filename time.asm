init_screen_time
				lda #0
				sta ScreenTicks
				sta ScreenSeconds
				sta ScreenMinutes
				rts
				
				
				
update_screen_time
				inc ScreenTicks
				lda ScreenTicks
				cmpa #60
				bne  update_screen_seconds_over
				
				lda #0
				sta ScreenTicks
				inc ScreenSeconds
				
update_screen_seconds_over
				lda ScreenSeconds
				cmpa #60
				bne update_screen_minutes_over

				lda #0
				sta ScreenSeconds
				inc ScreenMinutes
				
update_screen_minutes_over

				rts
				
				
update_gamescreen_time
				lda ScreenSeconds
				cmpa #60
				bne update_minutes_over
				
				
update_minutes_over
				
				jsr check_gamescreen_condition1
				jsr check_gamescreen_condition2
				jsr check_gamescreen_condition3
				jsr check_gamescreen_condition4
				jsr check_gamescreen_condition5

				rts
				
increase_enemy_speed
				dec EnemyVelocityX
				rts
				
check_gamescreen_condition1
				
				lda	ScreenTicks
				cmpa #0
				bne check_condition1_over
				
				lda	ScreenSeconds
				cmpa #5
				bne check_condition1_over
				
				lda	ScreenMinutes
				cmpa #0
				bne check_condition1_over
				
				jsr increase_enemy_speed
				
check_condition1_over
				rts
				
				
check_gamescreen_condition2
				
				lda	ScreenTicks
				cmpa #0
				bne check_condition2_over
				
				lda	ScreenSeconds
				cmpa #10
				bne check_condition2_over
				
				lda	ScreenMinutes
				cmpa #0
				bne check_condition2_over
				
				jsr increase_enemy_speed
				
check_condition2_over
				rts
				
				
check_gamescreen_condition3
				
				lda	ScreenTicks
				cmpa #0
				bne check_condition3_over
				
				lda	ScreenSeconds
				cmpa #30
				bne check_condition3_over
				
				lda	ScreenMinutes
				cmpa #0
				bne check_condition3_over
				
				jsr increase_enemy_speed
				
check_condition3_over
				rts
				
check_gamescreen_condition4
				
				lda	ScreenTicks
				cmpa #0
				bne check_condition4_over
				
				lda	ScreenSeconds
				cmpa #30
				bne check_condition4_over
				
				lda	ScreenMinutes
				cmpa #0
				beq check_condition4_over
				
				jsr increase_enemy_speed
				
check_condition4_over
				rts
				
check_gamescreen_condition5
				
				lda	ScreenTicks
				cmpa #0
				bne check_condition5_over
				
				lda	ScreenSeconds
				cmpa #59
				bne check_condition5_over
				
				lda	ScreenMinutes
				cmpa #0
				beq check_condition5_over
				
				jsr increase_enemy_speed
				
check_condition5_over
				rts