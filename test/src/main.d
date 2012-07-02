module test.main;

import odyssey.core.application;
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
    const float vertexPositions[] = [
        0.75,  0.75,  0.0,  1.0,
        0.75, -0.75,  0.0,  1.0,
       -0.75, -0.75,  0.0,  1.0
    ];
    
    // The handle for the vertex buffer objects
    GLuint vao;
    
    // The handle for the shader program
    Shader shader;
    
    void onInit() {
        shader = new Shader("resources/shader.vert", "resources/shader.frag");
        
        glGenVertexArrays(1, &vao);
        glBindVertexArray(vao);
        
        // Create the buffer object and bind the vertex data
        GLuint positionBufferObject;
        glGenBuffers(1, &positionBufferObject);
        glBindBuffer(GL_ARRAY_BUFFER, positionBufferObject);
        glBufferData(GL_ARRAY_BUFFER, vertexPositions.length * float.sizeof, vertexPositions.ptr, GL_STATIC_DRAW);
        
        // Set attribute-pointers to enable communication with the shader
        GLint positionlocation = glGetAttribLocation(shader.programID, "in_Position");
        glVertexAttribPointer(
            positionlocation,   // shader attribute
            4,                  // size
            GL_FLOAT,           // type
            GL_FALSE,           // normalized?
            0,                  // stride
            null                // array buffer offset
        );
        glEnableVertexAttribArray(positionlocation);
        
        // Cleanup
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindVertexArray(0);
        
    }
    
    void onRender() {
        // Clear the window
        glClear(GL_COLOR_BUFFER_BIT);
        
        // Activate the shader program
        shader.bind();
        
        // Draw the Vertex Array Object
        glBindVertexArray(vao);
        glDrawArrays(GL_TRIANGLES, 0, 3);   // Start at the 0th index and draw 3 verticies
        glBindVertexArray(0);
        
        // Disable the program
        shader.unbind();
    }
    
    void onCleanup() {
        writefln("Cleaning up OpenGL");
        glBindVertexArray(0);
        glDeleteVertexArrays(1, &vao);
    }
    
}