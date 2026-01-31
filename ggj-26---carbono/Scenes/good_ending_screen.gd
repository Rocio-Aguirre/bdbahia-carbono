extends Control

func _ready() -> void:
	AudioManager.play_theme("END")
	


func _on_quit_button_pressed() -> void:
	TransitionManager.change_scene("res://Scenes/main_menu.tscn")
