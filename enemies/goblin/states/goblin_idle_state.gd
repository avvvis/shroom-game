extends IdleState

@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5

var wander_state = move_state

var timer: float = 0

func enter() -> void:
	super()
	timer = randf_range(state_duration_min, state_duration_max)

func process(delta: float) -> State:
	timer -= delta
	if timer <= 0:
		return wander_state
	return null
