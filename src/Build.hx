import js.Promise;
import sys.FileSystem;
import sys.io.File;
import VscodeTextmate;

using StringTools;

// ported and adapted from https://github.com/Microsoft/TypeScript-TmLanguage
class Build {
	public static inline var GENERATED_DIR = "generated";
	static inline var CASES_DIR = "cases";
	static inline var MARKER = '^^';

	static function main() {
		// clean the generated dir
		if (FileSystem.exists(GENERATED_DIR)) {
			for (file in FileSystem.readDirectory(GENERATED_DIR))
				FileSystem.deleteFile('$GENERATED_DIR/$file');
		} else {
			FileSystem.createDirectory("generated");
		}

		var registry = new Registry();
		loadGrammar(registry, "haxe.tmLanguage").then(haxeGrammar -> {
			testGrammar(haxeGrammar, ".hx");
			loadGrammar(registry, "hxml.tmLanguage").then(hxmlGrammar -> testGrammar(hxmlGrammar, ".hxml"));
		});
	}

	static function testGrammar(grammar:IGrammar, extension:String) {
		for (fileName in FileSystem.readDirectory(CASES_DIR)) {
			var text = File.getContent('$CASES_DIR/$fileName').replace("\r\n", "\n");
			if (!fileName.endsWith(extension)) {
				continue;
			}
			var result = getScopesAtMarkers(text, grammar);
			if (result.markerScopes != null)
				File.saveContent('$GENERATED_DIR/$fileName.txt', result.markerScopes);
			File.saveContent('$GENERATED_DIR/$fileName.baseline.txt', result.wholeBaseline);
		}
	}

	static function loadGrammar(registry:Registry, path:String):Promise<IGrammar> {
		var rawGrammar = GrammarReader.parseRawGrammar(File.getContent(path), path);
		return registry.addGrammar(rawGrammar);
	}

	static function getScopesAtMarkers(text:String, grammar:IGrammar):{markerScopes:String, wholeBaseline:String} {
		var oriLines = text.split('\n');

		var outputLines = [];
		var cleanLines = [];
		var baselineLines = [];

		var hasMarkers = false;
		var ruleStack = null;
		for (i in 0...oriLines.length) {
			var line = oriLines[i];
			var markerLocations = getMarkerLocations(line);
			if (markerLocations.length > 0) {
				hasMarkers = true;
				line = line.replace(MARKER, "");
			}

			var result = grammar.tokenizeLine(line, ruleStack);
			ruleStack = result.ruleStack;

			cleanLines.push(line);
			outputLines.push(">" + line);
			baselineLines.push(">" + line);

			for (token in result.tokens) {
				for (markerLocation in markerLocations) {
					if (token.startIndex <= markerLocation && markerLocation < token.endIndex)
						writeTokenLine(token, '[' + (i + 1) + ', ' + (markerLocation + 1) + ']: ', ' ', outputLines);
				}
				writeTokenLine(token, "", "", baselineLines);
			}
		}

		return {
			markerScopes: if (hasMarkers) prepareOutput(oriLines, outputLines) else null,
			wholeBaseline: prepareOutput(cleanLines, baselineLines)
		};
	}

	static function getMarkerLocations(str:String):Array<Int> {
		var locations = [];
		var markerLocation = str.indexOf(MARKER);
		while (markerLocation != -1) {
			locations.push(markerLocation);
			str = str.substring(0, markerLocation) + str.substring(markerLocation + MARKER.length);
			markerLocation = str.indexOf(MARKER);
		}
		return locations;
	}

	static function writeTokenLine(token:IToken, preTextForToken:String, postTextForToken:String, outputLines:Array<String>) {
		var startingSpaces = " ";
		for (j in 0...token.startIndex)
			startingSpaces += " ";

		var locatingString = "";
		for (j in token.startIndex...token.endIndex)
			locatingString += "^";

		outputLines.push(startingSpaces + locatingString);
		outputLines.push(startingSpaces + preTextForToken + token.scopes.join(' ') + postTextForToken);
	}

	static inline function prepareOutput(originalLines:Array<String>, outputLines:Array<String>):String {
		return "original file\n-----------------------------------\n" + originalLines.join("\n") + "\n-----------------------------------\n\n" + outputLines
			.join("\n");
	}
}
