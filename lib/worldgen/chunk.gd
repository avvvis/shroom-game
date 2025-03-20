## Represents a single chunk of the world map.
##
## The game world is made up of cells grouped into chunks, which form a square grid.
##
## See: [WorldCell].
class_name Chunk

## The side length of a chunk.
const SIZE := 32

var _cells: Array[WorldCell] = []

## Creates a chunk with all cells set to null.
func _init() -> void:
	_cells.resize(SIZE * SIZE)

## Returns the [WorldCell] stored at the given relative coordinates.
func get_cell(rel_coords: Vector2i) -> WorldCell:
	return _cells[rel_coords.y * SIZE + rel_coords.x]

## Replaces the [WorldCell] stored at the given relative coordinates with [param cell].
func set_cell(rel_coords: Vector2i, cell: WorldCell) -> void:
	_cells[rel_coords.y * SIZE + rel_coords.x] = cell

# Gaussian blur parameters and constants:
const _R := 3
const _SIDELEN := 2 * _R + 1
const _SD := 0.8
const _2SDSQ := 2.0 * _SD * _SD
static var _GAUSSIAN := PackedFloat64Array()

const _NOISE_COORD_COEFF := 2.0

static func _static_init() -> void:
	# Calculate the Gaussian blur matrix:
	_GAUSSIAN.resize(_SIDELEN * _SIDELEN)
	for xy in Util.vec2i_range(Vector2i(-_R, -_R), Vector2i(_R + 1, _R + 1)):
		print(xy)
		var i := xy.y + _R
		var j := xy.x + _R
		_GAUSSIAN[i * _SIDELEN + j] = exp(-(xy.x * xy.x + xy.y * xy.y) / _2SDSQ) / (PI * _2SDSQ)

## Generates a copy of the chunk at the given super coordinates.
static func generate(noise_gen: FastNoiseLite, super_coords: Vector2i) -> Chunk:
	var chunk := Chunk.new()
	var corner_coords := super_coords * SIZE
	
	for rel_coords in Util.vec2i_range(Vector2i(0, 0), Vector2i(SIZE, SIZE)):
		var noise_xy := _NOISE_COORD_COEFF * (corner_coords + rel_coords)
		var biomic_x := noise_gen.get_noise_3d(noise_xy.x, noise_xy.y, 0)
		var biomic_y := noise_gen.get_noise_3d(noise_xy.x, noise_xy.y, 100)
		var biomic_xy := Vector2(biomic_x, biomic_y)
		chunk.set_cell(rel_coords, WorldCell.new(biomic_xy))
	
	return chunk
