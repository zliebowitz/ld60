extends PathFollow2D
@onready var animated_sprite_2d: AnimatedSprite2D = $Slug/AnimatedSprite2D

@export var speed := 100.0
var dir := 1
var _last_x := 0.0

func _ready() -> void:
	loop = false
	rotates = false
	_last_x = global_position.x


func _physics_process(delta: float) -> void:
	progress += speed * dir * delta
	if progress_ratio >= 1.0:
		dir = -1
	elif progress_ratio <= 0.0:
		dir = 1
		
	var dx := global_position.x - _last_x
	animated_sprite_2d.flip_h = not (dx > 0.0)
	_last_x = global_position.x
	
	
