shader_type canvas_item;

uniform float shadopacity : hint_range(0,1,0.05) = 0.2f;
uniform float shinopacity : hint_range(0,1,0.05) = 0.05f;

// save the Modulated color
varying vec4 modulation;
void vertex() {
	modulation = COLOR;
}

void fragment() {
	// get texture at this pixel and the one above
	vec4 thisColor = modulation * texture(TEXTURE, UV);
	float colorAbove = texture(TEXTURE, UV+vec2(0,-1)*TEXTURE_PIXEL_SIZE).a;
	// drop shadow
	if (thisColor.a < colorAbove-0.5) {
		thisColor = vec4(0, 0, 0, shadopacity);
	}
	// shine
	if (thisColor.a > colorAbove) {
		thisColor += vec4(1,1,1,1)*shinopacity;
	}
	COLOR = thisColor;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
