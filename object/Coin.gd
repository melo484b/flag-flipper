extends Node2D


var leaving = false

onready var destruction_timer: Timer = $destruction_timer
onready var pickup_sfx: Node = $pickup


func _physics_process(_delta) -> void:
	if leaving:
		position.y -= 30


func get_collected() -> void:
	pickup_sfx.play()
	Scorekeeper.increment_score()
	destruction_timer.start()
	leaving = true


func _on_Area2D_area_entered(area) -> void:
	if area.is_in_group("PLAYER"):
		get_collected()


func _on_destruction_timer_timeout() -> void:
	queue_free()
