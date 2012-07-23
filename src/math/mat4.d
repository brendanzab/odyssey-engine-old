module odyssey.math.mat4;

import odyssey.math.vec4;
import std.string : format;

const {
    Mat4 MAT4_IDENTITY =
        Mat4( 1, 0, 0, 0,
              0, 1, 0, 0,
              0, 0, 1, 0,
              0, 0, 0, 1 );
}

// TODO: Unittests

struct Mat4 {
    union {
        struct {
            float 
                m00, m01, m02, m03,
                m10, m11, m12, m13,
                m20, m21, m22, m23,
                m30, m31, m32, m33;
        };
        float[16] m16;
        float[4][4] m;
    };
    
    /**
     *  Construct the matrix
     */
    this(float m00, float m01, float m02, float m03,
         float m10, float m11, float m12, float m13,
         float m20, float m21, float m22, float m23,
         float m30, float m31, float m32, float m33) {
        
        m[0][0]=m00; m[0][1]=m01; m[0][2]=m02; m[0][3]=m03;
        m[1][0]=m10; m[1][1]=m11; m[1][2]=m12; m[1][3]=m13;
        m[2][0]=m20; m[2][1]=m21; m[2][2]=m22; m[2][3]=m23;
        m[3][0]=m30; m[3][1]=m31; m[3][2]=m32; m[3][3]=m33;
    }
    
    /**
     *  Construct the matrix using column vectors
     */
    this(Vec4 col0, Vec4 col1, Vec4 col2, Vec4 col3) {
        this.col!0 = col0;
        this.col!1 = col1;
        this.col!2 = col2;
        this.col!3 = col3;
    }
    
    @property auto ptr() { return m16.ptr; }
    
    /**
     *  Set row
     *      eg. m.row!3 = v
     */
    @property void row(int i)(Vec4 v) {
        m[i][0] = v.v[0];
        m[i][1] = v.v[1];
        m[i][2] = v.v[2];
        m[i][3] = v.v[3];
    }
    
    /**
     *  Get row as a Vec4
     *      eg. m.row!1
     */
    @property Vec4 row(int i)() {
        return Vec4(m[i][0],
                    m[i][1],
                    m[i][2],
                    m[i][3]);
    }
    
    /**
     *  Set column
     *      eg. m.col!3 = v
     */
    @property void col(int i)(Vec4 v) {
        m[0][i] = v.v[0];
        m[1][i] = v.v[1];
        m[2][i] = v.v[2];
        m[3][i] = v.v[3];
    }
    
    /**
     *  Get cloumn as a Vec4
     *      eg. m.col!1
     */
    @property Vec4 col(int i)()  {
        return Vec4(m[0][i],
                    m[1][i],
                    m[2][i],
                    m[3][i]);
    }
    
    /**
     *  Transpose the matrix
     */
    Mat4 transpose() {
        return Mat4(
            m00, m10, m20, m30,
            m01, m11, m21, m31,
            m02, m12, m22, m32,
            m03, m13, m23, m33);
    }
    
    /**
     *  The sum of the matrix and another matrix
     */
    Mat4 opBinary(string op : "+")(Mat4 m) {
        return Mat4(
            this.col!0 + m.col!0,
            this.col!1 + m.col!1,
            this.col!2 + m.col!2,
            this.col!3 + m.col!3);
    }
    
    /**
     *  Subtract the matrix by another matrix
     */
    Mat4 opBinary(string op : "-")(Mat4 m) {
        return Mat4(
            this.col!0 - m.col!0,
            this.col!1 - m.col!1,
            this.col!2 - m.col!2,
            this.col!3 - m.col!3);
    }
    
    /**
     *  Multiply the matrix by a float
     */
    Mat4 opBinary(string op : "*")(float f) {
        return Mat4(
            this.col!0 * f,
            this.col!1 * f,
            this.col!2 * f,
            this.col!3 * f);
    }
    
    /**
     *  Multiply the matrix by a 4-component vector
     */
    Vec4 opBinary(string op : "*")(Vec4 v) {
        return Vec4 (
            this.row!0 * v,
            this.row!1 * v,
            this.row!2 * v,
            this.row!3 * v);
    }
    
    /**
     *  Multiply the matrix by another 4x4 matrix
     */
    Mat4 opBinary(string op : "*")(Mat4 m) {
        return Mat4(
            (this.row!0 * m.col!0), (this.row!0 * m.col!1), (this.row!0 * m.col!2), (this.row!0 * m.col!3),
            (this.row!1 * m.col!0), (this.row!1 * m.col!1), (this.row!1 * m.col!2), (this.row!1 * m.col!3),
            (this.row!2 * m.col!0), (this.row!2 * m.col!1), (this.row!2 * m.col!2), (this.row!2 * m.col!3),
            (this.row!3 * m.col!0), (this.row!3 * m.col!1), (this.row!3 * m.col!2), (this.row!3 * m.col!3));
    }
    
    // TODO: Matrix Inversion
    
    string toString() {
        return 
            format("Mat4(%f.2\t%f.2\t%f.2\t%f.2\n", m00, m01, m02, m03)~
            format("     %f.2\t%f.2\t%f.2\t%f.2\n", m10, m11, m12, m13)~
            format("     %f.2\t%f.2\t%f.2\t%f.2\n", m20, m21, m22, m23)~
            format("     %f.2\t%f.2\t%f.2\t%f.2)",  m30, m31, m32, m33);
    }
    
}

Mat4 perspective(float fov, float aspect, float near, float far) {
    
    // TODO!
    
    //float range = tan
    throw new Exception("Not yet implemented");
}

Mat4 translate(Mat4 m, Vec4 v) {
    Mat4 result = m;
    result.col!3 = (m.col!0 * v.v[0]) +
                   (m.col!1 * v.v[1]) + 
                   (m.col!2 * v.v[2]) + m.col!3;
    return result;
}

Mat4 scale(Mat4 m, Vec4 v) {
    Mat4 result;
    result.col!0 = m.col!0 * v.v[0];
    result.col!1 = m.col!1 * v.v[1];
    result.col!2 = m.col!2 * v.v[2];
    result.col!3 = m.col!3;
    return result;
}