extends Path2D


@export var slug_speed: float = 100.0
	

func _ready() -> void:
	$SlugFollow.speed = slug_speed
