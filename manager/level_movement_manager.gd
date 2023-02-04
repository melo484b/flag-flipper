extends Node2D


var wall_direction: int = 1
var floor_direction: int = -1
var ceiling_direction: int = 1
var travel_speed: float = 0.25

onready var wall_tiles: TileMap = $walls
onready var floor_tiles: TileMap = $floor
onready var celing_tiles: TileMap = $ceiling

func _physics_process(delta) -> void:
	move_floor()
	move_celing()
	if Input.is_action_just_pressed("reverse"):
		reverse_direction()

func move_wall() -> void:
	wall_tiles.position.y += travel_speed * wall_direction

func move_floor() -> void:
	floor_tiles.position.y += travel_speed * floor_direction

func move_celing() -> void:
	celing_tiles.position.y += travel_speed * ceiling_direction

func reverse_direction() -> void:
	wall_direction *= -1
	floor_direction *= -1
	ceiling_direction *= -1
