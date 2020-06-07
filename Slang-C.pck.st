'From Cuis 5.0 [latest update: #4112] on 7 June 2020 at 11:37:53 am'!
'Description Package for the Slang code generation to C. 

License: MIT'!
!provides: 'Slang-C' 1 11!
!requires: 'Slang-Kernel' 1 0 nil!
SystemOrganization addCategory: #'Slang-C-Tests'!
SystemOrganization addCategory: #'Slang-C'!


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

!classDefinition: #SlangCTypeRepository category: #'Slang-C'!
SlangObject subclass: #SlangCTypeRepository
	instanceVariableNames: 'structTypes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-C'!
!classDefinition: 'SlangCTypeRepository class' category: #'Slang-C'!
SlangCTypeRepository class
	instanceVariableNames: ''!

!classDefinition: #SlangOSVMHeaderBuilder category: #'Slang-C'!
SlangObject subclass: #SlangOSVMHeaderBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-C'!
!classDefinition: 'SlangOSVMHeaderBuilder class' category: #'Slang-C'!
SlangOSVMHeaderBuilder class
	instanceVariableNames: ''!

!classDefinition: #SlangCCodeGenerator category: #'Slang-C'!
SlangCodeGenerator subclass: #SlangCCodeGenerator
	instanceVariableNames: 'inlineList variableDeclarations scopeStack apiMethods preparedMethodList variablesSetCache headerFiles globalVariableUsage doNotRemoveMethodList asArgumentTranslationDict receiverDict currentMethod declareMethodsStatic permitMethodPruning selectorTranslations inlineReturnTypes headerNotice versionString typeRepository'
	classVariableNames: 'UseRightShiftForDivide'
	poolDictionaries: ''
	category: 'Slang-C'!
!classDefinition: 'SlangCCodeGenerator class' category: #'Slang-C'!
SlangCCodeGenerator class
	instanceVariableNames: ''!

!classDefinition: #SlangCLanguageWriter category: #'Slang-C'!
SlangWriter subclass: #SlangCLanguageWriter
	instanceVariableNames: 'tabChar lfChar crChar spaceChar otherUnescapedChars'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-C'!
!classDefinition: 'SlangCLanguageWriter class' category: #'Slang-C'!
SlangCLanguageWriter class
	instanceVariableNames: ''!


!SlangCCodeGeneratorTest commentStamp: '<historical>' prior: 0!
I test the generic C code generator!

!SlangCTest commentStamp: 'dtl 9/18/2010 17:43' prior: 0!
The SlangTest tests verify code generation and inlining.
!

!SlangCTypeRepository commentStamp: '<historical>' prior: 0!
Contains information of stored types in a C module, can be used globally or locally. Used in the SlangCCodeGenerator subclasses.!

!SlangOSVMHeaderBuilder commentStamp: '<historical>' prior: 0!
This class is a builder for Opensmalltalk-VM plugin header files.!

!SlangCCodeGenerator commentStamp: 'tpr 5/2/2003 14:30' prior: 0!
This class oversees the translation of a subset of Smalltalk to C, allowing the comforts of Smalltalk during development and the efficiency and portability of C for the resulting interpreter.  
See VMMaker for more useful info!

!SlangCLanguageWriter commentStamp: '<historical>' prior: 0!
This class represents a specialized writer for writing to a stream C constructs.!

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

!SlangCTypeRepository methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 10:50:36'!
findBaseTypeForType: typeName
	"Returns the base type for the given type. For example 'int' if it's a subtype of int"
	^nil! !

!SlangCTypeRepository methodsFor: 'as yet unclassified' stamp: 'jpb 6/6/2020 19:25:30'!
findDefaultReturnTypeBy: aSymbol
	"Returns a literal for the given return when no explicit return has happened in a C function"
	#int = aSymbol ifTrue: [ ^0 ].
	
	self error: 'unknown default return type for ' , aSymbol.! !

!SlangCTypeRepository methodsFor: 'as yet unclassified' stamp: 'jpb 5/30/2020 16:35:46'!
findDefaultVariableDeclarationString
	^'int '! !

!SlangCTypeRepository methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 11:28:58'!
findStructTargetKindForDeclaration: decl
	"Returns the kind of a struct declaration or nil based on the given declaration"
	^(decl notNil
	   and: [structTypes anySatisfy:
			[:structType|
			(decl beginsWith: structType)
			and: [(decl indexOf: $* ifAbsent: [decl indexOf: Character space]) > structType size]]]) ifTrue:
		[(decl indexOf: $*) > 0
			ifTrue: [#pointer]
			ifFalse: [#struct]]! !

!SlangCTypeRepository methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 10:55:39'!
findTypeFor: aVariable fromDeclaration: aVariableDeclaration
	"Eliminate inessentials from aVariableDeclaration to answer a C type without the variable,
	 or initializations etc"
	| declaration |
	declaration _ aVariableDeclaration.
	(declaration beginsWith: 'static') ifTrue:
		[declaration _ declaration allButFirst: 6].

	(declaration indexOf: $= ifAbsent: []) ifNotNil:
		[:index| declaration _ declaration copyFrom: 1 to: index - 1].
		
	declaration _ declaration . "copyReplaceAll: aVariable with: '' tokenish: [:ch| ch = $_ or: [ch isAlphaNumeric]]."
	^self findBaseTypeForType: declaration.
	
	! !

!SlangCTypeRepository methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 11:29:28'!
initialize
	structTypes _ Set new.! !

!SlangCTypeRepository methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 10:41:50'!
isTypeStruct: typeName
	^false! !

!SlangCTypeRepository methodsFor: 'as yet unclassified' stamp: 'jpb 5/21/2020 09:55:13'!
isTypedPointerToStruct: typeName
	"Returns true if the given typeName represents a type which is a pointer to a struct"
	^false! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 23:01:45'!
emitHeaderOn: writer
	writer nextPutLine: '#ifndef OSVM_PLUGIN_H'.
	writer nextPutLine: '#define OSVM_PLUGIN_H'.
	writer enableAutoIndent.
	
	self emitTypedefsOn: writer.
	writer newLine.
	self emitInterpreterProxyStructOn: writer.
	
	writer disableAutoIndent.
	writer nextPutLine: '#endif'! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:37:17'!
emitInstanceCreatersOn: writer 
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''instance creation'''.

	lines _ #(
		'sqInt (*clone)(sqInt oop);'
		'sqInt (*instantiateClassindexableSize)(sqInt classPointer, sqInt size);'
		'sqInt (*makePointwithxValueyValue)(sqInt xValue, sqInt yValue);'
		'sqInt (*popRemappableOop)(void);'
		'sqInt (*pushRemappableOop)(sqInt oop);'
	).
	
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 23:28:55'!
emitInterpreterProxyStructOn: writer
	writer nextPutLine: 'typedef struct VirtualMachine {'.
	writer autoIndentBy: 2.

	self emitVersionGettersOn: writer.
	self emitStackAccessorsOn: writer.
	self emitObjectAccessorsOn: writer.
	self emitObjectTestersOn: writer.
	self emitObjectConvertersOn: writer.
	self emitSpecialObjectsOn: writer.
	self emitSpecialClassesOn: writer.
	self emitInstanceCreatersOn: writer.
	self emitOtherHelpersOn: writer.

	writer autoIndentBy: 1.
	writer nextPutLine: '} VirtualMachine;'.! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:37:41'!
emitObjectAccessorsOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''object access'''.
	lines _ #(
		'sqInt  (*argumentCountOf)(sqInt methodPointer);'
		'void  *(*arrayValueOf)(sqInt oop);'
		'sqInt  (*byteSizeOf)(sqInt oop);'
		'void  *(*fetchArrayofObject)(sqInt fieldIndex, sqInt objectPointer);'
		'sqInt  (*fetchClassOf)(sqInt oop);'
		'double (*fetchFloatofObject)(sqInt fieldIndex, sqInt objectPointer);'
		'sqInt  (*fetchIntegerofObject)(sqInt fieldIndex, sqInt objectPointer);'
		'sqInt  (*fetchPointerofObject)(sqInt fieldIndex, sqInt oop);'
		'sqInt  (*obsoleteDontUseThisFetchWordofObject)(sqInt fieldFieldIndex, sqInt oop);'
		'void  *(*firstFixedField)(sqInt oop);'
		'void  *(*firstIndexableField)(sqInt oop);'
		'sqInt  (*literalofMethod)(sqInt offset, sqInt methodPointer);'
		'sqInt  (*literalCountOf)(sqInt methodPointer);'
		'sqInt  (*methodArgumentCount)(void);'
		'sqInt  (*methodPrimitiveIndex)(void);'
		'sqInt  (*primitiveIndexOf)(sqInt methodPointer);'
		'sqInt  (*sizeOfSTArrayFromCPrimitive)(void *cPtr);'
		'sqInt  (*slotSizeOf)(sqInt oop);'
		'sqInt  (*stObjectat)(sqInt array, sqInt fieldIndex);'
		'sqInt  (*stObjectatput)(sqInt array, sqInt fieldIndex, sqInt value);'
		'sqInt  (*stSizeOf)(sqInt oop);'
		'sqInt  (*storeIntegerofObjectwithValue)(sqInt fieldIndex, sqInt oop, sqInt integer);'
		'sqInt  (*storePointerofObjectwithValue)(sqInt fieldIndex, sqInt oop, sqInt valuePointer);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:38:01'!
emitObjectConvertersOn: writer
	| lines |
	
	writer nextPutComment: 'InterpreterProxy methodsFor: ''converting'''.

	lines _ #(
		'sqInt  (*booleanValueOf)(sqInt obj);'
		'sqInt  (*checkedIntegerValueOf)(sqInt intOop);'
		'sqInt  (*floatObjectOf)(double aFloat);'
		'double (*floatValueOf)(sqInt oop);'
		'sqInt  (*integerObjectOf)(sqInt value);'
		'sqInt  (*integerValueOf)(sqInt oop);'
		'sqInt  (*positive32BitIntegerFor)(unsigned int integerValue);'
		'usqInt (*positive32BitValueOf)(sqInt oop);'
	).
	
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:40:14'!
emitObjectTestersOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''testing'''.
	
	lines _ #(
		'sqInt (*isKindOf)(sqInt oop, char *aString);'
		'sqInt (*isMemberOf)(sqInt oop, char *aString);'
		'sqInt (*isBytes)(sqInt oop);'
		'sqInt (*isFloatObject)(sqInt oop);'
		'sqInt (*isIndexable)(sqInt oop);'
		'sqInt (*isIntegerObject)(sqInt oop);'
		'sqInt (*isIntegerValue)(sqInt intValue);'
		'sqInt (*isPointers)(sqInt oop);'
		'sqInt (*isWeak)(sqInt oop);'
		'sqInt (*isWords)(sqInt oop);'
		'sqInt (*isWordsOrBytes)(sqInt oop);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:38:14'!
emitOtherHelpersOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''other'''.

	lines _ #(
		'sqInt (*becomewith)(sqInt array1, sqInt array2);'
		'sqInt (*byteSwapped)(sqInt w);'
		'sqInt (*failed)(void);'
		'sqInt (*fullDisplayUpdate)(void);'
		'void (*fullGC)(void);'
		'void (*incrementalGC)(void);'
		'sqInt (*primitiveFail)(void);'
		'sqInt (*showDisplayBitsLeftTopRightBottom)(sqInt aForm, sqInt l, sqInt t, sqInt r, sqInt b);'
		'sqInt (*signalSemaphoreWithIndex)(sqInt semaIndex);'
		'sqInt (*success)(sqInt aBoolean);'
		'sqInt (*superclassOf)(sqInt classPointer);'
	).
	lines do: [:line| writer nextPutLine: line].
	writer newLine.! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:28:13'!
emitSpecialClassesOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''special classes'''.

	lines _ #(
		'sqInt (*classArray)(void);'
		'sqInt (*classBitmap)(void);'
		'sqInt (*classByteArray)(void);'
		'sqInt (*classCharacter)(void);'
		'sqInt (*classFloat)(void);'
		'sqInt (*classLargePositiveInteger)(void);'
		'sqInt (*classPoint)(void);'
		'sqInt (*classSemaphore)(void);'
		'sqInt (*classSmallInteger)(void);'
		'sqInt (*classString)(void);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:26:02'!
emitSpecialObjectsOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''special objects'''. 

	lines _ #(
		'sqInt (*characterTable)(void);'
		'sqInt (*displayObject)(void);'
		'sqInt (*falseObject)(void);'
		'sqInt (*nilObject)(void);'
		'sqInt (*trueObject)(void);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/7/2020 11:37:45'!
emitSqIntTypedefsOn: writer
	"for 32bit images"
	"writer nextPutLine: 'typedef int sqInt;'."
	"writer nextPutLine: 'typedef unsigned int usqInt;'."
	
	"for 64bit"
	writer nextPutLine: 'typedef long sqInt;'.
	writer nextPutLine: 'typedef unsigned long usqInt;'.
	
	"writer nextPutLine: 'typedef long long sqInt;'."
	"writer nextPutLine: 'typedef unsigned long long usqInt;'."
	! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:39:45'!
emitStackAccessorsOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''stack access'''.
	lines _ #(
		'sqInt  (*pop)(sqInt nItems);'
		'sqInt  (*popthenPush)(sqInt nItems, sqInt oop);'
		'sqInt  (*push)(sqInt object);'
	 	'sqInt  (*pushBool)(sqInt trueOrFalse);'
	 	'sqInt  (*pushFloat)(double f);'
	 	'sqInt  (*pushInteger)(sqInt integerValue);'
	 	'double (*stackFloatValue)(sqInt offset);'
	 	'sqInt  (*stackIntegerValue)(sqInt offset);'
	 	'sqInt  (*stackObjectValue)(sqInt offset);'
	 	'sqInt  (*stackValue)(sqInt offset);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 23:46:32'!
emitTypedefsOn: writer
	self emitSqIntTypedefsOn: writer.
	writer newLine.
	writer nextPutLine: 'typedef sqInt (*CompilerHook)(void);'.
	writer newLine.
! !

!SlangOSVMHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 21:40:23'!
emitVersionGettersOn: writer
	writer nextPutAll: 'sqInt (*minorVersion)(void);'; newLine.
	writer nextPutAll: 'sqInt (*majorVersion)(void);'; newLine.
! !

!SlangOSVMHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/6/2020 20:11:23'!
findInterpreterProxyVersion
	"Only implemented for VMs which can generate 1:1 the interpreterProxy interface, which is only possible of a VM which inherits from the opensmalltalk-vm"
	^{Smalltalk vmParameterAt: 70. Smalltalk vmParameterAt: 71}! !

!SlangOSVMHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/6/2020 20:12:34'!
findOoPointerSize
	^Smalltalk vmParameterAt: 40! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'ar 2/14/1999 01:08'!
addHeaderFile: aString
	"Add a header file. The argument must be a quoted string!!"
	headerFiles addLast: aString.! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'eem 12/11/2010 13:42'!
addSelectorTranslation: aSelector to: aString
	selectorTranslations at: aSelector asSymbol put: aString! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'ikp 9/26/97 14:48'!
codeString
	"Return a string containing all the C code for the code base. Used for testing."

	| stream |
	stream _ ReadWriteStream on: (String new: 1000).
	self emitCCodeOn: stream doInlining: true doAssertions: true.
	^stream contents! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'jpb 5/16/2020 10:43:53'!
declToType: decl
	"Extracts the type from a C declaration string"

	| strs r |
	decl isNil ifFalse: [
		(decl indexOf: $=) > 0
			ifTrue: [ strs _ (decl copyFrom: 1 to: ((decl indexOf: $=) - 1)) ]
			ifFalse: [ strs _ decl ].
		
		strs _ (strs withoutTrailingBlanks) findTokens: ' '.
		strs size == 1 ifTrue: [ ^ strs first ]
			ifFalse:
		[
			| asterisks |
			r _ ''.
			strs allButLastDo: [ :s | r _ r,s,' ' ].
			"Bit of a hack to get 'type *'"
			asterisks _ (strs last copyFrom: 1 to: (strs last lastIndexOf: $*)).
			asterisks size > 0 ifTrue: [ r _ r,' ',asterisks ].
			
			r _ r withoutTrailingBlanks.
			(((r indexOf: $() > 0) or: ((r indexOf: $)) > 0)) ifTrue: [ ^nil ].
			^r withoutTrailingBlanks
		].
	] ifTrue: [ ^nil ].! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'dtl 2/5/2007 07:45'!
exportedPrimitiveNames
	"Return an array of all exported primitives"
	^methods select:[:m| m export] thenCollect:[:m| m selectorForCodeGeneration copyWithout: $:].
! !

!SlangCCodeGenerator methodsFor: 'public'!
globalsAsSet
	"Used by the inliner to avoid name clashes with global variables."

	((variablesSetCache == nil) or:
	 [variablesSetCache size ~= variables size]) ifTrue: [
		variablesSetCache _ variables asSet.
	].
	^ variablesSetCache! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'jpb 6/1/2020 14:10:28'!
initialize
	super initialize.

	translationDict _ Dictionary new.
	variableDeclarations _ Dictionary new: 100.
		
	self initializeTranslationDictionary.
	
	receiverDict _ Dictionary new.
	headerFiles _ OrderedCollection new.
	globalVariableUsage _ Dictionary new.
	
	scopeStack _ OrderedCollection new.
	
	headerNotice _ 'Slang Generator'.
	versionString _ '0.01'.
	
	abstractDeclarations _ IdentitySet new.
	uncheckedAbstractMethods _ OrderedCollection new.
	selectorTranslations _ IdentityDictionary new.
	
	typeRepository _ SlangCTypeRepository new.! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'jpb 5/15/2020 22:49:24'!
originClass: aClass
	"Set the interpreter class if any.  This is nil other than for the core VM."
	originClass _ aClass! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'ikp 9/26/97 14:50'!
storeCodeOnFile: fileName doInlining: inlineFlag
	"Store C code for this code base on the given file."

	self storeCodeOnFile: fileName doInlining: inlineFlag doAssertions: true! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'jpb 5/20/2020 22:35:16'!
storeCodeOnFile: fileName doInlining: inlineFlag doAssertions: assertionFlag
	"Store C code for this code base on the given file."

	| stream |
	[
		stream _ systemAdapter openNewFileNamed: fileName.
		self emitCCodeOn: stream doInlining: inlineFlag doAssertions: assertionFlag.
	] ensure: [ stream close ]! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'jpb 5/16/2020 23:02:51'!
var: varName declare: declarationString
	"Record the given C declaration for a global variable."

	(declarationString includesSubString: varName) ifFalse:
		[self error: 'declaration omits variable name.  probably an error.  use e.g. var:type:'].
	variableDeclarations at: varName asString put: declarationString.! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'jpb 5/19/2020 21:27:20'!
var: varName type: type
	"Use this in preference to #var:declareC: whenver possible since it avoids typing the varname twice and thus avoids the potential for a typo. See also #var:type:array:"
	self var: varName declare: type , ' ' , varName! !

!SlangCCodeGenerator methodsFor: 'public' stamp: 'jpb 5/19/2020 22:30:24'!
var: varName type: type array: array
	"use this in preference to #var:declareC: when possible. This produces a C statment of the form int * fooArray[]={1,2,3} See also #var:type: for simple var decls" 
	| declaration |
	declaration _ (String streamContents: [:s |
		| writer |
		writer _ SlangCLanguageWriter on: s.
		writer nextPutAll: type.
		writer space.
		writer nextPutAll: varName.
		writer nextPutAll: '[] = {'.
		writer nextPutArray: array.
		writer nextPut: $}]).
		
	self
		var: varName
		declare: declaration! !

!SlangCCodeGenerator methodsFor: 'composition' stamp: 'dtl 4/11/2012 18:52'!
mapVar: instanceVarName asInstanceOf: aClass to: newName
	"A class that has been added to this code generator has an instance variable
	instanceVarName that should point to an instance of aClass. Treat sends to
	that object as if they were sends to newName. When newName is 'self', all
	such methods are translated to C as functions in the current C module."

	receiverDict at: instanceVarName asString
		ifPresent: [ :previousMapping |
			previousMapping = newName
				ifFalse: [ self error: aClass name,'>>', instanceVarName, ' previously mapped to ',
					previousMapping, ' by another class, cannot be remapped to ', newName ]]
		ifAbsent: [ receiverDict at: instanceVarName asString put: newName.
			variables remove: instanceVarName ifAbsent: [] ]
! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'eem 2/12/2009 13:44'!
checkDeleteVariable: aName
	"Hook for debugging variable deletion."! !

!SlangCCodeGenerator methodsFor: 'utilities'!
checkForGlobalUsage: vars in: aTMethod 
	| item |
	vars
		do: [:var | 
			"TPR - why the use of globalsAsSet here instead of globalVariables? 
			JMM - globalVariables is not initialized yet, variables is an OrderedCollection, 
				globalsAsSet returns variables as needed set"
			(self globalsAsSet includes: var)
				ifTrue: ["find the set of method names using this global var"
					item _ globalVariableUsage
								at: var
								ifAbsent: [globalVariableUsage at: var put: Set new].
					"add this method name to that set"
					item add: aTMethod selector]].
	aTMethod referencesGlobalStructMakeZero! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'jpb 6/1/2020 12:11:30'!
compileToTMethodSelector: selector in: aClass
	"Compile a method to a Translation Method instance"

	| methodNode |	
	methodNode _ systemAdapter parseSelector: selector in: aClass. 
	^methodNode asSlangTranslationMethodOfClass: self translationMethodClass! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/27/2020 20:27:50'!
emitBuiltinConstructAsArgumentFor: msgNode on: aStream level: level
	"If the given selector is in the translation dictionary, translate it into a target code construct and return true. Otherwise, do nothing and return false."

	| action |
	action _ asArgumentTranslationDict
				at: msgNode selector
				ifAbsent: [translationDict at: msgNode selector ifAbsent: [ ^false ]].
				
	self perform: action with: msgNode with: aStream with: level.
	^true! !

!SlangCCodeGenerator methodsFor: 'utilities'!
emitBuiltinConstructFor: msgNode on: aStream level: level
	"If the given selector is in the translation dictionary, translate it into a target code construct and return true. Otherwise, do nothing and return false."

	| action |
	action _ translationDict at: msgNode selector ifAbsent: [ ^false ].
	self perform: action with: msgNode with: aStream with: level.
	^true! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'jpb 6/1/2020 14:30:52'!
findCodeForMethod: selector
	"Answer a string containing the C code for the given method."
	"Example:
		((CCodeGenerator new initialize addClass: TestCClass1; prepareMethods)
			cCodeForMethod: #ifTests)"

	| m s |
	m _ self findMethodNamed: selector.
	m = nil ifTrue: [ self error: 'method not found in code base: ', selector ].

	s _ (ReadWriteStream on: '').
	m emitCCodeOn: s generator: self.
	^ s contents! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/19/2020 17:21:51'!
findExportBuildInfoByClass: sourceClass
	"Returns the export buildinfo used for the generated Slang module"
	
	(sourceClass is: #InterpreterClass) ifTrue:  [^ 'char *__interpBuildInfo = __buildInfo;'].
	(sourceClass is: #CogitClass) ifTrue: [ ^'char *__cogitBuildInfo = __buildInfo;'].
	(sourceClass is: #PluginClass) ifTrue: [ ^sourceClass perform: #exportBuildInfoOrNil ].

	^nil! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/28/2020 19:09:56'!
localizeGlobalVariables
	| candidates procedure |
	self flag: #fixme.

	"find all globals used in only one method"
	candidates _ globalVariableUsage select: [:e | e size = 1].
	(candidates keys select: [:k| false "FIXME: Mechanism for determining if a variable must be global was removed"  ]) do:
		[:k| candidates removeKey: k].
		
	variables removeAllFoundIn: candidates keys.

	"move any suitable global to be local to the single method using it"
	candidates keysAndValuesDo: [:key :targets | 
		targets do: [:name |
			procedure _ methods at: name.
			procedure locals add: key.
			variableDeclarations at: key ifPresent: [:v | 
				procedure declarations at: key put: v.
				variableDeclarations removeKey: key]]].! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'dtl 7/3/2008 12:16'!
memoryAccessSelectors
	"Answer the selectors used for low level memory access. These are traditionally
	implemented as C preprocessor macros (or static inlined functions) in the external
	support code, but may also be implemented as Smalltalk methods for translation to C."

	^ { #byteAt: . #byteAt:put: .
		#shortAt: . #shortAt:put: .
		#intAt: . #intAt:put: .
		#longAt: . #longAt:put: .
		#byteAtPointer: . #byteAtPointer:put: .
		#shortAtPointer: . #shortAtPointer:put: .
		#intAtPointer: . #intAtPointer:put: .
		#longAtPointer: . #longAtPointer:put: }! !

!SlangCCodeGenerator methodsFor: 'utilities'!
methodsReferringToGlobal: v
	"Return a collection of methods that refer to the given global variable."

	| out |
	out _ OrderedCollection new.
	methods associationsDo: [ :assoc |
		(assoc value freeVariableReferences includes: v) ifTrue: [
			out add: assoc key.
		].
	].
	^ out! !

!SlangCCodeGenerator methodsFor: 'utilities'!
methodsThatCanInvoke: aSelectorList
	"Return a set of methods that can invoke one of the given selectors, either directly or via a sequence of intermediate methods."

	| out todo sel mSelector |
	out _ Set new.
	todo _ aSelectorList copy asOrderedCollection.
	[todo isEmpty] whileFalse: [
		sel _ todo removeFirst.
		out add: sel.
		methods do: [ :m |
			(m allCalls includes: sel) ifTrue: [
				mSelector _ m selector.
				((out includes: mSelector) or:
				 [todo includes: mSelector]) ifFalse: [
					todo add: mSelector.
				].
			].
		].
	].
	^ out
	! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/20/2020 22:49:05'!
nilOrBooleanConstantReceiverOf: sendNode
	"Answer nil or the boolean constant that is the receiver of the given message send. Used to suppress conditional code when the condition is a translation-time constant."

	| rcvr val |
	rcvr _ sendNode receiver.
	rcvr isConstant ifTrue: [
		val _ rcvr value.
		((val == true) or: [val == false]) ifTrue: [^ val]].
	^ nil
! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'dtl 1/22/2012 14:34'!
prepareMethods
	"Prepare methods for browsing."

	| globals |
	globals _ Set new: 200.
	globals addAll: variables.
	methods do: [ :m |
		(m locals, m args) do: [ :var |
			(globals includes: var) ifTrue: [
				self error: 'Local variable name may mask global when inlining: ', var.
			].
			(methods includesKey: var) ifTrue: [
				self error: 'Local variable name may mask method when inlining: ', var.
			].	
		].
		m mapReceiversIn: receiverDict.
		m bindClassVariablesIn: constants.
		m prepareMethodIn: self.
	].! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'eem 4/17/2009 14:40'!
removeMethodForSelector: aSelector
	"Remove the given method from the code base"
	methods removeKey:  aSelector ifAbsent: []! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/28/2020 18:55:35'!
removeVariable: aName
	"Remove the given (instance) variable from the code base."
	self checkDeleteVariable: aName.
	variables
		remove: aName
		ifAbsent:
			[(originClass notNil
			  and: [originClass isNonArgumentImplicitReceiverVariableName: aName]) ifFalse:
				[systemAdapter
					logWarning: 'warning, variable '
						, aName
						, ' doesn''t exist or has already been removed']].
				
	variableDeclarations removeKey: aName ifAbsent: []! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'jpb 6/1/2020 14:30:52'!
reportRecursiveMethods
	"Report in transcript all methods that can call themselves directly or indirectly or via a chain of N intermediate methods."

	| visited calls newCalls sel called |
	methods do: [: m |
		visited _ translationDict keys asSet.
		calls _ m allCalls asOrderedCollection.
		5 timesRepeat: [
			newCalls _ Set new: 50.
			[calls isEmpty] whileFalse: [
				sel _ calls removeFirst.
				sel = m selector ifTrue: [
					systemAdapter logWarning: m selector , ' is recursive'.
				] ifFalse: [
					(visited includes: sel) ifFalse: [
						called _ self findMethodNamed: sel.
						called = nil ifFalse: [ newCalls addAll: called allCalls ].
					].
					visited add: sel.
				].
			].
			calls _ newCalls asOrderedCollection.
		].
	].! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'JMM 4/16/2002 22:39'!
returnPrefixFromVariable: aName
	^aName! !

!SlangCCodeGenerator methodsFor: 'utilities' stamp: 'eem 5/20/2010 20:46'!
sortMethods: aTMethodCollection
	"We need to define this since different Squeak versions answer different results
	 for asSortedCollection and if sort order changes, generated code changes too."
	^aTMethodCollection asSortedCollection:
		[:a :b| a selector caseSensitiveLessOrEqual: b selector]! !

!SlangCCodeGenerator methodsFor: 'accessing' stamp: 'eem 7/2/2008 16:01'!
currentMethod
	^currentMethod! !

!SlangCCodeGenerator methodsFor: 'accessing' stamp: 'eem 7/2/2008 16:01'!
currentMethod: aTMethod
	currentMethod _ aTMethod! !

!SlangCCodeGenerator methodsFor: 'accessing' stamp: 'jpb 6/3/2020 17:02:51'!
declareMethodsStatic
	"If true generated methods will be declared static. "
	^ declareMethodsStatic
		ifNil: [declareMethodsStatic _ false]! !

!SlangCCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 17:26'!
declareMethodsStatic: aBoolean
	"If set false, generated methods will be not declared static.
	Default value is true."
	declareMethodsStatic _ aBoolean! !

!SlangCCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 18:54'!
permitMethodPruning
	"If false, pruning unreferenced methods will be disabled"
	^ permitMethodPruning ~= false! !

!SlangCCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 18:53'!
permitMethodPruning: aBoolean
	"If false, pruning unreferenced methods will be disabled"
	permitMethodPruning _ aBoolean! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 6/2/2020 21:19:10'!
emitCCodeOn: aStream 
	"Emit C code for all methods in the code base onto the given stream. All inlined method calls should already have been expanded."
	| writer |
	writer _ SlangCLanguageWriter on: aStream.

	self emitCHeaderOn: writer.
	self emitCTypesOn: writer.
	self emitCConstantsOn: writer.
	self emitCFunctionPrototypes: preparedMethodList on: writer.
	self emitCVariablesOn: writer.
	
	systemAdapter
		showProgressIn: preparedMethodList 
		label: 'Writing Translated Code ...'
		do: [:bar :m :i |
		bar value: i.
		m emitCCodeOn: writer generator: self ].
	
	self emitExportsOn: writer.
! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/26/2020 21:54:53'!
emitCCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag
	"Emit C code for all methods in the code base onto the given stream. All inlined method calls should already have been expanded."

	self prepareMethodsInlined: inlineFlag doAssertions: assertionFlag.
	^ self emitCCodeOn: aStream ! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 6/2/2020 21:50:58'!
emitCConstantsOn: aStream
	"Store the global variable declarations on the given stream."
	| unused constList node |
	unused _ constants keys asSet.
	methods do: [ :meth |
		meth parseTree nodesDo: [ :n |
			n isConstant ifTrue: [ unused remove: n name ifAbsent: []]]].
	
	constList _ constants keys reject: [ :any | unused includes: any].
	
	constList size > 0 ifTrue: [
		aStream nextPutSectionComment: 'Constants'.
	].
		
	constList asSortedCollection do: [ :varName |
		node _ constants at: varName.
		node name isEmpty ifFalse: [
			aStream nextPutAll: '#define '.
			aStream nextPutAll: node name.
			aStream space.
			aStream nextPutAll: (self findLiteralFor: node value).
			aStream newLine
		].
	].
	aStream newLine.! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: ' 2/7/08 14:57'!
emitCExpression: aParseNode on: aStream 
	"Emit C code for the expression described by the given parse node."

	aParseNode isLeaf 
		ifTrue: 
			["omit parens"
			 aParseNode emitCCodeAsExpressionOn: aStream level: 0 generator: self]
		ifFalse: 
			[aStream nextPut: $(.
			 aParseNode emitCCodeAsExpressionOn: aStream level: 0 generator: self.
			 aStream nextPut: $)]! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/30/2020 16:24:32'!
emitCFunctionPrototypes: methodList on: aStream 
	"Store prototype declarations for all non-inlined methods on the given stream."
	
	methodList size > 0 ifTrue: [
		self emitCFunctionPrototypesSectionHeaderOn: aStream.
	].

	methodList do: [:m | 				
		m emitCFunctionPrototype: aStream generator: self.
		aStream nextPutAll: ';'; newLine ].! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/30/2020 16:23:35'!
emitCFunctionPrototypesSectionHeaderOn: aStream
	aStream nextPutAll: '/*** Function Prototypes ***/'; newLine.! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 6/2/2020 21:26:05'!
emitCHeaderOn: languageWriter
	"Write a C file header onto the given stream."

	languageWriter nextPutComment: headerNotice. 
	languageWriter nextPutAll: (self fileHeaderVersionStampForSourceClass: originClass);
		newLine; newLine.

	"Additional header files"
	self emitHeaderFilesOn: languageWriter.

	languageWriter newLine.! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 11/9/2006 06:42'!
emitCTestBlock: aBlockNode on: aStream
	"Emit C code for the given block node to be used as a loop test."

	aBlockNode statements size > 1 ifTrue: [
		aBlockNode emitCCodeOn: aStream level: 0 generator: self.
	] ifFalse: [
		aBlockNode statements first asExpression emitCCodeOn: aStream level: 0 generator: self.
	].! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/16/2020 09:47:17'!
emitCTypesOn: aStream 
	"Store local type declarations on the given stream."! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/30/2020 16:35:13'!
emitCVariablesOn: aStream 
	"Store the global variable declarations on the given stream."
	| varString |
	variables size > 0 ifTrue: [ self emitCVariablesSectionHeaderOn: aStream ].
	
	variables asSortedCollection
		do: [:var | 
			varString _ var asString.
			(variableDeclarations includesKey: varString)
				ifTrue: [aStream nextPutAll: (variableDeclarations at: varString) , ';'; newLine]
				ifFalse: ["default variable declaration"
					aStream nextPutAll: typeRepository findDefaultVariableDeclarationString , varString , ';'; newLine]].
			
	aStream newLine! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/30/2020 16:25:42'!
emitCVariablesSectionHeaderOn: aStream 
	"Emit the header comment for the variables section of a generated file"
	aStream nextPutAll: '/*** Variables ***/'; newLine.
	! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 6/3/2020 16:13:00'!
emitExportsOn: aStream
	"Store all the exported primitives in a form to be used by the internal named prim system"! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 6/2/2020 21:48:31'!
emitHeaderFilesOn: aStream
	"Write a header files onto the given stream. A special hack allows use of 
	#ifdef THING
	#include <blah.h>
	#endif
	constructs"

	"Additional header files"
	headerFiles do:[:hdr|
		hdr first ~= $# ifTrue:
			[aStream nextPutLocalInclude: hdr].
		aStream newLine].
! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 6/3/2020 16:12:17'!
fileHeaderVersionStampForSourceClass: sourceClass
	"Answer a suitable version stamp to include in the header."
	| slangDescription sourceDescription |
		
	slangDescription _ systemAdapter findSlangDescriptionBy: self class.
	sourceClass ifNotNil: [sourceDescription _ systemAdapter findSourceDescriptionBy: sourceClass].
		
	^String streamContents:
		[:s| | writer |
		writer _ SlangCLanguageWriter on: s.
		writer nextPutCommentStart.
		writer nextPutAll: 'Automatically generated by' ; newLine.
		writer nextPutAll: slangDescription.
	
		sourceDescription ifNotNil: [
			writer newLine.
			writer nextPutAll: '   from' ; newLine.
			writer nextPutAll: '	'.
			writer nextPutAll: sourceDescription ].
		writer newLine; nextPutCommentEnd; newLine.]! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/19/2020 22:45:26'!
findFunctionNameFor: aSelector
	"Create a C function name from the given selector by finding
	 a specific translation, or if none, simply omitting colons."
	^selectorTranslations at: aSelector ifAbsent: [aSelector copyWithout: $:]! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/20/2020 23:28:41'!
findInternalOrExternalMethod: selector
	"Returns the method for the given selector or of the one for an external api call"
	^methods
		at: selector
		ifAbsent: [apiMethods ifNotNil: [apiMethods at: selector ifAbsent: nil]]! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/20/2020 19:21:07'!
findLiteralFor: anObject
	"Return a string representing the C literal value for the given object."
	(anObject is: #Number)
		ifTrue: [ ^self findNumberLiteralFor: anObject ].
	
	anObject isSymbol ifTrue: [^self findFunctionNameFor: anObject].
	(anObject is: #String) ifTrue: [^'"', anObject , '"'].
	
	anObject == nil ifTrue: [^ 'null' ].
	anObject == true ifTrue: [^ '1' ].
	anObject == false ifTrue: [^ '0' ].
	
	(anObject is: #Character) ifTrue: [
		^anObject == $'
			ifTrue: ['''\'''''] "i.e. '\''"
			ifFalse: [anObject asString printString]].
			
	self error: 'Warning: A Smalltalk literal could not be translated into a C constant: ', anObject printString.
	
	^'"XXX UNTRANSLATABLE CONSTANT XXX"'! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/20/2020 23:16:30'!
findLiteralFor: anObject name: smalltalkName
	"Return a string representing the C literal value for the given object.
	 This version may use hex for integers that are bit masks."
	anObject isInteger ifTrue:
		[| hex dec rep |
		hex _ anObject printStringBase: 16.
		dec _ anObject printStringBase: 10.
		rep _ ((smalltalkName endsWith: 'Mask')
				or: [anObject digitLength > 1
					and: [(hex asSet size * 3) <= (dec asSet size * 2)
					and: [(smalltalkName endsWith: 'Size') not]]])
					ifTrue: [hex first = $- ifTrue: ['-0x', hex allButFirst] ifFalse: ['0x', hex]]
					ifFalse: [dec].
		^rep , self findIntegerLiteralSuffixFor: anObject].
	
	^self findLiteralFor: anObject! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/20/2020 19:06:46'!
findNumberLiteralFor: anObject
	"Returns a C number literal for the given object"
	(anObject is: #Integer)
		ifTrue: [ ^SlangCLanguageWriter findIntegerLiteral: anObject ].
	
	anObject isFloat
		ifTrue: [ ^anObject printString ]! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/20/2020 23:30:03'!
isLiteral: anObject
	"Returns true if the given object is a literal in the target language"
	(anObject isKindOf: Integer) ifTrue: [^true].
	(anObject isKindOf: String) ifTrue: [^true].
	(anObject isKindOf: Float) ifTrue: [^true].
	anObject == nil ifTrue: [^true].
	anObject == true ifTrue: [^true].			"ikp"
	anObject == false ifTrue: [^true].			"ikp"
	(anObject isKindOf: Character) ifTrue:[^true]. "ar"
	^false! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/28/2020 19:02:16'!
isNonArgumentImplicitReceiverVariableName: aString
	^(self typeOfVariable: aString) == #implicit
	    or: [ #('interpreterProxy' 'self') includes: aString ] ! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/27/2020 21:01:14'!
prepareMethodsInlined: inlineFlag doAssertions: assertionFlag
	"Prepare to emit C code for all methods in the code base. All inlined method calls should be expanded. Answer a list of methods to be emitted as C code."

	| verbose methodList |
	"method preparation"
	verbose _ false.
	self prepareMethods.
	verbose ifTrue: [
		self printUnboundCallWarnings.
		self printUnboundVariableReferenceWarnings.
	].
	self checkAbstractMethods.
	assertionFlag ifFalse: [ self removeAssertions ].
	self doInlining: inlineFlag.

	"code generation"

	methodList _ methods asSortedCollection: [ :m1 :m2 | m1 selector < m2 selector ].
	"clean out no longer valid variable names and then handle any global
		variable usage in each method"
	methodList do: [:m | self checkForGlobalUsage: m removeUnusedTemps in: m].
	self localizeGlobalVariables.
	^ preparedMethodList _ methodList
! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'eem 7/2/2008 14:21'!
pushScope: variableToType "<Dictionary>" while: aBlock
	scopeStack addLast: variableToType.
	^aBlock ensure: [scopeStack removeLast]! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/21/2020 18:39:38'!
selectorReturnsPointerToStruct: selector "<Symbol>"
	| tMethod |
	^originClass notNil
	  and: [(tMethod _ methods at: selector ifAbsent: []) notNil
	  and: [self isType: tMethod returnType kind: #pointerToStruct]]! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/20/2020 23:28:41'!
selectorReturnsStruct: selector "<Symbol>"
	| tMethod |
	^(tMethod _ self findInternalOrExternalMethod: selector) notNil
	  and: [ systemAdapter isStructType: tMethod returnType]! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'jpb 5/16/2020 00:07:07'!
structTargetKindForVariableName: varName "<String>"
	^nil! !

!SlangCCodeGenerator methodsFor: 'C code generator' stamp: 'eem 2/9/2009 20:39'!
typeOfVariable: varName "<String>" 
	scopeStack reverseDo:
		[:dict|
		(dict includesKey: varName) ifTrue:
			[^dict at: varName]].
	^variableDeclarations at: varName ifAbsent: nil! !

!SlangCCodeGenerator methodsFor: 'error notification' stamp: 'jpb 5/20/2020 23:33:14'!
printUnboundCallWarnings
	"Print a warning message for every unbound method call in the code base."

	| knownSelectors undefinedCalls |
	undefinedCalls _ Dictionary new.
	knownSelectors _ translationDict keys asSet.
	knownSelectors add: #error:.

	methods do: [ :m | knownSelectors add: m selector ].
	methods do: [ :m |
		m allCalls do: [ :sel |
			(knownSelectors includes: sel) ifFalse: [
				(undefinedCalls includesKey: sel)
					ifTrue: [ (undefinedCalls at: sel) add: m selector ]
					ifFalse: [ undefinedCalls at: sel put: (OrderedCollection with: m selector) ].
			].
		].
	].

	systemAdapter printUndefinedCalls: undefinedCalls.! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/27/2020 20:51:32'!
collectInlineList
	"Make a list of methods that should be inlined."
	"Details: The method must not include any inline C, since the translator cannot
	currently map variable names in inlined C code. The #inline: directive may be
	used to override this for cases in which the C code or declarations are harmless.
	Methods to be inlined must be small or called from only one place."

	| methodsNotToInline callsOf inlineIt hasCCode nodeCount senderCount
sel returnTypesOf |
	methodsNotToInline _ Set new: methods size.

	"build dictionary to record the number of calls to each method"
	callsOf _ Dictionary new: methods size * 2.
	returnTypesOf _ Dictionary new: methods size.
	methods keys do: [ :s | callsOf at: s put: 0 ].
	methods do: [ :m | returnTypesOf at: m selector put: m returnType ].

	"For each method, scan its parse tree once to:
		1. determine if the method contains C code or declarations
		2. determine how many nodes it has
		3. increment the sender counts of the methods it calls
		4. determine if it includes any C declarations or code"
	inlineList _ Set new: methods size * 2.
	inlineReturnTypes _ Dictionary new: methods size.
	methods do: [ :m |
		inlineIt _ #dontCare.
		(translationDict includesKey: m selector) ifTrue: [
			hasCCode _ true.
		] ifFalse: [
			hasCCode _ m declarations size > 0.
			nodeCount _ 0.
			m parseTree nodesDo: [ :node |
				node isSend ifTrue: [
					sel _ node selector.
			
					senderCount _ callsOf at: sel ifAbsent: [ nil ].
					
					nil = senderCount ifFalse: [
						callsOf at: sel put: senderCount + 1.
					].
				].
				nodeCount _ nodeCount + 1.
			].
			inlineIt _ m extractInlineDirective.  "may be true, false, or
#dontCare"
		].
		(inlineIt ~= true and: [hasCCode or: [inlineIt = false]]) ifTrue: [
			"Don't inline if method has C code or if it contains a negative inline
			directive. If it contains a positive inline directive, permit inlining even
			if C code is present."
			methodsNotToInline add: m selector.
		] ifFalse: [
			((nodeCount < 40) or: [inlineIt = true]) ifTrue: [
				"inline if method has no C code and is either small or contains
inline directive"
				inlineList add: m selector.
				inlineReturnTypes at: sel put: m returnType.
			].
		].
	].

	callsOf associationsDo: [ :assoc |
		((assoc value = 1) and: [(methodsNotToInline includes: assoc key)
not]) ifTrue: [
			inlineList add: assoc key.
		].
	].! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/26/2020 21:31:06'!
doBasicInlining: inlineFlag
	"Inline the bodies of all methods that are suitable for inlining.
	This method does only the basic inlining suitable for both the core VM and plugins - no bytecode inlining etc"

	inlineFlag ifFalse: [^self].
	self collectInlineList.
	self tryMethodInliningWithProgressNotification ! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/16/2020 00:13:15'!
doInlining: inlineFlag
	"Inline the bodies of all methods that are suitable for inlining."
	"Modified slightly for the core VM translator, since the first level of inlining for the interpret loop must be performed in order that the instruction implementations can easily discover their addresses. Remember to inline the bytecode routines as well"

	inlineFlag ifFalse: [
		self inlineDispatchesInMethodNamed: #interpret localizingVars: #().
		^ self].
	self doBasicInlining: inlineFlag.
	self inlineCaseStatementBranchesInMethodNamed: #interpret localizingVars: #().
	
	'Inlining bytecodes'
		displayProgressAt: Sensor mousePoint
		from: 1 to: 2
		during: [:bar |
			self inlineDispatchesInMethodNamed: #interpret
				localizingVars: #(currentBytecode localIP localSP localHomeContext localReturnContext localReturnValue).
			bar value: 1.
			self removeMethodsReferingToGlobals: #(
					currentBytecode localIP localSP localHomeContext)
				except: #(interpret).
			bar value: 2].
	self permitMethodPruning
		ifTrue: [self pruneUnreachableMethods]
! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 6/1/2020 14:30:52'!
inlineCaseStatementBranchesInMethodNamed: selector localizingVars: varsList 
	"Inline case statement branches in the method with the given name."
	(self findMethodNamed: selector)
		ifNotNil: [:m | m inlineCaseStatementBranchesIn: self localizingVars: varsList]! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 6/1/2020 14:30:52'!
inlineDispatchesInMethodNamed: selector localizingVars: varsList
	"Inline dispatches (case statements) in the method with the given name."

	| m varString |
	m _ self findMethodNamed: selector.
	m = nil ifFalse: [
		m inlineCaseStatementBranchesIn: self localizingVars: varsList.
		m parseTree nodesDo: [ :n |
			n isCaseStmt ifTrue: [
				n customizeShortCasesForDispatchVar: 'currentBytecode' in: self method: m.
			].
		].
	].
	variables _ variables asOrderedCollection.
	varsList do: [ :v |
		varString _ v asString.
		variables remove: varString ifAbsent: [].
		(variableDeclarations includesKey: varString) ifTrue: [
			m declarations at: v asString put: (variableDeclarations at: varString).
			variableDeclarations removeKey: varString.
		].
	].
! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'asf 9/30/2014 20:18'!
inlineReturnType: selector
	"gets the return type of a given inline selector"

	^inlineReturnTypes at: selector ifAbsent: nil! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'eem 7/30/2013 16:26'!
isAssertSelector: selector
	^#(assert: asserta: assert:l: asserta:l:) includes: selector! !

!SlangCCodeGenerator methodsFor: 'inlining'!
mayInline: sel
	"Answer true if the method with the given selector may be inlined."

	^ inlineList includes: sel! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/27/2020 21:17:22'!
methodStatsString
	"Return a string describing the size, # of locals, and # of senders of
each method. Note methods that have inline C code or C declarations."

	| methodsWithCCode sizesOf callsOf hasCCode nodeCount senderCount s
calls registers selr m |
	methodsWithCCode _ Set new: methods size.
	sizesOf _ Dictionary new: methods size * 2.  "selector -> nodeCount"
	callsOf _ Dictionary new: methods size * 2.  "selector -> senderCount"

	"For each method, scan its parse tree once to:
		1. determine if the method contains C code or declarations
		2. determine how many nodes it has
		3. increment the sender counts of the methods it calls
		4. determine if it includes any C declarations or code"

	methods do: [ :m0 |  m _ m0.
		(translationDict includesKey: m selector) ifTrue: [
			hasCCode _ true.
		] ifFalse: [
			hasCCode _ m declarations size > 0.
			nodeCount _ 0.
			m parseTree nodesDo: [ :node |
				node isSend ifTrue: [
					selr _ node selector.
					senderCount _ callsOf at: selr ifAbsent: [ 0 ].
					callsOf at: selr put: senderCount + 1.
				].
				nodeCount _ nodeCount + 1.
			].
		].
		hasCCode ifTrue: [ methodsWithCCode add: m selector ].
		sizesOf at: m selector put: nodeCount.
	].

	s _ WriteStream on: (String new: 5000).
	methods keys asSortedCollection do: [ :sel |
		m _ methods at: sel.
		registers _ m locals size + m args size.
		calls _ callsOf at: sel ifAbsent: [0].
		registers > 11 ifTrue: [
			s nextPutAll: sel; tab.
			s nextPutAll: (sizesOf at: sel) printString; tab.
			s nextPutAll: calls printString; tab.
			s nextPutAll: registers printString; tab.
			(methodsWithCCode includes: sel) ifTrue: [ s nextPutAll: 'CCode' ].
		s cr.
		].
	].
	^ s contents! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'ar 2/3/2001 17:08'!
pruneMethods: selectorList
	"Explicitly prune some methods"
	selectorList do:[:sel| methods removeKey: sel ifAbsent:[]].! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'tpr 3/2/2004 11:09'!
pruneUnreachableMethods
	"Remove any methods that are not reachable. Retain methods needed by the translated classes - see implementors of requiredMethodNames"
 	
	| newMethods |
	"add all the exported methods and all the called methods to the dNRML"
	methods do: [ :m |
		m export ifTrue:[doNotRemoveMethodList add: m selector].
		doNotRemoveMethodList addAll: m allCalls].

	"build a new dictionary of methods from the collection of all the ones to keep"			
	newMethods _ Dictionary new: doNotRemoveMethodList size.
	doNotRemoveMethodList do:[:sel|
		methods at: sel ifPresent:[:meth| newMethods at: sel put: meth]].
	methods _ newMethods! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/28/2020 17:41:26'!
removeAssertions
	"Remove all assertions in method bodies.  This is for the benefit of inlining, which
	fails to recognise and disregard empty method bodies when checking the inlinability
	of sends."

	| newMethods |
	newMethods _ Dictionary new.
	systemAdapter
		showProgressIn: methods
		label: 'Removing assertions ...'
		do: [ :bar :m :i |
			bar value: i.
			(m is: #Assertion) ifFalse: [
				newMethods at: m selector put: m.
				m removeAssertions]].
	
	methods _ newMethods.! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 6/1/2020 14:30:52'!
removeMethodsReferingToGlobals: varList except: methodNames
	"Remove any methods (presumably inlined) that still contain references to the given obsolete global variables."

	| varListAsStrings mVars |
	varListAsStrings _ varList collect: [ :sym | sym asString ].
		(methods keys copyWithoutAll: methodNames) do: [ :sel |
			mVars _ (self findMethodNamed: sel) freeVariableReferences asSet.
			(mVars includesAnyOf: varListAsStrings)
				ifTrue: [methods removeKey: sel ifAbsent: []]]
! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'tpr 2/27/2004 18:49'!
retainMethods: aListOfMethodsToKeep
"add aListOfMethodsToKeep to doNotRemoveMethodList so that they will not be pruned"
	doNotRemoveMethodList ifNil:[doNotRemoveMethodList _ Set new:100].
	doNotRemoveMethodList addAll: aListOfMethodsToKeep.
	^aListOfMethodsToKeep! !

!SlangCCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/26/2020 21:31:40'!
tryMethodInliningWithProgressNotification 
	| pass max progress |
	pass _ 0.
	max _ 12. "More than this is probably due to infinite recursion" 
	progress _ true.
	
	[progress] whileTrue: [
		"repeatedly attempt to inline methods until no further progress is made"
		progress _ false.
		pass > max
			ifTrue: [self notify: 'too many inlining steps, inlining terminated']
			ifFalse: [
				systemAdapter
					showProgressIn: (self sortMethods: methods)
					label:  ('Inlining pass ', (pass _ pass + 1) printString, '...')
					do: [:bar :m :i |
						bar value: i.
						currentMethod _ m.
						(m tryToInlineMethodsIn: self)
							ifTrue: [progress _ true]]]].
! !

!SlangCCodeGenerator methodsFor: 'C types lookup' stamp: 'jpb 5/21/2020 10:55:42'!
extractTypeFor: aVariable fromDeclaration: aVariableDeclaration
	"Eliminate inessentials from aVariableDeclaration to answer a C type without the variable,
	 or initializations etc"
	^typeRepository findTypeFor: aVariable fromDeclaration: aVariableDeclaration! !

!SlangCCodeGenerator methodsFor: 'C types lookup' stamp: 'jpb 6/6/2020 19:11:12'!
findDefaultReturnTypeBy: aSymbol 
	^typeRepository findDefaultReturnTypeBy: aSymbol! !

!SlangCCodeGenerator methodsFor: 'C types lookup' stamp: 'jpb 5/30/2020 16:51:12'!
findDefaultReturnTypeDeclarationString
	"Returns the C type declaration string when no return type for functions was defined"
	^typeRepository findDefaultVariableDeclarationString ! !

!SlangCCodeGenerator methodsFor: 'C types lookup' stamp: 'jpb 5/30/2020 16:50:32'!
findDefaultVariableDeclarationString
	"Returns the C type declaration string when no type was defined"
	^typeRepository findDefaultVariableDeclarationString ! !

!SlangCCodeGenerator methodsFor: 'C types lookup' stamp: 'jpb 5/21/2020 09:56:57'!
isPointerToStructVariableName: varName "<String>"
	^self isTypedPointerToStruct: (self typeOfVariable: varName)! !

!SlangCCodeGenerator methodsFor: 'C types lookup' stamp: 'jpb 5/21/2020 11:07:25'!
isType: typeName kind: typeKind "<String>"
	"Returns true if the given typeName represents a type which is a pointer to a struct"

	(#pointerToStruct = typeKind) ifTrue: [^typeRepository isTypedPointerToStruct: typeName].
	(#struct = typeKind) ifTrue: [^typeRepository isTypeStruct: typeName].
	
	^false! !

!SlangCCodeGenerator methodsFor: 'C types lookup' stamp: 'jpb 5/21/2020 09:56:57'!
isTypedPointerToStruct: type "<String>"
	"Returns true if the given typeName represents a type which is a pointer to a struct"
	^typeRepository isTypedPointerToStruct: type! !

!SlangCCodeGenerator methodsFor: 'C types lookup' stamp: 'jpb 5/21/2020 11:04:22'!
isVariable: variableName inDeclaration: typeDeclaration kind: typeKind
	"Returns true if the given variableName is in a C type declaration of the given typeKind"
	| extractedType |
	extractedType _ self extractTypeFor: variableName
							fromDeclaration: typeDeclaration.
	
	extractedType ifNil: [^false].
	
	^self isType: extractedType kind: typeKind. ! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 10/5/2009 13:48'!
generateAddressOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPut: $(; nextPut: $&.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateAnd: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' && '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'ar 10/3/1998 13:45'!
generateAsFloat: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((double) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' )'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/15/2009 16:38'!
generateAsInteger: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((sqInt)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 5/19/2020 22:45:26'!
generateAsSymbol: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 The receiver is expected to be a TConstantNode."

	aStream nextPutAll: (self findFunctionNameFor: msgNode receiver nameOrValue)! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/15/2009 16:38'!
generateAsUnsignedInteger: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((usqInt)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 6/24/2010 09:33'!
generateAt: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $[.
	msgNode args first emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
	aStream nextPut: $]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 6/24/2010 09:33'!
generateAtPut: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $[.
	msgNode args first emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
	aStream nextPutAll: '] = '.
	self emitCExpression: msgNode args last on: aStream! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 7/8/2008 20:21'!
generateBetweenAnd: msgNode on: aStream indent: level
	"Generate the C code for the between:and: message onto the given stream."

	aStream nextPutAll: '(('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' >= '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') && ('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' <= '.
	self emitCExpression: msgNode args second on: aStream.
	aStream nextPutAll: '))'! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateBitAnd: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' & '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/22/2011 11:42'!
generateBitClear: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream next: 2 put: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' | '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') - '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 7/16/2009 13:46'!
generateBitInvert32: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPut: $~.
	self emitCExpression: msgNode receiver on: aStream! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateBitOr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' | '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'ikp 8/4/2004 16:29'!
generateBitShift: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| arg rcvr |
	arg _ msgNode args first.
	rcvr _ msgNode receiver.
	arg isConstant ifTrue: [
		"bit shift amount is a constant"
		aStream nextPutAll: '((usqInt) '.
		self emitCExpression: rcvr on: aStream.
		arg value < 0 ifTrue: [
			aStream nextPutAll: ' >> ', arg value negated printString.
		] ifFalse: [
			aStream nextPutAll: ' << ', arg value printString.
		].
		aStream nextPutAll: ')'.
	] ifFalse: [
		"bit shift amount is an expression"
		aStream nextPutAll: '(('.
		self emitCExpression: arg on: aStream.
		aStream nextPutAll: ' < 0) ? ((usqInt) '.
		self emitCExpression: rcvr on: aStream.
		aStream nextPutAll: ' >> -'.
		self emitCExpression: arg on: aStream.
		aStream nextPutAll: ') : ((usqInt) '.
		self emitCExpression: rcvr on: aStream.
		aStream nextPutAll: ' << '.
		self emitCExpression: arg on: aStream.
		aStream nextPutAll: '))'.
	].! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateBitXor: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' ^ '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/11/2009 13:53'!
generateCCoercion: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	aStream nextPutAll: msgNode args last value.
	aStream nextPutAll: ') '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)

! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'ikp 6/9/2004 16:14'!
generateDivide: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| rcvr arg divisor |
	rcvr _ msgNode receiver.
	arg _ msgNode args first.
	(arg isConstant and:
	 [UseRightShiftForDivide and:
	 [(divisor _ arg value) isInteger and:
	 [divisor isPowerOfTwo and:
	 [divisor > 0 and:
	 [divisor <= (1 bitShift: 31)]]]]])
	ifTrue: [
		"use signed (arithmetic) right shift instead of divide"
		aStream nextPutAll: '((sqInt) '.
		self emitCExpression: rcvr on: aStream.
		aStream nextPutAll: ' >> ', (divisor log: 2) asInteger printString.
		aStream nextPutAll: ')'.
	] ifFalse: [
		self emitCExpression: rcvr on: aStream.
		aStream nextPutAll: ' / '.
		self emitCExpression: arg on: aStream].
! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 06:24'!
generateDoWhileFalse: msgNode on: aStream indent: level
	"Generate do {stmtList} while(!!(cond))"

	| stmts testStmt |
	stmts _ msgNode receiver statements asOrderedCollection.
	testStmt _ stmts removeLast.
	msgNode receiver setStatements: stmts.
	aStream nextPutAll: 'do {'; cr.
	msgNode receiver emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '} while(!!('.
	testStmt asExpression emitCCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: '))'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 06:24'!
generateDoWhileTrue: msgNode on: aStream indent: level
	"Generate do {stmtList} while(cond)"

	| stmts testStmt |
	stmts _ msgNode receiver statements asOrderedCollection.
	testStmt _ stmts removeLast.
	msgNode receiver setStatements: stmts.
	aStream nextPutAll: 'do {'; cr.
	msgNode receiver emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '} while('.
	testStmt asExpression emitCCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: ')'.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateEqual: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' == '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 5/19/2020 22:46:16'!
generateFlag: msgNode on: aStream indent: level
	"Compoensate for the use of self flag: #aSymbol.  We used to translate  symbols
	 as strings unless they were quoted via #aSymbol asSymbol. But this is too tedious,
	 so we now translate symbols directly.  The only use that this affected was in
		 self flag: #aSymbol,
	 so hard-code it to produce a string value.  Note that this isn't strictly necessary
	 because there's a
		#define flag(foo) 0
	 in C land, but it makes the generated C less dissonant."

	aStream
		nextPutAll: 'flag(';
		nextPutAll: (self findLiteralFor: msgNode args last value asString);
		nextPut: $)! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateGreaterThan: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' > '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateGreaterThanOrEqual: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' >= '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: ' 2/7/08 14:57'!
generateIfFalse: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if (!!('.
			msgNode receiver emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
			aStream nextPutAll: ')) {'; cr.
			msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
			level timesRepeat: [aStream tab].
			aStream nextPut: $}]
		ifNotNil:
			[:const |
			const ifFalse:
				[msgNode args first emitCCodeOn: aStream level: level generator: self]]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 6/6/2020 14:23:01'!
generateIfFalseAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: '(!!('.
			 msgNode receiver emitCCodeAsArgumentOn: aStream level: 0 generator: self.
			aStream nextPut: $); newLine; tab: level + 1; nextPut: $?; space.
			msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream newLine; tab: level + 1; nextPutAll: ': 0)']
		ifNotNil:
			[:const|
			const ifFalse:
				[msgNode args first emitCCodeAsArgumentOn: aStream level: level generator: self]]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 10/24/2010 16:15'!
generateIfFalseIfTrue: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if ('.
			msgNode receiver emitCCodeAsExpressionOn: aStream level: level generator: self.
			aStream nextPutAll: ') {'; cr.
			msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}; nextPutAll: ' else {'; cr.
			msgNode args first emitCCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}]
		ifNotNil:
			[:const |
			 (const ifTrue: [msgNode args last] ifFalse: [msgNode args first])
				emitCCodeOn: aStream level: level generator: self]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 6/6/2020 14:23:10'!
generateIfFalseIfTrueAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			msgNode receiver emitCCodeAsArgumentOn: aStream level: level generator: self.
			aStream newLine; tab: level + 1; nextPut: $?; space.
			msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream newLine; tab: level + 1; nextPut: $:; space.
			msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream nextPut: $)]
		ifNotNil:
			[:const|
			(const
				ifTrue: [msgNode args last]
				ifFalse: [msgNode args first])
					emitCCodeAsArgumentOn: aStream level: level generator: self]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: ' 2/7/08 14:57'!
generateIfTrue: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if ('.
			msgNode receiver emitCCodeAsExpressionOn: aStream level: level generator: self.
			aStream nextPutAll: ') {'; cr.
			msgNode args first emitCCodeOn: aStream level: level + 1 generator: self.
			level timesRepeat: [ aStream tab ].
			aStream nextPut: $}]
		ifNotNil:
			[:const |
			const ifTrue:
				[msgNode args first emitCCodeOn: aStream level: level generator: self]]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 6/6/2020 14:22:50'!
generateIfTrueAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			 msgNode receiver emitCCodeAsArgumentOn: aStream level: level generator: self.
			 aStream newLine; tab: level + 1; nextPut: $?; space.
			 msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			 aStream newLine; tab: level + 1; nextPutAll: ': 0)']
		ifNotNil:
			[:const|
			const ifTrue:
				[msgNode args first emitCCodeAsArgumentOn: aStream level: level generator: self]]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 6/6/2020 19:14:59'!
generateIfTrueIfFalse: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	
	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if ('.
			msgNode receiver emitCCodeAsExpressionOn: aStream level: level generator: self.
			aStream nextPutAll: ') {'; newLine.
			msgNode args first emitCCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}; nextPutAll: ' else {'; newLine.
			msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}]
		ifNotNil:
			[:const |
			(const ifTrue: [msgNode args first] ifFalse: [msgNode args last])
				emitCCodeOn: aStream level: level generator: self]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 6/6/2020 14:23:25'!
generateIfTrueIfFalseAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			msgNode receiver emitCCodeAsArgumentOn: aStream level: level generator: self.
			aStream newLine; tab: level + 1; nextPut: $?; space.
			msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream newLine; tab: level + 1; nextPut: $:; space.
			msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream nextPut: $)]
		ifNotNil:
			[:const|
			(const ifTrue: [msgNode args first] ifFalse: [msgNode args last])
				emitCCodeAsArgumentOn: aStream level: level generator: self]! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 9/25/2010 10:13'!
generateInlineDirective: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '/* inline: '.
	aStream nextPutAll: msgNode args first value asString.
	aStream nextPutAll: ' */'.
! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateIntegerObjectOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' << 1) | 1)'.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateIntegerValueOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '('.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' >> 1)'.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateIsIntegerObject: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '('.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' & 1)'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 5/19/2020 22:46:16'!
generateIsNil: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' == '.
	aStream nextPutAll: (self findLiteralFor: nil).! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateLessThan: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' < '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateLessThanOrEqual: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' <= '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateMax: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' < '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') ? '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' : '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateMin: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' < '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') ? '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' : '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ')'.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateMinus: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' - '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateModulo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' % '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 7/8/2008 17:47'!
generateNegated: msgNode on: aStream indent: level
	"Generate the C code for teh negated message onto the given stream."

	aStream nextPut: $-.
	self emitCExpression: msgNode receiver on: aStream! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateNot: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '!!'.
	self emitCExpression: msgNode receiver on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateNotEqual: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' !!= '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 5/19/2020 22:46:16'!
generateNotNil: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' !!= '.
	aStream nextPutAll: (self findLiteralFor: nil).! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateOr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' || '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 1/18/2009 23:34'!
generatePerform: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $(.
	(msgNode args copyFrom: 2 to: msgNode args size) do:[:arg|
		self emitCExpression: arg on: aStream.
	] separatedBy:[aStream nextPutAll:', '].
	aStream nextPut: $)! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generatePlus: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' + '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'ar 2/15/1999 21:43'!
generateRaisedTo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'pow('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll:')'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 4/11/2011 19:13'!
generateRepeat: msgNode on: aStream indent: level
	"Generate while(1) { stmtList } "

	aStream nextPutAll: 'while(1) {'; cr.
	msgNode receiver emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'
! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 10/24/2010 15:41'!
generateSequentialAnd: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' && ('.
	self emitCTestBlock: msgNode args first on: aStream.
	aStream nextPut: $)! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 10/24/2010 15:41'!
generateSequentialOr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	"Note: PP 2.3 compiler produces two arguments for or:, presumably
	 to help with inlining later. Taking the last agument should do the correct
	 thing even if your compiler is different."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' || ('.
	self emitCTestBlock: msgNode args last on: aStream.
	aStream nextPutAll: ')'! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateSharedCodeDirective: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '/* common code: '.
	aStream nextPutAll: msgNode args first value.
	aStream nextPutAll: ' */'.
! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateShiftLeft: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' << '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'ikp 8/4/2004 18:25'!
generateShiftRight: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((usqInt) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ')'.
	aStream nextPutAll: ' >> '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/19/2009 16:17'!
generateSignedBitShift: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| arg |
	(arg _ msgNode args first) isConstant
		ifTrue: "bit shift amount is a constant"
			[aStream nextPut: $(; nextPutAll: '(signed)'.
			self emitCExpression: msgNode receiver on: aStream.
			arg value < 0
				ifTrue: [aStream nextPutAll: ' >> ', arg value negated printString]
				ifFalse: [aStream nextPutAll: ' << ', arg value printString].
			aStream nextPut: $)]
		ifFalse: "bit shift amount is an expression"
			[aStream nextPutAll: '(('.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: ' < 0) ? ('; nextPutAll: '(signed)'.
			self emitCExpression: msgNode receiver on: aStream.
			aStream nextPutAll: ' >> -'.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: ') : ('; nextPutAll: '(signed)'.
			self emitCExpression: msgNode receiver on: aStream.
			aStream nextPutAll: ' << '.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: '))']! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/5/2009 10:27'!
generateSignedIntFromLong: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((sqInt) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/2/2009 20:48'!
generateSignedIntFromShort: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((short)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/5/2009 10:28'!
generateSignedIntToLong: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((usqInt) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/5/2009 10:28'!
generateSignedIntToShort: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((usqInt) (short)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/26/2009 10:18'!
generateSmalltalkMetaError: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: 'error("'; nextPutAll: msgNode selector; nextPutAll: '")'! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateTimes: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' * '.
	self emitCExpression: msgNode args first on: aStream.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 6/2/2020 21:23:14'!
generateToByDo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	"N.B. MessageNode>>asTranslatorNodeIn: adds the limit var as a hidden fourth argument."
	| blockExpr iterationVar limitExpr mayHaveSideEffects limitVar step negative |
	blockExpr _ msgNode args third.
	blockExpr args size = 1 ifFalse:
		[self error: 'wrong number of block arguments'].

	iterationVar _ blockExpr args first.
	limitExpr _ msgNode args first.
	
	aStream nextPutAll: 'for (', iterationVar, ' = '.
	self emitCExpression: msgNode receiver on: aStream.
	
	mayHaveSideEffects _ msgNode args size = 4. "See TMethod>>prepareMethodIn:"
	mayHaveSideEffects ifTrue:
		[limitVar _ msgNode args last.
		 aStream nextPutAll: ', ', limitVar name, ' = '.
		 self emitCExpression: limitExpr on: aStream.
		 limitExpr _ limitVar].
	
	aStream nextPutAll: '; ', iterationVar.
	negative _ ((step _ msgNode args at: 2) isConstant and: [step value < 0])
				or: [step isSend and: [step selector == #negated
					and: [step receiver isConstant and: [step receiver value >= 0]]]].
			
	aStream nextPutAll: (negative ifTrue: [' >= '] ifFalse: [' <= ']).
	
	self emitCExpression: limitExpr on: aStream.
	aStream nextPutAll: '; ', iterationVar, ' += '.
	
	self emitCExpression: step on: aStream.
	aStream nextPutAll: ') {'; newLine.
	
	blockExpr emitCCodeOn: aStream level: level + 1 generator: self.
	aStream tab: level.
	
	aStream nextPut: $}! !

!SlangCCodeGenerator methodsFor: 'C translation'!
generateToDo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| iterationVar |
	(msgNode args last args size = 1) ifFalse: [
		self error: 'wrong number of block arguments'.
	].
	iterationVar _ msgNode args last args first.
	aStream nextPutAll: 'for (', iterationVar, ' = '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: '; ', iterationVar, ' <= '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: '; ', iterationVar, '++) {'; cr.
	msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'tpr 7/26/2003 10:23'!
generateTouch: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream - which is to say absolutely nothing"
! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 5/26/2020 21:11:33'!
generateValue: aTSendNode on: aStream indent: level
	"Reduce [:formal ... :formalN| body ] value: actual ... value: actualN
	 to body with formals substituted for by actuals."
	| substitution substitutionDict newLabels |
	self assert: aTSendNode receiver isStmtList.
	self assert: aTSendNode receiver args size = aTSendNode args size.
	substitution _ aTSendNode receiver copy.
	substitution renameLabelsForInliningInto: currentMethod.
	substitutionDict _ Dictionary new: aTSendNode args size * 2.
	aTSendNode receiver args with: aTSendNode args do:
		[ :argName :exprNode |
		substitutionDict at: argName put: exprNode].
	substitution
		bindVariablesIn: substitutionDict;
		emitCCodeOn: aStream level: level generator: self.
	newLabels _ Set withAll: currentMethod labels.
	substitution nodesDo:
		[:node| (node is: #Label) ifTrue: [node label ifNotNil: [:label| newLabels add: label]]].
	"now add the new labels so that a subsequent inline of
	 the same block will be renamed with different labels."
	currentMethod labels: newLabels! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 6/3/2020 00:04:45'!
generateValueAsArgument: aTSendNode on: aStream indent: level
	"Reduce [:formal ... :formalN| body ] value: actual ... value: actualN
	 to body with formals substituted for by actuals."
	| substitution substitutionDict newLabels |
	self assert: aTSendNode receiver isStmtList.
	self assert: aTSendNode receiver args size = aTSendNode args size.
	
	substitution _ aTSendNode receiver copy.
	substitution renameLabelsForInliningInto: currentMethod.
	substitutionDict _ Dictionary new: aTSendNode args size * 2.
	
	aTSendNode receiver args with: aTSendNode args do:
		[ :argName :exprNode |
		substitutionDict at: argName put: exprNode].
	
	substitution
		bindVariablesIn: substitutionDict;
		emitCCodeAsArgumentOn: aStream level: level generator: self.
		
	newLabels _ Set withAll: currentMethod labels.
	substitution nodesDo:
		[:node| (node is: #Label) ifTrue: [node label ifNotNil: [:label| newLabels add: label]]].
		
	"now add the new labels so that a subsequent inline of
	 the same block will be renamed with different labels."
	currentMethod labels: newLabels! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'acg 12/22/1999 01:41'!
generateWhileFalse: msgNode on: aStream indent: level
	"Generate C code for a loop in one of the following formats, as appropriate:
		while(!!(cond)) { stmtList }
		do {stmtList} while(!!(cond))
		while(1) {stmtListA; if (cond) break; stmtListB}"

	msgNode receiver statements size <= 1
		ifTrue: [^self generateWhileFalseLoop: msgNode on: aStream indent: level].
	msgNode args first isNilStmtListNode
		ifTrue: [^self generateDoWhileFalse: msgNode on: aStream indent: level].
	^self generateWhileForeverBreakTrueLoop: msgNode on: aStream indent: level! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'acg 12/22/1999 01:41'!
generateWhileFalseLoop: msgNode on: aStream indent: level
	"Generate while(!!(cond)) {stmtList}."

	aStream nextPutAll: 'while (!!('.
	self emitCTestBlock: msgNode receiver on: aStream.
	aStream nextPutAll: ')) {'; cr.
	msgNode args first isNilStmtListNode ifFalse:
		[msgNode args first emitCCodeOn: aStream level: level + 1 generator: self].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 06:28'!
generateWhileForeverBreakFalseLoop: msgNode on: aStream indent: level
	"Generate while(1) {stmtListA; if(!!(cond)) break; stmtListB}."

	| stmts testStmt |
	stmts _ msgNode receiver statements asOrderedCollection.
	testStmt _ stmts removeLast.
	msgNode receiver setStatements: stmts.
	level - 1 timesRepeat: [ aStream tab ].
	aStream nextPutAll: 'while (1) {'; cr.
	msgNode receiver emitCCodeOn: aStream level: level + 1 generator: self.
	(level + 1) timesRepeat: [ aStream tab ].
	aStream nextPutAll: 'if (!!('.
	testStmt asExpression emitCCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: ')) break;'; cr.
	msgNode args first emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 06:28'!
generateWhileForeverBreakTrueLoop: msgNode on: aStream indent: level
	"Generate while(1) {stmtListA; if(cond) break; stmtListB}."

	| stmts testStmt |
	stmts _ msgNode receiver statements asOrderedCollection.
	testStmt _ stmts removeLast.
	msgNode receiver setStatements: stmts.
	level - 1 timesRepeat: [ aStream tab ].
	aStream nextPutAll: 'while (1) {'; cr.
	msgNode receiver emitCCodeOn: aStream level: level + 1 generator: self.
	(level + 1) timesRepeat: [ aStream tab ].
	aStream nextPutAll: 'if ('.
	testStmt asExpression emitCCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: ') break;'; cr.
	msgNode args first emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'acg 12/22/1999 01:41'!
generateWhileTrue: msgNode on: aStream indent: level
	"Generate C code for a loop in one of the following formats, as appropriate:
		while(cond) { stmtList }
		do {stmtList} while(cond)
		while(1) {stmtListA; if (!!(cond)) break; stmtListB}"

	msgNode receiver statements size <= 1
		ifTrue: [^self generateWhileTrueLoop: msgNode on: aStream indent: level].
	msgNode args first isNilStmtListNode
		ifTrue: [^self generateDoWhileTrue: msgNode on: aStream indent: level].
	^self generateWhileForeverBreakFalseLoop: msgNode on: aStream indent: level! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'acg 12/22/1999 01:38'!
generateWhileTrueLoop: msgNode on: aStream indent: level
	"Generate while(cond) {stmtList}."

	aStream nextPutAll: 'while ('.
	self emitCTestBlock: msgNode receiver on: aStream.
	aStream nextPutAll: ') {'; cr.
	msgNode args first isNilStmtListNode ifFalse:
		[msgNode args first emitCCodeOn: aStream level: level + 1 generator: self].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!SlangCCodeGenerator methodsFor: 'C translation' stamp: 'jpb 6/1/2020 15:31:54'!
initializeTranslationDictionary 
	"Initialize the dictionary mapping message names to actions for C code generation."

	| pairs |
	super initializeTranslationDictionary.
	
	pairs _ #(	
	#flag:						#generateFlag:on:indent:
	
	#value								#generateValue:on:indent:
	#value:								#generateValue:on:indent:
	#value:value:						#generateValue:on:indent:
	).

	1 to: pairs size by: 2 do: [:i |
		translationDict at: (pairs at: i) put: (pairs at: i + 1)].

	pairs _ #(
		#ifTrue:					#generateIfTrueAsArgument:on:indent:	
		#ifFalse:				#generateIfFalseAsArgument:on:indent:
		#ifTrue:ifFalse:		#generateIfTrueIfFalseAsArgument:on:indent:
		#ifFalse:ifTrue:		#generateIfFalseIfTrueAsArgument:on:indent:

		#value					#generateValueAsArgument:on:indent:
		#value:					#generateValueAsArgument:on:indent:
		#value:value:			#generateValueAsArgument:on:indent:
	).

	asArgumentTranslationDict _ Dictionary new: 8.
	1 to: pairs size by: 2 do: [:i |
		asArgumentTranslationDict at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangCCodeGenerator class methodsFor: 'class initialization' stamp: 'jm 8/19/1998 10:03'!
initialize
	"CCodeGenerator initialize"

	UseRightShiftForDivide _ true.
		"If UseRightShiftForDivide is true, the translator will generate a right-shift when it encounters a division by a constant that is a small power of two. For example, 'x / 8' will generate '((int) x >> 3)'. The coercion to int is done to make it clear that the C compiler should generate a signed shift."
		"Note: The Kernighan and Ritchie 2nd Edition C manual, p. 49, leaves the semantics of right-shifting a negative number open to the discretion of the compiler implementor. However, it strongly suggests that most compilers should generate an arithmetic right shift (i.e., shifting in the sign bit), which is the same as dividing by a power of two. If your compiler does not generate or simulate an arithmetic shift, then make this class variable false and re-translate."
! !

!SlangCLanguageWriter methodsFor: 'writing comments' stamp: 'jpb 5/19/2020 17:55:16'!
nextPutComment: commentString
	"Writes out a long C comment /* ...  */"
	self nextPutCommentStart.
	self nextPutAll: commentString.
	self nextPutCommentEnd.
	self newLine.! !

!SlangCLanguageWriter methodsFor: 'writing comments' stamp: 'jpb 5/19/2020 17:55:51'!
nextPutCommentEnd
	self nextPutAll: ' */'.! !

!SlangCLanguageWriter methodsFor: 'writing comments' stamp: 'jpb 5/19/2020 17:55:36'!
nextPutCommentStart
	self nextPutAll: '/* '.! !

!SlangCLanguageWriter methodsFor: 'writing comments' stamp: 'jpb 6/2/2020 21:50:24'!
nextPutSectionComment: header
	stream nextPutAll: '/*** ' , header , ' ***/'; newLine.! !

!SlangCLanguageWriter methodsFor: 'writing strings' stamp: 'jpb 6/3/2020 15:54:42'!
emitEscapedChar: char on: stringStream
	"Finds an escaped version of the given string and emits it on the given stream. When no presentation was found just emit the character"
	
	tabChar = char ifTrue: [ stringStream nextPutAll: '\t'. ^self ].
	lfChar = char ifTrue: [ stringStream nextPutAll: '\n'. ^self ].
	crChar = char ifTrue: [ stringStream nextPutAll: '\r'. ^self ].
	
	$" = char ifTrue: [ stringStream nextPutAll: '\"'. ^self ].
	$' = char ifTrue: [ stringStream nextPutAll: '\'''. ^self ].
	$? = char ifTrue: [ stringStream nextPutAll: '\?'. ^self ].
	$\ = char ifTrue: [ stringStream nextPutAll: '\\'. ^self ].
	(otherUnescapedChars includes: char) ifTrue: [ stringStream nextPut: char. ^self ].
	
	7 = char asciiValue ifTrue: [ stringStream nextPutAll: '\a'. ^self ].
	8 = char asciiValue ifTrue: [ stringStream nextPutAll: '\b'. ^self].
				
	spaceChar = char ifTrue: [ stringStream nextPut: spaceChar. ^self ].
	char isAlphaNumeric ifTrue: [ stringStream nextPut: char. ^self].
	
	char numericValue <= 255 ifTrue: [ |hexString|
		hexString _ char numericValue printStringBase: 16 length: 2 padded: true.
		stringStream nextPutAll: '\x' , hexString. ^self]! !

!SlangCLanguageWriter methodsFor: 'writing strings' stamp: 'jpb 6/3/2020 07:40:00'!
escapeString: aString 
	^String streamContents: [:stringStream | 
		aString do: [:char | self emitEscapedChar: char on: stringStream ].
	]! !

!SlangCLanguageWriter methodsFor: 'writing strings' stamp: 'jpb 6/3/2020 16:01:59'!
nextPutString: newString
	| stringSize |
	stringSize _ newString size.
	
	self nextPutStringStart.
	charsOnLine > 77 ifTrue: [ self nextPut: $\. self newLine ].
	
	(1 to: stringSize by: 78) do: [:sliceStart |
		| sliceSize |
		sliceSize _  (stringSize - sliceStart).
		sliceSize > 78 ifTrue: [ sliceSize _ 78 ].
		sliceSize _ sliceSize - charsOnLine.
		
		self nextPutAll: (self escapeString: (newString copyFrom: sliceStart count: sliceSize)).
		
		(sliceStart + sliceSize) >= stringSize
			ifFalse: [ self nextPut: $\. self newLine ].
	].
	self nextPutStringEnd.! !

!SlangCLanguageWriter methodsFor: 'writing strings' stamp: 'jpb 5/19/2020 18:08:52'!
nextPutStringEnd
	self nextPut: $".! !

!SlangCLanguageWriter methodsFor: 'writing strings' stamp: 'jpb 5/19/2020 18:08:45'!
nextPutStringStart
	self nextPut: $".! !

!SlangCLanguageWriter methodsFor: 'writing arrays' stamp: 'jpb 5/19/2020 22:29:04'!
nextPutArray: array
	| first |
	first _ true.
	1 to: array size do:
		[:i |
			first 
				ifTrue: [first _ false]
				ifFalse: [stream nextPutAll: ', '].
			i \\ 16 = 1 ifTrue: [stream newLine].
		
			self nextPutInteger: (array at: i)]! !

!SlangCLanguageWriter methodsFor: 'writing arrays' stamp: 'jpb 5/19/2020 22:29:51'!
nextPutInteger: aNumber
	stream print: aNumber.
	(aNumber between: -2147483648 and: 2147483647)
		ifFalse: [(aNumber between: 2147483648 and: 4294967295)
			ifTrue: [stream nextPut: $U]
			ifFalse: [stream nextPut: $L]]! !

!SlangCLanguageWriter methodsFor: 'writing macros' stamp: 'jpb 5/20/2020 21:36:15'!
nextPutConstantNamed: constantName value: constantValue 
	self nextPutAll: '#define '.
	self nextPutAll: constantName asString.
	self space.
	self nextPutAll: constantValue asString.! !

!SlangCLanguageWriter methodsFor: 'writing macros' stamp: 'jpb 5/24/2020 16:20:01'!
nextPutInclude: aString 
	"Puts a standard include into the stream. So a include directive which searches only in standard locations for headers"
	self nextPutAll: '#include ' , '<' , aString , '.h>'! !

!SlangCLanguageWriter methodsFor: 'writing macros' stamp: 'jpb 5/24/2020 16:21:40'!
nextPutLocalInclude: aString 
	"Puts a local #include into the stream. So a include directive which searches first in the current directory and then tries to find other places"
	self nextPutAll: '#include ' , '"' , aString , '.h"'! !

!SlangCLanguageWriter methodsFor: 'initialization' stamp: 'jpb 6/6/2020 23:04:30'!
initialize
	super initialize.
	
	tabChar _ Character tab.
	lfChar _ Character lf.
	crChar _ Character cr.
	spaceChar _ Character space.
	otherUnescapedChars _ #($!! $# $$ $% $& $( $) $* $+ $- $_ $, $. $/ $: $; $< $= $> $@ $[ $] $^ $`)! !

!SlangCLanguageWriter methodsFor: 'as yet unclassified' stamp: 'jpb 6/6/2020 19:14:33'!
nextPutReturn: aTypeMapping 
	self nextPutAll: 'return ' , aTypeMapping asString , ';'! !

!SlangCLanguageWriter class methodsFor: 'target language helpers' stamp: 'jpb 5/20/2020 21:34:39'!
findIntegerLiteral: anObject
	"Returns an appropriate representation of the given object as a C integer literal"
	| printString |
	
	printString _ (anObject > 0
						and: [(anObject >> anObject lowBit + 1) isPowerOfTwo
						and: [(anObject highBit = anObject lowBit and: [anObject > 65536])
						or: [anObject highBit - anObject lowBit >= 4]]])
								ifTrue: ['0x', (anObject printStringBase: 16)]
								ifFalse: [anObject printString].

	^printString , (self findIntegerLiteralSuffixFor: anObject)! !

!SlangCLanguageWriter class methodsFor: 'target language helpers' stamp: 'jpb 5/20/2020 19:10:55'!
findIntegerLiteralSuffixFor: anObject
	"Returns the appropriate C integer suffix for representing a typed integer suffix"
	
	anObject > 16rFFFFFFFF ifTrue: [^self unsignedLongLongSuffix ].
	anObject < 16r7FFFFFFF ifFalse: [^self unsignedIntegerSuffix ].
	
	^''! !

!SlangCLanguageWriter class methodsFor: 'target language helpers' stamp: 'jpb 5/20/2020 17:25:14'!
unsignedIntegerSuffix
	"Answer the suffix that should be appended to unsigned integer literals in generated code."

	^ 'U'! !

!SlangCLanguageWriter class methodsFor: 'target language helpers' stamp: 'jpb 5/20/2020 17:25:31'!
unsignedLongLongSuffix
	"Answer the suffix that should be appended to unsigned integer literals in generated code."

	^'ULL'! !

!SlangBrowser methodsFor: '*Slang-C' stamp: 'jpb 5/30/2020 21:57:41'!
showCSource: aBoolean
	aBoolean
		ifTrue: [ self contentsSymbol: #slangCSource ]
		ifFalse: [ self contentsSymbol: #source ]! !

!SlangBrowser methodsFor: '*Slang-C' stamp: 'jpb 5/30/2020 21:55:07'!
showingCSource
	^self contentsSymbol == #slangCSource! !

!SlangBrowser methodsFor: '*Slang-C' stamp: 'jpb 5/30/2020 21:53:52'!
showingCSourceString
	^ (self showingCSource 
		ifTrue:
			['<yes>']
		ifFalse:
			['<no>']), 'C source'! !

!SlangBrowser methodsFor: '*Slang-C' stamp: 'jpb 5/30/2020 21:53:07'!
toggleShowCSource
	self showCSource: self showingCSource not! !

!SlangBrowser methodsFor: '*Slang-C' stamp: 'jpb 6/1/2020 14:30:52'!
translatedCSource
	"Returns the C source of the selected class using Slang as generating"
	 | selectedClass selector codeGenerator translatedSource methodNode |
	selectedClass _ self selectedClassOrMetaClass.
	
	(selectedClass isNil or: [(selector _ self selectedMessageName) isNil]) ifTrue: [^ ''].
	selectedClass compiledMethodAt: selector ifAbsent: [^ ''].

	codeGenerator _ SlangCCodeGenerator new initialize.
	codeGenerator declareMethodsStatic: false.
	codeGenerator permitMethodPruning: true.
	codeGenerator prepareMethodsInlined: false doAssertions: true.
	
	codeGenerator addClass: selectedClass.
	methodNode _ codeGenerator findMethodNamed: selector.
	translatedSource _ ReadWriteStream on: String new.
	methodNode emitCCodeOn: translatedSource generator: codeGenerator.
	
	^translatedSource contents! !

!SlangTParseNode methodsFor: '*Slang-C' stamp: ' 2/7/08 14:57'!
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	^self emitCCodeOn: aStream level: level generator: aCodeGen! !

!SlangTParseNode methodsFor: '*Slang-C' stamp: ' 2/7/08 14:57'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitCCodeOn: aStream level: level generator: aCodeGen! !

!SlangTParseNode methodsFor: '*Slang-C' stamp: 'nk 4/5/2005 21:02'!
emitCCodeOn: aStream level: lev generator: gen
	self subclassResponsibility.! !

!SlangTParseNode methodsFor: '*Slang-C' stamp: 'hg 8/14/2000 16:13'!
emitCCommentOn: aStream level: level
	"Emit the transferred Smalltalk comments as C comments."

	comment ifNotNil: [
		comment isString ifTrue: [^self].	"safety catch"
		aStream cr.
		1 to: comment size do: [:index | 
			aStream 
				tab: level;
				nextPutAll: '/* ';
				nextPutAll: (comment at: index);
				nextPutAll: ' */';
				cr].
		aStream cr]! !

!SlangTAssignmentNode methodsFor: '*Slang-C' stamp: 'eem 6/28/2011 10:57'!
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	aStream nextPut: $(.
	self emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPut: $)! !

!SlangTAssignmentNode methodsFor: '*Slang-C' stamp: ' 2/7/08 14:57'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	aStream nextPut: $(.
	self emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPut: $)! !

!SlangTAssignmentNode methodsFor: '*Slang-C' stamp: 'jpb 6/1/2020 14:30:52'!
emitCCodeOn: aStream level: level generator: aCodeGen
	expression isSwitch ifTrue:
		[^expression emitCCodeOn: aStream addToEndOfCases: self level: level generator: aCodeGen].
		
	variable emitCCodeOn: aStream level: level generator: aCodeGen.
	
	self isVariableUpdatingAssignment
		ifTrue:
			[aStream
				space;
				nextPutAll: expression selector;	"+ or -"
				nextPut: $=;
				space.
			expression args first emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen]
		ifFalse:
			[| vartype |
			 aStream space; nextPut: $=; space.
			 "Add an appropriate cast if we need to do so"
			 vartype _ aCodeGen typeOfVariable: variable name.
			 vartype _ aCodeGen declToType: vartype.
			
			 ((expression isMemberOf: SlangTSendNode) and: [vartype ~= nil])
				ifTrue:
					[| fntype expselector |
					 vartype _ vartype asSymbol.
					 expselector _ expression selector.
					 fntype _ (aCodeGen findMethodNamed: expselector).
					 fntype notNil ifTrue: [ fntype _ fntype returnType ].
					 "The expression may have been inlined"
					 fntype isNil ifTrue: [ fntype _ aCodeGen inlineReturnType: expselector ].
					 (fntype notNil and: [ fntype ~= vartype ] and: [ vartype ~= #void ]) ifTrue:
						[aStream nextPut: $(; nextPutAll: vartype asString; nextPut: $)].
					].
			 expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen]! !

!SlangTCaseStmtNode methodsFor: '*Slang-C' stamp: 'jpb 5/29/2020 20:59:08'!
emitCCodeOn: aStream level: level generator: aCodeGen

	| indent |
	indent _ (String new: level) collect: [ :ch | Character tab ].
	aStream nextPutAll: 'switch ('.
	expression asExpression emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'; newLine.
	
	1 to: cases size do: [ :i |
		(firsts at: i) to: (lasts at: i) do: [ :caseIndex |
			aStream nextPutAll: indent, 'case ', caseIndex printString, ':'; newLine.
		].
		(cases at: i) emitCCodeOn: aStream level: level + 1 generator: aCodeGen.
		aStream nextPutAll: indent; tab; nextPutAll: 'break;'.
		aStream newLine.
	].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!SlangTConstantNode methodsFor: '*Slang-C' stamp: 'jpb 5/19/2020 22:46:16'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C literal."

	aStream nextPutAll: (aCodeGen findLiteralFor: value).! !

!SlangTDefineNode methodsFor: '*Slang-C' stamp: 'ar 7/8/2003 11:08'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C literal."

	aStream nextPutAll: name.! !

!SlangTGoToNode methodsFor: '*Slang-C'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C goto statement."

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.! !

!SlangTInlineNode methodsFor: '*Slang-C' stamp: 'ar 7/6/2003 20:19'!
emitCCodeOn: aStream level: level generator: aCodeGen
	method emitInlineOn: aStream level: level generator: aCodeGen.
! !

!SlangTLabeledCommentNode methodsFor: '*Slang-C'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C comment with optional label."

	self printOptionalLabelOn: aStream.
	aStream nextPutAll: '/* '.
	aStream nextPutAll: comment.
	aStream nextPutAll: ' */'.! !

!SlangTNotImplementedNode methodsFor: '*Slang-C' stamp: 'jpb 5/29/2020 20:59:40'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a comment only"

	aStream newLine; nextPutAll: '/*** ';
		nextPutAll: self printString;
		nextPutAll: ' cannot translate: '; newLine;
		nextPutAll: parseNode printString;
		newLine; nextPutAll: ' ***/'; newLine
! !

!SlangTReturnNode methodsFor: '*Slang-C' stamp: 'eem 11/7/2009 15:43'!
emitCCodeOn: aStream level: level generator: aCodeGen

	(expression isSwitch
	 or: [expression isCaseStmt]) ifTrue:
		[^expression emitCCodeOn: aStream addToEndOfCases: self level: level generator: aCodeGen].

	('void' = aCodeGen currentMethod returnType) ifTrue: [
		"If the function is void, don't say 'return x' instead say ' x; return' "
		expression isLeaf ifFalse: [
			expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.	
			aStream nextPutAll: ';'; space.
		].
		aStream nextPutAll: 'return'.
	] ifFalse: [
		aStream nextPutAll: 'return'.
		aStream space.
		expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	].! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: 'dtl 10/19/2010 22:20'!
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	"Emit the receiver in a form that can be passed as an argument."

	"If the selector is a built-in construct, translate it and return"
	(aCodeGen emitBuiltinConstructAsArgumentFor: self asExpression on: aStream level: level) ifFalse:
		["If it is a pointer dereference generate it"
		(self emitCCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen) ifFalse:
			["Otherwise generate the vanilla C function call."
			 self emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen]]! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: ' 2/7/08 14:57'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: 'jpb 6/1/2020 14:30:52'!
emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen

	"Translate this message send into a C function call"
	"Special case for pluggable modules. Replace messages to interpreterProxy
	 by interpreterProxy->message(..) if the message is not builtin"
	| fn fnargtypes |
	"Translate this message send into a C function call."
	aStream nextPutAll: (aCodeGen findFunctionNameFor: selector); nextPut: $(.
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it."
	(self shouldIncludeReceiverAsFirstArgument: aCodeGen) ifTrue:
		[receiver emitCCodeOn: aStream level: level generator: aCodeGen.
		arguments isEmpty ifFalse:
			[aStream nextPutAll: ', ']].
		
	fn _ aCodeGen findMethodNamed: self selector.
	fn notNil ifTrue: [ fnargtypes _ fn findArgTypesWith: aCodeGen ].
	fnargtypes notNil ifTrue: [ fnargtypes size = arguments size ifFalse: [ fnargtypes _ nil ] ].
	fnargtypes notNil ifTrue: [ fnargtypes _ fnargtypes collect: [ :a | aCodeGen declToType: a ]].
	
	arguments withIndexDo:
		[ :arg :i | | argtype fnargtype |
		i = 1 ifFalse: [aStream nextPut: $,; space].
		argtype _ nil.
		fnargtype _ nil.
		(arg name notNil) ifTrue: [ argtype _ aCodeGen declToType: (aCodeGen typeOfVariable: arg name) ].
		fnargtypes notNil ifTrue: [ fnargtype _ fnargtypes at: i ].
		"Insert cast of function argument type if necessary"
		(argtype notNil and: fnargtype notNil and: [ argtype ~= fnargtype ]) ifTrue: [ aStream nextPutAll: '(',fnargtype,')'  ]. 
		arg emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $)! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: 'jpb 5/19/2020 22:45:26'!
emitCCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen
	"If appropriate, translate this message send as a pointer dereference"

	(self isStructSend: aCodeGen) ifFalse:
		[^false].

	aStream nextPut: $(.
	receiver  emitCCodeAsExpressionOn: aStream level: 0 generator: aCodeGen.
	aStream nextPut: $-; nextPut: $>.
	aStream nextPutAll: (aCodeGen findFunctionNameFor: selector).
	arguments isEmpty ifFalse:
		[self assert: arguments size = 1.
		 aStream nextPutAll: ' = '.
		 arguments first emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $).
	^true! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: 'eem 7/2/2008 15:44'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit the receiver as a statement."

	"If the selector is a built-in construct, translate it and return"
	(aCodeGen emitBuiltinConstructFor: self on: aStream level: level) ifFalse:
		["If it is a pointer dereference generate it"
		(self emitCCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen) ifFalse:
			["Otherwise generate the vanilla C function call."
			 self emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen]]! !

!SlangTSendNode methodsFor: '*Slang-C'!
inlineMethodsUsing: aDictionary

	arguments _ arguments collect: [ :arg |
		arg inlineMethodsUsing: aDictionary.
	].
	"xxx inline this message if it is in the dictionary xxx"! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: 'eem 10/24/2013 12:57'!
isSelfReference: varNode in: aCodeGen
	^(varNode name beginsWith: 'self')
	  and: [varNode name = 'self' or: [varNode name beginsWith: 'self_in_']]! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: 'eem 10/24/2013 13:01'!
isStructReference: varNode in: aCodeGen
	^(varNode structTargetKindIn: aCodeGen) notNil! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: 'jpb 6/1/2020 14:30:52'!
shouldExcludeReceiverAsFirstArgument: aCodeGen
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the method's definingClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it.
		 If it is a struct send of something the vm says is an implicit variable, don't include it."
	| m |
	(aCodeGen isAssertSelector: selector) ifTrue:
		[^true].

	(receiver isSend
	 and: [(receiver receiver is: #Variable)
	 and: [(self isSelfReference: receiver receiver in: aCodeGen)
		or: [self isStructReference: receiver receiver in: aCodeGen]]]) ifTrue:
		[^aCodeGen isNonArgumentImplicitReceiverVariableName: receiver selector].

	^(receiver is: #Variable)
	    and: [(aCodeGen isNonArgumentImplicitReceiverVariableName: receiver name)
		    or: [(self isSelfReference: receiver in: aCodeGen)
			    and: [(m _ aCodeGen findMethodNamed: selector) isNil
					or: [m typeForSelf == #implicit]]]]! !

!SlangTSendNode methodsFor: '*Slang-C' stamp: 'eem 2/11/2009 17:00'!
shouldIncludeReceiverAsFirstArgument: aCodeGen
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it."
	^(self shouldExcludeReceiverAsFirstArgument: aCodeGen) not! !

!SlangTStmtListNode methodsFor: '*Slang-C' stamp: 'jpb 5/26/2020 21:09:15'!
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen

	| statementWasComment |
	statementWasComment _ false.
	statements
		do:
			[:s |
			s emitCCommentOn: aStream level: level.
			s emitCCodeAsArgumentOn: aStream level: 0 generator: aCodeGen.
			statementWasComment _ s is: #Comment]
		separatedBy:
			[((self endsWithCloseBracket: aStream)
			  or: [statementWasComment]) ifFalse: [aStream nextPut: $,]]! !

!SlangTStmtListNode methodsFor: '*Slang-C' stamp: 'eem 8/18/2011 14:47'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen! !

!SlangTSwitchStmtNode methodsFor: '*Slang-C' stamp: 'jpb 5/28/2020 17:58:32'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	"Emit the receiver as an if-the-else chain."
	| varName n |
	self assert: ((expression is: #Variable) or: [switchVariable notNil]).
	
	aStream nextPut: $(.
	switchVariable
		ifNil: [varName _ String streamContents: [:s| expression emitCCodeOn: s level: 0 generator: aCodeGen].
			aStream nextPutAll: varName]
		ifNotNil:
			[varName _ switchVariable.
			 aStream nextPut: $(; nextPutAll: varName; nextPutAll: ' = '.
			 expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
			 aStream nextPut: $)].
	n _ 0.
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 n > 0 ifTrue:
				[aStream nextPutAll: varName].
			 aStream nextPutAll: ' == '.
			 label emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen.
			 aStream nextPut: $).
			 aStream crtab: level + n + 1.
			 aStream nextPutAll: '? ('.
			 (SlangTStmtListNode new setArguments: #() statements: case statements)
			 	emitCCodeAsArgumentOn: aStream
				level: level + 2
				generator: aCodeGen.
			 aStream nextPut: $); crtab: level + n + 1; nextPutAll: ': ('.
			 n _ n + 1]]
			valueWithArguments: tuple].
	otherwiseOrNil
		ifNotNil: [otherwiseOrNil emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause"), 0'].
	aStream next: n - 1 put: $)! !

!SlangTSwitchStmtNode methodsFor: '*Slang-C' stamp: 'jpb 6/6/2020 14:28:07'!
emitCCodeOn: aStream addToEndOfCases: aNodeOrNil level: level generator: aCodeGen

	aStream newLine; tab: level.
	aStream nextPutAll: 'switch ('.
	expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'.
	
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 aStream
				newLine; tab: level;
				nextPutAll: 'case '.
			label emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen.
			aStream nextPut: $:].
		  aStream newLine; tab: level + 1.
		  case emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level + 1 generator: aCodeGen]
			valueWithArguments: tuple.
		  (aNodeOrNil notNil and: [aNodeOrNil isReturn]) ifFalse:
			[aStream newLine; tab: level + 1; nextPutAll: 'break;']].
	aStream
		newLine; tab: level;
		nextPutAll: 'default:';
		newLine; tab: level + 1.
	otherwiseOrNil
		ifNotNil: [otherwiseOrNil emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level + 1 generator: aCodeGen]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause");'.
			   aNodeOrNil ifNotNil:
				[aStream newLine; tab: level + 1.
				 (aNodeOrNil copy setExpression: (SlangTConstantNode new setValue: -1))
					emitCCodeOn: aStream level: level generator: aCodeGen.
				 aStream nextPut: $;]].
	aStream
		newLine; tab: level;
		nextPut: $}! !

!SlangTSwitchStmtNode methodsFor: '*Slang-C' stamp: 'jpb 5/29/2020 21:01:56'!
emitCCodeOn: aStream level: level generator: aCodeGen

	aStream newLine; tab: level.
	aStream nextPutAll: 'switch ('.
	expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'.
	
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 aStream
				newLine; tab: level;
				nextPutAll: 'case '.
			label emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen.
			aStream nextPut: $:].
		  aStream newLine; tab: level + 1.
		  case emitCCodeOn: aStream level: level + 1 generator: aCodeGen.
		  case endsWithReturn ifFalse:
			[aStream tab: level + 1; nextPutAll: 'break;']]
			valueWithArguments: tuple].
		
	aStream
		newLine; tab: level;
		nextPutAll: 'default:';
		newLine; tab: level + 1.
		
	otherwiseOrNil
		ifNotNil:
			[otherwiseOrNil emitCCodeOn: aStream level: level + 1 generator: aCodeGen]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause");'].
		
	aStream
		newLine; tab: level;
		nextPut: $}! !

!SlangTVariableNode methodsFor: '*Slang-C' stamp: 'jpb 5/19/2020 22:46:16'!
emitCCodeOn: aStream level: level generator: aCodeGen

	name = 'nil'
		ifTrue: [ aStream nextPutAll: (aCodeGen findLiteralFor: nil) ]
		ifFalse: [ aStream nextPutAll: (aCodeGen returnPrefixFromVariable: name) ].! !
SlangCCodeGenerator initialize!
