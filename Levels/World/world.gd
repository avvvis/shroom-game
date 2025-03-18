class_name World
extends Node2D

const CHUNK_SIZE = 32

class Cell:
	var humidity: float
	var temperature: float
	
	var tile_coords: Vector2i:
		get:
			#return Vector2i(humidity < 0, temperature < 0)
			if humidity < 0:
				if temperature < 0:
					return Vector2i(3, 2)
				else:
					return Vector2i(2, 0)
			else:
				if temperature < 0:
					return Vector2i(3, 1)
				else:
					return Vector2i(1, 1)

var _noise: FastNoiseLite
@onready var _player: CharacterBody2D = $Player
@onready var _tiles: TileMapLayer = $Tiles
@onready var _regen_area: Area2D = $RegenArea
@onready var _regen_area_shape: CollisionShape2D = $RegenArea/Shape

var world_seed: int:
	get:
		return _noise.seed
	set(value):
		_noise.seed = value

func _init():
	_noise = FastNoiseLite.new()
	_noise.noise_type = FastNoiseLite.TYPE_PERLIN

func _get_cell(coords: Vector2i) -> Cell:
	var x = coords.x * 2
	var y = coords.y * 2
	
	var humidity: float = 0
	var temperature: float = 0
	
	var R = 3
	var STDEV = 0.80
	var STDEV_SQ = STDEV * STDEV
	
	var gaussian_sum: float = 0
	
	for dx in range(-R, +R + 1):
		for dy in range(-R, +R + 1):
			var gaussian = exp(-(dx * dx + dy * dy) / (2 * STDEV_SQ)) / (TAU * STDEV_SQ)
			gaussian_sum += gaussian
			humidity += _noise.get_noise_3d(x + dx, y + dy, 0)
			temperature += _noise.get_noise_3d(x + dx, y + dy, 100)
	
	humidity /= gaussian_sum
	temperature /= gaussian_sum
	
	var wc = Cell.new()
	wc.humidity = humidity
	wc.temperature = temperature
	return wc

func _populate_at(point: Vector2i, cell: Cell) -> void:
	_tiles.set_cell.call_deferred(point, 0, cell.tile_coords)

func _populate_around(origin: Vector2i) -> void:
	#print("_populate_around() start")
	for y in range(-2 * CHUNK_SIZE, +2 * CHUNK_SIZE):
		for x in range(-2 * CHUNK_SIZE, +2 * CHUNK_SIZE):
			var cell = _get_cell(origin + Vector2i(x, y))
			_populate_at(origin + Vector2i(x, y), cell)
	_regen_area.position = origin * _tiles.tile_set.tile_size
	#print("_populate_around() done")

func _ready() -> void:
	_regen_area_shape.scale = Vector2(CHUNK_SIZE, CHUNK_SIZE)
	world_seed = randi()
	print("World seed: ", world_seed)
	_populate_around(Vector2i(0, 0))

func _on_regen_area_body_exited(body: Node2D) -> void:
	if body == _player:
		print("Player exited regen area; regenerating chunks around them.")
		var origin = Vector2i(_player.position) / _tiles.tile_set.tile_size
		var thread = Thread.new()
		thread.start(func(): _populate_around(origin))
		#thread.wait_to_finish()
