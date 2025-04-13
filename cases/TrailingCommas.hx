function funshort(
    a:Int, // a
    callback:()->Int, // cb
):Int {
    return a + callback();
}

function funlong(
    a:Int, // a
    callback:(?a:(f:Int,)->Int, ?b:Int)->Int, // cb
):Int {
    return a + callback();
}

class Trailing {
    static function f(t:Type.ValueType, t2:Type.ValueType,) {}
    public static function main():Void {
        f(TNull,TNull,);
        foobar(
            1,
            2,
        );
        function blah(
            a:Int,
            b:Int,
        ):Void {}
        var a:(
            a:Int,
            b:Int,
        )->Int = null;
        a = (a, b,) -> a + b;
        trace(a(2, 3,) + moduleFoobar(5, 5,));
    }

    static function foobar(
        a:Int,
        b:Int,
    ):Void {}
}

enum Foo {
    Bar(
        a:Int,
        b:Int,
    );
}

function noargs(
):String {
    return "1" + 2;
}
