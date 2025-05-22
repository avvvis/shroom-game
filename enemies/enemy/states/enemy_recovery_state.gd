extends IdleState

var recovery_time := 0.2

func enter() -> void:
	recovery_time = 0.2
	super()

func process(delta: float) -> State:
	if recovery_time > 0:
		recovery_time -= delta
		return null
	else:
		if parent.is_player_in_range():
			return attack_state
		return move_state
	
