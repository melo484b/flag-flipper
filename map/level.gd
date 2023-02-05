extends Node2D


onready var spawn_manager: Node = $spawn_manager
onready var level_movement_manager: Node2D = $level_movement_manager


func _on_spawn_manager_spawning():
	spawn_manager.spawn_block()


# TODO: End the game
func _on_death_area_death():
	pass # Replace with function body.
