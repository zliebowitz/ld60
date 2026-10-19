extends PathFollow2D

@onready var saw_path: Path2D = $".."

@export var speed := 60.0
@export var auto_detect_loop := true  # loop if the curve ends where it starts
@export var force_loop := false       # force looping even if auto-detect says no

var dir := 1
var is_loop := false

func _ready() -> void:
	rotates = false
	is_loop = force_loop or (auto_detect_loop and _path_is_closed())
	loop = is_loop

func _physics_process(delta: float) -> void:
	progress += speed * dir * delta
	if is_loop:
		return  # loop = true wraps progress for us
	if progress_ratio >= 1.0:
		dir = -1
	elif progress_ratio <= 0.0:
		dir = 1

func _path_is_closed() -> bool:
	var curve := saw_path.curve
	if curve == null or curve.point_count < 3:
		return false
	var first := curve.get_point_position(0)
	var last := curve.get_point_position(curve.point_count - 1)
	return first.distance_to(last) < 1.0
