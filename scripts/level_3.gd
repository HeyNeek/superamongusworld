extends Node2D

@onready var clear_music = $ClearMusic
@onready var stage_music = $StageMusic
@onready var yippee_sound = $YippeeSound

@onready var continue_text_scene = preload("res://scenes/continue_text.tscn")

@onready var vert_spike_ball1 = $Traps/SpikeBall
@onready var vert_spike_ball2 = $Traps/SpikeBall2
@onready var vert_spike_ball3 = $Traps/SpikeBall3

@onready var player = $Player

var stage_cleared = false

func _ready():
	stage_music.play()
	
	vert_spike_ball1.animation_player.play("move_down")
	await get_tree().create_timer(1).timeout
	vert_spike_ball2.animation_player.play("move_down")
	await get_tree().create_timer(1).timeout
	vert_spike_ball3.animation_player.play("move_down")

func reset_game():
	get_tree().reload_current_scene()

func _on_trap_touched_player():
	player.is_active = false
	player.animated_sprite.play("explode")
	if player.is_on_floor() == true:
		player.global_position.y += -35
	
	await get_tree().create_timer(2.5).timeout
	
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
