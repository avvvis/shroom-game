@icon("res://CubeMarcher/cube_marcher_icon.png")
class_name CubeMarcher
extends Node

func get_mesh_of(sdf, width, height):
	assert(sdf is SDF, "Error: \"sdf\" must be an SDF")
	assert(width is float, "Error: \"width\" must be a float")
	assert(height is float, "Error: \"height\" must be a float")
