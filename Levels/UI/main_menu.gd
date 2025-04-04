extends Control
@onready var game_button = $Menu/MarginContainer/VBoxContainer/game
@onready var options_button = $Menu/MarginContainer/VBoxContainer/options
@onready var creds_button = $Menu/MarginContainer/VBoxContainer/creds
@onready var exit_button = $Menu/MarginContainer/VBoxContainer/ausgang
@onready var menu = $Menu
@onready var no_button = $exit_confirm/ColorRect/MarginContainer/VBoxContainer/no
@onready var yes_button = $exit_confirm/ColorRect/MarginContainer/VBoxContainer/yes
@onready var confirm = $exit_confirm
@onready var logos = $logo_buttons

var menu_open = GlobalSettings.menu_open
var confirm_open = false

func _ready():
	game_button.grab_focus()

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
	GlobalSettings.menu_open = menu_open
	pass # Replace with function body.


func _on_options_pressed() -> void:
	GlobalSettings.menu_open = menu_open
	get_tree().change_scene_to_file("res://Levels/UI/settings.tscn")


func _on_creds_pressed() -> void:
	GlobalSettings.menu_open = menu_open
	get_tree().change_scene_to_file("res://Levels/UI/credits.tscn")


func _on_ausgang_pressed() -> void:
	togglemenu()
	toggleconfirm()


func _on_yes_pressed() -> void:
	get_tree().quit()


func _on_no_pressed() -> void:
	toggleconfirm()
	togglemenu()
