switch (3) {
	case add(_, 1) => mul(_, 3) => a:
	trace(a);
}

var success = switch (e) {
	case TString(_.toLowerCase() => "foo"):
		true;
	case _:
		false;
}
