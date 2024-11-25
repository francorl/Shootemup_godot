shader_type canvas_item;

// Desplazamiento horizontal con un control de velocidad
uniform float speed = 0.1;

void fragment() { 
    // Ajustamos la coordenada UV para desplazarla horizontalmente usando TIME y la velocidad
    vec2 offset_uv = vec2(UV.x + TIME * speed, UV.y);
    
    // Aplicamos el desplazamiento en la textura
    COLOR = texture(TEXTURE, offset_uv);
}
