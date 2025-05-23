shader_type canvas_item;

uniform float time;
uniform float acidity;

// Code from https://godotshaders.com/snippet/2d-noise/
vec2 random(vec2 uv){
    uv = vec2( dot(uv, vec2(127.1,311.7) ),
               dot(uv, vec2(269.5,183.3) ) );
    return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}

float noise(vec2 uv) {
    vec2 uv_index = floor(uv);
    vec2 uv_fract = fract(uv);

    vec2 blur = smoothstep(0.0, 1.0, uv_fract);

    return mix( mix( dot( random(uv_index + vec2(0.0,0.0) ), uv_fract - vec2(0.0,0.0) ),
                     dot( random(uv_index + vec2(1.0,0.0) ), uv_fract - vec2(1.0,0.0) ), blur.x),
                mix( dot( random(uv_index + vec2(0.0,1.0) ), uv_fract - vec2(0.0,1.0) ),
                     dot( random(uv_index + vec2(1.0,1.0) ), uv_fract - vec2(1.0,1.0) ), blur.x), blur.y) + 0.5;
}
// End of stolen code

vec3 scramble(float f, float s) {
	float z = f;
	float y = (1.0 - f) * s;
	float x = 1.0 - y - z;
	return vec3(x, y, z);
}

// ----------------------------------------------------------------------------
// RGB ↔ HWB
// ----------------------------------------------------------------------------
vec3 rgb2hwb(vec3 c){
    float maxc = max(max(c.r,c.g),c.b);
    float minc = min(min(c.r,c.g),c.b);
    float whiteness = minc;
    float blackness = 1.0 - maxc;
    // compute hue like in HSV
    float hue = 0.0;
    if(maxc > minc){
        float d = maxc - minc;
        if(maxc == c.r) hue = mod((c.g - c.b) / d, 6.0);
        else if(maxc == c.g) hue = (c.b - c.r) / d + 2.0;
        else                      hue = (c.r - c.g) / d + 4.0;
        hue = hue / 6.0;
        if(hue < 0.0) hue += 1.0;
    }
    return vec3(hue, whiteness, blackness);
}

vec3 hwb2rgb(vec3 hwb){
    float h = hwb.x * 6.0;
    float w = hwb.y;
    float b = hwb.z;
    float v = 1.0 - b;
    int   i = int(floor(h)) % 6;
    float f = fract(h);
    if((i & 1)==1) f = 1.0 - f;
    float n = w + f * (v - w);

    if(i==0) return vec3(v,n,w);
    if(i==1) return vec3(n,v,w);
    if(i==2) return vec3(w,v,n);
    if(i==3) return vec3(w,n,v);
    if(i==4) return vec3(n,w,v);
             return vec3(v,w,n);
}


void fragment() {
	float effective_time = time / 100.0;

	float acidity_inflation = acidity;
	//float acidity_colors = pow(abs(sin(PI * acidity / 2.0)), 3.5);
	float acidity_colors = acidity;
	float acidity_burn = 1.0 - acidity;


	// INFLATION
#define inflation_density 10.0
#define delta 0.01
#define delta_x vec2(0.01, 0.0)
#define delta_y vec2(0.0, 0.01)
	float inflation_strength = 0.001 * acidity_inflation;

	float inflation_origin = noise(inflation_density * (SCREEN_UV + effective_time * vec2(10.0, 5.0)) + vec2(70.0, 80.0));
	float inflation_x_delta = noise(inflation_density * (SCREEN_UV + effective_time * vec2(10.0, 5.0) + delta_x) + vec2(90.0, 100.0));
	float inflation_y_delta = noise(inflation_density * (SCREEN_UV + effective_time * vec2(10.0, 5.0) + delta_y) + vec2(110.0, 120.0));
	float derivative_x = (inflation_origin - inflation_x_delta) / delta;
	float derivative_y = (inflation_origin - inflation_y_delta) / delta;

	vec4 inflated_color = texture(TEXTURE, SCREEN_UV + vec2(derivative_x, derivative_y) * inflation_strength);

	// FUNNY COLOR BUISNESS
	vec3 m_1 = scramble(noise(SCREEN_UV + effective_time * vec2(1.0, 0.5)), noise(SCREEN_UV + effective_time * vec2(0.8, 0.3) + vec2(10.0, 20.0)));
	vec3 m_2 = scramble(noise(SCREEN_UV + effective_time * vec2(1.0, 0.5) + vec2(30.0, 40.0)), noise(SCREEN_UV + effective_time * vec2(0.8, 0.3) + vec2(10.0, 20.0)));
	vec3 m_3 = scramble(noise(SCREEN_UV + effective_time * vec2(1.0, 0.5) + vec2(30.0, 40.0)), noise(SCREEN_UV + effective_time * vec2(0.8, 0.3) + vec2(50.0, 60.0)));
	vec3 shifted_color = mat3(m_1, m_2, m_3) * inflated_color.xyz;

	vec3 hwb_shift = rgb2hwb(shifted_color);

	hwb_shift.x += 0.6*acidity;
	hwb_shift.y = clamp(hwb_shift.y * (1.0 - acidity*0.5), 0.0, 1.0);
	hwb_shift.z = clamp(hwb_shift.z * (1.0 - acidity*0.5), 0.0, 1.0);

	shifted_color = hwb2rgb(hwb_shift);

	vec3 unburnt_color = mix(COLOR.xyz, shifted_color, acidity_colors);

	// BURN
#define burn_density 3.0
#define burn_speed 10.0

#define hue_density 5.0
#define hue_speed 4.0
	float hue = noise(hue_density * (SCREEN_UV + effective_time * vec2(hue_speed)) + vec2(170.0, 180.0));
	hue += noise(hue_density * (SCREEN_UV + effective_time * vec2(-hue_speed)) + vec2(190.0, 200.0));

	float burn_value = noise(burn_density * (SCREEN_UV + effective_time * vec2(burn_speed)) + vec2(130.0, 140.0));
	burn_value *= noise(burn_density * (SCREEN_UV + effective_time * vec2(-burn_speed)) + vec2(150.0, 160.0));
	burn_value = clamp(burn_value - acidity_burn, 0.0, 1.0);
	burn_value /= acidity_burn;

	//float burned = 1.0 - pow(min(cos(PI * burn_value / 2.0 ), 1.0 - abs(burn_value)), 4.0);
	float burned = min(burn_value * burn_value * 9.0, 1.0);
	float burning = min(pow((burn_value * 1.7), 5), 1.0);

	// hwb to rgb in reference to Alvy Ray Smith & Eric Ray Lyons 1996 "HWB—A More Intuitive Hue-Based Color Model"
	hue *= 3.2;
	vec3 burning_color;
	float whiteness = 0.0;
	float blackness = burning - burned;
	float v, n, f; // The paper authors didn't care to say what thease actually mean so I guess, these are just "magic" value xP
	int i;

	v = 1.0 - blackness;
	i = int(floor(hue));
	f = fract(hue);
	if ((i & 1) == 1)
		f = 1.0 - f;
	n = whiteness + f * (v - whiteness);
	switch (i) {
		case 6:
		case 0:
			burning_color = vec3(v, n, whiteness);
		break;
		case 1:
			burning_color = vec3(n, v, whiteness);
		break;
		case 2:
			burning_color = vec3(whiteness, v, n);
		break;
		case 3:
			burning_color = vec3(whiteness, n, v);
		break;
		case 4:
			burning_color = vec3(n, whiteness, v);
		break;
		case 5:
			burning_color = vec3(v, whiteness, n);
		break;
	}

	vec3 burned_color = mix(unburnt_color, burning_color, burned);
	
	vec3 hwb_burn = rgb2hwb(burned_color);

	hwb_burn.x += 0.4*acidity;
	hwb_burn.y = clamp(hwb_burn.y * (1.0 - acidity*0.5), 0.0, 1.0);
	hwb_burn.z = clamp(hwb_burn.z * (1.0 - acidity*0.5), 0.0, 1.0);

	burned_color = hwb2rgb(hwb_burn);

	COLOR.xyz = burned_color;

	//float a = COLOR.x + COLOR.y + COLOR.z;
	//COLOR.xyz = (COLOR.xyz / a) * mat3(scramble(1.0, 0.0), scramble(0.0, 0.0), scramble(0.0, 1.0)) * a;
}