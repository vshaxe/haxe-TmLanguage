import sys.FileSystem;
import sys.io.File;
import Build.GENERATED_DIR;

using StringTools;

// ported and adapted from https://github.com/Microsoft/TypeScript-TmLanguage
class Test {
	static inline var BASELINES_DIR = "baselines";

	static function main() {
		var hasError = false;
		for (file in FileSystem.readDirectory(GENERATED_DIR)) {
			var generatedText = File.getContent('$GENERATED_DIR/$file');
			var baseline = '$BASELINES_DIR/$file';
			if (!FileSystem.exists(baseline)) {
				hasError = true;
				Sys.println('Warning: "$file" has no baseline.');
				continue;
			}
			var baselinesText = File.getContent(baseline);
			if (removeNewlines(generatedText) != removeNewlines(baselinesText)) {
				hasError = true;
				Sys.println('Error: "$file" is not the same as the baseline!');
			}
		}

		Sys.println(" \n" + if (hasError) "Failed!" else "Success.");
		if (hasError)
			Sys.exit(1);
	}

	static function removeNewlines(text:String):String {
		return text.replace('\r\n', '').replace('\n', '');
	}
}
