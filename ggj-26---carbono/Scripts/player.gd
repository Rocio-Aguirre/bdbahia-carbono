extends CharacterBody2D

var speed = 300.0
@onready var step_timer: Timer = $StepTimer
const SOUND_STEP = preload("res://Audio/2 pasos.wav")

func _ready() -> void:
	GlobalData.mask_changed.connect(update_player_graphic)


func play_step_sound():
	AudioManager.play_sfx(SOUND_STEP, 0.0, 0.2)

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
		if velocity.length() > 0:
			if step_timer.is_stopped():
				play_step_sound()
				step_timer.start()
		move_and_slide()
