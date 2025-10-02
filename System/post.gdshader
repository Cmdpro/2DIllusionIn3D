shader_type canvas_item;

uniform sampler2D shaded_texture : filter_nearest;
uniform sampler2D unshaded_texture : filter_nearest;
uniform sampler2D normal_texture : filter_nearest;
uniform sampler2D depth_texture : filter_nearest;

uniform float camera_size;
uniform float outline_size;

vec4 edge(vec2 uv, vec2 pixelSize, sampler2D normal) {
	vec2 offsets[5] = {
		uv+vec2(0, pixelSize.y),
		uv+vec2(-pixelSize.x, 0), uv, uv+vec2(pixelSize.x, 0),
		uv+vec2(0, -pixelSize.y)
	};
	vec3 outlineColor = vec3(0.0, 0.0, 0.0);
	float outlineColorDepth = -1.0;
    for (int i = 0; i < 5; i++) {
        float intensity;
        float intensityN;
        vec2 coord = offsets[i];
        coord.x = clamp(coord.x, 0, 1);
        coord.y = clamp(coord.y, 0, 1);
        vec3 sampleVar = texture(unshaded_texture, coord).rgb;
		float depth = texture(depth_texture, coord).r;
		if (outlineColorDepth <= 0.0 || depth < outlineColorDepth) {
			outlineColor = sampleVar/3.0;
			outlineColorDepth = depth;
		}
    }
    float Gx = length(texture(unshaded_texture, offsets[3]) - texture(unshaded_texture, offsets[1]));
    float Gy = length(texture(unshaded_texture, offsets[0]) - texture(unshaded_texture, offsets[4]));
    float G = sqrt(Gx * Gx + Gy * Gy);
    float edgeThreshold = 0.2;
    float alpha = G > edgeThreshold ? 1.0 : 0.0;
    return vec4(outlineColor, alpha);
}


void fragment() {
	vec2 pixelSize = SCREEN_PIXEL_SIZE*(outline_size/camera_size);
	vec2 uv = UV;
	COLOR = texture(shaded_texture, uv);
	vec4 edgeColor = edge(uv, pixelSize, normal_texture);
	float nOutline = texture(normal_texture, uv).r;
	COLOR = vec4(mix(COLOR.rgb, edgeColor.rgb, max(edgeColor.a, nOutline)), 1.0);
}
