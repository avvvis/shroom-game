extends SDF
class_name Ball

var radius
var origin

func _init(c_origin :Vector3 = Vector3(0.0, 0.0, 0.0), c_radius :float = 1.0):
	radius = c_radius
	origin = c_origin

func get_value_at(input_position :Vector3):
	return (input_position - origin).length() - radius

func get_negative_bound() -> Vector3:
	return origin - radius * Vector3(1.0, 1.0, 1.0)
	
func get_positive_bound() -> Vector3:
	return origin + radius * Vector3(1.0, 1.0, 1.0)
