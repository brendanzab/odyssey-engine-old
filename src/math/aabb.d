module odyssey.math.aabb;

import odyssey.math.vec3;
import std.math : abs, min, max;

struct AABB {
    Vec3 center;
    Vec3 size;
    
    this(Vec3 center, Vec3 size) {
        this.center = center;
        this.size = size;
    }
    
    this(float width, float height, float depth) {
        this.size = Vec3(width, height, depth);
    }
    
    this(float minX, float minY, float minZ,
         float maxX, float maxY, float maxZ) {
        setBounds(minX, minY, minZ, maxX, maxY, maxZ);
    }
    
    @property float width () { return size.x; }
    @property float height() { return size.y; }
    @property float depth () { return size.z; }
    @property void  width (float f)  { size.x = f; }
    @property void  height(float f)  { size.x = f; }
    @property void  depth (float f)  { size.x = f; }
    
    @property float minX() { return center.x - abs(size.x)/2; }
    @property float minY() { return center.y - abs(size.y)/2; }
    @property float minZ() { return center.z - abs(size.z)/2; }
    @property float maxX() { return center.x + abs(size.x)/2; }
    @property float maxY() { return center.y + abs(size.y)/2; }
    @property float maxZ() { return center.z + abs(size.z)/2; }
    
    void setBounds(float minX, float minY, float minZ,
                   float maxX, float maxY, float maxZ) {
        center = (Vec3(minX, minY, minZ) + Vec3(maxX, maxY, maxZ)) / 2;
        size = Vec3(maxX - minX, maxY - minY, maxZ - minZ);
    }
    
    void normalize() {
        size = abs(size);
    }
    
    bool contains(Vec3 v) {
        return v.x > this.minX && v.x < this.maxX &&
               v.y > this.minY && v.y < this.maxY &&
               v.z > this.minZ && v.z < this.maxZ;
    }
    
    bool contains(AABB other) {
        return other.minX > this.minX && other.maxX < this.maxX &&
               other.minY > this.minY && other.maxY < this.maxY &&
               other.minZ > this.minZ && other.maxZ < this.maxZ;
    }
    
    //bool intersects(AABB other) {
    //    return null; //TODO!!
    //}
    
    void envelop(AABB other) {
        this.setBounds(
            min(this.minX, other.minX),
            min(this.minY, other.minY),
            min(this.minZ, other.minZ),
            max(this.maxX, other.maxX),
            max(this.maxY, other.maxY),
            max(this.maxZ, other.maxZ)
        );
    }
    
    void envelop(Vec3 v) {
        this.setBounds(
            min(this.minX, v.x),
            min(this.minY, v.y),
            min(this.minZ, v.z),
            max(this.maxX, v.x),
            max(this.maxY, v.y),
            max(this.maxZ, v.z)
        );
    }
}