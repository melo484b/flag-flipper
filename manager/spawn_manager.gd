extends Node


signal spawning


var spawn_parameter_x1: float = 32.0
var spawn_parameter_x2: float = 992.0
var spawn_parameter_y1: float = 64.0
var spawn_parameter_y2: float = 544.0
var spawn_position: Vector2 = Vector2()
var block: PackedScene = preload("res://map/block.tscn")
var rng = RandomNumberGenerator.new()

onready var spawn_timer: Timer = $spawn_timer


func _ready() -> void:
	rng.randomize()
	set_timer_length()


func start_spawning() -> void:
	spawn_timer.start()


func set_timer_length() -> void:
	spawn_timer.wait_time = rng.randf_range(0.5, 2.5)


func spawn_block() -> void:
	var block_instance = create_block()
	get_parent().add_child(block_instance)
	block_instance.initialize_shape()


func create_block() -> Block:
	var new_block = block.instance()
	generate_spawn_position()
	new_block.position = spawn_position
	return new_block


func generate_spawn_position() -> void:
	rng.randomize()
	var x_pos = rng.randf_range(spawn_parameter_x1, spawn_parameter_x2)
	var y_pos = rng.randf_range(spawn_parameter_y1, spawn_parameter_y2)
	spawn_position = Vector2(x_pos, y_pos)


func _on_spawn_timer_timeout() -> void:
	emit_signal("spawning")
