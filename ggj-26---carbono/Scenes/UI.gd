extends CanvasLayer

signal mask_button_pressed


@onready var change_mask_button: TextureButton = $ChangeMaskButton
@onready var announcement_label: Label = $AnnouncementLabel

func _ready() -> void:
	change_mask_button.disabled = true
	change_mask_button.modulate.a = 0.2
	GlobalData.pickup_lying_mask.connect(toggle_mask_enabled)
	
	pass


func show_info(info: String):
	announcement_label.text = info
	announcement_label.show()
	# creacion de tween y aparicion texto
	var tween =  create_tween()
	announcement_label.modulate.a = 0.0
	tween.tween_property(announcement_label,"modulate:a",1.0,1.0)
	# desaparicion texto
	tween.tween_interval(3.0)
	tween.tween_property(announcement_label,"modulate:a",0.0,1.0)
	tween.tween_callback(announcement_label.hide)

func toggle_mask_enabled():
	if change_mask_button.disabled:
		change_mask_button.disabled = false
		change_mask_button.modulate.a = 1.0
	else:
		change_mask_button.disabled = true
		change_mask_button.modulate.a = 0.2
		

func _on_change_mask_button_pressed() -> void:
	mask_button_pressed.emit() 
