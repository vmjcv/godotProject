shader_type canvas_item;
render_mode blend_mix;
uniform sampler2D gradient;
varying vec2 clamped_UV;
void vertex()
{
    if (UV.x > 1.0 || UV.y > 1.0) {
        clamped_UV = vec2(1.0, 1.0);
    } else {
        clamped_UV = UV;
    }
}
void fragment()
{   
    COLOR = texture(TEXTURE, UV);
    vec4 gradient_color=texture(gradient, clamped_UV);
    COLOR = vec4(gradient_color.rgb, COLOR.a);
}