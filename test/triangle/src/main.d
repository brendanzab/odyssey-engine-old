module test.main;

import odyssey.core.application;
import odyssey.geom.vertexarray;
import odyssey.render.shader;
import odyssey.math.mat4;
import odyssey.math.vec3;
import odyssey.math.vec4;
import odyssey.util.gl;
import odyssey.util.glfw3;

import std.stdio, std.string;

void main() {
    auto game = new Game();
    game.run();
}

class Game : Application {
    
    // 4D positions of the verticies
    Vec3 vertices[] = [
        Vec3( 0.75,  0.75,  0.0 ),
        Vec3( 0.75, -0.75,  0.0 ),
        Vec3(-0.75, -0.75,  0.0 )
    ];
    
    // The handle for the shader program
    ShaderProgram shader;
    VertexArray triangle;
    
    void onInit() {
        
        shader = new ShaderProgram("resources/shader.vert", 
                                   "resources/shader.frag");
        triangle = new VertexArray(vertices, shader);
    }
    
    void onRender() {
        // Clear the window
        glClear(GL_COLOR_BUFFER_BIT);
        triangle.draw();
        
    }
    
    void onCleanup() {
        shader.unload();
    }
    
}
