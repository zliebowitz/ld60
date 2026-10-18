extends Node2D

var level = 1
var current_level_root: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level_root = get_node("LevelRoot")
	_load_level(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# LEVEL MANAGEMENT
func _load_level(level_number: int) -> void:
	if current_level_root:
		current_level_root.queue_free()
	
	var level_path = "res://scenes/levels/level_%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "LevelRoot"
	_setup_level(current_level_root)

func _setup_level(level_root: Node) -> void:
	# Connect enemies
	var player = level_root.get_node_or_null("Player")
	if player:
		player.died.connect(_on_player_died)
		
	var goal = level_root.get_node_or_null("Goal")
	if goal:
		goal.body_entered.connect(_on_goal_body_entered)
				
				
# SIGNAL HANDLERS
func _on_goal_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		body.can_move = false
		print("Goal")
		call_deferred("_load_level",level)


func _on_player_died() -> void:
	print("Player Died")
	
	call_deferred("_load_level",level)
