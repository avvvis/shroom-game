class_name Util

class Vector2iRange:
	var begin: Vector2i
	var end: Vector2i
	var cur: Vector2i
	
	func _init(start: Vector2i, stop: Vector2i) -> void:
		begin = start
		end = stop
		cur = begin
		end.x = maxi(begin.x, end.x)
		end.y = maxi(begin.y, end.y)
		if end.x == begin.x || end.y == begin.y:
			end = begin
	
	func _iter_init(_iter: Array) -> bool:
		cur = begin
		return cur.y != end.y
	
	func _iter_next(_iter: Array) -> bool:
		cur.x += 1
		if cur.x == end.x:
			cur.x = begin.x
			cur.y += 1
		return cur.y != end.y
	
	func _iter_get(_iter: Variant) -> Vector2i:
		return cur

## Returns an iterable over all integer points in the rectangle
## from [start] (inclusive) to [stop] (exclusive).
static func vec2i_range(start: Vector2i, stop: Vector2i) -> Vector2iRange:
	return Vector2iRange.new(start, stop)

## Calculates the super coords of the chunk the cell at the given coords is in.
static func super_coords(cell_coords: Vector2i) -> Vector2i:
	# Integer division truncates (rounds towards zero), but we want to always round down.
	@warning_ignore("integer_division")
	var sx := cell_coords.x / Chunk.SIZE if cell_coords.x >= 0 else -((-cell_coords.x + Chunk.SIZE-1) / Chunk.SIZE)
	@warning_ignore("integer_division")
	var sy := cell_coords.y / Chunk.SIZE if cell_coords.y >= 0 else -((-cell_coords.y + Chunk.SIZE-1) / Chunk.SIZE)
	return Vector2i(sx, sy)

static func hash_int(x: int) -> int:
	# Courtesy of this StackOverflow answer:
	# https://stackoverflow.com/a/12996028
	
	# 2's complement multiplication is not sign-sensitive,
	# but I am sort of assuming these overflows are well-defined
	# and just truncate the result.
	x = (x ^ (x >> 31) ^ (x >> 62)) * 0x319642b2d24d8ec3
	x = (x ^ (x >> 27) ^ (x >> 54)) * (-7575587736534282103)
	x = x ^ (x >> 30) ^ (x >> 60)
	return x
