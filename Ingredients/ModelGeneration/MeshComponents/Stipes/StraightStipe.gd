extends Stipe

class_name StraightStipe

## Stipe with Newton interpolation

var _begining_thickness: float
var _ending_thickness: float
var _height: float

var _middle_thickness: float

func generate_mesh(_parameters: Dictionary, _seed: int) -> MeshInstance3D:
	_begining_thickness = _parameters["begining thickness"]
	_ending_thickness = _parameters["ending thickness"]
	var thickness_difference = _parameters["thickness difference"]
	_height = _parameters["height"]
	
	_middle_thickness = max(_begining_thickness, _ending_thickness) + thickness_difference
	
	var array_mesh = get_mesh()
	var result = MeshInstance3D.new()
	result.mesh = array_mesh
	return result

static func get_default() -> Dictionary:
	return {
		"begining thickness": 1.0,
		"ending thickness": 0.2,
		"thickness difference": 0.5,
		"height": 2.0,
	}

static func get_default_distribution_of_distributions() -> Dictionary:
	return {
		"begining thickness": DistributionOfDistributions.new(0.2, 2, 0.1, 0.4),
		"ending thickness": DistributionOfDistributions.new(0.05, 0.3, 0.05, 0.25),
		"thickness difference": DistributionOfDistributions.new(0.0, 1.0, 0.1, 0.2),
		"height": DistributionOfDistributions.new(1.0, 4.0, 1.0, 8.0),
	}

func get_cap_direction():
	return Vector3(0.0, 1.0, 0.0)
	
func get_cap_origin():
	return Vector3(0.0, _height, 0.0)

func get_value_at(_parameter :float, _angle :float) -> Vector3:
	if _parameter == 0.0:
		return Vector3(0.0, 0.0, 0.0)
	elif _parameter != 1.0:
		var effective_radius = \
			2 * (_parameter - 0.5) * (_parameter - 1) * _begining_thickness \
			- 4 * _parameter * (_parameter - 1) * _middle_thickness  \
			+ 2 * _parameter * (_parameter - 0.5) * _ending_thickness
		return Vector3(effective_radius * cos(_angle), _height * _parameter, effective_radius * sin(_angle))
	else:
		return Vector3(0.0, _height, 0.0)

func get_face_direction():
	return false

func _get_precision():
	return 20

func _get_parameter_to_angle_precision_ratio():
	return 1.0
