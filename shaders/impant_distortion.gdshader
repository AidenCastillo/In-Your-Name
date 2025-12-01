
shader_type canvas_item;

uniform float noise_strength = 0.02;
uniform float glitch_strength = 0.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    vec2 uv = SCREEN_UV;

    // Horizontal glitch lines
    if (glitch_strength > 0.0) {
        float offset = (fract(uv.y * 100.0 + TIME * 3.0) < 0.02) ? glitch_strength : 0.0;
        uv.x += offset;
    }

    COLOR = texture(SCREEN_TEXTURE, uv);

    // Add noise
    COLOR.rgb += (random(uv + TIME) - 0.5) * noise_strength;
}

float rand(vec2 p){
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}
