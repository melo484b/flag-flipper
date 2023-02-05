extends Node2D


const PLAYER_START_POS: Vector2 = Vector2(498, 530)

var player: PackedScene = preload("res://player/player.tscn")

onready var spawn_manager: Node = $spawn_manager
onready var level_movement_manager: Node2D = $level_movement_manager
onready var ui: Control = $UI


func new_game() -> void:
	Scorekeeper.score = 0
	spawn_player()
	level_movement_manager.reset()


func spawn_player() -> void:
	var new_player = player.instance()
	new_player.position = PLAYER_START_POS
	add_child(new_player)

func _on_spawn_manager_spawning() -> void:
	spawn_manager.spawn_block()


# TODO: End the game
func _on_death_area_death() -> void:
	ui.game_over()


func _on_UI_start_game() -> void:
	new_game()
