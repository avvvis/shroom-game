class_name ItemStack
var item: Item
var quantity: int

func get_item() -> Item: return item

func get_quantity() ->int: return quantity

func is_nonstack() ->bool:
	return !item.stackable
	
func _init(item: Item, quantity: int) -> void:
	self.item = item
	self.quantity = quantity
