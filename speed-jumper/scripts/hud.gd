extends CanvasLayer

@export var dash_icon: Texture2D
@export var double_jump_icon: Texture2D

@onready var death_label: Label = %DeathLabel
@onready var time_label: Label = %TimeLabel
@onready var power_icon: TextureRect = %PowerIcon
@onready var power_label: Label = %PowerLabel


func _ready() -> void:
	GameState.deaths_changed.connect(_on_deaths_changed)
	GameState.power_changed.connect(_on_power_changed)
	_on_deaths_changed(GameState.deaths)
	_on_power_changed(GameState.power)


func _process(_delta: float) -> void:
	time_label.text = GameState.format_time()


func _on_deaths_changed(count: int) -> void:
	death_label.text = "Deaths: %d" % count


func _on_power_changed(power: Power.Type) -> void:
	match power:
		Power.Type.DASH:
			power_icon.texture = dash_icon
			power_label.text = "Dash"
		Power.Type.DOUBLE_JUMP:
			power_icon.texture = double_jump_icon
			power_label.text = "Double Jump"
		_:
			power_icon.texture = null
			power_label.text = "-"
