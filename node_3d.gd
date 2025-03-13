extends Node3D

func _ready():
	var cube_marcher = CubeMarcher.new()
	cube_marcher.set_SDF(Ball.new())
	
	var m = MeshInstance3D.new()
	m.mesh = cube_marcher.get_mesh()
	add_child(m)
