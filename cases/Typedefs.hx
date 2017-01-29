typedef Pt = {
    #if #else #end
    var x:Dynamic<Float>;
    var y:Float;
    @:optional var z:Float; /* optional z */
    private function add(pt:Pt):Void;
}

typedef Pt2 = {
    #if #else #end
    x:Dynamic<Float>,
    y:Float,
    ?z:Float, //optional z
    add : Point -> Void,
}

typedef DS = Dynamic<String>;