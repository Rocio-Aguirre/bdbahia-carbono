extends Node
signal mask_changed(mask: MaskState)
signal dialogue_entered
signal dialogue_exited
signal init_game


enum MaskState {
	MASKLESS,
	TRUTH_MASK,
	LYING_MASK
}
@onready var current_mask: MaskState = MaskState.MASKLESS


var is_in_dialogue: bool = false
var both_masks_aquired: bool = false


func equip_mask():
	set_mask_state(MaskState.TRUTH_MASK)


func toggle_mask():
	if both_masks_aquired:
		match current_mask:
			MaskState.TRUTH_MASK:
				set_mask_state(MaskState.LYING_MASK)
				return
			MaskState.LYING_MASK:
				set_mask_state(MaskState.TRUTH_MASK)
				return

func set_mask_state(state: MaskState):
	current_mask = state
	mask_changed.emit(current_mask)


func _init():
	set_mask_state(MaskState.MASKLESS)
	tutorial_finished = false
	both_masks_aquired = false
	init_game.emit()






# ---------------- TUTORIAL SIGNALS Y METHODS ------------------------
signal corridor_enabled
signal pickup_lying_mask
signal end_tutorial
var tutorial_finished = false
