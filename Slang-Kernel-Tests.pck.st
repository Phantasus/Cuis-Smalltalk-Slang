'From Cuis 5.0 [latest update: #4112] on 1 June 2020 at 12:45:37 pm'!
'Description Contains the tests for the Slang kernel, which provides the base for the Slang transpilation system and Smalltalk dialect.

License: MIT'!
!provides: 'Slang-Kernel-Tests' 1 0!
!requires: 'Slang-Kernel' 1 0 nil!
SystemOrganization addCategory: #'Slang-Kernel-Tests'!


!classDefinition: #SlangParseNodeTest category: #'Slang-Kernel-Tests'!
TestCase subclass: #SlangParseNodeTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel-Tests'!
!classDefinition: 'SlangParseNodeTest class' category: #'Slang-Kernel-Tests'!
SlangParseNodeTest class
	instanceVariableNames: ''!

!classDefinition: #SlangSystemServiceTest category: #'Slang-Kernel-Tests'!
TestCase subclass: #SlangSystemServiceTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel-Tests'!
!classDefinition: 'SlangSystemServiceTest class' category: #'Slang-Kernel-Tests'!
SlangSystemServiceTest class
	instanceVariableNames: ''!

!classDefinition: #SlangTestSupportInterpreter category: #'Slang-Kernel-Tests'!
SlangPlugin subclass: #SlangTestSupportInterpreter
	instanceVariableNames: 'cg inlineFlag primFailCode aVarWithOneReference aVarWithTwoReferences aVariable breakSelector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel-Tests'!
!classDefinition: 'SlangTestSupportInterpreter class' category: #'Slang-Kernel-Tests'!
SlangTestSupportInterpreter class
	instanceVariableNames: ''!

!classDefinition: #SlangTestSupportPlugin category: #'Slang-Kernel-Tests'!
SlangPlugin subclass: #SlangTestSupportPlugin
	instanceVariableNames: 'cg inlineFlag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel-Tests'!
!classDefinition: 'SlangTestSupportPlugin class' category: #'Slang-Kernel-Tests'!
SlangTestSupportPlugin class
	instanceVariableNames: ''!


!SlangTestSupportInterpreter commentStamp: 'dtl 9/19/2010 21:36' prior: 0!
SlangTestSupport implements translatable methods for use in SlangTest unit tests.

	"VMMaker clearCacheEntriesFor: SlangTestSupportInterpreter.
	SlangTestSupportInterpreter asCString"!

!SlangTestSupportPlugin commentStamp: 'dtl 9/19/2010 21:36' prior: 0!
SlangTestSupport implements translatable methods for use in SlangTest unit tests.
This is a subclass of InterpreterPlugin, which provides coverage of slang translation
for base plugins.

	"VMMaker clearCacheEntriesFor: SlangTestSupportPlugin.
	SlangTestSupportPlugin asCString"!

!SlangParseNodeTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/26/2020 20:26:51'!
testIsQuery
	| node |
	node _ usedClass new.
	
	self assert: (node is: #ParseNode).
	self deny: (node is: #Assertion).
	self deny: (node is: #Comment).
	self deny: (node is: #Assignment).
	self deny: (node is: #Constant).
	self deny: (node is: #Inline).
	self deny: (node is: #GoTo).
	self deny: (node is: #Leaf).
	self deny: (node is: #PreprocessorDirective).
	self deny: (node is: #Return).
	self deny: (node is: #ReturningIf).
	self deny: (node is: #Send).
	self deny: (node is: #StatementList).
	self deny: (node is: #Switch).
	self deny: (node is: #Variable).! !

!SlangParseNodeTest methodsFor: 'setUp/tearDown' stamp: 'jpb 5/26/2020 20:21:16'!
setUp
	usedClass _ SlangTParseNode ! !

!SlangSystemServiceTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/20/2020 22:28:19'!
setUp
	usedClass _ SlangSystemAdapter ! !

!SlangSystemServiceTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/19/2020 17:38:02'!
testFindClassDescriptionForClass
	| service expected |
	service _ usedClass new.
	expected _ 'I represent a service for dealing with the Smalltalk system on which Slang is currently running on.'.
	
	self assert: expected equals: (service findClassDescriptionByClass: usedClass)! !

!SlangSystemServiceTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/20/2020 22:37:08'!
testFindSlangDescriptionForClass
	| service |
	service _ usedClass new.
	
	self assert: 'SlangSystemAdapter Slang-Tools'
		 equals: (service findSlangDescriptionBy: usedClass)! !

!SlangTestSupportInterpreter methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 22:21'!
anAbstractMethod

	self subclassResponsibility! !

!SlangTestSupportInterpreter methodsFor: 'other declarations' stamp: 'jpb 5/16/2020 11:07:37'!
doNotGenerateByMethod
	"SlangTestSupportInterpreter asCString: #doNotGenerateByMethod"

	self returnType: #int.
	self doNotGenerate.
	^ 2 + 2
! !

!SlangTestSupportInterpreter methodsFor: 'other declarations' stamp: 'jpb 5/16/2020 23:41:40'!
doNotGenerateByPragma
	"SlangTestSupportInterpreter asCString: #doNotGenerateByPragma"

	<doNotGenerate>
	<returnType: #int>
	^ 2 + 2
! !

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'jpb 5/26/2020 21:55:36'!
asCString

	| stream |
	stream _ ReadWriteStream on: String new.
	self findCodeGenerator emitCCodeOn: stream.
	^ stream contents
! !

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'jpb 5/26/2020 21:01:22'!
asCString: selector

	| method stream |
	method _ self findCodeGenerator methodNamed: selector.
	method ifNil: [^ 'No source has been generated'].
	stream _ ReadWriteStream on: String new.
	method emitCCodeOn: stream generator: cg.
	^ stream contents
! !

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'jpb 5/26/2020 21:01:22'!
findCodeGenerator
	"Lazy initialize, once per test"

	cg ifNil: [
		cg _ self class buildCodeGeneratorInlined: inlineFlag = true.
		cg prepareMethodsInlined: inlineFlag = true doAssertions: true].
	^ cg! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodEmbeddedWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i |
		1 to: self methodWithIntegerResult do: [:k | ]].
! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodTwiceWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i | ].
	1 to: self methodWithIntegerResult do: [:i | ].
! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:37'!
methodWithIntegerResult
	"Translates to nonsense, but use this to illustrate the point"
	^(Random new next * 100) asInteger! !

!SlangTestSupportInterpreter methodsFor: 'export declaration' stamp: 'dtl 4/25/2011 23:00'!
declareExportFalseByMethod
	"SlangTestSupportInterpreter asCString: #declareExportFalseByMethod"

	self export: false
! !

!SlangTestSupportInterpreter methodsFor: 'export declaration' stamp: 'dtl 4/25/2011 23:00'!
declareExportFalseByPragma
	"SlangTestSupportInterpreter asCString: #declareExportFalseByPragma"

	<export: false>
! !

!SlangTestSupportInterpreter methodsFor: 'export declaration' stamp: 'dtl 4/25/2011 23:00'!
declareExportTrueByMethod
	"SlangTestSupportInterpreter asCString: #declareExportTrueByMethod"

	self export: true
! !

!SlangTestSupportInterpreter methodsFor: 'export declaration' stamp: 'dtl 4/25/2011 23:00'!
declareExportTrueByPragma
	"SlangTestSupportInterpreter asCString: #declareExportTrueByPragma"

	<export: true>
! !

!SlangTestSupportInterpreter methodsFor: 'static declaration' stamp: 'dtl 4/25/2011 23:00'!
declareStaticFalseByMethod
	"SlangTestSupportInterpreter asCString: #declareStaticFalseByMethod"

	self static: false
! !

!SlangTestSupportInterpreter methodsFor: 'static declaration' stamp: 'dtl 4/25/2011 23:01'!
declareStaticFalseByPragma
	"SlangTestSupportInterpreter asCString: #declareStaticFalseByPragma"

	<static: false>
! !

!SlangTestSupportInterpreter methodsFor: 'static declaration' stamp: 'dtl 4/25/2011 23:01'!
declareStaticTrueByMethod
	"SlangTestSupportInterpreter asCString: #declareStaticTrueByMethod"

	self static: true
! !

!SlangTestSupportInterpreter methodsFor: 'static declaration' stamp: 'dtl 4/25/2011 23:01'!
declareStaticTrueByPragma
	"SlangTestSupportInterpreter asCString: #declareStaticTrueByPragma"

	<static: true>
! !

!SlangTestSupportInterpreter methodsFor: 'preprocessor directives' stamp: 'dtl 3/10/2013 18:04'!
ifDefinedTrueElseEndif

	self isDefinedTrueExpression: 'SIZE == 8'
		inSmalltalk: [ ^ 4 ]
		comment: 'SIZE may be 4 or 8'
		ifTrue: [ ^8 ]
		ifFalse: [ ^4 ].
	^nil
! !

!SlangTestSupportInterpreter methodsFor: 'preprocessor directives' stamp: 'dtl 3/10/2013 17:05'!
ifdefElseEndif

	self isDefined: 'HAVE_FOO'
		inSmalltalk: [ ^ #defaultBlockForSimulation ]
		comment: 'some platforms do not support foo properly'
		ifTrue: [ ^true ]
		ifFalse: [ ^false ].
	^nil
! !

!SlangTestSupportInterpreter methodsFor: 'preprocessor directives' stamp: 'dtl 3/10/2013 16:47'!
ifdefEndif

	self isDefined: 'HAVE_FOO'
		inSmalltalk: [ ^ #defaultBlockForSimulation ]
		comment: 'some platforms do not support foo properly'
		ifTrue: [ ^ true ].
	^ false
! !

!SlangTestSupportInterpreter methodsFor: 'preprocessor directives' stamp: 'dtl 3/10/2013 16:33'!
preprocessorExpression

	self preprocessorExpression: 'define FOO bar'.
! !

!SlangTestSupportInterpreter methodsFor: 'initialize' stamp: 'dtl 3/18/2013 09:47'!
inline: flag
	inlineFlag _ flag! !

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 4/25/2011 23:01'!
inlineByMethod
	"SlangTestSupportInterpreter asCString: #inlineByMethod"
	"SlangTestSupportInterpreter asInlinedCString: #inlineByMethod"

	| bar foo |
	foo _ self methodThatShouldBeInlinedByMethod.
	bar _ self methodThatShouldNotBeInlinedByMethod! !

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 4/26/2011 18:40'!
inlineByPragma
	"SlangTestSupportInterpreter asCString: #inlineByPragma"
	"SlangTestSupportInterpreter asInlinedCString: #inlineByPragma"

	| bar foo |
	foo _ self methodThatShouldBeInlinedByPragma.
	bar _ self methodThatShouldNotBeInlinedByPragma! !

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 9/18/2010 17:59'!
methodThatShouldBeInlinedByMethod

	self inline: true.
	^ #foo! !

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldBeInlinedByPragma

	<inline: true>
	^ #foo! !

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldNotBeInlinedByMethod

	self inline: false.
	^ #bar! !

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldNotBeInlinedByPragma

	<inline: false>
	^ #bar! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 4/26/2011 07:38'!
methodWithReferenceToAVarWithTwoReferences

	aVarWithTwoReferences _ 'use the variable here also'.
! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 4/26/2011 07:38'!
methodWithReferenceToVariables

	aVarWithOneReference _ 'use the variable in this method only'.
	aVarWithTwoReferences _ 'use the variable in this method and in one other method'.
! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 2/11/2012 17:50'!
setAVariable: oop
	aVariable _ oop! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 7/9/2012 19:49'!
setBreakSelector: aString
	"breakSelector is an instance variable and should not be declared as a local in
	the generated code"
	breakSelector _ aString! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 11/24/2014 22:11'!
sizeOfFoo
	^ self sizeOf: #Foo! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:04:32'!
returnTypeByMethod
	"SlangTestSupportInterpreter asCString: #returnTypeByMethod"

	self returnType: 'char *'.
! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:06:42'!
returnTypeByPragma
	"SlangTestSupportInterpreter asCString: #returnTypeByPragma"

	<returnType: 'char *'>
! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:12:35'!
varDefByMethod
	"SlangTestSupportInterpreter asCString: #varDefByMethod"

	| foo bar |
	self var: #foo type: 'char *'.
	self var: #bar declare: 'unsigned int * bar'
! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:17:46'!
varDefByMethodAndPragma
	"SlangTestSupportInterpreter asCString: #varDefByMethodAndPragma"

	| foo bar baz fum |
	<var: #baz type: 'float'>
	<var: #fum declare: 'double fum'>
	self var: #foo type: 'char *'.
	self var: #bar declare: 'unsigned int * bar'
! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:23:33'!
varDefByPragma
	"SlangTestSupportInterpreter asCString: #varDefByPragma"

	| foo bar |
	<var: #foo type: 'char *'>
	<var: #bar declare: 'unsigned int * bar'>
! !

!SlangTestSupportInterpreter class methodsFor: 'translation' stamp: 'jpb 5/16/2020 20:56:14'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg _ SlangCCodeGeneratorGlobalStructure new initialize.
	cg declareMethodsStatic: false.
	cg permitMethodPruning: true.
	cg uncheckedAbstractMethods addAll: self abstractSelectors.
	
	^self initializeCodeGenerator: cg

! !

!SlangTestSupportInterpreter class methodsFor: 'translation' stamp: 'dtl 8/22/2011 21:06'!
requiredMethodNames
	"return the list of method names that should be retained for export or other support reasons"
	^self selectors
! !

!SlangTestSupportInterpreter class methodsFor: 'translation' stamp: 'jpb 5/16/2020 00:02:58'!
uncheckedAbstractSelectors
	^ super uncheckedAbstractSelectors! !

!SlangTestSupportInterpreter class methodsFor: 'instance creation' stamp: 'dtl 3/18/2013 14:31'!
inline: flag

	"Transcript show: (self inline: true) asCString"

	^self new inline: flag! !

!SlangTestSupportPlugin methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 22:21'!
anAbstractMethod

	self subclassResponsibility! !

!SlangTestSupportPlugin methodsFor: 'other declarations' stamp: 'jpb 5/16/2020 22:30:10'!
doNotGenerateByMethod
	"SlangTestSupportInterpreter asCString: #doNotGenerateByMethod"

	self returnType: #int.
	self doNotGenerate.
	^ 2 + 2
! !

!SlangTestSupportPlugin methodsFor: 'other declarations' stamp: 'jpb 5/16/2020 23:41:44'!
doNotGenerateByPragma
	"SlangTestSupportInterpreter asCString: #doNotGenerateByPragma"

	<doNotGenerate>
	<returnType: #int>
	^ 2 + 2
! !

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'jpb 5/26/2020 21:55:51'!
asCString

	| stream |
	stream _ ReadWriteStream on: String new.
	self findCodeGenerator emitCCodeOn: stream.
	^ stream contents
! !

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'jpb 5/26/2020 21:10:07'!
asCString: selector

	| method stream |
	method _ self findCodeGenerator methodNamed: selector.
	method ifNil: [^ 'No source has been generated'].
	stream _ ReadWriteStream on: String new.
	method emitCCodeOn: stream generator: cg.
	^ stream contents
! !

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'jpb 5/26/2020 21:01:22'!
findCodeGenerator
	"Lazy initialize, once per test"

	cg ifNil: [
		cg _ self class buildCodeGeneratorInlined: inlineFlag = true.
		cg prepareMethodsInlined: inlineFlag = true doAssertions: true].
	^ cg! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodEmbeddedWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i |
		1 to: self methodWithIntegerResult do: [:k | ]].
! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodTwiceWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i | ].
	1 to: self methodWithIntegerResult do: [:i | ].
! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:37'!
methodWithIntegerResult
	"Translates to nonsense, but use this to illustrate the point"
	^(Random new next * 100) asInteger! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 2/18/2014 20:15'!
methodWithLoopLimitThatIsNotModified: arrayObj

	0 to: 10 do: [:i | self storePointerUnchecked: i ofObject: arrayObj withValue: 0]
! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 23:39'!
methodWithLoopLimitThatMightBeModified: arrayObj

	0 to: (self lengthOf: arrayObj) do:
	[:i | self storePointerUnchecked: i ofObject: arrayObj withValue: nil]
! !

!SlangTestSupportPlugin methodsFor: 'export declaration' stamp: 'dtl 9/19/2010 12:29'!
declareExportFalseByMethod
	"SlangTestSupport asCString: #declareExportFalseByMethod"

	self export: false
! !

!SlangTestSupportPlugin methodsFor: 'export declaration' stamp: 'dtl 9/19/2010 12:29'!
declareExportFalseByPragma
	"SlangTestSupport asCString: #declareExportFalseByPragma"

	<export: false>
! !

!SlangTestSupportPlugin methodsFor: 'export declaration' stamp: 'dtl 9/19/2010 12:21'!
declareExportTrueByMethod
	"SlangTestSupport asCString: #declareExportTrueByMethod"

	self export: true
! !

!SlangTestSupportPlugin methodsFor: 'export declaration' stamp: 'dtl 9/19/2010 12:21'!
declareExportTrueByPragma
	"SlangTestSupport asCString: #declareExportTrueByPragma"

	<export: true>
! !

!SlangTestSupportPlugin methodsFor: 'static declaration' stamp: 'dtl 9/19/2010 12:29'!
declareStaticFalseByMethod
	"SlangTestSupport asCString: #declareStaticFalseByMethod"

	self static: false
! !

!SlangTestSupportPlugin methodsFor: 'static declaration' stamp: 'dtl 9/19/2010 12:30'!
declareStaticFalseByPragma
	"SlangTestSupport asCString: #declareStaticFalseByPragma"

	<static: false>
! !

!SlangTestSupportPlugin methodsFor: 'static declaration' stamp: 'dtl 9/19/2010 12:29'!
declareStaticTrueByMethod
	"SlangTestSupport asCString: #declareStaticTrueByMethod"

	self static: true
! !

!SlangTestSupportPlugin methodsFor: 'static declaration' stamp: 'dtl 9/19/2010 12:30'!
declareStaticTrueByPragma
	"SlangTestSupport asCString: #declareStaticTrueByPragma"

	<static: true>
! !

!SlangTestSupportPlugin methodsFor: 'initialize' stamp: 'dtl 3/18/2013 14:48'!
inline: flag
	inlineFlag _ flag! !

!SlangTestSupportPlugin methodsFor: 'inlining' stamp: 'dtl 9/19/2010 11:50'!
inlineByMethod
	"SlangTestSupport asCString: #inlineByMethod"
	"SlangTestSupport asInlinedCString: #inlineByMethod"

	| bar foo |
	foo _ self methodThatShouldBeInlinedByMethod.
	bar _ self methodThatShouldNotBeInlinedByMethod! !

!SlangTestSupportPlugin methodsFor: 'inlining' stamp: 'dtl 9/19/2010 11:50'!
inlineByPragma
	"SlangTestSupport asCString: #inlineByPragma"
	"SlangTestSupport asInlinedCString: #inlineByPragma"

	| bar foo |
	foo _ self methodThatShouldBeInlinedByPragma.
	bar _ self methodThatShouldNotBeInlinedByPragma! !

!SlangTestSupportPlugin methodsFor: 'inlining' stamp: 'dtl 9/18/2010 17:59'!
methodThatShouldBeInlinedByMethod

	self inline: true.
	^ #foo! !

!SlangTestSupportPlugin methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldBeInlinedByPragma

	<inline: true>
	^ #foo! !

!SlangTestSupportPlugin methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldNotBeInlinedByMethod

	self inline: false.
	^ #bar! !

!SlangTestSupportPlugin methodsFor: 'inlining' stamp: 'dtl 9/18/2010 18:01'!
methodThatShouldNotBeInlinedByPragma

	<inline: false>
	^ #bar! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:04:36'!
returnTypeByMethod
	"SlangTestSupport asCString: #returnTypeByMethod"

	self returnType: 'char *'.
! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:06:55'!
returnTypeByPragma
	"SlangTestSupport asCString: #returnTypeByPragma"

	<returnType: 'char *'>
! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:13:08'!
varDefByMethod
	"SlangTestSupport asCString: #varDefByMethod"

	| foo bar |
	self var: #foo type: 'char *'.
	self var: #bar declare: 'unsigned int * bar'
! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:27:40'!
varDefByMethodAndPragma
	"SlangTestSupportPlugin asCString: #varDefByMethodAndPragma"

	| foo bar baz fum |
	<var: #baz type: 'float'>
	<var: #fum declare: 'double fum'>
	self var: #foo type: 'char *'.
	self var: #bar declare: 'unsigned int * bar'
! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'jpb 5/16/2020 23:28:29'!
varDefByPragma
	"SlangTestSupport asCString: #varDefByPragma"

	| foo bar |
	<var: #foo type: 'char *'>
	<var: #bar declare: 'unsigned int * bar'>
! !

!SlangTestSupportPlugin class methodsFor: 'translation' stamp: 'jpb 5/26/2020 20:59:58'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg _ SlangCCodeGenerator new initialize.
	cg declareMethodsStatic: false.
	cg permitMethodPruning: true.
	cg uncheckedAbstractMethods addAll: self abstractSelectors.
	
	^self initializeCodeGenerator: cg

! !

!SlangTestSupportPlugin class methodsFor: 'translation' stamp: 'dtl 8/22/2011 21:06'!
requiredMethodNames
	"return the list of method names that should be retained for export or other support reasons"
	^self selectors
! !

!SlangTestSupportPlugin class methodsFor: 'translation' stamp: 'dtl 3/19/2013 00:44'!
shouldBeTranslated
	"Translated only for unit test support. The generated C module is not expected
	to be compiled."
	^false! !

!SlangTestSupportPlugin class methodsFor: 'instance creation' stamp: 'dtl 3/18/2013 14:49'!
inline: flag

	"Transcript show: (self inline: true) asCString"

	^self new inline: flag! !
