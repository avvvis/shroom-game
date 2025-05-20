class_name AttackState
extends State

@export var idle_state: IdleState
@export var move_state: MoveState

@export var hit_box: HitBox
@export var deceleration_speed: int
@export var attack_speed: float

var is_complete: bool

func enter() -> void:
	is_complete = false
	hit_box.monitorable = true
	super()
	parent.anim_sprite.speed_scale = attack_speed
	await parent.anim_sprite.animation_finished
	parent.anim_sprite.speed_scale = 1.0
	hit_box.monitorable = false
	is_complete = true
	
func process_physics(delta: float) -> State:
	parent.velocity -= parent.velocity * delta * deceleration_speed
	parent.move_and_slide()
	
	if not is_complete:
		return null
		
	if move_component.get_movment_direction() == Vector2.ZERO:
		return idle_state
	else:
		return move_state
