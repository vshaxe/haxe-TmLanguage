import js.Promise;

@:jsRequire("vscode-textmate")
extern class GrammarReader {
	static function parseRawGrammar(content:String, filePath:String):IRawGrammar;
}

typedef IRawGrammar = {}

@:jsRequire("vscode-textmate", "Registry")
extern class Registry {
	function new();
	function addGrammar(rawGrammar:IRawGrammar, ?initialLanguage:Int, ?embeddedLanguages:IEmbeddedLanguagesMap):Promise<IGrammar>;
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
