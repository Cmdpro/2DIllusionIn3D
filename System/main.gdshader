shader_type spatial;

uniform vec3 mainColor : source_color = vec3(1.0, 1.0, 1.0);
uniform sampler2D image : filter_nearest;
uniform bool specular = false;
uniform bool shade = true;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment(){
	vec4 tex = texture(image, UV);
	ALBEDO = tex.rgb*mainColor;
}

void light(){
	if (shade) {
		float nDotL = clamp(dot(NORMAL, LIGHT), 0.0, 1.0);
		nDotL = smoothstep(0.2, 0.2, nDotL);
		vec3 result = mix(vec3(nDotL), ALBEDO, 0.25);
		DIFFUSE_LIGHT += result;
	} else {
		DIFFUSE_LIGHT = vec3(1.0);
	}

	if (specular) {
		float vDotL = clamp(dot(NORMAL, LIGHT), 0.0, 1.0);
		vDotL = pow(vDotL, 80);
		vDotL = smoothstep(0.06, 0.06, vDotL);
		SPECULAR_LIGHT += vDotL*0.2;
	}
}