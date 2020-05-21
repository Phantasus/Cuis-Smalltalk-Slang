# Design of Slang

This document describes roughly the design of Slang and the inner
workings of it. So here you get the big picture of how it works.
For the nitty gritty details look into the actual source code,
most methods and classes are documented.

## Parse nodes

Slang uses the Smalltalk compiler to take a class, searches in it
for its methods and parses each method nodes source into an
alternative abstract syntax tree (AST). In fact it first parses
it to the "native" AST node objects and implements on each of
them a method to translate the whole parse tree recursively
into the parse nodes of Slang. Slang describes these nodes as
TMethods where the T stands for translation so TranslationMethods.
The baseclass for this is the `SlangTParseNode`.

## Code generators

Then there are the `SlangCodeGenerator` classes, these specify
the concrete CodeGenerators used for translating the parse node
into a target language (e.g The C programming language) according
to some form of template for the output.
