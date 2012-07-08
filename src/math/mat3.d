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
    
    /**
     *  This union allows the Vec3's elements to be accessed
     *  either as separate variables or from a 3x3 array
     */
    union {
        /**
         * The matrix elements as separate member variables
         */
        struct {
            float
                m00, m01, m02,
                m10, m11, m12,
                m20, m21, m22;
        }
        /**
         *  The matrix elements as a 3x3 array
         */
        float[3][3] m;
    }
    
    /**
     *  Construct the matrix
     */
    this(float m00, float m01, float m02,
         float m10, float m11, float m12,
         float m20, float m21, float m22) {
        
        m[0][0]=m00; m[0][1]=m01; m[0][2]=m02;
        m[1][0]=m10; m[1][1]=m11; m[1][2]=m12;
        m[2][0]=m20; m[2][1]=m21; m[2][2]=m22;
    }
    
    /**
     *  Construct the matrix using the column vectors
     */
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
            
        // test that the layout of the array inidicies matches the constructor
        Mat3 b =
            Mat3(a.m[0][0], a.m[0][1], a.m[0][2],
                 a.m[1][0], a.m[1][1], a.m[1][2],
                 a.m[2][0], a.m[2][1], a.m[2][2]);
        
        assert(a == b);
        
        // test accessing via member variables
        Mat3 c;
        c.m00=a.m[0][0]; c.m01=a.m[0][1]; c.m02=a.m[0][2];
        c.m10=a.m[1][0]; c.m11=a.m[1][1]; c.m12=a.m[1][2];
        c.m20=a.m[2][0]; c.m21=a.m[2][1]; c.m22=a.m[2][2];
        
        assert(b == c);
    }
    
    /**
     *  Set row
     *      eg. m.row!3 = v
     */
    @property void row(int i)(Vec3 v) {
        m[i][0] = v.i; m[i][1] = v.j; m[i][2] = v.k;
    }
    
    /**
     *  Get row as a Vec3
     *      eg. m.row!1
     */
    @property Vec3 row(int i)() {
        return Vec3(m[i][0], m[i][1], m[i][2]);
    }
    
    /**
     *  Set column
     *      eg. m.col!3 = v
     */
    @property void col(int i)(Vec3 v) {
        m[0][i] = v.i;
        m[1][i] = v.j;
        m[2][i] = v.k;
    }
    
    /**
     *  Get cloumn as a Vec3
     *      eg. m.col!1
     */
    @property Vec3 col(int i)()  {
        return Vec3(m[0][i], m[1][i], m[2][i]);
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
    }
    
    /**
     *  Transpose the matrix
     */
    Mat3 transpose() {
        return Mat3(
            m00, m10, m20,
            m01, m11, m21,
            m02, m12, m22);
    }
    
    /**
     *  The sum of the matrix and another matrix
     */
    Mat3 opBinary(string op : "+")(Mat3 m) {
        return Mat3(
            this.col!0 + m.col!0,
            this.col!1 + m.col!1,
            this.col!2 + m.col!2);
    }
    
    /**
     *  Subtract the matrix by another matrix
     */
    Mat3 opBinary(string op : "-")(Mat3 m) {
        return Mat3(
            this.col!0 - m.col!0,
            this.col!1 - m.col!1,
            this.col!2 - m.col!2);
    }
    
    /**
     *  Multiply the matrix by a float
     */
    Mat3 opBinary(string op : "*")(float f) {
        return Mat3(
            this.col!0 * f,
            this.col!1 * f,
            this.col!2 * f);
    }
    
    unittest {
        
        // test matrix multiplication by float
        
        float f = 2;
        
        Mat3 a =
            Mat3(1, 2, 3,
                 4, 5, 6,
                 7, 8, 9);
        Mat3 b =
            Mat3( 2,  4,  6,
                  8, 10, 12,
                 14, 16, 18);
            
        assert(a * f == b);
    }
    
    /**
     *  Multiply the matrix by a 3-component vector
     */
    Vec3 opBinary(string op : "*")(Vec3 v) {
        return Vec3 (
            this.row!0 * v,
            this.row!1 * v,
            this.row!2 * v);
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
        // test Mat4*Mat4 multiplication
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
        
        // test identity constant
        assert(a * MAT3_IDENTITY == a);
    }
    
    string toString() {
        return
            format("Mat3(%f.2\t%f.2\t%f.2 ", m00, m01, m02) ~
            format("     %f.2\t%f.2\t%f.2 ", m10, m11, m12) ~
            format("     %f.2\t%f.2\t%f.2)", m20, m21, m22);
    }
    
}