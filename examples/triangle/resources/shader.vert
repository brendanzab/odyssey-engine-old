#version 150

in vec3 in_Position;
in vec3 in_Normal;

void main() {
    gl_Position = vec4(in_Position, 1);
    vec3 test = in_Normal;
}