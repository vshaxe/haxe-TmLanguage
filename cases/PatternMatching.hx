switch(e.expr) {
    case EConst(CString(s)) if (StringTools.startsWith(s, "foo")):
        "1";
    case EConst(CString(s)) if (StringTools.startsWith(s, "bar")):
        "2";
    case EConst(CInt(i)) if (switch(Std.parseInt(i) * 2) { case 4: true; case _: false; }):
        "3";
    case EConst(_):
        "4";
    default:
        "5";
}

switch [true, 1, "foo"] {
    case [true, 1, "foo"]: "0";
    case [true, 1, _]: "1";
    case _: "_";
}

class Colors {
    static function toInt( c : Color ) : Int {
        return switch( c ) {
            case Red: 0xFF0000;
            case Green: 0x00FF00;
            case Blue: 0x0000FF;
            case Grey(v): (v << 16) | (v << 8) | v;
            case Rgb(r,g,b): (r << 16) | (g << 8) | b;
            case Alpha(a,c): (a << 24) | (toInt(c) & 0xFFFFFF);
        }
    }
}