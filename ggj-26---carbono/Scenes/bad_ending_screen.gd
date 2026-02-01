extends Control

@export var hint_array: Array = []

func _ready() -> void:
	AudioManager.play_theme("END",0.1)
	$Label.text = hint_array.pick_random()
	


func _on_replay_button_pressed() -> void:
	TransitionManager.change_scene("res://Levels/TutorialZone/TutorialArea.tscn")




func _on_quit_button_pressed() -> void:
	TransitionManager.change_scene("res://Scenes/main_menu.tscn")
