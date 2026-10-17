extends Control

signal restart;
signal stop

@onready var label = $Label

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
	label.text = "%6.2f s" % time

func end():
	running = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	label.text = "%6.2f s" % time
	
