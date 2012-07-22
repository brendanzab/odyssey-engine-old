module odyssey.geom.vertexarray;

import odyssey.util.gl;
import odyssey.geom.buffer;
import odyssey.math.vec3;
import odyssey.render.shader;


interface Bindable {
    void bind();
    void unbind();
    void use(void delegate() statements);
}

class VertexArray {
    
    GLuint vertexArray;
    alias vertexArray this;
    
    Vec3[] positions;
    Buffer buffer;
    ShaderProgram shader;
    
    this(Vec3[] positions, ref ShaderProgram shader) {
        this.positions = positions;
        this.shader = shader;
        
        init();
    }
    
    void init() {
        // Create the vertex array object
        glGenVertexArrays(1, &vertexArray);
        this.use({
            // Create the buffer object and bind the vertex data
            buffer = new Buffer(positions);
            buffer.addAttribute(glGetAttribLocation(shader, "in_Position"), GL_FLOAT, 3);
        });
    }
    
    void bind() {
        glBindVertexArray(vertexArray);
    }
    
    void unbind() {
        glBindVertexArray(0);
    }
    
    /// Automatically binds/unbinds vertex array between supplied statements
    void use(void delegate() statements) {
        bind();
        /////////////
        statements();
        /////////////
        unbind();
    }
    
    void addAttribute(GLuint location, GLenum type, GLint size=4, GLsizei offset = 0,
                      GLsizei stride = 0, GLboolean normalized=GL_FALSE) {
        use({
            glVertexAttribPointer(location, size, type, normalized, stride, cast(const(GLvoid*))offset);
            glEnableVertexAttribArray(location);
            writeGLError();
        });
    }
    
    void draw() {
        shader.use({
            this.use({
                glDrawArrays(GL_TRIANGLES, 0, 3);
            });
        });
    }
    
    ~this() {
        glBindVertexArray(0);
        glDeleteVertexArrays(1, &vertexArray);
    }
}