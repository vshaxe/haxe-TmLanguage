() -> 1;
(?a:Int) -> a;
(a:Int=1, b:String) -> a + b.length;
map = [1 => a -> a + a, 2 => a -> a + a, 3 => a -> a + a];
(() -> 1:Void->Int);

var f:Void->Int;
var f:Int->Int->(Int->Int);