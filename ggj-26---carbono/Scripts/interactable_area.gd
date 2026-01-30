extends Area2D
class_name InteractableArea


@export var texture: Texture
@export var dialogue: DialogueResource

var player_near: bool = false

func _ready() -> void:
	$Sprite.texture = texture
	$Outline.texture = texture
	$Outline.scale*=1.005
	$Outline.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = true
		$Outline.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = false
		$Outline.visible = false
		

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and player_near:
		DialogueManager.show_dialogue_balloon(dialogue)
		GlobalData.is_in_dialogue = true
