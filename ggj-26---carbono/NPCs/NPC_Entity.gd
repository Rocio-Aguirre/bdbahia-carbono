extends CharacterBody2D
class_name NPCEntity


@export var dialogue: DialogueResource
@onready var anim_player = $AnimationPlayer

var player_near: bool = false

# Esta función la llamará el Dialogue Manager
func play_anim(anim_name: String):
	print("Haciendo Animacion: "+anim_name)
	# Protección: Si la animación no existe, no hacemos nada para que no crashee
	if not anim_player.has_animation(anim_name):
		push_warning("Animación no encontrada: " + anim_name)
		return

	anim_player.play(anim_name)
	
	# LÓGICA AUTOMÁTICA (Quality of Life para la Jam)
	# Si es un gesto corto (Afirmativo/Negativo), volvemos a IDLE solos
	if anim_name in ["AFFIRMATIVE", "NEGATIVE"]:
		await anim_player.animation_finished
		anim_player.play("IDLE")


func _ready() -> void:
	play_anim("IDLE")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(_dialogo):
	play_anim("IDLE")
	GlobalData.is_in_dialogue = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and player_near:
		DialogueManager.show_example_dialogue_balloon(dialogue,"start",[self])
		GlobalData.is_in_dialogue = true



func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = true
		$Exclamation.visible = true


func _on_player_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = false
		$Exclamation.visible = false
		
