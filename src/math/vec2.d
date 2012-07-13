module odyssey.math.vec2;

import std.math : sqrt;

// Constants
const {
    Vec2 VEC2_ZERO    = Vec2( 0, 0 );
    Vec2 VEC2_UNIT_X  = Vec2( 1, 0 );
    Vec2 VEC2_UNIT_Y  = Vec2( 0, 1 );
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
    
    /* Assignment Operations */
    
    /// Set each component of the vector to the given float
    void opAssign()(float f) {
        x = y = f;
    }

    /// Add to vector: `this += v`
    void opAssign(string op : "+")(Vec2 v) {
        x += v.x;
        y += v.y;
    }

    /// Subtract from vector: `this -= v`
    void opAssign(string op : "*")(Vec2 v) {
        x -= v.x;
        y -= v.y;
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
    Vec2 normalize() {
        float n = 1 / magnitude;
        return this * n;
    }

    void normalizeSelf() {
        float n = 1 / magnitude;
        x *= n;
        y *= n;
    }
    
}