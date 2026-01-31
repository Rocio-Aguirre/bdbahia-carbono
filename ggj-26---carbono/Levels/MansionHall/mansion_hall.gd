extends Node2D

func _ready() -> void:
	GlobalData.both_masks_aquired = true
	GlobalData.equip_mask()
	AudioManager.play_theme("GAMEPLAY")
	$UI.show_info("Objetivo: Resuelve el asesinato.")
	$UI.enable_journal()
	$UI.enable_mask_button()
 
