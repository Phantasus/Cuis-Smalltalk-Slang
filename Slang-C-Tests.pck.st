'From Cuis 5.0 [latest update: #4112] on 1 June 2020 at 12:45:31 pm'!
'Description This package contains the tests for the Slang-C package which contains the Slang to C translation.

License: MIT'!
!provides: 'Slang-C-Tests' 1 2!
!requires: 'Slang-C' 1 0 nil!
SystemOrganization addCategory: #'Slang-C-Tests'!


!classDefinition: #SlangCCodeGeneratorTest category: #'Slang-C-Tests'!
TestCase subclass: #SlangCCodeGeneratorTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-C-Tests'!
!classDefinition: 'SlangCCodeGeneratorTest class' category: #'Slang-C-Tests'!
SlangCCodeGeneratorTest class
	instanceVariableNames: ''!

!classDefinition: #SlangCLanguageWriterTest category: #'Slang-C-Tests'!
TestCase subclass: #SlangCLanguageWriterTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-C-Tests'!
!classDefinition: 'SlangCLanguageWriterTest class' category: #'Slang-C-Tests'!
SlangCLanguageWriterTest class
	instanceVariableNames: ''!

!classDefinition: #SlangCTest category: #'Slang-C-Tests'!
TestCase subclass: #SlangCTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-C-Tests'!
!classDefinition: 'SlangCTest class' category: #'Slang-C-Tests'!
SlangCTest class
	instanceVariableNames: ''!

!classDefinition: #SlangCTypeRepositoryTest category: #'Slang-C-Tests'!
TestCase subclass: #SlangCTypeRepositoryTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-C-Tests'!
!classDefinition: 'SlangCTypeRepositoryTest class' category: #'Slang-C-Tests'!
SlangCTypeRepositoryTest class
	instanceVariableNames: ''!


!SlangCCodeGeneratorTest commentStamp: '<historical>' prior: 0!
I test the generic C code generator!

!SlangCTest commentStamp: 'dtl 9/18/2010 17:43' prior: 0!
The SlangTest tests verify code generation and inlining.
!

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

!SlangCTest methodsFor: 'running' stamp: 'dtl 3/18/2013 18:48'!
setUp

	"Some of the test may be long running when SlangTestSupport is a subclass
	of ObjectMemory."
	(self respondsTo: #timeout: ) "Recent Squeak images with test case timeout"
		ifTrue: [self perform: #timeout: with: 30].
! !

!SlangCTest methodsFor: 'testing variable declaration' stamp: 'jpb 5/16/2020 11:12:32'!
testIvarShouldNotBeRedeclaredAsLocal
	"Document a bug in some versions of the code generator. If an instance variable is
	referenced in the generated code, that variable should not be declared as a local
	in the function."

	| stssi s |
	stssi _ SlangTestSupportInterpreter inline: false.
	s _ stssi asCString: #setBreakSelector: .
	
	self deny: (s includesSubString: 'sqInt breakSelector;')
! !

!SlangCTest methodsFor: 'testing variable declaration' stamp: 'dtl 11/25/2014 19:57'!
testLiteralName
	"sizeOf: #Foo should translated to C function call sizeof(Foo), where Foo is a literal, not a string"

	| stssi s |
	stssi _ SlangTestSupportInterpreter inline: false.
	s _ stssi asCString: #sizeOfFoo .
	self assert: (s includesSubString: 'sizeOf(Foo)').
	self deny: (s includesSubString: 'sizeOf("Foo")').

! !

!SlangCTest methodsFor: 'testing variable declaration' stamp: 'dtl 3/18/2013 14:38'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'jpb 5/16/2020 21:14:18'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 09:50'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 09:54'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:33'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'jpb 5/16/2020 00:23:41'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:24'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:36'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:37'!
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

!SlangCTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:38'!
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

!SlangCTest methodsFor: 'testing preprocessor directives' stamp: 'jpb 5/27/2020 21:31:12'!
testIfElseEndif
	"Test isDefinedTrueExpression:inSmalltalk:comment:ifTrue:ifFalse: is not implemented in Cuis Slang"

	| stssi |
	stssi _ SlangTestSupportInterpreter inline: false.

	self should: [ stssi ifDefinedTrueElseEndif ] raise: MessageNotUnderstood.! !

!SlangCTest methodsFor: 'testing preprocessor directives' stamp: 'jpb 5/27/2020 21:50:09'!
testIfdefElseEndif
	"Test that  isDefined:inSmalltalk:comment:ifTrue:ifFalse: is not implemented is Cuis Slang"

	| stssi expected|
	self flag: #FIXME. "See redundant implementation in oscog #cppIf:ifTrue:ifFalse:"

	stssi _ SlangTestSupportInterpreter inline: false.

	"verify that the default Smalltalk block that is evaluated in simulation"
	self should: [ stssi ifdefElseEndif ] raise: MessageNotUnderstood.
	
	expected _ String crlfString join: {
		''.
		'sqInt ifdefElseEndif(void) {'.
		'isDefinedinSmalltalkcommentifTrueifFalse("HAVE_FOO", return defaultBlockForSimulation, "some platforms do not support'.
		'foo properly", return 1, return 0);'.
		'return null;'.
		'}'.
	}.
	
	self assert: expected equals: (stssi asCString: #ifdefElseEndif).! !

!SlangCTest methodsFor: 'testing preprocessor directives' stamp: 'jpb 5/27/2020 21:28:07'!
testIfdefEndif
	"Tests that ifDef is not implemented. This is a difference to VMMaker Slang, which Cuis Slang doesn't implement "
	| stssi |
	self flag: #FIXME. "See redundant implementation in oscog #cppIf:ifTrue:"

	stssi _ SlangTestSupportInterpreter inline: false.

	"verify that the default Smalltalk block that is evaluated in simulation"
	self should: [ stssi ifdefEndif ]
		raise: MessageNotUnderstood.
! !

!SlangCTest methodsFor: 'testing preprocessor directives' stamp: 'jpb 5/27/2020 22:02:50'!
testPreprocessorExpression
	"Test that preprocessorExpression: is not supported in Cuis Slang"

	| stssi cString |
	self flag: #FIXME. "See redundant implementation in oscog #cPreprocessorDirective: "

	stssi _ SlangTestSupportInterpreter inline: false.
	cString _ stssi asCString: #preprocessorExpression.
	
	self deny: ('* define FOO bar*' match: cString).! !

!SlangCTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:32'!
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

!SlangCTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:34'!
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

!SlangCTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:35'!
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

!SlangCTest methodsFor: 'testing base plugins' stamp: 'jpb 5/16/2020 11:11:15'!
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

!SlangCTest methodsFor: 'testing base plugins' stamp: 'jpb 5/16/2020 11:12:18'!
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

!SlangCTest methodsFor: 'testing base plugins' stamp: 'jpb 5/16/2020 11:12:22'!
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

!SlangCTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:37'!
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

!SlangCTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:38'!
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

!SlangCTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:38'!
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
