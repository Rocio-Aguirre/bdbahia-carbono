extends Node
signal beat_added(text)
signal init_game

var story_database = {
	"masks_acknowledged": "Se ve que existen mascaras que obligan a decir la verdad, y mascaras que obligan a mentir... Interesante.",
	"chef_hates_daughter": "El chef dice que la hija del dueño era insoportable.",
	"lord_honorable": "El chef dice que el dueño de la mansión es un hombre honorable, y que es su amigo.",
	"lord_strict": "Pareciera que el dueño era muy estricto con su hija.",
	"lord_trusts_you": "El lord de la mansión confia en mi.",
	"thermo_obtained": "El chef me dio un termometro para carne.",
	"need_lord_trust": "El chef solo me dará el termometro si obtengo la confianza del dueño de la mansión.",
	"chef_not_know_pianist": "El chef nunca hablo con la pianista.",
	"lord_claims_accident": "El dueño de la mansión dice que la muerte fue un accidente.",
	"cadaver_checked": "He inspeccionado el cadaver, definitivamente fue un asesinato.",
	"daughter_contracted_pianist": "El dueño de la mansion dijo que fue su hija quien contrato a la pianista.",
	"lord_arrived_late": "El dueño de la mansion llego a la escena despues que la pianista.",
	"lord_and_friends_cant_see": "El dueño de la mansion y sus amigos ya estan grandes... No ven bien y sufren varios dolores.",
	"lord_may_be_aggresive": "El dueño no quiere hablar de su forma de 'disciplina'.. Acaso su hija sera victima de violencia familiar? ¿Habra intentado escapar?"
	
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
