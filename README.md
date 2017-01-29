# haxe-TmLanguage

[![Build Status](https://travis-ci.org/vshaxe/haxe-TmLanguage.svg?branch=master)](https://travis-ci.org/vshaxe/haxe-TmLanguage)

This repository contains the `.tmLanguage` grammar files for `.hx` and `.hxml` used for syntax highlighting by the [Visual Studio Code extension](https://github.com/vshaxe/vshaxe).

## Haxe example

![Haxe highlighting](images/haxe.png)

## HXML example

![hxml highlighting](images/hxml.png)

## Conversion

The `tmLanguage` XML files are converted from their `YAML-tmLanguage` source files:

```
haxelib install yaml
haxelib git plist https://github.com/back2dos/plisthaxelib
haxe convert.hxml
neko bin/convert.n
```

## Tests

There are some automated tests that can be run like this:

```
haxelib install hxnodejs
npm install vscode-textmate
haxe test.hxml
node bin/build.js
node bin/test.js
```

____________

Alternatively, you can just run `haxe all.hxml`, which does the conversion and then runs the tests. If you have this project open in VSCode, you can just execute the build task (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd>) to execute `all.hxml`.