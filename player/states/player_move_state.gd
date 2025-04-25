extends MoveState

func handle_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	
	return null

func process_physics(delta: float) -> State:
	direction = move_component.get_movment_direction()
	return super(delta)
