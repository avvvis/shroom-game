extends State

var enter_called = false
var exit_called = false
var process_physics_return = null
var handle_input_return = null
var process_return = null

func enter():
	enter_called = true

func exit():
	exit_called = true

func process_physics(delta):
	return process_physics_return

func handle_input(event):
	return handle_input_return

func process(delta):
	return process_return
