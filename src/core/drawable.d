module odyssey.core.drawable;

import odyssey.math.vector;
import odyssey.render.shader;

import derelict.opengl3.gl3;

class Drawable {
    
    GLuint vao;
    Vec3[] positions;
    Shader shader;
    
    this(Vec3[] positions, ref Shader shader) {
        this.positions = positions;
        this.shader = shader;
        
        init();
    }
    
    void init() {
        glGenVertexArrays(1, &vao);
        glBindVertexArray(vao);
        
        // Create the buffer object and bind the vertex data
        GLuint positionBufferObject;
        glGenBuffers(1, &positionBufferObject);
        glBindBuffer(GL_ARRAY_BUFFER, positionBufferObject);
        glBufferData(GL_ARRAY_BUFFER, positions.length * 3 * Vec3.sizeof, positions.ptr, GL_STATIC_DRAW);
        
        // Set attribute-pointers to enable communication with the shader
        GLint positionlocation = glGetAttribLocation(shader.programID, "in_Position");
        glVertexAttribPointer(
            positionlocation,   // shader attribute
            3,                  // size
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
    
    void render() {
        // Activate the shader program
        shader.bind();
        
        // Draw the Vertex Array Object
        glBindVertexArray(vao);
        glDrawArrays(GL_TRIANGLES, 0, 3);   // Start at the 0th index and draw 3 verticies
        glBindVertexArray(0);
        
        // Disable the program
        shader.unbind();
    }
    
    ~this() {
        glBindVertexArray(0);
        glDeleteVertexArrays(1, &vao);
    }
}