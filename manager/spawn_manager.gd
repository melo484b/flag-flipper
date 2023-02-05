extends Node


signal spawning


const SPAWN_X1: float = 32.0
const SPAWN_X2: float = 992.0
const SPAWN_Y1: float = 64.0
const SPAWN_Y2: float = 544.0

var spawn_position: Vector2 = Vector2()
var block: PackedScene = preload("res://map/block.tscn")
var rng = RandomNumberGenerator.new()

onready var spawn_timer: Timer = $spawn_timer


func _ready() -> void:
	set_timer_length()


func set_timer_length() -> void:
	rng.randomize()
	spawn_timer.wait_time = rng.randf_range(0.5, 2.0)


func spawn_block() -> void:
	var new_block = block.instance()
	new_block.set_size(rng.randi_range(0, 2))
	generate_spawn_position()
	new_block.position = spawn_position
	get_parent().add_child(new_block)


func generate_spawn_position() -> void:
	rng.randomize()
	var x_pos = rng.randf_range(SPAWN_X1, SPAWN_X2)
	var y_pos = rng.randf_range(SPAWN_Y1, SPAWN_Y2)
	spawn_position = Vector2(x_pos, y_pos)


func _on_spawn_timer_timeout() -> void:
	emit_signal("spawning")
