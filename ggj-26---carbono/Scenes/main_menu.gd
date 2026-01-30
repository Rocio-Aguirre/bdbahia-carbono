extends Control


func _on_play_button_pressed() -> void:
	TransitionManager.change_scene("res://Levels/TutorialZone/TutorialArea.tscn",0.5)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
