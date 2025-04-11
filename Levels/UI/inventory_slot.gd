extends Control

@onready var icon = $ItemIcon
@onready var viewport_container = $MushroomViewportContainer
@onready var viewport = $MushroomViewportContainer/SubViewport

func show2d(item):
	var texture = item.GetVisual
	icon.texture = texture
	icon.visible = true
	viewport_container.visible = false

func show3d(scene: PackedScene):
	icon.visible = false
	viewport_container.visible = true

	viewport.clear()  # Clear existing children
	for child in viewport.get_children():
		child.queue_free()

	var mushroom = scene.instantiate()
	viewport.add_child(mushroom)
