var f = function(foo) {}
var f = function (foo) {}

var v:Dynamic<Float>;
var v:Dynamic<{ "x":Int, y:Int }>;
var v:{ foo:Dynamic<Float> };
var v/**/:/**/Foo/**/, /**/ b:Dynamic<Float> = a < b;
var v:{ foo:Dynamic<Float>, "bar":String }, b, c:Foo = a < b;

var v = {
    5;
};

{
    var x;
    var y = 3;
    var z : String;
    var w : String = "";
    var a, b : Bool, c : Int = 0;
}