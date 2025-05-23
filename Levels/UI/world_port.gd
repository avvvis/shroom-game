extends SubViewportContainer

var shader_material: ShaderMaterial
var sub_viewport: SubViewport

func _ready():
	shader_material = material
	if not shader_material:
		push_error("No ShaderMaterial assigned to SubViewportContainer.material")

	sub_viewport = $viewport
	
	GameState.acidity_changed.connect(_on_acidity_changed)

func _process(delta):
	if not shader_material:
		return

	var time_sec = Time.get_ticks_msec() / 1000.0
	shader_material.set_shader_parameter("time", time_sec)

func _on_acidity_changed(acidity):
	shader_material.set_shader_parameter("acidity", acidity / GameState.max_acidity)
