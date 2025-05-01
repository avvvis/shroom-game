class_name Item
var ID:String = "FFFF_0000" #naming like category + _ + idnumbr 
var name:String = "Unknown"
var description:String = "Use this item and journal results!"
var type:String = "2d" #2d or 3d
var stackable:bool = false

func is_stackable()->bool:
	return stackable

func is_usable():
	return false

func use():
	return -1

func create_world_entity():
	pass

func create_inventory_entity():
	var blank
	if(type == "2d"):
		blank = load("res://assets/icon.svg")
	else:
		blank = load("res://Levels/Mock/grzyb.tscn")
	return blank
