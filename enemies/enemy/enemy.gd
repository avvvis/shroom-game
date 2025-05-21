class_name Enemy
extends CharacterBody2D

var face_direction = "down"
var invulnerable := false
var invulnerable_time := 0.1
@export var point_value := 1
@export var health := 30

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var state_machine = $StateMachine
@onready var move_component = $MoveComponent

func _ready() -> void:
	state_machine.init(self, move_component)
	
func _process(delta: float) -> void:
	if invulnerable_time > 0:
		invulnerable_time -= delta
	else:
		invulnerable = false
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
	
	face_direction = new_dir
	return true
	
func update_animation(name: String) -> void:
	var dir = face_direction
	if dir == "right" or dir == "left":
		dir = "side"
	animation.play(name + "_" + dir)
	

func take_damage(damage: int) -> void:
	if invulnerable:
		return
	invulnerable = true;
	invulnerable_time = 0.1;
	health -= damage
	if health < 0:
		die()
		
func die():
	GameState.give_points(point_value)
	queue_free()
	
	
	
