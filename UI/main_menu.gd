extends Control
@onready var game_button = $Menu/VBoxContainer/game
@onready var options_button = $Menu/VBoxContainer/options
@onready var creds_button = $Menu/VBoxContainer/creds
@onready var exit_button = $Menu/VBoxContainer/ausgang
@onready var menu = $Menu
@onready var no_button = $exit_confirm/ColorRect/VBoxContainer/no
@onready var yes_button = $exit_confirm/ColorRect/VBoxContainer/yes
@onready var confirm = $exit_confirm
@onready var logos = $logo_buttons
var menu_open = false;
var confirm_open = false;

func _input(event):
	if(event.is_action_pressed("ui_accept") && !menu_open && !confirm_open):
		togglemenu()
	
func togglemenu():
	menu_open = !menu_open
	if(menu_open):
		menu.visible = true
		logos.visible = true
		
		await get_tree().process_frame
		game_button.grab_focus()
	else:
		menu.visible = false
		logos.visible = false
		
func toggleconfirm():
	confirm_open = !confirm_open
	if(confirm_open):
		confirm.visible = true
		await get_tree().process_frame
		no_button.grab_focus()
	else:
		confirm.visible = false
		game_button.grab_focus()  # Return focus to the menu after closing confirm

func _on_game_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/settings.tscn")


func _on_creds_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/credits.tscn")


func _on_ausgang_pressed() -> void:
	togglemenu()
	toggleconfirm()


func _on_yes_pressed() -> void:
	get_tree().quit()


func _on_no_pressed() -> void:
	toggleconfirm()
	togglemenu()
