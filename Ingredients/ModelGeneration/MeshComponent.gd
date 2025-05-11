extends ParametricSolid

class_name MeshComponent

## Virtual function that returns a parametrized mesh of the component
## Underscores so that Godot doesn't whine about these variables being unused
func generate_mesh(_parameters: Dictionary, _seed: int) -> MeshInstance3D:
	return MeshInstance3D.new()

## This function should return a default dictionary containing "parameter": default_distribution_of_distributions pairs
static func get_default_distribution_of_distributions() -> Dictionary:
	return {}

## This function should return the default set of prameters that can generate the material component
static func get_default() -> Dictionary:
	return {}
