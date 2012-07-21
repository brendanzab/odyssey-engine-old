module odyssey.math.vec3;

import std.math : sqrt;

// Constants
const {
    Vec3 VEC3_ZERO      = Vec3( 0, 0, 0 );
    Vec3 VEC3_UNIT_X    = Vec3( 1, 0, 0 );
    Vec3 VEC3_UNIT_Y    = Vec3( 0, 1, 0 );
    Vec3 VEC3_UNIT_Z    = Vec3( 0, 0, 1 );
    Vec3 VEC3_IDENTITY  = Vec3( 1, 1, 1 );
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
    void opAssign(string op : "*")(Vec3 v) {
        x -= v.x;
        y -= v.y;
        z -= v.z;
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