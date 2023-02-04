extends KinematicBody2D


var velocity: Vector2 = Vector2()
export var speed: int = 200
export var jump_power = 2000
var direction: int = -1
var jumps: int = 2

onready var flag = $flag


func _ready() -> void:
	pass


func _physics_process(_delta) -> void:
	get_input()
	game_movement()
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)


func get_input() -> void:
	if Input.is_action_just_pressed("jump"):
		if jumps > 0:
			jumps -= 1
			velocity.y -= jump_power
	if Input.is_action_just_pressed("reverse"):
		jumps = 2
		direction *= -1
		flag.spin()


func game_movement() -> void:
	velocity.x += direction
	if !is_on_floor():
		velocity.y += 20
