@icon("res://SDF/sdf_icon.png")
class_name SDF
## A class for defining SDF's, for further rendering to a mesh in `CubeMarcher`
## NOTE: In order for this class to work correctly, you need to provide implementations for the required functions
extends Node

## Returns the distance to the implicit surface
func get_value_at(input_position :Vector3) -> float:
	assert(false, "Error: \"get_value_at(input_position :Vector3)\" must be overwritten by an inheriting class. Overwrite this function with your own signed distance function.")
	return 1.0
	
func get_negative_bound() -> Vector3:
	assert(false, "Error: \"get_negative_bound()\" must be overwritten by an inheriting class. Overwrite this function with your own signed distance function.")
	return Vector3(0.0, 0.0, 0.0)
	
func get_positive_bound() -> Vector3:
	assert(false, "Error: \"get_positive_bound()\" must be overwritten by an inheriting class. Overwrite this function with your own signed distance function.")
	return Vector3(0.0, 0.0, 0.0)
