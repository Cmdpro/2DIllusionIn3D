shader_type spatial;

render_mode unshaded, depth_draw_never, depth_test_disabled;

uniform sampler2D depth_texture : hint_depth_texture, filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}
void fragment(){
    vec2 uv = SCREEN_UV;
	
	float depth = texture(depth_texture, uv).r;
	vec3 ndc = vec3(SCREEN_UV, depth) * 2.0 - 1.0;
    vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
    view.xyz /= view.w;
    float linear_depth = -view.z;
	
	ALBEDO = vec3(linear_depth/4000.0, 0.0, 0.0);
}