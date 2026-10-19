extends Path2D

@export var track_color := Color(0.30, 0.32, 0.40)
@export var track_width := 2.0
@export var saw_speed: float = 60.0
	

func _ready() -> void:
	$SawFollow.speed = saw_speed
	curve = curve.duplicate()
	var line := Line2D.new()
	line.points = curve.get_baked_points()
	line.width = track_width
	line.default_color = track_color
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	line.show_behind_parent = true   # draws behind the saw, same layer as everything else
	add_child(line)
