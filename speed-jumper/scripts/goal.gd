extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal goal_complete

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "win":
		goal_complete.emit()
		
func goal_reached() -> void:
	animated_sprite_2d.animation = "win"
	
