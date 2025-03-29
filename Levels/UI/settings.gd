extends Control

# UI Nodes
@onready var main_panel = $MainSettingsPanel
@onready var resolution_option = $MainSettingsPanel/MarginContainer/VBox/ResPanel/MarginContainer/ResolutionOption
@onready var fullscreen_check = $MainSettingsPanel/MarginContainer/VBox/FullscreenPanel/MarginContainer/FullscreenCheck
@onready var border_check = $MainSettingsPanel/MarginContainer/VBox/BorderPanel/MarginContainer/BorderCheck
@onready var volume_slider = $MainSettingsPanel/MarginContainer/VBox/VolPanel/MarginContainer/SoundSlide
@onready var darkmode_check = $MainSettingsPanel/MarginContainer/VBox/DarkPanel/MarginContainer/DarkCheck
@onready var apply_button = $MainSettingsPanel/MarginContainer/VBox/Apply
#exit_ask_nodes
@onready var exit_confirm = $exit_confirm
@onready var exit_save = $exit_confirm/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/yes
@onready var exit_discard = $exit_confirm/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer2/no

# Predefined list of resolutions
var resolutions = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2880,1800),
	Vector2i(3840,2160),
]

var changes = false

func _ready():
	for res in resolutions:
		resolution_option.add_item("%dx%d" % [res.x, res.y])
		
	load_settings()
	
	resolution_option.grab_focus()


func load_settings():
	#Load resolution
	resolution_option.select(GlobalSettings.res_index)
	# Load fullscreen
	fullscreen_check.button_pressed = GlobalSettings.fullscreen
	#Load borders
	border_check.button_pressed = GlobalSettings.borderless
	# Load volume
	volume_slider.value = GlobalSettings.volume
	#Load theme
	darkmode_check.button_pressed = GlobalSettings.darkmode;
	
	
func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		if !changes:
			get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
		else:
			main_panel.visible = false
			exit_confirm.visible = true
			exit_save.grab_focus()

func _on_resolution_option_item_selected(index: int) -> void:
	changes = true


func _on_fullscreen_check_pressed() -> void:
	changes = true


func _on_border_check_pressed() -> void:
	changes = true


func _on_dark_check_pressed() -> void:
	changes = true

func _on_apply_pressed():
	#update parameters of settings
	GlobalSettings.res_index = resolution_option.get_selected()
	GlobalSettings.fullscreen = fullscreen_check.button_pressed
	GlobalSettings.borderless = border_check.button_pressed
	GlobalSettings.volume = volume_slider.value
	GlobalSettings.darkmode = darkmode_check.button_pressed
	#apply parameters
	GlobalSettings.apply_settings()
	changes = false;	


func _on_yes_pressed() -> void:
	_on_apply_pressed()
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")


func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/UI/main_menu.tscn")
