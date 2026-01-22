shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 thisColor = texture(TEXTURE, UV);
	float colorAbove = texture(TEXTURE, UV+vec2(0,-1)*TEXTURE_PIXEL_SIZE).a;
	if (thisColor.a < colorAbove) {
		thisColor = vec4(0, 0, 0, 0.2);
	}
	COLOR = thisColor;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
