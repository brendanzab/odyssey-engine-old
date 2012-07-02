module odyssey.math.vector;

import std.math;
import std.string;

// Constants
const {
    Vec3 v3_zero    = { 0, 0, 0 };
    Vec3 v3_unit_x  = { 1, 0, 0 };
    Vec3 v3_unit_y  = { 0, 1, 0 };
    Vec3 v3_unit_z  = { 0, 0, 0 };
}

/**
 *  A 3-dimensional vector
 */
struct Vec3 {

    float x, y, z;

    /* Operations */

    /// Returns the negated vector: `-this`
    Vec3 opUnary(string op : "-")() {
        return Vec3(-x, -y, -z);
    }

    /// Returns the sum of the vectors: `this + v`
    Vec3 opBinary(string op : "+")(Vec3 v) {
        return Vec3(x + v.x, y + v.y, z + v.z);
    }

    /// Returns the difference between the vectors: `this - v`
    Vec3 opBinary(string op : "-")(Vec3 v) {
        return Vec3(x - v.x, y - v.y, z - v.z);
    }
    
    /// Returns the vector multiplied by a float: `this * f`
    Vec3 opBinary(string op : "*")(float f) {
        return Vec3(x*f, y*f, z*f);
    }

    /// Returns the dot product: `this * v `
    float opBinary(string op : "*")(Vec3 v) {
        return (x * v.x) + (y * v.y) + (z * v.z);
    }
    
    /// Returns the vector divided by a float: `this * f`
    Vec3 opBinary(string op : "/")(float f) {
        f = 1/f;
        return Vec3(x*f, y*f, z*f);
    }
    
    /// Returns the vector divided by another vector `this / v`
    float opBinary(string op : "/")(Vec3 v) {
        f = 1/f;
        return Vec3(x * v.x, y * v.y, z * v.z);
    }

    Vec3 cross(Vec3 v) {
        return Vec3(
            y*v.z - z*v.y,
            z*v.x - x*v.z,
            x*v.y - y*v.x);
    }

    /* Assignment Operations */
    
    void opAssign()(float f) {
        x = y = z = f;
    }

    /// Add to vector: `this += v`
    void opAssign(string op : "+")(Vec3 v) {
        x += v.x;
        y += v.y;
        z += v.z;
    }

    /// Subtract from vector: `this -= v`
    void opAssign(string op : "*")(Vec3 v) {
        x -= v.x;
        y -= v.y;
        z -= v.z;
    }

    /// Multiply vector: `this *= f`
    void opAssign(string op : "*")(float f) {
        x *= f;
        y *= f;
        z *= f;
    }

    /// Divide vector: `this /= f`
    void opAssign(string op : "/")(float f) {
        f = 1/f;
        x *= f;
        y *= f;
        z *= f;
    }

    /// Divide from vector: `this /= v`
    void opAssign(string op : "/")(Vec3 v) {
        x /= v.x;
        y /= v.y;
        z /= v.z;
    }

    /* Other Methods */
    
    @property float magnitude() {
        return sqrt(x*x + y*y + z*z);
    }
    
    /// Scale the magnitude to the specified size
    @property void magnitude(float m) {
        float n = (1 / magnitude) * m;
        x *= n;
        y *= n;
        z *= n;
    }

    /// Returns the normalized vector
    Vec3 normalize() {
        float n = 1 / magnitude;
        return this * n;
    }

    void normalizeSelf() {
        float n = 1 / magnitude;
        x *= n;
        y *= n;
        z *= n;
    }
    
}

// Yeah, I have no idea how to write unittests. So I'm 
// just printing things out at the moment... :P
unittest {
    
    import std.stdio;
    
    Vec3 v1 = { 1, 2,  3 };
    Vec3 v2 = {-1, 2, -2 };
    float f = 3.4;
    
    assert(-v2     == Vec3(1, -2, 2));
    assert(v1 + v2 == Vec3(0, 4, 1));
    assert(v1 - v2 == Vec3(2, 0, 5));
    //assert(v1 * f  == Vec3(3.4, 6.8, 10.2));
    assert(v1 * v2 == -3);

    // Test vector operations
    writeln("Test Vec3 Operations:");
    writeln;
    writeln("let v1 = ", v1);
    writeln("let v2 = ", v2);
    writeln("let f  = ", f);
    writeln;
    writeln("-v1          = ",   -v1);
    writeln("v1 + v2      = ",   v1 + v2);
    writeln("v1 - v2      = ",   v1 - v2);
    writeln("v1 * f       = ",   v1 * f);
    writeln("v1 * v2      = ",   v1 * v2);
    writeln;
    writeln("v1.normalize = ",     v1.normalize);
    writeln("v1.magnitude = ",     v1.magnitude);
    writeln("v1.cross(v2) = ",     v1.cross(v2));
    writeln;
    
    v1.magnitude = 5;
    writeln("v1.magnitude = 5");
    writeln("v1 = ", v1);
    v1 = 0;
    writeln("v1 = 0");
    writeln("v1 = ", v1);
}