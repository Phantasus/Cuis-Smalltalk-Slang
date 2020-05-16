'From Cuis 5.0 [latest update: #4112] on 13 May 2020 at 2:49:25 pm'!
'Description '!
!provides: 'Slang-Tools-Tests' 1 0!
SystemOrganization addCategory: #'Slang-Tools-Tests'!


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
ObjectMemory subclass: #SlangTestSupportInterpreter
	instanceVariableNames: 'cg inlineFlag primFailCode aVarWithOneReference aVarWithTwoReferences objectMemory aVariable breakSelector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangTestSupportInterpreter class' category: #'Slang-Tools-Tests'!
SlangTestSupportInterpreter class
	instanceVariableNames: ''!

!classDefinition: #SlangTestSupportSSIP category: #'Slang-Tools-Tests'!
SmartSyntaxInterpreterPlugin subclass: #SlangTestSupportSSIP
	instanceVariableNames: 'cg inlineFlag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangTestSupportSSIP class' category: #'Slang-Tools-Tests'!
SlangTestSupportSSIP class
	instanceVariableNames: ''!

!classDefinition: #SlangTestSupportPlugin category: #'Slang-Tools-Tests'!
InterpreterPlugin subclass: #SlangTestSupportPlugin
	instanceVariableNames: 'cg inlineFlag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangTestSupportPlugin class' category: #'Slang-Tools-Tests'!
SlangTestSupportPlugin class
	instanceVariableNames: ''!


!SlangTest commentStamp: 'dtl 9/18/2010 17:43' prior: 0!
The SlangTest tests verify code generation and inlining.
!

!SlangTestSupportInterpreter commentStamp: 'dtl 9/19/2010 21:36' prior: 0!
SlangTestSupport implements translatable methods for use in SlangTest unit tests.

	"VMMaker clearCacheEntriesFor: SlangTestSupportInterpreter.
	SlangTestSupportInterpreter asCString"!

!SlangTestSupportSSIP commentStamp: 'dtl 9/19/2010 11:38' prior: 0!
SlangTestSupportSSIP implements translatable methods for use in SlangTest unit tests.
It is a subclass of SmartSyntaxInterpreterPlugin, which requires additional
test coverage.

	"VMMaker clearCacheEntriesFor: SlangTestSupportSSIP.
	SlangTestSupportSSIP asCString"!

!SlangTestSupportPlugin commentStamp: 'dtl 9/19/2010 21:36' prior: 0!
SlangTestSupport implements translatable methods for use in SlangTest unit tests.
This is a subclass of InterpreterPlugin, which provides coverage of slang translation
for base plugins.

	"VMMaker clearCacheEntriesFor: SlangTestSupportPlugin.
	SlangTestSupportPlugin asCString"!

!SlangTest methodsFor: 'testing' stamp: 'dtl 2/14/2012 07:46'!
expectedFailures
	^#( testSetInstanceVariableWithAnAccessorMethod )! !

!SlangTest methodsFor: 'running' stamp: 'dtl 3/18/2013 18:48'!
setUp

	"Some of the test may be long running when SlangTestSupport is a subclass
	of ObjectMemory."
	(self respondsTo: #timeout: ) "Recent Squeak images with test case timeout"
		ifTrue: [self perform: #timeout: with: 30].
! !

!SlangTest methodsFor: 'testing loop limits' stamp: 'dtl 4/4/2013 23:55'!
testCallMethodEmbeddedWithSendInLoopLimit
	"A loop embedded in a loop with two loop limit variables generated"

	"(SlangTest selector: #testCallMethodEmbeddedWithSendInLoopLimit) debug"

	| m1 sts lines |
	sts := SlangTestSupportInterpreter inline: true.
	m1 := (sts asCString: #callMethodEmbeddedWithSendInLoopLimit)
			copyReplaceAll: 'callMethodEmbeddedWithSendInLoopLimit'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 2.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.
	self should: (lines select: [:e | 'sqInt kLimiT;' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportPlugin inline: true.
	m1 := (sts asCString: #callMethodEmbeddedWithSendInLoopLimit)
			copyReplaceAll: 'callMethodEmbeddedWithSendInLoopLimit'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 2.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.
	self should: (lines select: [:e | 'sqInt kLimiT;' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportSSIP inline: true.
	m1 := (sts asCString: #callMethodEmbeddedWithSendInLoopLimit)
			copyReplaceAll: 'callMethodEmbeddedWithSendInLoopLimit'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 2.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.
	self should: (lines select: [:e | 'sqInt kLimiT;' = e withBlanksTrimmed]) size = 1.! !

!SlangTest methodsFor: 'testing loop limits' stamp: 'dtl 4/4/2013 23:56'!
testCallMethodTwiceWithLoopLimitThatMightBeModified
	"Two calls to a method with loop that might be modified generates a distinct
	loop limit variable for each."

	"(SlangTest selector: #testCallMethodTwiceWithLoopLimitThatMightBeModified) debug"

	| m1 sts lines |
	sts := SlangTestSupportInterpreter inline: true.
	m1 := (sts asCString: #callMethodTwiceWithLoopLimitThatMightBeModified)
			copyReplaceAll: 'callMethodTwiceWithLoopLimitThatMightBeModified'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 2.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.
	self should: (lines select: [:e | 'sqInt iLimiT1;' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportSSIP inline: true.
	m1 := (sts asCString: #callMethodTwiceWithLoopLimitThatMightBeModified)
			copyReplaceAll: 'callMethodTwiceWithLoopLimitThatMightBeModified'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 2.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.
	self should: (lines select: [:e | 'sqInt iLimiT1;' = e withBlanksTrimmed]) size = 1.
! !

!SlangTest methodsFor: 'testing loop limits' stamp: 'dtl 4/4/2013 23:57'!
testCallMethodTwiceWithSendInLoopLimit
	"Two calls to a method with loop with loop limit that is a method send can
	share the same loop limit variable."

	"(SlangTest selector: #testCallMethodTwiceWithSendInLoopLimit) debug"

	| m1 sts lines |
	sts := SlangTestSupportInterpreter inline: true.
	m1 := (sts asCString: #callMethodTwiceWithSendInLoopLimit)
			copyReplaceAll: 'callMethodTwiceWithSendInLoopLimit'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 1.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportPlugin inline: true.
	m1 := (sts asCString: #callMethodTwiceWithSendInLoopLimit)
			copyReplaceAll: 'callMethodTwiceWithSendInLoopLimit'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 1.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportSSIP inline: true.
	m1 := (sts asCString: #callMethodTwiceWithSendInLoopLimit)
			copyReplaceAll: 'callMethodTwiceWithSendInLoopLimit'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 1.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.
! !

!SlangTest methodsFor: 'testing loop limits' stamp: 'dtl 4/4/2013 23:57'!
testCallMethodWithLoopLimitThatIsNotModified
	"A call to a method with loop with a constant loop limit does not require a
	loop limit variable."

	"(SlangTest selector: #testCallMethodTwiceWithSendInLoopLimit) debug"

	| m1 sts lines |
	sts := SlangTestSupportInterpreter inline: true.
	m1 := (sts asCString: #callMethodWithLoopLimitThatIsNotModified)
			copyReplaceAll: 'callMethodWithLoopLimitThatIsNotModified'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 0.
	self should: (lines select: [:e | 'for (i = 0; i <= 10; i += 1) {' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportPlugin inline: true.
	m1 := (sts asCString: #callMethodWithLoopLimitThatIsNotModified)
			copyReplaceAll: 'callMethodWithLoopLimitThatIsNotModified'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 0.
	self should: (lines select: [:e | 'for (i = 0; i <= 10; i += 1) {' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportSSIP inline: true.
	m1 := (sts asCString: #callMethodWithLoopLimitThatIsNotModified)
			copyReplaceAll: 'callMethodWithLoopLimitThatIsNotModified'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 0.
	self should: (lines select: [:e | 'for (i = 0; i <= 10; i += 1) {' = e withBlanksTrimmed]) size = 1.
! !

!SlangTest methodsFor: 'testing loop limits' stamp: 'dtl 4/4/2013 23:58'!
testCallMethodWithLoopLimitThatMightBeModified
	"A call to a method with loop with a loop limit that might be modified by the loop
	body requires a loop limit variable."

	"(SlangTest selector: #testCallMethodWithLoopLimitThatMightBeModified) debug"

	| m1 sts lines |
	sts := SlangTestSupportInterpreter inline: true.
	m1 := (sts asCString: #callMethodWithLoopLimitThatMightBeModified)
			copyReplaceAll: 'callMethodWithLoopLimitThatMightBeModified'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 1.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportPlugin inline: true.
	m1 := (sts asCString: #callMethodWithLoopLimitThatMightBeModified)
			copyReplaceAll: 'callMethodWithLoopLimitThatMightBeModified'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 1.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.

	sts := SlangTestSupportSSIP inline: true.
	m1 := (sts asCString: #callMethodWithLoopLimitThatMightBeModified)
			copyReplaceAll: 'callMethodWithLoopLimitThatMightBeModified'
			with: 'methodName'.
	lines := m1 findTokens: String cr.
	self should: (lines select: [:e | '*sqInt *LimiT*' match: e]) size = 1.
	self should: (lines select: [:e | 'sqInt iLimiT;' = e withBlanksTrimmed]) size = 1.
! !

!SlangTest methodsFor: 'testing variable declaration' stamp: 'dtl 9/22/2012 14:30'!
testExportsForSqueak3D
	"If the code generator is not properly initialized in the special case of
	B3DEnginePlugin, the exports table will be incorrect in the generated code.
	Some versions of VMMaker had this problem, this test is to ensure that the
	problem stays fixed."

	Smalltalk at: #B3DEnginePlugin ifPresent: [:squeak3D | | src |
		src := squeak3D asCString.
		self assert: ( '*"Squeak3D", "setInterpreter", (void*)setInterpreter*' match: src)]
! !

!SlangTest methodsFor: 'testing variable declaration' stamp: 'dtl 3/18/2013 14:38'!
testIvarShouldNotBeRedeclaredAsLocal
	"Document a bug in some versions of the code generator. If an instance variable is
	referenced in the generated code, that variable should not be declared as a local
	in the function."

	| stssi s |
	stssi := SlangTestSupportInterpreter inline: false.
	s := stssi asCString: #setBreakSelector: .
	self deny: (s includesSubString: 'sqInt breakSelector;')
! !

!SlangTest methodsFor: 'testing variable declaration' stamp: 'dtl 11/25/2014 19:57'!
testLiteralName
	"sizeOf: #Foo should translated to C function call sizeof(Foo), where Foo is a literal, not a string"

	| stssi s |
	stssi := SlangTestSupportInterpreter inline: false.
	s := stssi asCString: #sizeOfFoo .
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
	stssi := SlangTestSupportInterpreter inline: false.
	s := stssi asCString: #methodWithReferenceToVariables .
	"variable with one method reference is promoted to a local method variable"
	self assert: (s includesSubString: 'sqInt aVarWithOneReference;').
	"normal expected behavior, the variable is global in the generated source module."
	self deny: (s includesSubString: 'sqInt aVarWithTwoReferences;')
! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/12/2014 19:31'!
testFetchClassOfIsFullyInlined
	"Test for inlining error resolved in VMMaker 4.13.4 (VMMaker-dtl.343). In this example,
	the ObjectMemoy>>wordMask method must be inlined (marked complete) in order for
	fetchClassOf: to be inlined. Some versions of the inliner treat the #cCode:inSmalltalk:
	at the root of the wordMask method as an indication that it is not completely inlined.
	This in turn prevents fetchClassOf: from being inlined."

	| stssi m |
	stssi := SlangTestSupportInterpreter inline: true.
	m := stssi asCString: #tryInliningForFetchClassOf:.
	self deny: ('*fetchClassOf(rcvr);*' match: m). "fetchClassOf() should not appear as a function call"
	self assert: ('*/# begin fetchClassOf: #/*' match: m). "fetchClassOf: has been inlined"
! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 09:49'!
testInterpDeclareExport
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stssi m p |
	stssi := SlangTestSupportInterpreter inline: false.
	m := (stssi asCString: #declareExportTrueByMethod)
			copyReplaceAll: 'declareExportTrueByMethod'
			with: 'methodName'.
	p := (stssi asCString: #declareExportTrueByPragma)
			copyReplaceAll: 'declareExportTrueByPragma'
			with: 'methodName'.
	self assert: m = p.

	m := (stssi asCString: #declareExportFalseByMethod)
			copyReplaceAll: 'declareExportFalseByMethod'
			with: 'methodName'.
	p := (stssi asCString: #declareExportFalseByPragma)
			copyReplaceAll: 'declareExportFalseByPragma'
			with: 'methodName'.
	self assert: m = p.! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 09:50'!
testInterpDeclareInline
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stssi m p |
	stssi := SlangTestSupportInterpreter inline: true.
	m := ((stssi asCString: #inlineByMethod)
			copyReplaceAll: 'inlineByMethod'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByMethod'
				with: 'calledMethodName'.
	p := ((stssi asCString: #inlineByPragma)
			copyReplaceAll: 'inlineByPragma'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByPragma'
				with: 'calledMethodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 09:54'!
testInterpDeclareStatic
	"A static directive should cause the generated function to be declared static."

	| stssi m1 p1 m2 p2 |
	stssi := SlangTestSupportInterpreter inline: false.
	m1 := (stssi asCString: #declareStaticTrueByMethod)
			copyReplaceAll: 'declareStaticTrueByMethod'
			with: 'methodName'.
	p1 := (stssi asCString: #declareStaticTrueByPragma)
			copyReplaceAll: 'declareStaticTrueByPragma'
			with: 'methodName'.
	self assert: m1 = p1.

	m2 := (stssi asCString: #declareStaticFalseByMethod)
			copyReplaceAll: 'declareStaticFalseByMethod'
			with: 'methodName'.
	p2 := (stssi asCString: #declareStaticFalseByPragma)
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
	stssi := SlangTestSupportInterpreter inline: false.
	self assert: (SlangTestSupportInterpreter canUnderstand: #doNotGenerateByMethod).
	m := stssi asCString: #doNotGenerateByMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stssi asCString includesSubString: 'doNotGenerateByMethod').
	self assert: (stssi doNotGenerateByMethod = 4)

! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:24'!
testInterpDoNotdoNotGenerateByPragma
	"A <doNotdoNotGenerate> declaration should prevent code generation"

	| stssi m |
	stssi := SlangTestSupportInterpreter inline: false.
	self assert: (SlangTestSupportInterpreter canUnderstand: #doNotGenerateByPragma).
	m := stssi asCString: #doNotGenerateByPragma.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stssi asCString includesSubString: 'doNotGenerateByPragma').
	self assert: (stssi doNotGenerateByPragma = 4)
! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:24'!
testInterpDoNotdoNotGenerateSubclassResponsibility
	"If a method contains self subclassResponsibility, assume it is not meant for translation."

	| stssi m |
	stssi := SlangTestSupportInterpreter inline: false.
	self assert: (SlangTestSupportInterpreter canUnderstand: #anAbstractMethod).
	m := stssi asCString: #anAbstractMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stssi asCString includesSubString: 'anAbstractMethod').
	self should: [stssi anAbstractMethod]
		raise: Error

! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:36'!
testInterpMixedMethodAndPragmaDeclarations
	"Pragmas and method declarations should coexist"

	| stssi s |
	stssi := SlangTestSupportInterpreter inline: false.
	s := (stssi asCString: #varDefByMethodAndPragma)
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
	stssi := SlangTestSupportInterpreter inline: false.
	m := (stssi asCString: #returnTypeByMethod)
			copyReplaceAll: 'returnTypeByMethod'
			with: 'methodName'.
	p := (stssi asCString: #returnTypeByPragma)
			copyReplaceAll: 'returnTypeByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing interpreter' stamp: 'dtl 3/18/2013 14:38'!
testInterpTypeDeclarations
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stssi m p |
	stssi := SlangTestSupportInterpreter inline: false.
	m := (stssi asCString: #varDefByMethod)
			copyReplaceAll: 'varDefByMethod'
			with: 'methodName'.
	p := (stssi asCString: #varDefByPragma)
			copyReplaceAll: 'varDefByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing preprocessor directives' stamp: 'dtl 3/18/2013 09:49'!
testIfElseEndif
	"Test isDefinedTrueExpression:inSmalltalk:comment:ifTrue:ifFalse: "

	"(SlangTest selector: #testIfElseEndif) run"

	| stssi cString stringWithoutWhiteSpace lines |
	stssi := SlangTestSupportInterpreter inline: false.

	"verify that the default Smalltalk block that is evaluated in simulation"
	self assert: stssi ifDefinedTrueElseEndif = 4.

	"verify generated C string"
	cString := stssi asCString: #ifDefinedTrueElseEndif.
	lines := (cString findTokens: Character cr) select: [:e |
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
	cString := stssi asCString: #ifDefinedTrueElseEndif.
	stringWithoutWhiteSpace := cString reject: [:e | e isSeparator].
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

	stssi := SlangTestSupportInterpreter inline: false.

	"verify that the default Smalltalk block that is evaluated in simulation"
	self assert: stssi ifdefElseEndif = #defaultBlockForSimulation.

	"verify generated C string"
	cString := stssi asCString: #ifdefElseEndif.
	lines := (cString findTokens: Character cr) select: [:e |
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
	stringWithoutWhiteSpace := cString reject: [:e | e isSeparator].
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

	stssi := SlangTestSupportInterpreter inline: false.

	"verify that the default Smalltalk block that is evaluated in simulation"
	self assert: stssi ifdefEndif = #defaultBlockForSimulation.

	"verify generated C string"
	cString := stssi asCString: #ifdefEndif.
	lines := (cString findTokens: Character cr) select: [:e |
		{
			'# ifdef HAVE_FOO  // some platforms do not support foo properly' .
			'	return 1;' .
			'# endif  // HAVE_FOO'
		} includes: e ].
	self should: lines size = 3.

	"check the rest of the method, ignoring whitespace"
	cString := stssi asCString: #ifdefEndif.
	stringWithoutWhiteSpace := cString reject: [:e | e isSeparator].
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

!SlangTest methodsFor: 'testing preprocessor directives' stamp: 'dtl 3/18/2013 14:39'!
testPreprocessorExpression
	"Test preprocessorExpression: "

	"(SlangTest selector: #testPreprocessorExpression) run"

	| stssi cString |
	self flag: #FIXME. "See redundant implementation in oscog #cPreprocessorDirective: "

	stssi := SlangTestSupportInterpreter inline: false.
	cString := stssi asCString: #preprocessorExpression.
	self should: ('*# define FOO bar*' match: cString).
	self should: ((cString findTokens: Character cr) select: [:e | e = '# define FOO bar' ]) size = 1.
	self should: ((cString findTokens: Character cr) select: [:e | e = '## define FOO bar' ]) size = 0.
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:32'!
testPluginDeclareExport
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stsp m p |
	stsp := SlangTestSupportPlugin inline: false.
	m := (stsp asCString: #declareExportTrueByMethod)
			copyReplaceAll: 'declareExportTrueByMethod'
			with: 'methodName'.
	p := (stsp asCString: #declareExportTrueByPragma)
			copyReplaceAll: 'declareExportTrueByPragma'
			with: 'methodName'.
	self assert: m = p.

	m := (stsp asCString: #declareExportFalseByMethod)
			copyReplaceAll: 'declareExportFalseByMethod'
			with: 'methodName'.
	p := (stsp asCString: #declareExportFalseByPragma)
			copyReplaceAll: 'declareExportFalseByPragma'
			with: 'methodName'.
	self assert: m = p.! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:34'!
testPluginDeclareInline
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stsp m p |
	stsp := SlangTestSupportPlugin inline: true.
	m := ((stsp asCString: #inlineByMethod)
			copyReplaceAll: 'inlineByMethod'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByMethod'
				with: 'calledMethodName'.
	p := ((stsp asCString: #inlineByPragma)
			copyReplaceAll: 'inlineByPragma'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByPragma'
				with: 'calledMethodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:35'!
testPluginDeclareStatic
	"A static directive should cause the generated function to be declared static."

	| stsp m1 p1 m2 p2 |
	stsp := SlangTestSupportPlugin inline: false.
	m1 := (stsp asCString: #declareStaticTrueByMethod)
			copyReplaceAll: 'declareStaticTrueByMethod'
			with: 'methodName'.
	p1 := (stsp asCString: #declareStaticTrueByPragma)
			copyReplaceAll: 'declareStaticTrueByPragma'
			with: 'methodName'.
	self assert: m1 = p1.

	m2 := (stsp asCString: #declareStaticFalseByMethod)
			copyReplaceAll: 'declareStaticFalseByMethod'
			with: 'methodName'.
	p2 := (stsp asCString: #declareStaticFalseByPragma)
			copyReplaceAll: 'declareStaticFalseByPragma'
			with: 'methodName'.
	self assert: m2 = p2.

	"verify that the keyword 'static appears in the generated C source"
	self assert: (m1 includesSubString: 'static').
	self assert: (p1 includesSubString: 'static').
	self deny: (m2 includesSubString: 'static').
	self deny: (p2 includesSubString: 'static')
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:36'!
testPluginDoNotGenerateByMethod
	"A doNotdoNotGenerate statement should prevent code generation"

	| stsp m |
	stsp := SlangTestSupportPlugin inline: false.
	self assert: (SlangTestSupportPlugin canUnderstand: #doNotGenerateByMethod).
	m := stsp asCString: #doNotGenerateByMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stsp asCString includesSubString: 'doNotGenerateByMethod').
	self assert: (stsp doNotGenerateByMethod = 4)
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:36'!
testPluginDoNotGenerateByPragma
	"A <doNotdoNotGenerate> declaration should prevent code generation"

	| stsp m |
	stsp := SlangTestSupportPlugin inline: false.
	self assert: (SlangTestSupportPlugin canUnderstand: #doNotGenerateByPragma).
	m := stsp asCString: #doNotGenerateByPragma.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stsp asCString includesSubString: 'doNotGenerateByPragma').
	self assert: (stsp doNotGenerateByPragma = 4)
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:37'!
testPluginDoNotGenerateSubclassResponsibility
	"If a method contains self subclassResponsibility, assume it is not meant for translation."

	| stsp m |
	stsp := SlangTestSupportPlugin inline: false.
	self assert: (SlangTestSupportPlugin canUnderstand: #anAbstractMethod).
	m := stsp asCString: #anAbstractMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stsp asCString includesSubString: 'anAbstractMethod').
	self should: [stsp anAbstractMethod]
		raise: Error
! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:37'!
testPluginMixedMethodAndPragmaDeclarations
	"Pragmas and method declarations should coexist"

	| stsp s |
	stsp := SlangTestSupportPlugin inline: false.
	s := (stsp asCString: #varDefByMethodAndPragma)
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
	stsp := SlangTestSupportPlugin inline: false.
	m := (stsp asCString: #returnTypeByMethod)
			copyReplaceAll: 'returnTypeByMethod'
			with: 'methodName'.
	p := (stsp asCString: #returnTypeByPragma)
			copyReplaceAll: 'returnTypeByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing base plugins' stamp: 'dtl 3/18/2013 18:38'!
testPluginTypeDeclarations
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stsp m p |
	stsp := SlangTestSupportPlugin inline: false.
	m := (stsp asCString: #varDefByMethod)
			copyReplaceAll: 'varDefByMethod'
			with: 'methodName'.
	p := (stsp asCString: #varDefByPragma)
			copyReplaceAll: 'varDefByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing var decl requires memoryaccess' stamp: 'dtl 3/2/2014 10:24'!
testRemoveTypeDeclarationForRemovedIntermediate
	"Document a bug in variable declaration. This is hard to reproduce, so the test uses
	the actual failure. Necessary conditions are to use MemoryAccess (requires deep
	inlining), then generate the entire interpreter. The error condition appears in the
	reverseDisplayFrom:to: method. Generating that method alone is not sufficient to
	reproduce the bug, the entire interpreter must first be generated, after which the
	method may be individually generated to inspect for the error condition. Symptoms
	are that #ptr, which is used as a sqInt, is incorrectly declared as (char *) due to a
	left over unreferenced declaration in one of the inlined methods.
	The bug exists as of VMMaker-dtl.342 and is corrected in VMMaker-dtl.343."

	| ma maState |
	ma := Smalltalk classNamed: #MemoryAccess.
	ma ifNil: [^ self
		"requires these accessors in combination with object memory / interpreter refactoring in order to reproduce bug"].
	maState := ma isEnabled.
	[ | s cg strm meth |
		ma enable.
		cg := CCodeGenerator new initialize.
		cg declareMethodsStatic: false.
		Interpreter initializeCodeGenerator: cg.
		cg vmClass: Interpreter.
		strm := ReadWriteStream on: ''.
		cg emitCCodeOn: strm doInlining: true doAssertions: false.
		meth := cg methodNamed: 'reverseDisplayFrom:to:' .
		strm := ReadWriteStream on: ''.
		meth emitCCodeOn: strm generator: cg.
		s := strm contents.
		self shouldnt: ('*char #ptr;*' match: s).
		self should: ('*sqInt ptr;*' match: s)
	] ensure: [maState
		ifTrue: [ma enable]
		ifFalse: [ma disable]]
	! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:42'!
testSSIPDeclareExport
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stss m p |
	stss := SlangTestSupportSSIP inline: false.
	m := (stss asCString: #declareExportTrueByMethod)
			copyReplaceAll: 'declareExportTrueByMethod'
			with: 'methodName'.
	p := (stss asCString: #declareExportTrueByPragma)
			copyReplaceAll: 'declareExportTrueByPragma'
			with: 'methodName'.
	self assert: m = p.

	m := (stss asCString: #declareExportFalseByMethod)
			copyReplaceAll: 'declareExportFalseByMethod'
			with: 'methodName'.
	p := (stss asCString: #declareExportFalseByPragma)
			copyReplaceAll: 'declareExportFalseByPragma'
			with: 'methodName'.
	self assert: m = p.! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:48'!
testSSIPDeclareInline
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stss m p |
	stss := SlangTestSupportSSIP inline: true.
	m := ((stss asCString: #inlineByMethod)
			copyReplaceAll: 'inlineByMethod'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByMethod'
				with: 'calledMethodName'.
	p := ((stss asCString: #inlineByPragma)
			copyReplaceAll: 'inlineByPragma'
			with: 'methodName')
				copyReplaceAll: 'methodThatShouldNotBeInlinedByPragma'
				with: 'calledMethodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:43'!
testSSIPDeclareStatic
	"A static directive should cause the generated function to be declared static."

	| stss m1 p1 m2 p2 |
	stss := SlangTestSupportSSIP inline: false.
	m1 := (stss asCString: #declareStaticTrueByMethod)
			copyReplaceAll: 'declareStaticTrueByMethod'
			with: 'methodName'.
	p1 := (stss asCString: #declareStaticTrueByPragma)
			copyReplaceAll: 'declareStaticTrueByPragma'
			with: 'methodName'.
	self assert: m1 = p1.

	m2 := (stss asCString: #declareStaticFalseByMethod)
			copyReplaceAll: 'declareStaticFalseByMethod'
			with: 'methodName'.
	p2 := (stss asCString: #declareStaticFalseByPragma)
			copyReplaceAll: 'declareStaticFalseByPragma'
			with: 'methodName'.
	self assert: m2 = p2.

	"verify that the keyword 'static appears in the generated C source"
	self assert: (m1 includesSubString: 'static').
	self assert: (p1 includesSubString: 'static').
	self deny: (m2 includesSubString: 'static').
	self deny: (p2 includesSubString: 'static')
! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:43'!
testSSIPDoNotGenerateByMethod
	"A doNotdoNotGenerate statement should prevent code generation"

	| stss m |
	stss := SlangTestSupportSSIP inline: false.
	self assert: (SlangTestSupportSSIP canUnderstand: #doNotGenerateByMethod).
	m := stss asCString: #doNotGenerateByMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stss asCString includesSubString: 'doNotGenerateByMethod').
	self assert: (stss doNotGenerateByMethod = 4)! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:44'!
testSSIPDoNotGenerateByPragma
	"A <doNotdoNotGenerate> declaration should prevent code generation"

	| stss m |
	stss := SlangTestSupportSSIP inline: false.
	self assert: (SlangTestSupportSSIP canUnderstand: #doNotGenerateByPragma).
	m := stss asCString: #doNotGenerateByPragma.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stss asCString includesSubString: 'doNotGenerateByPragma').
	self assert: (stss doNotGenerateByPragma = 4)
! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:44'!
testSSIPDoNotGenerateSubclassResponsibility
	"If a method contains self subclassResponsibility, assume it is not meant for translation."

	| stss m |
	stss := SlangTestSupportSSIP inline: false.
	self assert: (SlangTestSupportSSIP canUnderstand: #anAbstractMethod).
	m := stss asCString: #anAbstractMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stss asCString includesSubString: 'anAbstractMethod').
	self should: [stss anAbstractMethod]
		raise: Error
! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:45'!
testSSIPMixedMethodAndPragmaDeclarations
	"Pragmas and method declarations should coexist"

	| stss s |
	stss := SlangTestSupportSSIP inline: false.
	s := (stss asCString: #varDefByMethodAndPragma)
			copyReplaceAll: 'varDefByMethod'
			with: 'methodName'.
	self assert: (s includesSubString: 'unsigned int * bar').
	self assert: (s includesSubString: 'char *foo').
	self assert: (s includesSubString: 'float baz').
	self assert: (s includesSubString: 'double fum').
! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:45'!
testSSIPReturnTypeC
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stss m p |
	stss := SlangTestSupportSSIP inline: false.
	m := (stss asCString: #returnTypeByMethod)
			copyReplaceAll: 'returnTypeByMethod'
			with: 'methodName'.
	p := (stss asCString: #returnTypeByPragma)
			copyReplaceAll: 'returnTypeByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:45'!
testSSIPTypeDeclarations
	"Pragma declarations should generate the same C source code as the
	traditional method send declarations"

	| stss m p |
	stss := SlangTestSupportSSIP inline: false.
	m := (stss asCString: #varDefByMethod)
			copyReplaceAll: 'varDefByMethod'
			with: 'methodName'.
	p := (stss asCString: #varDefByPragma)
			copyReplaceAll: 'varDefByPragma'
			with: 'methodName'.
	self assert: m = p! !

!SlangTest methodsFor: 'testing intermediate variable removal' stamp: 'dtl 2/24/2014 21:35'!
testSetInstanceVariableWithAnAccessorMethod
	"Intermediate variable from parameter of accessor method should be removed.
	This is an existing limitation of the inliner, and could be improved for better code
	generation. It is not a bug."

	| stssi s |
	stssi := SlangTestSupportInterpreter inline: true.
	s := (stssi asCString: #setInstanceVariableWithAnAccessorMethod)
			copyReplaceAll: 'setInstanceVariableWithAnAccessorMethod'
			with: 'methodName'.
	self deny: (s includesSubString: 'sqInt oop').
	self assert: (s includesSubString: 'aVariable = remap(').

	"Should be translated to something similar to this:
		aVariable = remap(objectMemory, nilObj);

	Not like this:
		oop = remap(objectMemory, nilObj);
		aVariable = oop;"
! !

!SlangTest methodsFor: 'testing smart syntax' stamp: 'dtl 3/18/2013 15:08'!
testSmartSyntaxParameterDeclaration
	"(SlangTest selector: #testSmartSyntaxParameterDeclaration) run"

	| s |
	s := (SlangTestSupportSSIP
			asInlinedCString: #declareInt:wordPointer: ).
	"parameter taken from the stack should be cast to (unsigned *)"
	self should: ['*pointerToWords = ((unsigned **) (interpreterProxy->firstIndexableField(interpreterProxy->stackValue(0))));*' match: s].
	"local variable declaration should match the data type as in the cast"
	self shouldnt: ['*usqInt **pointerToWords*' match: s]. "the buggy code generator renders it as 'usqInt *pointerToWords' "
	self should: ['*unsigned **pointerToWords*' match: s]. "it should be rendered as 'unsigned *pointerToWords' "
! !

!SlangTestSupportInterpreter methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 22:21'!
anAbstractMethod

	self subclassResponsibility! !

!SlangTestSupportInterpreter methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 08:18'!
doNotGenerateByMethod
	"SlangTestSupportInterpreter asCString: #doNotGenerateByMethod"

	self returnTypeC: #int.
	self doNotGenerate.
	^ 2 + 2
! !

!SlangTestSupportInterpreter methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 08:11'!
doNotGenerateByPragma
	"SlangTestSupportInterpreter asCString: #doNotGenerateByPragma"

	<doNotGenerate>
	<returnTypeC: #int>
	^ 2 + 2
! !

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:28'!
asCString

	| stream |
	stream := ReadWriteStream on: String new.
	self cg emitCCodeOn: stream doAssertions: true.
	^ stream contents
! !

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:29'!
asCString: selector

	| method stream |
	method := self cg methodNamed: selector.
	method ifNil: [^ 'No source has been generated'].
	stream := ReadWriteStream on: String new.
	method emitCCodeOn: stream generator: cg.
	^ stream contents
! !

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:28'!
cg
	"Lazy initialize, once per test"

	cg ifNil: [ObjectMemory initialize; initializeConstants.
		cg := self class buildCodeGeneratorInlined: inlineFlag = true.
		cg prepareMethodsInlined: inlineFlag = true doAssertions: true].
	^ cg! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodEmbeddedWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i |
		1 to: self methodWithIntegerResult do: [:k | ]].
! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:49'!
callMethodTwiceWithLoopLimitThatMightBeModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatMightBeModified: aVar.
	self methodWithLoopLimitThatMightBeModified: aVar.
! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodTwiceWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i | ].
	1 to: self methodWithIntegerResult do: [:i | ].
! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:51'!
callMethodWithLoopLimitThatIsNotModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatIsNotModified: aVar.
! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:49'!
callMethodWithLoopLimitThatMightBeModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatMightBeModified: aVar.
! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:37'!
methodWithIntegerResult
	"Translates to nonsense, but use this to illustrate the point"
	^(Random new next * 100) asInteger! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:48'!
methodWithLoopLimitThatIsNotModified: arrayObj

	0 to: 10 do: [:i | self storePointerUnchecked: i ofObject: arrayObj withValue: nilObj]
! !

!SlangTestSupportInterpreter methodsFor: 'loop limits' stamp: 'dtl 5/4/2013 13:54'!
methodWithLoopLimitThatMightBeModified: arrayObj

	0 to: (objectMemory lengthOf: arrayObj) do:
	[:i | self storePointerUnchecked: i ofObject: arrayObj withValue: nilObj]
! !

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
	inlineFlag := flag! !

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 4/25/2011 23:01'!
inlineByMethod
	"SlangTestSupportInterpreter asCString: #inlineByMethod"
	"SlangTestSupportInterpreter asInlinedCString: #inlineByMethod"

	| bar foo |
	foo := self methodThatShouldBeInlinedByMethod.
	bar := self methodThatShouldNotBeInlinedByMethod! !

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 4/26/2011 18:40'!
inlineByPragma
	"SlangTestSupportInterpreter asCString: #inlineByPragma"
	"SlangTestSupportInterpreter asInlinedCString: #inlineByPragma"

	| bar foo |
	foo := self methodThatShouldBeInlinedByPragma.
	bar := self methodThatShouldNotBeInlinedByPragma! !

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

!SlangTestSupportInterpreter methodsFor: 'inlining' stamp: 'dtl 3/12/2014 18:46'!
tryInliningForFetchClassOf: rcvr

	objectMemory fetchClassOf: rcvr
	! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 4/26/2011 07:38'!
methodWithReferenceToAVarWithTwoReferences

	aVarWithTwoReferences := 'use the variable here also'.
! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 4/26/2011 07:38'!
methodWithReferenceToVariables

	aVarWithOneReference := 'use the variable in this method only'.
	aVarWithTwoReferences := 'use the variable in this method and in one other method'.
! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 2/11/2012 17:50'!
setAVariable: oop
	aVariable := oop! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 7/9/2012 19:49'!
setBreakSelector: aString
	"breakSelector is an instance variable and should not be declared as a local in
	the generated code"
	breakSelector := aString! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 2/18/2014 20:13'!
setInstanceVariableWithAnAccessorMethod
	objectMemory setAVariable: (objectMemory remap: objectMemory getNilObj).
! !

!SlangTestSupportInterpreter methodsFor: 'local and instance vars' stamp: 'dtl 11/24/2014 22:11'!
sizeOfFoo
	^ self sizeOf: #Foo! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'dtl 4/25/2011 22:59'!
returnTypeByMethod
	"SlangTestSupportInterpreter asCString: #returnTypeByMethod"

	self returnTypeC: 'char *'.
! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'dtl 4/25/2011 23:00'!
returnTypeByPragma
	"SlangTestSupportInterpreter asCString: #returnTypeByPragma"

	<returnTypeC: 'char *'>
! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'dtl 4/25/2011 23:00'!
varDefByMethod
	"SlangTestSupportInterpreter asCString: #varDefByMethod"

	| foo bar |
	self var: #foo type: 'char *'.
	self var: #bar declareC: 'unsigned int * bar'
! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 22:26'!
varDefByMethodAndPragma
	"SlangTestSupportInterpreter asCString: #varDefByMethodAndPragma"

	| foo bar baz fum |
	<var: #baz type: 'float'>
	<var: #fum declareC: 'double fum'>
	self var: #foo type: 'char *'.
	self var: #bar declareC: 'unsigned int * bar'
! !

!SlangTestSupportInterpreter methodsFor: 'type declaration' stamp: 'dtl 4/25/2011 23:00'!
varDefByPragma
	"SlangTestSupportInterpreter asCString: #varDefByPragma"

	| foo bar |
	<var: #foo type: 'char *'>
	<var: #bar declareC: 'unsigned int * bar'>
! !

!SlangTestSupportInterpreter class methodsFor: 'translation' stamp: 'dtl 3/18/2013 18:50'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg := CCodeGeneratorGlobalStructure new initialize.
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

!SlangTestSupportInterpreter class methodsFor: 'translation' stamp: 'dtl 6/18/2012 00:21'!
uncheckedAbstractSelectors
	^ super uncheckedAbstractSelectors, ObjectMemory uncheckedAbstractSelectors! !

!SlangTestSupportInterpreter class methodsFor: 'instance creation' stamp: 'dtl 3/18/2013 14:31'!
inline: flag

	"Transcript show: (self inline: true) asCString"

	^self new inline: flag! !

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

!SlangTestSupportPlugin methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 22:21'!
anAbstractMethod

	self subclassResponsibility! !

!SlangTestSupportPlugin methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 08:19'!
doNotGenerateByMethod
	"SlangTestSupportInterpreter asCString: #doNotGenerateByMethod"

	self returnTypeC: #int.
	self doNotGenerate.
	^ 2 + 2
! !

!SlangTestSupportPlugin methodsFor: 'other declarations' stamp: 'dtl 8/25/2011 08:11'!
doNotGenerateByPragma
	"SlangTestSupportInterpreter asCString: #doNotGenerateByPragma"

	<doNotGenerate>
	<returnTypeC: #int>
	^ 2 + 2
! !

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:28'!
asCString

	| stream |
	stream := ReadWriteStream on: String new.
	self cg emitCCodeOn: stream doAssertions: true.
	^ stream contents
! !

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:29'!
asCString: selector

	| method stream |
	method := self cg methodNamed: selector.
	method ifNil: [^ 'No source has been generated'].
	stream := ReadWriteStream on: String new.
	method emitCCodeOn: stream generator: cg.
	^ stream contents
! !

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'dtl 3/18/2013 14:28'!
cg
	"Lazy initialize, once per test"

	cg ifNil: [ObjectMemory initialize; initializeConstants.
		cg := self class buildCodeGeneratorInlined: inlineFlag = true.
		cg prepareMethodsInlined: inlineFlag = true doAssertions: true].
	^ cg! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodEmbeddedWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i |
		1 to: self methodWithIntegerResult do: [:k | ]].
! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:49'!
callMethodTwiceWithLoopLimitThatMightBeModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatMightBeModified: aVar.
	self methodWithLoopLimitThatMightBeModified: aVar.
! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 21:38'!
callMethodTwiceWithSendInLoopLimit

	<export: true>
	1 to: self methodWithIntegerResult do: [:i | ].
	1 to: self methodWithIntegerResult do: [:i | ].
! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:51'!
callMethodWithLoopLimitThatIsNotModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatIsNotModified: aVar.
! !

!SlangTestSupportPlugin methodsFor: 'loop limits' stamp: 'dtl 4/4/2013 20:49'!
callMethodWithLoopLimitThatMightBeModified

	<export: true>
	| aVar |
	aVar := 'foo'.
	self methodWithLoopLimitThatMightBeModified: aVar.
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
	inlineFlag := flag! !

!SlangTestSupportPlugin methodsFor: 'inlining' stamp: 'dtl 9/19/2010 11:50'!
inlineByMethod
	"SlangTestSupport asCString: #inlineByMethod"
	"SlangTestSupport asInlinedCString: #inlineByMethod"

	| bar foo |
	foo := self methodThatShouldBeInlinedByMethod.
	bar := self methodThatShouldNotBeInlinedByMethod! !

!SlangTestSupportPlugin methodsFor: 'inlining' stamp: 'dtl 9/19/2010 11:50'!
inlineByPragma
	"SlangTestSupport asCString: #inlineByPragma"
	"SlangTestSupport asInlinedCString: #inlineByPragma"

	| bar foo |
	foo := self methodThatShouldBeInlinedByPragma.
	bar := self methodThatShouldNotBeInlinedByPragma! !

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

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 11:50'!
returnTypeByMethod
	"SlangTestSupport asCString: #returnTypeByMethod"

	self returnTypeC: 'char *'.
! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 11:51'!
returnTypeByPragma
	"SlangTestSupport asCString: #returnTypeByPragma"

	<returnTypeC: 'char *'>
! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 11:51'!
varDefByMethod
	"SlangTestSupport asCString: #varDefByMethod"

	| foo bar |
	self var: #foo type: 'char *'.
	self var: #bar declareC: 'unsigned int * bar'
! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 22:25'!
varDefByMethodAndPragma
	"SlangTestSupportPlugin asCString: #varDefByMethodAndPragma"

	| foo bar baz fum |
	<var: #baz type: 'float'>
	<var: #fum declareC: 'double fum'>
	self var: #foo type: 'char *'.
	self var: #bar declareC: 'unsigned int * bar'
! !

!SlangTestSupportPlugin methodsFor: 'type declaration' stamp: 'dtl 9/19/2010 12:05'!
varDefByPragma
	"SlangTestSupport asCString: #varDefByPragma"

	| foo bar |
	<var: #foo type: 'char *'>
	<var: #bar declareC: 'unsigned int * bar'>
! !

!SlangTestSupportPlugin class methodsFor: 'translation' stamp: 'dtl 3/18/2013 18:51'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg := VMPluginCodeGenerator new initialize.
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
