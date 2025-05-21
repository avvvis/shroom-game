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
		
func prev(i: int) -> int:
	return (i - 1) % 8

func next(i: int) -> int:
	return (i + 1) % 8

func get_movment_direction(target: Vector2) -> Vector2:
	ray.rotation = 0
	for i in 8:
		obsticles[i] = 0;
		interest[i] = directions[i].dot(target)
		if ray.is_colliding():
			if ray.get_collider() == Enemy or ray.get_collider() == Obsticle:
				obsticles[i] += 3
				obsticles[prev(i)] += 1
				obsticles[next(i)] += 1
	
	if max(obsticles) == 0:
		return target
	
	for i in 8:
		interest[i] -= obsticles[i]	
	
	return directions[interest.find(interest.max())]
	
	
