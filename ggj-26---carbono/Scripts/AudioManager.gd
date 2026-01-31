extends Node

# Musica
@onready var gameplay_track: AudioStreamPlayer = $gameplay_track
@onready var honest_track: AudioStreamPlayer = $honest_track
@onready var menu_track: AudioStreamPlayer = $menu_track
@onready var end_track: AudioStreamPlayer = $end_track
@onready var lier_track: AudioStreamPlayer = $lier_track

var current_track: AudioStreamPlayer = null

func _ready() -> void:
	play_theme("MENU")

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
