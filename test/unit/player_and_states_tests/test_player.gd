extends GutTest

var player
var mock_state_machine

func before_each():
	# Load the actual Player scene
	var scene = load("res://player/Player.tscn")  
	player = scene.instantiate()
	add_child(player)  # Add the Player to the scene tree

	# Replace the state_machine with a mock
	mock_state_machine = preload("res://test/mock_classes/MockStateMachine.gd").new()
	player.add_child(mock_state_machine)  # Add to the Player node
	player.state_machine = mock_state_machine  # Set the state_machine reference

	# Call _ready to initialize player and its dependencies
	player._ready()

func after_each():
	# Cleanup
	player.queue_free()

func test_set_face_direction():
	# Test case: Moving left
	player.velocity = Vector2(-1, 0)
	assert_true(player.set_face_direction())
	assert_eq(player.face_direction, player.FaceDirection.LEFT)
	assert_true(player.sprite.flip_h)

	# Test case: Moving down
	player.velocity = Vector2(0, 1)
	assert_true(player.set_face_direction())
	assert_eq(player.face_direction, player.FaceDirection.DOWN)

	# Test case: Zero velocity
	player.velocity = Vector2.ZERO
	assert_false(player.set_face_direction())

func test_update_animation():
	# Simulate updating the animation
	player.face_direction = player.FaceDirection.UP
	player.update_animation("walk")
	assert_eq(player.animation.current_animation, "walk_up")

func test_direction_name():
	# Test case for each direction
	player.face_direction = player.FaceDirection.LEFT
	assert_eq(player.direction_name(), "side")

	player.face_direction = player.FaceDirection.DOWN
	assert_eq(player.direction_name(), "down")

	player.face_direction = player.FaceDirection.UP
	assert_eq(player.direction_name(), "up")
