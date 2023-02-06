extends Node2D


const FLOOR_START_POS: Vector2 = Vector2(-2, 244)
const CEILING_START_POS: Vector2 = Vector2(-2, -236)

var wall_direction: int = 1
var floor_direction: int = 1
var ceiling_direction: int = 1
var travel_speed: float = 0.25
var speed_increment: float = 0.05


onready var wall_tiles: TileMap = $walls
onready var floor_tiles: TileMap = $floor
onready var ceiling_tiles: TileMap = $ceiling


func _physics_process(_delta) -> void:
	move_floor()
	move_ceiling()
	if ceiling_tiles.position > FLOOR_START_POS or floor_tiles.position < CEILING_START_POS:
		reverse_direction()
	if Input.is_action_just_pressed("obstacle_reverse"):
		reverse_direction()


func move_wall() -> void:
	wall_tiles.position.y += travel_speed * wall_direction


func move_floor() -> void:
	floor_tiles.position.y += travel_speed * floor_direction


func move_ceiling() -> void:
	ceiling_tiles.position.y += travel_speed * ceiling_direction


func reverse_direction() -> void:
	wall_direction *= -1
	floor_direction *= -1
	ceiling_direction *= -1


func reset() -> void:
	floor_tiles.position = FLOOR_START_POS
	ceiling_tiles.position = CEILING_START_POS
	travel_speed = 0.25
	$good_bye.start()


func _on_speed_up_timeout() -> void:
	travel_speed += speed_increment


func _on_good_bye_timeout() -> void:
	travel_speed *= 2
