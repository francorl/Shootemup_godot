shader_type canvas_item;

// Función de ruido más eficiente (basada en gradientes)
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

    // Agregar menos octavas de ruido para un efecto más sutil
    for (int i = 0; i < 4; i++) { // Cambiado de 6 a 4
        total += gradNoise(p * frequency) * amplitude;
        frequency *= 0.1; // Aumentar la frecuencia
        amplitude *= 0.5; // Reducir la amplitud
    }

    return total;
}

void fragment() {
    vec2 p = vec2(UV.x * 5.0, -UV.y * 5.0);

    // Agregar desplazamiento animado tanto en x como en y
    float timeOffsetX = TIME * 0.1; // Velocidad del movimiento horizontal
    float timeOffsetY = TIME * 0.1; // Velocidad del movimiento vertical
    float noiseOffset = fbm(p + vec2(timeOffsetX, timeOffsetY));

    // Añadir un efecto de parpadeo u ondulación
    float flicker = sin(TIME * 0.5) * 0.1; // Ajusta la frecuencia y la intensidad
    float r = fbm(p + vec2(noiseOffset, flicker));

    // Aumentar la intensidad para un gris más claro
    r *= 0.0; // Escala de la intensidad ajustada para ser más brillante
    r += 0.2; // Aumenta el valor base para un gris claro

    // Asignar un color gris claro con transparencia controlada por UV.y
    COLOR = vec4(r, r, r, smoothstep(0.2, 1.0, UV.y)); // Ajuste de transparencia
}
