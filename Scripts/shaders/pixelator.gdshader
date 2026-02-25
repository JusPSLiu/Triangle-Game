shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;

uniform vec2 offset = vec2(0.0, 0.0);
uniform int pixel_size : hint_range(1, 64) = 4; // Pixel size
uniform vec2 screen_size = vec2(960, 540);
uniform bool FLOOR_IT = false;

void fragment() {
	//Pixel coordinates in screen space
	vec2 pixelated;
	if (FLOOR_IT) {
		pixelated = floor((FRAGCOORD.xy+offset) / float(pixel_size)) * float(pixel_size) - offset;
	} else {
		pixelated = round((FRAGCOORD.xy+offset) / float(pixel_size)) * float(pixel_size) - offset;
	}
    // Convert pixel coordinates to UVs for screen texture
    vec2 uv = pixelated / screen_size;
    // Get color from texture screen
    COLOR = texture(SCREEN_TEXTURE, uv);
}