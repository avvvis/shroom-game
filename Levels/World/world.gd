class_name World
extends Node2D

var _gen_params := WorldGenParams.new()
var _chunk_cache: Dictionary[Vector2i, Chunk] = {}

@onready var _tiles := $Tiles
@onready var _player := $PlayerCharacter
@onready var _regen_area := $RegenArea
@onready var _regen_area_shape := $RegenArea/Shape
@onready var _tile_size: int = $Tiles.tile_set.tile_size.x

func _init() -> void:
	_gen_params.master_seed = randi()
	print("World Gen Params: ", _gen_params)

func get_chunk(super_coords: Vector2i) -> Chunk:
	var chunk := _chunk_cache.get(super_coords) as Chunk
	if chunk == null:
		chunk = Chunk.generate(_gen_params, super_coords)
		_chunk_cache[super_coords] = chunk
	return chunk

func _ready() -> void:
	_regen_area_shape.scale = Vector2(Chunk.SIZE, Chunk.SIZE)
	_regen_area.position = Vector2(0.5, 0.5) * Chunk.SIZE * _tile_size
	_populate_chunks_around(Vector2i(0, 0))

func _on_regen_area_body_exited(body: Node2D) -> void:
	if body == _player:
		var super_coords := _player.get_super_coords() as Vector2i
		_regen_area.position = (Vector2(super_coords) + Vector2(0.5, 0.5)) * Chunk.SIZE * _tile_size
		_populate_chunks_around(super_coords)

func _populate_chunks_around(super_coords: Vector2i) -> void:
	for offset in Util.vec2i_range(Vector2i(-1, -1), Vector2i(2, 2)):
		_populate_chunk_at(super_coords + offset)

func _populate_chunk_at(super_coords: Vector2i) -> void:
	var chunk := get_chunk(super_coords)
	var corner_coords := super_coords * Chunk.SIZE
	for dy in range(Chunk.SIZE):
		for dx in range(Chunk.SIZE):
			var rel_coords := Vector2i(dx, dy)
			var coords := corner_coords + rel_coords
			var cell := chunk.get_cell(rel_coords)
			var tile_coords := Vector2i(2.0 * (cell.biomic_xy.clampf(-0.999, 0.999) + Vector2(1, 1)))
			_tiles.set_cell(coords, 0, tile_coords)
