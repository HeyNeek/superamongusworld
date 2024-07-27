extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var speed = 150
@export var jump_force = 200

var is_active = true

@onready var animated_sprite = $AnimatedSprite2D
@onready var player_jump_noise = $PlayerJumpNoise

func _physics_process(delta):
	if is_active == true:
		if is_on_floor() == false:
			velocity.y += gravity * delta
			
			if velocity.y > 200:
				velocity.y = 200
		
		if Input.is_action_just_pressed("jump") && is_on_floor() == true:
			player_jump_noise.play()
			jump(jump_force)
		
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * speed
		
		if direction == 0:
			velocity.x = 0
		
		if direction != 0:
			animated_sprite.flip_h = direction == -1
		
		if Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
			velocity.x = 0
		
		if velocity.x > 125:
			velocity.x = 125
		
		if velocity.x < -125:
			velocity.x = -125
		
		move_and_slide()
		
		update_animations(direction)

func jump(force):
	velocity.y = -force

func update_animations(direction):
	if is_active == true:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
