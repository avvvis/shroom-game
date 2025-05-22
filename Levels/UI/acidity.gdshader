shader_type canvas_item;

uniform sampler2D screen_tex;
uniform float time;
uniform vec2 resolution;

void fragment() {
    vec2 uv = FRAGCOORD.xy / resolution;

    // Wavy UV distortion
    float freq = 10.0;
    float speed = 2.0;
    vec2 distorted_uv = uv;
    distorted_uv.x += sin(uv.y * freq + time * speed) * 0.02;
    distorted_uv.y += cos(uv.x * freq * 1.5 + time * speed) * 0.02;

    // Sample the viewport texture with the distorted UV
    vec4 col = texture(screen_tex, distorted_uv);

    // RGB channel shift for chromatic aberration
    float shift = 0.01;
    float r = texture(screen_tex, distorted_uv + vec2(shift, 0.0)).r;
    float g = texture(screen_tex, distorted_uv).g;
    float b = texture(screen_tex, distorted_uv - vec2(shift, 0.0)).b;

    col.rgb = vec3(r, g, b);

    // Additional color cycling
    float hue_shift = sin(time * 2.0) * 0.1;
    float angle = hue_shift * 6.2831;
    float c = cos(angle);
    float s = sin(angle);
    mat3 hue_rotation = mat3(
        vec3(0.299, 0.587, 0.114),
        vec3(0.701, -0.587, -0.114),
        vec3(-0.299, -0.587, 0.886)
    );
    // Simple hue rotation
    col.rgb = col.rgb * c + (col.rgb.yzx * s);

    COLOR = col;
}