extends Area2D

@onready var animated_jump_pad_sprite = $AnimatedSprite2D
@onready var jump_pad_noise = $JumpPadNoise

func _on_body_entered(body):
	if body is Player:
		animated_jump_pad_sprite.play()
		jump_pad_noise.play()
		body.jump(350)
