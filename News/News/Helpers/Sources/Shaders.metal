//
//  Shaders.metal
//  News
//
//  Created by Yaroslav Kupriyanov on 14.02.2025.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 complexWave(float2 position, float time, float2 size, float speed, float strength, float frequency) {
	float2 normalizedPosition = position / size;
	float moveAmount = time * speed;

	position.x += sin((normalizedPosition.x + moveAmount) * frequency) * strength;
	position.y += cos((normalizedPosition.y + moveAmount) * frequency) * strength;

	return position;
}

[[ stitchable ]] float2 wave(float2 position, float time) {
	return position + float2 (sin(time + position.y / 20), sin(time + position.x / 20)) * 5;
}

[[ stitchable ]] half4 noise(float2 position, half4 currentColor, float time) {
	float value = fract(sin(dot(position + time, float2(12.9898, 78.233))) * 43758.5453);
	return half4(value, value, value, 1) * currentColor.a;
}
