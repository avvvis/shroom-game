extends MeshGenericTests

func before_all():
	model_script_path = "res://test/unit/procedural_generation/Ball.gd"
	generate_model()

func test_generic_suite():
	play_generic_suite()
