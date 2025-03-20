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
	
	func _iter_init(iter: Array) -> bool:
		#print("_iter_init: ", cur)
		cur = begin
		return cur.y != end.y
	
	func _iter_next(iter: Array) -> bool:
		#print("_iter_next: ", cur)
		cur.x += 1
		if cur.x == end.x:
			cur.x = begin.x
			cur.y += 1
		return cur.y != end.y
	
	func _iter_get(iter: Variant) -> Vector2i:
		#print("_iter_get: ", cur)
		return cur

static func vec2i_range(start: Vector2i, stop: Vector2i) -> Vector2iRange:
	return Vector2iRange.new(start, stop)

static func super_coords(cell_coords: Vector2i) -> Vector2i:
	# Integer division truncates (rounds towards zero), but we want to always round down.
	var sx := cell_coords.x / Chunk.SIZE if cell_coords.x >= 0 else -((-cell_coords.x + Chunk.SIZE-1) / Chunk.SIZE)
	var sy := cell_coords.y / Chunk.SIZE if cell_coords.y >= 0 else -((-cell_coords.y + Chunk.SIZE-1) / Chunk.SIZE)
	return Vector2i(sx, sy)
