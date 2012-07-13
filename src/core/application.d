module odyssey.core.application;

import odyssey.util.gldebug;
import odyssey.util.glfwdebug;
import odyssey.util.prettyout;

import std.conv, std.stdio, std.string;
import derelict.glfw3.glfw3;
import derelict.opengl3.gl3;


abstract class Application {
    
private:

    string name = "Application";
    int width = 640;
    int height = 480;

    bool running = false;
    
    GLFWwindow window;
    
    
public:
    
    void onInit() {}
    void onUpdate(float tpf) {}
    void onRender() {}
    void onCleanup() {}


/* Internal functions */

public final:

    this() {
        
    }
    
    void run() {
        init();
        
        running = true;
        
        Timer timer;
        timer.init();
        
        while (glfwIsWindow(window) && running) {
            // Poll events
            glfwPollEvents();
            
            update(timer.update());
            render();
            
            writeGLError();
        }
        
        cleanup();
    }
 
 
 private final:
    
    void init() {
        initGLFW();
        initOpenGL();
        
        onInit();
    }

    void initGLFW(){
        
        // Initialise GLFW
        DerelictGLFW3.load();
        if(!glfwInit()) {
            writeGLFWErrors();
            throw new Exception(errorString("Failed to create glcontext"));
        }
        
        // Log hardware and version info
        writeGLFWInfo();
        
        // Specify the profile that GLFW will load
        glfwOpenWindowHint(GLFW_OPENGL_VERSION_MAJOR, 3);
        glfwOpenWindowHint(GLFW_OPENGL_VERSION_MINOR, 2);
        // OS X 10.7+ only supports the forward compatible core profile
        glfwOpenWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
        glfwOpenWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
        
        // Create a GLWF window and OpenGL context
        window = glfwOpenWindow(width, height, GLFW_WINDOWED, name.ptr, null);
        if(!window) {
            writeGLFWErrors();
            throw new Exception(errorString("Failed to create window"));
        }

        // Enable vertical sync (on cards that support it)
        glfwSwapInterval(1);
        
        //// Setup input handling
        //glfwSetInputMode(window, GLFW_STICKY_KEYS, GL_TRUE);
        //glfwSetKeyCallback(&keyCallback);
        
    }
    
    void initOpenGL() {
        // Load DerelictGL3
        DerelictGL3.load();     // Load OpenGL functions from Version 1.1
        DerelictGL3.reload();   // Load OpenGL functions from Version 1.2+
        
        // Log version and display info
        writeGLInfo();
        
        // Set the viewport dimensions
        glViewport(0, 0, width, height);
        
        // Clear color buffer to dark grey
        glClearColor(0.2, 0.2, 0.2, 1);
    }
    
    /// tpf - the time in seconds
    void update(float tpf) {
        
        // Do stuff
        
        onUpdate(tpf);
    }
    
    void render() {
        
        // Update the window
        glfwSwapBuffers();
        
        onRender();
        
    }
    
    void cleanup() {
        
        writefln("Terminating GLFW");
        glfwTerminate();
        
        onCleanup();
        
    }
}

struct Timer {
    
    private double time;
    private double delta;
    
    void init() {
        time = glfwGetTime();
    }
    
    /// update and return the delta time in seconds 
    double update() {
        double oldTime = time;
        time = glfwGetTime();
        delta = time - oldTime;
        
        return delta;
    }
    
}