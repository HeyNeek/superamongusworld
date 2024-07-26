extends ParallaxBackground

@onready var sprite = $ParallaxLayer/Sprite2D

var scroll_speed = 10

func _process(delta):
	sprite.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	
	if sprite.region_rect.position >= Vector2(64, 64):
		sprite.region_rect.position = Vector2.ZERO
