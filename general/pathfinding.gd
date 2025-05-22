class_name Pathfinding
extends Node2D

@onready var ray = $RayCast2D

var obstacles: Array[float] = [0, 0, 0, 0, 0, 0, 0, 0]
var interest: Array[float] = [0, 0, 0, 0, 0, 0, 0, 0]
var directions: Array[Vector2] = [
	Vector2(0, -1),
	Vector2(1, -1),
	Vector2(1, 0),
	Vector2(1, 1),
	Vector2(0, 1),
	Vector2(-1, 1),
	Vector2(-1, 0),
	Vector2(-1, -1),
]

func _ready() -> void:
	for i in directions.size():
		directions[i].normalized()
	ray.enabled = false
		
func prev(i: int) -> int:
	return (i - 1) % 8

func next(i: int) -> int:
	return (i + 1) % 8

func get_movment_direction(target: Vector2) -> Vector2:
	ray.enabled = true
	for i in range(8):
		ray.target_position = directions[i] * 50
		ray.force_raycast_update()  
		obstacles[i] = 0
		interest[i] = directions[i].dot(target)
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider is Enemy or collider is Obstacle:
				obstacles[i] += 5
				obstacles[prev(i)] += 3
				obstacles[next(i)] += 3
	ray.enabled = false
	if obstacles.max() == 0:
		return target.normalized()
	for i in range(8):
		interest[i] -= obstacles[i]
	return directions[interest.find(interest.max())].normalized()
	
	
