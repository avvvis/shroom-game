extends Control

var healthbar: TextureProgressBar

const BAR_WIDTH := 800
const BAR_HEIGHT := 100
const OUTLINE_THICKNESS := 5

func _ready():
	var max_health := GameState.maxhealth
	var current_health := GameState.health

	# Create the health bar node
	healthbar = TextureProgressBar.new()
	healthbar.min_value = 0
	healthbar.max_value = max_health
	healthbar.value = current_health
	healthbar.position = Vector2(50, 50)
	healthbar.size = Vector2(BAR_WIDTH, BAR_HEIGHT)

	# Use solid colors for the bar—no image files required!
	var bg_tex = _make_colored_texture(Color(0.2, 0.2, 0.2), BAR_WIDTH, BAR_HEIGHT)
	var fg_tex = _make_colored_texture(Color(0.2, 0.9, 0.2), BAR_WIDTH, BAR_HEIGHT)
	var outline_tex = _make_colored_outline_texture(Color.BLACK, BAR_WIDTH, BAR_HEIGHT, OUTLINE_THICKNESS)

	healthbar.texture_under = bg_tex      # background bar
	healthbar.texture_progress = fg_tex   # fill bar
	healthbar.texture_over = outline_tex  # black outline

	add_child(healthbar)
	healthbar.position -= Vector2(160, -150) # so the outline is visible

func _make_colored_texture(col: Color, w: int, h: int, line_only := false) -> ImageTexture:
	var img := Image.create(w, h, false, Image.FORMAT_RGBA8)
	for x in w:
		for y in h:
			if line_only and (x == 0 or y == 0 or x == w-1 or y == h-1):
				img.set_pixel(x, y, col)
			elif not line_only:
				img.set_pixel(x, y, col)
	var tex := ImageTexture.create_from_image(img)
	return tex

func _make_colored_outline_texture(col: Color, w: int, h: int, t: int) -> ImageTexture:
	var img := Image.create(w, h, false, Image.FORMAT_RGBA8)
	for x in w:
		for y in h:
			if (x < t or y < t or x >= w-t or y >= h-t):
				img.set_pixel(x, y, col)
	var tex := ImageTexture.create_from_image(img)
	return tex

func _process(delta):
	# LIVE UPDATE from GameState (if it changes during the game)
	healthbar.max_value = GameState.maxhealth
	healthbar.value = GameState.health
