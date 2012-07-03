module odyssey.math.matrix;

import odyssey.math.vec3;

const {
    Mat4 MAT4_IDENTITY =
        { 1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          0, 0, 0, 1 };
}

struct Mat4 {
    
    float
        m11, m12, m13, m14,
        m21, m22, m23, m24,
        m31, m32, m33, m34,
        m41, m42, m43, m44;
    
    Mat4 transpose() {
        return Mat4(
            m11, m21, m31, m41,
            m12, m22, m32, m42,
            m13, m23, m33, m43,
            m14, m24, m34, m44);
    }
    
    Mat4 opBinary(string op : "*")(float f) {
        return Mat4(
            m11*f, m12*f, m13*f, m14*f,
            m21*f, m22*f, m23*f, m24*f,
            m31*f, m32*f, m33*f, m34*f,
            m41*f, m42*f, m43*f, m44*f);
    }
    
    Vec4 opBinary(string op : "*")(Vec4 v) {
        return Vec4 (
            m11*v.x + m12*v.y + m13*v.z + m14*v.w,
            m21*v.x + m22*v.y + m23*v.z + m24*v.w,
            m31*v.x + m32*v.y + m33*v.z + m34*v.w,
            m41*v.x + m42*v.y + m43*v.z + m44*v.w);
    }
    
    void opAssign(string op : "*")(float f) {
        m11*=f; m12*=f; m13*=f; m14*=f;
        m21*=f; m22*=f; m23*=f; m24*=f;
        m31*=f; m32*=f; m33*=f; m34*=f;
        m41*=f; m42*=f; m43*=f; m44*=f;
    }
    
}

/*
Mat4 perspective(float fov, float aspectRatio, float near, float far) {
    
}

Mat4 translate(Mat4 m, Vec3 v) {
    Mat4 result = m;
    
}

Mat4 scale(Mat4 m, Vec3 v) {
    
}
*/