extends CharacterBody2D
class_name NPCEntity


@export var can_move: bool
@export var dialogue: DialogueResource
@export var texture: Texture2D
@onready var speed = 100.0
var target_position: Vector2
var direction: Vector2
var player_near: bool = false



enum State {
	IDLE, WALK, STOP
}

var current_state = State.IDLE


func change_state(new_state: State):
	current_state = new_state
	match current_state:
		State.IDLE:
			$IdleStateTimer.start()
		State.WALK:
			# Settear una posicion random a 500 pixeles.
			target_position = Vector2(randf(),randf())*500
			$IdleStateTimer.stop()
		State.STOP:
			target_position = Vector2.ZERO
			$IdleStateTimer.stop()




func _ready() -> void:
	$Sprite.texture = texture
	change_state(State.IDLE)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(_dialogo):
	GlobalData.is_in_dialogue = false
	if current_state == State.STOP:
		change_state(State.IDLE)


func _physics_process(delta: float) -> void:
	match current_state:
		State.IDLE:
			pass
		State.WALK:
			## TO-FIX: ahora solo camina en una direccion hasta el infinito jaja
			if (target_position-global_position).length() < 10.0:
				change_state(State.IDLE)
			else:
				direction = (target_position-global_position).normalized()
				velocity = direction*speed
				move_and_slide()
		State.STOP:
			pass



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and player_near:
		DialogueManager.show_dialogue_balloon(dialogue)
		GlobalData.is_in_dialogue = true
		change_state(State.STOP)



func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = true
		$Exclamation.visible = true


func _on_player_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = false
		$Exclamation.visible = false


func _on_idle_state_timer_timeout() -> void:
	if can_move:
		change_state(State.WALK)
