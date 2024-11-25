shader_type canvas_item;

uniform vec2 character_pos;
uniform vec2 screen_size;
uniform float edge_threshold : hint_range(0.0, 1.0) = 0.2;
uniform float darkness_intensity : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    vec2 pixel_coords = SCREEN_UV * screen_size;

    float dist_to_edge = min(pixel_coords.x, screen_size.x - pixel_coords.x);
    dist_to_edge = min(dist_to_edge, pixel_coords.y);
    dist_to_edge = min(dist_to_edge, screen_size.y - pixel_coords.y);

    float edge_factor = smoothstep(edge_threshold * screen_size.x, 0.0, dist_to_edge);
    COLOR = vec4(vec3(0.0 - edge_factor * darkness_intensity), 1.0);
}
