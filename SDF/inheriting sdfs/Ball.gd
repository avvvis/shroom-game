extends SDF
## A class representing a ball of any radius and origin as a signed distance function
class_name Ball

## Radius of the ball
var radius
## Origin of the ball
var origin

func _init(c_origin :Vector3 = Vector3(0.0, 0.0, 0.0), c_radius :float = 1.0):
	radius = c_radius
	origin = c_origin

func get_value_at(input_position :Vector3):
	return (input_position - origin).length() - radius

func get_negative_bound() -> Vector3:
	return origin - radius * Vector3(1.0, 1.0, 1.0) * 1.1
	
func get_positive_bound() -> Vector3:
	return origin + radius * Vector3(1.0, 1.0, 1.0) * 1.1
