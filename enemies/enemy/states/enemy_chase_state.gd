extends MoveState

@export var turn_rate := 0.5

func process_physics(delta: float) -> State:
	if parent.is_player_in_range():
		return attack_state
	direction = move_component.get_movment_direction(parent.get_player_pos())
	return super(delta)
