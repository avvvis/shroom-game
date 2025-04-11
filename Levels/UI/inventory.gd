extends Control

@onready var grid = $ListingPanel/ScrollContainer/ItemList
var slot_scene = load("res://Levels/UI/inventory_slot.tscn")

func _ready():
	self.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clear():
	grid.clear()

func populate():
	for item in GameState.Inventory :
		var slot = slot_scene.instantiate()
		grid.add_child(slot)
		
		if(item.type == "2d"):
			slot.show2d(item)
		else:
			slot.show3d(item)
