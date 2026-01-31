extends Node
signal beat_added(text)

var story_database = {
	"masks_acknowledged": "Se ve que existen mascaras que obligan a decir la verdad, y mascaras que obligan a mentir... Interesante."
}
var unlocked_beats: Array = []

func unlock_beat(beat_id: String):
	if beat_id in unlocked_beats:
		return
	if not beat_id in story_database:
		print("OJO "+beat_id+" no existe en la DB")
	unlocked_beats.append(beat_id)
	beat_added.emit(story_database[beat_id])

func has_beat(beat_id: String):
	return beat_id in unlocked_beats
	
