extends Node2D

@onready var player: CharacterBody2D = $Characters/Player
@onready var ui: CanvasLayer = $UI
@onready var corridor: Node2D = $Map/Corridor

func _ready() -> void:
	$UI.mask_button_pressed.connect(GlobalData.toggle_mask)
	GlobalData.corridor_enabled.connect(show_corridor)
	GlobalData.pickup_lying_mask.connect(pickup_mask)
	GlobalData.end_tutorial.connect(end_tutorial)
	$UI.show_info("Objetivo: Entra a la fiesta.")
	$Map/BackgroundMusic.play()


func end_tutorial():
	$Characters/Guardia/SlideSound.play()
	var tween = create_tween()
	tween.tween_property($Characters/Guardia,"global_position",$Characters/Guardia.global_position+Vector2(100,0),1.75)
	print("Fin Tutorial")
	




func pickup_mask():
	$Map/Corridor/LyingMask.queue_free()


func show_corridor():
	corridor.visible = true
	$Map/Corridor/Arrow.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property($Map/Corridor/Arrow,"modulate:a",1.0,2.0)


func _on_background_music_finished() -> void:
	await get_tree().create_timer(1.0)
	$Map/BackgroundMusic.play()
