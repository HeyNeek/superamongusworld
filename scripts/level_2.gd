extends Node2D

@onready var stage_music = $StageMusic

func _ready():
	stage_music.play()

func reset_game():
	get_tree().reload_current_scene()

func _on_deathzone_body_entered(_body):
	await get_tree().create_timer(3).timeout
	reset_game()
