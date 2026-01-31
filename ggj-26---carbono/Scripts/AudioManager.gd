extends Node

# Musica
@onready var gameplay_track: AudioStreamPlayer = $gameplay_track
@onready var honest_track: AudioStreamPlayer = $honest_track
@onready var menu_track: AudioStreamPlayer = $menu_track
@onready var end_track: AudioStreamPlayer = $end_track
@onready var lier_track: AudioStreamPlayer = $lier_track

var current_track: AudioStreamPlayer = null

func _ready() -> void:
	play_theme("MENU",0.1)

func play_theme(track_name: String, transition_duration: float = 1.5):
	var next_track = _get_track_node(track_name)
	if next_track == current_track or next_track == null:
		return
	var tween = create_tween()
	tween.set_parallel(true)
	if current_track != null:
		tween.tween_property(current_track, "volume_db", -80.0, transition_duration)
	
	if next_track != null:
		if not next_track.playing:
			next_track.play()
		
		tween.tween_property(next_track, "volume_db", 0.0, transition_duration)
	
	current_track = next_track

func stop_music(duration: float = 1.0) -> void:
	if current_track == null:
		return
		
	var tween = create_tween()
	tween.tween_property(current_track, "volume_db", -80.0, duration)
	
	current_track = null


func _get_track_node(name :String) -> AudioStreamPlayer:
	print("Now Playing..."+name)
	match name:
		"GAMEPLAY": return gameplay_track
		"HONEST": return honest_track
		"LIAR": return lier_track
		"END": return end_track
		"MENU": return menu_track
	return null

func play_sfx(stream: AudioStream, volume_db: float = 0.0, pitch_variance: float = 0.0) -> void:
	if stream == null:
		return
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = stream
	sfx_player.volume_db = volume_db
	
	if pitch_variance > 0:
		# Ejemplo: si variance es 0.1, el pitch va de 0.9 a 1.1 aleatoriamente
		sfx_player.pitch_scale = randf_range(1.0 - pitch_variance, 1.0 + pitch_variance)
	
	# 3. Lo agregamos al árbol (como hijo de este AudioManager)
	add_child(sfx_player)
	
	# 4. Le damos play
	sfx_player.play()
	
	# 5. IMPORTANTE: Conectamos la señal para que se borre solo al terminar
	sfx_player.finished.connect(sfx_player.queue_free)
