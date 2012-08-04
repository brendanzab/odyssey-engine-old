module odyssey.math.vec2;

import std.math : fabs, fmin, fmax, sqrt;

// Constants
const {
    Vec2 VEC2_ZERO      = { 0, 0 };
    Vec2 VEC2_UNIT_X    = { 1, 0 };
    Vec2 VEC2_UNIT_Y    = { 0, 1 };
    Vec2 VEC2_IDENTITY  = { 1, 1 };
}

struct Vec2 {
    
    union {
        struct { float i, j; }
        struct { float x, y; }
        float[2] v;
    }
    
    /* Operations */
    
    /// Returns the negated vector: `-this`
    Vec2 opUnary(string op : "-")() {
        return Vec2(-x, -y);
    }

    /// Returns the sum of the vectors: `this + v`
    Vec2 opBinary(string op : "+")(Vec2 v) {
        return Vec2(x + v.x,
                    y + v.y);
    }

    /// Returns the difference between the vectors: `this - v`
    Vec2 opBinary(string op : "-")(Vec2 v) {
        return Vec2(x - v.x,
                    y - v.y);
    }
    
    /// Returns the vector multiplied by a float: `this * f`
    Vec2 opBinary(string op : "*")(float f) {
        return Vec2(x*f, y*f);
    }
    
    /// Returns the vector divided by a float: `this / f`
    Vec2 opBinary(string op : "/")(float f) {
        return Vec2(x/f, y/f);
    }
    
    /* Assignment Operations */
    
    /// Set each component of the vector to the given float
    void opAssign()(float f) {
        x = y = f;
    }

    /// Set the vector using a float array
    void opAssign()(float[2] v) {
        this.v = v;
    }

    /// Add to vector: `this += v`
    void opAssign(string op : "+")(Vec2 v) {
        x += v.x;
        y += v.y;
    }

    /// Subtract from vector: `this -= v`
    void opAssign(string op : "-")(Vec2 v) {
        x -= v.x;
        y -= v.y;
    }

    /// Multiply vector: `this *= f`
    void opAssign(string op : "*")(float f) {
        x *= f;
        y *= f;
    }

    /// Divide vector: `this /= f`
    void opAssign(string op : "/")(float f) {
        x /= f;
        y /= f;
    }
    
    /* Other Methods */
    
    /// Get the magnitute of the vector
    @property float magnitude() {
        return sqrt(x*x + y*y);
    }
    
    /// Set the magnitude whilst preserving the direction
    @property void magnitude(float m) {
        float n = (1 / magnitude) * m;
        x *= n;
        y *= n;
    }

    /// Returns the normalized vector
    @property Vec2 normalized() {
        float n = 1 / magnitude;
        return this * n;
    }

    void normalizeSelf() {
        float n = 1 / magnitude;
        x *= n;
        y *= n;
    }
    
}

Vec2 abs(Vec2 v) {
    return Vec2(fabs(v.x),
                fabs(v.y));
}

/// Returns the minimum coordinates in one vector
Vec2 min(Vec2 a, Vec2 b) {
    return Vec2(fmin(a.x, b.x),
                fmin(a.y, b.y));
}

/// Returns the minimum coordinates in one vector
Vec2 max(Vec2 a, Vec2 b) {
    return Vec2(fmax(a.x, b.x),
                fmax(a.y, b.y));
}