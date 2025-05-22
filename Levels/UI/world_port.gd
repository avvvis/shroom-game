extends SubViewportContainer

var shader_material: ShaderMaterial
var sub_viewport: SubViewport

func _ready():
	shader_material = material
	if not shader_material:
		push_error("No ShaderMaterial assigned to SubViewportContainer.material")

	sub_viewport = $viewport
	if sub_viewport:
		shader_material.set_shader_parameter("screen_tex", sub_viewport.get_texture())
	else:
		push_warning("SubViewport node not found as child")

func _process(delta):
	if not shader_material:
		return

	var time_sec = Time.get_ticks_msec() / 1000.0
	shader_material.set_shader_parameter("time", time_sec)
	shader_material.set_shader_parameter("resolution", GlobalSettings.resolutions[GlobalSettings.res_index])

	if sub_viewport:
		shader_material.set_shader_parameter("screen_tex", sub_viewport.get_texture())
