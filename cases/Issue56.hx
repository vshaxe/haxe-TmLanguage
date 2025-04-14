function name():Void {
    var x = true ? {x: 1, y: 0} : {x: 0, y: 1};

    var x = true ? {x: cast {x: 0}, y: 0} : {x: 0, y: 1};

    var x = true ? (":"):":";

    var x = true/**/?/**/(":")/**/:/**/":";
}

