## Holds all the tweakable parameters used in the world generation process.
##
## See: [Chunk].
class_name WorldGenParams

var master_seed: int

func _to_string() -> String:
	return "{master_seed={0}}".format([master_seed])
