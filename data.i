        include "../addons/libtari/vectrex/wrapperdata.I"

MAX_ENEMY_AMOUNT 	equ 	2
MAX_PARTICLE_EFFECT_AMOUNT 	equ 	2
SINGLE_PARTICLE_EFFECT_AMOUNT 	equ 	20

PaddlePositionX     equ  (GameDataStart)
PaddlePositionY	  equ 	(PaddlePositionX+2)
PaddleVelocityX	  equ   (PaddlePositionY+2)
PaddleVelocityY	  equ   (PaddleVelocityX+2)
PaddleIsJumping	  equ   (PaddleVelocityY+2)
PaddleSentinel    equ 	(PaddleIsJumping+2)

BallIsInUpperHalf	equ	 (PaddleSentinel)
BallPositionX	  equ    (BallIsInUpperHalf+2)
BallPositionY 	    equ	 (BallPositionX+2)
BallVelocityX 	    equ	 (BallPositionY+2)
BallVelocityY 	    equ	 (BallVelocityX+2)
BallAccelerationY 	    equ	 (BallVelocityY+2)
BallSentinel 		equ (BallAccelerationY+2)

EnemyAmount 	    equ	 (BallSentinel)
EnemiesMissed		equ  (EnemyAmount + 2)
EnemyLineOffsetX	equ	 (EnemiesMissed + 2)
EnemyLineOffsetY	equ	 (EnemyLineOffsetX + 2)
CurrentEnemyLine	equ	 (EnemyLineOffsetY + 2)
EnemyActive 	    equ	 (CurrentEnemyLine + 2)
EnemyPositionX		equ  (EnemyActive + 2*MAX_ENEMY_AMOUNT)
EnemyPositionY		equ  (EnemyPositionX + 2*MAX_ENEMY_AMOUNT)
EnemyVelocityX		equ  (EnemyPositionY + 2*MAX_ENEMY_AMOUNT)
CurrentEnemy		equ  (EnemyVelocityX + 2*MAX_ENEMY_AMOUNT)
EnemySentinel		equ  (CurrentEnemy + 2)

CurrentEffect	  	equ EnemySentinel
CurrentParticle 	equ (CurrentEffect + 2)
NextUsedParticle	equ (CurrentParticle + 2)
ParticleActive		equ (NextUsedParticle + 2)
ParticlePositionX	equ (ParticleActive + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticlePositionY	equ (ParticlePositionX + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleVelocityX	equ (ParticlePositionY + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleVelocityY	equ (ParticleVelocityX + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleTime		equ (ParticleVelocityY + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleSentinel	equ (ParticleTime + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))

CurrentScreen		equ (ParticleSentinel)
ScreenIsActive		equ (CurrentScreen + 2)
ScreenTicks			equ (ScreenIsActive + 2)
ScreenSeconds		equ (ScreenTicks + 2)
ScreenMinutes		equ (ScreenSeconds + 2)
Score				equ (ScreenMinutes + 2)
GameLogicSentinel	equ (Score + 10)

StackPointer 		equ (GameLogicSentinel)