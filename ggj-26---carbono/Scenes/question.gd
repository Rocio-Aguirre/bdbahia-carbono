extends Sprite2D

func _process(_delta):
	# 1. Forzamos la rotación global a 0 (vertical perfecto)
	global_rotation = 0
	
	# 2. (Opcional) Si la máscara está escalada para parecer isométrica 
	# (ej: scale.y = 0.5), el signo se verá aplastado. 
	# Esto lo devuelve a su tamaño real:
	global_scale = Vector2(1, 1) 
	
	# 3. (Opcional) Si querés que el signo flote un poquito arriba y no pegado al centro
	# podés ajustar el offset aquí o en el editor (Offset > y: -50)
