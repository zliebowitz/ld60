extends Area2D

@export var type: Power.Type
@onready var timer: Timer = $Timer
@onready var powerup_sound: AudioStreamPlayer2D = $PowerupSound

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if visible && body.is_in_group("player") and GameState.give_power(type):
		powerup_sound.play()
		visible = false
		timer.start(3)
		



func _on_timer_timeout() -> void:
	visible = true
