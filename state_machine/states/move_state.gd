class_name MoveState
extends State

@export var idle_state: IdleState
@export var attack_state: AttackState

@export var move_speed: int

var direction: Vector2

func process_physics(delta: float) -> State:
	if direction == Vector2.ZERO:
		return idle_state
	
	if parent.set_face_direction(direction):
		parent.update_animation(animation_name)
	
	parent.velocity = direction.normalized() * move_speed
	parent.move_and_slide()
	
	return null
