class_name Item

var name
var description
var type #2d or 3d

func _init():	
	name = 'Unkown'
	description = 'use this Item and journal results'

func setBase(name_, description_):
	name = name_
	description = description_

func use():
	return -1

func getVisual():
	var blank
	blank = load("res://assets/icon.svg")
	return blank


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
