import sys.io.File;

class Converter {
    static function main() {
        Sys.print("Converting syntax files to plist...");
        convert("haxe.YAML-tmLanguage", "haxe.tmLanguage");
        convert("hxml.YAML-tmLanguage", "hxml.tmLanguage");
        Sys.println(" Done.\n ");
    }

    static function convert(source:String, dest:String) {
        var content = File.getContent(source);
        var parsed = new yaml.Parser().parse(content,
            new yaml.Parser.ParserOptions().useObjects());

        switch (plist.Writer.write(parsed)) {
            case Success(data):
                File.saveContent(dest, data);
            case _: throw "Error";
        }
    }
}