extends Node2D

func update_direction(new_direction: String) -> void:
	match new_direction:
		"down":
			rotation_degrees = 0
		"up":
			rotation_degrees = 180
		"left":
			rotation_degrees = 90
		"right":
			rotation_degrees = 270
		_:
			rotation_degrees = 0
	
	
