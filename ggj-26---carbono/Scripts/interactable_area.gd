extends Area2D
class_name InteractableArea


@export var texture: Texture
@export var dialogue: DialogueResource
@export var max_width: float
@export var max_height: float
var player_near: bool = false

func _ready() -> void:
	$Question.visible = false
	$Sprite.texture = texture
	set_max_size($Sprite,max_width,max_height)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = true
		$Question.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = false
		$Question.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and player_near:
		DialogueManager.show_dialogue_balloon(dialogue)
		GlobalData.is_in_dialogue = true

func set_max_size(sprite: Sprite2D, max_width: float, max_height: float):
	var texture = sprite.texture
	if texture == null:
		return

	# 1. Obtenemos el tamaño original de la imagen
	var tex_width = texture.get_width()
	var tex_height = texture.get_height()
	
	# 2. Si ya es más chico que el máximo, no hacemos nada (opcional)
	if tex_width <= max_width and tex_height <= max_height:
		return 

	# 3. Calculamos cuánto hay que achicarlo para que entre
	var scale_x = max_width / tex_width
	var scale_y = max_height / tex_height
	
	# 4. Elegimos la escala MENOR para mantener la proporción (Aspect Ratio)
	# Si usamos la menor, nos aseguramos que entre en el ancho Y en el alto
	var final_scale = min(scale_x, scale_y)
	
	sprite.scale = Vector2(final_scale, final_scale)
