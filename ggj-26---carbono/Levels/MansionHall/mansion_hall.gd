extends Node2D

func _ready() -> void:
	GlobalData.both_masks_aquired = true
	GlobalData.equip_mask()
	$UI.enable_journal()
	$UI.enable_mask_button()
