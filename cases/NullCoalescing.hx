package cases;

class NullCoalescing {
	function fromArgb(input:String):Any {
		final a = (Std.parseInt("0x" + input.substr(0, 2)) ?? 255) / 255;
		final r = (Std.parseInt("0x" + input.substr(2, 2)) ?? 255) / 255;
		final g = (Std.parseInt("0x" + input.substr(4, 2)) ?? 255) / 255;
		final b = (Std.parseInt("0x" + input.substr(6, 2)) ?? 255) / 255;
		return {
			red: r,
			green: g,
			blue: b,
			alpha: a
		};
	}

	function fromRgb(input:String) {}
}
