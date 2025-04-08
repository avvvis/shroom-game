@tool
extends ProgrammaticTheme

# Font settings
const DEFAULT_FONT = "res://themes/fonts/Poppins-MediumItalic.ttf"
const DEFAULT_FONT_SIZE = 64

# UI Colors
var background_color
var background_color_solid
var text_color

var button_color
var button_hover_color
var button_pressed_color
var button_border_color

# UI Properties
const DEFAULT_BORDER_WIDTH = 8
const DEFAULT_CORNER_RADIUS = 25
const PANEL_CORNER_RADIUS = 50
const MARGIN_SIZE = 12
const PADDING_SIZE = 16
const BUTTON_PADDING = 20
const LABEL_PADDING = 8

# Theme Setup Functions
func setup_dark_theme():
	set_save_path("res://themes/build/dark_theme.tres")
	
	background_color = Color.from_rgba8(1, 1, 1, 194)
	background_color_solid = Color.from_rgba8(1, 1, 1, 255)  
	text_color = Color.WHITE
	
	button_color = background_color
	button_hover_color = button_color.darkened(0.1)
	button_pressed_color = button_color.darkened(0.15)
	button_border_color = background_color.darkened(0.42)

func setup_light_theme():
	set_save_path("res://themes/build/light_theme.tres")
	
	background_color = Color.from_rgba8(250, 240, 230, 164)
	background_color_solid = Color.from_rgba8(250, 240, 230, 255)  
	text_color = Color.BLACK
	
	button_color = background_color
	button_hover_color = button_color.darkened(0.1)
	button_pressed_color = button_color.darkened(0.15)
	button_border_color = background_color.darkened(0.22)



# Theme Definition
func define_theme():
	# Set global font and size
	define_default_font(load(DEFAULT_FONT))
	define_default_font_size(DEFAULT_FONT_SIZE)

	# Panel Styles
	var panel_style = stylebox_flat({
		bg_color = background_color,
		border_color = button_border_color,
		corner_radius_ = corner_radius(PANEL_CORNER_RADIUS),
		border_width_ = border_width(DEFAULT_BORDER_WIDTH),
		content_margin_ = content_margins(MARGIN_SIZE)
	})
	
	define_style("Panel", { panel = panel_style })
	define_style("PanelContainer", { panel = panel_style })

	# MarginContainer Styling (for consistent spacing)
	define_style("MarginContainer", {
		margin_top = MARGIN_SIZE,
		margin_bottom = MARGIN_SIZE,
		margin_left = MARGIN_SIZE,
		margin_right = MARGIN_SIZE,
		padding_top = PADDING_SIZE,
		padding_bottom = PADDING_SIZE,
		padding_left = PADDING_SIZE,
		padding_right = PADDING_SIZE
	})

	# Label Styling
	define_style("Label", { 
		font_color = text_color,
		padding_top = LABEL_PADDING,
		padding_bottom = LABEL_PADDING,
		padding_left = LABEL_PADDING,
		padding_right = LABEL_PADDING
	})

	# Button Styles
	var button_style = stylebox_flat({
		corner_radius_ = corner_radius(DEFAULT_CORNER_RADIUS),
		bg_color = button_color,
		border_color = button_border_color,
		border_ = border_width(DEFAULT_BORDER_WIDTH),
		content_margin_top = BUTTON_PADDING,
		content_margin_bottom = BUTTON_PADDING,
		content_margin_left = BUTTON_PADDING,
		content_margin_right = BUTTON_PADDING
	})
	
	# Button hover and pressed states for button depth effect
	var button_hover_style = inherit(button_style, { 
		bg_color = button_hover_color,
		content_margin_top = BUTTON_PADDING + 3,  # Slight depth on hover
		content_margin_bottom = BUTTON_PADDING + 3,
		content_margin_left = BUTTON_PADDING + 3,
		content_margin_right = BUTTON_PADDING + 3
	})
	
	var button_pressed_style = inherit(button_style, {
		bg_color = button_pressed_color,
		border_color = button_border_color.lightened(0.2),
		content_margin_top = BUTTON_PADDING + 5,  # Increased depth when pressed
		content_margin_bottom = BUTTON_PADDING + 5,
		content_margin_left = BUTTON_PADDING,
		content_margin_right = BUTTON_PADDING
	})
	
	# Define the Button with the various states (normal, hover, pressed)
	define_style("Button", {
		font_color = text_color,
		font_hover_color = text_color,
		font_focus_color = text_color,
		font_pressed_color = text_color,
		normal = button_style,
		hover = button_hover_style,
		pressed = button_pressed_style
	})

	# Define Containers
	define_style("VBoxContainer", {
		margin_top = MARGIN_SIZE,
		margin_bottom = MARGIN_SIZE,
		margin_left = MARGIN_SIZE,
		margin_right = MARGIN_SIZE,
		# Optional padding within container items
		padding_top = PADDING_SIZE,
		padding_bottom = PADDING_SIZE,
		padding_left = PADDING_SIZE,
		padding_right = PADDING_SIZE,
	})

	define_style("HBoxContainer", {
		margin_top = MARGIN_SIZE,
		margin_bottom = MARGIN_SIZE,
		margin_left = MARGIN_SIZE,
		margin_right = MARGIN_SIZE,
		# Optional padding within container items
		padding_top = PADDING_SIZE,
		padding_bottom = PADDING_SIZE,
		padding_left = PADDING_SIZE,
		padding_right = PADDING_SIZE,
	})
