class Main {
    public static function main() {
        var obj = {
            foo: switch baz() {
                case {x: x}: [x];
            },
            bar: switch baz() {
                case {x: x}: [x];
            },
        }
    }
}
