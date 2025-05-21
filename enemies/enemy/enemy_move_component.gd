extends Node

func get_movment_direction() -> Vector2:
	var x = randf_range(-1, 1)
	var y = randf_range(-1, 1)
	
	return Vector2(x, y)
	
