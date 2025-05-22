extends AttackState

func enter() -> void:
	parent.set_face_direction(parent.get_player_pos())
	super()
	
func process_physics(delta: float) -> State:
	parent.velocity = Vector2.ZERO
	
	if not is_complete:
		return null
		
	if parent.is_player_in_range():
		return idle_state
	else:
		return move_state
