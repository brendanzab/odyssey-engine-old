module odyssey.math.vec4;

import std.math : fabs, fmin, fmax, sqrt;

// Constants
const {
    Vec4 VEC4_ZERO      = { 0, 0, 0, 0 };
    Vec4 VEC4_UNIT_X    = { 1, 0, 0, 0 };
    Vec4 VEC4_UNIT_Y    = { 0, 1, 0, 0 };
    Vec4 VEC4_UNIT_Z    = { 0, 0, 1, 0 };
    Vec4 VEC4_UNIT_W    = { 0, 0, 0, 1 };
    Vec4 VEC4_IDENTITY  = { 1, 1, 1, 1 };
}

struct Vec4 {

    union {
        struct { float i, j, k, l; }
        struct { float x, y, z, w; }
        struct { float r, g, b, a; }
        float[4] v;
    }

    /* Operations */

    /// Returns the negated vector: `-this`
    pure Vec4 opUnary(string op : "-")() {
        return Vec4(-x, -y, -z, -w);
    }

    /// Returns the sum of the vectors: `this + v`
    pure Vec4 opBinary(string op : "+")(Vec4 v) {
        return Vec4(x + v.x,
                    y + v.y,
                    z + v.z,
                    w + v.w);
    }

    /// Returns the difference between the vectors: `this - v`
    pure Vec4 opBinary(string op : "-")(Vec4 v) {
        return Vec4(x - v.x,
                    y - v.y,
                    z - v.z,
                    w - v.w);
    }
    
    /// Returns the vector multiplied by a float: `this * f`
    pure Vec4 opBinary(string op : "*")(float f) {
        return Vec4(x*f, y*f, z*f, w*f);
    }

    /// Returns the dot product: `this * v `
    pure float opBinary(string op : "*")(Vec4 v) {
        return (x * v.x) + (y * v.y) + (z * v.z) + (w * v.w);
    }
    
    /// Returns the vector divided by a float: `this / f`
    pure Vec4 opBinary(string op : "/")(float f) {
        return Vec4(x/f, y/f, z/f, w/f);
    }

    /* Assignment Operations */
    
    /// Set each component of the vector to the given float
    void opAssign()(float f) {
        x = y = z = w =f;
    }

    /// Set the vector using a float array
    void opAssign()(float[4] v) {
        this.v = v;
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
    
    pure @property float magnitude() {
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
    pure @property Vec4 normalized() {
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

// Set each component of the vector to an absolute value
pure Vec4 abs(Vec4 v) {
    return Vec4(fabs(v.x),
                fabs(v.y),
                fabs(v.z),
                fabs(v.w));
}

/// Returns the minimum coordinates in one vector
pure Vec4 min(Vec4 a, Vec4 b) {
    return Vec4(fmin(a.x, b.x),
                fmin(a.y, b.y),
                fmin(a.z, b.z),
                fmin(a.w, b.w));
}

/// Returns the minimum coordinates in one vector
pure Vec4 max(Vec4 a, Vec4 b) {
    return Vec4(fmax(a.x, b.x),
                fmax(a.y, b.y),
                fmax(a.z, b.z),
                fmax(a.w, b.w));
}

