extends GutTest

static var SAMPLING_POINTS: Array[Vector3i] = []

static func _static_init() -> void:
	for i in range(-5, 6):
		for j in range(-5, 6):
			for k in range(-5, 6):
				var xyz := Vector3i(i, j, k)
				SAMPLING_POINTS.push_back(xyz)
				SAMPLING_POINTS.push_back(xyz * 1_000_000)

func _test_noise_method(f: Callable) -> void:
	const NSEEDS := 100
	var wn := WhiteNoise.new()
	
	for seed in range(1, NSEEDS + 1):
		wn.seed = seed
		
		for xyz in SAMPLING_POINTS:
			var val: float = f.call(wn, xyz)
			assert_between(val, -1.0, +1.0)

func test_get_noise_3d() -> void:
	_test_noise_method(func (wn, xyz): return wn.get_noise_3d(xyz.x, xyz.y, xyz.z))

func test_get_noise_2d() -> void:
	_test_noise_method(func (wn, xyz): return wn.get_noise_2d(xyz.x, xyz.y))

func test_get_noise_1d() -> void:
	_test_noise_method(func (wn, xyz): return wn.get_noise_1d(xyz.x))

func test_get_noise_3dv() -> void:
	_test_noise_method(func (wn, xyz): return wn.get_noise_3dv(xyz))

func test_get_noise_2dv() -> void:
	_test_noise_method(func (wn, xyz): return wn.get_noise_2dv(Vector2i(xyz.x, xyz.y)))
