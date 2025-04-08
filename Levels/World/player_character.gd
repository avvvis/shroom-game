extends CharacterBody2D

@export var speed := 10_000

@onready var _tile_size: int = $"../Tiles".tile_set.tile_size.x

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * delta * speed
	move_and_slide()

func get_coords() -> Vector2i:
	var scaled := position / _tile_size
	return Vector2i(floori(scaled.x), floori(scaled.y))

func get_super_coords() -> Vector2i:
	return Util.super_coords(get_coords())
