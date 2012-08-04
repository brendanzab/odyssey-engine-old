module odyssey.util.glfw3;

import odyssey.util.prettyout;
import std.stdio, std.conv, std.string;

public import derelict.glfw3.glfw3;

class GLFWException : Exception {
    this(string message1 = "", string message2 = "") {
        super(errorString(message1) ~ message2);
    }
}

void writeGLFWInfo() {
    if (!DerelictGLFW3.isLoaded()) {
        writefln(errorString("DerelictSDL2 is not loaded!"));
        return;
    }
    
    // Get desktop video mode
    GLFWvidmode dtmode;
    glfwGetDesktopMode(&dtmode);
    
    // Get all available video modes
    int MAX_NUM_MODES = 400;
    GLFWvidmode* modes;
    int modecount = glfwGetVideoModes(modes, MAX_NUM_MODES);
    
    // Print GLFW info
    writefln(headingString("GLFW"));
    writefln("Version:  %s", to!string(glfwGetVersionString()));
    writefln("Desktop mode: %s", dtmode.toString());
    writefln("Available modes: %d", modecount);
    foreach (int i; 0..modecount) {
        writefln(" %3d - %s", i, modes[i].toString());
    }
    writeln();
}

void writeGLFWErrors()() {
    int errorID = glfwGetError();
    while (errorID != GLFW_NO_ERROR) {
        writeln(errorString("GLFW Error: "), to!string(glfwErrorString(errorID)));
        errorID = glfwGetError();
    }
}

string toString(GLFWvidmode mode) {
    return format(
        "%d x %d, %d bits",
        mode.width, mode.height,
        mode.redBits + mode.greenBits + mode.blueBits);
}
