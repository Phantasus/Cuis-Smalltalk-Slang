'From Cuis 5.0 [latest update: #4112] on 26 May 2020 at 7:10:19 pm'!
'Description License: MIT'!
!provides: 'Slang-Tools-Tests' 1 2!
SystemOrganization addCategory: #'Slang-Tools-Tests'!


!classDefinition: #SlangCCodeGeneratorTest category: #'Slang-Tools-Tests'!
TestCase subclass: #SlangCCodeGeneratorTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangCCodeGeneratorTest class' category: #'Slang-Tools-Tests'!
SlangCCodeGeneratorTest class
	instanceVariableNames: ''!

!classDefinition: #SlangCLanguageWriterTest category: #'Slang-Tools-Tests'!
TestCase subclass: #SlangCLanguageWriterTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangCLanguageWriterTest class' category: #'Slang-Tools-Tests'!
SlangCLanguageWriterTest class
	instanceVariableNames: ''!

!classDefinition: #SlangCTypeRepositoryTest category: #'Slang-Tools-Tests'!
TestCase subclass: #SlangCTypeRepositoryTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangCTypeRepositoryTest class' category: #'Slang-Tools-Tests'!
SlangCTypeRepositoryTest class
	instanceVariableNames: ''!

!classDefinition: #SlangSystemServiceTest category: #'Slang-Tools-Tests'!
TestCase subclass: #SlangSystemServiceTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangSystemServiceTest class' category: #'Slang-Tools-Tests'!
SlangSystemServiceTest class
	instanceVariableNames: ''!

!classDefinition: #SlangTest category: #'Slang-Tools-Tests'!
TestCase subclass: #SlangTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangTest class' category: #'Slang-Tools-Tests'!
SlangTest class
	instanceVariableNames: ''!

!classDefinition: #SlangTestSupportInterpreter category: #'Slang-Tools-Tests'!
SlangPlugin subclass: #SlangTestSupportInterpreter
	instanceVariableNames: 'cg inlineFlag primFailCode aVarWithOneReference aVarWithTwoReferences aVariable breakSelector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangTestSupportInterpreter class' category: #'Slang-Tools-Tests'!
SlangTestSupportInterpreter class
	instanceVariableNames: ''!

!classDefinition: #SlangTestSupportPlugin category: #'Slang-Tools-Tests'!
SlangPlugin subclass: #SlangTestSupportPlugin
	instanceVariableNames: 'cg inlineFlag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangTestSupportPlugin class' category: #'Slang-Tools-Tests'!
SlangTestSupportPlugin class
	instanceVariableNames: ''!


!SlangCCodeGeneratorTest commentStamp: '<historical>' prior: 0!
I test the generic C code generator!

!SlangTest commentStamp: 'dtl 9/18/2010 17:43' prior: 0!
The SlangTest tests verify code generation and inlining.
!

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

!SlangCCodeGeneratorTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/19/2020 16:01:41'!
setUp
	usedClass _ SlangCCodeGenerator! !

!SlangCLanguageWriterTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/20/2020 18:03:07'!
setUp
	usedClass _ SlangCLanguageWriter ! !

!SlangCLanguageWriterTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/20/2020 18:18:17'!
testFindIntegerLiteral
	| helper |
	helper _ usedClass.
	
	self assert: '10' equals: (helper findIntegerLiteral: 10).
	self assert: '0xFFFFFFFFU' equals: (helper findIntegerLiteral: 16rFFFFFFFF).
	self assert: '0x100000000ULL' equals: (helper findIntegerLiteral: 16rFFFFFFFF + 1).! !

!SlangCLanguageWriterTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/20/2020 21:35:05'!
testWritingConstants
	| writer buffer |
	buffer _ '' writeStream.
	writer _ usedClass on: buffer.
	
	writer nextPutConstantNamed: 'foo' value: 123.
	self assert: '#define foo 123' equals: buffer contents.! !

!SlangCLanguageWriterTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/24/2020 16:17:36'!
testWritingIncludes
	| writer buffer |
	buffer _ '' writeStream.
	writer _ usedClass on: buffer.
	
	writer nextPutInclude: 'foo'.
	self assert: '#include <foo.h>' equals: buffer contents.! !

!SlangCLanguageWriterTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/24/2020 16:18:06'!
testWritingLocalIncludes
	| writer buffer |
	buffer _ '' writeStream.
	writer _ usedClass on: buffer.
	
	writer nextPutLocalInclude: 'foo'.
	self assert: '#include "foo.h"' equals: buffer contents.! !

!SlangCTypeRepositoryTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 18:43:11'!
makeRepository.
	^usedClass new	! !

!SlangCTypeRepositoryTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 18:41:38'!
setUp
	usedClass _ SlangCTypeRepository ! !

!SlangCTypeRepositoryTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 18:42:55'!
testFindBaseTypeForType
	| repository |
	repository _ self makeRepository.
	
	self assert: (repository findBaseTypeForType: 'int') isNil! !

!SlangCTypeRepositoryTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 18:45:35'!
testFindStructTargetKindForDeclaration
	| repository |
	repository _ self makeRepository.
	
	self assert: (repository findStructTargetKindForDeclaration: nil) isNil.
	self assert: (repository findStructTargetKindForDeclaration: 'int') isNil.! !

!SlangCTypeRepositoryTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 18:48:20'!
testFindTypeForDeclarationLookup
	| repository |
	repository _ self makeRepository.
	
	self assert: 'int' equals: (repository findTypeFor: 'foo' fromDeclaration: 'int foo').
	self assert: 'char*' equals: (repository findTypeFor: 'squeak' fromDeclaration: 'static char* squeak').! !

!SlangCTypeRepositoryTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 18:50:10'!
testIsTypeStruct
	| repository |
	repository _ self makeRepository.
	
	self deny: (repository isTypeStruct: 'int').
	self deny: (repository isTypeStruct: nil).
	self deny: (repository isTypeStruct: 'char *').
	! !

!SlangCTypeRepositoryTest methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 18:50:50'!
testIsTypedPointerToStruct
	| repository |
	repository _ self makeRepository.
	
	self deny: (repository isTypedPointerToStruct: 'int').
	self deny: (repository isTypedPointerToStruct: nil).
	self deny: (repository isTypedPointerToStruct: 'char *').
	! !

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

!SlangTest methodsFor: 'running' stamp: 'dtl 3/18/2013 18:48'!
setUp

	"Some of the test may be long running when SlangTestSupport is a subclass
	of ObjectMemory."
	(self respondsTo: #timeout: ) "Recent Squeak images with test case timeout"
		ifTrue: [self perform: #timeout: with: 30].
! !

!SlangTest methodsFor: 'testing variable declaration' stamp: 'jpb 5/16/2020 11:12:32'!
testIvarShouldNotBeRedeclaredAsLocal
	"Document a bug in some versions of the code generator. If an instance variable is
	referenced in the generated code, that variable should not be declared as a local
	in the function."

	| stssi s |
	stssi _ SlangTestSupportInterpreter inline: false.
	s _ stssi asCString: #setBreakSelector: .
	
	self deny: (s includesSubString: 'sqInt breakSelector;')
! !

!SlangTest methodsFor: 'testing variable declaration' stamp: 'dtl 11/25/2014 19:57'!
testLiteralName
	"sizeOf: #Foo should translated to C function call sizeof(Foo), where Foo is a literal, not a string"

	| stssi s |
	stssi _ SlangTestSupportInterpreter inline: false.
	s _ stssi asCString: #sizeOfFoo .
	self assert: (s includesSubString: 'sizeOf(Foo)').
	self deny: (s includesSubString: 'sizeOf("Foo")').

! !

!SlangTest methodsFor: 'testing variable declaration' stamp: 'dtl 3/18/2013 14:38'!
testLocalizeGlobalVariables
	"CCodeGenerator>>localizeGlobalVariables performs an optimization
	that may be misleading when introducing a new method. This test
	documents that optimization.
	
	If a method makes reference to an instance variable, and if this is the
	only method containing a reference to that variable, then the C translator
	will produce a local variable declaration in the generated function, and no
	global declaration will appear in the generated source file. This optimization
	is applied after inlining has been performed, so there are legitimate cases
	where a variable must be an instance variable referenced by two methods,
	but can be made local if those methods are inlined into a single method
	and only one method reference to the variable remains. See
	ObjectMemory>>markAndSweep: for an example."

	| stssi s |
	stssi _ SlangTestSupportInterpreter inline: false.
	s _ stssi asCString: #methodWithReferenceToVariables .
	"variable with one method reference is promoted to a local method variable"
	self assert: (s includesSubString: 'sqInt aVarWithOneReference;').
	"normal expected behavior, the variable is global in the generated source module."
	self deny: (s includesSubString: 'sqInt aVarWithTwoReferences;')
! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'jpb 5/16/2020 21:14:18'!
testInterpDeclareExport
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stssi m p |
	stssi _ SlangTestSupportInterpreter inline: false.
	m _ (stssi asCString: #declareExportTrueByMethod)
			copyReplaceAll: 'declareExportTrueByMethod'
			with: 'methodName'.
			
	p _ (stssi asCString: #declareExportTrueByPragma)
			copyReplaceAll: 'declareExportTrueByPragma'
			with: 'methodName'.
			
	self assert: m = p.

	m _ (stssi asCString: #declareExportFalseByMethod)
			copyReplaceAll: 'declareExportFalseByMethod'
			with: 'methodName'.
			
	p _ (stssi asCString: #declareExportFalseByPragma)
			copyReplaceAll: 'declareExportFalseByPragma'
			with: 'methodName'.
			
	self assert: m = p.! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 09:50'!
testInterpDeclareInline
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stssi m p |
	stssi _ SlangTestSupportInterpreter inline: true.
	m _ ((stssi asCString: #inlineByMethod)
			copyReplaceAll: 'inlineByMethod'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByMethod'
				with: 'calledMethodName'.
	p _ ((stssi asCString: #inlineByPragma)
			copyReplaceAll: 'inlineByPragma'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByPragma'
				with: 'calledMethodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 09:54'!
testInterpDeclareStatic
	"A static directive should cause the generated function to be declared static."

	| stssi m1 p1 m2 p2 |
	stssi _ SlangTestSupportInterpreter inline: false.
	m1 _ (stssi asCString: #declareStaticTrueByMethod)
			copyReplaceAll: 'declareStaticTrueByMethod'
			with: 'methodName'.
	p1 _ (stssi asCString: #declareStaticTrueByPragma)
			copyReplaceAll: 'declareStaticTrueByPragma'
			with: 'methodName'.
	self assert: m1 = p1.

	m2 _ (stssi asCString: #declareStaticFalseByMethod)
			copyReplaceAll: 'declareStaticFalseByMethod'
			with: 'methodName'.
	p2 _ (stssi asCString: #declareStaticFalseByPragma)
			copyReplaceAll: 'declareStaticFalseByPragma'
			with: 'methodName'.
	self assert: m2 = p2.

	"verify that the keyword 'static appears in the generated C source"
	self assert: (m1 includesSubString: 'static').
	self assert: (p1 includesSubString: 'static').
	self deny: (m2 includesSubString: 'static').
	self deny: (p2 includesSubString: 'static')
! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:33'!
testInterpDoNotdoNotGenerateByMethod
	"A doNotdoNotGenerate statement should prevent code generation"

	"(SlangTest selector: #testInterpDoNotdoNotGenerateByMethod) debug"

	| stssi m |
	stssi _ SlangTestSupportInterpreter inline: false.
	self assert: (SlangTestSupportInterpreter canUnderstand: #doNotGenerateByMethod).
	m _ stssi asCString: #doNotGenerateByMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stssi asCString includesSubString: 'doNotGenerateByMethod').
	self assert: (stssi doNotGenerateByMethod = 4)

! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'jpb 5/16/2020 00:23:41'!
testInterpDoNotdoNotGenerateByPragma
	"A <doNotdoNotGenerate> declaration should prevent code generation"

	| stssi m |
	stssi _ SlangTestSupportInterpreter inline: false.
	self assert: (SlangTestSupportInterpreter canUnderstand: #doNotGenerateByPragma).
	m _ stssi asCString: #doNotGenerateByPragma.
	
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stssi asCString includesSubString: 'doNotGenerateByPragma').
	self assert: (stssi doNotGenerateByPragma = 4)
! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:24'!
testInterpDoNotdoNotGenerateSubclassResponsibility
	"If a method contains self subclassResponsibility, assume it is not meant for translation."

	| stssi m |
	stssi _ SlangTestSupportInterpreter inline: false.
	self assert: (SlangTestSupportInterpreter canUnderstand: #anAbstractMethod).
	m _ stssi asCString: #anAbstractMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stssi asCString includesSubString: 'anAbstractMethod').
	self should: [stssi anAbstractMethod]
		raise: Error

! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:36'!
testInterpMixedMethodAndPragmaDeclarations
	"Pragmas and method declarations should coexist"

	| stssi s |
	stssi _ SlangTestSupportInterpreter inline: false.
	s _ (stssi asCString: #varDefByMethodAndPragma)
			copyReplaceAll: 'varDefByMethod'
			with: 'methodName'.
	self assert: (s includesSubString: 'unsigned int * bar').
	self assert: (s includesSubString: 'char *foo').
	self assert: (s includesSubString: 'float baz').
	self assert: (s includesSubString: 'double fum').
! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:37'!
testInterpReturnTypeC
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stssi m p |
	stssi _ SlangTestSupportInterpreter inline: false.
	m _ (stssi asCString: #returnTypeByMethod)
			copyReplaceAll: 'returnTypeByMethod'
			with: 'methodName'.
	p _ (stssi asCString: #returnTypeByPragma)
			copyReplaceAll: 'returnTypeByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:38'!
testInterpTypeDeclarations
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stssi m p |
	stssi _ SlangTestSupportInterpreter inline: false.
	m _ (stssi asCString: #varDefByMethod)
			copyReplaceAll: 'varDefByMethod'
			with: 'methodName'.
	p _ (stssi asCString: #varDefByPragma)
			copyReplaceAll: 'varDefByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing preprocessor directives' stamp: 'dtl 3/18/2013 09:49'!
testIfElseEndif
	"Test isDefinedTrueExpression:inSmalltalk:comment:ifTrue:ifFalse: "

	"(SlangTest selector: #testIfElseEndif) run"

	| stssi cString stringWithoutWhiteSpace lines |
	stssi _ SlangTestSupportInterpreter inline: false.

	"verify that the default Smalltalk block that is evaluated in simulation"
	self assert: stssi ifDefinedTrueElseEndif = 4.

	"verify generated C string"
	cString _ stssi asCString: #ifDefinedTrueElseEndif.
	lines _ (cString findTokens: Character cr) select: [:e |
		{
			'# if (SIZE == 8)  // SIZE may be 4 or 8' .
			'	return 8;' .
			'# else' .
			'	return 4;' .
			'# endif  // SIZE == 8'
		} includes: e ].
	self should: lines size = 5.
	self should: ('*return 8*' match: lines second).
	self should: ('*return 4*' match: lines fourth).

	"check the rest of the method, ignoring whitespace"
	cString _ stssi asCString: #ifDefinedTrueElseEndif.
	stringWithoutWhiteSpace _ cString reject: [:e | e isSeparator].
	self should: stringWithoutWhiteSpace =
		'sqIntifDefinedTrueElseEndif(void){#if(SIZE==8)//SIZEmaybe4or8return8;#elsereturn4;#endif//SIZE==8returnnull;}'.

"
sqInt ifDefinedTrueElseEndif(void) {
	
# if (SIZE == 8)  // SIZE may be 4 or 8
	return 8;
# else
	return 4;
# endif  // SIZE == 8
	
	return null;
}
"! !

!SlangTest methodsFor: 'testing preprocessor directives' stamp: 'dtl 3/18/2013 09:49'!
testIfdefElseEndif
	"Test isDefined:inSmalltalk:comment:ifTrue:ifFalse: "

	"(SlangTest selector: #testIfdefElseEndif) run"

	| stssi cString stringWithoutWhiteSpace lines |
	self flag: #FIXME. "See redundant implementation in oscog #cppIf:ifTrue:ifFalse:"

	stssi _ SlangTestSupportInterpreter inline: false.

	"verify that the default Smalltalk block that is evaluated in simulation"
	self assert: stssi ifdefElseEndif = #defaultBlockForSimulation.

	"verify generated C string"
	cString _ stssi asCString: #ifdefElseEndif.
	lines _ (cString findTokens: Character cr) select: [:e |
		{
			'# ifdef HAVE_FOO  // some platforms do not support foo properly' .
			'	return 1;' .
			'# else' .
			'	return 0;' .
			'# endif  // HAVE_FOO'
		} includes: e ].
	self should: lines size = 5.
	self should: ('*return 1*' match: lines second).
	self should: ('*return 0*' match: lines fourth).

	"check the rest of the method, ignoring whitespace"
	stringWithoutWhiteSpace _ cString reject: [:e | e isSeparator].
	self should: stringWithoutWhiteSpace =
		'sqIntifdefElseEndif(void){#ifdefHAVE_FOO//someplatformsdonotsupportfooproperlyreturn1;#elsereturn0;#endif//HAVE_FOOreturnnull;}'.

"
sqInt ifdefElseEndif(void) {
	
# ifdef HAVE_FOO  // some platforms do not support foo properly
	return 1;
# else
	return 0;
# endif  // HAVE_FOO
	
	return null;
}
"! !

!SlangTest methodsFor: 'testing preprocessor directives' stamp: 'dtl 3/18/2013 09:49'!
testIfdefEndif
	"Test isDefined:inSmalltalk:comment:ifTrue: "

	"(SlangTest selector: #testIfdefEndif) run"

	| stssi cString stringWithoutWhiteSpace lines |
	self flag: #FIXME. "See redundant implementation in oscog #cppIf:ifTrue:"

	stssi _ SlangTestSupportInterpreter inline: false.

	"verify that the default Smalltalk block that is evaluated in simulation"
	self assert: stssi ifdefEndif = #defaultBlockForSimulation.

	"verify generated C string"
	cString _ stssi asCString: #ifdefEndif.
	lines _ (cString findTokens: Character cr) select: [:e |
		{
			'# ifdef HAVE_FOO  // some platforms do not support foo properly' .
			'	return 1;' .
			'# endif  // HAVE_FOO'
		} includes: e ].
	self should: lines size = 3.

	"check the rest of the method, ignoring whitespace"
	cString _ stssi asCString: #ifdefEndif.
	stringWithoutWhiteSpace _ cString reject: [:e | e isSeparator].
	self should: stringWithoutWhiteSpace =
		'sqIntifdefEndif(void){#ifdefHAVE_FOO//someplatformsdonotsupportfooproperlyreturn1;#endif//HAVE_FOOreturn0;}'.

"
sqInt ifdefEndif(void) {
	
# ifdef HAVE_FOO  // some platforms do not support foo properly
	return 1;
# endif  // HAVE_FOO
	
	return 0;
}
"! !

!SlangTest methodsFor: 'testing preprocessor directives' stamp: 'jpb 5/16/2020 00:22:59'!
testPreprocessorExpression
	"Test preprocessorExpression: "

	"(SlangTest selector: #testPreprocessorExpression) run"

	| stssi cString |
	self flag: #FIXME. "See redundant implementation in oscog #cPreprocessorDirective: "

	stssi _ SlangTestSupportInterpreter inline: false.
	cString _ stssi asCString: #preprocessorExpression.
	
	self should: ('* define FOO bar*' match: cString).
	self should: ((cString findTokens: Character cr) select: [:e | e = '# define FOO bar' ]) size = 1.
	self should: ((cString findTokens: Character cr) select: [:e | e = '## define FOO bar' ]) size = 0.
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:32'!
testPluginDeclareExport
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stsp m p |
	stsp _ SlangTestSupportPlugin inline: false.
	m _ (stsp asCString: #declareExportTrueByMethod)
			copyReplaceAll: 'declareExportTrueByMethod'
			with: 'methodName'.
	p _ (stsp asCString: #declareExportTrueByPragma)
			copyReplaceAll: 'declareExportTrueByPragma'
			with: 'methodName'.
	self assert: m = p.

	m _ (stsp asCString: #declareExportFalseByMethod)
			copyReplaceAll: 'declareExportFalseByMethod'
			with: 'methodName'.
	p _ (stsp asCString: #declareExportFalseByPragma)
			copyReplaceAll: 'declareExportFalseByPragma'
			with: 'methodName'.
	self assert: m = p.! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:34'!
testPluginDeclareInline
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stsp m p |
	stsp _ SlangTestSupportPlugin inline: true.
	m _ ((stsp asCString: #inlineByMethod)
			copyReplaceAll: 'inlineByMethod'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByMethod'
				with: 'calledMethodName'.
	p _ ((stsp asCString: #inlineByPragma)
			copyReplaceAll: 'inlineByPragma'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByPragma'
				with: 'calledMethodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:35'!
testPluginDeclareStatic
	"A static directive should cause the generated function to be declared static."

	| stsp m1 p1 m2 p2 |
	stsp _ SlangTestSupportPlugin inline: false.
	m1 _ (stsp asCString: #declareStaticTrueByMethod)
			copyReplaceAll: 'declareStaticTrueByMethod'
			with: 'methodName'.
	p1 _ (stsp asCString: #declareStaticTrueByPragma)
			copyReplaceAll: 'declareStaticTrueByPragma'
			with: 'methodName'.
	self assert: m1 = p1.

	m2 _ (stsp asCString: #declareStaticFalseByMethod)
			copyReplaceAll: 'declareStaticFalseByMethod'
			with: 'methodName'.
	p2 _ (stsp asCString: #declareStaticFalseByPragma)
			copyReplaceAll: 'declareStaticFalseByPragma'
			with: 'methodName'.
	self assert: m2 = p2.

	"verify that the keyword 'static appears in the generated C source"
	self assert: (m1 includesSubString: 'static').
	self assert: (p1 includesSubString: 'static').
	self deny: (m2 includesSubString: 'static').
	self deny: (p2 includesSubString: 'static')
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'jpb 5/16/2020 11:11:15'!
testPluginDoNotGenerateByMethod
	"A doNotdoNotGenerate statement should prevent code generation"

	| stsp m |
	stsp _ SlangTestSupportPlugin inline: false.
	self assert: (SlangTestSupportPlugin canUnderstand: #doNotGenerateByMethod).
	m _ stsp asCString: #doNotGenerateByMethod.
	
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stsp asCString includesSubString: 'doNotGenerateByMethod').
	self assert: (stsp doNotGenerateByMethod = 4)
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'jpb 5/16/2020 11:12:18'!
testPluginDoNotGenerateByPragma
	"A <doNotdoNotGenerate> declaration should prevent code generation"

	| stsp m |
	stsp _ SlangTestSupportPlugin inline: false.
	self assert: (SlangTestSupportPlugin canUnderstand: #doNotGenerateByPragma).
	m _ stsp asCString: #doNotGenerateByPragma.
	
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stsp asCString includesSubString: 'doNotGenerateByPragma').
	self assert: (stsp doNotGenerateByPragma = 4)
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'jpb 5/16/2020 11:12:22'!
testPluginDoNotGenerateSubclassResponsibility
	"If a method contains self subclassResponsibility, assume it is not meant for translation."

	| stsp m |
	stsp _ SlangTestSupportPlugin inline: false.
	self assert: (SlangTestSupportPlugin canUnderstand: #anAbstractMethod).
	m _ stsp asCString: #anAbstractMethod.
	
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stsp asCString includesSubString: 'anAbstractMethod').
	self should: [stsp anAbstractMethod]
		raise: Error
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:37'!
testPluginMixedMethodAndPragmaDeclarations
	"Pragmas and method declarations should coexist"

	| stsp s |
	stsp _ SlangTestSupportPlugin inline: false.
	s _ (stsp asCString: #varDefByMethodAndPragma)
			copyReplaceAll: 'varDefByMethod'
			with: 'methodName'.
	self assert: (s includesSubString: 'unsigned int * bar').
	self assert: (s includesSubString: 'char *foo').
	self assert: (s includesSubString: 'float baz').
	self assert: (s includesSubString: 'double fum').
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:38'!
testPluginReturnTypeC
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stsp m p |
	stsp _ SlangTestSupportPlugin inline: false.
	m _ (stsp asCString: #returnTypeByMethod)
			copyReplaceAll: 'returnTypeByMethod'
			with: 'methodName'.
	p _ (stsp asCString: #returnTypeByPragma)
			copyReplaceAll: 'returnTypeByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:38'!
testPluginTypeDeclarations
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stsp m p |
	stsp _ SlangTestSupportPlugin inline: false.
	m _ (stsp asCString: #varDefByMethod)
			copyReplaceAll: 'varDefByMethod'
			with: 'methodName'.
	p _ (stsp asCString: #varDefByPragma)
			copyReplaceAll: 'varDefByPragma'
			with: 'methodName'.
	self assert: m = p! !

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

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:28'!
asCString

	| stream |
	stream _ ReadWriteStream on: String new.
	self cg emitCCodeOn: stream doAssertions: true.
	^ stream contents
! !

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:29'!
asCString: selector

	| method stream |
	method _ self cg methodNamed: selector.
	method ifNil: [^ 'No source has been generated'].
	stream _ ReadWriteStream on: String new.
	method emitCCodeOn: stream generator: cg.
	^ stream contents
! !

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'jpb 5/15/2020 22:23:03'!
cg
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

!SlangTestSupportInterpreter class methodsFor: 'translation' stamp: 'dtl 2/8/2014 14:08'!
isNonArgumentImplicitReceiverVariableName: aString
	^aString = 'objectMemory'
		or: [super isNonArgumentImplicitReceiverVariableName: aString]
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

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:28'!
asCString

	| stream |
	stream _ ReadWriteStream on: String new.
	self cg emitCCodeOn: stream doAssertions: true.
	^ stream contents
! !

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:29'!
asCString: selector

	| method stream |
	method _ self cg methodNamed: selector.
	method ifNil: [^ 'No source has been generated'].
	stream _ ReadWriteStream on: String new.
	method emitCCodeOn: stream generator: cg.
	^ stream contents
! !

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'jpb 5/16/2020 09:44:25'!
cg
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

!SlangTestSupportPlugin class methodsFor: 'translation' stamp: 'jpb 5/16/2020 22:23:41'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg _ SlangVMPluginCodeGenerator new initialize.
	cg declareMethodsStatic: false.
	cg permitMethodPruning: true.
	cg uncheckedAbstractMethods addAll: self abstractSelectors.
	cg pluginName: self moduleName.
	
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
