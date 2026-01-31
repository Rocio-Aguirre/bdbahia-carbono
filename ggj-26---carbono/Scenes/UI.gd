extends CanvasLayer

signal mask_button_pressed


@onready var change_mask_button: TextureButton = $ChangeMaskButton
@onready var announcement_label: Label = $AnnouncementLabel
@onready var journal_button: TextureButton = $JournalButton


func enable_journal():
	journal_button.modulate.a = 1.0
	journal_button.disabled = false

func _ready() -> void:
	if GlobalData.tutorial_finished:
		change_mask_button.disabled = false
		journal_button.disabled = false
		change_mask_button.modulate.a = 1.0
		journal_button.modulate.a = 1.0
	else:
		change_mask_button.modulate.a = 0.2
		journal_button.modulate.a = 0.2
	mask_button_pressed.connect(GlobalData.toggle_mask)
	GlobalData.pickup_lying_mask.connect(enable_mask_button)
	GlobalData.end_tutorial.connect(enable_journal)
	


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

func enable_mask_button():
	change_mask_button.disabled = false
	change_mask_button.modulate.a = 1.0

func disable_mask_button():
	change_mask_button.disabled = true
	change_mask_button.modulate.a = 0.2



func _on_change_mask_button_pressed() -> void:
	mask_button_pressed.emit() 


func _on_texture_button_pressed() -> void:
	$AudioStreamPlayer.play(4.28)
	$JournalUI.visible = true


func _on_journal_ui_journal_closed() -> void:
	$AudioStreamPlayer.play(6.18)
