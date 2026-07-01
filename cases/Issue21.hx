package cases;

abstract A({b:Int}) {
	var Foo = 0;
}

abstract A({b:Int}) from {b:Int} to {b:Int} {
	var Foo = 0;
}

abstract B({
	b:Int,
}) from {
	b:Int,
} to {
	b:Int,
} {
	var Foo = 0;
}
