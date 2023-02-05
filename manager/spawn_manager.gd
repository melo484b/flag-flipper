extends Node


signal spawning


var spawn_parameter_x1: float = 32.0
var spawn_parameter_x2: float = 992.0
var spawn_parameter_y1: float = 64.0
var spawn_parameter_y2: float = 544.0
var spawn_position: Vector2 = Vector2()
var block: PackedScene = preload("res://map/block.tscn")
var coin: PackedScene = preload("res://object/Coin.tscn")
var rng = RandomNumberGenerator.new()

onready var block_spawn_timer: Timer = $spawn_timer
onready var coin_spawn_timer: Timer = $coin_spawn_timer


func _ready() -> void:
	rng.randomize()
	set_timer_length()


func start_spawning() -> void:
	block_spawn_timer.start()
	coin_spawn_timer.start()


func set_timer_length() -> void:
	block_spawn_timer.wait_time = rng.randf_range(0.5, 1.8)


func spawn_block() -> void:
	var block_instance = create_block()
	get_parent().add_child(block_instance)
	block_instance.initialize_shape()


func spawn_coin() -> void:
	var coin_instance = coin.instance()
	generate_spawn_position()
	coin_instance.position = spawn_position
	get_parent().add_child(coin_instance)


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


func _on_coin_spawn_timer_timeout():
	spawn_coin()
