extends Area2D


signal death
signal clean_up


func _on_death_area_area_entered(area) -> void:
	if area.is_in_group("PLAYER"):
		emit_signal("death")
	if area.is_in_group("BLOCK"):
		emit_signal("clean_up")
