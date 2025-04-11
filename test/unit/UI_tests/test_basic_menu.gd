extends GutTest

var main_menu

func before_each():
	main_menu = load("res://Levels/UI/UI.tscn").instantiate()
	add_child(main_menu)
	await get_tree().process_frame

func after_each():
	main_menu.queue_free()
	await get_tree().process_frame

func test_exit_button_shows_confirm_dialog():
	main_menu._on_ausgang_pressed()
	await get_tree().process_frame
	assert_eq(main_menu.confirm.visible, true)

func test_no_button_hides_confirm_dialog():
	main_menu._on_ausgang_pressed()
	await get_tree().process_frame
	main_menu._on_no_pressed()
	await get_tree().process_frame
	assert_eq(main_menu.confirm.visible, false)

func test_back_credits_button_toggles_menu_and_credits():
	main_menu.credits.visible = true
	main_menu.menu.visible = false

	main_menu._on_back_credits_pressed()
	await get_tree().process_frame

	assert_eq(main_menu.credits.visible, false)
	assert_eq(main_menu.menu.visible, true)
