extends CharacterBody2D

signal died

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var landing_sound: AudioStreamPlayer2D = $LandingSound


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const DASH_SPEED = 900.0    
const DASH_TIME = 0.15       
const DASH_COOLDOWN = 0.4   
 
var alive = true
var can_move = true

var dash_timer = 0.0        
var dash_cooldown = 0.0      


func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	
	if !alive:
		return
	
	dash_cooldown = maxf(dash_cooldown - delta, 0.0)

	# DASH: start a dash
	if can_move and Input.is_action_just_pressed("dash") and dash_cooldown <= 0.0 and GameState.power == Power.Type.DASH:
		var held := Input.get_axis("left", "right")
		if held != 0.0:
			animated_sprite_2d.flip_h = held < 0.0
		dash_timer = DASH_TIME
		dash_cooldown = DASH_COOLDOWN
		GameState.consume_power()

	# DASH: while dashing, fixed speed, no gravity, no other control
	if dash_timer > 0.0:
		dash_timer -= delta
		var facing := -1.0 if animated_sprite_2d.flip_h else 1.0
		velocity.x = facing * DASH_SPEED
		velocity.y = 0.0
		if animated_sprite_2d.sprite_frames.has_animation("dash"):
			animated_sprite_2d.animation = "dash"
		else:
			animated_sprite_2d.animation = "run"
		move_and_slide()
		if dash_timer <= 0.0:
			velocity.x = clampf(velocity.x, -SPEED, SPEED)
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
		if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				velocity.y = JUMP_VELOCITY
				jump_sound.play()
			elif GameState.power == Power.Type.DOUBLE_JUMP:
				velocity.y = JUMP_VELOCITY
				jump_sound.play()
				GameState.consume_power()

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		var was_airborne := not is_on_floor()
		move_and_slide()
		if was_airborne and is_on_floor():
			landing_sound.play();
			
		if direction > 0.0:
			animated_sprite_2d.flip_h = false;
		elif direction < 0.0:
			animated_sprite_2d.flip_h = true;
		
		
func die() -> void:
	GameState.register_death()
	animated_sprite_2d.animation = "death"
	alive = false;
	death_sound.play()


func _on_hitbox_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if _area.is_in_group("enemy") and alive:
		die()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		died.emit()
