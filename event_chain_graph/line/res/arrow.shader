shader_type canvas_item;
render_mode blend_mix;
uniform vec4 color:hint_color;

void fragment()
{   
    COLOR = texture(TEXTURE, UV);
    COLOR = vec4(color.rgb, COLOR.a);
}