extends CanvasLayer

# El rectángulo negro que va a tapar la pantalla
var color_rect: ColorRect

func _ready() -> void:
	# Configuración inicial del CanvasLayer
	layer = 100 # Un número alto para asegurar que tape TODO (incluso otros CanvasLayers)
	
	# Creamos el ColorRect por código
	color_rect = ColorRect.new()
	color_rect.color = Color.BLACK
	color_rect.color.a = 0.0 # Empieza invisible
	
	# Hacemos que ocupe toda la pantalla siempre (Full Rect)
	color_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	# IMPORTANTE: Que no bloquee el mouse cuando es invisible
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	add_child(color_rect)

func change_scene(scene_path: String, duration: float = 0.5) -> void:
	# 1. Evitar que el jugador interactúe durante la transición
	get_tree().paused = true # Opcional: Pausar el juego para que no te maten mientras carga
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP # Bloquear clics
	
	# 2. Fade IN (Aparece el negro)
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS) # Para que funcione aunque el juego esté pausado
	tween.tween_property(color_rect, "color:a", 1.0, duration)
	
	# Esperar a que termine la animación
	await tween.finished
	
	# 3. Cambiar la escena
	var error = get_tree().change_scene_to_file(scene_path)
	if error != OK:
		print("Error al cambiar de escena: ", error)
		# Si falla, asegurate de despausar para no quedarte trabado
		get_tree().paused = false
		return

	# 4. Fade OUT (Desaparece el negro)
	tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(color_rect, "color:a", 0.0, duration)
	
	await tween.finished
	
	# 5. Liberar el control
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().paused = false
