shader_type canvas_item;

// Función de ruido basada en gradientes
float gradNoise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f); // Suavizado de la interpolación
    float n00 = dot(i, vec2(12.9898, 78.233)); // gradiente de cada punto
    float n10 = dot(i + vec2(1.0, 0.0), vec2(12.9898, 78.233));
    float n01 = dot(i + vec2(0.0, 1.0), vec2(12.9898, 78.233));
    float n11 = dot(i + vec2(1.0, 1.0), vec2(12.9898, 78.233));
    
    float n0 = mix(n00, n10, f.x); // Interpolación en x
    float n1 = mix(n01, n11, f.x); // Interpolación en x
    return mix(n0, n1, f.y); // Interpolación en y
}

// Función de Fractal Brownian Motion (FBM)
float fbm(vec2 p) {
    float total = 0.0;
    float amplitude = 1.0;
    float frequency = 1.0;
    
    // Reducir el número de octavas para un efecto más suave
    for (int i = 0; i < 4; i++) {
        total += gradNoise(p * frequency) * amplitude;
        frequency *= 0.5; // Aumentar la frecuencia
        amplitude *= 0.5; // Reducir la amplitud
    }
    
    return total;
}

void fragment() {
    // Configurar el vector 'p' para un efecto horizontal
    vec2 p = vec2(UV.x * 10.0, UV.y * 2.0);
    
    // Crear desplazamiento animado en el eje y para mover el humo verticalmente
    float timeOffsetY = TIME * 0.3; // Controla la velocidad del movimiento vertical
    float noiseOffset = fbm(p + vec2(0.0, timeOffsetY)); 

    // Añadir un efecto de parpadeo para dar realismo al humo
    float flicker = sin(TIME * 0.5) * 0.1;
    float r = fbm(p + vec2(noiseOffset, flicker)); 

    // Ajustar la intensidad para un gris claro
    r *= 0.0; // Escala de la intensidad ajustada
    r += 0.2; // Valor base para un gris claro

    // Asignar un color gris claro con transparencia controlada por UV.x para un efecto horizontal
    COLOR = vec4(r, r, r, smoothstep(0.0, 0.8, UV.x)); // Ajuste de transparencia horizontal
}
