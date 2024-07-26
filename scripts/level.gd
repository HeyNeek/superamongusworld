extends Node2D

@onready var stage_music = $StageMusic

func _ready():
	stage_music.play()

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		print('reloaded')
		reset_game()

func reset_game():
	get_tree().reload_current_scene()

func _on_deathzone_body_entered(_body):
	print("death area entered")
	reset_game()

func _on_trap_touched_player():
	reset_game()
