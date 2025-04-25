class_name HurtBox
extends Area2D

var hurt_box_mask  = 2

func _init() -> void:
	collision_layer = 0
	collision_mask = hurt_box_mask
	monitoring = true
	monitorable = false
	
func _ready() -> void:
	area_entered.connect(on_area_entered)
	
func on_area_entered(hit_box: HitBox) -> void:
	if hit_box == null or hit_box.owner == owner:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hit_box.damage)
