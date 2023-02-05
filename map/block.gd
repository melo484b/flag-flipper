class_name Block
extends StaticBody2D


var size: String = "single"
var sizes: Array = ["single", "double", "quad"]
var collision_shape_extents: Array = [16, 32, 64]
var width: int = 32
var coins: int = 1
var leaving: bool = false
var rng = RandomNumberGenerator.new()
var single_texture: Texture = load("res://sprite/single_block.png")
var double_texture: Texture = load("res://sprite/double_block.png")
var quad_texture: Texture = load("res://sprite/quad_block.png")
var coin: PackedScene = preload("res://object/Coin.tscn")

onready var coin_location_1: Position2D = $coin_location_1
onready var coin_location_2: Position2D = $coin_location_2
onready var coin_location_3: Position2D = $coin_location_3
onready var collider_shape: CollisionShape2D = $CollisionShape2D
onready var sprite: Sprite = $Sprite


func _init():
	rng.randomize()
	set_size(rng.randi_range(0, 2))


func _ready() -> void:
	spawn_coins()
	$expiration_timer.start()


func _physics_process(_delta) -> void:
	if leaving:
		position.y += 20


func set_size(array_pos: int) -> void:
	size = sizes[array_pos]


func initialize_shape() -> void:
	match size:
		"single":
			collider_shape.shape.extents.x = 16
			sprite.texture = single_texture
			width = 32
			coins = 1
		"double":
			collider_shape.shape.extents.x = 32
			sprite.texture = double_texture
			width = 64
			coins = 2
		"quad":
			collider_shape.shape.extents.x = 64
			sprite.texture = quad_texture
			width = 128
			coins = 3
		_:
			pass


func spawn_coins() -> void:
	match coins:
		1:
			var coin_1 = coin.instance()
			coin_1.position = coin_location_2.position
			add_child(coin_1)
		2:
			var coin_1 = coin.instance()
			coin_1.position = coin_location_1.position
			add_child(coin_1)
			var coin_3 = coin.instance()
			coin_3.position = coin_location_3.position
			add_child(coin_3)
		3:
			var coin_1 = coin.instance()
			coin_1.position = coin_location_1.position
			add_child(coin_1)
			var coin_2 = coin.instance()
			coin_2.position = coin_location_2.position
			add_child(coin_2)
			var coin_3 = coin.instance()
			coin_3.position = coin_location_3.position
			add_child(coin_3)
		_:
			pass


func _on_expiration_timer_timeout() -> void:
	leaving = true


func _on_Area2D_area_entered(area) -> void:
	if area.is_in_group("DEATH"):
		queue_free()
