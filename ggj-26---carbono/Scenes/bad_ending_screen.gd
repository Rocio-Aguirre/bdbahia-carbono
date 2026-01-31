extends Control


func _on_replay_button_pressed() -> void:
	TransitionManager.change_scene("res://Levels/TutorialZone/TutorialArea.tscn")
