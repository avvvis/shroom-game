class_name Player
extends CharacterBody2D

enum FaceDirection { LEFT, RIGHT, DOWN, UP }
var face_direction = FaceDirection.DOWN

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var state_machine = $StateMachine

func _ready() -> void:
	state_machine.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.handle_input(event)

func _process(delta: float) -> void:
	state_machine.process(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func set_face_direction() -> bool:
	var new_dir
	
	if velocity == Vector2.ZERO:
		return false
		
	if velocity.y == 0:
		new_dir = FaceDirection.LEFT if velocity.x < 0 else FaceDirection.RIGHT
	elif velocity.x == 0:
		new_dir = FaceDirection.UP if velocity.y < 0 else FaceDirection.DOWN
		
	sprite.flip_h = true if velocity.x < 0 else false
		
	if new_dir == face_direction:
		return false
	
	face_direction = new_dir
	return true
	
func update_animation(name: String) -> void:
	animation.play(name + "_" + direction_name())
	

func direction_name() -> String:
	match face_direction:
		FaceDirection.UP:
			return "up"
		FaceDirection.DOWN:
			return "down"
		_:
			return "side"
