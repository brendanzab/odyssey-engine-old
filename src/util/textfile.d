module odyssey.util.textfile;

import std.file    : readText;
import std.path    : extension;
import std.string  : toStringz;

struct TextFile {
    
    private string filename = null,
                   cachedData = null;
    
    this(string name) {
        filename = name;
    }
    
    /// Gets the filename
    pure @property string name() {
        return filename;
    }
    
    /// Sets the filename and re-caches the file data
    @property void name(string name) {
        filename = name;
        reloadData();
    }
    
    pure @property string extension() {
        return filename.extension();
    }
    
    /// Caches the data if neccesary, then returns the data as a string
    @property string data() {
        if (cachedData == null) {
            reloadData();
        }
        return cachedData;
    }
    
    /// Caches the data if neccesary, then returns the data as a C-style string
    @property immutable(char)* dataz() {
        if (cachedData == null) {
            reloadData();
        }
        return cachedData.toStringz();
    }
    
    void reloadData() {
        cachedData = filename.readText();
    }
}