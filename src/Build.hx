import VscodeTextmate;
import haxe.io.Path;
import js.lib.Promise;
import js.node.Fs.Fs;
import sys.FileSystem;
import sys.io.File;

using StringTools;

// ported and adapted from https://github.com/Microsoft/TypeScript-TmLanguage
inline final GENERATED_DIR = "generated";
private inline final CASES_DIR = "cases";
private inline final MARKER = '^^';

function main() {
	// clean the generated dir
	if (FileSystem.exists(GENERATED_DIR)) {
		for (file in FileSystem.readDirectory(GENERATED_DIR))
			FileSystem.deleteFile('$GENERATED_DIR/$file');
	} else {
		FileSystem.createDirectory("generated");
	}

	final wasmPath = "../node_modules/vscode-oniguruma/release/onig.wasm";
	final wasmBin = Fs.readFileSync(Path.join([js.Node.__dirname, wasmPath])).buffer;
	final vscodeOnigurumaLib = Oniguruma.loadWASM(wasmBin).then((_) -> {
		final lib:IOnigLib = {
			createOnigScanner: (sources) -> new OnigScanner(sources),
			createOnigString: (str) -> new OnigString(str)
		};
		return lib;
	});

	final registry = new Registry({
		onigLib: vscodeOnigurumaLib
	});
	loadGrammar(registry, "haxe.tmLanguage").then(haxeGrammar -> {
		testGrammar(haxeGrammar, ".hx");
		loadGrammar(registry, "hxml.tmLanguage").then(hxmlGrammar -> testGrammar(hxmlGrammar, ".hxml"));
	});
}

private function testGrammar(grammar:IGrammar, extension:String) {
	for (fileName in FileSystem.readDirectory(CASES_DIR)) {
		final text = File.getContent('$CASES_DIR/$fileName').replace("\r\n", "\n");
		if (!fileName.endsWith(extension)) {
			continue;
		}
		final result = getScopesAtMarkers(text, grammar);
		if (result.markerScopes != null)
			File.saveContent('$GENERATED_DIR/$fileName.txt', result.markerScopes);
		File.saveContent('$GENERATED_DIR/$fileName.baseline.txt', result.wholeBaseline);
	}
}

private function loadGrammar(registry:Registry, path:String):Promise<IGrammar> {
	final rawGrammar = GrammarReader.parseRawGrammar(File.getContent(path), path);
	return registry.addGrammar(rawGrammar);
}

private function getScopesAtMarkers(text:String, grammar:IGrammar):{markerScopes:String, wholeBaseline:String} {
	final oriLines = text.split('\n');

	final outputLines = [];
	final cleanLines = [];
	final baselineLines = [];

	var hasMarkers = false;
	var ruleStack = null;
	for (i in 0...oriLines.length) {
		var line = oriLines[i];
		final markerLocations = getMarkerLocations(line);
		if (markerLocations.length > 0) {
			hasMarkers = true;
			line = line.replace(MARKER, "");
		}

		final result = grammar.tokenizeLine(line, ruleStack);
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

private function getMarkerLocations(str:String):Array<Int> {
	final locations = [];
	var markerLocation = str.indexOf(MARKER);
	while (markerLocation != -1) {
		locations.push(markerLocation);
		str = str.substring(0, markerLocation) + str.substring(markerLocation + MARKER.length);
		markerLocation = str.indexOf(MARKER);
	}
	return locations;
}

private function writeTokenLine(token:IToken, preTextForToken:String, postTextForToken:String, outputLines:Array<String>) {
	var startingSpaces = " ";
	for (_ in 0...token.startIndex)
		startingSpaces += " ";

	var locatingString = "";
	for (_ in token.startIndex...token.endIndex)
		locatingString += "^";

	outputLines.push(startingSpaces + locatingString);
	outputLines.push(startingSpaces + preTextForToken + token.scopes.join(' ') + postTextForToken);
}

private function prepareOutput(originalLines:Array<String>, outputLines:Array<String>):String {
	return "original file\n-----------------------------------\n" + originalLines.join("\n") + "\n-----------------------------------\n\n"
		+ outputLines.join("\n");
}
