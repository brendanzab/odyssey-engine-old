module odessey.math.vector;

import std.math;
import std.string;

// Constants
const {
    Vec3 v3_zero        = Vec3(0, 0, 0);
    Vec3 v3_unit_x      = Vec3(1, 0, 0);
    Vec3 v3_unit_y      = Vec3(0, 1, 0);
    Vec3 v3_unit_z      = Vec3(0, 0, 1);
}

/**
 *  A 3-dimensional vector
 */
struct Vec3 {

    /* Member Variables */

    float x, y, z;

    this(float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    /* Operations */

    /// Returns the negated vector: `-this`
    Vec3 opNeg() {
        return Vec3(-x, -y, -z);
    }

    /// Returns the sum of the vectors: `this + v`
    Vec3 opAdd(Vec3 v) {
        return Vec3(x + v.x, y + v.y, z + v.z);
    }

    /// Returns the difference between the vectors: `this - v`
    Vec3 opSub(Vec3 v) {
        return Vec3(x - v.x, y - v.y, z - v.z);
    }
    
    /// Returns the vector multiplied by a float: `this * f`
    Vec3 opMul(float f) {
        return Vec3(x*f, y*f, z*f);
    }

    /// Dot product: `this * v `
    float opMul(Vec3 v) {
        return (x * v.x) + (y * v.y) + (z * v.z);
    }

    /* Assignment Operations */

    /// Add to vector: `this += v`
    void opAddAssign(Vec3 v) {
        x += v.x;
        y += v.y;
        z += v.z;
    }

    /// Subtract from vector: `this -= v`
    void opSubAssign(Vec3 v) {
        x -= v.x;
        y -= v.y;
        z -= v.z;
    }

    /// Multiply vector: `this *= f`
    void opMulAssign(float f) {
        x *= f;
        y *= f;
        z *= f;
    }

    /* Other Methods */

    /// Sets variables
    void set(float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

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

    Vec3 cross(Vec3 v) {
        return Vec3(
            y*v.z - z*v.y,
            z*v.x - x*v.z,
            x*v.y - y*v.x);
    }

    /* Debug */

    string toString() {
        return format("(", x, ", ", y, ", ",  z, ")");
    }
}

unittest {
    
    Vec3 v1 = Vec3(1, 2, 3);
    Vec3 v2 = Vec3(-1, 2, -2);
    float f = 3.4;

    // Test vector operations
    writeln("Test Vec3 Operations:");
    writeln;
    writeln("let v1 = ", v1.toString);
    writeln("let v2 = ", v2.toString);
    writeln("let f = ", f);
    writeln;
    writeln("opNeg:\t\t",   "\b-v1",        "\t\t= ",   -v1);
    writeln("opAdd:\t\t",   "v1 + v2",      "\t\t= ",   (v1 + v2).toString);
    writeln("opSub:\t\t",   "v1 - v2",      "\t\t= ",   (v1 - v2).toString);
    writeln("opMult:\t\t",  "v1 * f",       "\t\t= ",   v1 * f);
    writeln("opMult:\t\t",  "v1 * v2",      "\t\t= ",   v1 * v2);
    writeln;
    writeln("normalize:\t", "v1.normalize", "\t= ",     v1.normalize);
    writeln("magnitude:\t", "v1.magnitude", "\t= ",     v1.magnitude);
    writeln("cross:\t\t",   "v1.cross(v2)", "\t= ",     v1.cross(v2));
    
}