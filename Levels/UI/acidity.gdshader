shader_type canvas_item;

void fragment() {
	COLOR *= 0.5 + 0.5 * length(texture(TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, 0.0)) - texture(TEXTURE, SCREEN_UV));
	COLOR = texture(TEXTURE, vec2(mod(UV.x + UV.y, 1), UV.y));
}