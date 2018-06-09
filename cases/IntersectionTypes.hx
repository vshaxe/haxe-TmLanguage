typedef Type3 = Type1 & Type2 & {
	var field3:Bool;
}

typedef Type3 = {
	var field3:Bool;
} & Type1 & Type2;

typedef Type3 =
	Type1 &
	Type2 & {
	var field3:Bool;
}

class Class<Paramt:Type1 & Type2> { }
