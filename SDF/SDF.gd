@icon("res://SDF/sdf_icon.png")
class_name SDF
extends Node

func get_value_at(input_position):
	assert(input_position is Vector3, "Error: \"input_position\" must be a Vector3!")
	return _calculate_value_at(input_position)
	
func _calculate_value_at(input_position):
	assert(false, "Error: \"_calculate_value_at\" must be overwritten by an inheriting class. Overwrite this function with your own signed distance function.")
