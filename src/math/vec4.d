module odyssey.math.vec4;

import std.math;
import std.string;

struct Vec4 {
    
    float x, y, z, w;

    /* Operations */

    /// Returns the negated vector: `-this`
    Vec4 opUnary(string op : "-")() {
        return Vec4(-x, -y, -z, -w);
    }

    /// Returns the sum of the vectors: `this + v`
    Vec4 opBinary(string op : "+")(Vec4 v) {
        return Vec4(x + v.x, y + v.y, z + v.z, w + v.w);
    }

    /// Returns the difference between the vectors: `this - v`
    Vec4 opBinary(string op : "-")(Vec4 v) {
        return Vec4(x - v.x, y - v.y, z - v.z, w - v.w);
    }
    
    /// Returns the vector multiplied by a float: `this * f`
    Vec4 opBinary(string op : "*")(float f) {
        return Vec4(x*f, y*f, z*f, w*f);
    }

    /// Dot product: `this * v`
    float opBinary(string op : "*")(Vec4 v) {
        return (x * v.x) + (y * v.y) + (z * v.z) + (w * v.w);
    }
    
}