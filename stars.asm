init_title_stars:
        lda     #SINGLE_PARTICLE_EFFECT_AMOUNT
        sta     CurrentParticle
                                
init_stars_loop
        dec     CurrentParticle

        jsr     init_single_title_star

        lda     CurrentParticle
        cmpa    #0
        bne     init_stars_loop

        rts



init_single_title_star:
        ldb     #0
        lda     CurrentParticle
        ldx     #ParticleActive
        stb     a,x
        rts


draw_title_stars:
        lda     #SINGLE_PARTICLE_EFFECT_AMOUNT
        sta     CurrentParticle

draw_stars_loop
        dec     CurrentParticle

        jsr     add_single_star
        jsr     draw_single_star
        jsr     update_single_star

        lda     CurrentParticle
        cmpa    #0
        bne     draw_stars_loop

        rts

add_single_star:

        ldb     CurrentParticle
        ldx     #ParticleActive
        lda     b,x
        cmpa    #0
        bne     add_star_over

        jsr     Random
        jsr     randomize_a_sign
        ldb     CurrentParticle
        ldx     #ParticlePositionX
        sta     b,x

        jsr     Random
        jsr     randomize_a_sign
        ldb     CurrentParticle
        ldx     #ParticlePositionY
        sta     b,x

        jsr     Random
        anda    #0xF
        ldb     CurrentParticle
        ldx     #ParticleTime
        sta     b,x

        lda     #1
        ldb     CurrentParticle
        ldx     #ParticleActive
        sta     b,x

add_star_over;

        rts


	
draw_single_star:

        ldb     CurrentParticle
        ldx     #ParticlePositionY
        lda     b,x           

        ldx     #ParticlePositionX
        ldb     b,x

        jsr     Moveto_d 

        jsr     Dot_here	

        ldb     CurrentParticle
        ldx     #ParticlePositionY
        lda     b,x           

        ldx     #ParticlePositionX
        ldb     b,x

        nega
        negb
        jsr     Moveto_d 


        rts

	
update_single_star

        ldb     CurrentParticle
        ldx     #ParticleTime
        lda     b,x
        deca
        sta     b,x
        cmpa    #0
        bne     remove_star_over

        lda     #0
        ldx     #ParticleActive
        sta     b,x

remove_star_over:	

        rts