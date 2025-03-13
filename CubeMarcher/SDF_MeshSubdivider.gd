# A class for creating more detailed meshes from the
# meshes provided by the CubeMarcher
class_name SDF_MeshSubdivider

var _sdf
var _mesh

func set_SDF(f_sdf :SDF):
	_sdf = f_sdf

func set_mesh(f_mesh :SurfaceTool):
	_mesh = f_mesh
	
func get_mesh():
	return _mesh

func subdivide_center():
	assert(_sdf != null, "You must set the sdf with set_SDF")
	assert(_mesh != null, "You must set the mesh with set_mesh")
	
	var arrays = _mesh.commit_to_arrays()
	var new_mesh = SurfaceTool.new()
	new_mesh.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var iterator = 0
	while iterator < arrays[0].size():
		var first_vertex = arrays[0][iterator]
		var second_vertex = arrays[0][iterator + 1]
		var third_vertex = arrays[0][iterator + 2]
		
		var approximate_fourth_vertex = (first_vertex + second_vertex + third_vertex) / 3.0
		var normal_to_triangle = (second_vertex - first_vertex).cross(third_vertex - first_vertex)
		var fourth_vertex = _raymarch(normal_to_triangle, approximate_fourth_vertex)
		
		new_mesh.add_vertex(first_vertex)
		new_mesh.add_vertex(second_vertex)
		new_mesh.add_vertex(fourth_vertex)
		
		new_mesh.add_vertex(second_vertex)
		new_mesh.add_vertex(third_vertex)
		new_mesh.add_vertex(fourth_vertex)
		
		new_mesh.add_vertex(third_vertex)
		new_mesh.add_vertex(first_vertex)
		new_mesh.add_vertex(fourth_vertex)
		
		iterator += 3
		
	_mesh = new_mesh
	return _mesh

func subdivide_edges():
	assert(_sdf != null, "You must set the sdf with set_SDF")
	assert(_mesh != null, "You must set the mesh with set_mesh")
	
	var arrays = _mesh.commit_to_arrays()
	var new_mesh = SurfaceTool.new()
	new_mesh.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var iterator = 0
	while iterator < arrays[0].size():
		var approximate_first_vertex = arrays[0][iterator]
		var approximate_second_vertex = arrays[0][iterator + 1]
		var approximate_third_vertex = arrays[0][iterator + 2]
		var normal_to_triangle = \
			(approximate_second_vertex - approximate_first_vertex).cross(\
			approximate_third_vertex - approximate_first_vertex)
		
		var first_vertex = _raymarch(normal_to_triangle, approximate_first_vertex)
		var second_vertex = _raymarch(normal_to_triangle, approximate_second_vertex)
		var third_vertex = _raymarch(normal_to_triangle, approximate_third_vertex)
		
		var approximate_fourth_vertex = (first_vertex + second_vertex) / 2.0
		var approximate_fifth_vertex = (second_vertex + third_vertex) / 2.0
		var approximate_sixth_vertex = (first_vertex + third_vertex) / 2.0
		
		var fourth_vertex = _raymarch(normal_to_triangle, approximate_fourth_vertex)
		var fifth_vertex = _raymarch(normal_to_triangle, approximate_fifth_vertex)
		var sixth_vertex = _raymarch(normal_to_triangle, approximate_sixth_vertex)
		
		new_mesh.add_vertex(first_vertex)
		new_mesh.add_vertex(fourth_vertex)
		new_mesh.add_vertex(sixth_vertex)
		
		new_mesh.add_vertex(fourth_vertex)
		new_mesh.add_vertex(second_vertex)
		new_mesh.add_vertex(fifth_vertex)
		
		new_mesh.add_vertex(sixth_vertex)
		new_mesh.add_vertex(fifth_vertex)
		new_mesh.add_vertex(third_vertex)
		
		new_mesh.add_vertex(fourth_vertex)
		new_mesh.add_vertex(fifth_vertex)
		new_mesh.add_vertex(sixth_vertex)
		
		iterator += 3
		
	_mesh = new_mesh
	return _mesh

const _max_iterations = 100
const _treshold = 0.001
func _raymarch(direction :Vector3, origin :Vector3):
	direction = direction.normalized()
	var best_current_aproximation = origin
	var distance_to_surface = _sdf.get_value_at(best_current_aproximation)
	var iterations = 1
	while (abs(distance_to_surface) < _treshold and iterations < _max_iterations):
		best_current_aproximation = best_current_aproximation + (distance_to_surface + _treshold) * direction
		distance_to_surface = _sdf.get_value_at(best_current_aproximation)
		iterations += 1
	
	return best_current_aproximation + direction * distance_to_surface
	
