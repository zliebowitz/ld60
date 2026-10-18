extends PathFollow2D

@export var speed := 60.0
var dir := 1

func _ready() -> void:
	loop = false
	rotates = false

func _physics_process(delta: float) -> void:
	progress += speed * dir * delta
	if progress_ratio >= 1.0:
		dir = -1
	elif progress_ratio <= 0.0:
		dir = 1
