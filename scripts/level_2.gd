extends Node2D

@onready var clear_music = $ClearMusic
@onready var yippee_sound = $YippeeSound

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

func reset_game():
	get_tree().reload_current_scene()

func _on_deathzone_body_entered(_body):
	player.is_active = false
	await get_tree().create_timer(3).timeout
	reset_game()

func _on_spike_ball_touched_player():
	player.is_active = false
	player.global_position.y += -35
	player.animated_sprite.play("explode")
	
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
