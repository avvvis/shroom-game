class_name Player
extends CharacterBody2D

var face_direction := "S"
var health := 100

@onready var anim_sprite = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var move_component = $MoveComponent
@onready var interactions = $Interactions

func _ready() -> void:
	state_machine.init(self, move_component)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.handle_input(event)

func _process(delta: float) -> void:
	state_machine.process(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func set_face_direction(target: Vector2) -> bool:
	if target == Vector2.ZERO:
		return false
	
	var angle: float = rad_to_deg(target.angle())
	if angle < 0:
		angle += 360
	
	var new_dir: String
	if angle >= 337.5 or angle < 22.5:
		new_dir = "E"   
	elif angle >= 22.5 and angle < 67.5:
		new_dir = "SE"    
	elif angle >= 67.5 and angle < 112.5:
		new_dir = "S"      
	elif angle >= 112.5 and angle < 157.5:
		new_dir = "SW"     
	elif angle >= 157.5 and angle < 202.5:
		new_dir = "W"      
	elif angle >= 202.5 and angle < 247.5:
		new_dir = "NW"     
	elif angle >= 247.5 and angle < 292.5:
		new_dir = "N"      
	else:  
		new_dir = "NE"     
	
	if new_dir == face_direction:
		return false
	
	interactions.update_direction(new_dir)
	face_direction = new_dir
	return true
	
func update_animation(name: String) -> void:
	anim_sprite.play(name + "_" + face_direction)
	

func take_damage(damage: int) -> void:
	health -= damage
	print("damage has been taken: &d" %damage)
	pass
