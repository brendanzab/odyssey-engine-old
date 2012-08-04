module odyssey.math.vec3;

import std.math : fabs, fmin, fmax, sqrt;

// Constants
const {
    Vec3 VEC3_ZERO      = { 0, 0, 0 };
    Vec3 VEC3_UNIT_X    = { 1, 0, 0 };
    Vec3 VEC3_UNIT_Y    = { 0, 1, 0 };
    Vec3 VEC3_UNIT_Z    = { 0, 0, 1 };
    Vec3 VEC3_IDENTITY  = { 1, 1, 1 };
}

/**
 *  A 3-dimensional vector
 */
struct Vec3 {

    union {
        struct { float i, j, k; }
        struct { float x, y, z; }
        struct { float r, g, b; }
        float[3] v;
    }
    
    enum glsizeof = cast(void*) Vec3.sizeof;

    /* Operations */

    /// Returns the negated vector: `-this`
    Vec3 opUnary(string op : "-")() {
        return Vec3(-x, -y, -z);
    }

    /// Returns the sum of the vectors: `this + v`
    Vec3 opBinary(string op : "+")(Vec3 v) {
        return Vec3(x + v.x,
                    y + v.y,
                    z + v.z);
    }

    /// Returns the difference between the vectors: `this - v`
    Vec3 opBinary(string op : "-")(Vec3 v) {
        return Vec3(x - v.x,
                    y - v.y,
                    z - v.z);
    }
    
    /// Returns the vector multiplied by a float: `this * f`
    Vec3 opBinary(string op : "*")(float f) {
        return Vec3(x*f, y*f, z*f);
    }

    /// Returns the dot product: `this * v `
    float opBinary(string op : "*")(Vec3 v) {
        return (x * v.x) + (y * v.y) + (z * v.z);
    }
    
    /// Returns the vector divided by a float: `this / f`
    Vec3 opBinary(string op : "/")(float f) {
        return Vec3(x/f, y/f, z/f);
    }
    
    /// Returns the cross product
    Vec3 cross(Vec3 v) {
        return Vec3(
            y*v.z - z*v.y,
            z*v.x - x*v.z,
            x*v.y - y*v.x);
    }

    /* Assignment Operations */
    
    /// Set each component of the vector to the given float
    Vec3 opAssign()(float f) {
        x = y = z = f;
        return this;
    }

    /// Set the vector using a float array
    void opAssign()(float[3] v) {
        this.v = v;
    }
    
    Vec3 opAssign()(Vec3 v) {
        x = v.x;
        y = v.y;
        z = v.z;
        return this;
    }

    /// Add to vector: `this += v`
    void opAssign(string op : "+")(Vec3 v) {
        x += v.x;
        y += v.y;
        z += v.z;
    }

    /// Subtract from vector: `this -= v`
    void opAssign(string op : "-")(Vec3 v) {
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
        x /= f;
        y /= f;
        z /= f;
    }

    /* Other Methods */
    
    /// Get the magnitute of the vector
    @property float magnitude() {
        return sqrt(x*x + y*y + z*z);
    }
    
    /// Set the magnitude whilst preserving the direction
    @property void magnitude(float m) {
        float n = (1 / magnitude) * m;
        x *= n;
        y *= n;
        z *= n;
    }

    /// Returns the normalized vector
    @property Vec3 normalized() {
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

Vec3 abs(Vec3 v) {
    return Vec3(fabs(v.x),
                fabs(v.y),
                fabs(v.z));
}

/// Returns the minimum coordinates in one vector
Vec3 min(Vec3 a, Vec3 b) {
    return Vec3(fmin(a.x, b.x),
                fmin(a.y, b.y),
                fmin(a.z, b.z));
}

/// Returns the minimum coordinates in one vector
Vec3 max(Vec3 a, Vec3 b) {
    return Vec3(fmax(a.x, b.x),
                fmax(a.y, b.y),
                fmax(a.z, b.z));
}