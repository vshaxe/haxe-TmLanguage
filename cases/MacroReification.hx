class Foo {
    function foo() {
        var e = macro var $myVar = 0;
        var e = macro ${v}.toLowerCase();
        var e = macro o.$myField;
        var e = macro { $myField : 0 };
        var e = macro $i{varName}++;
        var e = macro $v{myStr};
        var args = [macro "sub", macro 3];
        var e = macro "Hello".toLowerCase($a{args});
        (macro $i{tmp}.addAtom($v{name}, $atom)).finalize(op.pos);

        var c = macro class MyClass extends Foo implements IClass {
            public function new() { }
            public function $funcName() {
                trace($v{funcName} + " was called");
            }
        }

        //macro class could have no name...
        var def = macro class {
            private inline function new(loader) this = loader;
            private var loader(get,never) : $loaderType;
            inline private function get_loader() : $loaderType return this;
        };

        var c = macro interface IClass {};
    }
}