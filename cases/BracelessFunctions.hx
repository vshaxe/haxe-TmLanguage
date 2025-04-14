typedef Type = {
    function f(cb:()->Void):Any<Int>;
}

var v = function name():Any<Int> new Boo("name", null);
var v = function name() new Boo("name", null);
var v = function():Any<Int> new Boo("name", null);
var v = function() new Boo("name", null);

var value = true ? (v) : v;

function foo(obj:{
    var foo:Int;
    function foo():Void;
}):Void;

class A {
    function f(cb:()->Void):Any<Int> return new Boo("name", null, this);
    function f(cb:()->Void):Any<Int> new Boo("name", null, this);
    function f(cb:()->Void) return   new Boo("name", null, this);
    function f(cb:()->Void) {        new Boo("name", null, this);}
    function f(cb:()->Void) return       Boo("name", null, this);
    function foo() {
        () -> new Boo("name", null, this);

        var v = function name():Void
            trace(1);
    }
}

var v = function(_) trace("foo");

function bracelessFunction() {
    iter(function() trace("Braceless") );
}

abstract Callback<T>(CallbackData<T>) from CallbackData<T> {
    @:from static inline function fromOptionalErrorOnly(f:(?error:Error) -> Void):Callback<NoData>
        return (?err:Error, ?result:NoData) -> f(err);

    @:from static inline function fromErrorOnly(f:(error:Error) -> Void):Callback<NoData>
        return (?err:Error, ?result:NoData) -> f(err);
}

class C {
    function f() {
        f(
            function() f,
            function() f,
            function() f
        );
    }
}

class T {}

class Body implements BodyInt {
    public inline function shape():Shape
        throw new Rect(new Vec(1)).top_left;
}

function set_pos(body:Body)
    update_entity(body);

final class Main {
    static function main() {}
}

class Main {
    static function main() {
        '${foo((j) -> return j)}';
        '${foo(function(j) return j)}'; // oh my everything is a string
    }
}

'abc${a.f(function() trace(o))}abc';
