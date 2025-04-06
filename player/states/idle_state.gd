extends State

@onready var move_state = $"../MoveState"

func handle_input(event: InputEvent) -> State:
	var move_actions = ["move_left", "move_right", "move_down", "move_up"]
	for action in move_actions:
		if Input.is_action_just_pressed(action):
			return move_state
			
	return null
