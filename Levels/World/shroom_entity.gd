extends Node2D

var _shroom: IngredientSpecimen
@onready var _sprite: Sprite2D = $Sprite2D
@onready var _subviewport: SubViewport = $SubViewport

func set_shroom(shroom: IngredientSpecimen) -> void:
	_shroom = shroom

func _ready() -> void:
	_subviewport.add_child(_shroom)
	#await RenderingServer.frame_post_draw
	#await RenderingServer.frame_post_draw
	#await RenderingServer.frame_post_draw
	#var image = _subviewport.get_texture().get_image()
	#var texture = ImageTexture.create_from_image(image)
	#_sprite.texture = texture
