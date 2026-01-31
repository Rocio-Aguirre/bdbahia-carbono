extends Node2D

@onready var player: CharacterBody2D = $Characters/Player
@onready var ui: CanvasLayer = $UI
@onready var corridor: Node2D = $Level/Corridor

func _ready() -> void:
	GlobalData.corridor_enabled.connect(show_corridor)
	GlobalData.pickup_lying_mask.connect(pickup_mask)
	GlobalData.end_tutorial.connect(end_tutorial)
	GlobalData._init()
	AudioManager.play_theme("GAMEPLAY")
	$UI.show_info("Objetivo: Entra a la fiesta.")


func end_tutorial():
	$Characters/Guardia/SlideSound.play()
	var tween = create_tween()
	tween.tween_property($Characters/Guardia,"global_position",$Characters/Guardia.global_position+Vector2(100,100),1.75)
	$Level/DoorArea.enable()




func pickup_mask():
	$Level/Corridor/LyingMask.queue_free()


func show_corridor():
	corridor.visible = true
	$Level/Corridor/Arrow.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property($Level/FogofWar,"modulate:a",0.0,1.0)
	tween.tween_property($Level/Corridor/Arrow,"modulate:a",1.0,2.0)
	


func _on_background_music_finished() -> void:
	await get_tree().create_timer(1.0)
	$Level/BackgroundMusic.play()
