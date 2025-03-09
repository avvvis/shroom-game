@icon("res://CubeMarcher/cube_marcher_icon.png")
class_name CubeMarcher
extends Node

# Positive and negative bounds describe the most negative corner and the most positive
# corner of a bounding box that contains the implicit surface
func get_mesh_of(sdf :SDF, negative_bound :Vector3 = Vector3(-10.0, -10.0, -10.0), positive_bound :Vector3 = Vector3(10.0, 10.0, 10.0)):
	print_debug("Hi from mesh")
