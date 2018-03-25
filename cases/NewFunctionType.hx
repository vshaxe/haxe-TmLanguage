// no arguments
var f:() -> Void;

// single argument
var f:(name:String) -> Void;

// multiple (also, optional) arguments
var f:(name:String, ?age:Int) -> Void;

// unnamed arguments
var f:(Int, String) -> Bool;

// mixed arguments, why not
var f:(a:Int, ?String) -> Void;

// nested
var f:(Int, a:(a:Int, ?String) -> Void) -> Bool;

var f:(UpperCaseName:String) -> Void;

function foo(f:(Int, a:(a:Int, ?String) -> Void) -> Bool) {}