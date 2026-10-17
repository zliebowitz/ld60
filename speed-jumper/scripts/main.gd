extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setup_level() -> void:
	# Connect enemies
	var player = $LevelRoot.get_node_or_null("Player")
	if player:
		player.died.connect(_on_player_died)
				
				
# SIGNAL HANDLERS
func _on_player_died() -> void:
	print("Player Died")
