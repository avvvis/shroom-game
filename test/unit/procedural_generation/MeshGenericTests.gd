extends GutTest
class_name MeshGenericTests

var model_script_path
var model
var continuous = true
var points_outward = true

func play_generic_suite():
	verticies_exist()
	if (continuous):
		is_continuous()
#	normals_direction_test()

func generate_model():
	var script = load(model_script_path)
	var parametric_instance = script.new()
	var array_mesh = parametric_instance.get_mesh()
	model = MeshDataTool.new()
	model.create_from_surface(array_mesh, 0)

func verticies_exist():
	assert_gt(model.get_edge_count(), 4)

func is_continuous():
	for i in model.get_edge_count():
		assert_eq(model.get_edge_faces(i).size(), 2, "A gap in mesh found")

func normals_direction_test():
	var some_face = model.get_face(model.get_face_count() / 2)
	var face_center = some_face
