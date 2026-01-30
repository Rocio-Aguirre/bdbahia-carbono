extends CharacterBody2D

var speed = 300.0



func _unhandled_input(event: InputEvent) -> void:
	if not GlobalData.is_in_dialogue:
		if event.is_action_pressed("change_mask") and not GlobalData.is_lying_mask_equipped:
			GlobalData.is_lying_mask_equipped = true
			$Sprite2D.modulate = Color.RED
		elif event.is_action_pressed("change_mask") and GlobalData.is_lying_mask_equipped:
			GlobalData.is_lying_mask_equipped = false
			$Sprite2D.modulate = Color.WHITE


func _physics_process(delta: float) -> void:
	if not GlobalData.is_in_dialogue:
		var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		velocity = direction*speed
		move_and_slide()
