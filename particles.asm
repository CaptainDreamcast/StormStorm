load_particles:
				lda	#MAX_PARTICLE_EFFECT_AMOUNT
				sta CurrentEffect
				
load_particles_loop
				dec CurrentEffect
				
				jsr	load_single_particle_effect

				lda CurrentEffect
				cmpa #0
				bne load_particles_loop
				
				rts
			
load_single_particle_effect
				lda	#SINGLE_PARTICLE_EFFECT_AMOUNT
				sta CurrentParticle
				
load_particle_effect_loop
				dec CurrentParticle
				
				jsr	load_single_particle

				lda CurrentParticle
				cmpa #0
				bne load_particle_effect_loop
				
				rts

load_single_particle
				jsr get_particle_index_to_a

				ldb #0
				ldx #ParticleActive
				stb a,x
				
				rts
	
add_particle_effect
				lda	#SINGLE_PARTICLE_EFFECT_AMOUNT
				sta CurrentParticle
				
add_particle_effect_loop
				dec CurrentParticle
				
				jsr	add_single_particle

				lda CurrentParticle
				cmpa #0
				bne add_particle_effect_loop
				
				rts

add_single_particle
				lda CurrentEnemy
				ldx #EnemyPositionX
				ldb a,x
				
				jsr get_particle_index_to_a
				ldx #ParticlePositionX
				stb a,x

				lda CurrentEnemy
				ldx #EnemyPositionY
				ldb a,x
				
				jsr get_particle_index_to_a
				ldx #ParticlePositionY
				stb a,x
				
				ldx #ParticleVelocityX
				jsr set_random_particle_velocity
				
				jsr get_particle_index_to_a
				ldx #ParticleVelocityY
				jsr set_random_particle_velocity
				
				ldb #20
				jsr get_particle_index_to_a
				ldx #ParticleTime
				stb a,x
				
				ldb #1
				ldx #ParticleActive
				stb a,x
				
				rts
				
; expects velocity array in x and index in a
set_random_particle_velocity
				exg a,b
				jsr Random
				anda #3

				cmpa #0
				bne set_random_velocity_in_a
				adda #1
set_random_velocity_in_a

				jsr randomize_a_sign
				
				sta b,x	
				
				rts
				
update_particles:
				lda	#MAX_PARTICLE_EFFECT_AMOUNT
				sta CurrentEffect
				
				lda #30
				ldb #0
				jsr     Moveto_d
				
update_particles_loop
				dec CurrentEffect
				
				jsr	update_single_particle_effect

				lda CurrentEffect
				cmpa #0
				bne update_particles_loop
				
				lda #-30
				ldb #0
				jsr     Moveto_d
				
				rts
			
update_single_particle_effect
				lda	#SINGLE_PARTICLE_EFFECT_AMOUNT
				sta CurrentParticle
				
update_particle_effect_loop
				dec CurrentParticle
				
				jsr	update_single_particle

				lda CurrentParticle
				cmpa #0
				bne update_particle_effect_loop
				
				rts

get_particle_index_to_a
				lda CurrentEffect
				ldx #particle_offset_list
				lda a,x
				adda CurrentParticle
				rts
				
update_single_particle
				jsr get_particle_index_to_a

				ldx #ParticleActive
				ldb a,x
				
				cmpb #0
				beq update_particle_over

				ldx #ParticleTime
				ldb a,x
				decb
				stb a,x
				cmpb #0
				bne remove_particle_over
				
				ldb #0
				ldx #ParticleActive
				stb a,x
	
remove_particle_over
				
				jsr move_single_particle
				jsr draw_single_particle
				
update_particle_over
				rts
	
move_single_particle
				
				ldx #ParticleVelocityX
				ldb a,x
				stb TestPosition
				
				ldx #ParticlePositionX
				ldb a,x
				addb TestPosition
				stb a,x
				
				ldx #ParticleVelocityY
				ldb a,x
				stb TestPosition
				
				ldx #ParticlePositionY
				ldb a,x
				addb TestPosition
				stb a,x
				
				rts				
				
draw_single_particle
				ldx #ParticlePositionX
				ldb a,x

				ldx #ParticlePositionY
				lda a,x
				
				jsr     Moveto_d
				
				jsr Dot_here
				
				jsr get_particle_index_to_a
				
				ldx #ParticlePositionX
				ldb a,x

				ldx #ParticlePositionY
				lda a,x

				nega
				negb
				jsr     Moveto_d
				
				jsr get_particle_index_to_a
				
				rts
	