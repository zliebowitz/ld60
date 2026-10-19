extends CanvasLayer

@onready var label: Label = $Label

func _ready() -> void:
	layer = 100
	GameState.stop_timer()
	label.text = "YOU WIN!\n\nDeaths: %d\nTime: %s" % [GameState.deaths, GameState.format_time()]
	show()
