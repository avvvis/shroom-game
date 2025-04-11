extends Control

@export var radius := 100.0

@export var day_color := Color.hex(0)
@export var evening_color := Color.hex(0)
@export var night_color := Color.hex(0) 

@export_range(0, 1, 0.01) var day_ratio := 0.5
@export_range(0, 1, 0.01) var evening_ratio := 0.25
@export_range(0, 1, 0.01) var night_ratio := 0.25

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(center)
	var colors = PackedColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

func _draw():
	var center = size / 2

	var start_angle := -90

	var angles = [
		{ "color": day_color, "ratio": day_ratio },
		{ "color": evening_color, "ratio": evening_ratio },
		{ "color": night_color, "ratio": night_ratio },
	]

	for section in angles:
		var sweep = section.ratio * 360
		draw_circle_arc_poly(center, radius, start_angle, start_angle+sweep, section.color)
		start_angle += sweep

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
