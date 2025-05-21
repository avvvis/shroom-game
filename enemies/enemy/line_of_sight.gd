extends RayCast2D

var target: Player
var facing_direction := Vector2.DOWN

@export var angle_cone_of_vision: int
@export var angle_between_rays: int
@export var view_distance: int


func _physics_process(delta: float) -> void:
	var cast_count := int(angle_cone_of_vision / angle_between_rays) + 1
	
	for i in cast_count:
		var angle_offset = angle_between_rays * (i - (cast_count - 1)/2.0)
		var ray_direction = facing_direction.rotated(deg_to_rad(angle_offset))
		target_position = ray_direction * view_distance
		if is_colliding():
			if get_collider() is Player:
				target = get_collider()
				break;
				
func update_direction(new_direction: String) -> void:
	match new_direction:
		"down":
			rotation_degrees = 0
		"up":
			rotation_degrees = 180
		"left":
			rotation_degrees = 90
		"right":
			rotation_degrees = 270
		_:
			rotation_degrees = 0
	facing_direction = Vector2.DOWN.rotated(rotation_degrees)

func _draw():
	var cast_count := int(angle_cone_of_vision / angle_between_rays) + 1
	
	for i in cast_count:
		var angle_offset = angle_between_rays * (i - (cast_count - 1)/2.0)
		var ray_direction = facing_direction.rotated(deg_to_rad(angle_offset))
		target_position = ray_direction * view_distance
		var color := Color.GREEN
		draw_line(Vector2.ZERO, ray_direction * view_distance, color, 1.0)
