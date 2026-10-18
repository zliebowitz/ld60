extends CanvasLayer

@export var dash_icon: Texture2D
@export var double_jump_icon: Texture2D

@onready var death_label: Label = %DeathLabel
@onready var time_label: Label = %TimeLabel
@onready var power_icon: TextureRect = %PowerIcon
@onready var power_label: Label = %PowerLabel

# name shown, which input action triggers it, and the hint text
const POWER_INFO := {
	Power.Type.DASH: {"name": "DASH", "action": "dash", "hint": "%s  ·  1 use"},
	Power.Type.DOUBLE_JUMP: {"name": "DOUBLE JUMP", "action": "jump", "hint": "%s in air  ·  1 use"},
}

func _ready() -> void:
	GameState.deaths_changed.connect(_on_deaths_changed)
	GameState.power_changed.connect(_on_power_changed)
	_on_deaths_changed(GameState.deaths)
	_on_power_changed(GameState.power)


func _process(_delta: float) -> void:
	time_label.text = GameState.format_time()


func _on_deaths_changed(count: int) -> void:
	death_label.text = "Deaths: %d" % count

func _key_for(action: StringName) -> String:
	var events := InputMap.action_get_events(action)
	if events.is_empty():
		return "?"
	return events[0].as_text().get_slice(" (", 0)   # "Shift (Physical)" -> "Shift"


func _on_power_changed(power: Power.Type) -> void:
	
	if power == Power.Type.NONE:
		power_label.text = "NO POWERS - Grab an orb: one use, one at a time"
	else:
		var info: Dictionary = POWER_INFO[power]
		var power_name = info["name"]
		var power_hint = info["hint"] % _key_for(info["action"])
		power_label.text = power_name + " - " + power_hint
		
	match power:
		Power.Type.DASH:
			power_icon.texture = dash_icon
		Power.Type.DOUBLE_JUMP:
			power_icon.texture = double_jump_icon
		_:
			power_icon.texture = null
			
			
	
