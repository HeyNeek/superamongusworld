extends Node2D
class_name HorizontalMovingPlatform

@onready var animation_player = $AnimationPlayer

func _on_area_2d_body_entered(body):
	print(body.name)
