class_name Pathfinding
extends Node2D

@onready var ray = $RayCast2D

var obsticles: Array[float] = [0, 0, 0, 0, 0, 0, 0, 0]
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
	for dir in directions:
		dir.normalized()
	ray.enabled = false
		
func prev(i: int) -> int:
	return (i - 1) % 8

func next(i: int) -> int:
	return (i + 1) % 8

func get_movment_direction(target: Vector2) -> Vector2:
	ray.enabled = true
	for i in range(8):
		var dir = directions[i].normalized()
		ray.rotation = dir.angle()  # rotate ray to direction
		ray.force_raycast_update()  # update raycast result
		obsticles[i] = 0
		interest[i] = dir.dot(target)
		if ray.is_colliding():
			var collider = ray.get_collider()
			# Use `is` to check type, or check group membership
			if collider is Enemy or collider is Obsticle:
				obsticles[i] += 3
				obsticles[prev(i)] += 1
				obsticles[next(i)] += 1
	ray.enabled = false
	print(obsticles)
	if obsticles.max() == 0:
		return target.normalized()  # probably you want it normalized
	for i in range(8):
		interest[i] -= obsticles[i]
	return directions[interest.find(interest.max())].normalized()
	
	
