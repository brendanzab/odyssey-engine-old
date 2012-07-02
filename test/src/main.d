module test.main;

import odyssey.core.application;
import odyssey.core.drawable;
import odyssey.math.vec3;
import odyssey.render.shader;

import std.stdio, std.string;
import derelict.glfw3.glfw3;
import derelict.opengl3.gl3;

void main() {
    auto game = new Game();
    game.run();
}

class Game : Application {
    
    // 4D positions of the verticies
    Vec3 vertices[] = [
        { 0.75,  0.75,  0.0 },
        { 0.75, -0.75,  0.0 },
        {-0.75, -0.75,  0.0 }
    ];
    
    // The handle for the shader program
    Shader shader;
    Drawable triangle;
    
    void onInit() {
        shader = new Shader("resources/shader.vert", "resources/shader.frag");
        triangle = new Drawable(vertices, shader);
    }
    
    void onRender() {
        // Clear the window
        glClear(GL_COLOR_BUFFER_BIT);
        
        triangle.render();
        
    }
    
}