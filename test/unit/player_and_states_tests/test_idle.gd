extends GutTest

# Import the IdleState script
var idle_state
var mock_state

func before_each():
	
	idle_state = preload("res://player/states/idle_state.gd").new()
	# Mock the move_state variable
	idle_state.move_state = preload("res://test/mock_classes/MockState.gd").new()

func test_handle_input_valid_actions():
	# Test valid move actions
	var move_actions = ["move_left", "move_right", "move_down", "move_up"]
	for action in move_actions:
		var event = InputEventAction.new()
		event.action = action
		event.pressed = true
		var result = idle_state.handle_input(event)
		assert_true(result == idle_state.move_state)

func test_handle_input_invalid_action():
	# Test invalid action
	var invalid_event = InputEventAction.new()
	invalid_event.action = "invalid_action"
	invalid_event.pressed = true
	var result_invalid = idle_state.handle_input(invalid_event)
	assert_true(result_invalid == null)
