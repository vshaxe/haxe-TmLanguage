switch e {
    case macro [for ($it) $body]:
    case macro super($a{_}):
    case macro null:
    case macro before(function($n) $f):
    case macro $a.should().$b, macro $a.should.$b:
    case macro @:keep e:
}