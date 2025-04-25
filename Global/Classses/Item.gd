class_name Item

var name = "Unknown"
var description = "Use this item and journal results!"
var type = "2d" #2d or 3d

func is_usable():
	return false

func use():
	return -1

func create_world_entity():
	pass

func create_inventory_entity():
	var blank
	blank = load("res://assets/icon.svg")
	return blank


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
