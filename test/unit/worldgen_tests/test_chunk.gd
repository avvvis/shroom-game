extends GutTest

# Gut itself doesn't provide any infra for fuzz testing.
# Thus, we'll just generate random cases ourselves.
const FUZZ_MASTER_SEED := 0xdeadbeefcafe
const MIN_SUPER_COORD := -1_000_000_000
const MAX_SUPER_COORD := +1_000_000_000

func _fuzz_rng() -> RandomNumberGenerator:
	var rng := RandomNumberGenerator.new()
	rng.seed = FUZZ_MASTER_SEED
	return rng

func _verify_cell(cell: WorldCell) -> void:
	assert_not_null(cell)
	assert_between(cell.biomic_xy.x, -1.0, +1.0)
	assert_between(cell.biomic_xy.y, -1.0, +1.0)

func _verify_chunk(chunk: Chunk) -> void:
	assert_not_null(chunk)
	for offset in Util.vec2i_range(Vector2i(0, 0), Vector2i(Chunk.SIZE, Chunk.SIZE)):
		var cell := chunk.get_cell(offset)
		_verify_cell(cell)

func test_init() -> void:
	var chunk := Chunk.new()
	for offset in Util.vec2i_range(Vector2i(0, 0), Vector2i(Chunk.SIZE, Chunk.SIZE)):
		var cell := chunk.get_cell(offset)
		assert_null(cell)

func test_fuzz_generate() -> void:
	const NWGPARAMS := 2
	const NCHUNKS := 50
	var rng := _fuzz_rng()
	
	for i in range(NWGPARAMS):
		var wgparams := WorldGenParams.new()
		wgparams.master_seed = rng.randi()
		
		for j in range(NCHUNKS):
			var super_coords := Vector2i(0, 0)
			super_coords.x = rng.randi_range(MIN_SUPER_COORD, MAX_SUPER_COORD)
			super_coords.y = rng.randi_range(MIN_SUPER_COORD, MAX_SUPER_COORD)
			
			var chunk := Chunk.generate(wgparams, super_coords)
			_verify_chunk(chunk)

func test_fuzz_get_set() -> void:
	const NSETGET := Chunk.SIZE ** 2
	var rng := _fuzz_rng()
	
	var chunk = Chunk.new()
	
	for i in range(NSETGET):
		var x := rng.randi_range(0, Chunk.SIZE - 1)
		var y := rng.randi_range(0, Chunk.SIZE - 1)
		var rel_coords := Vector2i(x, y)
		
		var cell := WorldCell.new(
			Vector2(
				rng.randf_range(-1.0, +1.0),
				rng.randf_range(-1.0, +1.0)
			),
		)
		
		chunk.set_cell(rel_coords, cell)
		var got_cell := chunk.get_cell(rel_coords)
		
		assert_not_null(got_cell)
		assert_eq(got_cell.biomic_xy, cell.biomic_xy)
