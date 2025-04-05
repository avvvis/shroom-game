extends ParametricSolid

func get_value_at(parameter :float, angle :float) -> Vector3:
	return Vector3(sin(parameter) * cos(angle), cos(parameter), sin(parameter) * sin(angle))
