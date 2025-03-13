extends Node3D

var marcher

func _on_button_button_down() -> void:
	var m = MeshInstance3D.new()
	marcher.set_precision(Vector3(0.1,0.1,0.1))
	var subdivider = SDF_MeshSubdivider.new()
	subdivider.set_SDF(our_sdf)
	
	var time_beginning = Time.get_unix_time_from_system()
	var surface_tool_of_sdf = marcher.get_mesh()
	subdivider.set_mesh(surface_tool_of_sdf)
	subdivider.subdivide_edges()
	subdivider.subdivide_edges()
	subdivider.subdivide_edges()
	var subdivided_mesh = subdivider.get_mesh()
	var time_end = Time.get_unix_time_from_system()
	subdivided_mesh.generate_normals()
	
	m.mesh = subdivided_mesh.commit()
	
	printerr("Grib henerathion time: ", (time_end - time_beginning) * 1000.0, "ms")
	add_child(m)

var our_sdf

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	marcher = CubeMarcher.new()
	our_sdf = specific_shroom.new(Vector3(0.19,0.4,0), 0.2, Vector2(1.77,1.63), Vector2(0.02,-0.3),Vector3(0.11,0,0), Vector3(0.24,0.22,0.0) ,Vector3(0.16,0.09,0.14),Vector4(0.1, 0.1, 0.1, 0.1), Vector3(0.05,0,0))
	marcher.set_SDF(our_sdf)
	#marcher.set_SDF(Ball.new())
	##										    cap_pos	    cap_height  cap ratios		cap_propeties			leg pos			    leg mid				leg elip					leg_r 				leg_cap_offset	   	
	#marcher.set_SDF(specific_shroom.new(Vector3(0.0,0.8,0.0), 0.5, Vector2(0.9,0.8), Vector2(0.03,-0.2),Vector3(0,0,0), Vector3(0.0,0.3,0.0) ,Vector3(0.3,0.3,0.3),Vector4(0.2, 0.2, 0.2, 0.2), Vector3(0,0,0)))
	#marcher.set_SDF(Ball.new())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
