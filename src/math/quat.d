module odyssey.math.quat;

struct Quat {
    
    union {
        struct { float x, y, z, w; }
        float[4] q;
    }
    
}