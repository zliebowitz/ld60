extends Node

signal deaths_changed(count: int)
signal power_changed(power: Power.Type)

var deaths := 0
var time := 0.0
var running := true
var power: Power.Type = Power.Type.NONE


func _process(delta: float) -> void:
	if running:
		time += delta


func register_death() -> void:
	deaths += 1
	deaths_changed.emit(deaths)
	clear_power()   # dying drops your powerup


func give_power(p: Power.Type) -> bool:
	if power != Power.Type.NONE:
		return false   # already holding one
	power = p
	power_changed.emit(power)
	return true


func consume_power() -> void:
	clear_power()


func clear_power() -> void:
	power = Power.Type.NONE
	power_changed.emit(power)


func stop_timer() -> void:
	running = false


func reset_run() -> void:
	deaths = 0
	time = 0.0
	running = true
	deaths_changed.emit(deaths)
	clear_power()


func format_time() -> String:
	var minutes := floori(time / 60.0)
	var seconds := floori(fmod(time, 60.0))
	var hundredths := floori(fmod(time, 1.0) * 100.0)
	return "%02d:%02d.%02d" % [minutes, seconds, hundredths]
