// valid, double quote
"\n \r \t \" \' \\";

"\000 \123 \295 \371";
"\x01";
"\xFa";
"\u2603";
"\u{1}";
"\u{1F37A}";

// invalid, double quote
"\foo \bar";

"\400";
"\1000";
"\x1";
"\x1000";
"\u263";
"\u26030";
"\u{}";
"\u{1F37P}";

// valid, single quote
'\n \r \t \" \' \\';

'\000 \123 \295 \371';
'\x01';
'\xFa';
'\u2603';
'\u{1}';
'\u{1F37A}';

// invalid, single quote
'\foo \bar';

'\400';
'\1000';
'\x1';
'\x1000';
'\u263';
'\u26030';
'\u{}';
'\u{1F37P}';