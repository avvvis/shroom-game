extends MoveState

@export var state_duration_min : float = 1
@export var state_duration_max : float = 2.5

var timer: float = 0


func enter():
	super()
	direction = move_component.get_movment_direction()
	timer = randf_range(state_duration_min, state_duration_max)
	
func process(delta: float) -> State:
	timer -= delta
	if timer <= 0:
		direction = Vector2.ZERO
		
	return null

func process_physics(delta: float) -> State:
	if parent.is_on_wall():
		direction = move_component.get_movment_direction()
		
	return super(delta)
