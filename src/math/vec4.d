module odyssey.math.vec4;

import std.math : abs, min, max, sqrt;
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
    
    /// Returns the vector divided by a float: `this / f`
    Vec4 opBinary(string op : "/")(float f) {
        return Vec4(x/f, y/f, z/f, w/f);
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
    void opAssign(string op : "-")(Vec3 v) {
        x -= v.x;
        y -= v.y;
        z -= v.z;
        w -= v.w;
    }

    /// Multiply vector: `this *= f`
    void opAssign(string op : "*")(float f) {
        x *= f;
        y *= f;
        z *= f;
        w *= f;
    }

    /// Divide vector: `this /= f`
    void opAssign(string op : "/")(float f) {
        x /= f;
        y /= f;
        z /= f;
        w /= f;
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
    @property Vec4 normalized() {
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

Vec4 abs(Vec4 v) {
    return Vec4(abs(v.x), abs(v.y), abs(v.z), abs(v.w));
}

/// Returns the minimum coordinates in one vector
Vec4 min(Vec4 a, Vec4 b) {
    return Vec4(min(a.x, b.x),
                min(a.y, b.y),
                min(a.z, b.z),
                min(a.w, b.w));
}

/// Returns the minimum coordinates in one vector
Vec4 max(Vec4 a, Vec4 b) {
    return Vec4(max(a.x, b.x),
                max(a.y, b.y),
                max(a.z, b.z),
                max(a.w, b.w));
}

