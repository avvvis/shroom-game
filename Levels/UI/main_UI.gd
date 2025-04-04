extends Control
#############################################################################
#Node adding
###############################################################################
# menu nodes
@onready var game_button = $Menu/MarginContainer/VBoxContainer/game
@onready var options_button = $Menu/MarginContainer/VBoxContainer/options
@onready var creds_button = $Menu/MarginContainer/VBoxContainer/creds
@onready var exit_button = $Menu/MarginContainer/VBoxContainer/ausgang
@onready var menu = $Menu
@onready var settings = $Settings
# menu exit nodes
@onready var no_button = $exit_confirm/ColorRect/MarginContainer/VBoxContainer/no
@onready var yes_button = $exit_confirm/ColorRect/MarginContainer/VBoxContainer/yes
@onready var confirm = $exit_confirm
@onready var logos = $logo_buttons

# settings nodes
@onready var main_panel = $Settings
@onready var resolution_option = $Settings/MarginContainer/VBox/ResPanel/MarginContainer/ResolutionOption
@onready var fullscreen_check = $Settings/MarginContainer/VBox/FullscreenPanel/MarginContainer/FullscreenCheck
@onready var border_check = $Settings/MarginContainer/VBox/BorderPanel/MarginContainer/BorderCheck
@onready var volume_slider = $Settings/MarginContainer/VBox/VolPanel/MarginContainer/SoundSlide
@onready var darkmode_check = $Settings/MarginContainer/VBox/DarkPanel/MarginContainer/DarkCheck
@onready var apply_button = $Settings/MarginContainer/VBox/Apply
#settings exit nodes
@onready var exit_settings = $exit_settings_confirm
@onready var exit_confirm = $exit_settings_confirm
@onready var exit_save = $exit_settings_confirm/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/yes
@onready var exit_discard = $exit_settings_confirm/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer2/no

#credits node
@onready var credits = $Credits
###############################################################
#variables
#################################################################

#organizational
var menu_open = true;
var settings_open = false;
var confirm_open = false
var settings_confirm_open = false;
var credit_open = false;

#settings variables
var resolutions = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2880,1800),
	Vector2i(3840,2160),
]
var changes = false

################################################################################
#GODOT functions
##################################################################################

func _ready():
	game_button.grab_focus()
	for res in resolutions:
		resolution_option.add_item("%dx%d" % [res.x, res.y])
		
	load_settings()

func _input(event):
	if(event.is_action_pressed("ui_cancel") && settings_open):
		if !changes:
			toggleSettings()
			togglemenu()
		else:
			togglemenu()
			toggleSettingsconfirm()
	elif(event.is_action_pressed("ui_cancel") && credit_open):
		togglecredit()
		togglemenu()
	elif(event.is_action_pressed("ui_cancel") && confirm_open):
		toggleconfirm()
		togglemenu()
	elif(event.is_action_pressed("ui_cancel") && menu_open):
		togglemenu()
		toggleconfirm()
	
#############################################################################
#panel swapping
#######################################################################################
func togglemenu():
	menu_open = !menu_open
	menu.visible = menu_open
	logos.visible = menu_open
	await get_tree().process_frame
	if(menu_open):
		game_button.grab_focus()
		
func toggleSettings():
	settings_open = !settings_open
	settings.visible = settings_open
	await get_tree().process_frame
	if(settings_open): resolution_option.grab_focus()

func toggleconfirm():
	confirm_open = !confirm_open
	confirm.visible = confirm_open
	await get_tree().process_frame
	if(confirm_open): yes_button.grab_focus()

func toggleSettingsconfirm():
	settings_confirm_open = ! settings_confirm_open
	exit_settings.visible = settings_confirm_open
	await get_tree().process_frame
	if(settings_confirm_open): exit_discard.grab_focus()

func togglecredit():
	credit_open = !credit_open
	credits.visible = credit_open
	
##################################################################################################
#main menu buttons
##################################################################################################
func _on_game_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	togglemenu()
	toggleSettings()


func _on_creds_pressed() -> void:
	togglemenu()
	togglecredit()


func _on_ausgang_pressed() -> void:
	togglemenu()
	toggleconfirm()


########################################################################
#GAME EXIT BUTTONS
########################################################################
func _on_yes_pressed() -> void:
	get_tree().quit()


func _on_no_pressed() -> void:
	toggleconfirm()
	togglemenu()


#######################################################################
#Settings utility
#######################################################################
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
	
#########################################################################
#Settings buttons
#########################################################################

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


func _on_yes_exitSettings_pressed() -> void:
	_on_apply_pressed()
	toggleSettingsconfirm()
	toggleSettings()
	togglemenu()


func _on_no_Settings_pressed() -> void:
	toggleSettingsconfirm()
	toggleSettings()
	togglemenu()
