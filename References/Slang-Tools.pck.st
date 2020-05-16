'From Cuis 5.0 [latest update: #4112] on 13 May 2020 at 2:49:23 pm'!
'Description '!
!provides: 'Slang-Tools' 1 0!
SystemOrganization addCategory: #'Slang-Tools-Tests'!
SystemOrganization addCategory: #'Slang-Tools'!


!classDefinition: #SlangTest category: #'Slang-Tools-Tests'!
TestCase subclass: #SlangTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools-Tests'!
!classDefinition: 'SlangTest class' category: #'Slang-Tools-Tests'!
SlangTest class
	instanceVariableNames: ''!

!classDefinition: #CCodeGenerator category: #'Slang-Tools'!
Object subclass: #CCodeGenerator
	instanceVariableNames: 'translationDict inlineList constants variables variableDeclarations scopeStack methods macros apiMethods preparedMethodList variablesSetCache headerFiles globalVariableUsage useSymbolicConstants generateDeadCode doNotRemoveMethodList asArgumentTranslationDict receiverDict vmClass currentMethod logger declareMethodsStatic permitMethodPruning pools abstractDeclarations uncheckedAbstractMethods selectorTranslations breakSrcInlineSelector breakDestInlineSelector inlineReturnTypes'
	classVariableNames: 'UseRightShiftForDivide'
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'CCodeGenerator class' category: #'Slang-Tools'!
CCodeGenerator class
	instanceVariableNames: ''!

!classDefinition: #CCodeGeneratorGlobalStructure category: #'Slang-Tools'!
CCodeGenerator subclass: #CCodeGeneratorGlobalStructure
	instanceVariableNames: 'localStructDef structDefDefine'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'CCodeGeneratorGlobalStructure class' category: #'Slang-Tools'!
CCodeGeneratorGlobalStructure class
	instanceVariableNames: ''!

!classDefinition: #VMPluginCodeGenerator category: #'Slang-Tools'!
CCodeGenerator subclass: #VMPluginCodeGenerator
	instanceVariableNames: 'pluginClass pluginName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'VMPluginCodeGenerator class' category: #'Slang-Tools'!
VMPluginCodeGenerator class
	instanceVariableNames: ''!

!classDefinition: #Pragmatizer category: #'Slang-Tools'!
Object subclass: #Pragmatizer
	instanceVariableNames: 'package selectors classes stampCutString stampInsertString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'Pragmatizer class' category: #'Slang-Tools'!
Pragmatizer class
	instanceVariableNames: ''!

!classDefinition: #TMethod category: #'Slang-Tools'!
Object subclass: #TMethod
	instanceVariableNames: 'selector returnType args locals declarations primitive parseTree labels writtenToGlobalVarsCache complete export static sharedLabel sharedCase comment definingClass globalStructureBuildMethodHasFoo canAsmLabel mustAsmLabel properties cascadeVariableNumber extraVariableNumber'
	classVariableNames: 'CaseStatements'
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TMethod class' category: #'Slang-Tools'!
TMethod class
	instanceVariableNames: ''!

!classDefinition: #TParseNode category: #'Slang-Tools'!
Object subclass: #TParseNode
	instanceVariableNames: 'comment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TParseNode class' category: #'Slang-Tools'!
TParseNode class
	instanceVariableNames: ''!

!classDefinition: #TAssignmentNode category: #'Slang-Tools'!
TParseNode subclass: #TAssignmentNode
	instanceVariableNames: 'variable expression'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TAssignmentNode class' category: #'Slang-Tools'!
TAssignmentNode class
	instanceVariableNames: ''!

!classDefinition: #TBraceCaseNode category: #'Slang-Tools'!
TParseNode subclass: #TBraceCaseNode
	instanceVariableNames: 'caseLabels cases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TBraceCaseNode class' category: #'Slang-Tools'!
TBraceCaseNode class
	instanceVariableNames: ''!

!classDefinition: #TCaseStmtNode category: #'Slang-Tools'!
TParseNode subclass: #TCaseStmtNode
	instanceVariableNames: 'expression firsts lasts cases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TCaseStmtNode class' category: #'Slang-Tools'!
TCaseStmtNode class
	instanceVariableNames: ''!

!classDefinition: #TConstantNode category: #'Slang-Tools'!
TParseNode subclass: #TConstantNode
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TConstantNode class' category: #'Slang-Tools'!
TConstantNode class
	instanceVariableNames: ''!

!classDefinition: #TDefineNode category: #'Slang-Tools'!
TConstantNode subclass: #TDefineNode
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TDefineNode class' category: #'Slang-Tools'!
TDefineNode class
	instanceVariableNames: ''!

!classDefinition: #TGoToNode category: #'Slang-Tools'!
TParseNode subclass: #TGoToNode
	instanceVariableNames: 'label'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TGoToNode class' category: #'Slang-Tools'!
TGoToNode class
	instanceVariableNames: ''!

!classDefinition: #TInlineNode category: #'Slang-Tools'!
TParseNode subclass: #TInlineNode
	instanceVariableNames: 'method'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TInlineNode class' category: #'Slang-Tools'!
TInlineNode class
	instanceVariableNames: ''!

!classDefinition: #TLabeledCommentNode category: #'Slang-Tools'!
TParseNode subclass: #TLabeledCommentNode
	instanceVariableNames: 'label'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TLabeledCommentNode class' category: #'Slang-Tools'!
TLabeledCommentNode class
	instanceVariableNames: ''!

!classDefinition: #TNotImplementedNode category: #'Slang-Tools'!
TParseNode subclass: #TNotImplementedNode
	instanceVariableNames: 'parseNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TNotImplementedNode class' category: #'Slang-Tools'!
TNotImplementedNode class
	instanceVariableNames: ''!

!classDefinition: #TReturnNode category: #'Slang-Tools'!
TParseNode subclass: #TReturnNode
	instanceVariableNames: 'expression'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TReturnNode class' category: #'Slang-Tools'!
TReturnNode class
	instanceVariableNames: ''!

!classDefinition: #TSendNode category: #'Slang-Tools'!
TParseNode subclass: #TSendNode
	instanceVariableNames: 'selector receiver arguments isBuiltinOperator isExpression'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TSendNode class' category: #'Slang-Tools'!
TSendNode class
	instanceVariableNames: ''!

!classDefinition: #TStmtListNode category: #'Slang-Tools'!
TParseNode subclass: #TStmtListNode
	instanceVariableNames: 'arguments statements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TStmtListNode class' category: #'Slang-Tools'!
TStmtListNode class
	instanceVariableNames: ''!

!classDefinition: #TSwitchStmtNode category: #'Slang-Tools'!
TParseNode subclass: #TSwitchStmtNode
	instanceVariableNames: 'expression cases otherwiseOrNil switchVariable'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TSwitchStmtNode class' category: #'Slang-Tools'!
TSwitchStmtNode class
	instanceVariableNames: ''!

!classDefinition: #TVariableNode category: #'Slang-Tools'!
TParseNode subclass: #TVariableNode
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'TVariableNode class' category: #'Slang-Tools'!
TVariableNode class
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

!CCodeGenerator commentStamp: 'tpr 5/2/2003 14:30' prior: 0!
This class oversees the translation of a subset of Smalltalk to C, allowing the comforts of Smalltalk during development and the efficiency and portability of C for the resulting interpreter.  
See VMMaker for more useful info!

!CCodeGeneratorGlobalStructure commentStamp: 'tpr 5/23/2003 11:17' prior: 0!
This subclass of CCodeGenerator adds support for sticking most global variables into a large global array. This in turn means that suitably minded C compilers can do a better job of accessing those variables; in particular the Mac OS use of PPC and Acorn use of ARM benfits by a substantial margin. 

Only simple globals are currently put in the array. Someday we might try adding pointers to the various arrays etc.!

!VMPluginCodeGenerator commentStamp: '<historical>' prior: 0!
I generate code that can be loaded dynamically from external libraries (e.g., DSOs on Unix or DLLs on Windows)!

!Pragmatizer commentStamp: 'dtl 9/25/2010 18:26' prior: 0!
Pragmatizer is a utility for converting message send directives (such as 'self inline: true') to their corresponding pragma implementations (<inline: true>) in method source.

The #depragmatize method provides a means for reverting to message send directives. This may be useful in the event of needing to load VMMaker into an image that does not support pragmas.

This is based on an original script provided by Eliot Miranda.!

!TMethod commentStamp: 'dtl 9/15/2008 09:06' prior: 0!
A TMethod is a translation method, representing a MethodNode that is to be translated to C source. It has a parseTree of translation nodes that mirrors the parse tree of the corresponding Smalltalk method.!

!TParseNode commentStamp: 'dtl 9/15/2008 09:05' prior: 0!
A TParseNode is node in the parse tree of a TMethod. Subclasses correspond to different types of nodes in a method parse tree. The tree of translation parse nodes mirrors the parse tree of a Smalltalk method, and is used for translating a Smalltalk method to C source.!

!TNotImplementedNode commentStamp: 'dtl 10/12/2010 19:37' prior: 0!
A TNotImplementedNode is a translation node for a parse node that cannot be translated, or for which translation is not yet implemented.
!

!TSwitchStmtNode commentStamp: '<historical>' prior: 0!
I implement a Smalltalk
	foo caseOf: { [IntegerConstant | GlobalVariable] -> [expr] }
statement converting it into a C switch statement.  I make some effort to discover identical right-hand-side cases.!

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

!TMethod methodsFor: 'accessing' stamp: 'hg 8/14/2000 15:57'!
comment: aComment

	comment := aComment ! !

!TMethod methodsFor: 'printing' stamp: 'TPR 3/2/2000 18:36'!
printOn: aStream

	super printOn: aStream.
	aStream nextPutAll: ' (', selector, ')'.! !

!TParseNode methodsFor: 'accessing' stamp: 'hg 8/14/2000 15:32'!
comment: aComment

	comment := aComment ! !

!TParseNode methodsFor: 'testing'!
isVariable

	^false! !

!TParseNode methodsFor: 'printing'!
printOn: aStream 
	"Append a description of the receiver onto the given stream."

	self printOn: aStream level: 0.! !

!TConstantNode methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:04'!
name
	^''! !

!TDefineNode methodsFor: 'as yet unclassified' stamp: 'ar 7/8/2003 11:04'!
name
	^name! !

!TSwitchStmtNode methodsFor: 'copying' stamp: 'eem 2/9/2009 19:26'!
postCopy
	expression := expression copy.
	cases := (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode copy].
				   pair last copy }]).
	otherwiseOrNil := otherwiseOrNil copy! !

!TVariableNode methodsFor: 'as yet unclassified'!
name

	^name! !

!TVariableNode methodsFor: 'testing'!
isVariable

	^true! !

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

!CCodeGenerator methodsFor: 'public' stamp: 'TPR 3/2/2000 11:22'!
addAllClassVarsFor: aClass
	"Add the class variables for the given class (and its superclasses) to the code base as constants."

	| allClasses |
	allClasses := aClass withAllSuperclasses.
	allClasses do: [:c | self addClassVarsFor: c].
! !

!CCodeGenerator methodsFor: 'public' stamp: 'dtl 3/23/2013 15:46'!
addClass: aClass
	"Add the variables and methods of the given class to the code base."

	aClass prepareToBeAddedToCodeGenerator: self.
	self checkClassForNameConflicts: aClass.
	self addClassVarsFor: aClass.
	"ikp..."
	self addPoolVarsFor: aClass.
	variables addAll: aClass instVarNames.
	self retainMethods: aClass requiredMethodNames.

	"The identity of the translated class is kept in vmClass for use in identifying the
	translated source. Unless otherwise overridden, the first class to be added to the
	code generator will provide this identifier."
	vmClass ifNil: [self vmClass: aClass].
	'Adding Class ' , aClass name , '...'
		displayProgressAt: Sensor cursorPoint
		from: 0
		to: aClass selectors size
		during:
			[:bar |
			 aClass selectors doWithIndex: [:sel :i |
				bar value: i.
				self addMethodFor: aClass selector: sel]].
	aClass declareCVarsIn: self! !

!CCodeGenerator methodsFor: 'public' stamp: 'ar 7/8/2003 11:16'!
addClassVarsFor: aClass
	"Add the class variables for the given class to the code base as constants."
	| val node |
	aClass classPool associationsDo: [:assoc | 
		val := assoc value.
		(useSymbolicConstants and:[self isCLiteral: val])
			ifTrue:[node := TDefineNode new setName: assoc key asString value: assoc value]
			ifFalse:[node := TConstantNode new setValue: assoc value].
		constants at: assoc key asString put: node].
! !

!CCodeGenerator methodsFor: 'public' stamp: 'ar 2/14/1999 01:08'!
addHeaderFile: aString
	"Add a header file. The argument must be a quoted string!!"
	headerFiles addLast: aString.! !

!CCodeGenerator methodsFor: 'public' stamp: 'eem 2/14/2009 09:10'!
addMacro: aString for: selector
	"Add a macro. aString must be the macro arguments and body without the leading #define or name"
	macros at: selector put: aString! !

!CCodeGenerator methodsFor: 'public' stamp: 'ar 2/1/2011 12:00'!
addMethodsForPrimitives: classAndSelectorList 
	| sel aClass source verbose meth |
	classAndSelectorList do:[:classAndSelector | 
		aClass := Smalltalk at: (classAndSelector at: 1) ifAbsent:[nil].
		aClass ifNotNil:[
			self addAllClassVarsFor: aClass.
			"TPR - should pool vars also be added here?"

			"find the method in either the class or the metaclass"
			sel := classAndSelector at: 2.
			(aClass includesSelector: sel)
				ifTrue: [source := aClass sourceCodeAt: sel ifAbsent:[nil]]
				ifFalse: [source := aClass class sourceCodeAt: sel ifAbsent:[nil]].
		].
		source ifNil:[
			Transcript cr; show: 'WARNING: Compiled primitive ', classAndSelector first, '>>', classAndSelector last, ' not present'.
		] ifNotNil:[
			"compile the method source and convert to a suitable translation 
			method "
			meth := (Compiler new
						parse: source
						in: aClass
						notifying: nil)
						asTranslationMethodOfClass: self translationMethodClass.

			(aClass includesSelector: sel)
				ifTrue: [meth definingClass: aClass]
				ifFalse: [meth definingClass: aClass class].
			meth primitive > 0 ifTrue:[meth preparePrimitiveName].
			"for old-style array accessing: 
			meth covertToZeroBasedArrayReferences."
			meth replaceSizeMessages.
			self addMethod: meth.
		].
	].
	"method preparation"
	verbose := false.
	self prepareMethods.
	verbose
		ifTrue: 
			[self printUnboundCallWarnings.
			self printUnboundVariableReferenceWarnings.
			Transcript cr].

	"code generation"
	self doInlining: true.

	methods do:[:m|
		"if this method is supposed to be a primitive (rather than a helper 
		routine), add assorted prolog and epilog items"
		m primitive > 0 ifTrue: [m preparePrimitivePrologue]].! !

!CCodeGenerator methodsFor: 'public' stamp: 'eem 1/28/2009 14:38'!
addPoolVarsFor: aClass 
	"Add the pool variables for the given class to the code base as constants."

	(aClass sharedPools reject: [:pool| pools includes: pool]) do:
		[:pool |
		pools add: pool.
		pool bindingsDo: [:assoc | | val node |
			val := assoc value.
			node := (useSymbolicConstants and:[self isCLiteral: val])
						ifTrue:[TDefineNode new setName: assoc key asString value: assoc value]
						ifFalse:[TConstantNode new setValue: assoc value].
			constants at: assoc key asString put: node]].! !

!CCodeGenerator methodsFor: 'public' stamp: 'eem 12/11/2010 13:42'!
addSelectorTranslation: aSelector to: aString
	selectorTranslations at: aSelector asSymbol put: aString! !

!CCodeGenerator methodsFor: 'public' stamp: 'ikp 9/26/97 14:48'!
codeString
	"Return a string containing all the C code for the code base. Used for testing."

	| stream |
	stream := ReadWriteStream on: (String new: 1000).
	self emitCCodeOn: stream doInlining: true doAssertions: true.
	^stream contents! !

!CCodeGenerator methodsFor: 'public' stamp: 'asf 10/14/2014 19:10'!
declToType: decl
	"Extracts the type from a C declaration string"

	| strs r |
	decl isNil ifFalse: [
		(decl indexOf: $=) > 0 ifTrue:
			[ strs := (decl copyFrom: 1 to: ((decl indexOf: $=) - 1)) ]
		ifFalse: [ strs := decl ].
		strs := (strs withoutTrailingBlanks) subStrings: ' '.
		strs size == 1 ifTrue: [ ^ strs first ]
			ifFalse:
		[
			| asterisks |
			r := ''.
			strs allButLastDo: [ :s | r := r,s,' ' ].
			"Bit of a hack to get 'type *'"
			asterisks := (strs last copyFrom: 1 to: (strs last lastIndexOf: $*)).
			asterisks size > 0 ifTrue: [ r := r,' ',asterisks ].
			r := r withoutTrailingBlanks.
			(((r indexOf: $() > 0) or: ((r indexOf: $)) > 0)) ifTrue: [ ^nil ].
			^r withoutTrailingBlanks
		].
	] ifTrue: [ ^nil ].! !

!CCodeGenerator methodsFor: 'public' stamp: 'ar 3/16/2002 18:00'!
declareModuleName: nameString
	"add the declaration of a module name, version and local/external tag"

	self var: #moduleName declareC:'const char *moduleName =
#ifdef SQUEAK_BUILTIN_PLUGIN
	"', nameString,' (i)"
#else
	"', nameString,' (e)"
#endif
'.! !

!CCodeGenerator methodsFor: 'public' stamp: 'eem 2/11/2009 08:52'!
declareVar: varName type: type
	"This both creates a varable and provides its type"
	self var: (variables add: varName asString) type: type! !

!CCodeGenerator methodsFor: 'public' stamp: 'dtl 2/5/2007 07:45'!
exportedPrimitiveNames
	"Return an array of all exported primitives"
	^methods select:[:m| m export] thenCollect:[:m| m selectorForCodeGeneration copyWithout: $:].
! !

!CCodeGenerator methodsFor: 'public'!
globalsAsSet
	"Used by the inliner to avoid name clashes with global variables."

	((variablesSetCache == nil) or:
	 [variablesSetCache size ~= variables size]) ifTrue: [
		variablesSetCache := variables asSet.
	].
	^ variablesSetCache! !

!CCodeGenerator methodsFor: 'public' stamp: 'dtl 12/28/2014 18:52'!
initialize
	translationDict := Dictionary new.
	constants := Dictionary new: 100.
	variables := OrderedCollection new: 100.
	variableDeclarations := Dictionary new: 100.
	methods := Dictionary new: 500.
	macros := Dictionary new.
	self initializeCTranslationDictionary.
	receiverDict := Dictionary new.
	headerFiles := OrderedCollection new.
	globalVariableUsage := Dictionary new.
	useSymbolicConstants := true.
	generateDeadCode := true.
	scopeStack := OrderedCollection new.
	logger := (ProvideAnswerNotification new tag: #logger; signal) ifNil: [Transcript].
	pools := IdentitySet new.
	abstractDeclarations := IdentitySet new.
	uncheckedAbstractMethods := OrderedCollection new.
	selectorTranslations := IdentityDictionary new.! !

!CCodeGenerator methodsFor: 'public' stamp: 'JMM 11/28/2002 11:52'!
isGlobalStructureBuild
	^false! !

!CCodeGenerator methodsFor: 'public' stamp: 'ikp 9/26/97 14:50'!
storeCodeOnFile: fileName doInlining: inlineFlag
	"Store C code for this code base on the given file."

	self storeCodeOnFile: fileName doInlining: inlineFlag doAssertions: true! !

!CCodeGenerator methodsFor: 'public' stamp: 'tpr 9/26/2001 07:28'!
storeCodeOnFile: fileName doInlining: inlineFlag doAssertions: assertionFlag
	"Store C code for this code base on the given file."

	| stream |
	stream := CrLfFileStream forceNewFileNamed: fileName.
	stream ifNil: [Error signal: 'Could not open C code file: ', fileName].
	self emitCCodeOn: stream doInlining: inlineFlag doAssertions: assertionFlag.
	stream close! !

!CCodeGenerator methodsFor: 'public' stamp: 'dtl 4/13/2013 10:11'!
storeHeaderFor: interpreterClassName onFile: fileName
	"Store C header code for this interpreter on the given file."

	| aStream |
	aStream := CrLfFileStream forceNewFileNamed: fileName.
	aStream ifNil: [Error signal: 'Could not open C header file: ', fileName].
	aStream
		nextPutAll: '/* ';
		nextPutAll: VMMaker headerNotice;
		nextPutAll: ' */'; cr; cr;
		nextPutAll: (self fileHeaderVersionStampForSourceClass: nil); cr; cr;
		nextPutAll: '#ifndef HAVE_INTERP_H'; cr;
		nextPutAll: '# define HAVE_INTERP_H'; cr;
		nextPutAll: '#endif'; cr; cr.
	self emitVmmVersionOn: aStream.
	(Smalltalk classNamed: interpreterClassName)
		emitInterpreterProxyVersionOn: aStream.
	self emitDefineBytesPerWordOn: aStream.
	self emitDefineMemoryAccessInImageOn: aStream.
	aStream cr.
	aStream close
! !

!CCodeGenerator methodsFor: 'public' stamp: 'eem 5/17/2011 12:19'!
storeHeaderOnFile: fileName contents: contents
	"Store C header code on the given file. Evaluate
	 aBlock with the stream to generate its contents."

	| aStream |
	aStream := VMMaker forceNewFileNamed: fileName.
	aStream ifNil: [Error signal: 'Could not open C header file: ', fileName].
	[(contents beginsWith: '/* Automatic') ifFalse:
		[aStream nextPutAll: (self fileHeaderVersionStampForSourceClass: nil); cr].
	 aStream nextPutAll: contents]
		ensure: [aStream close]! !

!CCodeGenerator methodsFor: 'public' stamp: 'eem 7/16/2009 14:07'!
var: varName declareC: declarationString
	"Record the given C declaration for a global variable."

	(declarationString includesSubString: varName) ifFalse:
		[self error: 'declaration omits variable name.  probably an error.  use e.g. var:type:'].
	variableDeclarations at: varName asString put: declarationString.! !

!CCodeGenerator methodsFor: 'public' stamp: 'tpr 12/29/2005 15:59'!
var: varName type: type
"Use this in preference to #var:declareC: whenver possible since it avoids typing the varname twice and thus avoids the potential for a typo. See also #var:type:array:"
	self var: varName declareC: type , ' ' , varName! !

!CCodeGenerator methodsFor: 'public' stamp: 'tpr 12/29/2005 16:00'!
var: varName type: type array: array
"use this in preference to #var:declareC: when possible. This produces a C statment of the form
int * fooArray[]={1,2,3}
See also #var:type: for simple var decls" 
	self
		var: varName
		declareC: (String streamContents: [:s |
			s nextPutAll: type.
			s space.
			s nextPutAll: varName.
			s nextPutAll: '[] = {'.
			self printArray: array on: s.
			s nextPut: $}])! !

!CCodeGenerator methodsFor: 'public' stamp: 'eem 2/9/2009 14:51'!
vmClass
	"Answer the interpreter classs if any.  This is nil other than for the core VM."
	^vmClass! !

!CCodeGenerator methodsFor: 'public' stamp: 'eem (auto rename) 2/9/2009 12:18'!
vmClass: aClass
	"Set the interpreter class if any.  This is nil other than for the core VM."
	vmClass := aClass! !

!CCodeGenerator methodsFor: 'composition' stamp: 'dtl 1/25/2012 05:18'!
addClass: aClass selectorPrefix: prefix
	"Incorporate the methods of aClass, and rename with prefixes reflecting the
	variable name. This is a simple transformation intended to support MemoryAccess,
	with renaming to avoid conflict with standard sqMemoryAccess.h macros."

	self addClass: aClass.
	aClass selectors do: [:sel |
		self renameSelector: sel
			as: (prefix, '_', sel) asSymbol].
! !

!CCodeGenerator methodsFor: 'composition' stamp: 'dtl 4/11/2012 21:28'!
addClass: aClass upTo: aSuperclass asInstanceVariable: varName
	"For an instance variable var in one of the classes that has been added to
	this code generator, assume that an instance of aClass would normally be
	assigned to that variable. Arrange for the methods in aClass and all superclasses
	up to but not including aSuperclass to be incorporated into the generated C source
	module as if they had been methods in the class with instance variable var.
	
	n.b. See #addStructureClass: mechanism in Cog."

	| cls |
	cls := aClass.
	[cls == aSuperclass]
		whileFalse: [self addClass: cls.
				self mapVar: varName asInstanceOf: cls to: 'self'.
				cls := cls superclass]
! !

!CCodeGenerator methodsFor: 'composition' stamp: 'dtl 4/11/2012 18:52'!
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

!CCodeGenerator methodsFor: 'composition' stamp: 'dtl 8/20/2011 14:32'!
renameSelector: selectorName as: newSelectorName
	"Rename selectors such that generated code will use the newSelectorName. This
	is intended to allow methods that may have default implementations in the support
	code to be renamed for code generation, such that the renamed versions will
	be referenced rather than the default platform implementations. For example,
	if #pointerForOop: is implemented in Smalltalk, it may be renamed such that
	the generated pointerForOop() function will be renamed to avoid conflict with
	the standard definitions provided in sqMemoryAccess.h."

	(methods includesKey: selectorName)
		ifFalse: [ self error: 'no such selector: ', selectorName ].
	methods do: [ :m |
		m renameSelector: selectorName as: newSelectorName ].
	methods at: newSelectorName put: (methods at: selectorName).
	methods removeKey: selectorName
! !

!CCodeGenerator methodsFor: 'utilities'!
addMethod: aTMethod
	"Add the given method to the code base."

	(methods includesKey:  aTMethod selector) ifTrue: [
		self error: 'Method name conflict: ', aTMethod selector.
	].
	methods at: aTMethod selector put: aTMethod.! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'dtl 5/27/2012 17:42'!
addMethodFor: aClass selector: selector
	"Add the given method to the code base and answer its translation
	 or nil if it shouldn't be translated."

	| method tmethod |
	method := aClass compiledMethodAt: selector.
	method requiresConcreteImplementation ifTrue: [abstractDeclarations add: selector].
	method isAbstract ifTrue: [^nil].
	(method pragmaAt: #doNotGenerate) ifNotNil: [^nil].
	"process optional methods by interpreting the argument to the option: pragma as either
	 a Cogit class name or a class variable name or a variable name in VMBasicConstants."
	(method pragmaAt: #option:) ifNotNil:
		[:pragma| | key |
		key := pragma argumentAt: 1.
		"((Cogit withAllSubclasses anySatisfy: [:c| c name = key])
		and: [VMClass getVMMaker cogitClassName ~= key]) ifTrue:
			[^nil]."
		(aClass bindingOf: key) ifNotNil:
			[:binding|
			binding value ifFalse: [^nil]].
		(VMBasicConstants bindingOf: key) ifNotNil:
			[:binding|
			binding value ifFalse: [^nil]]].
	tmethod := self compileToTMethodSelector: selector in: aClass.
	tmethod hasDoNotGenerateStatement ifTrue: [^nil].
	self addMethod: tmethod.
	"If the method has a macro then add the macro.  But keep the method
	 for analysis purposes (e.g. its variable accesses)."
	(method pragmaAt: #cmacro:) ifNotNil:
		[:pragma|
		self addMacro: (pragma argumentAt: 1) for: selector].
	(method propertyValueAt: #cmacro:) ifNotNil:
		[:macro|
		self addMacro: macro for: selector].
	^tmethod! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'dtl 7/2/2008 16:46'!
builtin: sel 
	"Answer true if the given selector is one of the builtin selectors."
	^ sel = #error:
		or: [(self memoryAccessSelectors includes: sel)
				or: [translationDict includesKey: sel]]! !

!CCodeGenerator methodsFor: 'utilities'!
cCodeForMethod: selector
	"Answer a string containing the C code for the given method."
	"Example:
		((CCodeGenerator new initialize addClass: TestCClass1; prepareMethods)
			cCodeForMethod: #ifTests)"

	| m s |
	m := self methodNamed: selector.
	m = nil ifTrue: [ self error: 'method not found in code base: ', selector ].

	s := (ReadWriteStream on: '').
	m emitCCodeOn: s generator: self.
	^ s contents! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 2/12/2009 13:44'!
checkDeleteVariable: aName
	"Hook for debugging variable deletion."! !

!CCodeGenerator methodsFor: 'utilities'!
checkForGlobalUsage: vars in: aTMethod 
	| item |
	vars
		do: [:var | 
			"TPR - why the use of globalsAsSet here instead of globalVariables? 
			JMM - globalVariables is not initialized yet, variables is an OrderedCollection, 
				globalsAsSet returns variables as needed set"
			(self globalsAsSet includes: var)
				ifTrue: ["find the set of method names using this global var"
					item := globalVariableUsage
								at: var
								ifAbsent: [globalVariableUsage at: var put: Set new].
					"add this method name to that set"
					item add: aTMethod selector]].
	aTMethod referencesGlobalStructMakeZero! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 2/12/2009 10:50'!
compileToTMethodSelector: selector in: aClass
	"Compile a method to a TMethod"

	^(Compiler new
		parse: (aClass sourceCodeAt: selector)
		in: aClass
		notifying: nil)
			asTranslationMethodOfClass: self translationMethodClass! !

!CCodeGenerator methodsFor: 'utilities' stamp: ' 2/7/08 14:57'!
emitBuiltinConstructAsArgumentFor: msgNode on: aStream level: level
	"If the given selector is in the translation dictionary, translate it into a target code construct and return true. Otherwise, do nothing and return false."

	| action |
	action := asArgumentTranslationDict
				at: msgNode selector
				ifAbsent: [translationDict at: msgNode selector ifAbsent: [ ^false ]].
	self perform: action with: msgNode with: aStream with: level.
	^true! !

!CCodeGenerator methodsFor: 'utilities'!
emitBuiltinConstructFor: msgNode on: aStream level: level
	"If the given selector is in the translation dictionary, translate it into a target code construct and return true. Otherwise, do nothing and return false."

	| action |
	action := translationDict at: msgNode selector ifAbsent: [ ^false ].
	self perform: action with: msgNode with: aStream with: level.
	^true! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 7/19/2013 10:32'!
isBuiltinSelector: sel
	"Answer true if the given selector is one of the builtin selectors."

	^(self isKernelSelector: sel) or: [translationDict includesKey: sel]! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'ar 10/7/1998 17:53'!
isGeneratingPluginCode
	^false! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 10/30/2013 11:01'!
isKernelSelector: sel
	"Answer true if the given selector is one of the kernel selectors that are implemented as macros."

	^(#(error:
		 oopAt: oopAt:put: oopAtPointer: oopAtPointer:put:
		 byteAt: byteAt:put: byteAtPointer: byteAtPointer:put:
		 shortAt: shortAt:put: shortAtPointer: shortAtPointer:put:
		 intAt: intAt:put: intAtPointer: intAtPointer:put:
		 longAt: longAt:put: longAtPointer: longAtPointer:put:
		 longLongAt: longLongAt:put: longLongAtPointer: longLongAtPointer:put:
		 fetchFloatAt:into: storeFloatAt:from:
				fetchFloatAtPointer:into: storeFloatAtPointer:from:
		 fetchSingleFloatAt:into: storeSingleFloatAt:from:
				fetchSingleFloatAtPointer:into: storeSingleFloatAtPointer:from:
		 pointerForOop: oopForPointer:
		 cCoerce:to: cCoerceSimple:to:)
			includes: sel)! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'dtl 7/11/2012 20:36'!
localizeGlobalVariables
	| candidates procedure |

	"find all globals used in only one method"
	candidates := globalVariableUsage select: [:e | e size = 1].
	(candidates keys select: [:k| vmClass mustBeGlobal: k]) do:
		[:k| candidates removeKey: k].
	variables removeAllFoundIn: candidates keys.

	"move any suitable global to be local to the single method using it"
	candidates keysAndValuesDo: [:key :targets | 
		targets do: [:name |
			procedure := methods at: name.
			procedure locals add: key.
			variableDeclarations at: key ifPresent: [:v | 
				procedure declarations at: key put: v.
				variableDeclarations removeKey: key]]].! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 7/28/2008 11:51'!
logger
	^logger! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 7/28/2008 11:51'!
logger: aTranscriptStream
	logger := aTranscriptStream! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'dtl 7/3/2008 12:16'!
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

!CCodeGenerator methodsFor: 'utilities'!
methodNamed: selector
	"Answer the method in the code base with the given selector."

	^ methods at: selector ifAbsent: [ nil ]! !

!CCodeGenerator methodsFor: 'utilities'!
methodsReferringToGlobal: v
	"Return a collection of methods that refer to the given global variable."

	| out |
	out := OrderedCollection new.
	methods associationsDo: [ :assoc |
		(assoc value freeVariableReferences includes: v) ifTrue: [
			out add: assoc key.
		].
	].
	^ out! !

!CCodeGenerator methodsFor: 'utilities'!
methodsThatCanInvoke: aSelectorList
	"Return a set of methods that can invoke one of the given selectors, either directly or via a sequence of intermediate methods."

	| out todo sel mSelector |
	out := Set new.
	todo := aSelectorList copy asOrderedCollection.
	[todo isEmpty] whileFalse: [
		sel := todo removeFirst.
		out add: sel.
		methods do: [ :m |
			(m allCalls includes: sel) ifTrue: [
				mSelector := m selector.
				((out includes: mSelector) or:
				 [todo includes: mSelector]) ifFalse: [
					todo add: mSelector.
				].
			].
		].
	].
	^ out
	! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'ar 7/8/2003 11:16'!
nilOrBooleanConstantReceiverOf: sendNode
	"Answer nil or the boolean constant that is the receiver of the given message send. Used to suppress conditional code when the condition is a translation-time constant."

	| rcvr val |
	generateDeadCode ifTrue:[^nil].
	rcvr := sendNode receiver.
	rcvr isConstant ifTrue: [
		val := rcvr value.
		((val == true) or: [val == false]) ifTrue: [^ val]].
	^ nil
! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'dtl 1/22/2012 14:34'!
prepareMethods
	"Prepare methods for browsing."

	| globals |
	globals := Set new: 200.
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

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 4/17/2009 14:40'!
removeMethodForSelector: aSelector
	"Remove the given method from the code base"
	methods removeKey:  aSelector ifAbsent: []! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 12/22/2010 14:31'!
removeVariable: aName
	"Remove the given (instance) variable from the code base."
	self checkDeleteVariable: aName.
	variables
		remove: aName
		ifAbsent:
			[(vmClass notNil
			  and: [vmClass isNonArgumentImplicitReceiverVariableName: aName]) ifFalse:
				[logger
					ensureCr;
					show: 'warning, variable '
						, aName
						, ' doesn''t exist or has already been removed';
						cr]].
	variableDeclarations removeKey: aName ifAbsent: []! !

!CCodeGenerator methodsFor: 'utilities'!
reportRecursiveMethods
	"Report in transcript all methods that can call themselves directly or indirectly or via a chain of N intermediate methods."

	| visited calls newCalls sel called |
	methods do: [: m |
		visited := translationDict keys asSet.
		calls := m allCalls asOrderedCollection.
		5 timesRepeat: [
			newCalls := Set new: 50.
			[calls isEmpty] whileFalse: [
				sel := calls removeFirst.
				sel = m selector ifTrue: [
					Transcript show: m selector, ' is recursive'; cr.
				] ifFalse: [
					(visited includes: sel) ifFalse: [
						called := self methodNamed: sel.
						called = nil ifFalse: [ newCalls addAll: called allCalls ].
					].
					visited add: sel.
				].
			].
			calls := newCalls asOrderedCollection.
		].
	].! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'JMM 4/16/2002 22:39'!
returnPrefixFromVariable: aName
	^aName! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem 5/20/2010 20:46'!
sortMethods: aTMethodCollection
	"We need to define this since different Squeak versions answer different results
	 for asSortedCollection and if sort order changes, generated code changes too."
	^aTMethodCollection asSortedCollection:
		[:a :b| a selector caseSensitiveLessOrEqual: b selector]! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'TPR 3/2/2000 11:45'!
translationMethodClass
	"return the class used to produce C translation methods from MethodNodes"
	^TMethod! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'ar 7/17/1999 15:06'!
unreachableMethods
	"Return a collection of methods that are never invoked."

	| sent out |
	sent := Set new.
	methods do: [ :m |
		m export ifTrue:[sent add: m selector].
		sent addAll: m allCalls.
	].

	out := OrderedCollection new.
	methods keys do: [ :sel |
		(sent includes: sel) ifFalse: [ out add: sel ].
	].
	^ out! !

!CCodeGenerator methodsFor: 'utilities' stamp: 'eem (auto rename) 10/13/2008 14:28'!
wantsLabels
	"Only label the VM, not plugins (internal or external).  This to cut down the scope
	 of problems with labels being duplicated by C compiler optimizer inlining and
	 loop unrolling.  We use the asmLabel: directive to control labelling in the
	 interpreter proper. But it is too much work doing that for plugins too."
	^vmClass notNil and: [vmClass wantsLabels]! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'eem 10/30/2012 15:54'!
breakDestInlineSelector
	^breakDestInlineSelector! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'eem 10/30/2012 15:54'!
breakDestInlineSelector: aSelector
	breakDestInlineSelector := aSelector! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'eem 10/30/2012 15:55'!
breakSrcInlineSelector
	^breakSrcInlineSelector! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'eem 10/30/2012 15:54'!
breakSrcInlineSelector: aSelector
	breakSrcInlineSelector := aSelector! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'eem 7/2/2008 16:01'!
currentMethod
	^currentMethod! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'eem 7/2/2008 16:01'!
currentMethod: aTMethod
	currentMethod := aTMethod! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 17:25'!
declareMethodsStatic
	"If true generated methods will be declared static. Default is true,
	appropriate for plugins."
	^ declareMethodsStatic
		ifNil: [declareMethodsStatic := true]! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 17:26'!
declareMethodsStatic: aBoolean
	"If set false, generated methods will be not declared static.
	Default value is true."
	declareMethodsStatic := aBoolean! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:26'!
generateDeadCode
	"Answer whether we should generate 'dead code' branches. This can be useful for hacking the VM when used in conjunction with #useSymbolicConstants, e.g., for code like:
		DoAssertionChecks ifTrue:[
			...
		].

	we will generate

		#define DoAssertionChecks 0
		...
		if(DoAssertionChecks) {
			...
		}.

	allowing us to change the #define (or redefine it as a variable) for later use."
	^generateDeadCode! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:26'!
generateDeadCode: aBool
	"Indicate whether we should generate 'dead code' branches."
	generateDeadCode := aBool! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 18:54'!
permitMethodPruning
	"If false, pruning unreferenced methods will be disabled"
	^ permitMethodPruning ~= false! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 18:53'!
permitMethodPruning: aBoolean
	"If false, pruning unreferenced methods will be disabled"
	permitMethodPruning := aBoolean! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'dtl 6/17/2012 23:01'!
uncheckedAbstractMethods
	"Answer the selectors for methods that should not be checked to ensure existence
	of concrete implementations, such as methods that are generated directly by the
	code generator itself."

	^uncheckedAbstractMethods

! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:23'!
useSymbolicConstants
	"Answer whether we should generate symbolic constants instead of their actual values"
	^useSymbolicConstants! !

!CCodeGenerator methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:23'!
useSymbolicConstants: aBool
	"Indicate whether we should generate symbolic constants instead of their actual values"
	useSymbolicConstants := aBool! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 12/12/2012 11:29'!
cFunctionNameFor: aSelector
	"Create a C function name from the given selector by finding
	 a specific translation, or if none, simply omitting colons."
	^selectorTranslations at: aSelector ifAbsent: [aSelector copyWithout: $:]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 11/22/2013 16:04'!
cLiteralFor: anObject
	"Return a string representing the C literal value for the given object."
	anObject isNumber
		ifTrue:
			[anObject isInteger ifTrue:
				[| printString |
				 printString := (anObject > 0
								and: [(anObject >> anObject lowBit + 1) isPowerOfTwo
								and: [(anObject highBit = anObject lowBit and: [anObject > 65536])
									  or: [anObject highBit - anObject lowBit >= 4]]])
									ifTrue: ['0x', (anObject printStringBase: 16)]
									ifFalse: [anObject printString].
				^anObject > 16rFFFFFFFF
						ifTrue: [printString, ObjectMemory unsignedLongLongSuffix]
						ifFalse: [anObject < 16r7FFFFFFF
							ifTrue: [printString]
							ifFalse: [printString, ObjectMemory unsignedIntegerSuffix]]].
			anObject isFloat ifTrue:
				[^anObject printString]]
		ifFalse:
			[anObject isSymbol ifTrue:
				[^self cFunctionNameFor: anObject].
			anObject isString ifTrue:
				[^'"', (anObject copyReplaceAll: (String with: Character cr) with: '\n') , '"'].
			anObject == nil ifTrue: [^ 'null' ].
			anObject == true ifTrue: [^ '1' ].
			anObject == false ifTrue: [^ '0' ].
			anObject isCharacter ifTrue:
				[^anObject == $'
					ifTrue: ['''\'''''] "i.e. '\''"
					ifFalse: [anObject asString printString]]].
	self error: 'Warning: A Smalltalk literal could not be translated into a C constant: ', anObject printString.
	^'"XXX UNTRANSLATABLE CONSTANT XXX"'! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 1/2/2013 11:19'!
cLiteralFor: anObject name: smalltalkName
	"Return a string representing the C literal value for the given object.
	 This version may use hex for integers that are bit masks."
	anObject isInteger ifTrue:
		[| hex dec rep |
		hex := anObject printStringBase: 16.
		dec := anObject printStringBase: 10.
		rep := ((smalltalkName endsWith: 'Mask')
				or: [anObject digitLength > 1
					and: [(hex asSet size * 3) <= (dec asSet size * 2)
					and: [(smalltalkName endsWith: 'Size') not]]])
					ifTrue: [hex first = $- ifTrue: ['-0x', hex allButFirst] ifFalse: ['0x', hex]]
					ifFalse: [dec].
		^anObject > 16rFFFFFFFF
			ifTrue: [rep, ObjectMemory unsignedLongLongSuffix]
			ifFalse: [anObject < 16r7FFFFFFF
				ifTrue: [rep]
				ifFalse: [rep, ObjectMemory unsignedIntegerSuffix]]].
	^self cLiteralFor: anObject! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 6/24/2012 14:43'!
emitCCodeOn: aStream doAssertions: assertionFlag
	"Emit C code for all methods in the code base onto the given stream. All inlined method calls should already have been expanded."

	self emitCHeaderOn: aStream.
	self emitCTypesOn: aStream.
	self emitCConstantsOn: aStream.
	self emitCFunctionPrototypes: preparedMethodList on: aStream.
	self emitCVariablesOn: aStream.
'Writing Translated Code...'
displayProgressAt: Sensor cursorPoint
from: 0 to: methods size
during: [:bar |
	preparedMethodList doWithIndex: [ :m :i | bar value: i.
		m emitCCodeOn: aStream generator: self.
]].
	self emitExportsOn: aStream.
! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 1/28/2007 14:10'!
emitCCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag
	"Emit C code for all methods in the code base onto the given stream. All inlined method calls should already have been expanded."

	self prepareMethodsInlined: inlineFlag doAssertions: assertionFlag.
	^ self emitCCodeOn: aStream doAssertions: assertionFlag
! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'jmv 10/26/2009 08:54'!
emitCConstantsOn: aStream
	"Store the global variable declarations on the given stream."
	| unused constList node |
	unused := constants keys asSet.
	methods do: [ :meth |
		meth parseTree nodesDo: [ :n |
			n isConstant ifTrue: [ unused remove: n name ifAbsent: []]]].
	constList := constants keys reject: [ :any | unused includes: any].
	aStream nextPutAll: '/*** Constants ***/';
		 cr.
	constList asSortedCollection do: [ :varName |
		node := constants at: varName.
		node name isEmpty ifFalse: [
			aStream nextPutAll: '#define '.
			aStream nextPutAll: node name.
			aStream space.
			aStream nextPutAll: (self cLiteralFor: node value).
			aStream cr
		].
	].
	aStream cr.! !

!CCodeGenerator methodsFor: 'C code generator' stamp: ' 2/7/08 14:57'!
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

!CCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 3/7/2003 19:55'!
emitCFunctionPrototypes: methodList on: aStream 
	"Store prototype declarations for all non-inlined methods on the given stream."
	| exporting |
	aStream nextPutAll: '/*** Function Prototypes ***/'; cr.
	exporting := false.
	methodList do: [:m | 
		m export
			ifTrue: [exporting
					ifFalse: 
						[aStream nextPutAll: '#pragma export on'; cr.
						exporting := true]]
			ifFalse: [exporting
					ifTrue: 
						[aStream nextPutAll: '#pragma export off'; cr.
						exporting := false]].
		m emitCFunctionPrototype: aStream generator: self.
		aStream nextPutAll: ';'; cr].
	exporting ifTrue: [aStream nextPutAll: '#pragma export off'; cr]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 5/28/2013 20:04'!
emitCHeaderForPrimitivesOn: aStream
	"Write a C file header for compiled primitives onto the given stream."

	aStream
		nextPutAll: '/* Automatically generated from Squeak (';
		nextPutAll: VMMaker versionString;
		nextPutAll: ') on '.
	Time dateAndTimeNow do: [:e | aStream nextPutAll: e asString; nextPut: Character space].
	aStream
		nextPutAll: '*/';
		cr; cr.
	self fileHeaderVersionStampForSourceClass: vmClass.
	aStream cr; cr;
		nextPutAll: '#include "sq.h"'; cr; cr.

	"Additional header files"
		self emitHeaderFilesOn: aStream.

	aStream nextPutAll: '
#include "sqMemoryAccess.h"

/*** Imported Functions/Variables ***/
extern sqInt stackValue(sqInt);
extern sqInt stackIntegerValue(sqInt);
extern sqInt successFlag;

/* allows accessing Strings in both C and Smalltalk */
#define asciiValue(c) c
'.
	aStream cr.! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 5/28/2013 20:03'!
emitCHeaderOn: aStream
	"Write a C file header onto the given stream."

	aStream nextPutAll: '/* '.
	aStream nextPutAll: VMMaker headerNotice.
	aStream nextPutAll: ' */'; cr;
		nextPutAll: (self fileHeaderVersionStampForSourceClass: vmClass);
		cr; cr.
	self emitGlobalStructFlagOn: aStream.
	aStream nextPutAll: '#include "sq.h"'; cr.

	"Additional header files"
	self emitHeaderFilesOn: aStream.

	"Default definitions for optional functions, provided for backward compatibility"
	self emitDefaultMacrosOn: aStream.

	aStream nextPutAll: '
#include "sqMemoryAccess.h"

sqInt printCallStack(void);
void defaultErrorProc(char *s) {
	/* Print an error message and exit. */
	static sqInt printingStack = false;

	printf("\n%s\n\n", s);
	if (!!printingStack) {
		/* flag prevents recursive error when trying to print a broken stack */
		printingStack = true;
		printCallStack();
	}
	exit(-1);
}
'.
	aStream cr.! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 11/9/2006 06:42'!
emitCTestBlock: aBlockNode on: aStream
	"Emit C code for the given block node to be used as a loop test."

	aBlockNode statements size > 1 ifTrue: [
		aBlockNode emitCCodeOn: aStream level: 0 generator: self.
	] ifFalse: [
		aBlockNode statements first asExpression emitCCodeOn: aStream level: 0 generator: self.
	].! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 2/11/2009 22:54'!
emitCTypesOn: aStream 
	"Store local type declarations on the given stream."
	vmClass ifNotNil:
		[vmClass ancilliaryStructClasses do:
			[:structClass|
			(vmClass shouldGenerateTypedefFor: structClass) ifTrue:
				[structClass printTypedefOn: aStream.
				 aStream cr; cr]]]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 4/12/2006 11:40'!
emitCVariablesOn: aStream 
	"Store the global variable declarations on the given stream."
	| varString |
	aStream nextPutAll: '/*** Variables ***/';
		 cr.
	variables asSortedCollection
		do: [:var | 
			varString := var asString.
			self isGeneratingPluginCode
				ifTrue: [varString = 'interpreterProxy'
						ifTrue: ["quite special..."
							aStream cr; nextPutAll: '#ifdef SQUEAK_BUILTIN_PLUGIN'.
							aStream cr; nextPutAll: 'extern'.
							aStream cr; nextPutAll: '#endif'; cr]
						ifFalse: [aStream nextPutAll: 'static ']].
			(variableDeclarations includesKey: varString)
				ifTrue: [aStream nextPutAll: (variableDeclarations at: varString) , ';'; cr]
				ifFalse: ["default variable declaration"
					aStream nextPutAll: 'sqInt ' , varString , ';'; cr]].
	aStream cr! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 7/4/2012 18:39'!
emitDefaultMacrosOn: aStream
	"Emit macros to provide default implementations of certain functions used by
	the interpreter. If not previously defined in config.h they will be defined here.
	The definitions will be available to any module that includes sqMemoryAccess.h.
	The default macros are chosen for backward compatibility with existing platform
	support code."

	"Reduce the obscurity of these macros by flagging some selectors to
	make this method show up as a sender."

	self flag: #assert:.
	"If assert() has not been defined e.g. by sqAssert.h, then use the standard clib version"
	aStream cr;
		nextPutAll: '#ifndef assert'; cr;
		nextPutAll: ' #include <assert.h>'; cr;
		nextPutAll: '#endif'; cr.

	self flag: #allocateMemory:minimum:imageFile:headerSize:.
	aStream cr;
		nextPutAll: '#ifndef allocateMemoryMinimumImageFileHeaderSize'; cr;
		nextPutAll: ' /* Called by Interpreter>>allocateMemory:minimum:imageFile:headerSize: */'; cr;
		nextPutAll: ' /* Default definition if not previously defined in config.h */'; cr;
		nextPutAll: ' #define allocateMemoryMinimumImageFileHeaderSize(',
						'heapSize, minimumMemory, fileStream, headerSize) \'; cr;
		nextPutAll: '    sqAllocateMemory(minimumMemory, heapSize)'; cr;
		nextPutAll: '#endif'; cr.

	self flag: #sqImage:read:size:length:.
	aStream cr;
		nextPutAll: '#ifndef sqImageFileReadEntireImage'; cr;
		nextPutAll: ' /* Called by Interpreter>>sqImage:read:size:length: */'; cr;
		nextPutAll: ' /* Default definition if not previously defined in config.h */'; cr;
		nextPutAll: ' #define sqImageFileReadEntireImage(memoryAddress, ',
						'elementSize,  length, fileStream) \'; cr;
		nextPutAll: '    sqImageFileRead(memoryAddress, elementSize,  length, fileStream)'; cr;
		nextPutAll: '#endif'; cr.

	self flag: #error:.
	aStream cr;
		nextPutAll: '#ifndef error'; cr;
		nextPutAll: ' /* error() function called from Interpreter */'; cr;
		nextPutAll: ' /* Default definition if not previously defined in config.h */'; cr;
		nextPutAll: ' #define error(str) defaultErrorProc(str)'; cr;
		nextPutAll: '#endif'; cr.

	self flag: #primitiveMicrosecondClock; flag: #ioMicroSecondClock.
	aStream cr;
		nextPutAll: '#ifndef ioMicroSecondClock'; cr;
		nextPutAll: ' /* Called by Interpreter>>primitiveMicrosecondClock and GC methods */'; cr;
		nextPutAll: ' /* Default definition if not previously defined in config.h */'; cr;
		nextPutAll: ' #define ioMicroSecondClock ioMSecs'; cr;
		nextPutAll: '#endif'; cr.

	self flag: #primitiveUtcWithOffset; flag: #setMicroSeconds:andOffset:.
	aStream cr;
		nextPutAll: '#ifndef ioUtcWithOffset'; cr;
		nextPutAll: ' /* Called by Interpreter>>primitiveUtcWithOffset */'; cr;
		nextPutAll: ' /* Default definition if not previously defined in config.h */'; cr;
		nextPutAll: ' #define ioUtcWithOffset(clock, offset) setMicroSecondsandOffset(clock, offset)'; cr;
		nextPutAll: '#endif'; cr.
! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 4/23/2011 13:21'!
emitDefineBytesPerWordOn: aStream
	"Define word size dependent constants. These are mirrored by class
	variables in ObjectMemory. The macro definitions here are used at compile
	time to permit building a VM for either 32-bit or 64-bit object memory from
	a single generated code base.
	
	If SQ_VI_BYTES_PER_WORD is defined as 8 (e.g. in config.h), then a VM for
	64-bit image will be built. Otherwise, a VM for 32-bit image is built."

	aStream cr;
		nextPutAll: '/*'; cr;
		nextPutAll: ' * define SQ_VI_BYTES_PER_WORD 8 for a 64-bit word size VM'; cr;
		nextPutAll: ' * and default to SQ_VI_BYTES_PER_WORD 4 for a 32-bit word size VM'; cr;
		nextPutAll: ' */'; cr;
		nextPutAll: '#ifndef SQ_VI_BYTES_PER_WORD'; cr;
		nextPutAll: '# define SQ_VI_BYTES_PER_WORD ';
		print: 4; cr; "default to word size 4"
		nextPutAll: '#endif'; cr; cr;
		nextPutAll: '#define BYTES_PER_WORD SQ_VI_BYTES_PER_WORD'; cr;
		nextPutAll: '#define BASE_HEADER_SIZE SQ_VI_BYTES_PER_WORD'; cr;

		"Define various constants that depend on BytesPerWord"
		nextPutAll: '#if (BYTES_PER_WORD == 4) // 32-bit object memory'; cr;
		nextPutAll: '# define WORD_MASK 0xffffffff'; cr; "(1 bitShift: BytesPerWord*8) - 1"
		nextPutAll: '# define SHIFT_FOR_WORD 2'; cr; "(BytesPerWord log: 2) rounded"
		nextPutAll: '# define SMALL_CONTEXT_SIZE 92'; cr; "ContextFixedSizePlusHeader + 16 * BytesPerWord"
		"Large contexts have 56 indexable fileds.  Max with single header word."
		"However note that in 64 bits, for now, large contexts have 3-word headers"
		nextPutAll: '# define LARGE_CONTEXT_SIZE 252'; cr; "ContextFixedSizePlusHeader + 56 * BytesPerWord."
		nextPutAll: '# define SIZE_MASK 0xfc'; cr; "Base header word bit field"
		nextPutAll: '# define LONG_SIZE_MASK 0xfffffffc'; cr; "Base header word bit field"
		nextPutAll: '# define SIZE_4_BIT 0'; cr;
		nextPutAll: '# define MARK_BIT 0x80000000'; cr; "Top bit, 1 bitShift: BytesPerWord*8 - 1"
		nextPutAll: '# define ROOT_BIT 0x40000000'; cr; "Next-to-top bit, 1 bitShift: BytesPerWord*8 - 2"
		nextPutAll: '# define ALL_BUT_MARK_BIT 0x7fffffff'; cr; "WordMask - MarkBit."
		nextPutAll: '# define ALL_BUT_ROOT_BIT 0xbfffffff'; cr; "WordMask - RootBit"
		nextPutAll: '# define ALL_BUT_TYPE_MASK 0xfffffffc'; cr; "WordMask - TypeMask"
		nextPutAll: '# define ALL_BUT_MARK_BIT_AND_TYPE_MASK 0x7ffffffc'; cr; "AllButTypeMask - MarkBit"
		nextPutAll: '# define ALL_BUT_HASH_BITS 0xe001ffff'; cr;
		nextPutAll: '# define SMALL_CONTEXT_SIZE 92'; cr; "16 indexable fields"
		nextPutAll: '# define LARGE_CONTEXT_SIZE 252'; cr; "56 indexable fields"

		nextPutAll: '#else // 64-bit object memory'; cr;
		nextPutAll: '# define WORD_MASK 0xffffffffffffffff'; cr;
		nextPutAll: '# define SHIFT_FOR_WORD 3'; cr;
		nextPutAll: '# define SMALL_CONTEXT_SIZE 184'; cr;
		nextPutAll: '# define LARGE_CONTEXT_SIZE 504'; cr;
		nextPutAll: '# define SIZE_MASK 0xf8'; cr; "Lose the 4 bit in temp 64-bit chunk format"
		nextPutAll: '# define LONG_SIZE_MASK 0xfffffffffffffff8'; cr;
		"The 4 bit is excluded from SIZE_MASK for 64-bit object memory, but need it"
		"for ST size, so define SIZE_4_BIT."
		nextPutAll: '# define SIZE_4_BIT 4'; cr;
		nextPutAll: '# define MARK_BIT 0x8000000000000000'; cr;
		nextPutAll: '# define ROOT_BIT 0x4000000000000000'; cr;
		nextPutAll: '# define ALL_BUT_MARK_BIT 0x7fffffffffffffff'; cr;
		nextPutAll: '# define ALL_BUT_ROOT_BIT 0xbfffffffffffffff'; cr;
		nextPutAll: '# define ALL_BUT_TYPE_MASK 0xfffffffffffffffc'; cr;
		nextPutAll: '# define ALL_BUT_MARK_BIT_AND_TYPE_MASK 0x7ffffffffffffffc'; cr;
		nextPutAll: '# define ALL_BUT_HASH_BITS 0xffffffffe001ffff'; cr;
		nextPutAll: '# define SMALL_CONTEXT_SIZE 184'; cr;
		nextPutAll: '# define LARGE_CONTEXT_SIZE 504'; cr;
		nextPutAll: '#endif //  (BYTES_PER_WORD == 4)'; cr
	
! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 4/6/2010 00:15'!
emitDefineMemoryAccessInImageOn: aStream
	"If MemoryAccess is present in the image, then define MEMORY_ACCESS_IN_IMAGE as
	a C preprocessor macro. When MEMORY_ACCESS_IN_IMAGE is defined, the traditional
	C preprocessor macros for low level memory access are ignored and will be replaced
	by directly translated (and inlined) SLANG versions of the same. This enables visibility
	of the memory access functions for debuggers and profilers."

	(Smalltalk classNamed: #MemoryAccess)
		ifNotNilDo: [:ma | ma isEnabled
			ifTrue: [aStream nextPutAll: '#define MEMORY_ACCESS_IN_IMAGE 1'; cr]]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 1/10/2003 16:17'!
emitExportsOn: aStream
	"Store all the exported primitives in a form to be used by the internal named prim system"
	aStream nextPutAll:'

void* vm_exports[][3] = {'.
	self exportedPrimitiveNames do:[:primName|
		aStream cr;
			nextPutAll:'	{"", "'; 
			nextPutAll: primName; 
			nextPutAll:'", (void*)'; 
			nextPutAll: primName;
			nextPutAll:'},'.
	].
	aStream nextPutAll:'
	{NULL, NULL, NULL}
};
'.! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'ikp 9/10/2003 05:53'!
emitGlobalStructFlagOn: aStream
	"Default: do nothing.  Overridden in CCGenGlobalStruct."
! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 5/28/2013 20:02'!
emitHeaderFilesOn: aStream
	"Write a header files onto the given stream. A special hack allows use of 
	#ifdef THING
	#include <blah.h>
	#endif
	constructs"

	"Additional header files"
	headerFiles do:[:hdr|
		hdr first ~= $# ifTrue:
			[aStream nextPutAll: '#include '].
		aStream nextPutAll: hdr; cr].
! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 4/6/2010 00:16'!
emitVmmVersionOn: aStream
	"Emit a version string macro suitable for identifying source code version
	of this interpreter. This is expected to be used in conjunction with a similar
	identifier for platform source code version, such the the VM can identify
	the source code version for its platform source and matching VMMaker source."

	aStream nextPutAll: '#define VMMAKER_VERSION "';
		nextPutAll: VMMaker versionString;
		nextPut: $";
		cr
! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 1/3/2013 13:47'!
fileHeaderVersionStampForSourceClass: sourceClass
	"Answer a suitable version stamp to include in the header."
	| exportBuildInfo slangDescription sourceDescription |
	[exportBuildInfo := sourceClass isInterpreterClass
						ifTrue: ['char *__interpBuildInfo = __buildInfo;']
						ifFalse:
							[sourceClass isCogitClass
								ifTrue: ['char *__cogitBuildInfo = __buildInfo;']
								ifFalse:
									[sourceClass isPluginClass ifTrue:
										[sourceClass exportBuildInfoOrNil]]]]
		on: MessageNotUnderstood
		do: [:ex| ex resume: false].
	[slangDescription := self class monticelloDescriptionFor: self class.
	 sourceClass ifNotNil:
		[sourceDescription := [sourceClass monticelloDescription]
								on: MessageNotUnderstood
								do: [:ex| self class monticelloDescriptionFor: sourceClass]]]
		on: Error
		do: [:ex| | now |
			now := Time dateAndTimeNow printString.
			^String streamContents:
				[:s|
				s nextPutAll: '/* Automatically generated from Squeak on '.
				s nextPutAll: now.
				s nextPutAll: ' */'; cr; cr.
				s nextPutAll: 'static char __buildInfo[] = "Generated on '.
				s nextPutAll: now.
				s nextPutAll: '. Compiled on "'.
				s nextPutAll: '__DATE__ ;'; cr.
				exportBuildInfo ifNotNil:
					[s nextPutAll: exportBuildInfo; cr].
				s cr]].
	^String streamContents:
		[:s|
		s nextPutAll: '/* Automatically generated by\	' withCRs.
		s nextPutAll: slangDescription.
		sourceDescription ifNotNil:
			[s nextPutAll: '\   from\	' withCRs; nextPutAll: (sourceDescription copyReplaceAll: '\' withCRs with: '\	' withCRs)].
		s cr; nextPutAll: ' */'; cr.
		sourceDescription ifNotNil:
			[s nextPutAll: 'static char __buildInfo[] = "'.
			 s nextPutAll: (sourceDescription copyReplaceAll: '\' withCRs with: '\n\', '\' withCRs).
			 s nextPutAll: ' " __DATE__ ;'; cr.
			exportBuildInfo ifNotNil:
				[s nextPutAll: exportBuildInfo; cr].
			s cr]]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'ar 7/8/2003 11:04'!
isCLiteral: anObject
	(anObject isKindOf: Integer) ifTrue: [^true].
	(anObject isKindOf: String) ifTrue: [^true].
	(anObject isKindOf: Float) ifTrue: [^true].
	anObject == nil ifTrue: [^true].
	anObject == true ifTrue: [^true].			"ikp"
	anObject == false ifTrue: [^true].			"ikp"
	(anObject isKindOf: Character) ifTrue:[^true]. "ar"
	^false! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 2/9/2009 20:41'!
isNonArgumentImplicitReceiverVariableName: aString
	^(self typeOfVariable: aString) == #implicit
	    or: [vmClass
			ifNil: [#('interpreterProxy' 'self') includes: aString]
	 		ifNotNil: [vmClass isNonArgumentImplicitReceiverVariableName: aString]]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 12/15/2008 18:38'!
isPointerToStructVariableName: varName "<String>"
	^self isTypePointerToStruct: (self typeOfVariable: varName)! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem (auto rename) 12/15/2008 18:38'!
isTypePointerToStruct: type "<String>"
	^vmClass notNil
	  and: [vmClass isTypePointerToStruct: type]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 3/19/2009 10:53'!
needToGenerateHeader: headerName file: interpHdrPath contents: newContentsArg
	"Check if we need to regenerate a header file.  We always need to if the contents have changed.
	 But if not we can avoid needless recompilations by not regenerating.  So only regenerate if the
	 package is clean (version doesn't include a '*').  If we can't find a package version ask the user."
	| newContents oldContents |
	(FileDirectory default fileExists: interpHdrPath) ifFalse:
		[^true].
	newContents := newContentsArg.
	oldContents := (FileDirectory default oldFileNamed: interpHdrPath) contentsOfEntireFile.
	(newContents beginsWith: '/*') = (oldContents beginsWith: '/*') ifFalse:
		[(newContents beginsWith: '/*') ifTrue:
			[newContents := newContents readStream upToAll: '*/'; skipSeparators; upToEnd].
		 (oldContents beginsWith: '/*') ifTrue:
			[oldContents := oldContents readStream upToAll: '*/'; skipSeparators; upToEnd]].
	oldContents := oldContents copyReplaceAll: {Character cr. Character lf} with: {Character cr}.
	oldContents replaceAll: Character lf with: Character cr.
	^oldContents ~= newContents
	 or: [[((self monticelloDescriptionFor: vmClass) includes: $*) not]
			on: Error
			do: [:ex|
				self confirm: headerName, ' contents are unchanged.\Writing the file may cause recompilation of support files.\Do you want to write the header file?\The interpreter will still be written either way.' withCRs]]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'dtl 5/28/2012 08:29'!
prepareMethodsInlined: inlineFlag doAssertions: assertionFlag
	"Prepare to emit C code for all methods in the code base. All inlined method calls should be expanded. Answer a list of methods to be emitted as C code."

	| verbose methodList |
	"method preparation"
	verbose := false.
	self prepareMethods.
	verbose ifTrue: [
		self printUnboundCallWarnings.
		self printUnboundVariableReferenceWarnings.
		Transcript cr.
	].
	self checkAbstractMethods.
	assertionFlag ifFalse: [ self removeAssertions ].
	self doInlining: inlineFlag.

	"code generation"

	methodList := methods asSortedCollection: [ :m1 :m2 | m1 selector < m2 selector ].
	"clean out no longer valid variable names and then handle any global
		variable usage in each method"
	methodList do: [:m | self checkForGlobalUsage: m removeUnusedTemps in: m].
	self localizeGlobalVariables.
	^ preparedMethodList := methodList
! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 7/2/2008 14:21'!
pushScope: variableToType "<Dictionary>" while: aBlock
	scopeStack addLast: variableToType.
	^aBlock ensure: [scopeStack removeLast]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem (auto rename) 12/16/2008 08:46'!
selectorReturnsPointerToStruct: selector "<Symbol>"
	| tMethod |
	^vmClass notNil
	  and: [(tMethod := methods at: selector ifAbsent: []) notNil
	  and: [vmClass isTypePointerToStruct: tMethod returnType]]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 10/14/2013 11:56'!
selectorReturnsStruct: selector "<Symbol>"
	| tMethod |
	^(tMethod := methods
					at: selector
					ifAbsent:
						[apiMethods ifNotNil:
							[apiMethods at: selector ifAbsent: []]]) notNil
	  and: [VMStructType isTypeStruct: tMethod returnType]! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 2/10/2009 15:05'!
shortMonticelloDescriptionForClass: aClass
	"Answer a suitable Monticello package stamp to include in a moduleName."
	| mdesc |
	mdesc := [self monticelloDescriptionFor: aClass]
				on: Error
				do: [:ex| ^' ', Date today asString].
	^mdesc copyFrom: 1 to: (mdesc indexOfSubCollection: ' uuid:') - 1! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 12/11/2010 12:33'!
structTargetKindForVariableName: varName "<String>"
	^VMStructType structTargetKindForDeclaration: (self typeOfVariable: varName)! !

!CCodeGenerator methodsFor: 'C code generator' stamp: 'eem 2/9/2009 20:39'!
typeOfVariable: varName "<String>" 
	scopeStack reverseDo:
		[:dict|
		(dict includesKey: varName) ifTrue:
			[^dict at: varName]].
	^variableDeclarations at: varName ifAbsent: nil! !

!CCodeGenerator methodsFor: 'error notification' stamp: 'dtl 6/17/2012 23:05'!
checkAbstractMethods
	"For each method that has been declared abstract, ensure that a concrete
	implementation has been provided. This check should be performed prior to
	inlining because methods may be removed during the inlining process."

	| selectors |
	selectors := methods keys, self uncheckedAbstractMethods.
	abstractDeclarations do: [:sel |
		(selectors includes: sel)
			ifFalse: [self notify: 'missing implementation for ', sel]]
! !

!CCodeGenerator methodsFor: 'error notification' stamp: 'dtl 4/11/2012 20:36'!
checkClassForNameConflicts: aClass
	"Verify that the given class does not have constant, variable, or method names that conflict with
	 those of previously added classes. Raise an error if a conflict is found, otherwise just return."

	"check for constant name collisions in class pools"
	aClass classPool associationsDo:
		[:assoc |
		(constants includesKey: assoc key asString) ifTrue:
			[self error: 'Constant ', assoc key, ' was defined in a previously added class']].

	"and in shared pools"
	(aClass sharedPools reject: [:pool| pools includes: pool]) do:
		[:pool |
		pool bindingsDo:
			[:assoc |
			(constants includesKey: assoc key asString) ifTrue:
				[self error: 'Constant ', assoc key, ' was defined in a previously added class']]].

	"check for instance variable name collisions"
	(aClass inheritsFrom: VMStructType) ifFalse:
		[aClass instVarNames do:
			[:varName |
			(variables includes: varName) ifTrue:
				[self error: 'Instance variable ', varName, ' was defined in a previously added class']]].

	"check for method name collisions"
	aClass selectors do:
		[:sel |
		((methods includesKey: sel) and:
			[ | meth |
			meth := aClass compiledMethodAt: sel.
			meth isAbstract not and: [(meth pragmaAt: #doNotGenerate) isNil]]) ifTrue:
				[self error: 'Method ', sel, ' was defined in a previously added class.']]! !

!CCodeGenerator methodsFor: 'error notification'!
printUnboundCallWarnings
	"Print a warning message for every unbound method call in the code base."

	| knownSelectors undefinedCalls |
	undefinedCalls := Dictionary new.
	knownSelectors := translationDict keys asSet.
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

	Transcript cr.
	undefinedCalls keys asSortedCollection do: [ :undefined |
		Transcript show: undefined, ' -- undefined method sent by:'; cr.
		(undefinedCalls at: undefined) do: [ :caller |
			Transcript tab; show: caller; cr.
		].
	].! !

!CCodeGenerator methodsFor: 'error notification'!
printUnboundVariableReferenceWarnings
	"Print a warning message for every unbound variable reference in the code base."

	| undefinedRefs globalVars knownVars |
	undefinedRefs := Dictionary new.
	globalVars := Set new: 100.
	globalVars addAll: variables.
	methods do: [ :m |
		knownVars := globalVars copy.
		m args do: [ :var | knownVars add: var ].
		m locals do: [ :var | knownVars add: var ].
		m freeVariableReferences do: [ :varName |
			(knownVars includes: varName) ifFalse: [
				(undefinedRefs includesKey: varName)
					ifTrue: [ (undefinedRefs at: varName) add: m selector ]
					ifFalse: [ undefinedRefs at: varName put: (OrderedCollection with: m selector) ].
			].
		].
	].

	Transcript cr.
	undefinedRefs keys asSortedCollection do: [ :var |
		Transcript show: var, ' -- undefined variable used in:'; cr.
		(undefinedRefs at: var) do: [ :sel |
			Transcript tab; show: sel; cr.
		].
	].! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'asf 9/30/2014 20:18'!
collectInlineList
	"Make a list of methods that should be inlined."
	"Details: The method must not include any inline C, since the translator cannot
	currently map variable names in inlined C code. The #inline: directive may be
	used to override this for cases in which the C code or declarations are harmless.
	Methods to be inlined must be small or called from only one place."

	| methodsNotToInline callsOf inlineIt hasCCode nodeCount senderCount
sel returnTypesOf |
	methodsNotToInline := Set new: methods size.

	"build dictionary to record the number of calls to each method"
	callsOf := Dictionary new: methods size * 2.
	returnTypesOf := Dictionary new: methods size.
	methods keys do: [ :s | callsOf at: s put: 0 ].
	methods do: [ :m | returnTypesOf at: m selector put: m returnType ].

	"For each method, scan its parse tree once to:
		1. determine if the method contains C code or declarations
		2. determine how many nodes it has
		3. increment the sender counts of the methods it calls
		4. determine if it includes any C declarations or code"
	inlineList := Set new: methods size * 2.
	inlineReturnTypes := Dictionary new: methods size.
	methods do: [ :m |
		inlineIt := #dontCare.
		(translationDict includesKey: m selector) ifTrue: [
			hasCCode := true.
		] ifFalse: [
			hasCCode := m declarations size > 0.
			nodeCount := 0.
			m parseTree nodesDo: [ :node |
				node isSend ifTrue: [
					sel := node selector.
					(sel = #cCode: or: [sel = #cCode:inSmalltalk:])
						ifTrue: [ hasCCode := true ].
					senderCount := callsOf at: sel ifAbsent: [ nil ].
					nil = senderCount ifFalse: [
						callsOf at: sel put: senderCount + 1.
					].
				].
				nodeCount := nodeCount + 1.
			].
			inlineIt := m extractInlineDirective.  "may be true, false, or
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

!CCodeGenerator methodsFor: 'inlining' stamp: 'dtl 6/23/2012 13:52'!
doBasicInlining: inlineFlag
	"Inline the bodies of all methods that are suitable for inlining.
	This method does only the basic inlining suitable for both the core VM and plugins - no bytecode inlining etc"

	| pass progress max |
	inlineFlag ifFalse: [^self].
	self collectInlineList.
	pass := 0.
	max := 12. "More than this is probably due to infinite recursion" 
	progress := true.
	[progress] whileTrue: [
		"repeatedly attempt to inline methods until no further progress is made"
		progress := false.
		pass > max
			ifTrue: [self notify: 'too many inlining steps, inlining terminated']
			ifFalse: [('Inlining pass ', (pass := pass + 1) printString, '...')
						displayProgressAt: Sensor cursorPoint
						from: 0 to: methods size
						during: [:bar |
							(self sortMethods: methods) doWithIndex: [:m :i |
								bar value: i.
								currentMethod := m.
								(m tryToInlineMethodsIn: self)
									ifTrue: [progress := true]]]]].

! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'dtl 8/21/2011 21:12'!
doInlining: inlineFlag
	"Inline the bodies of all methods that are suitable for inlining."
	"Modified slightly for the core VM translator, since the first level of inlining for the interpret loop must be performed in order that the instruction implementations can easily discover their addresses. Remember to inline the bytecode routines as well"

	inlineFlag ifFalse: [
		self inlineDispatchesInMethodNamed: #interpret localizingVars: #().
		^ self].
	self doBasicInlining: inlineFlag.
	self inlineCaseStatementBranchesInMethodNamed: #interpret localizingVars: #().
	'Inlining bytecodes'
		displayProgressAt: Sensor cursorPoint
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

!CCodeGenerator methodsFor: 'inlining' stamp: 'dtl 6/21/2008 12:54'!
inlineCaseStatementBranchesInMethodNamed: selector localizingVars: varsList 
	"Inline case statement branches in the method with the given name."
	(self methodNamed: selector)
		ifNotNilDo: [:m | m inlineCaseStatementBranchesIn: self localizingVars: varsList]! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'ar 7/8/2003 11:27'!
inlineDispatchesInMethodNamed: selector localizingVars: varsList
	"Inline dispatches (case statements) in the method with the given name."

	| m varString |
	m := self methodNamed: selector.
	m = nil ifFalse: [
		m inlineCaseStatementBranchesIn: self localizingVars: varsList.
		m parseTree nodesDo: [ :n |
			n isCaseStmt ifTrue: [
				n customizeShortCasesForDispatchVar: 'currentBytecode' in: self method: m.
			].
		].
	].
	variables := variables asOrderedCollection.
	varsList do: [ :v |
		varString := v asString.
		variables remove: varString ifAbsent: [].
		(variableDeclarations includesKey: varString) ifTrue: [
			m declarations at: v asString put: (variableDeclarations at: varString).
			variableDeclarations removeKey: varString.
		].
	].
! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'asf 9/30/2014 20:18'!
inlineReturnType: selector
	"gets the return type of a given inline selector"

	^inlineReturnTypes at: selector ifAbsent: nil! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'eem 7/30/2013 16:26'!
isAssertSelector: selector
	^#(assert: asserta: assert:l: asserta:l:) includes: selector! !

!CCodeGenerator methodsFor: 'inlining'!
mayInline: sel
	"Answer true if the method with the given selector may be inlined."

	^ inlineList includes: sel! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'ls 10/10/1999 13:55'!
methodStatsString
	"Return a string describing the size, # of locals, and # of senders of
each method. Note methods that have inline C code or C declarations."

	| methodsWithCCode sizesOf callsOf hasCCode nodeCount senderCount s
calls registers selr m |
	methodsWithCCode := Set new: methods size.
	sizesOf := Dictionary new: methods size * 2.  "selector -> nodeCount"
	callsOf := Dictionary new: methods size * 2.  "selector -> senderCount"

	"For each method, scan its parse tree once to:
		1. determine if the method contains C code or declarations
		2. determine how many nodes it has
		3. increment the sender counts of the methods it calls
		4. determine if it includes any C declarations or code"

	methods do: [ :m0 |  m := m0.
		(translationDict includesKey: m selector) ifTrue: [
			hasCCode := true.
		] ifFalse: [
			hasCCode := m declarations size > 0.
			nodeCount := 0.
			m parseTree nodesDo: [ :node |
				node isSend ifTrue: [
					selr := node selector.
					selr = #cCode: ifTrue: [ hasCCode := true ].
					senderCount := callsOf at: selr ifAbsent: [ 0 ].
					callsOf at: selr put: senderCount + 1.
				].
				nodeCount := nodeCount + 1.
			].
		].
		hasCCode ifTrue: [ methodsWithCCode add: m selector ].
		sizesOf at: m selector put: nodeCount.
	].

	s := WriteStream on: (String new: 5000).
	methods keys asSortedCollection do: [ :sel |
		m := methods at: sel.
		registers := m locals size + m args size.
		calls := callsOf at: sel ifAbsent: [0].
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

!CCodeGenerator methodsFor: 'inlining' stamp: 'ar 2/3/2001 17:08'!
pruneMethods: selectorList
	"Explicitly prune some methods"
	selectorList do:[:sel| methods removeKey: sel ifAbsent:[]].! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'tpr 3/2/2004 11:09'!
pruneUnreachableMethods
	"Remove any methods that are not reachable. Retain methods needed by the translated classes - see implementors of requiredMethodNames"
 	
	| newMethods |
	"add all the exported methods and all the called methods to the dNRML"
	methods do: [ :m |
		m export ifTrue:[doNotRemoveMethodList add: m selector].
		doNotRemoveMethodList addAll: m allCalls].

	"build a new dictionary of methods from the collection of all the ones to keep"			
	newMethods := Dictionary new: doNotRemoveMethodList size.
	doNotRemoveMethodList do:[:sel|
		methods at: sel ifPresent:[:meth| newMethods at: sel put: meth]].
	methods := newMethods! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	"Remove all assertions in method bodies.  This is for the benefit of inlining, which
	fails to recognise and disregard empty method bodies when checking the inlinability
	of sends."

	| newMethods |
	newMethods := Dictionary new.
	'Removing assertions...'
		displayProgressAt: Sensor cursorPoint
		from: 0 to: methods size
		during: [ :bar |
			methods doWithIndex: [ :m :i |
				bar value: i.
				m isAssertion ifFalse: [
					newMethods at: m selector put: m.
					m removeAssertions]]].
	methods := newMethods.! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'dtl 6/21/2008 09:21'!
removeMethodsReferingToGlobals: varList except: methodNames
	"Remove any methods (presumably inlined) that still contain references to the given obsolete global variables."

	| varListAsStrings mVars |
	varListAsStrings := varList collect: [ :sym | sym asString ].
		(methods keys copyWithoutAll: methodNames) do: [ :sel |
			mVars := (self methodNamed: sel) freeVariableReferences asSet.
			(mVars includesAnyOf: varListAsStrings)
				ifTrue: [methods removeKey: sel ifAbsent: []]]
! !

!CCodeGenerator methodsFor: 'inlining' stamp: 'tpr 2/27/2004 18:49'!
retainMethods: aListOfMethodsToKeep
"add aListOfMethodsToKeep to doNotRemoveMethodList so that they will not be pruned"
	doNotRemoveMethodList ifNil:[doNotRemoveMethodList := Set new:100].
	doNotRemoveMethodList addAll: aListOfMethodsToKeep.
	^aListOfMethodsToKeep! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 10/5/2009 13:48'!
generateAddressOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPut: $(; nextPut: $&.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)! !

!CCodeGenerator methodsFor: 'C translation'!
generateAnd: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' && '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'ar 10/3/1998 13:45'!
generateAsFloat: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((double) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' )'.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/15/2009 16:38'!
generateAsInteger: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((sqInt)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 1/3/2009 10:22'!
generateAsSymbol: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 The receiver is expected to be a TConstantNode."

	aStream nextPutAll: (self cFunctionNameFor: msgNode receiver nameOrValue)! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/15/2009 16:38'!
generateAsUnsignedInteger: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((usqInt)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 6/24/2010 09:33'!
generateAt: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $[.
	msgNode args first emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
	aStream nextPut: $]! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 6/24/2010 09:33'!
generateAtPut: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $[.
	msgNode args first emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
	aStream nextPutAll: '] = '.
	self emitCExpression: msgNode args last on: aStream! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 5/18/2010 21:38'!
generateBaseHeaderSize: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: 'BASE_HEADER_SIZE'

! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 7/8/2008 20:21'!
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

!CCodeGenerator methodsFor: 'C translation'!
generateBitAnd: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' & '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/22/2011 11:42'!
generateBitClear: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream next: 2 put: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' | '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') - '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 7/16/2009 13:46'!
generateBitInvert32: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPut: $~.
	self emitCExpression: msgNode receiver on: aStream! !

!CCodeGenerator methodsFor: 'C translation'!
generateBitOr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' | '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'ikp 8/4/2004 16:29'!
generateBitShift: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| arg rcvr |
	arg := msgNode args first.
	rcvr := msgNode receiver.
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

!CCodeGenerator methodsFor: 'C translation'!
generateBitXor: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' ^ '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 5/18/2010 21:33'!
generateBytesPerWord: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: 'BYTES_PER_WORD'
! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/11/2009 13:53'!
generateCCoercion: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	aStream nextPutAll: msgNode args last value.
	aStream nextPutAll: ') '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)

! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'ikp 6/9/2004 16:14'!
generateDivide: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| rcvr arg divisor |
	rcvr := msgNode receiver.
	arg := msgNode args first.
	(arg isConstant and:
	 [UseRightShiftForDivide and:
	 [(divisor := arg value) isInteger and:
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

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 06:24'!
generateDoWhileFalse: msgNode on: aStream indent: level
	"Generate do {stmtList} while(!!(cond))"

	| stmts testStmt |
	stmts := msgNode receiver statements asOrderedCollection.
	testStmt := stmts removeLast.
	msgNode receiver setStatements: stmts.
	aStream nextPutAll: 'do {'; cr.
	msgNode receiver emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '} while(!!('.
	testStmt asExpression emitCCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: '))'.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 06:24'!
generateDoWhileTrue: msgNode on: aStream indent: level
	"Generate do {stmtList} while(cond)"

	| stmts testStmt |
	stmts := msgNode receiver statements asOrderedCollection.
	testStmt := stmts removeLast.
	msgNode receiver setStatements: stmts.
	aStream nextPutAll: 'do {'; cr.
	msgNode receiver emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '} while('.
	testStmt asExpression emitCCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: ')'.! !

!CCodeGenerator methodsFor: 'C translation'!
generateEqual: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' == '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 12/12/2012 11:15'!
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
		nextPutAll: (self cLiteralFor: msgNode args last value asString);
		nextPut: $)! !

!CCodeGenerator methodsFor: 'C translation'!
generateGreaterThan: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' > '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation'!
generateGreaterThanOrEqual: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' >= '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: ' 2/7/08 14:57'!
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

!CCodeGenerator methodsFor: 'C translation' stamp: ' 2/7/08 14:57'!
generateIfFalseAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: '(!!('.
			 msgNode receiver emitCCodeAsArgumentOn: aStream level: 0 generator: self.
			aStream nextPut: $); crtab: level + 1; nextPut: $?; space.
			msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream crtab: level + 1; nextPutAll: ': 0)']
		ifNotNil:
			[:const|
			const ifFalse:
				[msgNode args first emitCCodeAsArgumentOn: aStream level: level generator: self]]! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 10/24/2010 16:15'!
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

!CCodeGenerator methodsFor: 'C translation' stamp: ' 2/7/08 14:57'!
generateIfFalseIfTrueAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			msgNode receiver emitCCodeAsArgumentOn: aStream level: level generator: self.
			aStream crtab: level + 1; nextPut: $?; space.
			msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream crtab: level + 1; nextPut: $:; space.
			msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream nextPut: $)]
		ifNotNil:
			[:const|
			(const
				ifTrue: [msgNode args last]
				ifFalse: [msgNode args first])
					emitCCodeAsArgumentOn: aStream level: level generator: self]! !

!CCodeGenerator methodsFor: 'C translation' stamp: ' 2/7/08 14:57'!
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

!CCodeGenerator methodsFor: 'C translation' stamp: ' 2/7/08 14:57'!
generateIfTrueAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			 msgNode receiver emitCCodeAsArgumentOn: aStream level: level generator: self.
			 aStream crtab: level + 1; nextPut: $?; space.
			 msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			 aStream crtab: level + 1; nextPutAll: ': 0)']
		ifNotNil:
			[:const|
			const ifTrue:
				[msgNode args first emitCCodeAsArgumentOn: aStream level: level generator: self]]! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 10/24/2010 16:14'!
generateIfTrueIfFalse: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if ('.
			msgNode receiver emitCCodeAsExpressionOn: aStream level: level generator: self.
			aStream nextPutAll: ') {'; cr.
			msgNode args first emitCCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}; nextPutAll: ' else {'; cr.
			msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}]
		ifNotNil:
			[:const |
			(const ifTrue: [msgNode args first] ifFalse: [msgNode args last])
				emitCCodeOn: aStream level: level generator: self]! !

!CCodeGenerator methodsFor: 'C translation' stamp: ' 2/7/08 14:57'!
generateIfTrueIfFalseAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			msgNode receiver emitCCodeAsArgumentOn: aStream level: level generator: self.
			aStream crtab: level + 1; nextPut: $?; space.
			msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream crtab: level + 1; nextPut: $:; space.
			msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream nextPut: $)]
		ifNotNil:
			[:const|
			(const ifTrue: [msgNode args first] ifFalse: [msgNode args last])
				emitCCodeAsArgumentOn: aStream level: level generator: self]! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 9/16/2009 18:06'!
generateInlineCCode: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 There are two forms, self cCode: aString ... and self cCode: aBlock."

	msgNode args first isConstant
		ifTrue: [aStream nextPutAll: msgNode args first value]
		ifFalse: [msgNode args first
					emitCCodeOn: aStream
					level: level
					generator: self]! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 12/14/2009 21:16'!
generateInlineCCodeAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 There are two forms, self cCode: aString ... and self cCode: aBlock."

	msgNode args first isConstant
		ifTrue: [aStream nextPutAll: msgNode args first value]
		ifFalse: [msgNode args first
					emitCCodeAsArgumentOn: aStream
					level: level
					generator: self]! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/24/2009 14:54'!
generateInlineCPreprocessorDirective: msgNode on: aStream indent: level
	"Generate the C preprocessor directive for this message onto the given stream."

	aStream cr; nextPutAll: msgNode args first value! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 19:47'!
generateInlineCppDirective: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream cr; nextPutAll: '# ', msgNode args first value.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/12/2006 17:30'!
generateInlineCppIfDef: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| comment |
	aStream cr; nextPutAll: '# ifdef ', msgNode args first value.
	comment := msgNode args third value.
	(comment isKindOf: String)
		ifTrue: [aStream nextPutAll: '  // ', comment]
		ifFalse: ["nil argument, ignore it"].
	aStream cr.
	msgNode isExpression
		ifTrue:
			[aStream tab: level + 1; nextPut: $(.
			msgNode args fourth asExpression
				emitCCodeOn: aStream level: level + 1 generator: self.
			aStream nextPut: $); cr]
		ifFalse:
			[msgNode args fourth
				emitCCodeOn: aStream level: level generator: self].
	aStream nextPutAll: '# endif  // ', msgNode args first value; cr; tab: level! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/12/2006 17:30'!
generateInlineCppIfDefElse: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| comment alternateBlock alternateBlockIsNil |
	aStream cr; nextPutAll: '# ifdef ', msgNode args first value.
	comment := msgNode args third value.
	(comment isKindOf: String)
		ifTrue: [aStream nextPutAll: '  // ', comment]
		ifFalse: ["nil argument, ignore it"].
	aStream cr.
	msgNode isExpression
		ifTrue:
			[aStream tab: level + 1; nextPut: $(.
			msgNode args fourth asExpression
				emitCCodeOn: aStream level: level + 1 generator: self.
			aStream nextPut: $); cr]
		ifFalse:
			[msgNode args fourth
				emitCCodeOn: aStream level: level generator: self].
	alternateBlock := msgNode args fifth.
	alternateBlockIsNil := true. "check for nil #else clause"
	alternateBlock nodesDo: [:n |
		(n ~= alternateBlock and: [n name ~= 'nil'])
			ifTrue: [alternateBlockIsNil := false ]].
	(alternateBlockIsNil) ifFalse:
		[aStream nextPutAll: '# else'; cr.
		msgNode isExpression
			ifTrue:
				[aStream tab: level + 1; nextPut: $(.
				alternateBlock asExpression
					emitCCodeOn: aStream level: level + 1 generator: self.
				aStream nextPut: $); cr]
			ifFalse:
				[alternateBlock
					emitCCodeOn: aStream level: level generator: self]].
	aStream nextPutAll: '# endif  // ', msgNode args first value; cr; tab: level
! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 5/17/2010 15:18'!
generateInlineCppIfElse: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| comment alternateBlock alternateBlockIsNil |
	aStream cr; nextPutAll: '# if (', msgNode args first value, ')'.
	comment := msgNode args third value.
	(comment isKindOf: String)
		ifTrue: [aStream nextPutAll: '  // ', comment]
		ifFalse: ["nil argument, ignore it"].
	aStream cr.
	msgNode isExpression
		ifTrue:
			[aStream tab: level + 1; nextPut: $(.
			msgNode args fourth asExpression
				emitCCodeOn: aStream level: level + 1 generator: self.
			aStream nextPut: $); cr]
		ifFalse:
			[msgNode args fourth
				emitCCodeOn: aStream level: level generator: self].
	alternateBlock := msgNode args fifth.
	alternateBlockIsNil := true. "check for nil #else clause"
	alternateBlock nodesDo: [:n |
		(n ~= alternateBlock and: [n name ~= 'nil'])
			ifTrue: [alternateBlockIsNil := false ]].
	(alternateBlockIsNil) ifFalse:
		[aStream nextPutAll: '# else'; cr.
		msgNode isExpression
			ifTrue:
				[aStream tab: level + 1; nextPut: $(.
				alternateBlock asExpression
					emitCCodeOn: aStream level: level + 1 generator: self.
				aStream nextPut: $); cr]
			ifFalse:
				[alternateBlock
					emitCCodeOn: aStream level: level generator: self]].
	aStream nextPutAll: '# endif  // ', msgNode args first value; cr; tab: level
! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 9/25/2010 10:13'!
generateInlineDirective: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '/* inline: '.
	aStream nextPutAll: msgNode args first value asString.
	aStream nextPutAll: ' */'.
! !

!CCodeGenerator methodsFor: 'C translation'!
generateIntegerObjectOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' << 1) | 1)'.! !

!CCodeGenerator methodsFor: 'C translation'!
generateIntegerValueOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '('.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' >> 1)'.! !

!CCodeGenerator methodsFor: 'C translation'!
generateIsIntegerObject: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '('.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' & 1)'.! !

!CCodeGenerator methodsFor: 'C translation'!
generateIsNil: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' == '.
	aStream nextPutAll: (self cLiteralFor: nil).! !

!CCodeGenerator methodsFor: 'C translation'!
generateLessThan: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' < '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation'!
generateLessThanOrEqual: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' <= '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation'!
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

!CCodeGenerator methodsFor: 'C translation'!
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

!CCodeGenerator methodsFor: 'C translation'!
generateMinus: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' - '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation'!
generateModulo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' % '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 7/8/2008 17:47'!
generateNegated: msgNode on: aStream indent: level
	"Generate the C code for teh negated message onto the given stream."

	aStream nextPut: $-.
	self emitCExpression: msgNode receiver on: aStream! !

!CCodeGenerator methodsFor: 'C translation'!
generateNot: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '!!'.
	self emitCExpression: msgNode receiver on: aStream.! !

!CCodeGenerator methodsFor: 'C translation'!
generateNotEqual: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' !!= '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation'!
generateNotNil: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' !!= '.
	aStream nextPutAll: (self cLiteralFor: nil).! !

!CCodeGenerator methodsFor: 'C translation'!
generateOr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' || '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 1/18/2009 23:34'!
generatePerform: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $(.
	(msgNode args copyFrom: 2 to: msgNode args size) do:[:arg|
		self emitCExpression: arg on: aStream.
	] separatedBy:[aStream nextPutAll:', '].
	aStream nextPut: $)! !

!CCodeGenerator methodsFor: 'C translation'!
generatePlus: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' + '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'ATG 4/8/2004 15:03'!
generatePreDecrement: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| varNode |
	varNode := msgNode receiver.
	varNode isVariable
		ifFalse: [ self error: 'preDecrement can only be applied to variables' ].
	aStream nextPutAll: '--'.
	aStream nextPutAll: (self returnPrefixFromVariable: varNode name).
! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'ikp 9/11/2003 20:08'!
generatePreIncrement: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| varNode |
	varNode := msgNode receiver.
	varNode isVariable
		ifFalse: [ self error: 'preIncrement can only be applied to variables' ].
	aStream nextPutAll: '++'.
	aStream nextPutAll: (self returnPrefixFromVariable: varNode name).
! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'ar 2/15/1999 21:43'!
generateRaisedTo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'pow('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll:')'.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 4/11/2011 19:13'!
generateRepeat: msgNode on: aStream indent: level
	"Generate while(1) { stmtList } "

	aStream nextPutAll: 'while(1) {'; cr.
	msgNode receiver emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'
! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 10/24/2010 15:41'!
generateSequentialAnd: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' && ('.
	self emitCTestBlock: msgNode args first on: aStream.
	aStream nextPut: $)! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 10/24/2010 15:41'!
generateSequentialOr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	"Note: PP 2.3 compiler produces two arguments for or:, presumably
	 to help with inlining later. Taking the last agument should do the correct
	 thing even if your compiler is different."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' || ('.
	self emitCTestBlock: msgNode args last on: aStream.
	aStream nextPutAll: ')'! !

!CCodeGenerator methodsFor: 'C translation'!
generateSharedCodeDirective: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '/* common code: '.
	aStream nextPutAll: msgNode args first value.
	aStream nextPutAll: ' */'.
! !

!CCodeGenerator methodsFor: 'C translation'!
generateShiftLeft: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' << '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'ikp 8/4/2004 18:25'!
generateShiftRight: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((usqInt) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ')'.
	aStream nextPutAll: ' >> '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/19/2009 16:17'!
generateSignedBitShift: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| arg |
	(arg := msgNode args first) isConstant
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

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/5/2009 10:27'!
generateSignedIntFromLong: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((sqInt) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/2/2009 20:48'!
generateSignedIntFromShort: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((short)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/5/2009 10:28'!
generateSignedIntToLong: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((usqInt) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/5/2009 10:28'!
generateSignedIntToShort: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((usqInt) (short)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 2/26/2009 10:18'!
generateSmalltalkMetaError: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: 'error("'; nextPutAll: msgNode selector; nextPutAll: '")'! !

!CCodeGenerator methodsFor: 'C translation'!
generateTimes: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' * '.
	self emitCExpression: msgNode args first on: aStream.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 3/30/2013 13:55'!
generateToByDo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	"N.B. MessageNode>>asTranslatorNodeIn: adds the limit var as a hidden fourth argument."
	| blockExpr iterationVar limitExpr mayHaveSideEffects limitVar step negative |
	blockExpr := msgNode args third.
	blockExpr args size = 1 ifFalse:
		[self error: 'wrong number of block arguments'].
	iterationVar := blockExpr args first.
	limitExpr := msgNode args first.
	aStream nextPutAll: 'for (', iterationVar, ' = '.
	self emitCExpression: msgNode receiver on: aStream.
	mayHaveSideEffects := msgNode args size = 4. "See TMethod>>prepareMethodIn:"
	mayHaveSideEffects ifTrue:
		[limitVar := msgNode args last.
		 aStream nextPutAll: ', ', limitVar name, ' = '.
		 self emitCExpression: limitExpr on: aStream.
		 limitExpr := limitVar].
	aStream nextPutAll: '; ', iterationVar.
	negative := ((step := msgNode args at: 2) isConstant and: [step value < 0])
				or: [step isSend and: [step selector == #negated
					and: [step receiver isConstant and: [step receiver value >= 0]]]].
	aStream nextPutAll: (negative ifTrue: [' >= '] ifFalse: [' <= ']).
	self emitCExpression: limitExpr on: aStream.
	aStream nextPutAll: '; ', iterationVar, ' += '.
	self emitCExpression: step on: aStream.
	aStream nextPutAll: ') {'; cr.
	blockExpr emitCCodeOn: aStream level: level + 1 generator: self.
	aStream tab: level.
	aStream nextPut: $}! !

!CCodeGenerator methodsFor: 'C translation'!
generateToDo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| iterationVar |
	(msgNode args last args size = 1) ifFalse: [
		self error: 'wrong number of block arguments'.
	].
	iterationVar := msgNode args last args first.
	aStream nextPutAll: 'for (', iterationVar, ' = '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: '; ', iterationVar, ' <= '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: '; ', iterationVar, '++) {'; cr.
	msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'tpr 7/26/2003 10:23'!
generateTouch: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream - which is to say absolutely nothing"
! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 10/14/2013 08:13'!
generateValue: aTSendNode on: aStream indent: level
	"Reduce [:formal ... :formalN| body ] value: actual ... value: actualN
	 to body with formals substituted for by actuals."
	| substitution substitutionDict newLabels |
	self assert: aTSendNode receiver isStmtList.
	self assert: aTSendNode receiver args size = aTSendNode args size.
	substitution := aTSendNode receiver copy.
	substitution renameLabelsForInliningInto: currentMethod.
	substitutionDict := Dictionary new: aTSendNode args size * 2.
	aTSendNode receiver args with: aTSendNode args do:
		[ :argName :exprNode |
		substitutionDict at: argName put: exprNode].
	substitution
		bindVariablesIn: substitutionDict;
		emitCCodeOn: aStream level: level generator: self.
	newLabels := Set withAll: currentMethod labels.
	substitution nodesDo:
		[:node| node isLabel ifTrue: [node label ifNotNil: [:label| newLabels add: label]]].
	"now add the new labels so that a subsequent inline of
	 the same block will be renamed with different labels."
	currentMethod labels: newLabels! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'eem 10/22/2013 16:01'!
generateValueAsArgument: aTSendNode on: aStream indent: level
	"Reduce [:formal ... :formalN| body ] value: actual ... value: actualN
	 to body with formals substituted for by actuals."
	| substitution substitutionDict newLabels |
	self assert: aTSendNode receiver isStmtList.
	self assert: aTSendNode receiver args size = aTSendNode args size.
	substitution := aTSendNode receiver copy.
	substitution renameLabelsForInliningInto: currentMethod.
	substitutionDict := Dictionary new: aTSendNode args size * 2.
	aTSendNode receiver args with: aTSendNode args do:
		[ :argName :exprNode |
		substitutionDict at: argName put: exprNode].
	substitution
		bindVariablesIn: substitutionDict;
		emitCCodeAsArgumentOn: aStream level: level generator: self.
	newLabels := Set withAll: currentMethod labels.
	substitution nodesDo:
		[:node| node isLabel ifTrue: [node label ifNotNil: [:label| newLabels add: label]]].
	"now add the new labels so that a subsequent inline of
	 the same block will be renamed with different labels."
	currentMethod labels: newLabels! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'acg 12/22/1999 01:41'!
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

!CCodeGenerator methodsFor: 'C translation' stamp: 'acg 12/22/1999 01:41'!
generateWhileFalseLoop: msgNode on: aStream indent: level
	"Generate while(!!(cond)) {stmtList}."

	aStream nextPutAll: 'while (!!('.
	self emitCTestBlock: msgNode receiver on: aStream.
	aStream nextPutAll: ')) {'; cr.
	msgNode args first isNilStmtListNode ifFalse:
		[msgNode args first emitCCodeOn: aStream level: level + 1 generator: self].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 06:28'!
generateWhileForeverBreakFalseLoop: msgNode on: aStream indent: level
	"Generate while(1) {stmtListA; if(!!(cond)) break; stmtListB}."

	| stmts testStmt |
	stmts := msgNode receiver statements asOrderedCollection.
	testStmt := stmts removeLast.
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

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/9/2006 06:28'!
generateWhileForeverBreakTrueLoop: msgNode on: aStream indent: level
	"Generate while(1) {stmtListA; if(cond) break; stmtListB}."

	| stmts testStmt |
	stmts := msgNode receiver statements asOrderedCollection.
	testStmt := stmts removeLast.
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

!CCodeGenerator methodsFor: 'C translation' stamp: 'acg 12/22/1999 01:41'!
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

!CCodeGenerator methodsFor: 'C translation' stamp: 'acg 12/22/1999 01:38'!
generateWhileTrueLoop: msgNode on: aStream indent: level
	"Generate while(cond) {stmtList}."

	aStream nextPutAll: 'while ('.
	self emitCTestBlock: msgNode receiver on: aStream.
	aStream nextPutAll: ') {'; cr.
	msgNode args first isNilStmtListNode ifFalse:
		[msgNode args first emitCCodeOn: aStream level: level + 1 generator: self].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!CCodeGenerator methodsFor: 'C translation' stamp: 'dtl 11/25/2014 19:15'!
initializeCTranslationDictionary 
	"Initialize the dictionary mapping message names to actions for C code generation."

	| pairs |
	translationDict := Dictionary new: 200.
	pairs := #(
	#&				#generateAnd:on:indent:
	#|				#generateOr:on:indent:
	#and:			#generateSequentialAnd:on:indent:
	#or:			#generateSequentialOr:on:indent:
	#not			#generateNot:on:indent:

	#+				#generatePlus:on:indent:
	#-				#generateMinus:on:indent:
	#negated		#generateNegated:on:indent:
	#*				#generateTimes:on:indent:
	#/				#generateDivide:on:indent:
	#//				#generateDivide:on:indent:
	#\\				#generateModulo:on:indent:
	#<<			#generateShiftLeft:on:indent:
	#>>			#generateShiftRight:on:indent:
	#min:			#generateMin:on:indent:
	#max:			#generateMax:on:indent:
	#between:and:	#generateBetweenAnd:on:indent:

	#bitAnd:		#generateBitAnd:on:indent:
	#bitOr:			#generateBitOr:on:indent:
	#bitXor:		#generateBitXor:on:indent:
	#bitShift:		#generateBitShift:on:indent:
	#signedBitShift:	#generateSignedBitShift:on:indent:
	#bitInvert32		#generateBitInvert32:on:indent:
	#bitClear:			#generateBitClear:on:indent:

	#<				#generateLessThan:on:indent:
	#<=			#generateLessThanOrEqual:on:indent:
	#=				#generateEqual:on:indent:
	#>				#generateGreaterThan:on:indent:
	#>=			#generateGreaterThanOrEqual:on:indent:
	#~=			#generateNotEqual:on:indent:
	#==			#generateEqual:on:indent:
	#~~			#generateNotEqual:on:indent:
	#isNil			#generateIsNil:on:indent:
	#notNil			#generateNotNil:on:indent:

	#whileTrue: 	#generateWhileTrue:on:indent:
	#whileFalse:	#generateWhileFalse:on:indent:
	#whileTrue 		#generateDoWhileTrue:on:indent:
	#whileFalse		#generateDoWhileFalse:on:indent:
	#to:do:			#generateToDo:on:indent:
	#to:by:do:		#generateToByDo:on:indent:
	#repeat 		#generateRepeat:on:indent:

	#ifTrue:			#generateIfTrue:on:indent:
	#ifFalse:		#generateIfFalse:on:indent:
	#ifTrue:ifFalse:	#generateIfTrueIfFalse:on:indent:
	#ifFalse:ifTrue:	#generateIfFalseIfTrue:on:indent:

	#at:			#generateAt:on:indent:
	#at:put:			#generateAtPut:on:indent:
	#basicAt:		#generateAt:on:indent:
	#basicAt:put:	#generateAtPut:on:indent:

	#integerValueOf:			#generateIntegerValueOf:on:indent:
	#integerObjectOf:			#generateIntegerObjectOf:on:indent:
	#isIntegerObject: 			#generateIsIntegerObject:on:indent:
	#cCode:					#generateInlineCCode:on:indent:
	#cCode:inSmalltalk:			#generateInlineCCode:on:indent:
	#cPreprocessorDirective:	#generateInlineCPreprocessorDirective:on:indent:
	#preprocessorExpression:	#generateInlineCppDirective:on:indent:
	#isDefined:inSmalltalk:comment:ifTrue:	#generateInlineCppIfDef:on:indent:
	#isDefined:inSmalltalk:comment:ifTrue:ifFalse:	#generateInlineCppIfDefElse:on:indent:
	#isDefinedTrueExpression:inSmalltalk:comment:ifTrue:ifFalse:	#generateInlineCppIfElse:on:indent:
	#cCoerce:to:				#generateCCoercion:on:indent:
	#cCoerceSimple:to:			#generateCCoercion:on:indent:
	#addressOf:				#generateAddressOf:on:indent:
	#signedIntFromLong			#generateSignedIntFromLong:on:indent:
	#signedIntToLong			#generateSignedIntToLong:on:indent:
	#signedIntFromShort		#generateSignedIntFromShort:on:indent:
	#signedIntToShort			#generateSignedIntToShort:on:indent:
	#preIncrement				#generatePreIncrement:on:indent:
	#preDecrement				#generatePreDecrement:on:indent:
	#inline:						#generateInlineDirective:on:indent:
	#asFloat					#generateAsFloat:on:indent:
	#asInteger					#generateAsInteger:on:indent:
	#asUnsignedInteger			#generateAsUnsignedInteger:on:indent:
	#asSymbol					#generateAsSymbol:on:indent:
	#flag:						#generateFlag:on:indent:
	#anyMask:					#generateBitAnd:on:indent:
	#raisedTo:					#generateRaisedTo:on:indent:
	#touch:						#generateTouch:on:indent:
	#bytesPerWord		#generateBytesPerWord:on:indent:
	#baseHeaderSize		#generateBaseHeaderSize:on:indent:

	#sharedCodeNamed:inCase:		#generateSharedCodeDirective:on:indent:

	#perform:							#generatePerform:on:indent:
	#perform:with:						#generatePerform:on:indent:
	#perform:with:with:					#generatePerform:on:indent:
	#perform:with:with:with:				#generatePerform:on:indent:
	#perform:with:with:with:with:		#generatePerform:on:indent:
	#perform:with:with:with:with:with:	#generatePerform:on:indent:

	#value								#generateValue:on:indent:
	#value:								#generateValue:on:indent:
	#value:value:						#generateValue:on:indent:

	#shouldNotImplement				#generateSmalltalkMetaError:on:indent:
	#shouldBeImplemented				#generateSmalltalkMetaError:on:indent:
	).

	1 to: pairs size by: 2 do: [:i |
		translationDict at: (pairs at: i) put: (pairs at: i + 1)].

	pairs := #(
	#ifTrue:				#generateIfTrueAsArgument:on:indent:	
	#ifFalse:			#generateIfFalseAsArgument:on:indent:
	#ifTrue:ifFalse:		#generateIfTrueIfFalseAsArgument:on:indent:
	#ifFalse:ifTrue:		#generateIfFalseIfTrueAsArgument:on:indent:
	#cCode:			#generateInlineCCodeAsArgument:on:indent:
	#cCode:inSmalltalk:	#generateInlineCCodeAsArgument:on:indent:

	#value					#generateValueAsArgument:on:indent:
	#value:					#generateValueAsArgument:on:indent:
	#value:value:			#generateValueAsArgument:on:indent:
	).

	asArgumentTranslationDict := Dictionary new: 8.
	1 to: pairs size by: 2 do: [:i |
		asArgumentTranslationDict at: (pairs at: i) put: (pairs at: i + 1)].
! !

!CCodeGenerator methodsFor: 'private' stamp: 'sma 3/3/2000 12:08'!
printArray: array on: aStream
	| first |
	first := true.
	1 to: array size do:
		[:i |
		first 
			ifTrue: [first := false]
			ifFalse: [aStream nextPutAll: ', '].
		i \\ 16 = 1 ifTrue: [aStream cr].
		self printInt: (array at: i) on: aStream]! !

!CCodeGenerator methodsFor: 'private' stamp: 'sma 3/3/2000 12:13'!
printInt: int on: aStream
	aStream print: int.
	(int between: -2147483648 and: 2147483647)
		ifFalse: [(int between: 2147483648 and: 4294967295)
			ifTrue: [aStream nextPut: $U]
			ifFalse: [aStream nextPut: $L]]! !

!CCodeGenerator class methodsFor: 'class initialization' stamp: 'jm 8/19/1998 10:03'!
initialize
	"CCodeGenerator initialize"

	UseRightShiftForDivide := true.
		"If UseRightShiftForDivide is true, the translator will generate a right-shift when it encounters a division by a constant that is a small power of two. For example, 'x / 8' will generate '((int) x >> 3)'. The coercion to int is done to make it clear that the C compiler should generate a signed shift."
		"Note: The Kernighan and Ritchie 2nd Edition C manual, p. 49, leaves the semantics of right-shifting a negative number open to the discretion of the compiler implementor. However, it strongly suggests that most compilers should generate an arithmetic right shift (i.e., shifting in the sign bit), which is the same as dividing by a power of two. If your compiler does not generate or simulate an arithmetic shift, then make this class variable false and re-translate."
! !

!CCodeGenerator class methodsFor: 'C code generator' stamp: 'eem 2/9/2009 22:44'!
monticelloDescriptionFor: aClass
	"Answer a suitable Monticello package stamp to include in the header."
	| pkgInfo pkg uuid |
	pkgInfo := PackageOrganizer default packageOfClass: aClass.
	pkg := MCWorkingCopy allManagers detect: [:ea| ea packageName = pkgInfo packageName].
	pkg ancestry ancestors isEmpty ifFalse:
		[uuid := pkg ancestry ancestors first id].
	^aClass name, (pkg modified ifTrue: [' * '] ifFalse: [' ']), pkg ancestry ancestorString, ' uuid: ', uuid asString! !

!CCodeGenerator class methodsFor: 'removing from system' stamp: 'jm 5/16/1998 10:26'!
removeCompilerMethods
	"Before removing the C code generator classes from the system, use this method to remove the compiler node methods that support it. This avoids leaving dangling references to C code generator classes in the compiler node classes."

	ParseNode withAllSubclasses do: [ :nodeClass |
		nodeClass removeCategory: 'C translation'.
	].
	Smalltalk at: #AbstractSound ifPresent: [:abstractSound |
		 abstractSound class removeCategory: 'primitive generation'].
! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator'!
buildSortedVariablesCollection
	"Build sorted vars, end result will be sorted collection based on static usage, 
	perhaps cache lines will like this!!"

	| globalNames sorted |

	globalNames := Bag new: globalVariableUsage size.
	globalVariableUsage keysAndValuesDo: [:k :v | 
		(variableDeclarations includesKey: k) ifFalse: 
			[globalNames add: k withOccurrences: v size]].	
	variableDeclarations keysDo: 
		[:e | globalNames add: e withOccurrences: 0].
	sorted := SortedCollection sortBlock: 
		[:a :b | (globalNames occurrencesOf: a) > (globalNames occurrencesOf: b)].
	sorted addAll: variables.
	^sorted! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator' stamp: 'tpr 10/29/2002 14:00'!
emitCCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag
	super emitCCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag.

	"if the machine needs the globals structure defined locally in the interp.c file, don't add the folowing function"
	localStructDef ifFalse:[self emitStructureInitFunctionOn: aStream]! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator' stamp: 'dtl 12/4/2010 11:51'!
emitCVariablesOn: aStream
	"Store the global variable declarations on the given stream.
	break logic into vars for structure and vars for non-structure"
	| varString structure nonstruct target |

	structure := WriteStream on: (String new: 32768).
	nonstruct := WriteStream on: (String new: 32768).
	aStream nextPutAll: '/*** Variables ***/'; cr.
	structure nextPutAll: 'static struct foo {'; cr.
	self buildSortedVariablesCollection do: [ :var |
		varString := var asString.
		target := (self placeInStructure: var) 
			ifTrue: [structure]
			ifFalse: [nonstruct].
		(self isGeneratingPluginCode) ifTrue:[
			varString = 'interpreterProxy' ifTrue:[
				"quite special..."
				aStream cr; nextPutAll: '#ifdef SQUEAK_BUILTIN_PLUGIN'.
				aStream cr; nextPutAll: 'extern'.
				aStream cr; nextPutAll: '#endif'; cr.
			] ifFalse:[aStream nextPutAll:'static '].
		].
		(variableDeclarations includesKey: varString) ifTrue: [
			target nextPutAll: (variableDeclarations at: varString), ';'; cr.
		] ifFalse: [
			"default variable declaration"
			target nextPutAll: 'sqInt ', varString, ';'; cr.
		].
	].
	structure nextPutAll: ' } fum;';cr.

	"if the machine needs the fum structure defining locally, do it now"
	localStructDef ifTrue:[structure nextPutAll: 'struct foo * foo = &fum;';cr;cr].

	aStream nextPutAll: structure contents.
	aStream nextPutAll: nonstruct contents.
	aStream cr.! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator' stamp: 'eem 12/10/2008 11:25'!
emitGlobalStructFlagOn: aStream
	"Define SQ_USE_GLOBAL_STRUCT before including the header."

	aStream
		nextPutAll: '#if ';
		nextPutAll: structDefDefine; cr;
		nextPutAll: '# define SQ_USE_GLOBAL_STRUCT 1'; cr;
		nextPutAll: '#else'; cr;
		nextPutAll: '# define SQ_USE_GLOBAL_STRUCT 0'; cr;
		nextPutAll: '#endif'; cr;
		cr! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator' stamp: 'tpr 10/9/2002 15:40'!
emitStructureInitFunctionOn: aStream 
	"For the VM using a global struct for most of the global vars (useful for ARM and PPC so far), append the initGlobalStructure() function"
	aStream 
		cr;
		nextPutAll: 'void initGlobalStructure(void) {foo = &fum;}';
		cr! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator' stamp: 'tpr 10/29/2002 15:01'!
globalStructDefined: aBool
	localStructDef := aBool! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator' stamp: 'eem 2/25/2009 13:29'!
initialize
	super initialize.
	localStructDef := false.
	structDefDefine := '1'! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator' stamp: 'tpr 12/22/2005 16:03'!
placeInStructure: var
	"See if we should put this array into a structure
	This has hard coded vars, should go somewhere else!!
	The variables listed are hardcoded as C in the interpreter thus they don't get resolved via TVariableNode logic
	Also let's ignore variables that have special definitions that require initialization, and the function def which has problems"

	| check |
	check := variableDeclarations at: var ifAbsent: [''].
	(check includes: $=) ifTrue: [^false].
	(check includes: $() ifTrue: [^false].

	(#( 'showSurfaceFn' 'memory' 'extraVMMemory' 'interpreterProxy') includes: var) ifTrue: [^false].
	^true.
	! !

!CCodeGeneratorGlobalStructure methodsFor: 'C code generator'!
returnPrefixFromVariable: aName
	^((self globalsAsSet includes: aName) and: [self placeInStructure: aName])
		ifTrue: ['foo->',aName]
		ifFalse: [aName]! !

!CCodeGeneratorGlobalStructure methodsFor: 'utilities'!
checkForGlobalUsage: vars in: aTMethod 
	"override to handle global struct needs"
	super checkForGlobalUsage: vars in: aTMethod.
	"if localStructDef is false, we  don't ever need to include a reference to it in a function"
	localStructDef ifFalse:[^self].
	vars asSet do: [:var |
		"if any var is global and in the global var struct 
		tell the TMethod it will be refering to the  struct"
			  ((self globalsAsSet includes: var )
					and: [self placeInStructure: var ])
				ifTrue: [aTMethod referencesGlobalStructIncrementBy: (vars occurrencesOf: var)]]! !

!CCodeGeneratorGlobalStructure methodsFor: 'utilities'!
localizeGlobalVariables
"TPR - remove all the global vars destined for the structure that are only used once - not worth the space,
actually what will happen is the folding code will fold these variables into the method"

	super localizeGlobalVariables.
	globalVariableUsage := globalVariableUsage select: [:e | e size > 1].
! !

!CCodeGeneratorGlobalStructure methodsFor: 'public'!
isGlobalStructureBuild
	^true! !

!CCodeGeneratorGlobalStructure methodsFor: 'initialize-release' stamp: 'eem 12/10/2008 11:12'!
structDefDefine: aString
	structDefDefine := aString! !

!VMPluginCodeGenerator methodsFor: 'inlining' stamp: 'dtl 8/21/2011 21:16'!
doInlining: inlineFlag
"do inlining for a plugin"
	self doBasicInlining: inlineFlag.
	self permitMethodPruning
		ifTrue: [self pruneUnreachableMethods]
! !

!VMPluginCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 2/13/2013 13:11'!
emitCHeaderForPrimitivesOn: aStream
	"Write a C file header for compiled primitives onto the given stream."

	self emitCHeaderOn: aStream.
	aStream nextPutAll: '
/*** Proxy Functions ***/
#define stackValue(i) (interpreterProxy->stackValue(i))
#define stackIntegerValue(i) (interpreterProxy->stackIntegerValue(i))
#define successFlag (!!interpreterProxy->failed())
#define success(bool) (interpreterProxy->success(bool))
#define arrayValueOf(oop) (interpreterProxy->arrayValueOf(oop))
#define checkedIntegerValueOf(oop) (interpreterProxy->checkedIntegerValueOf(oop))
#define fetchArrayofObject(idx,oop) (interpreterProxy->fetchArrayofObject(idx,oop))
#define fetchFloatofObject(idx,oop) (interpreterProxy->fetchFloatofObject(idx,oop))
#define fetchIntegerofObject(idx,oop) (interpreterProxy->fetchIntegerofObject(idx,oop))
#define floatValueOf(oop) (interpreterProxy->floatValueOf(oop))
#define isBytes(oop) (interpreterProxy->isBytes(oop))
#define pop(n) (interpreterProxy->pop(n))
#define pushInteger(n) (interpreterProxy->pushInteger(n))
#define sizeOfSTArrayFromCPrimitive(cPtr) (interpreterProxy->sizeOfSTArrayFromCPrimitive(cPtr))
#define storeIntegerofObjectwithValue(idx,oop,value) (interpreterProxy->storeIntegerofObjectwithValue(idx,oop,value))
#define primitiveFail() interpreterProxy->primitiveFail()
/* allows accessing Strings in both C and Smalltalk */
#define asciiValue(c) c

'.
	aStream cr.! !

!VMPluginCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 5/28/2013 20:07'!
emitCHeaderOn: aStream
	"Write a C file header onto the given stream."

	aStream nextPutAll: '/* '.
	aStream nextPutAll: VMMaker headerNotice.
	aStream nextPutAll: ' */';cr.
	aStream nextPutAll: (self fileHeaderVersionStampForSourceClass: vmClass).
	aStream cr; cr.

	aStream nextPutAll:'
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* Default EXPORT macro that does nothing (see comment in sq.h): */
#define EXPORT(returnType) returnType

/* Do not include the entire sq.h file but just those parts needed. */
/*  The virtual machine proxy definition */
#include "sqVirtualMachine.h"
/* Configuration options */
#include "sqConfig.h"
/* Platform specific definitions */
#include "sqPlatformSpecific.h"

#define true 1
#define false 0
#define null 0  /* using ''null'' because nil is predefined in Think C */
#ifdef SQUEAK_BUILTIN_PLUGIN
#undef EXPORT
// was #undef EXPORT(returnType) but screws NorCroft cc
#define EXPORT(returnType) static returnType
#endif
'.

	"Additional header files"
	self emitHeaderFilesOn: aStream.

	aStream nextPutAll: '
#include "sqMemoryAccess.h"

'.
	aStream cr.! !

!VMPluginCodeGenerator methodsFor: 'C code generator' stamp: 'tpr 1/10/2003 16:09'!
emitExportsOn: aStream
	"Store all the exported primitives in a form to be used by internal plugins"
	| prefix |
	aStream nextPutAll:'

#ifdef SQUEAK_BUILTIN_PLUGIN';cr.

	aStream nextPutAll:'

void* ', pluginName,'_exports[][3] = {'.
	prefix := '"', pluginName,'"'.
	self exportedPrimitiveNames do:[:primName|
		aStream cr;
			nextPutAll:'	{'; 
			nextPutAll: prefix; 
			nextPutAll:', "'; 
			nextPutAll: primName; 
			nextPutAll:'", (void*)'; 
			nextPutAll: primName;
			nextPutAll:'},'.
	].
	aStream nextPutAll:'
	{NULL, NULL, NULL}
};
'.
	aStream nextPutAll:'

#endif /* ifdef SQ_BUILTIN_PLUGIN */

'.! !

!VMPluginCodeGenerator methodsFor: 'C code generator' stamp: 'eem 11/7/2009 10:03'!
isTypePointerToStruct: type "<String>"
	^pluginClass notNil
	  and: [[pluginClass isTypePointerToStruct: type]
			on: MessageNotUnderstood
			do: [:ex| ex message selector == #isTypePointerToStruct: ifTrue: [^false].
					ex pass]]! !

!VMPluginCodeGenerator methodsFor: 'public' stamp: 'ar 7/8/2003 10:53'!
generateCodeStringForPrimitives
"TPR - moved down from CCodeGenerator"
	| s methodList |
	s := ReadWriteStream on: (String new: 1000).
	methodList := methods asSortedCollection: [:m1 :m2 | m1 selector < m2 selector].
	self emitCHeaderForPrimitivesOn: s.
	self emitCConstantsOn: s.
	self emitCVariablesOn: s.
	self emitCFunctionPrototypes: methodList on: s.
	methodList do: [:m | m emitCCodeOn: s generator: self].
	self emitExportsOn: s.
	^ s contents
! !

!VMPluginCodeGenerator methodsFor: 'public' stamp: 'tpr 1/10/2003 16:20'!
localizeGlobalVariables
"TPR - we don't do this for plugins"! !

!VMPluginCodeGenerator methodsFor: 'public' stamp: 'tpr 1/10/2003 16:18'!
pluginName: aString
"TPR - moved from CCodeGenerator"
	"Set the plugin name when generating plugins."
	pluginName := aString.! !

!VMPluginCodeGenerator methodsFor: 'testing' stamp: 'ar 10/7/1998 17:54'!
isGeneratingPluginCode
	^true! !

!VMPluginCodeGenerator methodsFor: 'private' stamp: 'ar 4/4/2006 21:15'!
storeVirtualMachineProxyHeader: categoryList on: fileName
	"Store the interpreter definitions on the given file"
	| stream |
	stream := FileStream newFileNamed: fileName.
	stream nextPutAll:
'#ifndef _SqueakVM_H
#define _SqueakVM_H

/* Increment the following number if you change the order of
   functions listed or if you remove functions */
#define VM_PROXY_MAJOR 1

/* Increment the following number if you add functions at the end */
#define VM_PROXY_MINOR 0

typedef struct VirtualMachine {
	int (*minorVersion) (void);
	int (*majorVersion) (void);
'.

	categoryList do:[:assoc|
		stream cr; crtab; nextPutAll:'/* InterpreterProxy methodsFor: ''',assoc key, ''' */'; cr; crtab.
		assoc value asSortedCollection do:[:sel|
			(methods at: sel) emitProxyFunctionPrototype: stream generator: self.
			stream nextPutAll: ';'; crtab]].

	stream nextPutAll:'
} VirtualMachine;

#endif /* _SqueakVM_H */
'.
	stream close.! !

!VMPluginCodeGenerator methodsFor: 'private' stamp: 'tpr 4/12/2006 12:29'!
storeVirtualMachineProxyImplementation: categoryList on: fileName
	"Store the interpreter definitions on the given file"
	| stream |
	stream := FileStream newFileNamed: fileName.
	stream nextPutAll:'
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "sqVirtualMachine.h"'; cr;cr.
	stream nextPutAll:'/*** Function prototypes ***/'.

	categoryList do:[:assoc|
		stream cr; cr; nextPutAll:'/* InterpreterProxy methodsFor: ''',assoc key, ''' */'; cr.
		assoc value asSortedCollection do:[:sel|
			(methods at: sel) emitCFunctionPrototype: stream generator: self.
			stream nextPutAll: ';'; cr]].

	stream cr; nextPutAll:'struct VirtualMachine *VM = NULL;'; cr.
	stream cr; nextPutAll:
'static int majorVersion(void) {
	return VM_PROXY_MAJOR;
}

static int minorVersion(void) {
	return VM_PROXY_MINOR;
}

struct VirtualMachine* sqGetInterpreterProxy(void)
{
	if(VM) return VM;
	VM = (struct VirtualMachine *) calloc(1, sizeof(VirtualMachine));
	/* Initialize Function pointers */
	VM->majorVersion = majorVersion;
	VM->minorVersion = minorVersion;
'.
	categoryList do:[:assoc|
		stream cr; crtab; nextPutAll:'/* InterpreterProxy methodsFor: ''',assoc key, ''' */'; crtab.
		assoc value asSortedCollection do:[:sel|
		stream nextPutAll:'VM->';
			nextPutAll: (self cFunctionNameFor: sel);
			nextPutAll:' = ';
			nextPutAll: (self cFunctionNameFor: sel);
			nextPutAll:';';
			crtab]].

	stream cr; crtab; nextPutAll:'return VM;'; cr; nextPutAll:'}'; cr.
	stream close.! !

!Pragmatizer methodsFor: 'accessing' stamp: 'dtl 9/27/2010 13:41'!
classes: listOfClasses
	"If set, only the classes in this list will be modified. The classes are assumed to be
	classes in the package. This is intended to allow specifying one or more plugins
	in VMMaker-Plugins to be converted individually."

	classes := listOfClasses! !

!Pragmatizer methodsFor: 'accessing' stamp: 'dtl 9/25/2010 11:19'!
stampCutString: stringToRemoveFromMethodStamp
	"If set, this substring will be removed from method stamps during conversion. This is
	intended to enable conversion to and from pragmas without repeated extension of the
	method stamp."

	stampCutString := stringToRemoveFromMethodStamp! !

!Pragmatizer methodsFor: 'accessing' stamp: 'dtl 9/25/2010 12:49'!
stampInsertString: commentToInsert
	"If set, the commentToInsert will be used for method stamp modification
	rather than the default conversion value. This is intended to permit a
	Pragmatizer to reproduce a previous conversion, e.g. the previously converted
	methods in the Cog VM."

	stampInsertString := commentToInsert
! !

!Pragmatizer methodsFor: 'convert pragmas to sends' stamp: 'dtl 9/27/2010 11:37'!
depragmatize
	"Convert methods from pragmas to old style message send directives, retaining
	original author initials and time stamps. Answer the methods that were modified."

	| instanceMethods |
	"Only instance side methods are translated, so ignore class side methods in the package"
	instanceMethods := package methods
				reject: [:e | e classIsMeta
						or: [self isExcludedClass: e]].
	^ instanceMethods
		reject: [:mr | self depragmatize: mr]! !

!Pragmatizer methodsFor: 'convert pragmas to sends' stamp: 'dtl 9/25/2010 12:51'!
depragmatize: methodReference
	"Depragmatize the method. Answer true if the method was not modified, and false
	if conversion was performed."

	| method newSource newStamp pragmas stamp |
	pragmas := OrderedCollection new.
	method := methodReference compiledMethod.
	method properties keysAndValuesDo: [:sel :p |
		(selectors includes: sel)
			ifTrue: [pragmas add: p]].
	pragmas isEmpty ifTrue: [^ true].
	newSource := pragmas
		inject: method getSourceFromFile asString
		into: [:src : pragma |
				src copyReplaceAll: pragma asString
					with: 'self ', pragma asString allButFirst allButLast, '.'].
		stamp := method timeStamp.
		newStamp := self newConvertToMessageSendStamp: stamp.
	Transcript
		print: method methodClass;
		nextPutAll: '>>';
		print: method selector;
		nextPut: Character space;
		nextPutAll: newStamp;
		cr; flush.
	method methodClass
		compile: newSource
		classified: methodReference category
		withStamp: newStamp
		notifying: nil.
	^false
! !

!Pragmatizer methodsFor: 'testing' stamp: 'dtl 9/27/2010 13:44'!
isExcludedClass: aMethodReference

	classes notNil
		and: [classes
				detect: [:cls | cls name = aMethodReference classSymbol]
				ifNone: [^ true]].
	^ false! !

!Pragmatizer methodsFor: 'method stamp' stamp: 'dtl 9/25/2010 13:06'!
newConvertToMessageSendStamp: oldStamp
	"Insert a comment in a method stamp to indicate that conversion from pragmas to old
	style message sends was done. If stampCutString has been set, remove this substring
	from the oldStamp prior to adding a new substring. If stampInsertString was set, use
	this as the substring to insert. Otherwise add a substring with current date and author
	initials." 

	| newStamp |
	stampCutString
		ifNil: [newStamp := oldStamp]
		ifNotNil: [newStamp := oldStamp copyReplaceAll: stampCutString with: ''].
	stampInsertString
		ifNil: [newStamp := newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: '(remove pragmas ', Utilities authorInitials, ' ', Date today yyyymmdd, ') ']
		ifNotNil: [newStamp := newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: stampInsertString].
	^ newStamp
! !

!Pragmatizer methodsFor: 'method stamp' stamp: 'dtl 9/25/2010 13:06'!
newConvertToPragmaStamp: oldStamp
	"Insert a comment in a method stamp to indicate that conversion to pragmas was done.
	If stampCutString has been set, remove this substring from the oldStamp prior to adding
	a new substring. If stampInsertString was set, use this as the substring to insert. Otherwise
	add a substring with current date and author initials." 

	| newStamp |
	stampCutString
		ifNil: [newStamp := oldStamp]
		ifNotNil: [newStamp := oldStamp copyReplaceAll: stampCutString with: ''].
	stampInsertString
		ifNil: [newStamp := newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: '(auto pragmas ', Utilities authorInitials, ' ', Date today yyyymmdd, ') ']
		ifNotNil: [newStamp := newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: stampInsertString].
	^ newStamp
! !

!Pragmatizer methodsFor: 'convert sends to pragmas' stamp: 'dtl 9/25/2010 18:05'!
newPragmatizedSourceFrom: source nodes: pragmaNodes nodeRanges: ranges

	^ String streamContents: [:str|
		str nextPutAll: (source copyFrom: 1 to: ranges first - 6).
		pragmaNodes
			do: [:node| | pragma args |
				str nextPut: $<.
				str nextPutAll: (node asString allButFirst: 6) allButLast.
				str nextPut: $>]
			separatedBy: [str crtab: 1].
		str nextPutAll: (source copyFrom: ((ranges last + 1 <= source size
										   and: [(source at: ranges last + 1) = $.])
											ifTrue: [ranges last + 2]
											ifFalse: [ranges last + 1])
							to: source size)]
! !

!Pragmatizer methodsFor: 'convert sends to pragmas' stamp: 'dtl 9/27/2010 11:36'!
pragmatize
	"Convert methods to use pragmas, retaining original author initials and time stamps.
	Answer the methods that were modified."

	| instanceMethods |
	"Only instance side methods are translated, so ignore class side methods in the package"
	instanceMethods := package methods
				reject: [:e | e classIsMeta
						or: [self isExcludedClass: e]].
	^ instanceMethods
		reject: [:mr | self pragmatize: mr]! !

!Pragmatizer methodsFor: 'convert sends to pragmas' stamp: 'dtl 9/25/2010 17:26'!
pragmatize: methodReference
	"Pragmatize the method. Answer true if the method was not modified, and false
	if conversion was performed."

	| method methodNode pragmaNodes sourceRanges ranges source newSource stamp newStamp |
	method := methodReference compiledMethod.
	methodNode := method methodNode.
	pragmaNodes := SortedCollection
						sortBlock: [:a :b | (sourceRanges at: a) first <= (sourceRanges at: b) first].
	(sourceRanges := methodNode rawSourceRanges)
		keysAndValuesDo: [:node :range | (node isMessageNode
					and: [selectors includes: node selector key])
				ifTrue: [pragmaNodes add: node]].
	^ pragmaNodes isEmpty
		ifFalse: [ranges := (sourceRanges at: pragmaNodes first) first
								to: (sourceRanges at: pragmaNodes last) last.

				source := method getSourceFromFile asString.
				"methodBodyStart := method methodClass parserClass new
										parseMethodComment: source setPattern: [:ignored|];
										startOfNextToken.
				tempsStart := source indexOf: $| startingAt: methodBodyStart.
				hasTemps := tempsStart > 0 and: [tempsStart < ranges first]."
				(source copyFrom: ranges first - 5 to: ranges first - 1) ~= 'self ' ifTrue: [self halt].
				(ranges last < source size
					and: [(source indexOf: $. startingAt: ranges last) > (ranges last + 1)]) ifTrue: [self halt].
				newSource := self newPragmatizedSourceFrom: source
							nodes: pragmaNodes
							nodeRanges: ranges.
				stamp := method timeStamp.
				newStamp := self newConvertToPragmaStamp: stamp.
				Transcript
					print: method methodClass;
					nextPutAll: '>>';
					print: method selector;
					nextPut: Character space;
					nextPutAll: newStamp;
					cr; flush.
				method methodClass
					compile: newSource
					classified: methodReference category
					withStamp: newStamp
					notifying: nil.
				false]
! !

!Pragmatizer methodsFor: 'initialize-release' stamp: 'dtl 9/20/2010 18:57'!
package: packageName selectors: selectorList

	package := PackageOrganizer default
		packageNamed: packageName
		ifAbsent: [self error: 'package ', packageName, ' not found'].
	selectors := selectorList! !

!Pragmatizer class methodsFor: 'examples' stamp: 'dtl 9/25/2010 15:15'!
convertVMMakerAndPluginsToPragmas
	"Create (unused) packages named 'VMMaker-Interpreter', 'VMMaker-Plugins',
	and 'VMMaker-SmartSyntaxPlugins'. Open a transcript, then evaluate this method.
	Some errors will be found during the conversion. Fix the problem methods
	manually in the notifier dialog, and proceed. The issues are related to declarations
	that are not the first lines of source in the method, so just move the declarations
	to the top of the method to resolve."
	
	"Pragmatizer convertVMMakerAndPluginsToPragmas"

	| selectorsToConvert packages converter |
	selectorsToConvert := #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: ).
	packages := { 'VMMaker-Interpreter' . 'VMMaker-Plugins' . 'VMMaker-SmartSyntaxPlugins' }.
	packages do: [:package |
		converter := Pragmatizer on: package selectors: selectorsToConvert.
		converter pragmatize]! !

!Pragmatizer class methodsFor: 'examples' stamp: 'dtl 9/26/2010 11:03'!
revertVMMakerAndPluginsToMessageSendDeclarations
	"To revert back to the message send declarations. "
	
	"Pragmatizer revertVMMakerAndPluginsToMessageSendDeclarations"

	| selectorsToConvert packages converter substringToRemoveFromMethodStamp |

	"Optional - Edit the following to match substring to be removed from the method
	stamps to return them to their original form prior to conversion to pragmas:
	Note leading space in the string."
	substringToRemoveFromMethodStamp := ' (auto pragmas dtl 2010-09-26)'.

	selectorsToConvert := #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: ).
	packages := { 'VMMaker-Interpreter' . 'VMMaker-Plugins' . 'VMMaker-SmartSyntaxPlugins' }.
	packages do: [:package |
		converter := Pragmatizer on: package selectors: selectorsToConvert.
		converter stampCutString: substringToRemoveFromMethodStamp.
		converter stampInsertString: ''.
		converter depragmatize]! !

!Pragmatizer class methodsFor: 'instance creation' stamp: 'dtl 9/23/2010 19:31'!
on: packageName selectors: selectorList
	"Pragmatizer on: 'VMMaker-Interpreter' selectors: #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: )"
	"Pragmatizer on: 'VMMaker-Plugins' selectors: #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: )"
	"Pragmatizer on: 'VMMaker-SmartSyntaxPlugins' selectors: #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: )"

	^ self new package: packageName selectors: selectorList! !

!TMethod methodsFor: 'inlining support' stamp: 'eem 3/30/2013 11:56'!
addVarsDeclarationsAndLabelsOf: methodToBeInlined except: doNotRename
	"Prepare to inline the body of the given method into the receiver by making the args and locals of the argument to the receiver be locals of the receiver. Record any type declarations for these variables. Record labels. Assumes that the variables have already be renamed to avoid name clashes."

	locals
		addAll: (methodToBeInlined args reject: [ :v | doNotRename includes: v]);
		addAll: (methodToBeInlined locals reject: [ :v | doNotRename includes: v]).
	methodToBeInlined declarations keysAndValuesDo:
		[ :v :decl |
		(doNotRename includes: v) ifFalse:
			[self declarationAt: v put: decl]].

	labels addAll: methodToBeInlined labels! !

!TMethod methodsFor: 'inlining support' stamp: 'eem 10/24/2013 16:03'!
computePossibleSideEffectsInto: writtenToVars visited: visitedSelectors in: aCodeGen
	"Add all variables written to by this method and its callees to writtenToVars.
	 Avoid circularity via visitedSelectors"

	(visitedSelectors includes: selector) ifTrue:
		[^self].
	visitedSelectors add: selector.
	writtenToGlobalVarsCache ifNotNil:
		[writtenToVars addAll: writtenToGlobalVarsCache.
		 ^self].
	parseTree nodesDo:
		[ :node |
			(node isAssignment
			 and: [(locals includes: node variable name) not])
				ifTrue:
					[writtenToVars add: node variable name].
			(node isSend
			 and: [node isBuiltinOperator not
			 and: [(node isStructSendIn: aCodeGen) not]]) ifTrue:
				[(aCodeGen methodNamed: node selector) ifNotNil:
					[:method|
					 method
						computePossibleSideEffectsInto: writtenToVars
						visited: visitedSelectors
						in: aCodeGen]]].
	writtenToGlobalVarsCache := writtenToVars copy! !

!TMethod methodsFor: 'inlining support' stamp: 'dtl 9/19/2010 13:20'!
extractInlineDirective
	"Scan the top-level statements for an inlining directive of the form:

		self inline: <boolean>

	 and remove the directive from the method body. Return the argument of the directive or #dontCare if there is no inlining directive."

	| result newStatements methodDirectiveFound |
	sharedCase ifNotNil:[^false]. "don't auto-inline shared code; it gets handled specially"
	result := #dontCare.
	methodDirectiveFound := false.
	newStatements := OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		(stmt isSend and: [stmt selector = #inline:]) ifTrue: [
			methodDirectiveFound := true.
			result := stmt args first value = true.
		] ifFalse: [
			newStatements add: stmt.
		].
	].
	parseTree setStatements: newStatements asArray.
	methodDirectiveFound ifTrue: [^ result].
	"no method declaration was used, so check for a pragma declaration"
	sharedCase ifNotNil: [^false]. "don't auto-inline shared code; it gets handled specially"
	^self
		extractDirective: #inline:
		valueBlock: [:sendNode| sendNode args first value = true]
		default: #dontCare! !

!TMethod methodsFor: 'inlining support' stamp: 'dtl 8/25/2011 22:37'!
hasDoNotGenerateStatement
	"True if method has a #doNotGenerate statement, equivalent to pragma <doNotGenerate>
	or if it has a #subclassResponsibility statement."
	parseTree statements
		detect: [:stmt | stmt isSend
					and: [stmt selector = #doNotGenerate
						or: [stmt selector = #subclassResponsibility]]]
		ifNone: [^ false].
	^ true! !

!TMethod methodsFor: 'inlining support' stamp: 'eem 7/30/2008 15:08'!
maySubstituteGlobal: globalVar in: aCodeGen
	"We can substitute globalVar into this method provided globalVar is only read, not written."

	writtenToGlobalVarsCache = nil ifTrue:
		[self computePossibleSideEffectsInto: (Set new: 50) visited: (Set new: 50) in: aCodeGen].
	^(writtenToGlobalVarsCache includes: globalVar) not! !

!TMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:06'!
renameLabelsForInliningInto: destMethod
	"Rename any labels that would clash with those of the destination method."

	| destLabels usedLabels labelMap newLabelName |
	destLabels := destMethod labels asSet.
	usedLabels := destLabels copy.  "usedLabels keeps track of labels in use"
	usedLabels addAll: labels.
	labelMap := Dictionary new: 100.
	self labels do: [ :l |
		(destLabels includes: l) ifTrue: [
			newLabelName := self unusedNamePrefixedBy: 'l' avoiding: usedLabels.
			labelMap at: l put: newLabelName.
		].
	].
	self renameLabelsUsing: labelMap.! !

!TMethod methodsFor: 'inlining support'!
renameLabelsUsing: aDictionary
	"Rename all labels according to the old->new mappings of the given dictionary."

	labels := labels collect: [ :label |
		(aDictionary includesKey: label) ifTrue: [ aDictionary at: label ] ifFalse: [ label ].
	].

	parseTree nodesDo: [ :node |
		(node isGoTo and: [aDictionary includesKey: node label]) ifTrue: [
			node setLabel: (aDictionary at: node label).
		].
		(node isLabel and: [aDictionary includesKey: node label]) ifTrue: [
			node setLabel: (aDictionary at: node label).
		].
	].! !

!TMethod methodsFor: 'inlining support' stamp: 'dtl 6/23/2012 10:32'!
renameVariablesUsing: aDictionary
	"Rename all variables according to old->new mappings of the given dictionary."

	| newDecls newKey newValue |
	"map args and locals"
	args := args collect: [ :arg |
		(aDictionary includesKey: arg) ifTrue: [ aDictionary at: arg ] ifFalse: [ arg ].
	].
	locals := locals collect: [ :v |
		(aDictionary includesKey: v) ifTrue: [ aDictionary at: v ] ifFalse: [ v ].
	].
	"prevent runaway recursion, e.g. inlining a method with super send"
	locals size > 1000 ifTrue: [self error: 'recursive inlining in ', selector asString, ', too many locals'].

	"map declarations"
	newDecls := declarations species new.
	declarations associationsDo: [ :assoc |
		(aDictionary includesKey: assoc key)
			ifTrue: [ newKey := aDictionary at: assoc key.
					newValue := assoc value replaceLastOccurrence: assoc key with: newKey.
					newDecls at: newKey put: newValue]
			ifFalse: [ newDecls add: assoc ].
	].
	declarations := newDecls.

	"map variable names in parse tree"
	parseTree nodesDo: [ :node |
		(node isVariable and:
		 [aDictionary includesKey: node name]) ifTrue: [
			node setName: (aDictionary at: node name).
		].
		(node isStmtList and: [node args size > 0]) ifTrue: [
			node setArguments:
				(node args collect: [ :arg |
					(aDictionary includesKey: arg)
						ifTrue: [ aDictionary at: arg ]
						ifFalse: [ arg ].
				]).
		].
	].! !

!TMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:07'!
renameVarsForCaseStmt
	"Rename the arguments and locals of this method with names like t1, t2, t3, etc. Return the number of variable names assigned. This is done to allow registers to be shared among the cases."

	| i varMap |
	i := 1.
	varMap := Dictionary new: 100.
	args, locals do: [ :v |
		varMap at: v put: ('t', i printString) asSymbol.
		i := i + 1.
	].
	self renameVariablesUsing: varMap.
	^ i - 1! !

!TMethod methodsFor: 'inlining support' stamp: 'eem 3/30/2013 11:57'!
renameVarsForInliningInto: destMethod except: doNotRename in: aCodeGen
	"Rename any variables that would clash with those of the destination method."

	| destVars usedVars varMap newVarName |
	destVars := aCodeGen globalsAsSet copy.
	destVars addAll: destMethod locals.
	destVars addAll: destMethod args.
	usedVars := destVars copy.  "keeps track of names in use"
	usedVars addAll: args; addAll: locals.
	varMap := Dictionary new: 100.
	locals, args do:
		[ :v |
		((doNotRename includes: v) not
		  and: [destVars includes: v]) ifTrue:
			[newVarName := self unusedNamePrefixedBy: v avoiding: usedVars.
			varMap at: v put: newVarName]].
	self renameVariablesUsing: varMap! !

!TMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:07'!
renameVarsForInliningInto: destMethod in: aCodeGen
	"Rename any variables that would clash with those of the destination method."

	| destVars usedVars varMap newVarName |
	destVars := aCodeGen globalsAsSet copy.
	destVars addAll: destMethod locals.
	destVars addAll: destMethod args.
	usedVars := destVars copy.  "keeps track of names in use"
	usedVars addAll: args; addAll: locals.
	varMap := Dictionary new: 100.
	args, locals do: [ :v |
		(destVars includes: v) ifTrue: [
			newVarName := self unusedNamePrefixedBy: v avoiding: usedVars.
			varMap at: v put: newVarName.
		].
	].
	self renameVariablesUsing: varMap.! !

!TMethod methodsFor: 'inlining support'!
unusedNamePrefixedBy: aString avoiding: usedNames
	"Choose a unique variable or label name with the given string as a prefix, avoiding the names in the given collection. The selected name is added to usedNames."

	| n newVarName |
	n := 1.
	newVarName := aString, n printString.
	[usedNames includes: newVarName] whileTrue: [
		n := n + 1.
		newVarName := aString, n printString.
	].
	usedNames add: newVarName.
	^ newVarName! !

!TMethod methodsFor: 'utilities'!
allCalls
	"Answer a collection of selectors for the messages sent by this method."

	^parseTree allCalls! !

!TMethod methodsFor: 'utilities'!
freeVariableReferences
	"Answer a collection of variables referenced this method, excluding locals, arguments, and pseudovariables."

	| refs |
	refs := Set new.
	parseTree nodesDo: [ :node |
		node isVariable ifTrue: [ refs add: node name asString ].
	].
	args do: [ :var | refs remove: var asString ifAbsent: [] ].
	locals do: [ :var | refs remove: var asString ifAbsent: [] ].
	#('self' 'nil' 'true' 'false') do: [ :var | refs remove: var ifAbsent: [] ].
	^ refs asSortedCollection! !

!TMethod methodsFor: 'utilities'!
hasNoCCode
	"Answer true if the receiver does not use inlined C or C declarations, which are not currently renamed properly by the the inliner."

	declarations isEmpty ifFalse: [ ^ false ].

	parseTree nodesDo: [ :node |
		node isSend ifTrue: [
			node selector = #cCode: ifTrue: [ ^ false ].
		].
	].
	^ true! !

!TMethod methodsFor: 'utilities'!
nodeCount
	"Answer the number of nodes in this method's parseTree (a rough measure of its size)."

	| cnt |
	cnt := 0.
	parseTree nodesDo: [ :n | cnt := cnt + 1 ].
	^cnt! !

!TMethod methodsFor: 'utilities' stamp: 'ar 7/8/2003 11:20'!
removeUnusedTemps
	"Remove all of the unused temps in this method. Answer a bag (why the hell a bag???) with the references."
	"After inlining some variable references are now obsolete, we could fix them there but the 
	code seems a bit complicated, the other choice to to rebuild the locals before extruding. This is done here"
	| refs |
	refs := Bag new.
	"find all the variable names referenced in this method"
	parseTree nodesDo: [ :node |
		node isVariable ifTrue: [ refs add: node name asString ].
		node isStmtList ifTrue: [refs addAll: node args]].
	"add all the non-arg declarations (might be variables usedonly in cCode sections)"
	refs addAll:((self declarations keys) reject: [:e | self args includes: e]).
	"reset the locals to be only those still referred to"
	locals := locals select: [:e | refs includes: e].
	^refs
! !

!TMethod methodsFor: 'utilities' stamp: 'eem 2/11/2009 19:00'!
typeForSelf
	self assert: definingClass notNil.
	^[definingClass typeForSelf]
		on: MessageNotUnderstood
		do: [:ex| nil]! !

!TMethod methodsFor: 'utilities'!
variablesAssignedTo
	"Answer a collection of variables assigned to by this method."

	| refs |
	refs := Set new.
	parseTree nodesDo: [ :node |
		node isAssignment ifTrue: [ refs add: node variable name ].
	].
	^ refs! !

!TMethod methodsFor: 'inlining'!
argAssignmentsFor: meth args: argList in: aCodeGen
	"Return a collection of assignment nodes that assign the given argument expressions to the formal parameter variables of the given method."
	"Optimization: If the actual parameters are either constants or local variables in the target method (the receiver), substitute them directly into the body of meth. Note that global variables cannot be subsituted because the inlined method might depend on the exact ordering of side effects to the globals."

	| stmtList substitutionDict |
	stmtList := OrderedCollection new: 100.
	substitutionDict := Dictionary new: 100.
	meth args with: argList do: [ :argName :exprNode |
		(self isSubstitutableNode: exprNode intoMethod: meth in: aCodeGen) ifTrue: [
			substitutionDict at: argName put: exprNode.
			locals remove: argName.
		] ifFalse: [
			stmtList add: (TAssignmentNode new
				setVariable: (TVariableNode new setName: argName)
				expression: exprNode copyTree).
		].
	].
	meth parseTree: (meth parseTree bindVariablesIn: substitutionDict).
	^stmtList! !

!TMethod methodsFor: 'inlining'!
checkForCompleteness: stmtLists in: aCodeGen
	"Set the complete flag if none of the given statement list nodes contains further candidates for inlining."

	complete := true.
	stmtLists do: [ :stmtList |
		stmtList statements do: [ :node |
			(self inlineableSend: node in: aCodeGen) ifTrue: [
				complete := false.  "more inlining to do"
				^self
			].
		].
	].
	parseTree nodesDo: [ :n |
		(self inlineableFunctionCall: n in: aCodeGen) ifTrue: [
			complete := false.  "more inlining to do"
			^self
		].
	].! !

!TMethod methodsFor: 'inlining'!
exitVar: exitVar label: exitLabel
	"Replace each return statement in this method with an assignment to the exit variable followed by a goto to the given label. Return true if a goto was generated."
	"Optimization: If exitVar is nil, the return value of the inlined method is not being used, so don't add the assignment statement."

	| newStmts labelUsed |
	labelUsed := false.
	parseTree nodesDo: [ :node |
		node isStmtList ifTrue: [
			newStmts := OrderedCollection new: 100.
			node statements do: [ :stmt |
				(stmt isReturn) ifTrue: [
					exitVar = nil ifTrue: [
						stmt expression isLeaf ifFalse: [
							"evaluate return expression even though value isn't used"
							newStmts add: stmt expression.
						].
					] ifFalse: [
						"assign return expression to exit variable"
						newStmts add:
							(TAssignmentNode new
								setVariable: (TVariableNode new setName: exitVar)
								expression: stmt expression).
					].
					(stmt == parseTree statements last) ifFalse: [
						"generate a goto (this return is NOT the last statement in the method)"
						newStmts add: (TGoToNode new setLabel: exitLabel).
						labelUsed := true.
					].
				] ifFalse: [
					newStmts addLast: stmt.
				].
			].
			node setStatements: newStmts asArray.
		].
	].
	^labelUsed! !

!TMethod methodsFor: 'inlining' stamp: 'dtl 8/17/2008 18:46'!
inlineCaseStatementBranchesIn: aCodeGen localizingVars: varsList

	| stmt sel meth newStatements maxTemp usedVars exitLabel v |
	maxTemp := 0.
	parseTree nodesDo: [ :n |
		n isCaseStmt ifTrue: [
			n cases do: [ :stmtNode |
				stmt := stmtNode statements first.
				stmt isSend ifTrue: [
					sel := stmt selector.
					meth := aCodeGen methodNamed: sel.
					"Note, original version of this method tested for #hasNoCCode. Removed
					the test to permit inlining methods that may contain automatically
					generated C code for type conversions. -dtl"
					((meth ~= nil) and:
					 [meth args size = 0]) ifTrue: [
						meth := meth copy.
						meth hasReturn ifTrue: [
							exitLabel := self unusedLabelForInliningInto: self.
							meth exitVar: nil label: exitLabel.
							labels add: exitLabel.
						] ifFalse: [ exitLabel := nil ].

						meth renameLabelsForInliningInto: self.
						meth labels do: [ :label | labels add: label ].
						newStatements := stmtNode statements asOrderedCollection.
						newStatements removeFirst.

						exitLabel ~= nil ifTrue: [
							newStatements addFirst:
								(TLabeledCommentNode new
									setLabel: exitLabel comment: 'end case').
						].

						newStatements addFirst: meth asInlineNode.
						newStatements addFirst:
							(TLabeledCommentNode new setComment: meth selector).
						stmtNode setStatements: newStatements.
					].
				].
			].
		].
	].
	usedVars := (locals, args) asSet.
	1 to: maxTemp do: [ :i |
		v := ('t', i printString).
		(usedVars includes: v) ifTrue: [ self error: 'temp variable name conflicts with an existing local or arg' ].
		locals addLast: v.
	].

	"make local versions of the given globals"
	varsList do: [ :var |
		(usedVars includes: var) ifFalse: [ locals addFirst: var asString ].
	].
! !

!TMethod methodsFor: 'inlining'!
inlineCodeOrNilForStatement: aNode in: aCodeGen
	"If the given statement node can be inlined, answer the statements that replace it. Otherwise, answer nil."

	| stmts |
	aNode isReturn ifTrue: [
		(self inlineableSend: aNode expression in: aCodeGen) ifTrue: [
			stmts := self inlineSend: aNode expression
				directReturn: true exitVar: nil in: aCodeGen.
			^stmts
		].
	].
	aNode isAssignment ifTrue: [
		(self inlineableSend: aNode expression in: aCodeGen) ifTrue: [
			^self inlineSend: aNode expression
				directReturn: false exitVar: aNode variable name in: aCodeGen
		].
	].
	aNode isSend ifTrue: [
		(self inlineableSend: aNode in: aCodeGen) ifTrue: [
			^self inlineSend: aNode
				directReturn: false exitVar: nil in: aCodeGen
		].
	].
	^nil! !

!TMethod methodsFor: 'inlining' stamp: 'eem 7/26/2011 13:59'!
inlineFunctionCall: aSendNode in: aCodeGen
	"Answer the body of the called function, substituting the actual
	 parameters for the formal argument variables in the method body.
	 Assume caller has established that:
		1. the method arguments are all substitutable nodes, and
		2. the method to be inlined contains no additional embedded returns."

	| sel meth doNotRename argsForInlining substitutionDict |
	sel := aSendNode selector.
	meth := (aCodeGen methodNamed: sel) copy.
	doNotRename := Set withAll: args.
	argsForInlining := aSendNode argumentsForInliningCodeGenerator: aCodeGen.
	meth args with: argsForInlining do:
		[ :argName :exprNode |
		exprNode isLeaf ifTrue:
			[doNotRename add: argName]].
	meth renameVarsForInliningInto: self except: doNotRename in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth except: doNotRename.
	substitutionDict := Dictionary new: meth args size * 2.
	meth args with: argsForInlining do:
		[ :argName :exprNode |
		substitutionDict at: argName put: exprNode.
		(doNotRename includes: argName) ifFalse:
			[locals remove: argName]].
	meth parseTree bindVariablesIn: substitutionDict.
	^meth statements first expression! !

!TMethod methodsFor: 'inlining' stamp: 'dtl 2/5/2014 16:05'!
inlineSend: aSendNode directReturn: directReturn exitVar: exitVar in: aCodeGen
	"Answer a collection of statments to replace the given send. directReturn indicates that the send is the expression of a return statement, so returns can be left in the body of the inlined method. If exitVar is nil, the value returned by the send is not used; thus, returns need not assign to the output variable."

	| sel meth exitLabel labelUsed inlineStmts |
	sel := aSendNode selector.
	meth := (aCodeGen methodNamed: sel) copy.
	meth renameVarsForInliningInto: self in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth except: #().
	meth hasReturn ifTrue: [
		directReturn ifTrue: [
			"propagate the return type, if necessary"
			returnType = meth returnType ifFalse: [ self halt ].  "caller's return type should be declared by user"
			returnType := meth returnType.
		] ifFalse: [
			exitLabel := self unusedLabelForInliningInto: self.
			labelUsed := meth exitVar: exitVar label: exitLabel.
			labelUsed
				ifTrue: [ labels add: exitLabel ]
				ifFalse: [ exitLabel := nil ].
		].
		"propagate type info if necessary"
		((exitVar ~= nil) and: [meth returnType ~= 'sqInt']) ifTrue: [
			declarations at: exitVar put: meth returnType, ' ', exitVar.
		].
	].
	inlineStmts := OrderedCollection new: 100.
	inlineStmts add: (TLabeledCommentNode new setComment: 'begin ', sel).
	inlineStmts addAll:
		(self argAssignmentsFor: meth args: aSendNode args in: aCodeGen).
	inlineStmts addAll: meth statements.  "method body"
	(directReturn and: [meth endsWithReturn not]) ifTrue: [
		inlineStmts add: (TReturnNode new setExpression: (TVariableNode new setName: 'nil')).
	].
	exitLabel ~= nil ifTrue: [
		inlineStmts add:
			(TLabeledCommentNode new
				setLabel: exitLabel comment: 'end ', meth selector).
	].
	^inlineStmts! !

!TMethod methodsFor: 'inlining'!
inlineableFunctionCall: aNode in: aCodeGen
	"Answer true if the given send node is a call to a 'functional' method--a method whose body is a single return statement of some expression and whose actual parameters can all be directly substituted."

	| m |
	aNode isSend ifFalse: [ ^false ].
	m := aCodeGen methodNamed: aNode selector.  "nil if builtin or external function"
	((m ~= nil) and: [m isFunctional and: [aCodeGen mayInline: m selector]]) ifTrue: [
		aNode args do: [ :a | (self isSubstitutableNode: a intoMethod: m in: aCodeGen) ifFalse: [ ^false ]].
		^true
	] ifFalse: [
		^false
	].! !

!TMethod methodsFor: 'inlining'!
inlineableSend: aNode in: aCodeGen
	"Answer true if the given send node is a call to a method that can be inlined."

	| m |
	aNode isSend ifFalse: [ ^false ].
	m := aCodeGen methodNamed: aNode selector.  "nil if builtin or external function"
	^(m ~= nil) and: [m isComplete and: [aCodeGen mayInline: m selector]]! !

!TMethod methodsFor: 'inlining'!
isFunctional
	"Answer true if the receiver is a functional method. That is, if it consists of a single return statement of an expression that contains no other returns."

	(parseTree statements size = 1 and:
	 [parseTree statements last isReturn]) ifFalse: [ ^false ].
	parseTree statements last expression nodesDo: [ :n | n isReturn ifTrue: [ ^false ]].
	^true! !

!TMethod methodsFor: 'inlining' stamp: 'ar 5/9/2000 12:13'!
isSubstitutableNode: aNode
	"Answer true if the given parameter node is either a constant, a local variable, or a formal parameter of the receiver. Such parameter nodes may be substituted directly into the body of the method during inlining. Note that global variables cannot be subsituted because the inlined method might depend on the exact ordering of side effects to the globals."

	aNode isConstant ifTrue: [ ^true ].
	^aNode isVariable and:
		[(locals includes: aNode name) or:
		[args includes: aNode name]]! !

!TMethod methodsFor: 'inlining'!
isSubstitutableNode: aNode intoMethod: targetMeth in: aCodeGen
	"Answer true if the given parameter node is either a constant, a local variable, or a formal parameter of the receiver. Such parameter nodes may be substituted directly into the body of the method during inlining. Note that global variables cannot be subsituted into methods with possible side effects (i.e., methods that may assign to global variables) because the inlined method might depend on having the value of the global variable captured when it is passed in as an argument."

	| var |
	aNode isConstant ifTrue: [ ^ true ].

	aNode isVariable ifTrue: [
		var := aNode name.
		((locals includes: var) or: [args includes: var]) ifTrue: [ ^ true ].
		(#(self true false nil) includes: var) ifTrue: [ ^ true ].
		(targetMeth maySubstituteGlobal: var in: aCodeGen) ifTrue: [ ^ true ].
	].

	"scan expression tree; must contain only constants, builtin ops, and inlineable vars"
	aNode nodesDo: [ :node |
		node isSend ifTrue: [
			node isBuiltinOperator ifFalse: [ ^false ].
		].
		node isVariable ifTrue: [
			var := node name.
			((locals includes: var) or:
			 [(args includes: var) or:
			 [(#(self true false nil) includes: var) or:
			 [targetMeth maySubstituteGlobal: var in: aCodeGen]]]) ifFalse: [ ^ false ].
		].
		(node isConstant or: [node isVariable or: [node isSend]]) ifFalse: [ ^false ].
	].

	^ true! !

!TMethod methodsFor: 'inlining' stamp: 'eem 10/25/2013 11:10'!
maybeBreakFor: aNode in: aCodeGen
	"convenient for debugging..."
	(aNode isSend
	and: [(aCodeGen breakSrcInlineSelector notNil or: [aCodeGen breakDestInlineSelector notNil])
	and: [(aCodeGen breakSrcInlineSelector ifNil: [true] ifNotNil: [:srcSel| srcSel = aNode selector])
	and: [aCodeGen breakDestInlineSelector ifNil: [true] ifNotNil: [:dstSel| dstSel = selector]]]]) ifTrue:
		[self halt: selector]! !

!TMethod methodsFor: 'inlining' stamp: 'dtl 3/1/2014 18:22'!
removeUnreferencedDeclarations
	"Variables may have been eliminated during inlining. Remove declarations for those variables."
	declarations keys copy
		do: [:key | (args , locals includes: key)
				ifFalse: [declarations removeKey: key]]! !

!TMethod methodsFor: 'inlining' stamp: 'eem 7/30/2013 16:20'!
statementsListsForInliningIn: aCodeGen
	"Answer a collection of statement list nodes that are candidates for inlining.
	 Currently, we cannot inline into the argument blocks of and: and or: messages.
	 We do not want to inline code strings within cCode:inSmalltalk: blocks (those with a
	 proper block for the cCode: argument are inlined in MessageNode>>asTranslatorNodeIn:).
	 We do not want to inline code within assert: sends (because we want the assert to read nicely)."

	| stmtLists |
	stmtLists := OrderedCollection new: 10.
	parseTree
		nodesDo:
			[:node|
			node isStmtList ifTrue: [stmtLists add: node]]
		unless:
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [aCodeGen isAssertSelector: node selector]]].
	parseTree nodesDo:
		[:node|
		node isSend ifTrue:
			[node selector = #cCode:inSmalltalk: ifTrue:
				[node nodesDo:
					[:ccisNode| stmtLists remove: ccisNode ifAbsent: []]].
			 node selector = #cppIf:ifTrue:ifFalse: ifTrue:
				[node args first nodesDo:
					[:inCondNode| stmtLists remove: inCondNode ifAbsent: []]].
			((node selector = #and:) or: [node selector = #or:]) ifTrue:
				"Note: the PP 2.3 compiler produces two arg nodes for these selectors"
				[stmtLists remove: node args first ifAbsent: [].
				stmtLists remove: node args last ifAbsent: []].
			(#(	#ifTrue: #ifFalse: #ifTrue:ifFalse: #ifFalse:ifTrue:
				#ifNil: #ifNotNil: #ifNil:ifNotNil: #ifNotNil:ifNil: ) includes: node selector) ifTrue:
				[stmtLists remove: node receiver ifAbsent: []].
			(#(whileTrue whileTrue: whilefalse whileFalse:) includes: node selector) ifTrue:
				"Allow inlining if it is a [...] whileTrue/whileFalse.
				This is identified by having more than one statement in the 
				receiver block in which case the C code wouldn't work anyways"
				[node receiver statements size = 1 ifTrue:
					[stmtLists remove: node receiver ifAbsent: []]].
			(node selector = #to:do:) ifTrue:
				[stmtLists remove: node receiver ifAbsent: [].
				stmtLists remove: node args first ifAbsent: []].
			(node selector = #to:by:do:) ifTrue:
				[stmtLists remove: node receiver ifAbsent: [].
				stmtLists remove: node args first ifAbsent: [].
				stmtLists remove: node args second ifAbsent: []]].
		node isCaseStmt ifTrue: "don't inline cases"
			[node cases do: [:case| stmtLists remove: case ifAbsent: []]]].
	^stmtLists! !

!TMethod methodsFor: 'inlining' stamp: 'eem 10/13/2013 17:16'!
superExpansionNodeFor: aSelector args: argumentNodes
	"Answer the expansion of a super send.  Merge the super expansion's
	 locals, properties and comment into this method's properties."
	(definingClass superclass lookupSelector: aSelector)
		ifNil: [self error: 'superclass does not define super method']
		ifNotNil:
			[:superMethod| | superTMethod commonVars varMap |
			superTMethod := superMethod methodNode asTranslationMethodOfClass: self class.
			((argumentNodes allSatisfy: [:parseNode| parseNode isVariableNode])
			and: [(argumentNodes asOrderedCollection collect: [:parseNode| parseNode key]) = superTMethod args]) ifFalse:
				[self error: definingClass name, '>>',selector, ' args ~= ',
							superTMethod definingClass name, '>>', aSelector,
							(String with: $. with: Character cr),
							'For super expansions to be translated correctly each argument must be a variable with the same name as the corresponding argument in the super method.'].
			self mergePropertiesOfSuperMethod: superTMethod.
			(commonVars := superTMethod locals intersection: self locals) notEmpty ifTrue:
				[varMap := Dictionary new.
				 commonVars do:
					[:k| varMap at: k put: (superTMethod unusedNamePrefixedBy: k avoiding: self allLocals)].
				 superTMethod renameVariablesUsing: varMap].
			self assert: (superTMethod locals allSatisfy: [:var| (self locals includes: var) not]).
			locals addAll: superTMethod locals.
			superTMethod declarations keysAndValuesDo:
				[:var :decl|
				self declarationAt: var put: decl].
			superTMethod comment ifNotNil:
				[:superComment|
				comment := comment
								ifNil: [superComment]
								ifNotNil: [superComment, comment]].
			superTMethod extraVariableNumber ifNotNil:
				[:scvn|
				extraVariableNumber := extraVariableNumber ifNil: [scvn] ifNotNil: [:cvn| cvn + scvn]].
			superTMethod elideAnyFinalReturn.
			^superTMethod parseTree]! !

!TMethod methodsFor: 'inlining' stamp: 'dtl 3/10/2014 20:36'!
tryToInlineMethodsIn: aCodeGen
	"Expand any (complete) inline methods called by this method. Set the complete bit when all inlining has been done. Return true if something was inlined."

	| stmtLists didSomething newStatements sendsToInline |
	self definedAsMacro ifTrue:
		[complete := true.
		 ^false].
	didSomething := false.
	sendsToInline := Dictionary new: 100.
	parseTree
		nodesDo:
			[:node|
			(self inlineableFunctionCall: node in: aCodeGen) ifTrue:
				[sendsToInline at: node put: (self inlineFunctionCall: node in: aCodeGen)]]
		unless: "Don't inline the arguments to asserts to keep the asserts readable"
			[:node|
				node isSend
					and: [aCodeGen isAssertSelector: node selector]].

	sendsToInline isEmpty ifFalse:
		[didSomething := true.
		self removeUnreferencedDeclarations.
		parseTree := parseTree replaceNodesIn: sendsToInline].

	didSomething ifTrue:
		[writtenToGlobalVarsCache := nil.
		^didSomething].

	stmtLists := self statementsListsForInliningIn: aCodeGen.
	stmtLists do:
		[:stmtList|
		newStatements := OrderedCollection new: 100.
		stmtList statements do:
			[:stmt|
			(self inlineCodeOrNilForStatement: stmt in: aCodeGen)
				ifNil: [newStatements addLast: stmt]
				ifNotNil: [:inlinedStmts|
					didSomething := true.
					newStatements addAllLast: inlinedStmts]].
		stmtList setStatements: newStatements asArray].

	didSomething ifTrue:
		[writtenToGlobalVarsCache := nil.
		^didSomething].

	complete ifFalse:
		[self checkForCompleteness: stmtLists in: aCodeGen.
		 complete ifTrue: [ didSomething := true ]].  "marking a method complete is progress"
	^didSomething! !

!TMethod methodsFor: 'inlining'!
unusedLabelForInliningInto: targetMethod

	| usedLabels |
	usedLabels := labels asSet.
	usedLabels addAll: targetMethod labels.
	^self unusedNamePrefixedBy: 'l' avoiding: usedLabels! !

!TMethod methodsFor: 'primitive compilation' stamp: 'ar 11/8/2010 18:38'!
argConversionExprFor: varName stackIndex: stackIndex 
	"Return the parse tree for an expression that fetches and converts the 
	primitive argument at the given stack offset."
	| exprList decl stmtList |
	exprList := OrderedCollection new.
	(declarations includesKey: varName) ifTrue:[
		decl := declarations at: varName.
		(decl includes: $*) ifTrue:["array"
			(decl includesSubString: 'char') ifTrue:[ | expr |
				expr := '(interpreterProxy isBytes: (interpreterProxy stackValue: (stackIndex))) ifFalse:[^interpreterProxy primitiveFail].'.
				expr := expr copyReplaceAll: 'interpreterProxy' with: self vmNameString.
				expr := expr copyReplaceAll: 'stackIndex' with: stackIndex printString.
				exprList add: expr.
			].
			exprList add: varName , ' := ', self vmNameString, ' arrayValueOf: (', self vmNameString, ' stackValue: (' , stackIndex printString , '))'.
			exprList add: varName , ' := ' , varName , ' - 1'.
		] ifFalse:["must be a double"
			(decl findString: 'double' startingAt: 1) = 0 ifTrue: [
				self error: 'unsupported type declaration in a primitive method'
			].
			exprList add: varName , ' := ', self vmNameString, ' stackFloatValue: ' , stackIndex printString.
		]
	] ifFalse: ["undeclared variables are taken to be integer"
		exprList add: varName , ' := ', self vmNameString, ' stackIntegerValue: ' , stackIndex printString
	].
	stmtList := OrderedCollection new.
	exprList do: [:e | stmtList addAll: (self statementsFor: e varName: varName)].
	^ stmtList! !

!TMethod methodsFor: 'primitive compilation'!
checkSuccessExpr
	"Return the parse tree for an expression that aborts the primitive if the successFlag is not true."

	| expr |
	expr := 'successFlag ifFalse: [^ nil ]'.
	^ self statementsFor: expr varName: ''
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'jm 2/15/98 16:48'!
covertToZeroBasedArrayReferences
	"Replace the index expressions in at: and at:put: messages with (<expr> - 1), since C uses zero-based array indexing."
	"Note: Up through release 1.31, generated primitives used the convention that array variables pointed to the first element. That meant that Smalltalk one-based index expressions had to have one subtracted to yield a zero-based index. Later, we decided to adjust the base address by -1 once in the primitive prolog rather on every array access. This resulted in a five percent performance increase for the bitmap compress/decompress primitives. This method is retained as documentation and in case we choose to revert the the previous scheme."

	| oldIndexExpr newIndexExpr |
	parseTree nodesDo: [ :n |
		(n isSend and: [(n selector = #at:) or: [ n selector = #at:put: ]]) ifTrue: [
			oldIndexExpr := n args first.
			oldIndexExpr isConstant ifTrue: [
				"index expression is a constant: decrement the constant now"
				newIndexExpr := TConstantNode new setValue: (n args first value - 1).
			] ifFalse: [
				"index expression is complex: build an expression to decrement result at runtime"
				newIndexExpr := TSendNode new
					setSelector: #-
					receiver: oldIndexExpr
					arguments: (Array with: (TConstantNode new setValue: 1)).
			].
			n args at: 1 put: newIndexExpr.
		].
	].
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'ar 4/4/2006 21:15'!
fetchRcvrExpr
	"Return the parse tree for an expression that fetches the receiver from the stack."

	| expr |
	expr := 'rcvr := ', self vmNameString, ' stackValue: (', args size printString, ')'.
	^ self statementsFor: expr varName: ''
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:19'!
fixUpReturns: argCount postlog: postlog
	"Replace each return statement in this method with (a) the given postlog, (b) code to pop the receiver and the given number of arguments, and (c) code to push the integer result and return."

	| newStmts |
	parseTree nodesDo: [:node |
		node isStmtList ifTrue: [
			newStmts := OrderedCollection new: 100.
			node statements do: [:stmt |
				stmt isReturn
					ifTrue: [
						(stmt expression isSend and:
						 ['primitiveFail' = stmt expression selector])
							ifTrue: [  "failure return"
								newStmts addLast: stmt expression.
								newStmts addLast: (TReturnNode new
									setExpression: (TVariableNode new setName: 'null'))]
							ifFalse: [  "normal return"
								newStmts addAll: postlog.
								newStmts addAll: (self popArgsExpr: argCount + 1).
								newStmts addLast: (TSendNode new
									setSelector: #pushInteger:
									receiver: (TVariableNode new setName: self vmNameString)
									arguments: (Array with: stmt expression)).
								newStmts addLast: (TReturnNode new
									setExpression: (TVariableNode new setName: 'null'))]]
					ifFalse: [
						newStmts addLast: stmt]].
			node setStatements: newStmts asArray]].
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'ar 4/4/2006 21:15'!
instVarGetExprFor: varName offset: instIndex
	"Return the parse tree for an expression that fetches and converts the value of the instance variable at the given offset."

	| exprList decl stmtList |
	exprList := OrderedCollection new.
	(declarations includesKey: varName) ifTrue: [
		decl := declarations at: varName.
		(decl includes: $*) ifTrue: [  "array"
			exprList add:
				(varName, ' := ', self vmNameString, ' fetchArray: ', instIndex printString, ' ofObject: rcvr').
			exprList add: (varName, ' := ', varName, ' - 1').
		] ifFalse: [  "must be a double"
			((decl findString: 'double' startingAt: 1) = 0)
				ifTrue: [ self error: 'unsupported type declaration in a primitive method' ].
			exprList add:
				(varName, ' := ', self vmNameString, ' fetchFloat: ', instIndex printString, ' ofObject: rcvr').
		].
	] ifFalse: [  "undeclared variables are taken to be integer"
		exprList add:
			(varName, ' := ', self vmNameString, ' fetchInteger: ', instIndex printString, ' ofObject: rcvr').
	].
	stmtList := OrderedCollection new.
	exprList do: [:e | stmtList addAll: (self statementsFor: e varName: varName)].
	^ stmtList
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:13'!
instVarPutExprFor: varName offset: instIndex
	"Return the parse tree for an expression that saves the value of the integer instance variable at the given offset."

	| expr |
	(declarations includesKey: varName) ifTrue: [
		self error: 'a primitive method can only modify integer instance variables'.
	].
	expr := '', self vmNameString, ' storeInteger: ', instIndex printString, ' ofObject: rcvr withValue: ', varName.
	^ self statementsFor: expr varName: varName
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:13'!
popArgsExpr: argCount
	"Return the parse tree for an expression that pops the given number of arguments from the stack."

	| expr |
	expr := '', self vmNameString, ' pop: ', argCount printString.
	^ self statementsFor: expr varName: ''
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'ar 2/3/2001 17:33'!
preparePrimitiveName
	"Prepare the selector for this method in translation"
	| aClass |
	aClass := definingClass.
	primitive = 117 
		ifTrue:[selector := ((aClass includesSelector: selector)
					ifTrue: [aClass compiledMethodAt: selector]
					ifFalse: [aClass class compiledMethodAt: selector]) literals first at: 2.
				export := true]
		ifFalse:[selector := 'prim', aClass name, selector].

! !

!TMethod methodsFor: 'primitive compilation' stamp: 'eem 4/3/2013 16:10'!
preparePrimitivePrologue
	"Add a prolog and postlog to a primitive method. The prolog copies any instance variables referenced by this primitive method into local variables. The postlog copies values of assigned-to variables back into the instance. The names of the new locals are added to the local variables list.

The declarations dictionary defines the types of any non-integer variables (locals, arguments, or instance variables). In particular, it may specify the types:

	int *		-- an array of 32-bit values (e.g., a BitMap)
	short *		-- an array of 16-bit values (e.g., a SoundBuffer)
	char *		-- an array of unsigned bytes (e.g., a String)
	double		-- a double precision floating point number (e.g., 3.14159)

Undeclared variables are taken to be integers and will be converted from Smalltalk to C ints."

"Current restrictions:
	o method must not contain message sends
	o method must not allocate objects
	o method must not manipulate raw oops
	o method cannot access class variables
	o method can only return an integer"

	| prolog postlog instVarsUsed varsAssignedTo instVarList primArgCount varName endsWithReturn aClass |
	self assert: selector ~~ #setInterpreter:.
	aClass := definingClass.
	prolog := OrderedCollection new.
	postlog := OrderedCollection new.
	instVarsUsed := self freeVariableReferences asSet.
	varsAssignedTo := self variablesAssignedTo asSet.
	instVarList := aClass allInstVarNames.
	primArgCount := args size.

	"add receiver fetch and arg conversions to prolog"
	prolog addAll: self fetchRcvrExpr.
	1 to: args size do: [:argIndex |
		varName := args at: argIndex.
		prolog addAll:
			(self argConversionExprFor: varName stackIndex: args size - argIndex)].

	"add success check to postlog"
	postlog addAll: self checkSuccessExpr.

	"add instance variable fetches to prolog and instance variable stores to postlog"
	1 to: instVarList size do: [:varIndex |
		varName := instVarList at: varIndex.
		(instVarsUsed includes: varName) ifTrue: [
			locals add: varName.
			prolog addAll: (self instVarGetExprFor: varName offset: varIndex - 1).
			(varsAssignedTo includes: varName) ifTrue: [
				postlog addAll: (self instVarPutExprFor: varName offset: varIndex - 1)]]].
	prolog addAll: self checkSuccessExpr.

	((locals includes: 'rcvr') or: [(locals intersection: args) notEmpty]) ifTrue:
		[self error: 'local name conflicts with instance variable name'].
	locals add: 'rcvr'; addAll: args.
	args := args class new.
	endsWithReturn := self endsWithReturn.
	self fixUpReturns: primArgCount postlog: postlog.

	endsWithReturn
		ifTrue: [parseTree setStatements: prolog, parseTree statements]
		ifFalse: [
			postlog addAll: (self popArgsExpr: primArgCount).
			parseTree setStatements: prolog, parseTree statements, postlog].
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 19:08'!
replaceSizeMessages
	"Replace sends of the message 'size' with calls to sizeOfSTArrayFromCPrimitive."

	| argExpr |
	parseTree nodesDo: [:n |
		(n isSend and: [n selector = #size]) ifTrue: [
			argExpr := TSendNode new
				setSelector: #+
				receiver: n receiver
				arguments: (Array with: (TConstantNode new setValue: 1)).
			n
				setSelector: #sizeOfSTArrayFromCPrimitive:
				receiver: (TVariableNode new setName: self vmNameString)
				arguments: (Array with: argExpr)]].
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'TPR 2/29/2000 18:47'!
statementsFor: sourceText varName: varName
	"Return the parse tree for the given expression. The result is the statements list of the method parsed from the given source text."
	"Details: Various variables are declared as locals to avoid Undeclared warnings from the parser."

	| s |
	s := WriteStream on: ''.
	s nextPutAll: 'temp'; cr; cr; tab.
	self printTempsAndVar: varName on: s.
	s nextPutAll: sourceText.
	^ ((Compiler new parse: s contents in: Object notifying: nil)
			asTranslationMethodOfClass: self class) statements
! !

!TMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:08'!
vmNameString
	"return the string to use as the vm name in code generated for this method"
	^'self'! !

!TMethod methodsFor: 'accessing' stamp: 'asf 9/29/2014 11:45'!
argTypes
	"Get the types of the parameters of this method"

	^args collect: [ :a | self declarationAt: a ]! !

!TMethod methodsFor: 'accessing'!
args
	"The arguments of this method."

	^args! !

!TMethod methodsFor: 'accessing' stamp: 'eem 3/3/2009 08:59'!
declarationAt: aVariableName
	^declarations at: aVariableName ifAbsent: [#sqInt, ' ', aVariableName]! !

!TMethod methodsFor: 'accessing' stamp: 'eem 3/3/2009 08:42'!
declarationAt: aVariableName  "<String>" put: aDeclaration "<String>" "^aDeclaration"
	^declarations at: aVariableName put: aDeclaration! !

!TMethod methodsFor: 'accessing'!
declarations
	"The type declaration dictionary of this method."

	^declarations! !

!TMethod methodsFor: 'accessing' stamp: 'ar 2/3/2001 17:29'!
definingClass
	^definingClass! !

!TMethod methodsFor: 'accessing' stamp: 'ar 2/3/2001 17:29'!
definingClass: aClass
	definingClass := aClass.! !

!TMethod methodsFor: 'accessing' stamp: 'jm 11/24/1998 09:03'!
export

	^ export
! !

!TMethod methodsFor: 'accessing' stamp: 'jm 11/24/1998 09:03'!
globalStructureBuildMethodHasFoo
	^globalStructureBuildMethodHasFoo! !

!TMethod methodsFor: 'accessing'!
globalStructureBuildMethodHasFoo: number
	globalStructureBuildMethodHasFoo := number! !

!TMethod methodsFor: 'accessing'!
isComplete
	"A method is 'complete' if it does not contain any more inline-able calls."

	^complete! !

!TMethod methodsFor: 'accessing' stamp: 'dtl 8/21/2011 17:43'!
isStaticIn: aCodeGen
	"If static has been explicitly set, honor that setting. Otherwise defer
	to the code generator for a default setting."
	^static ifNil: [aCodeGen declareMethodsStatic]! !

!TMethod methodsFor: 'accessing' stamp: 'ar 5/9/2000 12:13'!
labels

	^labels! !

!TMethod methodsFor: 'accessing' stamp: 'ar 5/9/2000 12:13'!
locals
	"The local variables of this method."

	^locals! !

!TMethod methodsFor: 'accessing'!
parseTree
	"The parse tree of this method."

	^parseTree! !

!TMethod methodsFor: 'accessing'!
parseTree: aNode
	"Set the parse tree of this method."

	parseTree := aNode.! !

!TMethod methodsFor: 'accessing' stamp: 'jm 2/12/98 11:56'!
primitive
	"The primitive number of this method; zero if not a primitive."

	^ primitive
! !

!TMethod methodsFor: 'accessing'!
referencesGlobalStructIncrementBy: value
	globalStructureBuildMethodHasFoo := globalStructureBuildMethodHasFoo + value.! !

!TMethod methodsFor: 'accessing'!
referencesGlobalStructMakeZero
	globalStructureBuildMethodHasFoo := 0! !

!TMethod methodsFor: 'accessing'!
returnType
	"The type of the values returned by this method. This string will be used in the C declaration of this function."

	^returnType! !

!TMethod methodsFor: 'accessing' stamp: 'eem 8/1/2008 10:34'!
returnType: aString
	"Set the type of the values returned by this method. This string will be used in the C declaration of this function."

	returnType := aString! !

!TMethod methodsFor: 'accessing'!
selector
	"The Smalltalk selector of this method."

	^selector! !

!TMethod methodsFor: 'accessing'!
selector: newSelector

	selector := newSelector.! !

!TMethod methodsFor: 'accessing' stamp: 'dtl 12/21/2008 14:55'!
selectorForCodeGeneration
	"Subclasses may allow a directive to override the selector specification."

	^ selector! !

!TMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:18'!
sharedCase
	^sharedCase! !

!TMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:41'!
sharedCase: aNumber
	sharedCase := aNumber.! !

!TMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:18'!
sharedLabel
	^sharedLabel! !

!TMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:40'!
sharedLabel: aString
	sharedLabel := aString! !

!TMethod methodsFor: 'accessing'!
statements

	parseTree isStmtList
		ifFalse: [ self error: 'expected method parse tree to be a TStmtListNode' ].
	((parseTree args = nil) or: [parseTree args isEmpty])
		ifFalse: [ self error: 'expected method parse tree to have no args' ].

	^parseTree statements! !

!TMethod methodsFor: 'accessing' stamp: 'eem 2/10/2009 13:53'!
static: aBoolean
	static := aBoolean! !

!TMethod methodsFor: 'transformations' stamp: 'ar 7/6/2003 20:09'!
asInlineNode
	^TInlineNode new method: self! !

!TMethod methodsFor: 'transformations'!
bindClassVariablesIn: constantDictionary
	"Class variables are used as constants. This method replaces all references to class variables in the body of this method with the corresponding constant looked up in the class pool dictionary of the source class. The source class class variables should be initialized before this method is called."

	parseTree := parseTree bindVariablesIn: constantDictionary.! !

!TMethod methodsFor: 'transformations' stamp: 'ar 7/6/2003 20:35'!
bindVariableUsesIn: aDictionary
	parseTree := parseTree bindVariableUsesIn: aDictionary.! !

!TMethod methodsFor: 'transformations' stamp: 'ar 11/19/1999 14:40'!
buildCaseStmt: aSendNode
	"Build a case statement node for the given send of dispatchOn:in:."
	"Note: the first argument is the variable to be dispatched on. The second argument is a constant node holding an array of unary selectors, which will be turned into sends to self."

	((aSendNode args size >= 2) and:
	 [aSendNode args second isConstant and:
	 [aSendNode args second value class = Array]]) ifFalse: [
		self error: 'wrong node structure for a case statement'.
	].

	^TCaseStmtNode new
		setExpression: aSendNode args first
		selectors: aSendNode args second value
		arguments: (aSendNode args copyFrom: 3 to: aSendNode args size)! !

!TMethod methodsFor: 'transformations' stamp: 'eem 10/13/2013 17:46'!
buildSwitchStmt: aSendNode parent: parentNode
	"Build a switch statement node for the given send of caseOf: or caseOf:otherwise:."
	| switch |
	switch := TSwitchStmtNode new
				expression: aSendNode receiver
				cases: aSendNode args first
				otherwiseOrNil: (aSendNode args at: 2 ifAbsent: [nil]).
	(aSendNode receiver isVariable or: [parentNode isStmtList]) ifFalse:
		[switch switchVariable: (locals add: (self extraVariableName: 'switch'))].
	^switch! !

!TMethod methodsFor: 'transformations' stamp: 'eem 12/15/2008 09:52'!
extractDirective: theSelector valueBlock: aBlock default: defaultResult
	"Find a pragma of the form:

		<theSelector[args]>

	 Answer the result of evaluating aBock with a TSendNode corresponding
	 to the pragma node, or defaultResult if there is no matching pragma."

	| result found newStatements |
	(properties at: theSelector ifAbsent: []) ifNotNil:
		[:pragma|
		^aBlock value: (TSendNode new
							setSelector: pragma keyword
							receiver: (TVariableNode new setName: 'self')
							arguments: (pragma arguments collect: [:const| TConstantNode new setValue: const]))].
	"Pre-pragma backward compatibility:
	 Scan the top-level statements for a labelling directive of the form:

		self theSelector[args]

	 and remove the directive from the method body if found.
	 Answer the result of evaluating aBock with the send node,
	  or defaultResult if there is no labelling directive."	result := defaultResult.
	found := false.
	newStatements := OrderedCollection new: parseTree statements size.
	parseTree statements do:
		[ :stmt |
		(stmt isSend
		 and: [stmt selector = theSelector])
			ifTrue:
				[found := true.
				 result := aBlock value: stmt]
			ifFalse:
				[newStatements add: stmt]].
	^found
		ifTrue:
			[parseTree setStatements: newStatements asArray.
			 result]
		ifFalse: [defaultResult]! !

!TMethod methodsFor: 'transformations' stamp: 'eem 9/20/2008 18:26'!
extractExpandCaseDirective
	"Scan the top-level statements for an inlining directive of the form:
		self expandCases
	 and remove the directive from the method body. Answer whether
	 there was such a directive."

	^self
		extractDirective: #expandCases
		valueBlock: [:sendNode| true]
		default: false! !

!TMethod methodsFor: 'transformations' stamp: 'dtl 9/19/2010 12:19'!
extractExportDirective
	"Scan the top-level statements for an inlining directive of the form:

		self export: <boolean>

	 and remove the directive from the method body. Return the argument of the directive or false if there is no export directive."

	| result newStatements methodDirectiveFound |
	result := false.
	methodDirectiveFound := false.
	newStatements := OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		(stmt isSend and: [stmt selector = #export:]) ifTrue: [
			methodDirectiveFound := true.
			result := stmt args first value = true.
		] ifFalse: [
			newStatements add: stmt.
		].
	].
	parseTree setStatements: newStatements asArray.
	methodDirectiveFound ifTrue: [^ result].
	"no method declaration was used, so check for a pragma declaration"
	^self
		extractDirective: #export:
		valueBlock: [:sendNode| sendNode args first value ~= false]
		default: false
! !

!TMethod methodsFor: 'transformations' stamp: 'eem 11/18/2008 12:44'!
extractLabelDirective
	"Scan the top-level statements for an inlining directive of the form:

		self asmLabel: <boolean>

	 and remove the directive from the method body. Answer the
	 argument of the directive or true if there is no export directive."

	^self
		extractDirective: #asmLabel:
		valueBlock: [:sendNode| sendNode args first value ~= false and: [mustAsmLabel := true. true]]
		default: true! !

!TMethod methodsFor: 'transformations' stamp: 'ar 7/7/2003 00:56'!
extractSharedCase
	"Scan the top-level statements for an shared case directive of the form:

		self sharedCodeNamed: <sharedLabel> inCase: <sharedCase>.

	and remove the directive from the method body."

	| newStatements |
	newStatements := OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		(stmt isSend and: [stmt selector = #sharedCodeNamed:inCase:]) ifTrue: [
			sharedLabel := stmt args first value.
			sharedCase := stmt args last value
		] ifFalse: [
			newStatements add: stmt.
		].
	].
	parseTree setStatements: newStatements asArray.
	sharedCase ifNotNil:[
		args isEmpty ifFalse:[self error: 'Cannot share code sections in methods with arguments'].
	].! !

!TMethod methodsFor: 'transformations' stamp: 'dtl 7/4/2012 10:58'!
extractStaticDirective
	"Scan the top-level statements for an inlining directive of the form:

		self static: <boolean>

	and remove the directive from the method body. Answer the argument of the
	directive. If there is no static directive, answer true if this is an api method,
	otherwise answer nil for undefined. The code generator may determine the
	static declaration when undefined."

	^self
		extractDirective: #static:
		valueBlock: [:sendNode| sendNode args first value ~= false]
		default: (((properties includesKey: #api) or: [properties includesKey: #api:])
					ifTrue: [false] "api methods cannot be declared static"
					ifFalse: [nil]) "undefined, defer to the code generator for default"! !

!TMethod methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:38'!
mapReceiversIn: aDictionary
	parseTree mapReceiversIn: aDictionary.! !

!TMethod methodsFor: 'transformations' stamp: 'dtl 1/15/2014 21:55'!
prepareMethodIn: aCodeGen
	"Record sends of builtin operators, map sends of the special selector dispatchOn:in:
	 with case statement nodes, and map sends of caseOf:[otherwise:] to switch statements.
	 As a hack also update the types of variables introduced to implement cascades correctly.
	 This has to be done at the same time as this is done, so why not piggy back here?"
	extraVariableNumber ifNotNil:
		[declarations keysAndValuesDo:
			[:varName :decl|
			decl isBlock ifTrue:
				[self assert: ((varName beginsWith: 'cascade') and: [varName last isDigit]).
				 locals add: varName.
				 self declarationAt: varName
					put: (decl value: self value: aCodeGen), ' ', varName]]].
	aCodeGen
		pushScope: declarations
		while:"N.B.  nodesWithParentsDo: is bottom-up, hence replacement is destructive and conserved."
			[parseTree nodesWithParentsDo:
				[:node :parent|
				 node isSend ifTrue:
					[(aCodeGen isBuiltinSelector: node selector)
						ifTrue:
							[node isBuiltinOperator: true.
							"If a to:by:do:'s limit has side-effects, declare the limit variable, otherwise delete it from the args"
							 (node selector = #to:by:do:
							  and: [node args size = 4]) ifTrue:
								[| limitExpr |
								 limitExpr := node args first.
								 (limitExpr anySatisfy:
										[:subNode|
										subNode isSend
										and: [(aCodeGen isBuiltinSelector: subNode selector) not
										and: [(subNode isStructSendIn: aCodeGen) not]]])
									ifTrue: [ | limitVar |
										limitVar := node args last name.
										"n.b. Two loops in the same method may share the same variable
										for loop limit, so add the variable declaration only if not already
										declared by a previous loop. Assumes that the name of the loop
										limit variable (e.g. 'iLimiT') is unlikely to have been used as an actual
										instance variable elsewhere." 
										(locals includes: limitVar) ifFalse: [locals add: limitVar]]
									ifFalse:
										[node arguments: node args allButLast]]]
						ifFalse:
							[(CaseStatements includes: node selector) ifTrue:
								[parent replaceNodesIn: (Dictionary newFromPairs: { node. self buildCaseStmt: node})].
							 (#(caseOf: #caseOf:otherwise:) includes: node selector) ifTrue:
								[parent replaceNodesIn: (Dictionary newFromPairs: { node. self buildSwitchStmt: node parent: parent })]]]]]! !

!TMethod methodsFor: 'transformations' stamp: 'dtl 9/19/2010 17:26'!
recordDeclarations
	"Record C type declarations of the forms

		self returnTypeC: 'float'.
		self var: #foo declareC: 'float foo'
		self var: #foo type:'float'.

	 and remove the declarations from the method body."

	| newStatements |
	properties pragmas notEmpty ifTrue:
		[properties pragmas do:
			[:pragma|
			pragma keyword = #var:declareC: ifTrue:
				[self declarationAt: pragma arguments first asString put: pragma arguments last].
			pragma keyword = #var:type: ifTrue:
				[| varName varType |
				varName := pragma arguments first asString.
				varType := pragma arguments last.
				varType last = $* ifFalse: [varType := varType, ' '].
				self declarationAt: varName put: varType, varName].
			pragma keyword = #returnTypeC: ifTrue:
				[returnType := pragma arguments last].
			pragma keyword = #doNotGenerate: ifTrue:
				[locals remove: pragma arguments last]]].
	newStatements := OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		| isDeclaration |
		isDeclaration := false.
		stmt isSend ifTrue: [
			stmt selector = #var:declareC: ifTrue: [
				isDeclaration := true.
				self declarationAt: stmt args first value asString put: stmt args last value.
			].
			stmt selector = #var:type: ifTrue: [
				| varName varType |
				isDeclaration := true.
				varName := stmt args first value asString.
				varType := stmt args last value.
				varType last = $* ifFalse: [varType := varType, ' '].
				self declarationAt: varName put: varType, varName.
			].
			stmt selector = #returnTypeC: ifTrue: [
				isDeclaration := true.
				returnType := stmt args last value.
			].
		].
		isDeclaration ifFalse: [
			newStatements add: stmt.
		].
	].
	parseTree setStatements: newStatements asArray.! !

!TMethod methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	parseTree removeAssertions! !

!TMethod methodsFor: 'transformations' stamp: 'jm 12/14/1998 08:35'!
removeFinalSelfReturn
	"The Smalltalk parser automatically adds the statement '^self' to the end of methods without explicit returns. This method removes such statements, since the generated code has no notion of 'self' anyway."

	| stmtList lastStmt |
	stmtList := parseTree statements asOrderedCollection.
	lastStmt := stmtList last.

	((lastStmt isReturn) and:
	 [(lastStmt expression isVariable) and:
	 ['self' = lastStmt expression name]]) ifTrue: [
		stmtList removeLast.
		parseTree setStatements: stmtList.
	].! !

!TMethod methodsFor: 'transformations' stamp: 'dtl 8/20/2011 14:28'!
renameSelector: selectorName as: newSelectorName
	"Rename selectors such that generated code will use the newSelectorName. This
	is intended to allow methods that may have default implementations in the support
	code to be renamed for code generation, such that the renamed versions will
	be referenced rather than the default platform implementations. For example,
	if #pointerForOop: is implemented in Smalltalk, it may be renamed such that
	the generated pointerForOop() function will be renamed to avoid conflict with
	the standard definitions provided in sqMemoryAccess.h."

	selector = selectorName
		ifTrue: [selector := newSelectorName].
	parseTree nodesDo: [:node |
			node
				renameSelector: selectorName
				as: newSelectorName ]
! !

!TMethod methodsFor: 'transformations' stamp: 'ar 7/6/2003 21:31'!
replaceNodesIn: map
	parseTree := parseTree replaceNodesIn: map.! !

!TMethod methodsFor: 'copying' stamp: 'ar 7/6/2003 21:40'!
copy
	"Make a deep copy of this TMethod."

	^ (self class basicNew)
		setSelector: selector
		returnType: returnType
		args: args copy
		locals: locals copy
		declarations: declarations copy
		primitive: primitive
		parseTree: parseTree copyTree
		labels: labels copy
		complete: complete;
		sharedLabel: sharedLabel;
		sharedCase: sharedCase;
		yourself
! !

!TMethod methodsFor: 'testing' stamp: 'eem 2/11/2009 09:11'!
definedAsMacro
	^properties notNil
	  and: [properties includesKey: #cmacro:]! !

!TMethod methodsFor: 'testing' stamp: 'eem 8/8/2008 12:02'!
endsWithReturn
	"Answer true if the last statement of this method is a return."

	^parseTree endsWithReturn! !

!TMethod methodsFor: 'testing'!
hasReturn
	"Answer true if this method contains a return statement."

	parseTree nodesDo: [ :n | n isReturn ifTrue: [ ^ true ]].
	^ false! !

!TMethod methodsFor: 'testing' stamp: 'ikp 9/26/97 14:50'!
isAssertion
	^(selector beginsWith: 'assert') or: [selector beginsWith: 'verify']! !

!TMethod methodsFor: 'testing' stamp: 'eem 2/11/2009 21:20'!
isStructAccessor
	^[definingClass isAccessor: selector]
		on: MessageNotUnderstood
		do: [:ex| false]! !

!TMethod methodsFor: 'C code generation' stamp: 'asf 9/30/2014 20:19'!
emitCCodeOn: aStream generator: aCodeGen
	"Emit C code for this method onto the given stream. All calls to inlined methods should already have been expanded."

	aCodeGen currentMethod: self.
	self emitCCommentOn: aStream.	"place method comment before function"
	self emitCHeaderOn: aStream generator: aCodeGen.
	parseTree emitCCodeOn: aStream level: 1 generator: aCodeGen.
	"Ensure code is POSIX compliant"
	(self returnType = #void or: [self endsWithReturn]) ifFalse: [aStream tab: 1; nextPutAll: 'return null;'; cr].
	aStream nextPutAll: '}'; cr.! !

!TMethod methodsFor: 'C code generation' stamp: 'hg 8/14/2000 16:09'!
emitCCommentOn: aStream
	"Emit the transferred Smalltalk comments as C comments."

	comment ifNotNil: [
		aStream cr;cr.
		1 to: comment size do: [:index | 
			aStream 
				nextPutAll: '/*'; tab;
				nextPutAll: (comment at: index);
				nextPutAll: ' */';
				cr]]! !

!TMethod methodsFor: 'C code generation' stamp: 'eem 2/12/2009 12:29'!
emitCFunctionPrototype: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	properties ifNotNil:
		[(properties at: #api: ifAbsent: []) ifNotNil:
			[:pragma|
			aStream nextPutAll: (pragma argumentAt: 1).
			^self]].
	self emitCFunctionPrototype: aStream generator: aCodeGen newlineBeforeName: false! !

!TMethod methodsFor: 'C code generation' stamp: 'dtl 7/4/2012 10:22'!
emitCFunctionPrototype: aStream generator: aCodeGen newlineBeforeName: newlineBeforeName "<Boolean>"
	"Emit a C function header for this method onto the given stream."

	export 
		ifTrue:[aStream nextPutAll: 'EXPORT('; nextPutAll: returnType; nextPut: $)]
		ifFalse:[(self isStaticIn: aCodeGen) ifTrue:[aStream nextPutAll: 'static '].
				aStream nextPutAll: returnType].
	newlineBeforeName ifTrue: [aStream cr] ifFalse: [aStream space].
	(returnType last = $)
	and: [returnType includesSubString: (aCodeGen cFunctionNameFor: self selectorForCodeGeneration)]) ifTrue:
		["Hack fix for e.g. <returnTypeC: 'void (*setInterruptCheckChain(void (*aFunction)(void)))()'>"
		 ^self].
	aStream
		nextPutAll: (aCodeGen cFunctionNameFor: self selectorForCodeGeneration);
		nextPut: $(.
	args isEmpty
		ifTrue: [aStream nextPutAll: #void]
		ifFalse:
			[args
				do: [:arg| aStream nextPutAll: (self declarationAt: arg)]
				separatedBy: [ aStream nextPutAll: ', ' ]].
	aStream nextPut: $)! !

!TMethod methodsFor: 'C code generation' stamp: 'ikp 6/9/2004 16:15'!
emitCHeaderOn: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	aStream cr. 
	self emitCFunctionPrototype: aStream generator: aCodeGen.
	aStream nextPutAll: ' {'; cr.
	self emitGlobalStructReferenceOn: aStream.
	locals do: [ :var |
		aStream nextPutAll: '    '.
		aStream nextPutAll: (declarations at: var ifAbsent: [ 'sqInt ', var]), ';'; cr.
	].
	locals isEmpty ifFalse: [ aStream cr ].! !

!TMethod methodsFor: 'C code generation'!
emitGlobalStructReferenceOn: aStream
	"Add a reference to the globals struct if needed"

	(self globalStructureBuildMethodHasFoo > 1)
		ifTrue: [aStream nextPutAll: 'register struct foo * foo = &fum;'; cr].
! !

!TMethod methodsFor: 'C code generation' stamp: 'ikp 6/9/2004 16:15'!
emitInlineOn: aStream level: level generator: aCodeGen
	"Emit C code for this method onto the given stream. All calls to inlined methods should already have been expanded."
	self removeUnusedTemps.
	sharedLabel ifNotNil:[
		aStream crtab: level-1; nextPutAll: sharedLabel; nextPutAll:':'.
		aStream crtab: level.
		aStream nextPutAll: '/* '; nextPutAll: selector; nextPutAll: ' */'.
		aStream crtab: level.
	].
	aStream nextPutAll:'{'; cr.
	locals do: [ :var |
		aStream tab: level+1.
		aStream nextPutAll: (declarations at: var ifAbsent: [ 'sqInt ', var]), ';'; cr.
	].
	parseTree emitCCodeOn: aStream level: level+1 generator: aCodeGen.
	aStream tab: level; nextPutAll: '}'; cr.! !

!TMethod methodsFor: 'C code generation' stamp: 'dtl 2/3/2007 11:03'!
emitProxyFunctionPrototype: aStream generator: aCodeGen
	"Emit an indirect C function header for this method onto the given stream."

	| arg |
	aStream nextPutAll: returnType; space.
	aStream nextPutAll: '(*', (aCodeGen cFunctionNameFor: self selectorForCodeGeneration), ')('.
	args isEmpty ifTrue: [ aStream nextPutAll: 'void' ].
	1 to: args size do: [ :i |
		arg := args at: i.
		(declarations includesKey: arg) ifTrue: [
			aStream nextPutAll: (declarations at: arg).
		] ifFalse: [
			aStream nextPutAll: 'sqInt ', (args at: i).
		].
		i < args size ifTrue: [ aStream nextPutAll: ', ' ].
	].
	aStream nextPutAll: ')'.! !

!TMethod methodsFor: 'initialization' stamp: 'eem 10/2/2009 12:01'!
newCascadeTempFor: aTParseNode
	| varNode |
	cascadeVariableNumber := cascadeVariableNumber
								ifNil: [0]
								ifNotNil: [cascadeVariableNumber + 1].
	varNode := TVariableNode new setName: 'cascade', cascadeVariableNumber printString.
	aTParseNode isLeaf ifFalse:
		[declarations
			at: varNode name
			put: [:cg| self determineTypeFor: aTParseNode in: cg]].
	^varNode! !

!TMethod methodsFor: 'initialization' stamp: 'dtl 9/19/2010 14:58'!
setSelector: sel definingClass: class args: argList locals: localList block: aBlockNode primitive: aNumber properties: methodProperties comment: aComment
	"Initialize this method using the given information."

	selector := sel.
	definingClass := class.
	returnType := #sqInt. 	 "assume return type is long for now"
	args := argList asOrderedCollection collect: [:arg | arg key].
	locals := (localList asSortedCollection: [:a :b| a key < b key]) collect: [:arg | arg key].
	declarations := Dictionary new.
	"self addTypeForSelf." "<- Cog feature to be added later"
	primitive := aNumber.
	properties := methodProperties.
	comment := aComment.
	parseTree := aBlockNode asTranslatorNodeIn: self.
	labels := OrderedCollection new.
	complete := false.  "set to true when all possible inlining has been done"
	export := self extractExportDirective.
	static := self extractStaticDirective.
	canAsmLabel := self extractLabelDirective.
	self extractSharedCase.
	self removeFinalSelfReturn.	"must preceed recordDeclarations because this may set returnType"
	self recordDeclarations.
	globalStructureBuildMethodHasFoo := 0! !

!TMethod methodsFor: 'initialization' stamp: 'jm 2/12/98 11:55'!
setSelector: sel returnType: retType args: argList locals: localList declarations: decls primitive: primNumber parseTree: aNode labels: labelList complete: completeFlag
	"Initialize this method using the given information. Used for copying."

	selector := sel.
	returnType := retType.
	args := argList.
	locals := localList.
	declarations := decls.
	primitive := primNumber.
	parseTree := aNode.
	labels := labelList.
	complete := completeFlag.! !

!TMethod methodsFor: 'private' stamp: 'TPR 2/29/2000 18:45'!
printTempsAndVar: varName on: aStream 
	"add the required temps and the varname to the stream"
	aStream nextPutAll: '| rcvr stackPointer successFlag ' , varName , ' |';
	 cr! !

!TMethod class methodsFor: 'class initialization' stamp: 'ar 11/18/1999 20:06'!
initialize
	"TMethod initialize"	
	CaseStatements := IdentitySet new: 10.
	CaseStatements addAll: #(dispatchOn:in: dispatchOn:in:with: dispatchOn:in:with:with:).! !

!TParseNode methodsFor: 'utilities' stamp: 'eem 12/12/2012 12:15'!
allCalls
	"Answer a collection of selectors for the messages sent in this parse tree."

	| calls |
	calls := Set new: 32.
	self nodesDo:
		[:node|
		node isSend ifTrue:
			[calls add: node selector].
		(node isConstant and: [node value isSymbol]) ifTrue:
			[calls add: node value]].
	^calls! !

!TParseNode methodsFor: 'utilities'!
nodeCount
	"Answer the number of nodes in this parseTree (a rough measure of its size)."

	| cnt |
	cnt := 0.
	self nodesDo: [ :n | cnt := cnt + 1 ].
	^cnt! !

!TParseNode methodsFor: 'enumerating' stamp: 'eem 3/29/2013 16:58'!
anySatisfy: aBlock
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^true]].
	^false! !

!TParseNode methodsFor: 'enumerating'!
nodesDo: aBlock

	aBlock value: self.! !

!TParseNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:01'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	self subclassResponsibility! !

!TParseNode methodsFor: 'enumerating' stamp: 'eem 8/1/2013 11:02'!
nodesDo: aBlock unless: cautionaryBlock
	"Evaluate aBlock for all nodes in  the tree except those for which cautionaryBlock
	 answers true or are children of those for which cautionaryBlock answers true."
	(cautionaryBlock value: self) ifFalse:
		[aBlock value: self]! !

!TParseNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:01'!
nodesWithParentsDo: aBlock
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	self nodesDo: aBlock parent: nil! !

!TParseNode methodsFor: 'enumerating' stamp: 'eem 3/29/2013 16:58'!
noneSatisfy: aBlock
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^false]].
	^true! !

!TParseNode methodsFor: 'converting' stamp: 'dtl 10/28/2006 18:50'!
asExpression
	"Sender expects to use this node as a simple expression rather than as as statement"

	^self! !

!TParseNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:13'!
bindVariableUsesIn: aDictionary
	"Bind uses of all variables in the given dictionary, but do not change variables that appear on the left-hand-side of an assignment statement."

	^ self
! !

!TParseNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	^self! !

!TParseNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 14:43'!
mapReceiversIn: aDictionary
	^self! !

!TParseNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	"default: do nothing"! !

!TParseNode methodsFor: 'transformations' stamp: 'dtl 8/20/2011 13:48'!
renameSelector: selectorName as: newSelectorName
	"Rename selectors such that generated code will use the newSelectorName. This
	is intended to allow methods that may have default implementations in the support
	code to be renamed for code generation, such that the renamed versions will
	be referenced rather than the default platform implementations. For example,
	if #pointerForOop: is implemented in Smalltalk, it may be renamed such that
	the generated pointerForOop() function will be renamed to avoid conflict with
	the standard definitions provided in sqMemoryAccess.h."! !

!TParseNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [self]! !

!TParseNode methodsFor: 'accessing' stamp: 'acg 12/17/1999 07:21'!
nameOrValue

	self error: 'object is neither variable nor constant'! !

!TParseNode methodsFor: 'as yet unclassified' stamp: 'nk 4/5/2005 21:01'!
copyTree
	self subclassResponsibility.! !

!TParseNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	self! !

!TParseNode methodsFor: 'as yet unclassified' stamp: 'dtl 10/24/2006 21:56'!
isDirective
	"Preprocessor directive, e.g. a cpp macro"

	^false! !

!TParseNode methodsFor: 'as yet unclassified' stamp: 'JMM 11/23/2002 23:25'!
nodesVarCheckDo: aBlock

	aBlock value: self.! !

!TParseNode methodsFor: 'as yet unclassified' stamp: 'dtl 3/20/2005 14:23'!
requiresCLineTerminator

	^ self isComment not
! !

!TParseNode methodsFor: 'C code generation' stamp: ' 2/7/08 14:57'!
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	^self emitCCodeOn: aStream level: level generator: aCodeGen! !

!TParseNode methodsFor: 'C code generation' stamp: ' 2/7/08 14:57'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitCCodeOn: aStream level: level generator: aCodeGen! !

!TParseNode methodsFor: 'C code generation' stamp: 'nk 4/5/2005 21:02'!
emitCCodeOn: aStream level: lev generator: gen
	self subclassResponsibility.! !

!TParseNode methodsFor: 'C code generation' stamp: 'hg 8/14/2000 16:13'!
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

!TParseNode methodsFor: 'testing' stamp: 'eem 2/11/2009 15:24'!
endsWithReturn

	^false! !

!TParseNode methodsFor: 'testing'!
hasExplicitReturn

	self nodesDo: [ :node |
		node isReturn ifTrue: [ ^true ].
	].
	^false! !

!TParseNode methodsFor: 'testing' stamp: 'ikp 9/26/97 14:50'!
isAssertion
	^false! !

!TParseNode methodsFor: 'testing' stamp: 'ikp 9/26/97 14:50'!
isAssignment

	^false! !

!TParseNode methodsFor: 'testing'!
isCaseStmt

	^false! !

!TParseNode methodsFor: 'testing'!
isComment

	^false! !

!TParseNode methodsFor: 'testing'!
isConstant

	^false! !

!TParseNode methodsFor: 'testing'!
isGoTo

	^false! !

!TParseNode methodsFor: 'testing' stamp: 'eem 7/8/2008 19:57'!
isInline
	^false! !

!TParseNode methodsFor: 'testing'!
isLabel

	^false! !

!TParseNode methodsFor: 'testing'!
isLeaf
	"Answer true if the receiver is a variable or a constant node."

	^false! !

!TParseNode methodsFor: 'testing' stamp: 'eem 2/24/2009 14:48'!
isPreprocessorDirective
	^false! !

!TParseNode methodsFor: 'testing'!
isReturn

	^false! !

!TParseNode methodsFor: 'testing' stamp: 'eem 8/8/2008 11:57'!
isReturningIf
	^false! !

!TParseNode methodsFor: 'testing'!
isSend

	^false! !

!TParseNode methodsFor: 'testing'!
isStmtList

	^false! !

!TParseNode methodsFor: 'testing' stamp: 'eem 2/10/2009 07:58'!
isSwitch
	^false! !

!TParseNode methodsFor: 'testing' stamp: 'eem 2/11/2009 17:12'!
isTParseNode
	^true! !

!TParseNode methodsFor: 'testing' stamp: 'eem 12/11/2010 12:25'!
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^nil! !

!TParseNode methodsFor: 'testing' stamp: 'eem 10/24/2013 13:02'!
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^nil! !

!TParseNode methodsFor: 'printing'!
printOn: aStream level: anInteger 
	"Typically overridden. If control actually gets here, avoid recursion loop by sending to super."

	super printOn: aStream.! !

!TAssignmentNode methodsFor: 'transformations' stamp: 'mn 6/30/2000 13:19'!
bindVariableUsesIn: aDictionary
	"Do NOT bind the variable on the left-hand-side of an assignment statement."
	"was bindVariablesIn:"
	expression := expression bindVariableUsesIn: aDictionary.
! !

!TAssignmentNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	variable := variable bindVariablesIn: aDictionary.
	expression := expression bindVariablesIn: aDictionary.! !

!TAssignmentNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 20:00'!
mapReceiversIn: aDictionary
	expression mapReceiversIn: aDictionary
! !

!TAssignmentNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions

	expression removeAssertions! !

!TAssignmentNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		variable := variable replaceNodesIn: aDictionary.
		expression := expression replaceNodesIn: aDictionary.
		self]! !

!TAssignmentNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setVariable: variable copyTree
		expression: expression copyTree! !

!TAssignmentNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	variable inlineMethodsUsing: aDictionary.
	expression inlineMethodsUsing: aDictionary.! !

!TAssignmentNode methodsFor: 'C code generation' stamp: 'eem 6/28/2011 10:57'!
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	aStream nextPut: $(.
	self emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPut: $)! !

!TAssignmentNode methodsFor: 'C code generation' stamp: ' 2/7/08 14:57'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	aStream nextPut: $(.
	self emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPut: $)! !

!TAssignmentNode methodsFor: 'C code generation' stamp: 'asf 10/14/2014 18:53'!
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
			 vartype := aCodeGen typeOfVariable: variable name.
			 vartype := aCodeGen declToType: vartype.
			 ((expression isMemberOf: TSendNode) and: [vartype ~= nil])
				ifTrue:
					[| fntype expselector |
					 vartype := vartype asSymbol.
					 expselector := expression selector.
					 fntype := (aCodeGen methodNamed: expselector).
					 fntype notNil ifTrue: [ fntype := fntype returnType ].
					 "The expression may have been inlined"
					 fntype isNil ifTrue: [ fntype := aCodeGen inlineReturnType: expselector ].
					 (fntype notNil and: [ fntype ~= vartype ] and: [ vartype ~= #void ]) ifTrue:
						[aStream nextPut: $(; nextPutAll: vartype asString; nextPut: $)].
					].
			 expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen]! !

!TAssignmentNode methodsFor: 'accessing'!
expression

	^expression! !

!TAssignmentNode methodsFor: 'accessing'!
setVariable: varNode expression: expressionNode

	variable := varNode.
	expression := expressionNode.! !

!TAssignmentNode methodsFor: 'accessing'!
variable

	^variable! !

!TAssignmentNode methodsFor: 'testing'!
isAssignment

	^true! !

!TAssignmentNode methodsFor: 'testing'!
isVariableUpdatingAssignment
	"Return true if this assignment statement is of one of the forms:
		var = var + ...
		var = var - ...
	Such assignments statements can exploit the C updating assignment operators. For example, 'x += 4' can be generated instead of 'x = x + 4'. This produces better code under some C compilers, most notably the CodeWarrior 68K compiler."

	| sel |
	(expression isSend and: [expression receiver isVariable]) ifFalse: [^ false].
	sel := expression selector.
	^ (expression receiver name = variable name) and: [(sel = #+) or: [sel = #-]]! !

!TAssignmentNode methodsFor: 'testing' stamp: 'eem 12/11/2010 12:25'!
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^variable structTargetKind: aCodeGen! !

!TAssignmentNode methodsFor: 'testing' stamp: 'eem 10/24/2013 13:02'!
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^variable structTargetKindIn: aCodeGen! !

!TAssignmentNode methodsFor: 'enumerating'!
nodesDo: aBlock

	variable nodesDo: aBlock.
	expression nodesDo: aBlock.
	aBlock value: self.! !

!TAssignmentNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 16:59'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	variable nodesDo: aBlock parent: self.
	expression nodesDo: aBlock parent: self.
	aBlock value: self value: parent! !

!TAssignmentNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:46'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	variable nodesDo: aBlock unless: cautionaryBlock.
	expression nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.! !

!TAssignmentNode methodsFor: 'printing' stamp: 'ar 4/4/2006 21:12'!
printOn: aStream level: level

	variable printOn: aStream level: level.
	aStream nextPutAll: ' := '.
	expression printOn: aStream level: level + 2.! !

!TBraceCaseNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:13'!
bindVariableUsesIn: aDictionary

	caseLabels := caseLabels collect: [:node| node bindVariableUsesIn: aDictionary].
	cases := cases collect: [:node| node bindVariableUsesIn: aDictionary]! !

!TBraceCaseNode methodsFor: 'transformations' stamp: 'eem 10/29/2012 11:38'!
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newCaseLabels newCases |
	newCaseLabels := caseLabels collect: [:node| node bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	newCases := cases collect: [:node| node bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	^(newCaseLabels = caseLabels
	   and: [newCases = cases])
		ifTrue: [self]
		ifFalse: [self shallowCopy
					caseLabels: newCaseLabels;
					cases: newCases;
					yourself]! !

!TBraceCaseNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:12'!
bindVariablesIn: aDictionary

	caseLabels := caseLabels collect: [:node| node bindVariablesIn: aDictionary].
	cases := cases collect: [:node| node bindVariablesIn: aDictionary]! !

!TBraceCaseNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 10:27'!
caseLabels
	"Answer the value of caseLabels"

	^ caseLabels! !

!TBraceCaseNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 10:27'!
caseLabels: anObject
	"Set the value of caseLabels"

	caseLabels := anObject! !

!TBraceCaseNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 10:27'!
cases
	"Answer the value of cases"

	^ cases! !

!TBraceCaseNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 10:27'!
cases: anObject
	"Set the value of cases"

	cases := anObject! !

!TBraceCaseNode methodsFor: 'copying' stamp: 'dtl 1/20/2014 15:03'!
copyTree

	self flag: #FIXME. "adopt from oscog - get rid of copyTree,  use postCopy instead"
	^self copy
! !

!TBraceCaseNode methodsFor: 'enumerating' stamp: 'eem 11/19/2012 12:12'!
nodesDo: aBlock
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	caseLabels do:
		[:node| node nodesDo: aBlock].
	cases do:
		[:node| node nodesDo: aBlock].
	aBlock value: self! !

!TBraceCaseNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:00'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	caseLabels do:
		[:node| node nodesDo: aBlock parent: self.].
	cases do:
		[:node| node nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!TBraceCaseNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:47'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	caseLabels do:
		[:node| node nodesDo: aBlock unless: cautionaryBlock].
	cases do:
		[:node| node nodesDo: aBlock unless: cautionaryBlock].
	aBlock value: self! !

!TBraceCaseNode methodsFor: 'enumerating' stamp: 'eem 2/11/2009 10:16'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		caseLabels := caseLabels collect: [:node| node replaceNodesIn: aDictionary].
		cases := cases collect: [:node| node replaceNodesIn: aDictionary].
		self]! !

!TCaseStmtNode methodsFor: 'as yet unclassified' stamp: 'dtl 7/3/2008 09:37'!
assumesCurrentBytecodeMatchesCaseValue: statementList
	"Test for the special case of certain methods that rely on the value of
	the currentBytecode variable to be expanded to a constant. This is a
	performance optimization that permits the next bytecode to be fetched
	early while not affecting the prior value of currentBytecode, which
	will have been translated to a constant.
	
	See senders of #'requires currentBytecode to be expanded to a constant'
	for methods that rely on this behavior."

	| trickySelectors commentString firstLine |
	trickySelectors := {
			#pushLiteralConstantBytecode .
			#pushLiteralVariableBytecode .
			#pushReceiverVariableBytecode .
			#pushTemporaryVariableBytecode .
			#storeAndPopTemporaryVariableBytecode .
			#storeAndPopReceiverVariableBytecode
		}.
	firstLine := statementList statements first.
	firstLine isComment ifTrue: [
		commentString := firstLine asString.
		trickySelectors detect: [:e | commentString includesSubString: e]
			ifNone: [^ false].
		^ true].
	^ false! !

!TCaseStmtNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setExpression: expression copyTree
		firsts: firsts copy
		lasts: lasts copy
		cases: (cases collect: [ :case | case copyTree ])! !

!TCaseStmtNode methodsFor: 'as yet unclassified' stamp: 'ar 7/6/2003 23:34'!
customizeCase: caseParseTree forVar: varName from: firstIndex to: lastIndex in: codeGen method: aTMethod
	"Return a collection of copies of the given parse tree, each of which has the value of the case index substituted for the given variable."

	| newCases dict newCase |
	newCases := OrderedCollection new.
	firstIndex to: lastIndex do: [ :caseIndex |
		dict := Dictionary new.
		dict at: varName put: (TConstantNode new setValue: caseIndex).
		newCase := caseParseTree copyTree bindVariableUsesIn: dict.
		self processSharedCodeBlocks: newCase forCase: caseIndex in: codeGen method: aTMethod.
		newCases addLast: newCase.
	].
	^ newCases! !

!TCaseStmtNode methodsFor: 'as yet unclassified' stamp: 'dtl 7/3/2008 09:57'!
customizeShortCasesForDispatchVar: varName in: codeGen method: aTMethod
	"Make customized versions of a short bytecode methods, substituting a constant having the case index value for the given variable. This produces better code for short bytecodes such as instance variable pushes that encode the index of the instance variable in the bytecode."

	| newFirsts newLasts newCases l f case expanded |
	newFirsts := OrderedCollection new.
	newLasts := OrderedCollection new.
	newCases := OrderedCollection new.
	1 to: cases size do: [ :i |
		l := lasts at: i.
		f := firsts at: i.
		case := cases at: i.
		expanded := false.
		(l - f) > 1 ifTrue: [  "case code covers multiple cases"
			(case nodeCount < 60
				or: [self assumesCurrentBytecodeMatchesCaseValue: case]) ifTrue: [
					newFirsts addAll: (f to: l) asArray.
					newLasts addAll: (f to: l) asArray.
					newCases addAll: (self customizeCase: case forVar: varName from: f to: l in: codeGen method: aTMethod).
					expanded := true
			]
		].
		expanded ifFalse: [
			self processSharedCodeBlocks: case forCase: f in: codeGen method: aTMethod.
			newFirsts addLast: f.
			newLasts addLast: l.
			newCases addLast: case.
		]
	].
	firsts := newFirsts asArray.
	lasts := newLasts asArray.
	cases := newCases asArray.
! !

!TCaseStmtNode methodsFor: 'as yet unclassified' stamp: 'dtl 11/9/2006 06:29'!
emitCCodeOn: aStream level: level generator: aCodeGen

	| indent |
	indent := (String new: level) collect: [ :ch | Character tab ].
	aStream nextPutAll: 'switch ('.
	expression asExpression emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'; cr.
	1 to: cases size do: [ :i |
		(firsts at: i) to: (lasts at: i) do: [ :caseIndex |
			aStream nextPutAll: indent, 'case ', caseIndex printString, ':'; cr.
		].
		(cases at: i) emitCCodeOn: aStream level: level + 1 generator: aCodeGen.
		aStream nextPutAll: indent; tab; nextPutAll: 'break;'.
		aStream cr.
	].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!TCaseStmtNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	expression inlineMethodsUsing: aDictionary.
	cases do: [ :c | c inlineMethodsUsing: aDictionary ].! !

!TCaseStmtNode methodsFor: 'as yet unclassified'!
setExpression: aNode firsts: firstsList lasts: lastsList cases: caseList

	expression := aNode.
	firsts := firstsList.
	lasts := lastsList.
	cases := caseList.! !

!TCaseStmtNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:26'!
bindVariableUsesIn: aDictionary

	expression := expression bindVariableUsesIn: aDictionary.
	cases := cases collect: [ :c | c bindVariableUsesIn: aDictionary ].! !

!TCaseStmtNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	expression := expression bindVariablesIn: aDictionary.
	cases := cases collect: [ :c | c bindVariablesIn: aDictionary ].! !

!TCaseStmtNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:38'!
mapReceiversIn: aDictionary
	expression mapReceiversIn: aDictionary.
	cases do: [ :c | c mapReceiversIn: aDictionary ]
! !

!TCaseStmtNode methodsFor: 'transformations' stamp: 'ar 7/7/2003 00:18'!
processSharedCodeBlocks: caseTree forCase: caseIndex in: codeGen method: aTMethod
	"Process any shared code blocks in the case parse tree for the given case, either inlining them or making them a 'goto sharedLabel'."
	| map meth sharedNode exitLabel |
	exitLabel := nil.

	[sharedNode := nil.
	map := IdentityDictionary new.
	caseTree nodesDo:[:node|
		(node isSend 
			and:[(meth := codeGen methodNamed: node selector) notNil
			and:[meth sharedCase notNil]]) ifTrue:[
			meth sharedCase = caseIndex ifTrue:[
				sharedNode := meth.
				map at: node put: (TLabeledCommentNode new setComment: 'goto ', meth sharedLabel).
			] ifFalse:[
				map at: node put: (TGoToNode new setLabel: meth sharedLabel).
			].
		].
	].
	caseTree replaceNodesIn: map.
	"recursively expand"
	sharedNode == nil] whileFalse:[
		meth := sharedNode copy.
		(meth hasReturn) ifTrue: [
			exitLabel ifNil:[
				exitLabel := aTMethod unusedLabelForInliningInto: aTMethod.
				aTMethod labels add: exitLabel.
			].
			meth exitVar: nil label: exitLabel.
		].
		meth renameLabelsForInliningInto: aTMethod.
		aTMethod labels addAll: meth labels.
		caseTree setStatements: (caseTree statements copyWith: meth asInlineNode).
	].
	exitLabel ifNotNil:[
		caseTree setStatements: (caseTree statements copyWith:
			(TLabeledCommentNode new setLabel: exitLabel comment: 'end case')).

	].! !

!TCaseStmtNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	expression removeAssertions.
	cases do: [ :case | case removeAssertions ].! !

!TCaseStmtNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		expression := expression replaceNodesIn: aDictionary.
		cases := cases collect: [ :c | c replaceNodesIn: aDictionary ].
		self]! !

!TCaseStmtNode methodsFor: 'accessing'!
cases

	^cases! !

!TCaseStmtNode methodsFor: 'accessing'!
expression

	^expression! !

!TCaseStmtNode methodsFor: 'accessing' stamp: 'ar 11/18/1999 20:08'!
setExpression: aNode selectors: selectorList arguments: anArray
	"Initialize the node from the given set of selectors."
	"Note: Each case is a statement list with containing one statement, a send to self of a selector from the given selector list. Having statement list nodes makes inlining easier later."

	| selfNode stmt lastSel firstInRun sel |
	expression := aNode.
	selfNode := TVariableNode new setName: 'self'.
	firsts := OrderedCollection new: 400.
	lasts := OrderedCollection new: 400.
	cases := OrderedCollection new: 400.
	lastSel := selectorList first.
	firstInRun := 0.
	1 to: selectorList size do: [ :i |
		sel := selectorList at: i.
		sel ~= lastSel ifTrue: [
			firsts add: firstInRun.
			lasts add: i - 2.
			stmt := TSendNode new setSelector: lastSel receiver: selfNode arguments: anArray.
			cases add: (TStmtListNode new setArguments: #() statements: (Array with: stmt)).
			lastSel := sel.
			firstInRun := i - 1.
		].
	].
	firsts add: firstInRun.
	lasts add: selectorList size - 1.
	stmt := TSendNode new setSelector: lastSel receiver: selfNode arguments: anArray.
	cases add: (TStmtListNode new setArguments: #() statements: (Array with: stmt)).! !

!TCaseStmtNode methodsFor: 'testing'!
isCaseStmt

	^true! !

!TCaseStmtNode methodsFor: 'enumerating'!
nodesDo: aBlock

	expression nodesDo: aBlock.
	cases do: [ :c | c nodesDo: aBlock ].
	aBlock value: self.! !

!TCaseStmtNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:00'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	expression nodesDo: aBlock parent: self.
	cases do: [:c| c nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!TCaseStmtNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:47'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	expression nodesDo: aBlock unless: cautionaryBlock.
	cases do: [ :c | c nodesDo: aBlock  unless: cautionaryBlock].
	aBlock value: self! !

!TCaseStmtNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream crtab: level.
	aStream nextPutAll: 'select '.
	expression printOn: aStream level: level.
	aStream nextPutAll: ' in'.
	1 to: cases size do: [ :i |
		(firsts at: i) to: (lasts at: i) do: [ :caseIndex |
			aStream crtab: level.
			aStream nextPutAll: 'case ', caseIndex printString, ':'.
		].
		aStream crtab: level + 1.
		(cases at: i) printOn: aStream level: level + 1.
	].
	aStream crtab: level.
	aStream nextPutAll: 'end select'.! !

!TConstantNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setValue: value! !

!TConstantNode methodsFor: 'C code generation'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C literal."

	aStream nextPutAll: (aCodeGen cLiteralFor: value).! !

!TConstantNode methodsFor: 'testing'!
isConstant

	^true! !

!TConstantNode methodsFor: 'testing'!
isLeaf

	^true! !

!TConstantNode methodsFor: 'accessing' stamp: 'acg 12/17/1999 07:19'!
nameOrValue

	^value! !

!TConstantNode methodsFor: 'accessing'!
setValue: anObject

	value := anObject.! !

!TConstantNode methodsFor: 'accessing'!
value

	^value! !

!TConstantNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:10'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	aBlock value: self value: parent! !

!TConstantNode methodsFor: 'printing' stamp: 'eem 12/12/2012 11:23'!
printOn: aStream level: level
	value isSymbol
		ifTrue: [aStream nextPutAll: (value copyWithout: $:)]
		ifFalse: [value storeOn: aStream]! !

!TDefineNode methodsFor: 'as yet unclassified' stamp: 'ar 7/8/2003 11:11'!
copyTree

	^self class new
		setName: name value: value! !

!TDefineNode methodsFor: 'C code generation' stamp: 'ar 7/8/2003 11:08'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C literal."

	aStream nextPutAll: name.! !

!TDefineNode methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:05'!
name: aName
	name := aName! !

!TDefineNode methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:08'!
nameOrValue
	^name! !

!TDefineNode methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:10'!
setName: aName value: aValue
	self name: aName.
	self setValue: aValue.! !

!TGoToNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new setLabel: label! !

!TGoToNode methodsFor: 'C code generation'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C goto statement."

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.! !

!TGoToNode methodsFor: 'testing'!
isGoTo

	^true! !

!TGoToNode methodsFor: 'accessing'!
label

	^label! !

!TGoToNode methodsFor: 'accessing'!
setLabel: aString

	label := aString.! !

!TGoToNode methodsFor: 'enumerating' stamp: 'eem 10/25/2013 14:43'!
nodesDo: aBlock parent: parent
	aBlock value: self value: parent! !

!TGoToNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.! !

!TInlineNode methodsFor: 'transformations' stamp: 'ar 7/6/2003 20:34'!
bindVariableUsesIn: aDictionary
	method := method bindVariableUsesIn: aDictionary.
! !

!TInlineNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 14:43'!
mapReceiversIn: aDictionary
	method mapReceiversIn: aDictionary
! !

!TInlineNode methodsFor: 'transformations' stamp: 'ar 7/6/2003 21:30'!
replaceNodesIn: map
	^map at: self ifAbsent: [
		method replaceNodesIn: map.
		self]! !

!TInlineNode methodsFor: 'accessing' stamp: 'ar 7/6/2003 20:15'!
copyTree

	^self class new
		method: method copy! !

!TInlineNode methodsFor: 'accessing' stamp: 'ar 7/6/2003 20:08'!
method
	^method! !

!TInlineNode methodsFor: 'accessing' stamp: 'ar 7/6/2003 20:08'!
method: aTMethod
	method := aTMethod! !

!TInlineNode methodsFor: 'C code generation' stamp: 'ar 7/6/2003 20:19'!
emitCCodeOn: aStream level: level generator: aCodeGen
	method emitInlineOn: aStream level: level generator: aCodeGen.
! !

!TInlineNode methodsFor: 'enumerating' stamp: 'ar 7/6/2003 20:36'!
nodesDo: aBlock
	method parseTree nodesDo: aBlock.
	aBlock value: self.! !

!TInlineNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:47'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	method parseTree nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.! !

!TInlineNode methodsFor: 'printing' stamp: 'ar 7/6/2003 22:00'!
printOn: aStream level: anInteger
	method parseTree printOn: aStream level: anInteger! !

!TLabeledCommentNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setLabel: label
		comment: comment! !

!TLabeledCommentNode methodsFor: 'as yet unclassified'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C comment with optional label."

	self printOptionalLabelOn: aStream.
	aStream nextPutAll: '/* '.
	aStream nextPutAll: comment.
	aStream nextPutAll: ' */'.! !

!TLabeledCommentNode methodsFor: 'testing'!
isComment
	"Answer true if the receiver is just a comment (i.e., it has no label)."

	^label = nil! !

!TLabeledCommentNode methodsFor: 'testing'!
isLabel

	^true! !

!TLabeledCommentNode methodsFor: 'testing'!
isLeaf

	^true! !

!TLabeledCommentNode methodsFor: 'accessing'!
label

	^label! !

!TLabeledCommentNode methodsFor: 'accessing'!
setComment: commentString

	label := nil.
	comment := commentString.! !

!TLabeledCommentNode methodsFor: 'accessing'!
setLabel: labelString

	label := labelString.! !

!TLabeledCommentNode methodsFor: 'accessing'!
setLabel: labelString comment: commentString

	label := labelString.
	comment := commentString.! !

!TLabeledCommentNode methodsFor: 'enumerating' stamp: 'eem 10/25/2013 14:42'!
nodesDo: aBlock parent: parent
	aBlock value: self value: parent! !

!TLabeledCommentNode methodsFor: 'printing'!
printOn: aStream level: level

	self printOptionalLabelOn: aStream.
	aStream nextPut: $".
	aStream nextPutAll: comment.
	aStream nextPut: $".! !

!TLabeledCommentNode methodsFor: 'printing'!
printOptionalLabelOn: aStream

	label ~= nil ifTrue: [
		self unindentOneTab: aStream.
		aStream nextPutAll: label.
		aStream nextPut: $:.
		aStream tab.	
	].! !

!TLabeledCommentNode methodsFor: 'C code generation'!
unindentOneTab: aStream
	"Remove the last tab from the given stream if possible."

	(aStream isKindOf: ReadWriteStream) ifFalse: [ ^self ].
	aStream position > 0 ifTrue: [
		aStream position: aStream position - 1.
		"restore stream position if previous char was not a tab"
		aStream peek = Character tab ifFalse: [ aStream next ].
	].! !

!TNotImplementedNode methodsFor: 'C code generation' stamp: 'dtl 6/20/2012 07:59'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a comment only"

	aStream cr; nextPutAll: '/*** ';
		nextPutAll: self printString;
		nextPutAll: ' cannot translate: '; cr;
		nextPutAll: parseNode printString;
		cr; nextPutAll: ' ***/'; cr
! !

!TNotImplementedNode methodsFor: 'accessing' stamp: 'dtl 10/12/2010 19:40'!
parseNode
	"Answer the value of parseNode"

	^ parseNode! !

!TNotImplementedNode methodsFor: 'accessing' stamp: 'dtl 10/12/2010 19:40'!
parseNode: anObject
	"Set the value of parseNode"

	parseNode := anObject! !

!TReturnNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:26'!
bindVariableUsesIn: aDictionary

	expression := expression bindVariableUsesIn: aDictionary.! !

!TReturnNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	expression := expression bindVariablesIn: aDictionary.! !

!TReturnNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:38'!
mapReceiversIn: aDictionary
	expression mapReceiversIn: aDictionary
! !

!TReturnNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	expression removeAssertions! !

!TReturnNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		expression := expression replaceNodesIn: aDictionary.
		self]! !

!TReturnNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setExpression: expression copyTree! !

!TReturnNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	expression := expression inlineMethodsUsing: aDictionary.! !

!TReturnNode methodsFor: 'C code generation' stamp: 'eem 11/7/2009 15:43'!
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

!TReturnNode methodsFor: 'testing' stamp: 'eem 2/11/2009 15:24'!
endsWithReturn

	^true! !

!TReturnNode methodsFor: 'testing'!
isReturn

	^true! !

!TReturnNode methodsFor: 'accessing'!
expression

	^expression! !

!TReturnNode methodsFor: 'accessing'!
setExpression: aNode

	expression := aNode.! !

!TReturnNode methodsFor: 'enumerating'!
nodesDo: aBlock

	expression nodesDo: aBlock.
	aBlock value: self.! !

!TReturnNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:02'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	expression nodesDo: aBlock parent: self.
	aBlock value: self value: parent! !

!TReturnNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:47'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	expression nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.! !

!TReturnNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream nextPut: $^.
	expression printOn: aStream level: level.! !

!TSendNode methodsFor: 'accessing'!
args

	^arguments! !

!TSendNode methodsFor: 'accessing'!
copyTree

	^self class new
		setSelector: selector
		receiver: receiver copyTree
		arguments: (arguments collect: [ :arg | arg copyTree ])
		isBuiltInOp: isBuiltinOperator! !

!TSendNode methodsFor: 'accessing' stamp: 'dtl 11/11/2009 20:59'!
isExpression
	"Answer the value of isExpression. True if this node is expected to be used
	as an expression. Normally false but may be set by #asExpression to indicate
	that this node should be translated as a simple expression rather than as
	a statement."

	^ isExpression ifNil: [isExpression := false]! !

!TSendNode methodsFor: 'accessing' stamp: 'dtl 11/7/2006 12:06'!
isExpression: anObject
	"Set the value of isExpression"

	isExpression := anObject! !

!TSendNode methodsFor: 'accessing'!
receiver

	^receiver! !

!TSendNode methodsFor: 'accessing'!
receiver: aNode

	receiver := aNode.! !

!TSendNode methodsFor: 'accessing'!
selector

	^selector! !

!TSendNode methodsFor: 'accessing'!
setSelector: aSymbol receiver: rcvrNode arguments: argList

	selector := aSymbol.
	receiver := rcvrNode.
	arguments := argList asArray.
	isBuiltinOperator := false.! !

!TSendNode methodsFor: 'accessing'!
setSelector: aSymbol receiver: rcvrNode arguments: argList isBuiltInOp: builtinFlag

	selector := aSymbol.
	receiver := rcvrNode.
	arguments := argList asArray.
	isBuiltinOperator := builtinFlag.! !

!TSendNode methodsFor: 'private' stamp: 'eem 10/29/2012 12:48'!
arguments: aSequence
	arguments := aSequence! !

!TSendNode methodsFor: 'inlining support' stamp: 'eem 2/11/2009 17:03'!
argumentsForInliningCodeGenerator: aCodeGen
	^(self shouldIncludeReceiverAsFirstArgument: aCodeGen)
		ifTrue: [{receiver}, arguments]
		ifFalse: [arguments]! !

!TSendNode methodsFor: 'converting' stamp: 'dtl 11/7/2006 12:09'!
asExpression
	"Sender expects to use this node as a simple expression rather than as as statement"

	self isExpression: true.
	^self! !

!TSendNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:26'!
bindVariableUsesIn: aDictionary

	receiver := receiver bindVariableUsesIn: aDictionary.
	arguments := arguments collect: [ :a | a bindVariableUsesIn: aDictionary ].! !

!TSendNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	receiver := receiver bindVariablesIn: aDictionary.
	arguments := arguments collect: [ :a | a bindVariablesIn: aDictionary ].! !

!TSendNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:39'!
mapReceiversIn: aDictionary
	receiver mapReceiversIn: aDictionary.
	arguments collect: [:a | a mapReceiversIn: aDictionary]! !

!TSendNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	receiver removeAssertions.
	arguments do: [:arg | arg removeAssertions].! !

!TSendNode methodsFor: 'transformations' stamp: 'dtl 8/20/2011 14:20'!
renameSelector: selectorName as: newSelectorName
	"Rename selectors such that generated code will use the newSelectorName. This
	is intended to allow methods that may have default implementations in the support
	code to be renamed for code generation, such that the renamed versions will
	be referenced rather than the default platform implementations. For example,
	if #pointerForOop: is implemented in Smalltalk, it may be renamed such that
	the generated pointerForOop() function will be renamed to avoid conflict with
	the standard definitions provided in sqMemoryAccess.h."

	selector = selectorName
		ifTrue: [selector := newSelectorName]! !

!TSendNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		receiver := receiver replaceNodesIn: aDictionary.
		arguments := arguments collect: [ :a | a replaceNodesIn: aDictionary ].
		self]! !

!TSendNode methodsFor: 'C code generation' stamp: 'dtl 10/19/2010 22:20'!
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	"Emit the receiver in a form that can be passed as an argument."

	"If the selector is a built-in construct, translate it and return"
	(aCodeGen emitBuiltinConstructAsArgumentFor: self asExpression on: aStream level: level) ifFalse:
		["If it is a pointer dereference generate it"
		(self emitCCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen) ifFalse:
			["Otherwise generate the vanilla C function call."
			 self emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen]]! !

!TSendNode methodsFor: 'C code generation' stamp: ' 2/7/08 14:57'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen! !

!TSendNode methodsFor: 'C code generation' stamp: 'dtl 12/28/2014 18:50'!
emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen

	"Translate this message send into a C function call"
	"Special case for pluggable modules. Replace messages to interpreterProxy
	 by interpreterProxy->message(..) if the message is not builtin"
	| fn fnargtypes |
	(aCodeGen isGeneratingPluginCode
	 and: [receiver isVariable
	 and: ['interpreterProxy' = receiver name
	 and: [self isBuiltinOperator not]]]) ifTrue:
		[aStream nextPutAll:'interpreterProxy->'].
	"Translate this message send into a C function call."
	aStream nextPutAll: (aCodeGen cFunctionNameFor: selector); nextPut: $(.
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
	fn := aCodeGen methodNamed: self selector.
	fn notNil ifTrue: [ fnargtypes := fn argTypes ].
	fnargtypes notNil ifTrue: [ fnargtypes size = arguments size ifFalse: [ fnargtypes := nil ] ].
	fnargtypes notNil ifTrue: [ fnargtypes := fnargtypes collect: [ :a | aCodeGen declToType: a ]].
	arguments withIndexDo:
		[ :arg :i | | argtype fnargtype |
		i = 1 ifFalse: [aStream nextPut: $,; space].
		argtype := nil.
		fnargtype := nil.
		(arg name notNil) ifTrue: [ argtype := aCodeGen declToType: (aCodeGen typeOfVariable: arg name) ].
		fnargtypes notNil ifTrue: [ fnargtype := fnargtypes at: i ].
		"Insert cast of function argument type if necessary"
		(argtype notNil and: fnargtype notNil and: [ argtype ~= fnargtype ]) ifTrue: [ aStream nextPutAll: '(',fnargtype,')'  ]. 
		arg emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $)! !

!TSendNode methodsFor: 'C code generation' stamp: 'eem 4/7/2009 10:46'!
emitCCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen
	"If appropriate, translate this message send as a pointer dereference"

	(self isStructSend: aCodeGen) ifFalse:
		[^false].

	aStream nextPut: $(.
	receiver  emitCCodeAsExpressionOn: aStream level: 0 generator: aCodeGen.
	aStream nextPut: $-; nextPut: $>.
	aStream nextPutAll: (aCodeGen cFunctionNameFor: selector).
	arguments isEmpty ifFalse:
		[self assert: arguments size = 1.
		 aStream nextPutAll: ' = '.
		 arguments first emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $).
	^true! !

!TSendNode methodsFor: 'C code generation' stamp: 'eem 7/2/2008 15:44'!
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit the receiver as a statement."

	"If the selector is a built-in construct, translate it and return"
	(aCodeGen emitBuiltinConstructFor: self on: aStream level: level) ifFalse:
		["If it is a pointer dereference generate it"
		(self emitCCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen) ifFalse:
			["Otherwise generate the vanilla C function call."
			 self emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen]]! !

!TSendNode methodsFor: 'C code generation'!
inlineMethodsUsing: aDictionary

	arguments := arguments collect: [ :arg |
		arg inlineMethodsUsing: aDictionary.
	].
	"xxx inline this message if it is in the dictionary xxx"! !

!TSendNode methodsFor: 'C code generation' stamp: 'eem 10/24/2013 12:57'!
isSelfReference: varNode in: aCodeGen
	^(varNode name beginsWith: 'self')
	  and: [varNode name = 'self' or: [varNode name beginsWith: 'self_in_']]! !

!TSendNode methodsFor: 'C code generation' stamp: 'eem 10/24/2013 13:01'!
isStructReference: varNode in: aCodeGen
	^(varNode structTargetKindIn: aCodeGen) notNil! !

!TSendNode methodsFor: 'C code generation' stamp: 'eem 11/6/2013 14:42'!
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
	 and: [receiver receiver isVariable
	 and: [(self isSelfReference: receiver receiver in: aCodeGen)
		or: [self isStructReference: receiver receiver in: aCodeGen]]]) ifTrue:
		[^aCodeGen isNonArgumentImplicitReceiverVariableName: receiver selector].

	^receiver isVariable
	    and: [(aCodeGen isNonArgumentImplicitReceiverVariableName: receiver name)
		    or: [(self isSelfReference: receiver in: aCodeGen)
			    and: [(m := aCodeGen methodNamed: selector) isNil
					or: [m typeForSelf == #implicit]]]]! !

!TSendNode methodsFor: 'C code generation' stamp: 'eem 2/11/2009 17:00'!
shouldIncludeReceiverAsFirstArgument: aCodeGen
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it."
	^(self shouldExcludeReceiverAsFirstArgument: aCodeGen) not! !

!TSendNode methodsFor: 'testing' stamp: 'eem 2/11/2009 15:25'!
endsWithReturn
	^self isReturningIf! !

!TSendNode methodsFor: 'testing' stamp: 'ikp 9/26/97 14:50'!
isAssertion
	^(selector beginsWith: 'assert') or: [selector beginsWith: 'verify']! !

!TSendNode methodsFor: 'testing'!
isBuiltinOperator

	^ isBuiltinOperator! !

!TSendNode methodsFor: 'testing'!
isBuiltinOperator: builtinFlag

	isBuiltinOperator := builtinFlag.! !

!TSendNode methodsFor: 'testing' stamp: 'dtl 7/8/2012 11:48'!
isDirective
	"Preprocessor directive, e.g. a cpp macro"

	^ {	#preprocessorExpression: .
		#isDefined:inSmalltalk:comment:ifTrue:ifFalse: .
		#isDefined:inSmalltalk:comment:ifTrue: .
		#isDefinedTrueExpression:inSmalltalk:comment:ifTrue:ifFalse: .
		#cPreprocessorDirective:
		} identityIncludes: selector! !

!TSendNode methodsFor: 'testing'!
isSend

	^true! !

!TSendNode methodsFor: 'testing' stamp: 'eem 12/11/2010 12:26'!
isStructSend: aCodeGen
	"Answer if the recever is a send of a structure accessor.
	 This is tricky.  We want
		foo bar => foo->bar
		foo bar => foo.bar
		foo bar: expr => foo->bar = expr
		foo bar: expr => foo.bar = expr
	 depending on whether foo is a struct or a pointer to a struct,
	 but only if both foo is a struct type and bar is a field accessor.
	 The tricky cases are self-sends within struct class methods.  Here we need to
	 distinguish between self-sends of ordinary methods from self sends of accessors."
	^arguments size <= 1
	   and: [(receiver structTargetKind: aCodeGen) notNil
	   and: [(aCodeGen methodNamed: selector)
				ifNil: [false]
				ifNotNil: [:method| method isStructAccessor]]]! !

!TSendNode methodsFor: 'testing' stamp: 'eem 10/24/2013 16:03'!
isStructSendIn: aCodeGen
	"Answer if the recever is a send of a structure accessor.
	 This is tricky.  We want
		foo bar => foo->bar
		foo bar => foo.bar
		foo bar: expr => foo->bar = expr
		foo bar: expr => foo.bar = expr
	 depending on whether foo is a struct or a pointer to a struct,
	 but only if both foo is a struct type and bar is a field accessor.
	 The tricky cases are self-sends within struct class methods.  Here we need to
	 distinguish between self-sends of ordinary methods from self sends of accessors."
	^arguments size <= 1
	   and: [(receiver structTargetKindIn: aCodeGen) notNil
	   and: [(aCodeGen methodNamed: selector)
				ifNil: [false]
				ifNotNil: [:method| method isStructAccessor]]]! !

!TSendNode methodsFor: 'testing' stamp: 'dtl 10/24/2006 22:05'!
requiresCLineTerminator

	^ (self isComment or: [self isDirective]) not
! !

!TSendNode methodsFor: 'testing' stamp: 'eem 12/11/2010 12:37'!
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil.  Right now we don't need or support
	 structure return so this method answers either #pointer or nil."
	selector == #cCoerceSimple:to: ifTrue:
		[^(VMStructType isTypePointerToStruct: arguments last value) ifTrue:
			[#pointer]].

	^(aCodeGen selectorReturnsPointerToStruct: selector) ifTrue:
		[#pointer]! !

!TSendNode methodsFor: 'testing' stamp: 'eem 10/24/2013 13:02'!
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil.  Right now we don't need or support
	 structure return so this method answers either #pointer or nil."
	selector == #cCoerceSimple:to: ifTrue:
		[^(VMStructType isTypePointerToStruct: arguments last value) ifTrue:
			[#pointer]].

	selector == #addressOf: ifTrue:
		[^#pointer].

	selector == #at: ifTrue:
		[receiver isVariable ifTrue:
			[(aCodeGen typeOfVariable: receiver name) ifNotNil:
				[:type| | derefType |
				 type last = $* ifFalse:
					[^receiver structTargetKindIn: aCodeGen].
				 (VMStructType isTypeStruct: (aCodeGen
											extractTypeFor: receiver name
											fromDeclaration: type allButLast)) ifTrue:
						[^#struct]]].
		(receiver structTargetKindIn: aCodeGen) ifNotNil:
			[:kind| ^kind]].

	(aCodeGen selectorReturnsPointerToStruct: selector) ifTrue:
		[^#pointer].

	(aCodeGen selectorReturnsStruct: selector) ifTrue:
		[^#struct].

	^nil! !

!TSendNode methodsFor: 'enumerating'!
nodesDo: aBlock

	receiver nodesDo: aBlock.
	arguments do: [ :arg | arg nodesDo: aBlock ].
	aBlock value: self.! !

!TSendNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:03'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	receiver nodesDo: aBlock parent: self.
	arguments do: [:arg| arg nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!TSendNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 21:55'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	receiver nodesDo: aBlock unless: cautionaryBlock.
	arguments do: [ :arg | arg nodesDo: aBlock unless: cautionaryBlock].
	aBlock value: self.! !

!TSendNode methodsFor: 'printing' stamp: 'eem 3/30/2013 14:11'!
printOn: aStream level: level
	| possiblyParenthesize |
	possiblyParenthesize :=
		[:node :newLevel|
		(node isSend
		 and: [node selector precedence >= 3]) ifTrue:
			[aStream nextPut: $(].
		node printOn: aStream level: newLevel.
		(node isSend
		 and: [node selector precedence >= 3]) ifTrue:
			[aStream nextPut: $)]].

	possiblyParenthesize value: receiver value: level.
	arguments size = 0 ifTrue:
		[aStream space; nextPutAll: selector.
		^self].
	selector keywords with: (arguments first: selector numArgs) do:
		[:keyword :arg |
		aStream space; nextPutAll: keyword; space.
		possiblyParenthesize value: arg value: level + 1]! !

!TStmtListNode methodsFor: 'accessing'!
args

	^arguments! !

!TStmtListNode methodsFor: 'accessing'!
setArguments: argList

	arguments := argList.! !

!TStmtListNode methodsFor: 'accessing'!
setArguments: argList statements: statementList
	"Initialize this method using the given information."

	arguments := argList.
	statements := statementList.! !

!TStmtListNode methodsFor: 'accessing'!
setStatements: stmtList

	statements := stmtList asOrderedCollection.! !

!TStmtListNode methodsFor: 'accessing'!
statements

	^statements! !

!TStmtListNode methodsFor: 'converting' stamp: 'dtl 10/28/2006 18:51'!
asExpression

	^ (self statements size = 1)
		ifTrue: [statements first]
		ifFalse: [self error: 'multiple statements can not serve as a simple expression']! !

!TStmtListNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:26'!
bindVariableUsesIn: aDictionary

	statements := statements collect: [ :s | s bindVariableUsesIn: aDictionary ].! !

!TStmtListNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	statements := statements collect: [ :s | s bindVariablesIn: aDictionary ].! !

!TStmtListNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:39'!
mapReceiversIn: aDictionary
	statements do: [ :s | s mapReceiversIn: aDictionary ]
! !

!TStmtListNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	| newStatements |
	newStatements := OrderedCollection new: statements size.
	statements do: [ :stmt |
		stmt isAssertion ifFalse: [
			newStatements add: (stmt removeAssertions; yourself).
		]
	].
	self setStatements: newStatements asArray! !

!TStmtListNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		statements := statements collect: [ :s | s replaceNodesIn: aDictionary ].
		self]! !

!TStmtListNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setArguments: arguments copy
		statements: (statements collect: [ :s | s copyTree ])! !

!TStmtListNode methodsFor: 'as yet unclassified' stamp: 'dtl 1/3/2013 23:05'!
emitCCodeOn: aStream level: level generator: aCodeGen

	self emitCCommentOn: aStream level: level.
	statements do: [:s |
		s emitCCommentOn: aStream level: level.
		aStream tab: level.
		s emitCCodeOn: aStream level: level generator: aCodeGen.
		(((self endsWithCloseBracket: aStream) not
			and: [(s isComment) not])
				and: [s requiresCLineTerminator])
			ifTrue: [aStream nextPut: $;].
		aStream cr].
! !

!TStmtListNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	statements do: [ :s | s inlineMethodsUsing: aDictionary ].! !

!TStmtListNode methodsFor: 'C code generation' stamp: ' 2/7/08 14:57'!
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen

	| statementWasComment |
	statementWasComment := false.
	statements
		do:
			[:s |
			s emitCCommentOn: aStream level: level.
			s emitCCodeAsArgumentOn: aStream level: 0 generator: aCodeGen.
			statementWasComment := s isComment]
		separatedBy:
			[((self endsWithCloseBracket: aStream)
			  or: [statementWasComment]) ifFalse: [aStream nextPut: $,]]! !

!TStmtListNode methodsFor: 'C code generation' stamp: 'eem 8/18/2011 14:47'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen! !

!TStmtListNode methodsFor: 'testing' stamp: 'jm 11/25/1998 16:26'!
endsWithCloseBracket: aStream
	"Answer true if the given stream ends in a $} character."

	| ch pos |
	(pos := aStream position) > 0 ifTrue: [
		aStream position: pos - 1.
		ch := aStream next].
	^ ch = $}
! !

!TStmtListNode methodsFor: 'testing' stamp: 'dtl 12/28/2014 17:13'!
endsWithReturn
	"Answer true if the last statement of this lock is a return."

	^ statements isEmpty not
		and: [statements last isReturn
				or: [statements last isReturningIf]]! !

!TStmtListNode methodsFor: 'testing' stamp: 'acg 12/21/1999 02:25'!
isNilStmtListNode

	|stmt|
	statements size = 1 ifFalse: [^false].
	stmt := statements at: 1.
	^ stmt isVariable and: [stmt name = 'nil']! !

!TStmtListNode methodsFor: 'testing'!
isStmtList

	^true! !

!TStmtListNode methodsFor: 'enumerating'!
nodesDo: aBlock

	statements do: [ :s | s nodesDo: aBlock ].	
	aBlock value: self.! !

!TStmtListNode methodsFor: 'enumerating' stamp: 'eem 10/14/2013 15:02'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	statements do: [:s| s nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!TStmtListNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:46'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	statements do: [ :s | s nodesDo: aBlock unless: cautionaryBlock ].	
	aBlock value: self! !

!TStmtListNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream nextPut: $[.
	arguments size > 0 ifTrue: [
		arguments do: [ :arg | aStream nextPutAll: ' :', arg ].
		aStream nextPutAll: ' | '.
	].
	self printStatementsOn: aStream level: level.
	aStream nextPut: $].! !

!TStmtListNode methodsFor: 'printing'!
printStatementsOn: aStream level: level

	statements size > 1 ifTrue: [ aStream crtab: level + 1 ].
	1 to: statements size do: [ :i |
		(statements at: i) printOn: aStream level: level.
		i = statements size ifTrue: [
			(statements size > 1) ifTrue: [
				aStream crtab: level.
			].
		] ifFalse: [
			aStream nextPut: $.; crtab: level + 1.
		].
	].! !

!TSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:15'!
bindVariableUsesIn: aDictionary
	expression := expression bindVariableUsesIn: aDictionary.
	cases := (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode bindVariableUsesIn: aDictionary].
				   pair last bindVariableUsesIn: aDictionary }]).
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil := otherwiseOrNil bindVariableUsesIn: aDictionary]! !

!TSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 10/29/2012 12:55'!
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newExpression newCases newOtherwise |
	newExpression := expression bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	newCases := cases collect:
					[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
					{ pair first collect: [:labelNode| labelNode bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
					   pair last bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen}].
	newOtherwise := otherwiseOrNil ifNotNil:
						[otherwiseOrNil bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	^(newExpression = expression
	   and: [newCases = cases
	   and: [newOtherwise = otherwiseOrNil]])
		ifTrue: [self]
		ifFalse:
			[self shallowCopy
				expression: newExpression;
				cases: newCases;
				otherwiseOrNil: newOtherwise;
				yourself]! !

!TSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:14'!
bindVariablesIn: aDictionary
	expression := expression bindVariablesIn: aDictionary.
	cases := (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode bindVariablesIn: aDictionary].
				   pair last bindVariablesIn: aDictionary }]).
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil := otherwiseOrNil bindVariablesIn: aDictionary]! !

!TSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:18'!
removeAssertions
	expression removeAssertions.
	cases do:
		[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
		pair first do: [:labelNode| labelNode removeAssertions].
		pair last removeAssertions].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil removeAssertions]! !

!TSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 17:16'!
replaceNodesIn: aDictionary
	^aDictionary
		at: self
		ifAbsent:
			[expression := expression replaceNodesIn: aDictionary.
			 cases := (cases collect:
						[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
						{ pair first collect: [:labelNode| labelNode replaceNodesIn: aDictionary].
						   pair last replaceNodesIn: aDictionary }]).
			 otherwiseOrNil ifNotNil:
				[otherwiseOrNil := otherwiseOrNil replaceNodesIn: aDictionary].
			 self]! !

!TSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
cases
	"Answer the value of cases"

	^ cases! !

!TSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
cases: anObject
	"Set the value of cases"

	cases := anObject! !

!TSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
expression
	"Answer the value of expression"

	^ expression! !

!TSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
expression: anObject
	"Set the value of expression"

	expression := anObject! !

!TSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
otherwiseOrNil
	"Answer the value of otherwiseOrNil"

	^ otherwiseOrNil! !

!TSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
otherwiseOrNil: anObject
	"Set the value of otherwiseOrNil"

	otherwiseOrNil := anObject! !

!TSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 10/13/2013 17:20'!
switchVariable
	"Answer the value of switchVariable"

	^ switchVariable! !

!TSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 10/13/2013 17:20'!
switchVariable: anObject
	"Set the value of switchVariable"

	switchVariable := anObject! !

!TSwitchStmtNode methodsFor: 'copying' stamp: 'dtl 1/20/2014 15:02'!
copyTree

	self flag: #FIXME. "adopt from oscog - get rid of copyTree,  use postCopy instead"
	^self copy
! !

!TSwitchStmtNode methodsFor: 'instance initialization' stamp: 'eem 2/9/2009 18:47'!
createCasesFromBraceNode: aTBraceNode
	| casesToStrings stringsToLabels newCases |
	casesToStrings := Dictionary new.
	stringsToLabels := Dictionary new.
	newCases := OrderedCollection new: aTBraceNode caseLabels size.
	aTBraceNode caseLabels with: aTBraceNode cases do:
		[:label :case| | printString |
		printString := casesToStrings at: case put: case printString.
		(stringsToLabels at: printString ifAbsentPut: [OrderedCollection new]) addLast: label].

	aTBraceNode caseLabels with: aTBraceNode cases do:
		[:label :case| | printString labels |
		printString := casesToStrings at: case.
		label = (labels := (stringsToLabels at: printString) asArray) first ifTrue:
			[newCases addLast: { labels collect: [:ea| ea statements first]. case}]].

	^newCases! !

!TSwitchStmtNode methodsFor: 'instance initialization' stamp: 'eem 2/9/2009 16:30'!
expression: expr cases: aTBraceNode otherwiseOrNil: otherwiseOrNilNode

	self expression: expr.
	self cases: (self createCasesFromBraceNode: aTBraceNode).
	self otherwiseOrNil: otherwiseOrNilNode! !

!TSwitchStmtNode methodsFor: 'C code generation' stamp: 'eem 10/13/2013 18:35'!
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	"Emit the receiver as an if-the-else chain."
	| varName n |
	self assert: (expression isVariable or: [switchVariable notNil]).
	aStream nextPut: $(.
	switchVariable
		ifNil: [varName := String streamContents: [:s| expression emitCCodeOn: s level: 0 generator: aCodeGen].
			aStream nextPutAll: varName]
		ifNotNil:
			[varName := switchVariable.
			 aStream nextPut: $(; nextPutAll: varName; nextPutAll: ' = '.
			 expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
			 aStream nextPut: $)].
	n := 0.
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
			 (TStmtListNode new setArguments: #() statements: case statements)
			 	emitCCodeAsArgumentOn: aStream
				level: level + 2
				generator: aCodeGen.
			 aStream nextPut: $); crtab: level + n + 1; nextPutAll: ': ('.
			 n := n + 1]]
			valueWithArguments: tuple].
	otherwiseOrNil
		ifNotNil: [otherwiseOrNil emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause"), 0'].
	aStream next: n - 1 put: $)! !

!TSwitchStmtNode methodsFor: 'C code generation' stamp: 'eem 2/15/2009 10:41'!
emitCCodeOn: aStream addToEndOfCases: aNodeOrNil level: level generator: aCodeGen

	aStream crtab: level.
	aStream nextPutAll: 'switch ('.
	expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'.
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 aStream
				crtab: level;
				nextPutAll: 'case '.
			label emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen.
			aStream nextPut: $:].
		  aStream crtab: level + 1.
		  case emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level + 1 generator: aCodeGen]
			valueWithArguments: tuple.
		  (aNodeOrNil notNil and: [aNodeOrNil isReturn]) ifFalse:
			[aStream crtab: level + 1; nextPutAll: 'break;']].
	aStream
		crtab: level;
		nextPutAll: 'default:';
		crtab: level + 1.
	otherwiseOrNil
		ifNotNil: [otherwiseOrNil emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level + 1 generator: aCodeGen]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause");'.
			   aNodeOrNil ifNotNil:
				[aStream crtab: level + 1.
				 (aNodeOrNil copy setExpression: (TConstantNode new setValue: -1))
					emitCCodeOn: aStream level: level generator: aCodeGen.
				 aStream nextPut: $;]].
	aStream
		crtab: level;
		nextPut: $}! !

!TSwitchStmtNode methodsFor: 'C code generation' stamp: 'eem 2/13/2009 16:41'!
emitCCodeOn: aStream level: level generator: aCodeGen

	aStream crtab: level.
	aStream nextPutAll: 'switch ('.
	expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'.
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 aStream
				crtab: level;
				nextPutAll: 'case '.
			label emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen.
			aStream nextPut: $:].
		  aStream crtab: level + 1.
		  case emitCCodeOn: aStream level: level + 1 generator: aCodeGen.
		  case endsWithReturn ifFalse:
			[aStream tab: level + 1; nextPutAll: 'break;']]
			valueWithArguments: tuple].
	aStream
		crtab: level;
		nextPutAll: 'default:';
		crtab: level + 1.
	otherwiseOrNil
		ifNotNil:
			[otherwiseOrNil emitCCodeOn: aStream level: level + 1 generator: aCodeGen]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause");'].
	aStream
		crtab: level;
		nextPut: $}! !

!TSwitchStmtNode methodsFor: 'testing' stamp: 'eem 2/10/2009 07:58'!
isSwitch
	^true! !

!TSwitchStmtNode methodsFor: 'enumerating' stamp: 'eem 11/19/2012 12:12'!
nodesDo: aBlock
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	expression nodesDo: aBlock.
	cases do:
		[:pair|
		pair first do: [:node| node nodesDo: aBlock].
		pair last nodesDo: aBlock].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil nodesDo: aBlock].
	aBlock value: self! !

!TSwitchStmtNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:06'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	expression nodesDo: aBlock parent: self..
	cases do:
		[:pair|
		pair first do: [:node| node nodesDo: aBlock parent: self.].
		pair last nodesDo: aBlock parent: self.].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!TSwitchStmtNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:48'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	expression nodesDo: aBlock unless: cautionaryBlock.
	cases do:
		[:pair|
		pair first do: [:node| node nodesDo: aBlock unless: cautionaryBlock].
		pair last nodesDo: aBlock unless: cautionaryBlock].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil nodesDo: aBlock unless: cautionaryBlock]! !

!TSwitchStmtNode methodsFor: 'printing' stamp: 'eem 2/10/2009 19:17'!
printOn: aStream level: level

	aStream crtab: level.
	aStream nextPutAll: 'switch ('.
	expression printOn: aStream level: level.
	aStream nextPutAll: ') {'.
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 aStream
				crtab: level;
				nextPutAll: 'case '.
			label printOn: aStream level: level + 1.
			aStream nextPut: $:].
		  aStream crtab: level + 1.
		  case printOn: aStream level: level + 1.
		  aStream crtab: level + 1; nextPutAll: 'break;']
			valueWithArguments: tuple].
	otherwiseOrNil ifNotNil:
		[aStream
			crtab: level;
			nextPutAll: 'default:';
			crtab: level + 1.
		 otherwiseOrNil printOn: aStream level: level + 1].
	aStream
		crtab: level;
		nextPut: $}! !

!TVariableNode methodsFor: 'as yet unclassified' stamp: 'di 6/5/2000 16:56'!
bindVariableUsesIn: aDictionary

	^ (aDictionary at: name ifAbsent: [^ self]) copyTree! !

!TVariableNode methodsFor: 'as yet unclassified' stamp: 'sma 5/24/2000 23:42'!
bindVariablesIn: aDictionary 
	^ (aDictionary at: name ifAbsent: [^ self]) copyTree! !

!TVariableNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new setName: name! !

!TVariableNode methodsFor: 'as yet unclassified' stamp: 'JMM 4/5/2002 14:14'!
emitCCodeOn: aStream level: level generator: aCodeGen

	name = 'nil'
		ifTrue: [ aStream nextPutAll: (aCodeGen cLiteralFor: nil) ]
		ifFalse: [ aStream nextPutAll: (aCodeGen returnPrefixFromVariable: name) ].! !

!TVariableNode methodsFor: 'testing'!
isLeaf

	^true! !

!TVariableNode methodsFor: 'testing' stamp: 'eem 12/11/2010 12:28'!
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^aCodeGen structTargetKindForVariableName: name! !

!TVariableNode methodsFor: 'testing' stamp: 'eem 10/24/2013 13:02'!
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^aCodeGen structTargetKindForVariableName: name! !

!TVariableNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:28'!
mapReceiversIn: aDictionary
	"Remap the receiver, as when converting a send to objectMemory into a send to self"

	aDictionary
		at: name
		ifPresent: [:newName | name := newName]
! !

!TVariableNode methodsFor: 'accessing' stamp: 'acg 12/17/1999 07:18'!
nameOrValue

	^name! !

!TVariableNode methodsFor: 'accessing'!
setName: aString

	name := aString.! !

!TVariableNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:10'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	aBlock value: self value: parent! !

!TVariableNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream nextPutAll: name.! !

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
CCodeGenerator initialize!
TMethod initialize!
