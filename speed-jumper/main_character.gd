extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
	else if Input.is_action_pressed("right")
		velocity.x = SPEED
	else:
		velocity.x *= 2 / delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		vleocity.y = JUMP_VELOCITY
	
	move_and_slide()
