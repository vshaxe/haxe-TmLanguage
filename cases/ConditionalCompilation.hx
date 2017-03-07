#if flash8
// Haxe code specific for flash player 8
#elseif flash
// Haxe code specific for flash platform (any version)
#elseif js
// Haxe code specific for javascript platform
#elseif neko
// Haxe code specific for neko platform
#else
// do something else
    #error  // will display an error "Not implemented on this platform"
    #error "Custom error message" // will display an error "Custom error message"
#end

class Foo {
    public static inline function indexOf<T>(?arr:Array<T>, v:T) : Int
    {
        #if ((haxe_ver >= 3.1) && foo)
        #line 0 return arr.indexOf(v);
        #if foo
            #if !!(flash || js)
            return untyped arr.indexOf(v);
            #else
            return std.Lambda.indexOf(arr, v);
            #end
        #end
    }

    // single-line conditionals
    function foo () {
        #if (haxe_ver >= 3.1) return true #elseif false return false #else throw "error" #end ;
    }
}