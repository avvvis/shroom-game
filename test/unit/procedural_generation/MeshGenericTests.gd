extends GutTest
class_name MeshGenericTests

var model_script_path
var model

func generate_model():
	var script = load(model_script_path)
	var parametric_instance = script.new()
	var array_mesh = parametric_instance.get_mesh()
	model = MeshDataTool.new()
	model.create_from_surface(array_mesh, 0)

func test_verticies_exist():
	assert_gt(model.get_edge_count(), 4)

func test_is_continuous():
	for i in model.get_edge_count():
		assert_eq(model.get_edge_faces(i).size(), 2, "A gap in mesh found")

func test_spacing_extremes():
	var min = null
	var max = null
	for i in model.get_face_count():
		var vertex1 = model.get_vertex(model.get_face_vertex(i, 0))
		var vertex2 = model.get_vertex(model.get_face_vertex(i, 1))
		var vertex3 = model.get_vertex(model.get_face_vertex(i, 2))
		
		var edge1 = (vertex1 - vertex2).length()
		var edge2 = (vertex2 - vertex3).length()
		var edge3 = (vertex3 - vertex1).length()
		
		var min_edge = min(edge1, edge2, edge3)
		var max_edge = max(edge1, edge2, edge3)
		
		if min == null or min_edge < min:
			min = min_edge
		if max == null or max_edge > max:
			max = max_edge
	
	assert_gt(min, 0.01)
	assert_lt(max, 0.7)

func test_normals_correct():
	var volume = 0.0
	for i in range(0, model.get_face_count()):
		var vertex1 = model.get_vertex(model.get_face_vertex(i, 0))
		var vertex2 = model.get_vertex(model.get_face_vertex(i, 2))
		var vertex3 = model.get_vertex(model.get_face_vertex(i, 1))
		
		# Technically there should be a 1/6 coefficient used here, but we don't care for the actuall volume
		# we only care for it's sign
		volume += vertex1.dot(vertex2.cross(vertex3))
	
	assert_gt(volume, 0.0)
