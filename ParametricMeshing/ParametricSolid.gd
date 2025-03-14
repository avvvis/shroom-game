class_name ParametricSolid

## * parameter in [0, 1]
## 		NOTE: Please specify the function for parameter = 0. That point is going to be the origin of the mesh
## * angle in [0, 2π]
func get_value_at(parameter :float, angle :float) -> Vector3:
	assert(false, "This is a virtual function, it may not be invoked directly")
	return Vector3(0.0, 0.0, 0.0)

func get_x(radius :float, angle :float):
	return radius * cos(angle)

func get_y(radius :float, angle :float):
	return radius * sin(angle)
