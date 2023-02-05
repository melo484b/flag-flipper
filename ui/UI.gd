extends Control


signal start_game


onready var button_container: CenterContainer = $button_container
onready var button: Button = $button_container/MarginContainer/PanelContainer/MarginContainer/Button
onready var game_over_container: MarginContainer = $game_over_container
onready var score_label: Label = $CanvasLayer/CenterContainer/HBoxContainer/score_label
onready var game_over_timer: Timer = $game_over_timer


func _process(_delta) -> void:
	update_score()


func update_score() -> void:
	score_label.text = str(Scorekeeper.score)


func _on_Button_pressed() -> void:
	button.release_focus()
	button_container.hide()
	game_over_container.hide()
	emit_signal("start_game")


func game_over() -> void:
	game_over_container.show()
	game_over_timer.start()
	button_container.show()


func _on_game_over_timer_timeout() -> void:
	game_over_container.hide()
	
