class_name HitBox
extends Area2D

@export var damage: int

var hit_box_layer = 2

func _init() -> void:
	collision_layer = hit_box_layer
	collision_mask = 0
	monitorable = false
	monitoring = false
