extends Node2D


signal collected


var leaving = false

onready var destruction_timer: Timer = $destruction_timer


func _physics_process(_delta):
	if leaving:
		position.y -= 20


func get_collected() -> void:
	emit_signal("collected")
	destruction_timer.start()
	leaving = true


func _on_Area2D_area_entered(area) -> void:
	if area.is_in_group("PLAYER"):
		get_collected()


func _on_destruction_timer_timeout():
	queue_free()
