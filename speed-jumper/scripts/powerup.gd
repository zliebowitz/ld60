extends Area2D

@export var type: Power.Type

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and GameState.give_power(type):
		queue_free()
