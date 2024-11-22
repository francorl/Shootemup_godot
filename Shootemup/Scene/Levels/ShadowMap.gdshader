shader_type canvas_item;

uniform vec2 character_position; // La posición del personaje en coordenadas del mundo
uniform vec2 map_size; // El tamaño del mapa
uniform float fade_distance : hint_range(0.0, 500.0); // Distancia para empezar a oscurecer
uniform float max_darkness : hint_range(0.0, 1.0); // Oscuridad máxima
uniform float smoothness : hint_range(0.1, 2.0) = 1.0; // Control de suavidad de la transición

void fragment() {
    // Normaliza la posición del personaje al rango [0,1]
    vec2 normalized_pos = character_position / map_size;
    
    // Calcula la distancia a los bordes del mapa
    float left_dist = character_position.x;
    float right_dist = map_size.x - character_position.x;
    float top_dist = character_position.y;
    float bottom_dist = map_size.y - character_position.y;
    
    // La distancia mínima a cualquier borde
    float min_distance = min(min(left_dist, right_dist), min(top_dist, bottom_dist));
    
    // Aplica una función suave para la transición
    float normalized_distance = min_distance / fade_distance;
    float smooth_factor = pow(normalized_distance, smoothness);
    
    // Calcula el factor de oscuridad con una transición más suave
    float darkness = clamp(1.0 - smooth_factor, 0.0, max_darkness);
    
    // Aplica un gradiente radial centrado en el personaje
    vec2 screen_pos = UV * map_size;
    float dist_to_player = length(screen_pos - character_position);
    float radial_factor = smoothstep(0.0, fade_distance, dist_to_player);
    
    // Combina el efecto de bordes con el gradiente radial
    float final_darkness = darkness * mix(0.8, 1.0, radial_factor);
    
    // Aplica el efecto de oscuridad
    COLOR = vec4(vec3(0.0), final_darkness);
}