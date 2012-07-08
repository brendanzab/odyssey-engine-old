module odyssey.math.vec4;

import std.math;
import std.string;

struct Vec4 {

    union {
        struct { float i, j, k, l; }
        struct { float x, y, z, w; }
        struct { float r, g, b, a; }
        float[4] v;
    }

    /* Operations */

    /// Returns the negated vector: `-this`
    Vec4 opUnary(string op : "-")() {
        return Vec4(-x, -y, -z, -w);
    }

    /// Returns the sum of the vectors: `this + v`
    Vec4 opBinary(string op : "+")(Vec4 v) {
        return Vec4(x + v.x,
                    y + v.y,
                    z + v.z,
                    w + v.w);
    }

    /// Returns the difference between the vectors: `this - v`
    Vec4 opBinary(string op : "-")(Vec4 v) {
        return Vec4(x - v.x,
                    y - v.y,
                    z - v.z,
                    w - v.w);
    }
    
    /// Returns the vector multiplied by a float: `this * f`
    Vec4 opBinary(string op : "*")(float f) {
        return Vec4(x*f, y*f, z*f, w*f);
    }

    /// Returns the dot product: `this * v `
    float opBinary(string op : "*")(Vec4 v) {
        return (x * v.x) + (y * v.y) + (z * v.z) + (w * v.w);
    }

    /* Assignment Operations */
    
    /// Set each component of the vector to the given float
    void opAssign()(float f) {
        x = y = z = w =f;
    }

    /// Add to vector: `this += v`
    void opAssign(string op : "+")(Vec3 v) {
        x += v.x;
        y += v.y;
        z += v.z;
        w += v.w;
    }

    /// Subtract from vector: `this -= v`
    void opAssign(string op : "*")(Vec3 v) {
        x -= v.x;
        y -= v.y;
        z -= v.z;
        w -= v.w;
    }

    /// Divide vector: `this /= f`
    void opAssign(string op : "/")(float f) {
        f = 1/f;
        x *= f;
        y *= f;
        z *= f;
        w *= f;
    }

    /* Other Methods */
    
    @property float magnitude() {
        return sqrt(x*x + y*y + z*z + w*w);
    }
    
    /// Set the magnitude whilst preserving the direction
    @property void magnitude(float m) {
        float n = (1 / magnitude) * m;
        x *= n;
        y *= n;
        z *= n;
        w *= n;
    }

    /// Returns the normalized vector
    Vec4 normalize() {
        float n = 1 / magnitude;
        return this * n;
    }

    void normalizeSelf() {
        float n = 1 / magnitude;
        x *= n;
        y *= n;
        z *= n;
        w *= n;
    }
    
}