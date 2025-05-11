extends Cap

class_name Chalice

# https://www.desmos.com/calculator/ygkjrtkukt
# _height and _stipe_height can be pretty much whatever
var _height: float
var _stipe_height: float
# _radius >> _stipe_thickness
var _radius: float
var _stipe_thickness: float
# steepness, you should figure out what it should be, default is 1.5
var _steepness: float

func generate_mesh(_parameters: Dictionary, _seed: int) -> MeshInstance3D:
	_height = _parameters["height"]
	_stipe_height = _parameters["stipe height"]
	_radius = _parameters["radius"]
	_stipe_thickness = _parameters["stipe thickness"]
	_steepness = _parameters["steepness"]
	
	var array_mesh = get_mesh()
	var result = MeshInstance3D.new()
	result.mesh = array_mesh
	return result

static func get_default() -> Dictionary:
	return {
		"height": 2.0,
		"stipe height": 1.0,
		"radius": 4.0,
		"stipe thickness": 1.0,
		"steepness": 1.5,
	}

static func get_default_distribution_of_distributions() -> Dictionary:
	return {
		"height": DistributionOfDistributions.new(0.5, 5, 0.1, 1),
		"stipe height": DistributionOfDistributions.new(0.1, 3, 0.05, 0.5),
		"radius": DistributionOfDistributions.new(2, 5, 0.1, 1),
		"stipe thickness": DistributionOfDistributions.new(0.05, 2, 0.05, 0.2),
		"steepness": DistributionOfDistributions.new(0.01, 2, 0.05, 0.2)
	}

func get_value_at(_parameter :float, _angle :float) -> Vector3:
	if _parameter == 0.0:
		return Vector3(0.0, _stipe_height, 0.0)
	elif _parameter == 1.0:
		#return Vector3(cos(_angle) *  _stipe_height, _stipe_thickness, sin(_angle) * _stipe_height)
		return Vector3(0.0, 0.0, 0.0)
	
	var effective_radius
	var effective_height
	if _parameter <= 1.0 / 2.0:
		effective_radius = 2 * _parameter * _radius
		effective_height = _stipe_height + (1 - cos(_parameter * 2 * PI)) / 2 * (_height - _stipe_height)
	else:
		effective_radius = _radius - (_parameter - 0.5) * 2 * (_radius - _stipe_thickness)
		effective_height = _height - _height * pow((2 * _parameter - 1), _steepness)
	
	return Vector3(cos(_angle) * effective_radius, effective_height, sin(_angle) * effective_radius)

func get_face_direction():
	return true

func _get_precision():
	return 20

func _get_parameter_to_angle_precision_ratio():
	return 1.0
