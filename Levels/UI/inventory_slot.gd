extends Control

@onready var icon = $ItemIcon
@onready var viewport_container = $Viewport
@onready var viewport = $Viewport/SubViewport
@onready var button = $butt

signal slot_clicked(slot_data)
signal slot_focused(slot_data)
signal slot_unfocused(slot_data)

var data:Item

func show2d(item:Item):
	viewport_container.visible = false
	var temp = load("res://assets/icon.svg")#this line should be replaced when we get items and inventory working
	icon.texture = temp
	data = item
	
func show3d(item:Item):
	icon.visible = false
	var temp = load("res://Levels/Mock/grzyb.tscn")#to be replaced when we work out items better
	viewport.add_child(temp.instantiate())
	data = item

func _ready():
	button.connect("pressed", self._on_pressed)
	button.connect("focus_entered", self._on_focus_entered)
	button.connect("focus_exited", self._on_focus_exited)


func _on_pressed():
	emit_signal("slot_clicked", data)

func _on_focus_entered():
	emit_signal("slot_focused", data)

func _on_focus_exited():
	emit_signal("slot_unfocused", data)
