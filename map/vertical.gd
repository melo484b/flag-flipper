extends TileMap


onready var left_wall: Position2D = $left_wall
onready var right_wall: Position2D = $right_wall


func get_distance_between() -> float:
	return left_wall.distance_to(right_wall)


func get_positions() -> Array:
	return [left_wall.position, right_wall.position]
