extends Area2D


signal death


func _on_death_area_area_entered(area):
	if area.is_in_group("PLAYER"):
		emit_signal("death")
