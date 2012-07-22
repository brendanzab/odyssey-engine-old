module odyssey.render.shader;

import odyssey.math.mat4;
import odyssey.util.prettyout;
import odyssey.util.gl3;
import odyssey.util.textfile;

import std.stdio, std.string;

class ShaderProgram {
    
    GLuint program;
    alias program this;
    
    this(string vsPath, string fsPath) {
        load(vsPath, fsPath);
    }
    
    void bind() {
        glUseProgram(program);
    }
    
    void unbind() {
        glUseProgram(0);
    }
    
    void use(void delegate() statements) {
        bind();
        /////////////
        statements();
        /////////////
        unbind();
    }
    
    void load(string vsPath, string fsPath) {
        // TODO: check if the program is loaded
        
        program = glCreateProgram();
        
        vertexShader = new Shader(vsPath);
        fragmentShader = new Shader(fsPath);
        
        program.glAttachShader(vertexShader);
        program.glAttachShader(fragmentShader);
        
        program.glBindAttribLocation(0, "in_Position");
        program.glBindFragDataLocation(0, "out_Color");
        
        program.glLinkProgram();
        writeLog();
    }
    
    void unload() {
        writeln("Unloading shader program");
        
        program.glDetachShader(vertexShader);
        program.glDetachShader(fragmentShader);
        
        vertexShader.unload();
        vertexShader.unload();
        
        program.glDeleteProgram();
    }
    
private:
    
    Shader vertexShader;
    Shader fragmentShader;
    
    void writeLog() {
        GLint succeeded;
        program.glGetProgramiv(GL_LINK_STATUS, &succeeded);
        
        if (!succeeded) {
            // Get log-length
            GLint len;
            program.glGetProgramiv(GL_INFO_LOG_LENGTH, &len);
            
            // Get info log and throw exception
            char[] log = new char[len];
            program.glGetProgramInfoLog(len, null, cast(char*)log);
            throw new Exception(format("%s %s", "Program Linker failure:".errorString, log));
        }
    }
    
}

class Shader {
    
    GLuint shader;
    alias shader this;
    
    TextFile shaderSource;
    
    this(string path) {
        shaderSource = TextFile(path);
        load(path);
    }
    
    void load(string path) {
        writefln("Creating %s from %s", shaderSource.typeString, path);
        
        shader = glCreateShader(shaderSource.shaderType);
        
        // Read the shader from the file
        const char* data = shaderSource.dataz;
        shader.glShaderSource(1, &data, null);
        
        shader.glCompileShader();
        writeLog();
    }
    
    void unload() {
        writefln("Deleting %s", shaderSource.typeString);
        shader.glDeleteShader();
    }
    
private:
    
    void writeLog() {
        // Throw an exception if the compilation fails
        GLint succeeded;
        shader.glGetShaderiv(GL_COMPILE_STATUS, &succeeded);
        
        // Print log if the compilation failed
        if (!succeeded) {
            // Get log-length
            GLint len;
            shader.glGetShaderiv(GL_INFO_LOG_LENGTH, &len);
            
            // Get info log and throw exception
            char[] log = new char[len];
            shader.glGetShaderInfoLog(len, null, cast(char*)log);
            throw new Exception(format("%s %s", "GLSL Compile failure:".errorString, log));
        }
    }
}

/// Returns the shader type based on the file extension
GLenum shaderType(ref TextFile file) {
    switch(file.extension) {
        case ".vert":
        case ".vs":
            return GL_VERTEX_SHADER;
        case ".frag":
        case ".fs":
            return GL_FRAGMENT_SHADER;
        case ".geom":
        case ".gs":
            return GL_GEOMETRY_SHADER;
        case "":
            throw new Exception("The shader file does not have an extension.");
        default:
            throw new Exception("'" ~ file.extension ~ "' not supported.");
    }
}

/// Returns the type of the shader file as a string
string typeString(ref TextFile file) {
    switch (file.shaderType) {
        case GL_VERTEX_SHADER:      return "vertex shader";
        case GL_FRAGMENT_SHADER:    return "fragment shader";
        case GL_GEOMETRY_SHADER:    return "geometry shader";
        default: throw new Exception("Invalid shader type");
    }
}