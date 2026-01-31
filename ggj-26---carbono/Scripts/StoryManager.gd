extends Node
signal beat_added(text)
signal init_game

var story_database = {
	"masks_acknowledged": "Se ve que existen mascaras que obligan a decir la verdad, y mascaras que obligan a mentir... Interesante.",
	"chef_hates_daughter": "El chef dice que la hija del dueño era insoportable.",
	"lord_honorable": "El chef dice que el dueño de la mansión es un hombre honorable, y que es su amigo.",
	"lord_strict": "El chef dice que el dueño era estricto con su hija.",
	"lord_trusts_you": "El lord de la mansión confia en mi.",
	"thermo_obtained": "El chef me dio un termometro para carne.",
	"need_lord_trust": "El chef solo me dará el termometro si obtengo la confianza del dueño de la mansión.",
	"chef_not_know_pianist": "El chef nunca hablo con la pianista."
}
var unlocked_beats: Array = []

func _ready() -> void:
	GlobalData.init_game.connect(reset_clues)

func reset_clues():
	unlocked_beats = []
	init_game.emit()

func unlock_beat(beat_id: String):
	if beat_id in unlocked_beats:
		return
	if not beat_id in story_database:
		print("OJO "+beat_id+" no existe en la DB")
	unlocked_beats.append(beat_id)
	beat_added.emit(story_database[beat_id])

func has_beat(beat_id: String):
	return beat_id in unlocked_beats
