extends Control

@export var menu_screen: PackedScene = null

@onready var credits_container = $CreditsTextContainer
@onready var proceed_container = $ProceedTextContainer
@onready var credits_text_scene = preload("res://scenes/credits_text.tscn")
@onready var proceed_text_scene = preload("res://scenes/proceed_to_title_text.tscn")

var ready_to_proceed = false

func _ready():
	var credits_text_instance = credits_text_scene.instantiate()
	var proceed_text_instance = proceed_text_scene.instantiate()
	await get_tree().create_timer(2.5).timeout
	credits_container.add_child(credits_text_instance)
	proceed_container.add_child(proceed_text_instance)
	ready_to_proceed = true

func _process(_delta):
	if ready_to_proceed == true && Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_packed(menu_screen)
