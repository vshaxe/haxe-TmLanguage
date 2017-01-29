// 'is' should be highlighted
(Math.random() * 5 is String);
trace(("" is String));
super(("" is String));
for (i in 0...("" is String)) {}
while (("" is String)) {}
switch ("" is String) { case _:}
@:native(("" is String))
@:custom(("" is String))
untyped __call__(("" is String));

// 'is' should not be highlighted
Math.random() * 5 is String;
trace("" is String);
super("" is String);
while ("" is String) {}
switch "" is String { case _:}
for ("" is String) {}
@:native("" is String)
@:custom("" is String)
untyped __call__("" is String);

var is:Int;

// Std.is() still needs to be a method name
(Std.is());