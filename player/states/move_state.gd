extends State

@onready var idle_state = $"../IdleState"

@export var move_speed = 100

func process_physics(delta: float) -> State:
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down",
	).normalized()
	
	parent.velocity = direction * move_speed
	
	if direction == Vector2.ZERO:
		return idle_state
		
	if parent.set_face_direction():
		parent.update_animation(animation_name)
	
	parent.move_and_slide()
	
	return null
