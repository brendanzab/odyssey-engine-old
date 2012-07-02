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

    /* Member Variables */

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

    /// Dot product: `this * v `
    float opBinary(string op : "*")(Vec3 v) {
        return (x * v.x) + (y * v.y) + (z * v.z);
    }

    Vec3 cross(Vec3 v) {
        return Vec3(
            y*v.z - z*v.y,
            z*v.x - x*v.z,
            x*v.y - y*v.x);
    }

    /* Assignment Operations */

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

    /* Other Methods */

    /// Returns the magnitude of the vector
    float magnitude() {
        return sqrt(x*x + y*y + z*z);
    }

    /// Returns the normalized vector
    Vec3 normalize() {
        float n = 1 / magnitude;
        return Vec3(x*n, y*n, z*n);
    }

    void normalizeSelf() {
        float n = 1 / magnitude;
        x *= n;
        y *= n;
        z *= n;
    }
    
}

string toString(Vec3 v) {
    return format("(", v.x, ", ", v.y, ", ",  v.z, ")");
}

unittest {
    
    Vec3 v1 = { 1, 2,  3 };
    Vec3 v2 = {-1, 2, -2 };
    float f = 3.4;

    // Test vector operations
    writeln("Test Vec3 Operations:");
    writeln;
    writeln("let v1 = ", v1.toString);
    writeln("let v2 = ", v2.toString);
    writeln("let f = ", f);
    writeln;
    writeln("\b-v1",        "\t\t= ",   -v1);
    writeln("v1 + v2",      "\t\t= ",   (v1 + v2).toString);
    writeln("v1 - v2",      "\t\t= ",   (v1 - v2).toString);
    writeln("v1 * f",       "\t\t= ",   v1 * f);
    writeln("v1 * v2",      "\t\t= ",   (v1 * v2).toString);
    writeln;
    writeln("v1.normalize", "\t= ",     v1.normalize);
    writeln("v1.magnitude", "\t= ",     v1.magnitude);
    writeln("v1.cross(v2)", "\t= ",     v1.cross(v2));
    
}