extends TileMap


onready var top: Position2D = $top
onready var bottom: Position2D = $bottom


func get_top_position() -> Vector2:
	return top.position


func get_bottom_position() -> Vector2:
	return bottom.position
