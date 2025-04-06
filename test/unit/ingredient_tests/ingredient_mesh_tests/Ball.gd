extends ParametricSolid

func get_value_at(parameter :float, angle :float) -> Vector3:
	parameter *= PI
	return Vector3(sin(parameter) * cos(angle), cos(parameter), sin(parameter) * sin(angle))

func _get_precision():
	return 20

func _get_parameter_to_angle_precision_ratio():
	return 0.2

func get_face_direction():
	return false
