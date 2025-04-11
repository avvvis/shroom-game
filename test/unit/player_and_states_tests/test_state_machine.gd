extends GutTest

var state_machine
var mock_starting_state
var mock_new_state
var mock_parent

func before_each():
	# Create a mock CharacterBody2D parent
	mock_parent = CharacterBody2D.new()
	add_child(mock_parent)  # Add the mock parent to the scene tree
	
	# Load the StateMachine script and instantiate it
	state_machine = load("res://state_machine/state_machine.gd").new()
	mock_parent.add_child(state_machine)  # Add the state machine as a child of the mock parent
	
	# Create mock states
	mock_starting_state = preload("res://test/mock_classes/MockState.gd").new()
	mock_new_state = preload("res://test/mock_classes/MockState.gd").new()
	
	# Set the starting state
	state_machine.starting_state = mock_starting_state
	state_machine.init(mock_parent)  # Pass the mock parent to the init method

func after_each():
	# Cleanup
	mock_parent.queue_free()

func test_initialization():
	# Test that the starting state is set and entered
	assert_eq(state_machine.current_state, mock_starting_state)
	assert_true(mock_starting_state.enter_called)

func test_change_state():
	# Change to a new state
	state_machine.change_state(mock_new_state)
	
	# Verify that the starting state's exit() was called
	assert_true(mock_starting_state.exit_called)
	
	# Verify that the new state's enter() was called
	assert_true(mock_new_state.enter_called)
	
	# Verify the current state is updated
	assert_eq(state_machine.current_state, mock_new_state)

func test_process_physics():
	# Simulate process_physics and return a new state
	mock_starting_state.process_physics_return = mock_new_state
	state_machine.process_physics(0.016)
	
	# Verify state transition
	assert_eq(state_machine.current_state, mock_new_state)
	assert_true(mock_starting_state.exit_called)
	assert_true(mock_new_state.enter_called)

func test_handle_input():
	# Simulate input handling and return a new state
	var mock_event = InputEventKey.new()  # Use InputEventKey for concrete input
	mock_event.keycode = KEY_SPACE       # Simulate pressing the SPACE key
	mock_starting_state.handle_input_return = mock_new_state
	state_machine.handle_input(mock_event)
	
	# Verify state transition
	assert_eq(state_machine.current_state, mock_new_state)
	assert_true(mock_starting_state.exit_called)
	assert_true(mock_new_state.enter_called)

func test_process():
	# Simulate process and return a new state
	mock_starting_state.process_return = mock_new_state
	state_machine.process(0.016)
	
	# Verify state transition
	assert_eq(state_machine.current_state, mock_new_state)
	assert_true(mock_starting_state.exit_called)
	assert_true(mock_new_state.enter_called)
