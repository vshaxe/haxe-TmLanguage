import js.lib.ArrayBuffer;
import js.lib.Promise;

@:jsRequire("vscode-textmate")
extern class GrammarReader {
	static function parseRawGrammar(content:String, ?filePath:String):IRawGrammar;
}

typedef IRawGrammar = {}

@:jsRequire("vscode-textmate", "Registry")
extern class Registry {
	function new(options:{
		onigLib:Promise<IOnigLib>,
		// theme?: IRawTheme;
		// colorMap?: string[];
		// loadGrammar(scopeName: string): Promise<IRawGrammar | undefined | null>;
		// getInjections?(scopeName: string): string[] | undefined;
	});
	function addGrammar(rawGrammar:IRawGrammar, ?initialLanguage:Int, ?embeddedLanguages:IEmbeddedLanguagesMap):Promise<IGrammar>;
}

typedef IOnigLib = {
	function createOnigScanner(sources:Array<String>):OnigScanner;
	function createOnigString(str:String):OnigString;
}

@:jsRequire("vscode-oniguruma")
extern class Oniguruma {
	static function loadWASM(bin:ArrayBuffer):Promise<Void>;
}

@:jsRequire("vscode-oniguruma", "OnigScanner")
extern class OnigScanner {
	function new(sources:Array<String>);
	// findNextMatchSync(string:string | OnigString, startPosition:number):IOnigMatch;
}

@:jsRequire("vscode-oniguruma", "OnigString")
extern class OnigString {
	function new(str:String);
	// readonly content:string;
	// readonly dispose ? : () => void;
}

typedef IEmbeddedLanguagesMap = {}

typedef IGrammar = {
	function tokenizeLine(lineText:String, ?prevState:StackElement):ITokenizeLineResult;
}

typedef ITokenizeLineResult = {
	var tokens(default, null):Array<IToken>;
	var ruleStack(default, null):StackElement;
}

typedef IToken = {
	var startIndex:Int;
	var endIndex(default, null):Int;
	var scopes(default, null):Array<String>;
}

typedef StackElement = {}
