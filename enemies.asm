load_enemies:
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy

load_enemy_loop
        dec     CurrentEnemy
        jsr     load_single_enemy

        lda     CurrentEnemy
        cmpa    #0x0
        bne     load_enemy_loop

        rts

load_single_enemy
        lda     CurrentEnemy
        ldx     #EnemyActive
        ldb     #0
        stb     a,x

        rts

update_enemies:
        jsr     update_adding_enemies
        jsr     update_moving_enemies
        jsr     draw_enemies
        jsr     update_collisions

        rts
			
update_collisions
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy

update_collisions_loop
        dec     CurrentEnemy
        jsr     update_single_collision

        lda     CurrentEnemy
        cmpa    #0x0
        bne     update_collisions_loop

        rts

update_single_collision
        lda     CurrentEnemy
        ldx     #EnemyActive
        lda     a,x
        cmpa    #0
        beq     update_single_collision_over

        lda     BallIsInUpperHalf
        cmpa    #0
        beq     update_single_collision_over

        lda     CurrentEnemy
        ldx     #EnemyPositionX
        lda     a,x

        ldb     BallPositionX
        addb    #20
        stb     TestPosition
        cmpa    TestPosition
        bge     update_single_collision_over

        lda     CurrentEnemy
        ldx     #EnemyPositionX
        lda     a,x

        ldb     BallPositionX
        addb    #-20
        stb     TestPosition
        cmpa    TestPosition
        ble     update_single_collision_over

        lda     CurrentEnemy
        ldx     #EnemyPositionY
        lda     a,x

        ldb     BallPositionY
        addb    #20
        stb     TestPosition
        cmpa    TestPosition
        bge     update_single_collision_over

        lda     CurrentEnemy
        ldx     #EnemyPositionY
        lda     a,x

        ldb     BallPositionY
        addb    #-20
        stb     TestPosition
        cmpa    TestPosition
        ble     update_single_collision_over

        ldb     #0
        lda     CurrentEnemy
        ldx     #EnemyActive
        stb     a,x

        lda     NextUsedParticle
        sta	CurrentEffect
        inca
        anda    #1
        sta     NextUsedParticle

        jsr     add_particle_effect
        jsr     increase_score
			
update_single_collision_over
        rts
				
increase_score
        lda     #1
        ldx     #Score
        jsr     Add_Score_a

        rts

update_adding_enemies:
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy


update_adding_enemy_loop
        dec     CurrentEnemy
        jsr     update_adding_single_enemy

        lda     CurrentEnemy
        cmpa    #0x0
        bne     update_adding_enemy_loop

        rts

update_adding_single_enemy
        lda     CurrentEnemy
        ldx     #EnemyActive
        lda     a,x

        cmpa    #0
        bne     adding_single_enemy_over

        jsr     Random
        cmpa    #-125
        bgt     adding_single_enemy_over

        ldb     #126
        lda     CurrentEnemy
        ldx     #EnemyPositionX
        stb     a,x

        jsr     Random
        anda    #0x2F

        exg     a,b
        lda     CurrentEnemy
        ldx     #EnemyPositionY
        stb     a,x

        ldb     #1
        lda     CurrentEnemy
        ldx     #EnemyActive
        stb     a,x				

adding_single_enemy_over
        rts
				
update_moving_enemies:
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy

update_moving_enemy_loop
        dec     CurrentEnemy
        jsr     update_moving_single_enemy

        lda     CurrentEnemy
        cmpa    #0x0
        bne     update_moving_enemy_loop

        rts
				
update_moving_single_enemy
        lda     CurrentEnemy
        ldx     #EnemyActive
        lda     a,x
        cmpa    #0
        beq     update_moving_enemy_over

        lda     CurrentEnemy
        ldx     #EnemyPositionX
        lda     a,x

        adda    EnemyVelocityX

        cmpa    #-126
        bne     enemy_remove_over
        ldb     CurrentEnemy
        ldx     #EnemyActive
        lda     #0
        sta     b,x
        inc     EnemiesMissed

enemy_remove_over

        ldb     CurrentEnemy
        ldx     #EnemyPositionX
        sta     b,x

update_moving_enemy_over				

        lda     EnemiesMissed
        cmpa    #3
        bne	gameover_check_over
        lda     #0
        sta     ScreenIsActive
        lda     #3
        sta     CurrentScreen

gameover_check_over

        rts		

draw_enemies:
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy

        lda     #30
        ldb     #0
        jsr     Moveto_d

draw_enemy_loop
        dec     CurrentEnemy
        jsr     draw_single_enemy

        lda     CurrentEnemy
        cmpa    #0x0
        bne     draw_enemy_loop

        lda     #-30
        ldb     #0
        jsr     Moveto_d

        rts


draw_single_enemy

        lda     CurrentEnemy
        ldx     #EnemyActive
        lda     a,x
        cmpa    #0
        beq     draw_single_enemy_over


        lda     CurrentEnemy
        ldy     #EnemyPositionY
        lda     a,y

        ldb     CurrentEnemy
        ldx     #EnemyPositionX
        ldb     b,x

        jsr     Moveto_d

        lda     #4
        sta     CurrentEnemyLine

draw_enemy_line_loop		
        jsr     Random
        anda    #0xF
        jsr     randomize_a_sign
        exg     a,b

        jsr     Random
        anda    #0x1F

        sta     EnemyLineOffsetY
        stb     EnemyLineOffsetX

        jsr     Draw_Line_d

        lda     EnemyLineOffsetY
        ldb     EnemyLineOffsetX
        nega
        negb	
        jsr     Moveto_d

        dec     CurrentEnemyLine
        lda     CurrentEnemyLine
        cmpa    #0
        bne     draw_enemy_line_loop

        lda     CurrentEnemy
        ldy     #EnemyPositionY
        lda     a,y
        nega

        ldb     CurrentEnemy
        ldx     #EnemyPositionX
        ldb     b,x
        negb

        jsr     Moveto_d



draw_single_enemy_over
        rts