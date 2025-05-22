## Represents a single cell of the world map.
##
## See: [Chunk].
class_name WorldCell

var biomic_xy: Vector2
var has_shroom: bool = false
var has_goblin: bool = false

func _init(biomics: Vector2) -> void:
	biomic_xy = biomics
