module odyssey.math.mat3;

import odyssey.math.vec3;
import std.string : format;

const {
    Mat3 MAT3_IDENTITY =
        Mat3( 1, 0, 0,
              0, 1, 0,
              0, 0, 1 );
}

struct Mat3 {
    
    union {
        /// The matrix elements as separate member variables
        struct {
            float
                m00, m01, m02,
                m10, m11, m12,
                m20, m21, m22;
        }
        
        /// The matrix elements as a 3x3 array
        float[3][3] m;
    }
    
    this(float m00, float m01, float m02,
         float m10, float m11, float m12,
         float m20, float m21, float m22) {
        
        m[0][0]=m00; m[0][1]=m01; m[0][2]=m02;
        m[1][0]=m10; m[1][1]=m11; m[1][2]=m12;
        m[2][0]=m20; m[2][1]=m21; m[2][2]=m22;
    }
    
    //this(float f) {
    //    m[0][0]=f; m[0][1]=0; m[0][2]=0;
    //    m[1][0]=0; m[1][1]=f; m[1][2]=0;
    //    m[2][0]=0; m[2][1]=0; m[2][2]=f;
    //}
    
    this(Vec3 col0, Vec3 col1, Vec3 col2) {
        this.col!0 = col0;
        this.col!1 = col1;
        this.col!2 = col2;
    }
    
    unittest {
        Mat3 a =
            Mat3( 2, -4, -6,
                 -4,  3, 10,
                  1,  0, -9);
        Mat3 b =
            Mat3(a.m[0][0], a.m[0][1], a.m[0][2],
                 a.m[1][0], a.m[1][1], a.m[1][2],
                 a.m[2][0], a.m[2][1], a.m[2][2]);
        
        assert(a == b);
    }
    
    @property void row(int i)(Vec3 v) {
        m[i][0] = v.x; m[i][1] = v.y; m[i][2] = v.z;
    }
    
    @property Vec3 row(int i)() {
        return Vec3(m[i][0], m[i][1], m[i][2]);
    }
    
    @property void col(int i)(Vec3 v) {
        m[0][i] = v.x;
        m[1][i] = v.y;
        m[2][i] = v.y;
    }
    
    @property Vec3 col(int i)()  {
        return Vec3(
            m[0][i],
            m[1][i],
            m[2][i]);
    }
    
    unittest {
        Mat3 a;
        a.row!0 = Vec3( 2, -4, -6);
        a.row!1 = Vec3(-4,  3, 10);
        a.row!2 = Vec3( 1,  0, -9);
        
        assert(a.col!0 == Vec3( 2, -4,  1));
        assert(a.col!1 == Vec3(-4,  3,  0));
        assert(a.col!2 == Vec3(-6, 10, -9));
        
        Mat3 b =
            Mat3( 2, -4, -6,
                 -4,  3, 10,
                  1,  0, -9);
        
        assert(a == b);
        
        Mat3 c =
            Mat3(a.m[0][0], a.m[0][1], a.m[0][2],
                 a.m[1][0], a.m[1][1], a.m[1][2],
                 a.m[2][0], a.m[2][1], a.m[2][2]);
        
        assert(a == c);
    }
    
    Mat3 transpose() {
        return Mat3(
            m[0][0], m[1][0], m[2][0],
            m[0][1], m[1][1], m[2][1],
            m[0][2], m[1][2], m[2][2]);
    }
    
    Mat3 opBinary(string op : "+")(Mat3 m) {
        return Mat3(
            (m[0][0] + m.m[0][0]), (m[0][1] + m.m[0][1]), (m[0][2] + m.m[0][2]),
            (m[1][0] + m.m[1][0]), (m[1][1] + m.m[1][1]), (m[1][2] + m.m[1][2]),
            (m[2][0] + m.m[2][0]), (m[2][1] + m.m[2][1]), (m[2][2] + m.m[2][2]));
    }
    
    Mat3 opBinary(string op : "-")(Mat3 m) {
        return Mat3(
            (m[0][0] - m.m[0][0]), (m[0][1] - m.m[0][1]), (m[0][2] - m.m[0][2]),
            (m[1][0] - m.m[1][0]), (m[1][1] - m.m[1][1]), (m[1][2] - m.m[1][2]),
            (m[2][0] - m.m[2][0]), (m[2][1] - m.m[2][1]), (m[2][2] - m.m[2][2]));
    }
    
    /**
     *  Multiply the matrix by a float
     */
    Mat3 opBinary(string op : "*")(float f) {
        return Mat3(
            (m[0][0] * f), (m[0][1] * f), (m[0][2] * f),
            (m[1][0] * f), (m[1][1] * f), (m[1][2] * f),
            (m[2][0] * f), (m[2][1] * f), (m[2][2] * f));
    }
    
    /**
     *  Multiply the matrix by a 3-component vector
     */
    Vec3 opBinary(string op : "*")(Vec3 v) {
        return Vec3 (
            row!0 * v,
            row!1 * v,
            row!2 * v);
    }
    
    /**
     *  Multiply the matrix by another 3x3 matrix
     */
    Mat3 opBinary(string op : "*")(Mat3 m) {
        return Mat3(
            (this.row!0 * m.col!0), (this.row!0 * m.col!1), (this.row!0 * m.col!2),
            (this.row!1 * m.col!0), (this.row!1 * m.col!1), (this.row!1 * m.col!2),
            (this.row!2 * m.col!0), (this.row!2 * m.col!1), (this.row!2 * m.col!2));
    }
    
    unittest {
        auto m = 
            Mat3( 2,  3,  1,
                  4,  2,  0,
                  5,  1,  7);
            
        assert(m * MAT3_IDENTITY == m);
        
        auto a =
            Mat3( 1, -5,  3,
                  0, -2,  6,
                  7,  2, -4);
        auto b =
            Mat3(-8,  6,  1,
                  7,  0, -3,
                  2,  4,  5);
        auto c =
            Mat3(-37,  18,  31,
                  -2,  24,  36,
                 -50,  26, -19);
            
        assert(a * b == c);
    }
    
    string toString() {
        return
            format("Mat3(%f.2\t%f.2\t%f.2 ", m[0][0], m[0][1], m[0][2]) ~
            format("     %f.2\t%f.2\t%f.2 ", m[1][0], m[1][1], m[1][2]) ~
            format("     %f.2\t%f.2\t%f.2)", m[2][0], m[2][1], m[2][2]);
    }
    
}