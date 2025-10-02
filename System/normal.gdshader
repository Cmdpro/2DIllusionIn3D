shader_type spatial;

render_mode unshaded, depth_draw_never, depth_test_disabled;

uniform sampler2D screen_texture : filter_nearest;
uniform sampler2D normal_texture : hint_normal_roughness_texture, filter_nearest;
uniform float edge_threshold = 0.2;

void vertex() {
	// Called for every vertex the material is visible on.
}
void fragment(){
    vec2 uv = SCREEN_UV;
    vec3 center_normal = texture(normal_texture, uv).rgb;

    vec2 pixel_size = vec2(1.0) / VIEWPORT_SIZE;
    vec3 n_left = texture(normal_texture, uv + vec2(-pixel_size.x, 0.0)).rgb;
    vec3 n_right = texture(normal_texture, uv + vec2(pixel_size.x, 0.0)).rgb;
    vec3 n_up = texture(normal_texture, uv + vec2(0.0, pixel_size.y)).rgb;
    vec3 n_down = texture(normal_texture, uv + vec2(0.0, -pixel_size.y)).rgb;

    float normal_diff_x = length(n_right - n_left);
    float normal_diff_y = length(n_up - n_down);
    float normal_gradient = sqrt(normal_diff_x * normal_diff_x + normal_diff_y * normal_diff_y);

    vec4 original_color = texture(screen_texture, uv);

    if (normal_gradient > edge_threshold) {
        ALBEDO = vec3(1.0, 1.0, 1.0);
    } else {
        ALBEDO = vec3(0.0, 0.0, 0.0);
    }
}