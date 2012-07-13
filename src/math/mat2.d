module odyssey.math.mat2;

import odyssey.math.vec2;
import std.string : format;

struct Mat2 {
    
    union {
        struct {
            float
                m00, m01,
                m10, m11;
        }
        float m[2][2];
    }
    
    // TODO: probably should add some unittests :D
    
    /**
     *  Set row
     *      eg. m.row!0 = v
     */
    @property void row(int i)(Vec2 v) {
        m[i][0] = v.v[0];
        m[i][1] = v.v[1];
    }
    
    /**
     *  Get row as a Vec3
     *      eg. m.row!1
     */
    @property Vec2 row(int i)() {
        return Vec2(m[i][0],
                    m[i][1]);
    }
    
    /**
     *  Set column
     *      eg. m.col!0 = v
     */
    @property void col(int i)(Vec2 v) {
        m[0][i] = v.v[0];
        m[1][i] = v.v[1];
    }
    
    /**
     *  Get cloumn as a Vec3
     *      eg. m.col!1
     */
    @property Vec2 col(int i)()  {
        return Vec2(m[0][i],
                    m[1][i]);
    }
    
    /**
     *  Transpose the matrix
     */
    Mat2 transpose() {
        return Mat2(m00, m10,
                    m01, m11);
    }
    
    /**
     *  The sum of the matrix and another matrix
     */
    Mat2 opBinary(string op : "+")(Mat3 m) {
        return Mat2(this.col!0 + m.col!0,
                    this.col!1 + m.col!1);
    }
    
    /**
     *  Subtract the matrix by another matrix
     */
    Mat2 opBinary(string op : "-")(Mat2 m) {
        return Mat2(this.col!0 - m.col!0,
                    this.col!1 - m.col!1);
    }
    
    /**
     *  Multiply the matrix by a float
     */
    Mat2 opBinary(string op : "*")(float f) {
        return Mat2(this.col!0 * f,
                    this.col!1 * f);
    }
    
    /**
     *  Multiply the matrix by a 2-component vector
     */
    Vec2 opBinary(string op : "*")(Vec2 v) {
        return Vec2 (
            this.row!0 * v,
            this.row!1 * v);
    }
    
    /**
     *  Multiply the matrix by another 3x3 matrix
     */
    Mat3 opBinary(string op : "*")(Mat3 m) {
        return Mat2(
            (this.row!0 * m.col!0), (this.row!0 * m.col!1),
            (this.row!1 * m.col!0), (this.row!1 * m.col!1));
    }
    
    // TODO: matrix inversion
    
    string toString() {
        return
            format("Mat2(%f.2\t%f.2 ", m00, m01) ~
            format("     %f.2\t%f.2)", m10, m11);
    }
    
}