extends Control

@onready var grid = $ListingPanel/ScrollContainer/ItemList
@onready var itemD = $item_description
@onready var preview2d = $item_description/vbox/item_inspector/preview/Preview2d
@onready var preview3d = $item_description/vbox/item_inspector/preview/Preview3d
@onready var Biglabel = $item_description/vbox/Name/BigLabel
@onready var Smalllabel = $item_description/vbox/Description/SmallLabel

func my_grab_focus():
	if grid.get_child_count() > 0:
		var slot = grid.get_child(0)
		slot.grab_focus()

func populate():
	#generic placeholder for testing
	for i in range(0,10):
	#for item in GameState.Inventory.data:
		var slot = preload("res://Levels/UI/inventory_slot.tscn").instantiate()
		var cont: MarginContainer = MarginContainer.new()
		cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		cont.add_child(slot)
		grid.add_child(cont)
		var item := Item.new()
		item.name = "Item #%d" % i
		item.description = "This is item number %d" % i
		if(i == 0):
			slot.get_child(2).grab_focus()
		if(i<5):
			item.type = "2d"
			slot.show2d(item)
		else:
			item.type = "3d"
			slot.show3d(item)
		#if item.type == "2d":
		#	slot.show2d(item.GetVisual())
		#else:
		#	slot.show3d(item.GetVisual())
		slot.connect("slot_clicked", self._on_slot_clicked)
		slot.connect("slot_focused", self._on_slot_focused)
		slot.connect("slot_unfocused", self._on_slot_unfocused)
func showDeets() -> void:
	itemD = null

func _ready():
	self.visible = false

func clear():
	for child in grid.get_children():
		grid.remove_child(child)
		child.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_slot_clicked(data):
	pass
	
func _on_slot_focused(data:Item):
	if(data.type == "2d"):
		preview3d.visible = false
		preview2d.visible = true
	else:
		preview2d.visible = false
		preview3d.visible = true
	Biglabel.clear()
	Smalllabel.clear()
	Biglabel.add_text(data.name)
	Smalllabel.add_text(data.description)

func _on_slot_unfocused(data):
	pass
