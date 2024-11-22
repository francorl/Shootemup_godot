shader_type canvas_item;

uniform vec2 character_position;
uniform vec2 map_size;
uniform float fade_distance;
uniform float max_darkness;

void fragment() {
    // Calcula las distancias a los bordes
    float left_dist = character_position.x;
    float right_dist = map_size.x - character_position.x;
    float top_dist = character_position.y;
    float bottom_dist = map_size.y - character_position.y;
    
    // Encuentra la distancia más cercana a cualquier borde
    float min_distance = min(min(left_dist, right_dist), min(top_dist, bottom_dist));
    
    // Calcula la intensidad del oscurecimiento
    float darkness = smoothstep(fade_distance, 0.0, min_distance) * max_darkness;
    
    // Aplica el efecto de oscuridad con una transición suave
    COLOR = vec4(0.0, 0.0, 0.0, darkness);
}