extends CharacterBody2D

var speed = 300.0

func _ready() -> void:
	GlobalData.mask_changed.connect(update_player_graphic)



func update_player_graphic(_state):
	match GlobalData.current_mask:
		GlobalData.MaskState.MASKLESS:
			$Sprite2D.modulate = Color.WHITE
		GlobalData.MaskState.TRUTH_MASK:
			$Sprite2D.modulate = Color.GREEN
		GlobalData.MaskState.LYING_MASK:
			$Sprite2D.modulate = Color.RED


func _physics_process(delta: float) -> void:
	if not GlobalData.is_in_dialogue:
		var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		velocity = direction*speed
		move_and_slide()
