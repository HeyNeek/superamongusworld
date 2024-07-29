extends Node2D

@export var next_level: PackedScene = null

@onready var clear_music = $ClearMusic
@onready var yippee_sound = $YippeeSound
@onready var death_sound = $DeathSound

@onready var continue_text_scene = preload("res://scenes/continue_text.tscn")

var stage_cleared = false

@onready var stage_music = $StageMusic
@onready var player = $Player

@onready var vert_spike_ball1 = $Traps/SpikeBall2
@onready var vert_spike_ball2 = $Traps/SpikeBall3

func _ready():
	stage_music.play()
	vert_spike_ball1.animation_player.play("move_down")
	vert_spike_ball2.animation_player.play("move_down")

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		print('reloaded')
		reset_game()
	
	if stage_cleared == true && Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_packed(next_level)

func reset_game():
	get_tree().reload_current_scene()

func _on_deathzone_body_entered(_body):
	player.is_active = false
	death_sound.play()
	await get_tree().create_timer(3).timeout
	reset_game()

func _on_spike_ball_touched_player():
	player.is_active = false
	player.collision_layer = 0
	player.global_position.y += -35
	player.animated_sprite.play("explode")
	death_sound.play()
	
	await get_tree().create_timer(3).timeout
	reset_game()

func _on_exit_body_entered(body):
	stage_cleared = true
	
	stage_music.stop()
	yippee_sound.play()
	clear_music.play()
	
	body.is_active = false
	body.animated_sprite.play("idle")
	
	var continue_text_instance = continue_text_scene.instantiate()
	body.add_child(continue_text_instance)
	continue_text_instance.global_position.x -= 45
	continue_text_instance.global_position.y += 75
