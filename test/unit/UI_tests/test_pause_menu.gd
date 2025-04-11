extends GutTest

var main_menu

func before_each():
	main_menu = load("res://Levels/UI/UI.tscn").instantiate()
	add_child(main_menu)
	await get_tree().process_frame

func after_each():
	main_menu.queue_free()
	await get_tree().process_frame

func test_ui_cancel_while_in_world_opens_pause():
	main_menu.world.visible = true
	main_menu.pause.visible = false
	main_menu.settings.visible = false

	var ev = InputEventAction.new()
	ev.action = "ui_cancel"
	ev.pressed = true

	main_menu._input(ev)
	await get_tree().process_frame

	assert_eq(main_menu.pause.visible, true)
	assert_eq(get_tree().paused, true)

func test_pause_back_button_unpauses_game():
	main_menu.pause.visible = true
	get_tree().paused = true

	main_menu._on_pause_back_pressed()
	await get_tree().process_frame

	assert_eq(main_menu.pause.visible, false)
	assert_eq(get_tree().paused, false)

func test_pause_main_menu_button_returns_to_main_menu():
	main_menu.world.visible = true
	main_menu.pause.visible = true

	main_menu._on_main_menu_pressed()
	await get_tree().process_frame

	assert_eq(main_menu.world.visible, false)
	assert_eq(main_menu.fullmenu.visible, true)
	assert_eq(get_tree().paused, false)
