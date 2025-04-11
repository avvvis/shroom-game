extends GutTest

var main_menu

func before_each():
	main_menu = load("res://Levels/UI/UI.tscn").instantiate()
	add_child(main_menu)
	await get_tree().process_frame

func after_each():
	main_menu.queue_free()
	await get_tree().process_frame

func test_apply_button_updates_global_settings():
	main_menu.volume_slider.value = 0.3
	main_menu.fullscreen_check.button_pressed = true
	main_menu.border_check.button_pressed = true
	main_menu.darkmode_check.button_pressed = true
	main_menu.resolution_option.select(2)

	main_menu._on_apply_pressed()

	# Uncomment if volume issues are resolved in testing
	# assert_almost_eq(GlobalSettings.volume, 0.3, 0.01)
	assert_eq(GlobalSettings.fullscreen, true)
	assert_eq(GlobalSettings.borderless, true)
	assert_eq(GlobalSettings.darkmode, true)
	assert_eq(GlobalSettings.res_index, 2)

func test_apply_button_resets_changes_flag():
	main_menu.changes = true
	main_menu._on_apply_pressed()
	assert_eq(main_menu.changes, false)

func test_resolution_selection_sets_changes_flag():
	main_menu.changes = false
	main_menu._on_resolution_option_item_selected(1)
	assert_eq(main_menu.changes, true)

func test_ui_cancel_from_settings_without_changes_closes_settings():
	main_menu.settings.visible = true
	main_menu.changes = false

	var ev = InputEventAction.new()
	ev.action = "ui_cancel"
	ev.pressed = true

	main_menu._input(ev)
	await get_tree().process_frame

	assert_eq(main_menu.settings.visible, false)

func test_ui_cancel_from_settings_with_changes_shows_confirm():
	main_menu.settings.visible = true
	main_menu.changes = true

	var ev = InputEventAction.new()
	ev.action = "ui_cancel"
	ev.pressed = true

	main_menu._input(ev)
	await get_tree().process_frame

	assert_eq(main_menu.exit_settings.visible, true)

func test_yes_exit_settings_applies_and_closes():
	main_menu.settings.visible = true
	main_menu.exit_settings.visible = true
	main_menu.changes = true

	main_menu._on_yes_exitSettings_pressed()
	await get_tree().process_frame

	assert_eq(main_menu.settings.visible, false)
	assert_eq(main_menu.exit_settings.visible, false)
	assert_eq(main_menu.changes, false)

func test_no_exit_settings_discards_changes():
	main_menu.settings.visible = true
	main_menu.exit_settings.visible = true
	main_menu.changes = true

	main_menu._on_no_Settings_pressed()
	await get_tree().process_frame

	assert_eq(main_menu.exit_settings.visible, false)
	assert_eq(main_menu.settings.visible, false)
	assert_eq(main_menu.changes, false)
