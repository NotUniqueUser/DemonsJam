shader_type canvas_item;

uniform vec4 color : hint_color; 

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR = mix(mix(COLOR, color, 0.5), vec4(TIME / 3600.0, TIME / 3600.0, TIME / 3600.0, 1.0), 0.5);
}