extends Node
signal beat_added(text)
signal init_game

var story_database = {
	"masks_acknowledged": "Se ve que existen mascaras que obligan a decir la verdad, y mascaras que obligan a mentir... Interesante.",
	"chef_hates_daughter": "El chef dice que la hija del dueño era insoportable.",
	"lord_honorable": "El chef dice que el dueño de la mansión es un hombre honorable, y que es su amigo.",
	"chef_outage_story": "El chef dice que se corto la luz, y que siguio sonando la musica.",
	"chef_found_victim": "El chef dice que luego del corte de luz, escucho un estruendo y encontro el cadaver en la sala.",
	"chef_claims_lord_strict": "El chef dice que el dueño era estricto con la hija, aunque no suficiente.",
	"chef_likes_today_music": "El chef dice que el desempeño de la pianista fue pobre durante la semana, pero que extrañamente hoy mejoro mucho.",
	"chef_claims_cooking": "El chef dice que se ensucio las manos cocinando",
	"thermo_obtained": "El chef me dio un termometro para carne.",
	"chef_not_know_pianist": "El chef nunca hablo con la pianista.",
	"need_lord_trust": "El chef solo me dará el termometro si obtengo la confianza del dueño de la mansión.",

	"lord_strict": "Pareciera que el dueño era muy estricto con su hija. Segun el, su hija era muy irrespetuosa.",
	"lord_trusts_you": "El dueño de la mansión confia en mi.",
	"lord_claims_accident": "El dueño dice que la muerte fue un accidente.",
	"daughter_contracted_pianist": "El dueño de la mansion dijo que fue su hija quien contrato a la pianista hace unas semana.",
	"daughter_overprotective_piano": "El dueño dijo que su hija es muy celosa de quien toca su piano",
	"lord_arrived_late": "El dueño de la mansion llego a la escena despues que la pianista.",
	"lord_claims_cant_see": "El dueño de la mansion dice que no puede ver bien.",
	"lord_mixed_up_daughter": "El dueño se confundio a la pianista con su hija.",
	"lord_may_be_aggresive": "El dueño no quiere hablar de su forma de 'disciplina'.. Esperemos que no sea violento",
	"lord_mixed_up_guard": "El dueño me confundio con el guardia, a pesar de que no somos parecidos.",
	
	"pianist_contrated_by_lord": "La pianista dijo que fue contratada por el dueño hace unos meses.",
	"pianist_likes_lord": "La pianista dijo que el dueño nunca fue violento con ella.",
	"pianist_likes_daughter": "La pianista dijo que la hija del dueño era una persona respetable.",
	"pianist_cant_play_dark": "La pianista dijo que le seria imposible tocar el piano en la oscuridad",
	"pianist_hurt": "La pianista tiene moretones en el cuello. Ella afirma que fueron un accidente con las cuerdas del piano",
	"pianist_overprotective_piano": "A pesar de parecer una persona calma, cuando intente tocar el piano, la pianista casi me ataca.",
	
	"cadaver_checked": "He inspeccionado el cadaver, definitivamente fue un asesinato.",
	"corpse_hands_inspected": "Las manos del cuerpo estan llenas de callos, parecen de alguien que trabajo toda su vida en el campo",
	"corpse_glued_mask": "Extrañamente, la mascara se encuentra pegada al cadaver... ¿Por que harian esto?",
	"pianist_can_play_dark": "Cuando apague la luz, la pianista siguio tocando musica."
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
