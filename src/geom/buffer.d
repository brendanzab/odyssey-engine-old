module odyssey.geom.buffer;


import odyssey.util.gldebug;
import std.stdio;
import derelict.opengl3.gl3;

class Buffer {
    GLuint buffer;
    alias buffer this;
    
    GLenum hint;
    GLenum drawMode;
    size_t length = 0;
    
    this(void[] data, GLenum drawMode = GL_TRIANGLES, GLenum hint = GL_STATIC_DRAW) {
        glGenBuffers(1, &buffer);
        setData(data, hint);
    }
    
    ~this() {
        writeln("Removing buffer");
        remove();
    }
    
    void remove() {
        glDeleteBuffers(1, &buffer);
    }
    
    void bind() {
        glBindBuffer(GL_ARRAY_BUFFER, buffer);
    }
    
    void unbind() {
        glBindBuffer(GL_ARRAY_BUFFER, 0);
    }
    
    /// Automatically binds/unbinds buffer between supplied statements
    void use(void delegate() statements) {
        bind();
        /////////////
        statements();
        /////////////
        unbind();
    }
    
    void draw() {
        use({
            glDrawArrays(drawMode, 0, 3);
        });
    }
    
    void addAttribute(GLuint location, GLenum type, GLint size=4, GLsizei offset = 0,
                      GLsizei stride = 0, GLboolean normalized=GL_FALSE) {
        use({
            glVertexAttribPointer(location, size, type, normalized, stride, cast(GLvoid*)offset);
            writeGLError();
            glEnableVertexAttribArray(location);
        });
    }
    
    void setData(void[] data, GLenum hint = GL_STATIC_DRAW) {
        this.length = data.length;
        this.hint   = hint;
        
        use({
            glBufferData(GL_ARRAY_BUFFER, length, data.ptr, hint);
        });
        
    }
    
    void update(void[] data, GLintptr offset) {
        use({
            glBufferSubData(GL_ARRAY_BUFFER, offset, data.length, data.ptr);
        });
    }
}