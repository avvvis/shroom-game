class_name IdleState
extends State

@export var move_state: MoveState
@export var attack_state: AttackState

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
