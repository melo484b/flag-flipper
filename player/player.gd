extends KinematicBody2D


var velocity: Vector2 = Vector2.ZERO
export var speed: int = 200
export var jump_power: int = -1000
export var gravity: int = 3000
export var acceleration: float = 0.25
var direction: int = -1
var jumps: int = 2
var fatigued: bool = false

onready var flag: AnimatedSprite = $flag
onready var fatigue_timer: Timer = $fatigue
onready var sprint_timer: Timer = $sprint
onready var wall_detector: Area2D = $Area2D
onready var hurt_sfx: Node = $hurt
onready var jump_sfx: Node = $jump
onready var sprint_sfx: Node = $sprint_sfx
onready var reverse_sfx: Node = $reverse


func _ready() -> void:
	pass


func _physics_process(delta) -> void:
	get_input()
	game_movement()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func get_input() -> void:
	if Input.is_action_just_pressed("jump"):
		if jumps > 0:
			jump_sfx.play()
			jumps -= 1
			velocity.y = jump_power
	if Input.is_action_just_pressed("reverse") and not fatigued:
		reverse_sfx.play()
		jumps = int(clamp(jumps + 1, 1, 2))
		velocity.x = 0
		reverse_direction()
		flag.spin()
		fatigued = true
		fatigue_timer.start()
	if Input.is_action_just_pressed("sprint"):
		sprint_sfx.play()
		acceleration = 1.0
		speed = 600
		sprint_timer.start()


func game_movement() -> void:
	velocity.x = lerp(velocity.x, direction * speed, acceleration)
	

func reverse_direction() -> void:
	direction *= -1


func _on_fatigue_timeout() -> void:
	fatigued = false


func _on_Area2D_body_entered(body) -> void:
	if body.is_in_group("WALL"):
		hurt_sfx.play()
		reverse_direction()
		flag.spin()


func _on_Area2D_area_entered(area) -> void:
	if area.is_in_group("DEATH"):
		queue_free()


func _on_sprint_timeout() -> void:
	acceleration = 0.25
	speed = 200
