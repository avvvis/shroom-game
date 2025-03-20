## A white noise generator with an API similar to a subset of that of [Noise].
##
## You can think of it as an infinite 3D array filled wth pseudorandom floats,
## evenly distributed between [code]-1[/code] and [code]1[/code].
class_name WhiteNoise

## The seed for the noise.
var seed: int

func get_noise_3d(x: int, y: int, z: int) -> float:
	# TODO: generate white noise in a way that's less retarded
	var input := PackedByteArray()
	input.resize(4 * 8)
	input.encode_s64(0 * 8, seed)
	input.encode_s64(1 * 8, x)
	input.encode_s64(2 * 8, y)
	input.encode_s64(3 * 8, z)
	var hc := HashingContext.new()
	hc.start(HashingContext.HASH_SHA256)
	hc.update(input)
	const NBITS := 48
	var s64 := absi(hc.finish().decode_s64(0)) & ((1 << NBITS) - 1)
	return 2.0 * (float(s64) / (1 << NBITS)) - 1.0

func get_noise_2d(x: int, y: int) -> float:
	return get_noise_3d(x, y, 0)

func get_noise_1d(x: int) -> float:
	return get_noise_3d(x, 0, 0)

func get_noise_3dv(xyz: Vector3i) -> float:
	return get_noise_3d(xyz.x, xyz.y, xyz.z)

func get_noise_2dv(xy: Vector2i) -> float:
	return get_noise_3d(xy.x, xy.y, 0)
