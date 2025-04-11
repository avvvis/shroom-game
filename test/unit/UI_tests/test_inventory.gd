extends GutTest

var main_menu

func before_each():
	main_menu = load("res://Levels/UI/UI.tscn").instantiate()
	add_child(main_menu)
	await get_tree().process_frame

func after_each():
	main_menu.queue_free()
	await get_tree().process_frame

func test_toggle_inventory_with_key():
	main_menu.world.visible = true
	main_menu.inv.visible = false
	main_menu.pause.visible = false

	var ev = InputEventAction.new()
	ev.action = "inv"
	ev.pressed = true

	main_menu._input(ev)
	await get_tree().process_frame

	assert_eq(main_menu.inv.visible, true)

	# toggle it back
	main_menu._input(ev)
	await get_tree().process_frame
	assert_eq(main_menu.inv.visible, false)
