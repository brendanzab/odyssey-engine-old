module test.main;

import odyssey.core.application;
import odyssey.geom.vertexarray;
import odyssey.render.shader;
import odyssey.math.mat4;
import odyssey.math.vec3;
import odyssey.math.vec4;
import odyssey.util.gldebug;

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
        Vec3( 0.75,  0.75,  0.0 ),
        Vec3( 0.75, -0.75,  0.0 ),
        Vec3(-0.75, -0.75,  0.0 )
    ];
    
    Mat4 projectionMatrix;  // normally constant (stores the perspective)
    Mat4 viewMatrix;        // 
    Mat4 modelMatrix;
    
    // The handle for the shader program
    ShaderProgram shader;
    VertexArray triangle;
    
    void onInit() {
        
        float fov = 60.0;
        int windowWidth = 640;
        int windowHeight = 480;
        float near = 0.1;
        float far = 100;
        
        // WARNING: these functions haven't been implemented yet!
        projectionMatrix = perspective(fov, windowWidth / windowHeight, near, far);
        viewMatrix       = translate(Mat4(1), Vec4(0, 0, -5));   // translate view back 5 units
        modelMatrix      = scale(Mat4(1), Vec4(0.5));            // halve the size of the model
        
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
