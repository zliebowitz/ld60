extends CharacterBody2D

signal died

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var alive = true
var can_move = true


func _ready() -> void:
	died.connect(die)
	

func _physics_process(delta: float) -> void:
	
	if !alive:
		return
	
	# Add animation
	if velocity.x > 0 or velocity.x < 0:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jump"

	if can_move:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_sound.play()

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		
		if direction > 0.0:
			animated_sprite_2d.flip_h = false;
		elif direction < 0.0:
			animated_sprite_2d.flip_h = true;
		
		
func die() -> void:
	animated_sprite_2d.animation = "death"
	alive = false;
	death_sound.play()


func _on_body_entered(body: Node2D) -> void:
	if body == self:
		return
	if body.is_in_group("enemy") and alive:
		died.emit()


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("enemy") and alive:
		died.emit()
