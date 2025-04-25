extends MoveState

@export var state_duration_min : float = 1
@export var state_duration_max : float = 2.5


func enter():
	super()
	direction = move_component.get_movment_direction()

func process_physics(delta: float) -> State:
	if parent.is_on_wall():
		direction = move_component.get_movment_direction()
		
	return super(delta)
