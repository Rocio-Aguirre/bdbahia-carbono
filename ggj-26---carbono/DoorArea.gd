extends Area2D
@export var DestinationScene: PackedScene
@export var is_enabled: bool
@onready var arrow_sprite = $ArrowSprite
enum WallSide { LEFT_WALL, RIGHT_WALL }
@export var pointing_to: WallSide = WallSide.LEFT_WALL

var player_in_area: bool = false


func setup_arrow_direction() -> void:
	# Ajustamos la rotación según la pared (asumiendo sprite -> derecha)
	match pointing_to:
		WallSide.LEFT_WALL:
			# Apunta Noreste (Arriba-Derecha)
			arrow_sprite.rotation_degrees = -26.6 
		WallSide.RIGHT_WALL:
			# Apunta Noroeste (Arriba-Izquierda)
			arrow_sprite.rotation_degrees = -153.4

func _ready() -> void:
	setup_arrow_direction()
	if not is_enabled:
		$CollisionPolygon2D.disabled = true
		arrow_sprite.visible = false
	start_floating_animation()

func enable():
	$CollisionPolygon2D.disabled = false


# Detectar entrada
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": # O body.is_in_group("Player")
		player_in_area = true
		arrow_sprite.visible = true

# Detectar salida
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = false
		arrow_sprite.visible = false

# Detectar la tecla de acción (Enter / E / Espacio)
func _unhandled_input(event: InputEvent) -> void:
	if player_in_area and event.is_action_pressed("ui_accept"):
		# Acá llamás a tu TransitionManager
		TransitionManager.change_scene("res://Levels/MansionHall/MansionHall.tscn")
		# Opcional: Desactivar input para que no spamee
		set_process_unhandled_input(false)

# Animación de "flote" (Loop infinito)
func start_floating_animation() -> void:
	var tween = create_tween().set_loops() # Loop infinito
	
	# Mueve la flecha 10 pixeles arriba y abajo
	# Ajustá el "-50" a la altura base que quieras
	var base_y = arrow_sprite.position.y 
	
	# Baja suave
	tween.tween_property(arrow_sprite, "position:y", base_y + 5, 0.8).set_trans(Tween.TRANS_SINE)
	# Sube suave
	tween.tween_property(arrow_sprite, "position:y", base_y - 5, 0.8).set_trans(Tween.TRANS_SINE)
