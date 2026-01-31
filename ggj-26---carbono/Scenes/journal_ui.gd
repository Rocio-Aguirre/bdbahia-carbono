extends CanvasLayer


@onready var suspects_grid: GridContainer = $CenterContainer/JournalPanel/SplitContent/Culprit_Panel/VBoxContainer/SuspectsGrid
@onready var option_button: OptionButton = $CenterContainer/JournalPanel/SplitContent/Culprit_Panel/VBoxContainer2/OptionButton
@onready var submit_button: Button = $CenterContainer/JournalPanel/SplitContent/Culprit_Panel/SubmitButton

var suspect_data = ["Plague","Wolf","Fox","Cat"]

var selected_suspect_name = ""
var selected_icon_name = ""

func _ready() -> void:
	# visible = false
	submit_button.disabled = true
	
	for b in suspects_grid.get_children():
		if b is Button:
			b.toggled.connect(_on_icon_toggled.bind(b))
			



func check_confirm_status():
	if (selected_suspect_name != "") and (selected_icon_name != ""):
		submit_button.disabled = false


func _on_icon_toggled(toggled_on: bool, button: Button):
	if toggled_on:
		var index = button.get_index()
		if index < suspect_data.size():
			selected_icon_name = suspect_data[index]
		else:
			print("ERROR: El botón ", index, " no tiene nombre en la lista suspect_data")
	else:
		var index = button.get_index()
		if index < suspect_data.size() and selected_suspect_name == suspect_data[index]:
			selected_icon_name = ""
		return
	print(selected_icon_name)
	check_confirm_status()




func _on_submit_button_pressed() -> void:
	if selected_icon_name=="Cat" and selected_suspect_name == "La Hija":
		TransitionManager.change_scene("res://Scenes/GoodEndingScreen.tscn")
	else:
		TransitionManager.change_scene("res://Scenes/BadEndingScreen.tscn")


func _on_option_button_item_selected(index: int) -> void:
	if index > -1:
		selected_suspect_name = option_button.get_item_text(index)
	check_confirm_status()


func _on_quit_button_pressed() -> void:
	visible = false
