extends AnimatedSprite


var direction: String = "e"


func spin() -> void:
	if direction == "e":
		$AnimationPlayer.play("spin")
		direction = "w"
	else:
		$AnimationPlayer.play_backwards("spin")
		direction = "e"
