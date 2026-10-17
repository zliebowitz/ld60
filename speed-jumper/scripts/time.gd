extends Control

signal restart;
signal stop

@onready var label = $Label

const format = "%.1f s"

var time = 0
var running = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	restart.connect(reset)
	stop.connect(end)
	reset()

func reset() -> void:
	time = 0.0
	running = true
	label.text = format % time

func end():
	running = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	label.text = format % time
	
