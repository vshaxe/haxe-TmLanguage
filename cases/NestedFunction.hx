class Test <T:Void->Void> {
    private function new():Void {
        inline function innerFun(a:Int, b:Int):Int {
            return readOnlyField = a + b;
        }

        _innerFun(1, 2.3);
    }
}
