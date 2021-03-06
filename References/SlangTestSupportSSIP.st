'From Squeak5.3 of 3 March 2020 [latest update: #19431] on 23 May 2020 at 6:59:30 pm'!
SmartSyntaxInterpreterPlugin subclass: #SlangTestSupportSSIP
	instanceVariableNames: 'cg inlineFlag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VMMaker-Tests'!
!SlangTestSupportSSIP commentStamp: 'dtl 9/19/2010 11:38' prior: 0!
SlangTestSupportSSIP implements translatable methods for use in SlangTest unit tests.
It is a subclass of SmartSyntaxInterpreterPlugin, which requires additional
test coverage.

	"VMMaker clearCacheEntriesFor: SlangTestSupportSSIP.
	SlangTestSupportSSIP asCString"!


!SlangTestSupportSSIP methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 22:21'!
anAbstractMethod

	self subclassResponsibility! !

!SlangTestSupportSSIP methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 08:19'!
doNotGenerateByMethod
	"SlangTestSupportInterpreter asCString: #doNotGenerateByMethod"

	self returnTypeC: #int.
	self doNotGenerate.
	^ 2 + 2
! !

!SlangTestSupportSSIP methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 08:11'!
doNotGenerateByPragma
	"SlangTestSupportInterpreter asCString: #doNotGenerateByPragma"

	<doNotGenerate>
	<returnTypeC: #int>
	^ 2 + 2
! !


!SlangTestSupportSSIP methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:28'!
asCString

	| stream |
	stream := ReadWriteStream on: String new.
	self cg emitCCodeOn: stream doAssertions: true.
	^ stream contents
! !

!SlangTestSupportSSIP methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:29'!
asCString: selector

	| method stream |
	method := self cg methodNamed: selector.
	method ifNil: [^ 'No source has been generated'].
	stream := ReadWriteStream on: String new.
	method emitCCodeOn: stream generator: cg.
	^ stream contents
! !

!SlangTestSupportSSIP methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:28'!
cg
	"Lazy initialize, once per test"

	cg ifNil: [ObjectMemory initialize; initializeConstants.
		cg := self class buildCodeGeneratorInlined: inlineFlag = true.
		cg prepareMethodsInlined: inlineFlag = true doAssertions: true].
	^ cg! !


!SlangTestSupportSSIP methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodEmbeddedWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i |
		1 to: self methodWithIntegerResult do: [:k | ]].
! !

!SlangTestSupportSSIP methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:49'!
callMethodTwiceWithLoopLimitThatMightBeModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatMightBeModified: aVar.
	self methodWithLoopLimitThatMightBeModified: aVar.
! !

!SlangTestSupportSSIP methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodTwiceWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i | ].
	1 to: self methodWithIntegerResult do: [:i | ].
! !

!SlangTestSupportSSIP methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:51'!
callMethodWithLoopLimitThatIsNotModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatIsNotModified: aVar.
! !

!SlangTestSupportSSIP methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:49'!
callMethodWithLoopLimitThatMightBeModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatMightBeModified: aVar.
! !

!SlangTestSupportSSIP methodsFor: 'loop limits' stamp: 'dtl 4/5/2013 00:01'!
methodWithIntegerResult
	^127 + 5! !

!SlangTestSupportSSIP methodsFor: 'loop limits' stamp: 'dtl 2/18/2014 20:15'!
methodWithLoopLimitThatIsNotModified: arrayObj

	0 to: 10 do: [:i | self storePointerUnchecked: i ofObject: arrayObj withValue: 0]
! !

!SlangTestSupportSSIP methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 23:39'!
methodWithLoopLimitThatMightBeModified: arrayObj

	0 to: (self lengthOf: arrayObj) do:
	[:i | self storePointerUnchecked: i ofObject: arrayObj withValue: nil]
! !


!SlangTestSupportSSIP methodsFor: 'export declaration' stamp: 'dtl 9/19/2010 12:29'!
declareExportFalseByMethod
	"SlangTestSupportSSIP asCString: #declareExportFalseByMethod"

	self export: false
! !

!SlangTestSupportSSIP methodsFor: 'export declaration' stamp: 'dtl 9/19/2010 12:29'!
declareExportFalseByPragma
	"SlangTestSupportSSIP asCString: #declareExportFalseByPragma"

	<export: false>
! !

!SlangTestSupportSSIP methodsFor: 'export declaration' stamp: 'dtl 9/19/2010 12:21'!
declareExportTrueByMethod
	"SlangTestSupportSSIP asCString: #declareExportTrueByMethod"

	self export: true
! !

!SlangTestSupportSSIP methodsFor: 'export declaration' stamp: 'dtl 9/19/2010 12:21'!
declareExportTrueByPragma
	"SlangTestSupportSSIP asCString: #declareExportTrueByPragma"

	<export: true>
! !


!SlangTestSupportSSIP methodsFor: 'parameter declarations' stamp: 'dtl 3/8/2013 19:40'!
declareInt: anInt wordPointer: pointerToWords
	"The pointerToWords parameter should be (unsigned *) as a result of the WordArray
	declaration in primitive:parameters: and the local declaration for pointerToWords should
	match this data type. For buggy code generator this is not the case."

	self var: #pointerToWords type: 'unsigned char * '. "intentional red herring, no effect"
	self primitive: 'primitiveShowHostWindowRect' parameters: #(SmallInteger WordArray).

	"Incorrect output, demonstrating code generator bug:
	
EXPORT(sqInt) primitiveShowHostWindowRect(void) {
	sqInt anInt;
	usqInt *pointerToWords;

	anInt = interpreterProxy->stackIntegerValue(1);
	interpreterProxy->success(interpreterProxy->isWords(interpreterProxy->stackValue(0)));
	pointerToWords = ((unsigned *) (interpreterProxy->firstIndexableField(interpreterProxy->stackValue(0))));
	if (interpreterProxy->failed()) {
		return null;
	}
	if (interpreterProxy->failed()) {
		return null;
	}
	interpreterProxy->pop(2);
	return null;
}
"! !


!SlangTestSupportSSIP methodsFor: 'static declaration' stamp: 'dtl 9/19/2010 12:29'!
declareStaticFalseByMethod
	"SlangTestSupportSSIP asCString: #declareStaticFalseByMethod"

	self static: false
! !

!SlangTestSupportSSIP methodsFor: 'static declaration' stamp: 'dtl 9/19/2010 12:30'!
declareStaticFalseByPragma
	"SlangTestSupportSSIP asCString: #declareStaticFalseByPragma"

	<static: false>
! !

!SlangTestSupportSSIP methodsFor: 'static declaration' stamp: 'dtl 9/19/2010 12:29'!
declareStaticTrueByMethod
	"SlangTestSupportSSIP asCString: #declareStaticTrueByMethod"

	self static: true
! !

!SlangTestSupportSSIP methodsFor: 'static declaration' stamp: 'dtl 9/19/2010 12:30'!
declareStaticTrueByPragma
	"SlangTestSupportSSIP asCString: #declareStaticTrueByPragma"

	<static: true>
! !


!SlangTestSupportSSIP methodsFor: 'initialize' stamp: 'dtl 3/18/2013 14:54'!
inline: flag
	inlineFlag := flag! !


!SlangTestSupportSSIP methodsFor: 'inlining' stamp: 'dtl 9/19/2010 11:50'!
inlineByMethod
	"SlangTestSupportSSIP asCString: #inlineByMethod"
	"SlangTestSupportSSIP asInlinedCString: #inlineByMethod"

	| bar foo |
	foo := self methodThatShouldBeInlinedByMethod.
	bar := self methodThatShouldNotBeInlinedByMethod! !

!SlangTestSupportSSIP methodsFor: 'inlining' stamp: 'dtl 9/19/2010 11:50'!
inlineByPragma
	"SlangTestSupportSSIP asCString: #inlineByPragma"
	"SlangTestSupportSSIP asInlinedCString: #inlineByPragma"

	| bar foo |
	foo := self methodThatShouldBeInlinedByPragma.
	bar := self methodThatShouldNotBeInlinedByPragma! !

!SlangTestSupportSSIP methodsFor: 'inlining' stamp: 'dtl 9/18/2010 17:59'!
methodThatShouldBeInlinedByMethod

	self inline: true.
	^ #foo! !

!SlangTestSupportSSIP methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldBeInlinedByPragma

	<inline: true>
	^ #foo! !

!SlangTestSupportSSIP methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldNotBeInlinedByMethod

	self inline: false.
	^ #bar! !

!SlangTestSupportSSIP methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldNotBeInlinedByPragma

	<inline: false>
	^ #bar! !


!SlangTestSupportSSIP methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 11:50'!
returnTypeByMethod
	"SlangTestSupportSSIP asCString: #returnTypeByMethod"

	self returnTypeC: 'char *'.
! !

!SlangTestSupportSSIP methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 11:51'!
returnTypeByPragma
	"SlangTestSupportSSIP asCString: #returnTypeByPragma"

	<returnTypeC: 'char *'>
! !

!SlangTestSupportSSIP methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 11:51'!
varDefByMethod
	"SlangTestSupportSSIP asCString: #varDefByMethod"

	| foo bar |
	self var: #foo type: 'char *'.
	self var: #bar declareC: 'unsigned int * bar'
! !

!SlangTestSupportSSIP methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 22:25'!
varDefByMethodAndPragma
	"SlangTestSupportSSIP asCString: #varDefByMethodAndPragma"

	| foo bar baz fum |
	<var: #baz type: 'float'>
	<var: #fum declareC: 'double fum'>
	self var: #foo type: 'char *'.
	self var: #bar declareC: 'unsigned int * bar'
! !

!SlangTestSupportSSIP methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 12:05'!
varDefByPragma
	"SlangTestSupportSSIP asCString: #varDefByPragma"

	| foo bar |
	<var: #foo type: 'char *'>
	<var: #bar declareC: 'unsigned int * bar'>
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SlangTestSupportSSIP class
	instanceVariableNames: ''!

!SlangTestSupportSSIP class methodsFor: 'translation' stamp: 'dtl 3/18/2013 18:52'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg := SmartSyntaxPluginCodeGenerator new initialize.
	cg declareMethodsStatic: false.
	cg permitMethodPruning: true.
	cg uncheckedAbstractMethods addAll: self abstractSelectors.
	^self initializeCodeGenerator: cg

! !

!SlangTestSupportSSIP class methodsFor: 'translation' stamp: 'dtl 8/22/2011 21:06'!
requiredMethodNames
	"return the list of method names that should be retained for export or other support reasons"
	^self selectors
! !

!SlangTestSupportSSIP class methodsFor: 'translation' stamp: 'dtl 3/19/2013 00:44'!
shouldBeTranslated
	"Translated only for unit test support. The generated C module is not expected
	to be compiled."
	^false! !


!SlangTestSupportSSIP class methodsFor: 'instance creation' stamp: 'dtl 3/18/2013 14:49'!
inline: flag

	"Transcript show: (self inline: true) asCString"

	^self new inline: flag! !
