extends Area2D

@onready var animated_trophy_sprite = $AnimatedTrophySprite
@onready var sparkler1 = $Sparkler1
@onready var sparkler2 = $Sparkler2
@onready var win_text_scene = preload("res://scenes/win_text.tscn")

func _on_body_entered(body):
	animated_trophy_sprite.play("victory")
	sparkler1.emitting = true
	sparkler2.emitting = true
	var win_text_instance = win_text_scene.instantiate()
	body.add_child(win_text_instance)
	win_text_instance.global_position.x += 125
