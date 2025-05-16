extends Node

class_name MaterialComponent

const texture_resolution = 512

## A virtual function that generates a material based on the provided parameters and seed
## Note: Material may change due to the how oblivious to the material system the author is :(
static func generate_material(_parameters: Dictionary, _seed: int) -> Material:
	return StandardMaterial3D.new()

## This function should return a default dictionary containing "parameter": default_distribution_of_distributions pairs
static func get_default_distribution_of_distributions() -> Dictionary:
	return {}

## This function should return the default set of prameters that can generate the material component
static func get_default() -> Dictionary:
	return {}
