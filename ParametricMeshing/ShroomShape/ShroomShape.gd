extends Node3D
class_name ShroomShape

var _cap
var _leg

func _init(c_cap :Cap, c_leg :Leg):
	set_cap(c_cap)
	set_leg(c_leg)

func set_cap(c_cap :Cap):
	_cap = c_cap
	
func get_cap():
	return _cap

func set_leg(c_leg :Leg):
	_leg = c_leg
	
func get_leg():
	return _leg
