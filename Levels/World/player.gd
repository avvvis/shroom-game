extends CharacterBody2D

@export var speed = 10_000

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * delta * speed
	move_and_slide()
	$"../Camera".position = position
