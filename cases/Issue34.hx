var option = haxe.ds.Option.Some(0);
switch (option) {
    case Foo(var a, var b): "foo";
    case Some(var i): "bar";
    case None:
}