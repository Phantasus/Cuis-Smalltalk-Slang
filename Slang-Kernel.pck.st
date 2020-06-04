'From Cuis 5.0 [latest update: #4112] on 4 June 2020 at 8:14:11 am'!
'Description Contains the fundamental basic infrastructure for Slang, without any tools or language specific translation mechanisms. With just the Kernel you can''t build a plugin, you need the specific translation packages.

License: MIT'!
!provides: 'Slang-Kernel' 1 3!
!requires: 'Cuis-Base' 50 4112 nil!
SystemOrganization addCategory: #'Slang-Kernel-Tests'!
SystemOrganization addCategory: #'Slang-Kernel'!


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

!classDefinition: #SlangModule category: #'Slang-Kernel'!
Object subclass: #SlangModule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangModule class' category: #'Slang-Kernel'!
SlangModule class
	instanceVariableNames: ''!

!classDefinition: #SlangPlugin category: #'Slang-Kernel'!
SlangModule subclass: #SlangPlugin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangPlugin class' category: #'Slang-Kernel'!
SlangPlugin class
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

!classDefinition: #SlangObject category: #'Slang-Kernel'!
Object subclass: #SlangObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangObject class' category: #'Slang-Kernel'!
SlangObject class
	instanceVariableNames: ''!

!classDefinition: #SlangCodeGenerator category: #'Slang-Kernel'!
SlangObject subclass: #SlangCodeGenerator
	instanceVariableNames: 'systemAdapter translationDict constants variables methods originClass useSymbolicConstants pools abstractDeclarations uncheckedAbstractMethods slangConformist'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangCodeGenerator class' category: #'Slang-Kernel'!
SlangCodeGenerator class
	instanceVariableNames: ''!

!classDefinition: #SlangConformist category: #'Slang-Kernel'!
SlangObject subclass: #SlangConformist
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangConformist class' category: #'Slang-Kernel'!
SlangConformist class
	instanceVariableNames: ''!

!classDefinition: #SlangLineStream category: #'Slang-Kernel'!
SlangObject subclass: #SlangLineStream
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangLineStream class' category: #'Slang-Kernel'!
SlangLineStream class
	instanceVariableNames: ''!

!classDefinition: #SlangPragmatizer category: #'Slang-Kernel'!
SlangObject subclass: #SlangPragmatizer
	instanceVariableNames: 'package selectors classes stampCutString stampInsertString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangPragmatizer class' category: #'Slang-Kernel'!
SlangPragmatizer class
	instanceVariableNames: ''!

!classDefinition: #SlangSystemAdapter category: #'Slang-Kernel'!
SlangObject subclass: #SlangSystemAdapter
	instanceVariableNames: 'logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangSystemAdapter class' category: #'Slang-Kernel'!
SlangSystemAdapter class
	instanceVariableNames: ''!

!classDefinition: #SlangTMethod category: #'Slang-Kernel'!
SlangObject subclass: #SlangTMethod
	instanceVariableNames: 'selector returnType args locals declarations primitive parseTree labels writtenToGlobalVarsCache complete export static sharedLabel sharedCase comment definingClass globalStructureBuildMethodHasFoo canAsmLabel mustAsmLabel properties cascadeVariableNumber extraVariableNumber'
	classVariableNames: 'CaseStatements'
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTMethod class' category: #'Slang-Kernel'!
SlangTMethod class
	instanceVariableNames: ''!

!classDefinition: #SlangTParseNode category: #'Slang-Kernel'!
SlangObject subclass: #SlangTParseNode
	instanceVariableNames: 'comment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTParseNode class' category: #'Slang-Kernel'!
SlangTParseNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTAssignmentNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTAssignmentNode
	instanceVariableNames: 'variable expression'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTAssignmentNode class' category: #'Slang-Kernel'!
SlangTAssignmentNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTBraceCaseNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTBraceCaseNode
	instanceVariableNames: 'caseLabels cases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTBraceCaseNode class' category: #'Slang-Kernel'!
SlangTBraceCaseNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTCaseStmtNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTCaseStmtNode
	instanceVariableNames: 'expression firsts lasts cases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTCaseStmtNode class' category: #'Slang-Kernel'!
SlangTCaseStmtNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTConstantNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTConstantNode
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTConstantNode class' category: #'Slang-Kernel'!
SlangTConstantNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTDefineNode category: #'Slang-Kernel'!
SlangTConstantNode subclass: #SlangTDefineNode
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTDefineNode class' category: #'Slang-Kernel'!
SlangTDefineNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTGoToNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTGoToNode
	instanceVariableNames: 'label'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTGoToNode class' category: #'Slang-Kernel'!
SlangTGoToNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTInlineNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTInlineNode
	instanceVariableNames: 'method'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTInlineNode class' category: #'Slang-Kernel'!
SlangTInlineNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTLabeledCommentNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTLabeledCommentNode
	instanceVariableNames: 'label'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTLabeledCommentNode class' category: #'Slang-Kernel'!
SlangTLabeledCommentNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTNotImplementedNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTNotImplementedNode
	instanceVariableNames: 'parseNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTNotImplementedNode class' category: #'Slang-Kernel'!
SlangTNotImplementedNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTReturnNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTReturnNode
	instanceVariableNames: 'expression'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTReturnNode class' category: #'Slang-Kernel'!
SlangTReturnNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTSendNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTSendNode
	instanceVariableNames: 'selector receiver arguments isBuiltinOperator isExpression'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTSendNode class' category: #'Slang-Kernel'!
SlangTSendNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTStmtListNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTStmtListNode
	instanceVariableNames: 'arguments statements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTStmtListNode class' category: #'Slang-Kernel'!
SlangTStmtListNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTSwitchStmtNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTSwitchStmtNode
	instanceVariableNames: 'expression cases otherwiseOrNil switchVariable'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTSwitchStmtNode class' category: #'Slang-Kernel'!
SlangTSwitchStmtNode class
	instanceVariableNames: ''!

!classDefinition: #SlangTVariableNode category: #'Slang-Kernel'!
SlangTParseNode subclass: #SlangTVariableNode
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Kernel'!
!classDefinition: 'SlangTVariableNode class' category: #'Slang-Kernel'!
SlangTVariableNode class
	instanceVariableNames: ''!


!SlangModule commentStamp: '<historical>' prior: 0!
This class represents the baseclass for Slang based objects. This means that the smalltalk used within the object is reduced and can be used for generating external code like C!

!SlangPlugin commentStamp: '<historical>' prior: 0!
Represents an internally Slang using object, which implements some kind of plugin. Subclasses define the exact pattern of the plugin which can be serialized out.!

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

!SlangObject commentStamp: '<historical>' prior: 0!
Base class for all the classes, which take some part in the Slang Smalltalk to translation target language framework and share common functionality. It's mainly used to split the system into the majority of parts which belong to the system and the parts which belong to Slang as this is the common base class.

Through this splitting adapters to the surrounding system can be implemented and parts can be exchanged, which increases portability.!

!SlangCodeGenerator commentStamp: '<historical>' prior: 0!
Represents a superclass of all possible code generators, which take in slang and can generate source code in different low-level programming languages, which have roughly the features of C.!

!SlangConformist commentStamp: '<historical>' prior: 0!
Conforms to what Slang is and knows about it.!

!SlangLineStream commentStamp: '<historical>' prior: 0!
Represents an output stream which puts out every input out as a new line!

!SlangPragmatizer commentStamp: 'dtl 9/25/2010 18:26' prior: 0!
Pragmatizer is a utility for converting message send directives (such as 'self inline: true') to their corresponding pragma implementations (<inline: true>) in method source.

The #depragmatize method provides a means for reverting to message send directives. This may be useful in the event of needing to load VMMaker into an image that does not support pragmas.

This is based on an original script provided by Eliot Miranda.!

!SlangSystemAdapter commentStamp: '<historical>' prior: 0!
I represent a service for dealing with the Smalltalk system on which Slang is currently running on.!

!SlangTMethod commentStamp: 'dtl 9/15/2008 09:06' prior: 0!
A TMethod is a translation method, representing a MethodNode that is to be translated to C source. It has a parseTree of translation nodes that mirrors the parse tree of the corresponding Smalltalk method.!

!SlangTParseNode commentStamp: 'dtl 9/15/2008 09:05' prior: 0!
A TParseNode is node in the parse tree of a TMethod. Subclasses correspond to different types of nodes in a method parse tree. The tree of translation parse nodes mirrors the parse tree of a Smalltalk method, and is used for translating a Smalltalk method to C source.!

!SlangTNotImplementedNode commentStamp: 'dtl 10/12/2010 19:37' prior: 0!
A TNotImplementedNode is a translation node for a parse node that cannot be translated, or for which translation is not yet implemented.
!

!SlangTSwitchStmtNode commentStamp: '<historical>' prior: 0!
I implement a Smalltalk
	foo caseOf: { [IntegerConstant | GlobalVariable] -> [expr] }
statement converting it into a C switch statement.  I make some effort to discover identical right-hand-side cases.!

!SlangTMethod methodsFor: 'accessing' stamp: 'hg 8/14/2000 15:57'!
comment: aComment

	comment _ aComment ! !

!SlangTMethod methodsFor: 'printing' stamp: 'TPR 3/2/2000 18:36'!
printOn: aStream

	super printOn: aStream.
	aStream nextPutAll: ' (', selector, ')'.! !

!SlangTParseNode methodsFor: 'accessing' stamp: 'hg 8/14/2000 15:32'!
comment: aComment

	comment _ aComment ! !

!SlangTParseNode methodsFor: 'printing'!
printOn: aStream 
	"Append a description of the receiver onto the given stream."

	self printOn: aStream level: 0.! !

!SlangTConstantNode methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:04'!
name
	^''! !

!SlangTDefineNode methodsFor: 'as yet unclassified' stamp: 'ar 7/8/2003 11:04'!
name
	^name! !

!SlangTSwitchStmtNode methodsFor: 'copying' stamp: 'eem 2/9/2009 19:26'!
postCopy
	expression _ expression copy.
	cases _ (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode copy].
				   pair last copy }]).
	otherwiseOrNil _ otherwiseOrNil copy! !

!SlangTVariableNode methodsFor: 'as yet unclassified'!
name

	^name! !

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

!SlangSystemServiceTest methodsFor: 'as yet unclassified' stamp: 'jpb 6/2/2020 07:45:52'!
testFindSlangDescriptionForClass
	| service |
	service _ usedClass new.
	
	self assert: 'SlangSystemAdapter Slang-Kernel'
		 equals: (service findSlangDescriptionBy: usedClass)! !

!SlangModule methodsFor: 'Slang syntax' stamp: 'jpb 5/16/2020 11:10:33'!
doNotGenerate
	"Annotates the method with the information, that it should not be generated. When running  in Smalltalk it does nothing"! !

!SlangModule methodsFor: 'Slang syntax' stamp: 'jpb 5/19/2020 22:54:59'!
export: aBoolean
	"Does nothing in Smalltalk. But marks the method in where this is called as to be exported to the outside world"! !

!SlangModule methodsFor: 'Slang syntax' stamp: 'jpb 5/16/2020 11:09:31'!
returnType: aSymbol 
	"Do nothing when running in Smalltalk. Annotates this method with the type of the method which returns"! !

!SlangModule methodsFor: 'as yet unclassified' stamp: 'jpb 5/24/2020 17:13:45'!
code: expression
	"Pass in the given code to the target language"! !

!SlangModule class methodsFor: 'Slang translation' stamp: 'jpb 5/15/2020 23:26:12'!
abstractSelectors
        "Selectors for abstract methods in this class"
        ^ #()! !

!SlangModule class methodsFor: 'Slang translation' stamp: 'jpb 5/15/2020 23:30:01'!
declareVarsIn: codeGenerator! !

!SlangModule class methodsFor: 'Slang translation' stamp: 'jpb 5/18/2020 15:28:59'!
initializeCodeGenerator: codeGenerator
        "Load a code generator with classes in a manner suitable for generating
        code for this class."

        | currentClass |
        currentClass _ self.
        [currentClass == SlangModule]
                whileFalse:
                        [codeGenerator addClass: currentClass.
                        currentClass _ currentClass superclass].

        "cg uncheckedAbstractMethods addAll: self uncheckedAbstractSelectors."
        ^codeGenerator
! !

!SlangModule class methodsFor: 'Slang translation' stamp: 'jpb 5/16/2020 22:24:46'!
moduleName
	"Answer the receiver's module name that is used for the plugin's C code."
	^self name asString! !

!SlangModule class methodsFor: 'Slang translation' stamp: 'jpb 5/15/2020 23:28:16'!
prepareToBeAddedToCodeGenerator: aSlangCCodeGeneratorGlobalStructure 
	"do nothing"! !

!SlangModule class methodsFor: 'Slang translation' stamp: 'jpb 5/16/2020 00:02:40'!
requiredMethodNames
	^self selectors! !

!SlangPlugin methodsFor: 'plugin lifecyle' stamp: 'jpb 5/27/2020 20:32:51'!
getModuleName
	"Returns the name of the module"! !

!SlangPlugin methodsFor: 'plugin lifecyle' stamp: 'jpb 5/27/2020 20:31:00'!
initialiseModule
	"Common entry point for plugins"! !

!SlangPlugin methodsFor: 'plugin lifecyle' stamp: 'jpb 5/27/2020 20:32:28'!
shutdownModule
	"Shutsdown the plugin. Frees internal memory, resets state, etc"! !

!SlangPlugin class methodsFor: 'as yet unclassified' stamp: 'jpb 5/18/2020 15:39:40'!
initializeCodeGenerator: codeGenerator
        "Load a code generator with classes in a manner suitable for generating
        code for this class."

        | currentClass |
        currentClass _ self.
        [currentClass == SlangPlugin]
                whileFalse:
                        [codeGenerator addClass: currentClass.
                        currentClass _ currentClass superclass].

        "cg uncheckedAbstractMethods addAll: self uncheckedAbstractSelectors."
        ^codeGenerator
! !

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

!SlangTestSupportInterpreter methodsFor: 'translation' stamp: 'jpb 6/1/2020 14:30:52'!
asCString: selector

	| method stream |
	method _ self findCodeGenerator findMethodNamed: selector.
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

!SlangTestSupportInterpreter class methodsFor: 'translation' stamp: 'jpb 6/1/2020 14:56:03'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg _ SlangCCodeGenerator new.
	cg declareMethodsStatic: false.
	cg permitMethodPruning: true.
	cg findAllUncheckedAbstractMethods addAll: self abstractSelectors.
	
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

!SlangTestSupportPlugin methodsFor: 'translation' stamp: 'jpb 6/1/2020 14:30:52'!
asCString: selector

	| method stream |
	method _ self findCodeGenerator findMethodNamed: selector.
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

!SlangTestSupportPlugin class methodsFor: 'translation' stamp: 'jpb 6/1/2020 14:36:35'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg _ SlangCCodeGenerator new initialize.
	cg declareMethodsStatic: false.
	cg permitMethodPruning: true.
	cg findAllUncheckedAbstractMethods addAll: self abstractSelectors.
	
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

!SlangCodeGenerator methodsFor: 'translation nodes' stamp: 'jpb 6/1/2020 13:58:55'!
newConstantNode
	^SlangTConstantNode new! !

!SlangCodeGenerator methodsFor: 'translation nodes' stamp: 'jpb 6/1/2020 13:58:28'!
newDefineNode
	^SlangTDefineNode new! !

!SlangCodeGenerator methodsFor: 'translation nodes' stamp: 'jpb 6/1/2020 14:33:02'!
translationMethodClass
	"return the class used to produce C translation methods from MethodNodes"
	^SlangTMethod! !

!SlangCodeGenerator methodsFor: 'composition' stamp: 'jpb 6/1/2020 14:25:16'!
addClass: aClass upTo: aSuperclass asInstanceVariable: varName
	"For an instance variable var in one of the classes that has been added to
	this code generator, assume that an instance of aClass would normally be
	assigned to that variable. Arrange for the methods in aClass and all superclasses
	up to but not including aSuperclass to be incorporated into the generated C source
	module as if they had been methods in the class with instance variable var.
	
	n.b. See #addStructureClass: mechanism in Cog."

	| cls |
	cls _ aClass.
	[cls == aSuperclass]
		whileFalse: [self addClass: cls.
				self mapVar: varName asInstanceOf: cls to: 'self'.
				cls _ cls superclass]! !

!SlangCodeGenerator methodsFor: 'composition' stamp: 'jpb 6/1/2020 14:23:50'!
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
	methods removeKey: selectorName! !

!SlangCodeGenerator methodsFor: 'error notifications' stamp: 'jpb 6/1/2020 14:36:35'!
checkAbstractMethods
	"For each method that has been declared abstract, ensure that a concrete
	implementation has been provided. This check should be performed prior to
	inlining because methods may be removed during the inlining process."

	| selectors |
	selectors _ methods keys, self findAllUncheckedAbstractMethods.
	abstractDeclarations do: [:sel |
		(selectors includes: sel)
			ifFalse: [self notify: 'missing implementation for ', sel]]
! !

!SlangCodeGenerator methodsFor: 'error notifications' stamp: 'jpb 6/1/2020 14:20:35'!
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

	"check for method name collisions"
	aClass selectors do:
		[:sel |
		((methods includesKey: sel) and:
			[ | meth |
			meth _ aClass compiledMethodAt: sel.
			"meth isAbstract" false not and: [(meth pragmaAt: #doNotGenerate) isNil]]) ifTrue:
				[self error: 'Method ', sel, ' was defined in a previously added class.']]! !

!SlangCodeGenerator methodsFor: 'method queries' stamp: 'jpb 6/2/2020 22:37:00'!
compileToTMethodSelector: selector in: aClass
	"Compile a method to a Translation Method"

	self subclassResponsibility ! !

!SlangCodeGenerator methodsFor: 'method queries' stamp: 'jpb 6/1/2020 14:36:35'!
findAllUncheckedAbstractMethods
	"Answer the selectors for methods that should not be checked to ensure existence
	of concrete implementations, such as methods that are generated directly by the
	code generator itself."

	^uncheckedAbstractMethods

! !

!SlangCodeGenerator methodsFor: 'method queries' stamp: 'jpb 6/1/2020 14:29:12'!
findAllUnreachableMethods
	"Return a collection of methods that are never invoked."

	| sent out |
	sent _ Set new.
	methods do: [ :m |
		m export ifTrue:[sent add: m selector].
		sent addAll: m allCalls.
	].

	out _ OrderedCollection new.
	methods keys do: [ :sel |
		(sent includes: sel) ifFalse: [ out add: sel ].
	].
	^ out! !

!SlangCodeGenerator methodsFor: 'method queries' stamp: 'jpb 6/1/2020 14:30:52'!
findMethodNamed: selector
	"Answer the method in the code base with the given selector."

	^ methods at: selector ifAbsent: [ nil ]! !

!SlangCodeGenerator methodsFor: 'public' stamp: 'jpb 6/1/2020 13:47:51'!
addAllClassVarsFor: aClass
	"Add the class variables for the given class (and its superclasses) to the code base as constants."

	| allClasses |
	allClasses _ aClass withAllSuperclasses.
	allClasses do: [:c | self addClassVarsFor: c].
! !

!SlangCodeGenerator methodsFor: 'public' stamp: 'jpb 6/1/2020 13:45:34'!
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
	originClass ifNil: [self originClass: aClass].
	
	'Adding Class ' , aClass name , '...'
		displayProgressAt: Sensor mousePoint
		from: 0
		to: aClass selectors size
		during:
			[:bar |
			 aClass selectors withIndexDo: [:sel :i |
				bar value: i.
				self addMethodFor: aClass selector: sel]].
		
	aClass declareVarsIn: self! !

!SlangCodeGenerator methodsFor: 'public' stamp: 'jpb 6/1/2020 13:50:18'!
addClass: aClass selectorPrefix: prefix
	"Incorporate the methods of aClass, and rename with prefixes reflecting the
	variable name. This is a simple transformation intended to support MemoryAccess,
	with renaming to avoid conflict with standard sqMemoryAccess.h macros."

	self addClass: aClass.
	aClass selectors do: [:sel |
		self renameSelector: sel
			as: (prefix, '_', sel) asSymbol].
! !

!SlangCodeGenerator methodsFor: 'public' stamp: 'jpb 6/1/2020 13:59:29'!
addClassVarsFor: aClass
	"Add the class variables for the given class to the code base as constants."
	| val node |
	aClass classPool associationsDo: [:assoc | 
		val _ assoc value.
		(useSymbolicConstants and:[self isLiteral: val])
			ifTrue:[node _ self newDefineNode setName: assoc key asString value: assoc value]
			ifFalse:[node _ self newConstantNode setValue: assoc value].
		constants at: assoc key asString put: node].
! !

!SlangCodeGenerator methodsFor: 'public' stamp: 'jpb 6/1/2020 14:13:24'!
addMethod: aTMethod
	"Add the given method to the code base."

	(methods includesKey:  aTMethod selector) ifTrue: [
		self error: 'Method name conflict: ', aTMethod selector.
	].
	methods at: aTMethod selector put: aTMethod.! !

!SlangCodeGenerator methodsFor: 'public' stamp: 'jpb 6/1/2020 14:49:43'!
addMethodFor: aClass selector: selector
	"Add the given method to the code base and answer its translation
	 or nil if it shouldn't be translated."

	| method tmethod |
	method _ aClass compiledMethodAt: selector.
	"Not implemented yet: 
	    method requiresConcreteImplementation ifTrue: [abstractDeclarations add: selector].
	   method isAbstract ifTrue: [^nil]."
	
	(method pragmaAt: #doNotGenerate) ifNotNil: [^nil].
	
	tmethod _ self compileToTMethodSelector: selector in: aClass.
	tmethod hasDoNotGenerateStatement ifTrue: [^nil].
	
	self addMethod: tmethod.
	
	^tmethod! !

!SlangCodeGenerator methodsFor: 'public' stamp: 'jpb 6/1/2020 14:04:52'!
addPoolVarsFor: aClass 
	"Add the pool variables for the given class to the code base as constants."

	(aClass sharedPools reject: [:pool| pools includes: pool]) do:
		[:pool |
		pools add: pool.
		pool bindingsDo: [:assoc | | val node |
			val _ assoc value.
			node _ (useSymbolicConstants and:[self isLiteral: val])
						ifTrue:[ self newDefineNode setName: assoc key asString value: assoc value]
						ifFalse:[ self newConstantNode setValue: assoc value].
			constants at: assoc key asString put: node]].! !

!SlangCodeGenerator methodsFor: 'initialization' stamp: 'jpb 6/2/2020 07:39:39'!
initialize
	systemAdapter _ SlangSystemAdapter new.
	
	constants _ Dictionary new: 100.
	variables _ OrderedCollection new: 100.
	methods _ Dictionary new: 500.
	
	pools _ IdentitySet new.
	useSymbolicConstants _ true.
	slangConformist _ systemAdapter newConformist.! !

!SlangCodeGenerator methodsFor: 'initialization' stamp: 'jpb 6/2/2020 07:43:45'!
initializeTranslationDictionary 
	"Initialize the dictionary mapping message names to actions for code generation."
	| pairs  |

	translationDict _ Dictionary new: 200.
	
	slangConformist addLogicOperatorsTo: translationDict.
	slangConformist addMathOperatorsTo: translationDict.
	slangConformist addBinaryOperatorsTo: translationDict.
	slangConformist addComparatorsTo: translationDict .
	
	slangConformist addIntervalOperatorsTo: translationDict.
	slangConformist addControlConstructsTo: translationDict.
	slangConformist addAccessorsTo: translationDict.
	slangConformist addConvertersTo: translationDict.
	
	slangConformist addMetaMarkersTo: translationDict.
	slangConformist addDelegatorsTo: translationDict.
	
	pairs _ #(	
	#sharedCodeNamed:inCase:		#generateSharedCodeDirective:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		translationDict at: (pairs at: i) put: (pairs at: i + 1)].! !

!SlangCodeGenerator methodsFor: 'slang queries' stamp: 'jpb 6/2/2020 07:54:49'!
isBuiltinSelector: selector
	"Answer true if the given selector is one of the builtin selectors."

	^(slangConformist isKernelSelector: selector) 
		or: [translationDict includesKey: selector]! !

!SlangConformist methodsFor: 'slang queries' stamp: 'jpb 6/2/2020 07:55:29'!
isKernelSelector: selector
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
		 coerce:to: coerceSimple:to:)
			includes: selector)! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:44:50'!
addAccessorsTo: dictionary
	"Adds the Slang operators to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#at:                   #generateAt:on:indent:
		#at:put:			#generateAtPut:on:indent:
		#basicAt:		#generateAt:on:indent:
		#basicAt:put:	#generateAtPut:on:indent:
		
		#integerValueOf:			#generateIntegerValueOf:on:indent:
		#integerObjectOf:			#generateIntegerObjectOf:on:indent:
		#isIntegerObject: 		#generateIsIntegerObject:on:indent:

		#addressOf:				#generateAddressOf:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:32:23'!
addBinaryOperatorsTo: dictionary
	"Adds the Slang operators to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#bitAnd:		            #generateBitAnd:on:indent:
		#bitOr:	                 #generateBitOr:on:indent:
		#bitXor:                  #generateBitXor:on:indent:
		#bitShift:		      #generateBitShift:on:indent:
		#signedBitShift:	#generateSignedBitShift:on:indent:
		#bitInvert32		#generateBitInvert32:on:indent:
		#bitClear:			#generateBitClear:on:indent:

		#<<			#generateShiftLeft:on:indent:
		#>>			#generateShiftRight:on:indent:
		#anyMask:			#generateBitAnd:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:34:20'!
addComparatorsTo: dictionary
	"Adds the Slang comparators to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#<					#generateLessThan:on:indent:
		#<=				#generateLessThanOrEqual:on:indent:
		#=					#generateEqual:on:indent:
		#>					#generateGreaterThan:on:indent:
		#>=				#generateGreaterThanOrEqual:on:indent:
		#~=				#generateNotEqual:on:indent:
		#==				#generateEqual:on:indent:
		#~~				#generateNotEqual:on:indent:
		#isNil			#generateIsNil:on:indent:
		#notNil			#generateNotNil:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:39:21'!
addControlConstructsTo: dictionary
	"Adds the Slang operators to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#ifTrue:	                #generateIfTrue:on:indent:
		#ifFalse:		     #generateIfFalse:on:indent:
		#ifTrue:ifFalse:	#generateIfTrueIfFalse:on:indent:
		#ifFalse:ifTrue:	#generateIfFalseIfTrue:on:indent:

		#whileTrue: 	#generateWhileTrue:on:indent:
		#whileFalse:	#generateWhileFalse:on:indent:
		#whileTrue 		#generateDoWhileTrue:on:indent:
		#whileFalse		#generateDoWhileFalse:on:indent:
		#to:do:			#generateToDo:on:indent:
		#to:by:do:		#generateToByDo:on:indent:
		#repeat 		     #generateRepeat:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:43:03'!
addConvertersTo: dictionary
	"Adds the Slang operators to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#coerce:to:				#generateCCoercion:on:indent:
		#coerceSimple:to:		#generateCCoercion:on:indent:
	
		#asFloat					#generateAsFloat:on:indent:
		#asInteger				#generateAsInteger:on:indent:
		#asUnsignedInteger	#generateAsUnsignedInteger:on:indent:
		#asSymbol				#generateAsSymbol:on:indent:	
		
		#signedIntFromLong		#generateSignedIntFromLong:on:indent:
		#signedIntToLong			#generateSignedIntToLong:on:indent:
		#signedIntFromShort		#generateSignedIntFromShort:on:indent:
		#signedIntToShort			#generateSignedIntToShort:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:53:57'!
addDelegatorsTo: dictionary
	"Adds the Slang meta translation markers to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#perform:				                           #generatePerform:on:indent:
		#perform:with:		                                #generatePerform:on:indent:
		#perform:with:with:	                           #generatePerform:on:indent:
		#perform:with:with:with:		           #generatePerform:on:indent:
		#perform:with:with:with:with:             #generatePerform:on:indent:
		#perform:with:with:with:with:with:	#generatePerform:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:36:52'!
addIntervalOperatorsTo: dictionary
	"Adds the Slang operators to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#min:		            #generateMin:on:indent:
		#max:			      #generateMax:on:indent:
		#between:and:	#generateBetweenAnd:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:25:10'!
addLogicOperatorsTo: dictionary
	"Adds the Slang operators to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#&				#generateAnd:on:indent:
		#|				#generateOr:on:indent:
		#and:			#generateSequentialAnd:on:indent:
		#or:			#generateSequentialOr:on:indent:
		#not			#generateNot:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:36:10'!
addMathOperatorsTo: dictionary
	"Adds the Slang operators to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#+				#generatePlus:on:indent:
		#-				#generateMinus:on:indent:
		#negated		#generateNegated:on:indent:
		#raisedTo:	#generateRaisedTo:on:indent:
	
		#*				#generateTimes:on:indent:
		#/				#generateDivide:on:indent:
		#//			#generateDivide:on:indent:
		#\\			#generateModulo:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangConformist methodsFor: 'translation setup' stamp: 'jpb 6/1/2020 22:50:31'!
addMetaMarkersTo: dictionary
	"Adds the Slang meta translation markers to the given dictionary with the mapping to specific generator methods for generating target code"
	| pairs |
	
	pairs _ #(
		#shouldNotImplement				#generateSmalltalkMetaError:on:indent:
		#shouldBeImplemented				#generateSmalltalkMetaError:on:indent:
		#inline:								#generateInlineDirective:on:indent:
		
		#touch:				#generateTouch:on:indent:
	).
	
	1 to: pairs size by: 2 do: [:i |
		dictionary at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangPragmatizer methodsFor: 'accessing' stamp: 'dtl 9/27/2010 13:41'!
classes: listOfClasses
	"If set, only the classes in this list will be modified. The classes are assumed to be
	classes in the package. This is intended to allow specifying one or more plugins
	in VMMaker-Plugins to be converted individually."

	classes _ listOfClasses! !

!SlangPragmatizer methodsFor: 'accessing' stamp: 'dtl 9/25/2010 11:19'!
stampCutString: stringToRemoveFromMethodStamp
	"If set, this substring will be removed from method stamps during conversion. This is
	intended to enable conversion to and from pragmas without repeated extension of the
	method stamp."

	stampCutString _ stringToRemoveFromMethodStamp! !

!SlangPragmatizer methodsFor: 'accessing' stamp: 'dtl 9/25/2010 12:49'!
stampInsertString: commentToInsert
	"If set, the commentToInsert will be used for method stamp modification
	rather than the default conversion value. This is intended to permit a
	Pragmatizer to reproduce a previous conversion, e.g. the previously converted
	methods in the Cog VM."

	stampInsertString _ commentToInsert
! !

!SlangPragmatizer methodsFor: 'convert pragmas to sends' stamp: 'dtl 9/27/2010 11:37'!
depragmatize
	"Convert methods from pragmas to old style message send directives, retaining
	original author initials and time stamps. Answer the methods that were modified."

	| instanceMethods |
	"Only instance side methods are translated, so ignore class side methods in the package"
	instanceMethods _ package methods
				reject: [:e | e classIsMeta
						or: [self isExcludedClass: e]].
	^ instanceMethods
		reject: [:mr | self depragmatize: mr]! !

!SlangPragmatizer methodsFor: 'convert pragmas to sends' stamp: 'dtl 9/25/2010 12:51'!
depragmatize: methodReference
	"Depragmatize the method. Answer true if the method was not modified, and false
	if conversion was performed."

	| method newSource newStamp pragmas stamp |
	pragmas _ OrderedCollection new.
	method _ methodReference compiledMethod.
	method properties keysAndValuesDo: [:sel :p |
		(selectors includes: sel)
			ifTrue: [pragmas add: p]].
	pragmas isEmpty ifTrue: [^ true].
	newSource _ pragmas
		inject: method getSourceFromFile asString
		into: [:src : pragma |
				src copyReplaceAll: pragma asString
					with: 'self ', pragma asString allButFirst allButLast, '.'].
		stamp _ method timeStamp.
		newStamp _ self newConvertToMessageSendStamp: stamp.
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

!SlangPragmatizer methodsFor: 'testing' stamp: 'dtl 9/27/2010 13:44'!
isExcludedClass: aMethodReference

	classes notNil
		and: [classes
				detect: [:cls | cls name = aMethodReference classSymbol]
				ifNone: [^ true]].
	^ false! !

!SlangPragmatizer methodsFor: 'method stamp' stamp: 'dtl 9/25/2010 13:06'!
newConvertToMessageSendStamp: oldStamp
	"Insert a comment in a method stamp to indicate that conversion from pragmas to old
	style message sends was done. If stampCutString has been set, remove this substring
	from the oldStamp prior to adding a new substring. If stampInsertString was set, use
	this as the substring to insert. Otherwise add a substring with current date and author
	initials." 

	| newStamp |
	stampCutString
		ifNil: [newStamp _ oldStamp]
		ifNotNil: [newStamp _ oldStamp copyReplaceAll: stampCutString with: ''].
	stampInsertString
		ifNil: [newStamp _ newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: '(remove pragmas ', Utilities authorInitials, ' ', Date today yyyymmdd, ') ']
		ifNotNil: [newStamp _ newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: stampInsertString].
	^ newStamp
! !

!SlangPragmatizer methodsFor: 'method stamp' stamp: 'dtl 9/25/2010 13:06'!
newConvertToPragmaStamp: oldStamp
	"Insert a comment in a method stamp to indicate that conversion to pragmas was done.
	If stampCutString has been set, remove this substring from the oldStamp prior to adding
	a new substring. If stampInsertString was set, use this as the substring to insert. Otherwise
	add a substring with current date and author initials." 

	| newStamp |
	stampCutString
		ifNil: [newStamp _ oldStamp]
		ifNotNil: [newStamp _ oldStamp copyReplaceAll: stampCutString with: ''].
	stampInsertString
		ifNil: [newStamp _ newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: '(auto pragmas ', Utilities authorInitials, ' ', Date today yyyymmdd, ') ']
		ifNotNil: [newStamp _ newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: stampInsertString].
	^ newStamp
! !

!SlangPragmatizer methodsFor: 'convert sends to pragmas' stamp: 'dtl 9/25/2010 18:05'!
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

!SlangPragmatizer methodsFor: 'convert sends to pragmas' stamp: 'dtl 9/27/2010 11:36'!
pragmatize
	"Convert methods to use pragmas, retaining original author initials and time stamps.
	Answer the methods that were modified."

	| instanceMethods |
	"Only instance side methods are translated, so ignore class side methods in the package"
	instanceMethods _ package methods
				reject: [:e | e classIsMeta
						or: [self isExcludedClass: e]].
	^ instanceMethods
		reject: [:mr | self pragmatize: mr]! !

!SlangPragmatizer methodsFor: 'convert sends to pragmas' stamp: 'dtl 9/25/2010 17:26'!
pragmatize: methodReference
	"Pragmatize the method. Answer true if the method was not modified, and false
	if conversion was performed."

	| method methodNode pragmaNodes sourceRanges ranges source newSource stamp newStamp |
	method _ methodReference compiledMethod.
	methodNode _ method methodNode.
	pragmaNodes _ SortedCollection
						sortBlock: [:a :b | (sourceRanges at: a) first <= (sourceRanges at: b) first].
	(sourceRanges _ methodNode rawSourceRanges)
		keysAndValuesDo: [:node :range | (node isMessageNode
					and: [selectors includes: node selector key])
				ifTrue: [pragmaNodes add: node]].
	^ pragmaNodes isEmpty
		ifFalse: [ranges _ (sourceRanges at: pragmaNodes first) first
								to: (sourceRanges at: pragmaNodes last) last.

				source _ method getSourceFromFile asString.
				"methodBodyStart _ method methodClass parserClass new
										parseMethodComment: source setPattern: [:ignored|];
										startOfNextToken.
				tempsStart _ source indexOf: $| startingAt: methodBodyStart.
				hasTemps _ tempsStart > 0 and: [tempsStart < ranges first]."
				(source copyFrom: ranges first - 5 to: ranges first - 1) ~= 'self ' ifTrue: [self halt].
				(ranges last < source size
					and: [(source indexOf: $. startingAt: ranges last) > (ranges last + 1)]) ifTrue: [self halt].
				newSource _ self newPragmatizedSourceFrom: source
							nodes: pragmaNodes
							nodeRanges: ranges.
				stamp _ method timeStamp.
				newStamp _ self newConvertToPragmaStamp: stamp.
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

!SlangSystemAdapter methodsFor: 'logging' stamp: 'jpb 5/24/2020 12:34:32'!
logWarning: logString
	"Logs the given logString to the configured logger mechanism as a warning"
	logger show: logString ; newLine.! !

!SlangSystemAdapter methodsFor: 'logging' stamp: 'jpb 5/20/2020 23:32:52'!
printUndefinedCalls: undefinedCalls
	"Notifies about the given undefined calls"

	Transcript newLine.
	undefinedCalls keys asSortedCollection do: [ :undefined |
		Transcript show: undefined, ' -- undefined method sent by:'; newLine.
		(undefinedCalls at: undefined) do: [ :caller |
			Transcript tab; show: caller; newLine.
		].
	].! !

!SlangSystemAdapter methodsFor: 'logging' stamp: 'jpb 5/20/2020 23:35:01'!
printUndefinedVariableReferences: undefinedRefs
	"Print the given undefined variable references"

	Transcript newLine.
	undefinedRefs keys asSortedCollection do: [ :var |
		Transcript show: var, ' -- undefined variable used in:'; newLine.
		(undefinedRefs at: var) do: [ :sel |
			Transcript tab; show: sel; newLine.
		].
	].! !

!SlangSystemAdapter methodsFor: 'logging' stamp: 'jpb 5/24/2020 09:05:17'!
showIntervalProgressUsing: aRange label: progressLabel do: aBlock
	progressLabel
		displayProgressAt: Sensor mousePoint
			from: aRange first
			to: aRange last
			during: aBlock! !

!SlangSystemAdapter methodsFor: 'logging' stamp: 'jpb 5/24/2020 09:20:42'!
showProgressIn: collection label: progressLabel do: aBlock
	"Shows a UI progress bar which is updated while the given collection is traversed. The label of the progress bar is set according to the given label"
	progressLabel
		displayProgressAt: Sensor mousePoint
			from: 0
			to: collection size
			during: [ :progress |
				collection withIndexDo: [ :item :itemIndex |
					aBlock value: progress value: item value: itemIndex ] ]! !

!SlangSystemAdapter methodsFor: 'queries' stamp: 'jpb 5/19/2020 17:36:01'!
findClassDescriptionByClass: sourceClass
	"Returns the description (class comment) of the source class"
	^sourceClass comment ! !

!SlangSystemAdapter methodsFor: 'queries' stamp: 'jpb 5/19/2020 17:41:19'!
findGeneratedAtString
	"Returns the timestamp string used for representing 'generate at X' where X is the time"

	^Time dateAndTimeNow printString.! !

!SlangSystemAdapter methodsFor: 'queries' stamp: 'jpb 5/19/2020 16:51:01'!
findPackageNameFor: aClass
	"Returns a package name for the given class"
	| foundPackage |
	foundPackage _ CodePackage packageOfClass: aClass ifNone: nil.
	
	^foundPackage isNil 
		ifTrue: [ 'unknown' ]
		ifFalse: [ foundPackage packageName ].! !

!SlangSystemAdapter methodsFor: 'queries' stamp: 'jpb 5/19/2020 21:14:02'!
findSlangDescriptionBy: aClass
	"Answer a suitable package stamp to include in the header."
	| packageName |
	
	packageName _ self findPackageNameFor: aClass.
	
	^aClass name , ' ' , packageName! !

!SlangSystemAdapter methodsFor: 'queries' stamp: 'jpb 5/19/2020 21:14:54'!
findSourceDescriptionBy: sourceClass
	"Returns the description for the sourceClass used in generated module source for describing the module"

	^[self findClassDescriptionByClass: sourceClass]
		on: MessageNotUnderstood
		do: [:ex| self findSlangDescriptionBy: sourceClass]! !

!SlangSystemAdapter methodsFor: 'queries' stamp: 'jpb 5/20/2020 23:24:17'!
isStructType: typeName
	"Returns if the given typeName is a struct"
	^false! !

!SlangSystemAdapter methodsFor: 'parsing' stamp: 'jpb 5/20/2020 23:11:00'!
parseSelector: selector in: aClass
	"Returns the parse node for the given selector of the class of the selector"
	^aClass parserClass new
		parse:  (aClass sourceCodeAt: selector)
           class: aClass.! !

!SlangSystemAdapter methodsFor: 'files' stamp: 'jpb 5/20/2020 22:34:32'!
openNewFileNamed: fileName
	"Opens the given fileName, when it existis overwrite it"
	| fileStream |
	
	fileStream _ SlangLineStream on: fileName asFileEntry forceWriteStream.
	fileStream ifNil: [Error signal: 'Could not open C code file: ', fileName].
	
	^fileStream.! !

!SlangSystemAdapter methodsFor: 'object create' stamp: 'jpb 6/2/2020 07:41:37'!
newConformist
	^SlangConformist new! !

!SlangSystemAdapter methodsFor: 'initialization' stamp: 'jpb 5/24/2020 12:34:25'!
initialize
	logger _ Transcript! !

!SlangTMethod methodsFor: 'accessing'!
args
	"The arguments of this method."

	^args! !

!SlangTMethod methodsFor: 'accessing' stamp: 'jpb 5/30/2020 17:00:58'!
declarationAt: aVariableName ifAbsent: absentValue
	^declarations at: aVariableName ifAbsent: absentValue! !

!SlangTMethod methodsFor: 'accessing' stamp: 'eem 3/3/2009 08:42'!
declarationAt: aVariableName  "<String>" put: aDeclaration "<String>" "^aDeclaration"
	^declarations at: aVariableName put: aDeclaration! !

!SlangTMethod methodsFor: 'accessing'!
declarations
	"The type declaration dictionary of this method."

	^declarations! !

!SlangTMethod methodsFor: 'accessing' stamp: 'ar 2/3/2001 17:29'!
definingClass
	^definingClass! !

!SlangTMethod methodsFor: 'accessing' stamp: 'ar 2/3/2001 17:29'!
definingClass: aClass
	definingClass _ aClass.! !

!SlangTMethod methodsFor: 'accessing' stamp: 'jm 11/24/1998 09:03'!
export

	^ export
! !

!SlangTMethod methodsFor: 'accessing' stamp: 'jpb 5/30/2020 17:00:34'!
findArgTypesWith: aCodeGen
	"Get the types of the parameters of this method"
	| default |
	default _ aCodeGen findDefaultVariableDeclarationString.

	^args collect: [ :a | self declarationAt: a ifAbsent: [ default ] ]! !

!SlangTMethod methodsFor: 'accessing'!
globalStructureBuildMethodHasFoo: number
	globalStructureBuildMethodHasFoo _ number! !

!SlangTMethod methodsFor: 'accessing'!
isComplete
	"A method is 'complete' if it does not contain any more inline-able calls."

	^complete! !

!SlangTMethod methodsFor: 'accessing' stamp: 'dtl 8/21/2011 17:43'!
isStaticIn: aCodeGen
	"If static has been explicitly set, honor that setting. Otherwise defer
	to the code generator for a default setting."
	^static ifNil: [aCodeGen declareMethodsStatic]! !

!SlangTMethod methodsFor: 'accessing' stamp: 'ar 5/9/2000 12:13'!
labels

	^labels! !

!SlangTMethod methodsFor: 'accessing' stamp: 'ar 5/9/2000 12:13'!
locals
	"The local variables of this method."

	^locals! !

!SlangTMethod methodsFor: 'accessing'!
parseTree
	"The parse tree of this method."

	^parseTree! !

!SlangTMethod methodsFor: 'accessing'!
parseTree: aNode
	"Set the parse tree of this method."

	parseTree _ aNode.! !

!SlangTMethod methodsFor: 'accessing' stamp: 'jm 2/12/98 11:56'!
primitive
	"The primitive number of this method; zero if not a primitive."

	^ primitive
! !

!SlangTMethod methodsFor: 'accessing'!
referencesGlobalStructIncrementBy: value
	globalStructureBuildMethodHasFoo _ globalStructureBuildMethodHasFoo + value.! !

!SlangTMethod methodsFor: 'accessing'!
referencesGlobalStructMakeZero
	globalStructureBuildMethodHasFoo _ 0! !

!SlangTMethod methodsFor: 'accessing'!
returnType
	"The type of the values returned by this method. This string will be used in the C declaration of this function."

	^returnType! !

!SlangTMethod methodsFor: 'accessing' stamp: 'eem 8/1/2008 10:34'!
returnType: aString
	"Set the type of the values returned by this method. This string will be used in the C declaration of this function."

	returnType _ aString! !

!SlangTMethod methodsFor: 'accessing'!
selector
	"The Smalltalk selector of this method."

	^selector! !

!SlangTMethod methodsFor: 'accessing'!
selector: newSelector

	selector _ newSelector.! !

!SlangTMethod methodsFor: 'accessing' stamp: 'dtl 12/21/2008 14:55'!
selectorForCodeGeneration
	"Subclasses may allow a directive to override the selector specification."

	^ selector! !

!SlangTMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:18'!
sharedCase
	^sharedCase! !

!SlangTMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:41'!
sharedCase: aNumber
	sharedCase _ aNumber.! !

!SlangTMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:18'!
sharedLabel
	^sharedLabel! !

!SlangTMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:40'!
sharedLabel: aString
	sharedLabel _ aString! !

!SlangTMethod methodsFor: 'accessing'!
statements

	parseTree isStmtList
		ifFalse: [ self error: 'expected method parse tree to be a TStmtListNode' ].
	((parseTree args = nil) or: [parseTree args isEmpty])
		ifFalse: [ self error: 'expected method parse tree to have no args' ].

	^parseTree statements! !

!SlangTMethod methodsFor: 'accessing' stamp: 'eem 2/10/2009 13:53'!
static: aBoolean
	static _ aBoolean! !

!SlangTMethod methodsFor: 'inlining support' stamp: 'eem 3/30/2013 11:56'!
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

!SlangTMethod methodsFor: 'inlining support' stamp: 'jpb 6/1/2020 14:30:52'!
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
				[(aCodeGen findMethodNamed: node selector) ifNotNil:
					[:method|
					 method
						computePossibleSideEffectsInto: writtenToVars
						visited: visitedSelectors
						in: aCodeGen]]].
	writtenToGlobalVarsCache _ writtenToVars copy! !

!SlangTMethod methodsFor: 'inlining support' stamp: 'dtl 9/19/2010 13:20'!
extractInlineDirective
	"Scan the top-level statements for an inlining directive of the form:

		self inline: <boolean>

	 and remove the directive from the method body. Return the argument of the directive or #dontCare if there is no inlining directive."

	| result newStatements methodDirectiveFound |
	sharedCase ifNotNil:[^false]. "don't auto-inline shared code; it gets handled specially"
	result _ #dontCare.
	methodDirectiveFound _ false.
	newStatements _ OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		(stmt isSend and: [stmt selector = #inline:]) ifTrue: [
			methodDirectiveFound _ true.
			result _ stmt args first value = true.
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

!SlangTMethod methodsFor: 'inlining support' stamp: 'dtl 8/25/2011 22:37'!
hasDoNotGenerateStatement
	"True if method has a #doNotGenerate statement, equivalent to pragma <doNotGenerate>
	or if it has a #subclassResponsibility statement."
	parseTree statements
		detect: [:stmt | stmt isSend
					and: [stmt selector = #doNotGenerate
						or: [stmt selector = #subclassResponsibility]]]
		ifNone: [^ false].
	^ true! !

!SlangTMethod methodsFor: 'inlining support' stamp: 'eem 7/30/2008 15:08'!
maySubstituteGlobal: globalVar in: aCodeGen
	"We can substitute globalVar into this method provided globalVar is only read, not written."

	writtenToGlobalVarsCache = nil ifTrue:
		[self computePossibleSideEffectsInto: (Set new: 50) visited: (Set new: 50) in: aCodeGen].
	^(writtenToGlobalVarsCache includes: globalVar) not! !

!SlangTMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:06'!
renameLabelsForInliningInto: destMethod
	"Rename any labels that would clash with those of the destination method."

	| destLabels usedLabels labelMap newLabelName |
	destLabels _ destMethod labels asSet.
	usedLabels _ destLabels copy.  "usedLabels keeps track of labels in use"
	usedLabels addAll: labels.
	labelMap _ Dictionary new: 100.
	self labels do: [ :l |
		(destLabels includes: l) ifTrue: [
			newLabelName _ self unusedNamePrefixedBy: 'l' avoiding: usedLabels.
			labelMap at: l put: newLabelName.
		].
	].
	self renameLabelsUsing: labelMap.! !

!SlangTMethod methodsFor: 'inlining support' stamp: 'jpb 5/26/2020 21:11:52'!
renameLabelsUsing: aDictionary
	"Rename all labels according to the old->new mappings of the given dictionary."

	labels _ labels collect: [ :label |
		(aDictionary includesKey: label) ifTrue: [ aDictionary at: label ] ifFalse: [ label ].
	].

	parseTree nodesDo: [ :node |
		(node isGoTo and: [aDictionary includesKey: node label]) ifTrue: [
			node setLabel: (aDictionary at: node label).
		].
		((node is: #Label) and: [aDictionary includesKey: node label]) ifTrue: [
			node setLabel: (aDictionary at: node label).
		].
	].! !

!SlangTMethod methodsFor: 'inlining support' stamp: 'jpb 5/28/2020 17:54:50'!
renameVariablesUsing: aDictionary
	"Rename all variables according to old->new mappings of the given dictionary."

	| newDecls newKey newValue |
	"map args and locals"
	args _ args collect: [ :arg |
		(aDictionary includesKey: arg) ifTrue: [ aDictionary at: arg ] ifFalse: [ arg ].
	].
	locals _ locals collect: [ :v |
		(aDictionary includesKey: v) ifTrue: [ aDictionary at: v ] ifFalse: [ v ].
	].
	"prevent runaway recursion, e.g. inlining a method with super send"
	locals size > 1000 ifTrue: [self error: 'recursive inlining in ', selector asString, ', too many locals'].

	"map declarations"
	newDecls _ declarations species new.
	declarations associationsDo: [ :assoc |
		(aDictionary includesKey: assoc key)
			ifTrue: [ newKey _ aDictionary at: assoc key.
					newValue _ assoc value replaceLastOccurrence: assoc key with: newKey.
					newDecls at: newKey put: newValue]
			ifFalse: [ newDecls add: assoc ].
	].
	declarations _ newDecls.

	"map variable names in parse tree"
	parseTree nodesDo: [ :node |
		((node is: #Variable) and:
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

!SlangTMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:07'!
renameVarsForCaseStmt
	"Rename the arguments and locals of this method with names like t1, t2, t3, etc. Return the number of variable names assigned. This is done to allow registers to be shared among the cases."

	| i varMap |
	i _ 1.
	varMap _ Dictionary new: 100.
	args, locals do: [ :v |
		varMap at: v put: ('t', i printString) asSymbol.
		i _ i + 1.
	].
	self renameVariablesUsing: varMap.
	^ i - 1! !

!SlangTMethod methodsFor: 'inlining support' stamp: 'eem 3/30/2013 11:57'!
renameVarsForInliningInto: destMethod except: doNotRename in: aCodeGen
	"Rename any variables that would clash with those of the destination method."

	| destVars usedVars varMap newVarName |
	destVars _ aCodeGen globalsAsSet copy.
	destVars addAll: destMethod locals.
	destVars addAll: destMethod args.
	usedVars _ destVars copy.  "keeps track of names in use"
	usedVars addAll: args; addAll: locals.
	varMap _ Dictionary new: 100.
	locals, args do:
		[ :v |
		((doNotRename includes: v) not
		  and: [destVars includes: v]) ifTrue:
			[newVarName _ self unusedNamePrefixedBy: v avoiding: usedVars.
			varMap at: v put: newVarName]].
	self renameVariablesUsing: varMap! !

!SlangTMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:07'!
renameVarsForInliningInto: destMethod in: aCodeGen
	"Rename any variables that would clash with those of the destination method."

	| destVars usedVars varMap newVarName |
	destVars _ aCodeGen globalsAsSet copy.
	destVars addAll: destMethod locals.
	destVars addAll: destMethod args.
	usedVars _ destVars copy.  "keeps track of names in use"
	usedVars addAll: args; addAll: locals.
	varMap _ Dictionary new: 100.
	args, locals do: [ :v |
		(destVars includes: v) ifTrue: [
			newVarName _ self unusedNamePrefixedBy: v avoiding: usedVars.
			varMap at: v put: newVarName.
		].
	].
	self renameVariablesUsing: varMap.! !

!SlangTMethod methodsFor: 'inlining support'!
unusedNamePrefixedBy: aString avoiding: usedNames
	"Choose a unique variable or label name with the given string as a prefix, avoiding the names in the given collection. The selected name is added to usedNames."

	| n newVarName |
	n _ 1.
	newVarName _ aString, n printString.
	[usedNames includes: newVarName] whileTrue: [
		n _ n + 1.
		newVarName _ aString, n printString.
	].
	usedNames add: newVarName.
	^ newVarName! !

!SlangTMethod methodsFor: 'utilities'!
allCalls
	"Answer a collection of selectors for the messages sent by this method."

	^parseTree allCalls! !

!SlangTMethod methodsFor: 'utilities' stamp: 'jpb 5/28/2020 18:05:30'!
freeVariableReferences
	"Answer a collection of variables referenced this method, excluding locals, arguments, and pseudovariables."

	| refs |
	refs _ Set new.
	parseTree nodesDo: [ :node |
		(node is: #Variable) ifTrue: [ refs add: node name asString ].
	].

	args do: [ :var | refs remove: var asString ifAbsent: [] ].
	locals do: [ :var | refs remove: var asString ifAbsent: [] ].
	#('self' 'nil' 'true' 'false') do: [ :var | refs remove: var ifAbsent: [] ].
	
	^ refs asSortedCollection! !

!SlangTMethod methodsFor: 'utilities' stamp: 'jpb 5/27/2020 21:17:29'!
hasNoCCode
	"Answer true if the receiver does not use inlined C or C declarations, which are not currently renamed properly by the the inliner."

	declarations isEmpty ifFalse: [ ^ false ].
	^ true! !

!SlangTMethod methodsFor: 'utilities'!
nodeCount
	"Answer the number of nodes in this method's parseTree (a rough measure of its size)."

	| cnt |
	cnt _ 0.
	parseTree nodesDo: [ :n | cnt _ cnt + 1 ].
	^cnt! !

!SlangTMethod methodsFor: 'utilities' stamp: 'jpb 5/28/2020 18:17:57'!
removeUnusedTemps
	"Remove all of the unused temps in this method. Answer a bag (why the hell a bag???) with the references."
	"After inlining some variable references are now obsolete, we could fix them there but the 
	code seems a bit complicated, the other choice to to rebuild the locals before extruding. This is done here"
	| refs |
	refs _ Bag new.
	"find all the variable names referenced in this method"
	
	parseTree nodesDo: [ :node |
		(node is: #Variable) ifTrue: [ refs add: node name asString ].
		node isStmtList ifTrue: [refs addAll: node args]].
	
	"add all the non-arg declarations (might be variables usedonly in cCode sections)"
	refs addAll:((self declarations keys) reject: [:e | self args includes: e]).
	"reset the locals to be only those still referred to"
	locals _ locals select: [:e | refs includes: e].
	
	^refs
! !

!SlangTMethod methodsFor: 'utilities' stamp: 'eem 2/11/2009 19:00'!
typeForSelf
	self assert: definingClass notNil.
	^[definingClass typeForSelf]
		on: MessageNotUnderstood
		do: [:ex| nil]! !

!SlangTMethod methodsFor: 'utilities'!
variablesAssignedTo
	"Answer a collection of variables assigned to by this method."

	| refs |
	refs _ Set new.
	parseTree nodesDo: [ :node |
		node isAssignment ifTrue: [ refs add: node variable name ].
	].
	^ refs! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 5/13/2020 22:41:58'!
argAssignmentsFor: meth args: argList in: aCodeGen
	"Return a collection of assignment nodes that assign the given argument expressions to the formal parameter variables of the given method."
	"Optimization: If the actual parameters are either constants or local variables in the target method (the receiver), substitute them directly into the body of meth. Note that global variables cannot be subsituted because the inlined method might depend on the exact ordering of side effects to the globals."

	| stmtList substitutionDict |
	stmtList _ OrderedCollection new: 100.
	substitutionDict _ Dictionary new: 100.
	meth args with: argList do: [ :argName :exprNode |
		(self isSubstitutableNode: exprNode intoMethod: meth in: aCodeGen) ifTrue: [
			substitutionDict at: argName put: exprNode.
			locals remove: argName.
		] ifFalse: [
			stmtList add: (SlangTAssignmentNode new
				setVariable: (SlangTVariableNode new setName: argName)
				expression: exprNode copyTree).
		].
	].
	meth parseTree: (meth parseTree bindVariablesIn: substitutionDict).
	^stmtList! !

!SlangTMethod methodsFor: 'inlining'!
checkForCompleteness: stmtLists in: aCodeGen
	"Set the complete flag if none of the given statement list nodes contains further candidates for inlining."

	complete _ true.
	stmtLists do: [ :stmtList |
		stmtList statements do: [ :node |
			(self inlineableSend: node in: aCodeGen) ifTrue: [
				complete _ false.  "more inlining to do"
				^self
			].
		].
	].
	parseTree nodesDo: [ :n |
		(self inlineableFunctionCall: n in: aCodeGen) ifTrue: [
			complete _ false.  "more inlining to do"
			^self
		].
	].! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 5/13/2020 22:41:58'!
exitVar: exitVar label: exitLabel
	"Replace each return statement in this method with an assignment to the exit variable followed by a goto to the given label. Return true if a goto was generated."
	"Optimization: If exitVar is nil, the return value of the inlined method is not being used, so don't add the assignment statement."

	| newStmts labelUsed |
	labelUsed _ false.
	parseTree nodesDo: [ :node |
		node isStmtList ifTrue: [
			newStmts _ OrderedCollection new: 100.
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
							(SlangTAssignmentNode new
								setVariable: (SlangTVariableNode new setName: exitVar)
								expression: stmt expression).
					].
					(stmt == parseTree statements last) ifFalse: [
						"generate a goto (this return is NOT the last statement in the method)"
						newStmts add: (SlangTGoToNode new setLabel: exitLabel).
						labelUsed _ true.
					].
				] ifFalse: [
					newStmts addLast: stmt.
				].
			].
			node setStatements: newStmts asArray.
		].
	].
	^labelUsed! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 6/1/2020 14:30:52'!
inlineCaseStatementBranchesIn: aCodeGen localizingVars: varsList

	| stmt sel meth newStatements maxTemp usedVars exitLabel v |
	maxTemp _ 0.
	parseTree nodesDo: [ :n |
		n isCaseStmt ifTrue: [
			n cases do: [ :stmtNode |
				stmt _ stmtNode statements first.
				stmt isSend ifTrue: [
					sel _ stmt selector.
					meth _ aCodeGen findMethodNamed: sel.
					"Note, original version of this method tested for #hasNoCCode. Removed
					the test to permit inlining methods that may contain automatically
					generated C code for type conversions. -dtl"
					((meth ~= nil) and:
					 [meth args size = 0]) ifTrue: [
						meth _ meth copy.
						meth hasReturn ifTrue: [
							exitLabel _ self unusedLabelForInliningInto: self.
							meth exitVar: nil label: exitLabel.
							labels add: exitLabel.
						] ifFalse: [ exitLabel _ nil ].

						meth renameLabelsForInliningInto: self.
						meth labels do: [ :label | labels add: label ].
						newStatements _ stmtNode statements asOrderedCollection.
						newStatements removeFirst.

						exitLabel ~= nil ifTrue: [
							newStatements addFirst:
								(SlangTLabeledCommentNode new
									setLabel: exitLabel comment: 'end case').
						].

						newStatements addFirst: meth asInlineNode.
						newStatements addFirst:
							(SlangTLabeledCommentNode new setComment: meth selector).
						stmtNode setStatements: newStatements.
					].
				].
			].
		].
	].
	usedVars _ (locals, args) asSet.
	1 to: maxTemp do: [ :i |
		v _ ('t', i printString).
		(usedVars includes: v) ifTrue: [ self error: 'temp variable name conflicts with an existing local or arg' ].
		locals addLast: v.
	].

	"make local versions of the given globals"
	varsList do: [ :var |
		(usedVars includes: var) ifFalse: [ locals addFirst: var asString ].
	].
! !

!SlangTMethod methodsFor: 'inlining'!
inlineCodeOrNilForStatement: aNode in: aCodeGen
	"If the given statement node can be inlined, answer the statements that replace it. Otherwise, answer nil."

	| stmts |
	aNode isReturn ifTrue: [
		(self inlineableSend: aNode expression in: aCodeGen) ifTrue: [
			stmts _ self inlineSend: aNode expression
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

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 6/1/2020 14:30:52'!
inlineFunctionCall: aSendNode in: aCodeGen
	"Answer the body of the called function, substituting the actual
	 parameters for the formal argument variables in the method body.
	 Assume caller has established that:
		1. the method arguments are all substitutable nodes, and
		2. the method to be inlined contains no additional embedded returns."

	| sel meth doNotRename argsForInlining substitutionDict |
	sel _ aSendNode selector.
	meth _ (aCodeGen findMethodNamed: sel) copy.
	doNotRename _ Set withAll: args.
	argsForInlining _ aSendNode argumentsForInliningCodeGenerator: aCodeGen.
	meth args with: argsForInlining do:
		[ :argName :exprNode |
		exprNode isLeaf ifTrue:
			[doNotRename add: argName]].
	meth renameVarsForInliningInto: self except: doNotRename in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth except: doNotRename.
	substitutionDict _ Dictionary new: meth args size * 2.
	meth args with: argsForInlining do:
		[ :argName :exprNode |
		substitutionDict at: argName put: exprNode.
		(doNotRename includes: argName) ifFalse:
			[locals remove: argName]].
	meth parseTree bindVariablesIn: substitutionDict.
	^meth statements first expression! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 6/1/2020 14:30:52'!
inlineSend: aSendNode directReturn: directReturn exitVar: exitVar in: aCodeGen
	"Answer a collection of statments to replace the given send. directReturn indicates that the send is the expression of a return statement, so returns can be left in the body of the inlined method. If exitVar is nil, the value returned by the send is not used; thus, returns need not assign to the output variable."

	| sel meth exitLabel labelUsed inlineStmts |
	sel _ aSendNode selector.
	meth _ (aCodeGen findMethodNamed: sel) copy.
	meth renameVarsForInliningInto: self in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth except: #().
	meth hasReturn ifTrue: [
		directReturn ifTrue: [
			"propagate the return type, if necessary"
			returnType = meth returnType ifFalse: [ self halt ].  "caller's return type should be declared by user"
			returnType _ meth returnType.
		] ifFalse: [
			exitLabel _ self unusedLabelForInliningInto: self.
			labelUsed _ meth exitVar: exitVar label: exitLabel.
			labelUsed
				ifTrue: [ labels add: exitLabel ]
				ifFalse: [ exitLabel _ nil ].
		].
		"propagate type info if necessary"
		((exitVar ~= nil) and: [meth returnType ~= 'sqInt']) ifTrue: [
			declarations at: exitVar put: meth returnType, ' ', exitVar.
		].
	].
	inlineStmts _ OrderedCollection new: 100.
	inlineStmts add: (SlangTLabeledCommentNode new setComment: 'begin ', sel).
	inlineStmts addAll:
		(self argAssignmentsFor: meth args: aSendNode args in: aCodeGen).
	inlineStmts addAll: meth statements.  "method body"
	(directReturn and: [meth endsWithReturn not]) ifTrue: [
		inlineStmts add: (SlangTReturnNode new setExpression: (SlangTVariableNode new setName: 'nil')).
	].
	exitLabel ~= nil ifTrue: [
		inlineStmts add:
			(SlangTLabeledCommentNode new
				setLabel: exitLabel comment: 'end ', meth selector).
	].
	^inlineStmts! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 6/1/2020 14:30:52'!
inlineableFunctionCall: aNode in: aCodeGen
	"Answer true if the given send node is a call to a 'functional' method--a method whose body is a single return statement of some expression and whose actual parameters can all be directly substituted."

	| m |
	aNode isSend ifFalse: [ ^false ].
	m _ aCodeGen findMethodNamed: aNode selector.  "nil if builtin or external function"
	((m ~= nil) and: [m isFunctional and: [aCodeGen mayInline: m selector]]) ifTrue: [
		aNode args do: [ :a | (self isSubstitutableNode: a intoMethod: m in: aCodeGen) ifFalse: [ ^false ]].
		^true
	] ifFalse: [
		^false
	].! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 6/1/2020 14:30:52'!
inlineableSend: aNode in: aCodeGen
	"Answer true if the given send node is a call to a method that can be inlined."

	| m |
	aNode isSend ifFalse: [ ^false ].
	m _ aCodeGen findMethodNamed: aNode selector.  "nil if builtin or external function"
	^(m ~= nil) and: [m isComplete and: [aCodeGen mayInline: m selector]]! !

!SlangTMethod methodsFor: 'inlining'!
isFunctional
	"Answer true if the receiver is a functional method. That is, if it consists of a single return statement of an expression that contains no other returns."

	(parseTree statements size = 1 and:
	 [parseTree statements last isReturn]) ifFalse: [ ^false ].
	parseTree statements last expression nodesDo: [ :n | n isReturn ifTrue: [ ^false ]].
	^true! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 5/28/2020 17:54:03'!
isSubstitutableNode: aNode
	"Answer true if the given parameter node is either a constant, a local variable, or a formal parameter of the receiver. Such parameter nodes may be substituted directly into the body of the method during inlining. Note that global variables cannot be subsituted because the inlined method might depend on the exact ordering of side effects to the globals."

	aNode isConstant ifTrue: [ ^true ].
	^(aNode is: #Variable) and:
		[(locals includes: aNode name) or:
		[args includes: aNode name]]! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 5/28/2020 17:54:22'!
isSubstitutableNode: aNode intoMethod: targetMeth in: aCodeGen
	"Answer true if the given parameter node is either a constant, a local variable, or a formal parameter of the receiver. Such parameter nodes may be substituted directly into the body of the method during inlining. Note that global variables cannot be subsituted into methods with possible side effects (i.e., methods that may assign to global variables) because the inlined method might depend on having the value of the global variable captured when it is passed in as an argument."

	| var |
	aNode isConstant ifTrue: [ ^ true ].

	aNode isVariable ifTrue: [
		var _ aNode name.
		((locals includes: var) or: [args includes: var]) ifTrue: [ ^ true ].
		(#(self true false nil) includes: var) ifTrue: [ ^ true ].
		(targetMeth maySubstituteGlobal: var in: aCodeGen) ifTrue: [ ^ true ].
	].

	"scan expression tree; must contain only constants, builtin ops, and inlineable vars"
	aNode nodesDo: [ :node |
		node isSend ifTrue: [
			node isBuiltinOperator ifFalse: [ ^false ].
		].
		(node is: #Variable) ifTrue: [
			var _ node name.
			((locals includes: var) or:
			 [(args includes: var) or:
			 [(#(self true false nil) includes: var) or:
			 [targetMeth maySubstituteGlobal: var in: aCodeGen]]]) ifFalse: [ ^ false ].
		].
		(node isConstant or: [(node is: #Variable) or: [node isSend]]) ifFalse: [ ^false ].
	].

	^ true! !

!SlangTMethod methodsFor: 'inlining' stamp: 'dtl 3/1/2014 18:22'!
removeUnreferencedDeclarations
	"Variables may have been eliminated during inlining. Remove declarations for those variables."
	declarations keys copy
		do: [:key | (args , locals includes: key)
				ifFalse: [declarations removeKey: key]]! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 5/27/2020 21:23:02'!
statementsListsForInliningIn: aCodeGen
	"Answer a collection of statement list nodes that are candidates for inlining.
	 Currently, we cannot inline into the argument blocks of and: and or: messages.
	 We do not want to inline code strings within cCode:inSmalltalk: blocks (those with a
	 proper block for the cCode: argument are inlined in MessageNode>>asTranslatorNodeIn:).
	 We do not want to inline code within assert: sends (because we want the assert to read nicely)."

	| stmtLists |
	stmtLists _ OrderedCollection new: 10.
	parseTree
		nodesDo:
			[:node|  node isStmtList ifTrue: [stmtLists add: node]]
		unless:
			[:node|  node isSend and: [aCodeGen isAssertSelector: node selector] ].
		
	parseTree nodesDo: [:node|
		node isSend ifTrue: [
			
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

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 6/1/2020 12:11:30'!
superExpansionNodeFor: aSelector args: argumentNodes
	"Answer the expansion of a super send.  Merge the super expansion's
	 locals, properties and comment into this method's properties."
	(definingClass superclass lookupSelector: aSelector)
		ifNil: [self error: 'superclass does not define super method']
		ifNotNil:
			[:superMethod| | superTMethod commonVars varMap |
			superTMethod _ superMethod methodNode asSlangTranslationMethodOfClass: self class.
			((argumentNodes allSatisfy: [:parseNode| parseNode isVariableNode])
			and: [(argumentNodes asOrderedCollection collect: [:parseNode| parseNode key]) = superTMethod args]) ifFalse:
				[self error: definingClass name, '>>',selector, ' args ~= ',
							superTMethod definingClass name, '>>', aSelector,
							(String with: $. with: Character cr),
							'For super expansions to be translated correctly each argument must be a variable with the same name as the corresponding argument in the super method.'].
			self mergePropertiesOfSuperMethod: superTMethod.
			(commonVars _ superTMethod locals intersection: self locals) notEmpty ifTrue:
				[varMap _ Dictionary new.
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
				comment _ comment
								ifNil: [superComment]
								ifNotNil: [superComment, comment]].
			superTMethod extraVariableNumber ifNotNil:
				[:scvn|
				extraVariableNumber _ extraVariableNumber ifNil: [scvn] ifNotNil: [:cvn| cvn + scvn]].
			superTMethod elideAnyFinalReturn.
			^superTMethod parseTree]! !

!SlangTMethod methodsFor: 'inlining' stamp: 'jpb 5/28/2020 16:24:10'!
tryToInlineMethodsIn: aCodeGen
	"Expand any (complete) inline methods called by this method. Set the complete bit when all inlining has been done. Return true if something was inlined."

	| stmtLists didSomething newStatements sendsToInline |
	didSomething _ false.
	sendsToInline _ Dictionary new: 100.
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
		[didSomething _ true.
		self removeUnreferencedDeclarations.
		parseTree _ parseTree replaceNodesIn: sendsToInline].

	didSomething ifTrue:
		[writtenToGlobalVarsCache _ nil.
		^didSomething].

	stmtLists _ self statementsListsForInliningIn: aCodeGen.
	stmtLists do:
		[:stmtList|
		newStatements _ OrderedCollection new: 100.
		stmtList statements do:
			[:stmt|
			(self inlineCodeOrNilForStatement: stmt in: aCodeGen)
				ifNil: [newStatements addLast: stmt]
				ifNotNil: [:inlinedStmts|
					didSomething _ true.
					newStatements addAllLast: inlinedStmts]].
		stmtList setStatements: newStatements asArray].

	didSomething ifTrue:
		[writtenToGlobalVarsCache _ nil.
		^didSomething].

	complete ifFalse:
		[self checkForCompleteness: stmtLists in: aCodeGen.
		 complete ifTrue: [ didSomething _ true ]].  "marking a method complete is progress"
	^didSomething! !

!SlangTMethod methodsFor: 'inlining'!
unusedLabelForInliningInto: targetMethod

	| usedLabels |
	usedLabels _ labels asSet.
	usedLabels addAll: targetMethod labels.
	^self unusedNamePrefixedBy: 'l' avoiding: usedLabels! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'ar 11/8/2010 18:38'!
argConversionExprFor: varName stackIndex: stackIndex 
	"Return the parse tree for an expression that fetches and converts the 
	primitive argument at the given stack offset."
	| exprList decl stmtList |
	exprList _ OrderedCollection new.
	(declarations includesKey: varName) ifTrue:[
		decl _ declarations at: varName.
		(decl includes: $*) ifTrue:["array"
			(decl includesSubString: 'char') ifTrue:[ | expr |
				expr _ '(interpreterProxy isBytes: (interpreterProxy stackValue: (stackIndex))) ifFalse:[^interpreterProxy primitiveFail].'.
				expr _ expr copyReplaceAll: 'interpreterProxy' with: self vmNameString.
				expr _ expr copyReplaceAll: 'stackIndex' with: stackIndex printString.
				exprList add: expr.
			].
			exprList add: varName , ' _ ', self vmNameString, ' arrayValueOf: (', self vmNameString, ' stackValue: (' , stackIndex printString , '))'.
			exprList add: varName , ' _ ' , varName , ' - 1'.
		] ifFalse:["must be a double"
			(decl findString: 'double' startingAt: 1) = 0 ifTrue: [
				self error: 'unsupported type declaration in a primitive method'
			].
			exprList add: varName , ' _ ', self vmNameString, ' stackFloatValue: ' , stackIndex printString.
		]
	] ifFalse: ["undeclared variables are taken to be integer"
		exprList add: varName , ' _ ', self vmNameString, ' stackIntegerValue: ' , stackIndex printString
	].
	stmtList _ OrderedCollection new.
	exprList do: [:e | stmtList addAll: (self statementsFor: e varName: varName)].
	^ stmtList! !

!SlangTMethod methodsFor: 'primitive compilation'!
checkSuccessExpr
	"Return the parse tree for an expression that aborts the primitive if the successFlag is not true."

	| expr |
	expr _ 'successFlag ifFalse: [^ nil ]'.
	^ self statementsFor: expr varName: ''
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'jpb 5/13/2020 22:41:33'!
covertToZeroBasedArrayReferences
	"Replace the index expressions in at: and at:put: messages with (<expr> - 1), since C uses zero-based array indexing."
	"Note: Up through release 1.31, generated primitives used the convention that array variables pointed to the first element. That meant that Smalltalk one-based index expressions had to have one subtracted to yield a zero-based index. Later, we decided to adjust the base address by -1 once in the primitive prolog rather on every array access. This resulted in a five percent performance increase for the bitmap compress/decompress primitives. This method is retained as documentation and in case we choose to revert the the previous scheme."

	| oldIndexExpr newIndexExpr |
	parseTree nodesDo: [ :n |
		(n isSend and: [(n selector = #at:) or: [ n selector = #at:put: ]]) ifTrue: [
			oldIndexExpr _ n args first.
			oldIndexExpr isConstant ifTrue: [
				"index expression is a constant: decrement the constant now"
				newIndexExpr _ SlangTConstantNode new setValue: (n args first value - 1).
			] ifFalse: [
				"index expression is complex: build an expression to decrement result at runtime"
				newIndexExpr _ SlangTSendNode new
					setSelector: #-
					receiver: oldIndexExpr
					arguments: (Array with: (SlangTConstantNode new setValue: 1)).
			].
			n args at: 1 put: newIndexExpr.
		].
	].
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'ar 4/4/2006 21:15'!
fetchRcvrExpr
	"Return the parse tree for an expression that fetches the receiver from the stack."

	| expr |
	expr _ 'rcvr _ ', self vmNameString, ' stackValue: (', args size printString, ')'.
	^ self statementsFor: expr varName: ''
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'jpb 5/13/2020 22:41:58'!
fixUpReturns: argCount postlog: postlog
	"Replace each return statement in this method with (a) the given postlog, (b) code to pop the receiver and the given number of arguments, and (c) code to push the integer result and return."

	| newStmts |
	parseTree nodesDo: [:node |
		node isStmtList ifTrue: [
			newStmts _ OrderedCollection new: 100.
			node statements do: [:stmt |
				stmt isReturn
					ifTrue: [
						(stmt expression isSend and:
						 ['primitiveFail' = stmt expression selector])
							ifTrue: [  "failure return"
								newStmts addLast: stmt expression.
								newStmts addLast: (SlangTReturnNode new
									setExpression: (SlangTVariableNode new setName: 'null'))]
							ifFalse: [  "normal return"
								newStmts addAll: postlog.
								newStmts addAll: (self popArgsExpr: argCount + 1).
								newStmts addLast: (SlangTSendNode new
									setSelector: #pushInteger:
									receiver: (SlangTVariableNode new setName: self vmNameString)
									arguments: (Array with: stmt expression)).
								newStmts addLast: (SlangTReturnNode new
									setExpression: (SlangTVariableNode new setName: 'null'))]]
					ifFalse: [
						newStmts addLast: stmt]].
			node setStatements: newStmts asArray]].
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'ar 4/4/2006 21:15'!
instVarGetExprFor: varName offset: instIndex
	"Return the parse tree for an expression that fetches and converts the value of the instance variable at the given offset."

	| exprList decl stmtList |
	exprList _ OrderedCollection new.
	(declarations includesKey: varName) ifTrue: [
		decl _ declarations at: varName.
		(decl includes: $*) ifTrue: [  "array"
			exprList add:
				(varName, ' _ ', self vmNameString, ' fetchArray: ', instIndex printString, ' ofObject: rcvr').
			exprList add: (varName, ' _ ', varName, ' - 1').
		] ifFalse: [  "must be a double"
			((decl findString: 'double' startingAt: 1) = 0)
				ifTrue: [ self error: 'unsupported type declaration in a primitive method' ].
			exprList add:
				(varName, ' _ ', self vmNameString, ' fetchFloat: ', instIndex printString, ' ofObject: rcvr').
		].
	] ifFalse: [  "undeclared variables are taken to be integer"
		exprList add:
			(varName, ' _ ', self vmNameString, ' fetchInteger: ', instIndex printString, ' ofObject: rcvr').
	].
	stmtList _ OrderedCollection new.
	exprList do: [:e | stmtList addAll: (self statementsFor: e varName: varName)].
	^ stmtList
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:13'!
instVarPutExprFor: varName offset: instIndex
	"Return the parse tree for an expression that saves the value of the integer instance variable at the given offset."

	| expr |
	(declarations includesKey: varName) ifTrue: [
		self error: 'a primitive method can only modify integer instance variables'.
	].
	expr _ '', self vmNameString, ' storeInteger: ', instIndex printString, ' ofObject: rcvr withValue: ', varName.
	^ self statementsFor: expr varName: varName
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:13'!
popArgsExpr: argCount
	"Return the parse tree for an expression that pops the given number of arguments from the stack."

	| expr |
	expr _ '', self vmNameString, ' pop: ', argCount printString.
	^ self statementsFor: expr varName: ''
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'ar 2/3/2001 17:33'!
preparePrimitiveName
	"Prepare the selector for this method in translation"
	| aClass |
	aClass _ definingClass.
	primitive = 117 
		ifTrue:[selector _ ((aClass includesSelector: selector)
					ifTrue: [aClass compiledMethodAt: selector]
					ifFalse: [aClass class compiledMethodAt: selector]) literals first at: 2.
				export _ true]
		ifFalse:[selector _ 'prim', aClass name, selector].

! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'eem 4/3/2013 16:10'!
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
	aClass _ definingClass.
	prolog _ OrderedCollection new.
	postlog _ OrderedCollection new.
	instVarsUsed _ self freeVariableReferences asSet.
	varsAssignedTo _ self variablesAssignedTo asSet.
	instVarList _ aClass allInstVarNames.
	primArgCount _ args size.

	"add receiver fetch and arg conversions to prolog"
	prolog addAll: self fetchRcvrExpr.
	1 to: args size do: [:argIndex |
		varName _ args at: argIndex.
		prolog addAll:
			(self argConversionExprFor: varName stackIndex: args size - argIndex)].

	"add success check to postlog"
	postlog addAll: self checkSuccessExpr.

	"add instance variable fetches to prolog and instance variable stores to postlog"
	1 to: instVarList size do: [:varIndex |
		varName _ instVarList at: varIndex.
		(instVarsUsed includes: varName) ifTrue: [
			locals add: varName.
			prolog addAll: (self instVarGetExprFor: varName offset: varIndex - 1).
			(varsAssignedTo includes: varName) ifTrue: [
				postlog addAll: (self instVarPutExprFor: varName offset: varIndex - 1)]]].
	prolog addAll: self checkSuccessExpr.

	((locals includes: 'rcvr') or: [(locals intersection: args) notEmpty]) ifTrue:
		[self error: 'local name conflicts with instance variable name'].
	locals add: 'rcvr'; addAll: args.
	args _ args class new.
	endsWithReturn _ self endsWithReturn.
	self fixUpReturns: primArgCount postlog: postlog.

	endsWithReturn
		ifTrue: [parseTree setStatements: prolog, parseTree statements]
		ifFalse: [
			postlog addAll: (self popArgsExpr: primArgCount).
			parseTree setStatements: prolog, parseTree statements, postlog].
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'jpb 5/13/2020 22:41:58'!
replaceSizeMessages
	"Replace sends of the message 'size' with calls to sizeOfSTArrayFromCPrimitive."

	| argExpr |
	parseTree nodesDo: [:n |
		(n isSend and: [n selector = #size]) ifTrue: [
			argExpr _ SlangTSendNode new
				setSelector: #+
				receiver: n receiver
				arguments: (Array with: (SlangTConstantNode new setValue: 1)).
			n
				setSelector: #sizeOfSTArrayFromCPrimitive:
				receiver: (SlangTVariableNode new setName: self vmNameString)
				arguments: (Array with: argExpr)]].
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'TPR 2/29/2000 18:47'!
statementsFor: sourceText varName: varName
	"Return the parse tree for the given expression. The result is the statements list of the method parsed from the given source text."
	"Details: Various variables are declared as locals to avoid Undeclared warnings from the parser."

	| s |
	s _ WriteStream on: ''.
	s nextPutAll: 'temp'; cr; cr; tab.
	self printTempsAndVar: varName on: s.
	s nextPutAll: sourceText.
	^ ((Compiler new parse: s contents in: Object notifying: nil)
			asTranslationMethodOfClass: self class) statements
! !

!SlangTMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:08'!
vmNameString
	"return the string to use as the vm name in code generated for this method"
	^'self'! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:40:56'!
asInlineNode
	^SlangTInlineNode new method: self! !

!SlangTMethod methodsFor: 'transformations'!
bindClassVariablesIn: constantDictionary
	"Class variables are used as constants. This method replaces all references to class variables in the body of this method with the corresponding constant looked up in the class pool dictionary of the source class. The source class class variables should be initialized before this method is called."

	parseTree _ parseTree bindVariablesIn: constantDictionary.! !

!SlangTMethod methodsFor: 'transformations' stamp: 'ar 7/6/2003 20:35'!
bindVariableUsesIn: aDictionary
	parseTree _ parseTree bindVariableUsesIn: aDictionary.! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:40:23'!
buildCaseStmt: aSendNode
	"Build a case statement node for the given send of dispatchOn:in:."
	"Note: the first argument is the variable to be dispatched on. The second argument is a constant node holding an array of unary selectors, which will be turned into sends to self."

	((aSendNode args size >= 2) and:
	 [aSendNode args second isConstant and:
	 [aSendNode args second value class = Array]]) ifFalse: [
		self error: 'wrong node structure for a case statement'.
	].

	^SlangTCaseStmtNode new
		setExpression: aSendNode args first
		selectors: aSendNode args second value
		arguments: (aSendNode args copyFrom: 3 to: aSendNode args size)! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/28/2020 18:04:47'!
buildSwitchStmt: aSendNode parent: parentNode
	"Build a switch statement node for the given send of caseOf: or caseOf:otherwise:."
	| switch |
	switch _ SlangTSwitchStmtNode new
				expression: aSendNode receiver
				cases: aSendNode args first
				otherwiseOrNil: (aSendNode args at: 2 ifAbsent: [nil]).
				
	((aSendNode receiver is: #Variable) or: [parentNode isStmtList]) ifFalse:
		[switch switchVariable: (locals add: (self extraVariableName: 'switch'))].
	^switch! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:36:18'!
checkLimitExpressionIn: aCodeGen on: node
	| limitExpr |
	limitExpr _ node args first.
	
	^(limitExpr anySatisfy: [:subNode|
		subNode isSend
		and: [(aCodeGen isBuiltinSelector: subNode selector) not
		and: [(subNode isStructSendIn: aCodeGen) not]]])! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:41:58'!
extractDirective: theSelector valueBlock: aBlock default: defaultResult
	"Find a pragma of the form:

		<theSelector[args]>

	 Answer the result of evaluating aBock with a TSendNode corresponding
	 to the pragma node, or defaultResult if there is no matching pragma."

	| result found newStatements |
	(properties at: theSelector ifAbsent: []) ifNotNil:
		[:pragma|
		^aBlock value: (SlangTSendNode new
							setSelector: pragma keyword
							receiver: (SlangTVariableNode new setName: 'self')
							arguments: (pragma arguments collect: [:const| SlangTConstantNode new setValue: const]))].
	"Pre-pragma backward compatibility:
	 Scan the top-level statements for a labelling directive of the form:

		self theSelector[args]

	 and remove the directive from the method body if found.
	 Answer the result of evaluating aBock with the send node,
	  or defaultResult if there is no labelling directive."	result _ defaultResult.
	found _ false.
	newStatements _ OrderedCollection new: parseTree statements size.
	parseTree statements do:
		[ :stmt |
		(stmt isSend
		 and: [stmt selector = theSelector])
			ifTrue:
				[found _ true.
				 result _ aBlock value: stmt]
			ifFalse:
				[newStatements add: stmt]].
	^found
		ifTrue:
			[parseTree setStatements: newStatements asArray.
			 result]
		ifFalse: [defaultResult]! !

!SlangTMethod methodsFor: 'transformations' stamp: 'eem 9/20/2008 18:26'!
extractExpandCaseDirective
	"Scan the top-level statements for an inlining directive of the form:
		self expandCases
	 and remove the directive from the method body. Answer whether
	 there was such a directive."

	^self
		extractDirective: #expandCases
		valueBlock: [:sendNode| true]
		default: false! !

!SlangTMethod methodsFor: 'transformations' stamp: 'dtl 9/19/2010 12:19'!
extractExportDirective
	"Scan the top-level statements for an inlining directive of the form:

		self export: <boolean>

	 and remove the directive from the method body. Return the argument of the directive or false if there is no export directive."

	| result newStatements methodDirectiveFound |
	result _ false.
	methodDirectiveFound _ false.
	newStatements _ OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		(stmt isSend and: [stmt selector = #export:]) ifTrue: [
			methodDirectiveFound _ true.
			result _ stmt args first value = true.
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

!SlangTMethod methodsFor: 'transformations' stamp: 'eem 11/18/2008 12:44'!
extractLabelDirective
	"Scan the top-level statements for an inlining directive of the form:

		self asmLabel: <boolean>

	 and remove the directive from the method body. Answer the
	 argument of the directive or true if there is no export directive."

	^self
		extractDirective: #asmLabel:
		valueBlock: [:sendNode| sendNode args first value ~= false and: [mustAsmLabel _ true. true]]
		default: true! !

!SlangTMethod methodsFor: 'transformations' stamp: 'ar 7/7/2003 00:56'!
extractSharedCase
	"Scan the top-level statements for an shared case directive of the form:

		self sharedCodeNamed: <sharedLabel> inCase: <sharedCase>.

	and remove the directive from the method body."

	| newStatements |
	newStatements _ OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		(stmt isSend and: [stmt selector = #sharedCodeNamed:inCase:]) ifTrue: [
			sharedLabel _ stmt args first value.
			sharedCase _ stmt args last value
		] ifFalse: [
			newStatements add: stmt.
		].
	].
	parseTree setStatements: newStatements asArray.
	sharedCase ifNotNil:[
		args isEmpty ifFalse:[self error: 'Cannot share code sections in methods with arguments'].
	].! !

!SlangTMethod methodsFor: 'transformations' stamp: 'dtl 7/4/2012 10:58'!
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

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:46:06'!
isToByDoNode: node
 ^(node selector = #to:by:do:  and: [node args size = 4])! !

!SlangTMethod methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:38'!
mapReceiversIn: aDictionary
	parseTree mapReceiversIn: aDictionary.! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:58:26'!
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
				 node isSend ifTrue: [ self replaceSendsWithMappingsIn: aCodeGen on: node parent: parent ]]]! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:51:11'!
prepareToByDoLoopIn:  aCodeGen on: node
	(self checkLimitExpressionIn: aCodeGen on: node)
		ifTrue: [ | limitVar |
			limitVar _ node args last name.
			"n.b. Two loops in the same method may share the same variable
			for loop limit, so add the variable declaration only if not already
			declared by a previous loop. Assumes that the name of the loop
			limit variable (e.g. 'iLimiT') is unlikely to have been used as an actual
			instance variable elsewhere." 
			
			(locals includes: limitVar) ifFalse: [locals add: limitVar]]
		ifFalse: [ node arguments: node args allButLast ]! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/28/2020 19:55:47'!
recordDeclarations
	"Record C type declarations of the forms

		self returnType: 'float'.
		self var: #foo declare: 'float foo'
		self var: #foo type:'float'.

	 and remove the declarations from the method body."

	| newStatements |
	properties pragmas notEmpty ifTrue:
		[properties pragmas do:
			[:pragma|
			pragma keyword = #var:declare: ifTrue:
				[self declarationAt: pragma arguments first asString put: pragma arguments last].
			pragma keyword = #var:type: ifTrue:
				[| varName varType |
				varName _ pragma arguments first asString.
				varType _ pragma arguments last.
				varType last = $* ifFalse: [varType _ varType, ' '].
				self declarationAt: varName put: varType, varName].
			
			pragma keyword = #returnType: ifTrue:
				[returnType _ pragma arguments last].
			pragma keyword = #doNotGenerate: ifTrue:
				[locals remove: pragma arguments last]]].
	newStatements _ OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		| isDeclaration |
		isDeclaration _ false.
		stmt isSend ifTrue: [
			stmt selector = #var:declare: ifTrue: [
				isDeclaration _ true.
				self declarationAt: stmt args first value asString put: stmt args last value.
			].
			stmt selector = #var:type: ifTrue: [
				| varName varType |
				isDeclaration _ true.
				varName _ stmt args first value asString.
				varType _ stmt args last value.
				varType last = $* ifFalse: [varType _ varType, ' '].
				self declarationAt: varName put: varType, varName.
			].
			stmt selector = #returnType: ifTrue: [
				isDeclaration _ true.
				returnType _ stmt args last value.
			].
		].
		isDeclaration ifFalse: [
			newStatements add: stmt.
		].
	].
	parseTree setStatements: newStatements asArray.! !

!SlangTMethod methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	parseTree removeAssertions! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/28/2020 17:54:29'!
removeFinalSelfReturn
	"The Smalltalk parser automatically adds the statement '^self' to the end of methods without explicit returns. This method removes such statements, since the generated code has no notion of 'self' anyway."

	| stmtList lastStmt |
	stmtList _ parseTree statements asOrderedCollection.
	lastStmt _ stmtList last.

	((lastStmt isReturn) and:
	 [(lastStmt expression is: #Variable) and:
	 ['self' = lastStmt expression name]]) ifTrue: [
		stmtList removeLast.
		parseTree setStatements: stmtList.
	].! !

!SlangTMethod methodsFor: 'transformations' stamp: 'dtl 8/20/2011 14:28'!
renameSelector: selectorName as: newSelectorName
	"Rename selectors such that generated code will use the newSelectorName. This
	is intended to allow methods that may have default implementations in the support
	code to be renamed for code generation, such that the renamed versions will
	be referenced rather than the default platform implementations. For example,
	if #pointerForOop: is implemented in Smalltalk, it may be renamed such that
	the generated pointerForOop() function will be renamed to avoid conflict with
	the standard definitions provided in sqMemoryAccess.h."

	selector = selectorName
		ifTrue: [selector _ newSelectorName].
	parseTree nodesDo: [:node |
			node
				renameSelector: selectorName
				as: newSelectorName ]
! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:53:09'!
replaceCaseStatementsOn: node parent: parent
	(CaseStatements includes: node selector) ifTrue:
		[parent replaceNodesIn: (Dictionary newFromPairs: { node. self buildCaseStmt: node})].! !

!SlangTMethod methodsFor: 'transformations' stamp: 'ar 7/6/2003 21:31'!
replaceNodesIn: map
	parseTree _ parseTree replaceNodesIn: map.! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:58:01'!
replaceSendsWithMappingsIn: aCodeGen on: node parent: parent
	(aCodeGen isBuiltinSelector: node selector)
		ifTrue: [
			node isBuiltinOperator: true.
			"If a to:by:do:'s limit has side-effects, declare the limit variable, otherwise delete it from the args"
			(self isToByDoNode: node) ifTrue: [ self prepareToByDoLoopIn: aCodeGen on: node ]]
		ifFalse: [
			self replaceCaseStatementsOn: node parent: parent.
			self replaceSwitchStatementsOn: node parent: parent. ]! !

!SlangTMethod methodsFor: 'transformations' stamp: 'jpb 5/13/2020 22:54:45'!
replaceSwitchStatementsOn: node parent: parent
	(#(caseOf: #caseOf:otherwise:) includes: node selector) ifTrue: [
		parent replaceNodesIn: (Dictionary newFromPairs: { node. self buildSwitchStmt: node parent: parent })]! !

!SlangTMethod methodsFor: 'copying' stamp: 'ar 7/6/2003 21:40'!
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

!SlangTMethod methodsFor: 'testing' stamp: 'eem 8/8/2008 12:02'!
endsWithReturn
	"Answer true if the last statement of this method is a return."

	^parseTree endsWithReturn! !

!SlangTMethod methodsFor: 'testing'!
hasReturn
	"Answer true if this method contains a return statement."

	parseTree nodesDo: [ :n | n isReturn ifTrue: [ ^ true ]].
	^ false! !

!SlangTMethod methodsFor: 'testing' stamp: 'jpb 5/28/2020 17:44:01'!
is: query
	#Assertion = query
		ifTrue: [ ^(selector beginsWith: 'assert') or: [selector beginsWith: 'verify'] ].
		
	^super is: query! !

!SlangTMethod methodsFor: 'testing' stamp: 'eem 2/11/2009 21:20'!
isStructAccessor
	^[definingClass isAccessor: selector]
		on: MessageNotUnderstood
		do: [:ex| false]! !

!SlangTMethod methodsFor: 'C code generation' stamp: 'jpb 5/29/2020 21:07:03'!
emitCCodeOn: aStream generator: aCodeGen
	"Emit C code for this method onto the given stream. All calls to inlined methods should already have been expanded."

	aCodeGen currentMethod: self.
	self emitCCommentOn: aStream.	"place method comment before function"
	self emitCHeaderOn: aStream generator: aCodeGen.
	
	parseTree emitCCodeOn: aStream level: 1 generator: aCodeGen.
	
	"Ensure code is POSIX compliant"
	(self returnType = #void or: [self endsWithReturn])
		 ifFalse: [aStream tab: 1; nextPutAll: 'return null;'; newLine].
	
	aStream nextPutAll: '}'; newLine.! !

!SlangTMethod methodsFor: 'C code generation' stamp: 'jpb 5/29/2020 20:57:56'!
emitCCommentOn: aStream
	"Emit the transferred Smalltalk comments as C comments."

	comment ifNotNil: [
		aStream newLine; newLine.
		
		1 to: comment size do: [:index | 
			aStream 
				nextPutAll: '/*'; tab;
				nextPutAll: (comment at: index);
				nextPutAll: ' */';
				newLine ]]! !

!SlangTMethod methodsFor: 'C code generation' stamp: 'eem 2/12/2009 12:29'!
emitCFunctionPrototype: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	properties ifNotNil:
		[(properties at: #api: ifAbsent: []) ifNotNil:
			[:pragma|
			aStream nextPutAll: (pragma argumentAt: 1).
			^self]].
	self emitCFunctionPrototype: aStream generator: aCodeGen newlineBeforeName: false! !

!SlangTMethod methodsFor: 'C code generation' stamp: 'jpb 6/3/2020 00:06:26'!
emitCFunctionPrototype: aStream generator: aCodeGen newlineBeforeName: newlineBeforeName "<Boolean>"
	"Emit a C function header for this method onto the given stream."
	| defaultDeclaration |
	
	defaultDeclaration _ aCodeGen findDefaultVariableDeclarationString.

	export 
		ifTrue: [aStream nextPutAll: 'EXPORT('; nextPutAll: returnType; nextPut: $)]
		ifFalse: [
			(self isStaticIn: aCodeGen) ifTrue: [aStream nextPutAll: 'static '].
			aStream nextPutAll: returnType].
			
	newlineBeforeName ifTrue: [aStream newLine] ifFalse: [aStream space].
	
	(returnType last = $)
	and: [returnType includesSubString: (aCodeGen findFunctionNameFor: self selectorForCodeGeneration)]) ifTrue:
		["Hack fix for e.g. <returnType: 'void (*setInterruptCheckChain(void (*aFunction)(void)))()'>"
		 ^self].
	
	aStream
		nextPutAll: (aCodeGen findFunctionNameFor: self selectorForCodeGeneration);
		nextPut: $(.
		
	args isEmpty
		ifTrue: [aStream nextPutAll: #void]
		ifFalse:
			[args
				do: [:arg| aStream nextPutAll: (self declarationAt: arg ifAbsent: defaultDeclaration)]
				separatedBy: [ aStream nextPutAll: ', ' ]].
			
	aStream nextPut: $)! !

!SlangTMethod methodsFor: 'C code generation' stamp: 'jpb 5/30/2020 16:56:04'!
emitCHeaderOn: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	aStream newLine. 
	self emitCFunctionPrototype: aStream generator: aCodeGen.
	aStream nextPutAll: ' {'; newLine.

	locals do: [ :var | |declaration|
		aStream nextPutAll: '    '.
		declaration _ (declarations at: var ifAbsent: [
			aCodeGen findDefaultVariableDeclarationString , var]).
		
		aStream nextPutAll: declaration, ';'; newLine.
	].
	locals isEmpty ifFalse: [ aStream newLine ].! !

!SlangTMethod methodsFor: 'C code generation' stamp: 'ikp 6/9/2004 16:15'!
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

!SlangTMethod methodsFor: 'initialization' stamp: 'jpb 5/13/2020 22:41:58'!
newCascadeTempFor: aTParseNode
	| varNode |
	cascadeVariableNumber _ cascadeVariableNumber
								ifNil: [0]
								ifNotNil: [cascadeVariableNumber + 1].
	varNode _ SlangTVariableNode new setName: 'cascade', cascadeVariableNumber printString.
	aTParseNode isLeaf ifFalse:
		[declarations
			at: varNode name
			put: [:cg| self determineTypeFor: aTParseNode in: cg]].
	^varNode! !

!SlangTMethod methodsFor: 'initialization' stamp: 'jpb 6/3/2020 00:01:37'!
setSelector: sel definingClass: class args: argList locals: localList block: aBlockNode primitive: aNumber properties: methodProperties comment: aComment
	"Initialize this method using the given information."

	selector _ sel.
	definingClass _ class.
	returnType _ #int. 	 "assume return type is long for now"
	
	args _ argList asOrderedCollection collect: [:arg | arg key].
	locals _ (localList asSortedCollection: [:a :b| a key < b key]) collect: [:arg | arg key].
	declarations _ Dictionary new.
	
	"self addTypeForSelf." "<- Cog feature to be added later"
	primitive _ aNumber.
	properties _ methodProperties.
	comment _ aComment.
	parseTree _ aBlockNode asSlangTranslatorNodeIn: self.
	
	labels _ OrderedCollection new.
	complete _ false.  "set to true when all possible inlining has been done"
	export _ self extractExportDirective.
	static _ self extractStaticDirective.
	
	canAsmLabel _ self extractLabelDirective.
	self extractSharedCase.
	self removeFinalSelfReturn.	"must preceed recordDeclarations because this may set returnType"
	
	self recordDeclarations.
	globalStructureBuildMethodHasFoo _ 0! !

!SlangTMethod methodsFor: 'initialization' stamp: 'jm 2/12/98 11:55'!
setSelector: sel returnType: retType args: argList locals: localList declarations: decls primitive: primNumber parseTree: aNode labels: labelList complete: completeFlag
	"Initialize this method using the given information. Used for copying."

	selector _ sel.
	returnType _ retType.
	args _ argList.
	locals _ localList.
	declarations _ decls.
	primitive _ primNumber.
	parseTree _ aNode.
	labels _ labelList.
	complete _ completeFlag.! !

!SlangTMethod methodsFor: 'private' stamp: 'TPR 2/29/2000 18:45'!
printTempsAndVar: varName on: aStream 
	"add the required temps and the varname to the stream"
	aStream nextPutAll: '| rcvr stackPointer successFlag ' , varName , ' |';
	 cr! !

!SlangTMethod class methodsFor: 'class initialization' stamp: 'ar 11/18/1999 20:06'!
initialize
	"TMethod initialize"	
	CaseStatements _ IdentitySet new: 10.
	CaseStatements addAll: #(dispatchOn:in: dispatchOn:in:with: dispatchOn:in:with:with:).! !

!SlangTParseNode methodsFor: 'accessing' stamp: 'acg 12/17/1999 07:21'!
nameOrValue

	self error: 'object is neither variable nor constant'! !

!SlangTParseNode methodsFor: 'testing' stamp: 'eem 2/11/2009 15:24'!
endsWithReturn

	^false! !

!SlangTParseNode methodsFor: 'testing' stamp: 'jpb 5/26/2020 20:20:38'!
is: query
	^#ParseNode = query or: [ super is: query ]! !

!SlangTParseNode methodsFor: 'testing' stamp: 'ikp 9/26/97 14:50'!
isAssignment

	^false! !

!SlangTParseNode methodsFor: 'testing'!
isCaseStmt

	^false! !

!SlangTParseNode methodsFor: 'testing'!
isConstant

	^false! !

!SlangTParseNode methodsFor: 'testing'!
isGoTo

	^false! !

!SlangTParseNode methodsFor: 'testing'!
isLeaf
	"Answer true if the receiver is a variable or a constant node."

	^false! !

!SlangTParseNode methodsFor: 'testing'!
isReturn

	^false! !

!SlangTParseNode methodsFor: 'testing' stamp: 'eem 8/8/2008 11:57'!
isReturningIf
	^false! !

!SlangTParseNode methodsFor: 'testing'!
isSend

	^false! !

!SlangTParseNode methodsFor: 'testing'!
isStmtList

	^false! !

!SlangTParseNode methodsFor: 'testing' stamp: 'eem 2/10/2009 07:58'!
isSwitch
	^false! !

!SlangTParseNode methodsFor: 'testing' stamp: 'jpb 5/26/2020 21:08:52'!
requiresCLineTerminator

	^ (self is: #Comment) not
! !

!SlangTParseNode methodsFor: 'testing' stamp: 'eem 12/11/2010 12:25'!
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^nil! !

!SlangTParseNode methodsFor: 'testing' stamp: 'eem 10/24/2013 13:02'!
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^nil! !

!SlangTParseNode methodsFor: 'printing'!
printOn: aStream level: anInteger 
	"Typically overridden. If control actually gets here, avoid recursion loop by sending to super."

	super printOn: aStream.! !

!SlangTParseNode methodsFor: 'utilities' stamp: 'eem 12/12/2012 12:15'!
allCalls
	"Answer a collection of selectors for the messages sent in this parse tree."

	| calls |
	calls _ Set new: 32.
	self nodesDo:
		[:node|
		node isSend ifTrue:
			[calls add: node selector].
		(node isConstant and: [node value isSymbol]) ifTrue:
			[calls add: node value]].
	^calls! !

!SlangTParseNode methodsFor: 'utilities'!
nodeCount
	"Answer the number of nodes in this parseTree (a rough measure of its size)."

	| cnt |
	cnt _ 0.
	self nodesDo: [ :n | cnt _ cnt + 1 ].
	^cnt! !

!SlangTParseNode methodsFor: 'enumerating' stamp: 'eem 3/29/2013 16:58'!
anySatisfy: aBlock
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^true]].
	^false! !

!SlangTParseNode methodsFor: 'enumerating'!
nodesDo: aBlock

	aBlock value: self.! !

!SlangTParseNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:01'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	self subclassResponsibility! !

!SlangTParseNode methodsFor: 'enumerating' stamp: 'eem 8/1/2013 11:02'!
nodesDo: aBlock unless: cautionaryBlock
	"Evaluate aBlock for all nodes in  the tree except those for which cautionaryBlock
	 answers true or are children of those for which cautionaryBlock answers true."
	(cautionaryBlock value: self) ifFalse:
		[aBlock value: self]! !

!SlangTParseNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:01'!
nodesWithParentsDo: aBlock
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	self nodesDo: aBlock parent: nil! !

!SlangTParseNode methodsFor: 'enumerating' stamp: 'eem 3/29/2013 16:58'!
noneSatisfy: aBlock
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^false]].
	^true! !

!SlangTParseNode methodsFor: 'converting' stamp: 'dtl 10/28/2006 18:50'!
asExpression
	"Sender expects to use this node as a simple expression rather than as as statement"

	^self! !

!SlangTParseNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:13'!
bindVariableUsesIn: aDictionary
	"Bind uses of all variables in the given dictionary, but do not change variables that appear on the left-hand-side of an assignment statement."

	^ self
! !

!SlangTParseNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	^self! !

!SlangTParseNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 14:43'!
mapReceiversIn: aDictionary
	^self! !

!SlangTParseNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	"default: do nothing"! !

!SlangTParseNode methodsFor: 'transformations' stamp: 'dtl 8/20/2011 13:48'!
renameSelector: selectorName as: newSelectorName
	"Rename selectors such that generated code will use the newSelectorName. This
	is intended to allow methods that may have default implementations in the support
	code to be renamed for code generation, such that the renamed versions will
	be referenced rather than the default platform implementations. For example,
	if #pointerForOop: is implemented in Smalltalk, it may be renamed such that
	the generated pointerForOop() function will be renamed to avoid conflict with
	the standard definitions provided in sqMemoryAccess.h."! !

!SlangTParseNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [self]! !

!SlangTParseNode methodsFor: 'as yet unclassified' stamp: 'nk 4/5/2005 21:01'!
copyTree
	self subclassResponsibility.! !

!SlangTParseNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	self! !

!SlangTParseNode methodsFor: 'as yet unclassified' stamp: 'jpb 5/16/2020 11:02:26'!
tabulateOn: aStream indent: level 
	"Print tabs on the given stream"
	| tab |
	tab _ Character tab.
	
	level timesRepeat: [aStream nextPut: tab]! !

!SlangTAssignmentNode methodsFor: 'transformations' stamp: 'mn 6/30/2000 13:19'!
bindVariableUsesIn: aDictionary
	"Do NOT bind the variable on the left-hand-side of an assignment statement."
	"was bindVariablesIn:"
	expression _ expression bindVariableUsesIn: aDictionary.
! !

!SlangTAssignmentNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	variable _ variable bindVariablesIn: aDictionary.
	expression _ expression bindVariablesIn: aDictionary.! !

!SlangTAssignmentNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 20:00'!
mapReceiversIn: aDictionary
	expression mapReceiversIn: aDictionary
! !

!SlangTAssignmentNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions

	expression removeAssertions! !

!SlangTAssignmentNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		variable _ variable replaceNodesIn: aDictionary.
		expression _ expression replaceNodesIn: aDictionary.
		self]! !

!SlangTAssignmentNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setVariable: variable copyTree
		expression: expression copyTree! !

!SlangTAssignmentNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	variable inlineMethodsUsing: aDictionary.
	expression inlineMethodsUsing: aDictionary.! !

!SlangTAssignmentNode methodsFor: 'accessing'!
expression

	^expression! !

!SlangTAssignmentNode methodsFor: 'accessing'!
setVariable: varNode expression: expressionNode

	variable _ varNode.
	expression _ expressionNode.! !

!SlangTAssignmentNode methodsFor: 'accessing'!
variable

	^variable! !

!SlangTAssignmentNode methodsFor: 'testing'!
isAssignment

	^true! !

!SlangTAssignmentNode methodsFor: 'testing' stamp: 'jpb 5/28/2020 17:53:08'!
isVariableUpdatingAssignment
	"Return true if this assignment statement is of one of the forms:
		var = var + ...
		var = var - ...
	Such assignments statements can exploit the C updating assignment operators. For example, 'x += 4' can be generated instead of 'x = x + 4'. This produces better code under some C compilers, most notably the CodeWarrior 68K compiler."

	| sel |
	(expression isSend and: [expression receiver is: #Variable]) ifFalse: [^ false].
	sel _ expression selector.
	^ (expression receiver name = variable name) and: [(sel = #+) or: [sel = #-]]! !

!SlangTAssignmentNode methodsFor: 'testing' stamp: 'eem 12/11/2010 12:25'!
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^variable structTargetKind: aCodeGen! !

!SlangTAssignmentNode methodsFor: 'testing' stamp: 'eem 10/24/2013 13:02'!
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^variable structTargetKindIn: aCodeGen! !

!SlangTAssignmentNode methodsFor: 'enumerating'!
nodesDo: aBlock

	variable nodesDo: aBlock.
	expression nodesDo: aBlock.
	aBlock value: self.! !

!SlangTAssignmentNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 16:59'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	variable nodesDo: aBlock parent: self.
	expression nodesDo: aBlock parent: self.
	aBlock value: self value: parent! !

!SlangTAssignmentNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:46'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	variable nodesDo: aBlock unless: cautionaryBlock.
	expression nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.! !

!SlangTAssignmentNode methodsFor: 'printing' stamp: 'ar 4/4/2006 21:12'!
printOn: aStream level: level

	variable printOn: aStream level: level.
	aStream nextPutAll: ' _ '.
	expression printOn: aStream level: level + 2.! !

!SlangTBraceCaseNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:13'!
bindVariableUsesIn: aDictionary

	caseLabels _ caseLabels collect: [:node| node bindVariableUsesIn: aDictionary].
	cases _ cases collect: [:node| node bindVariableUsesIn: aDictionary]! !

!SlangTBraceCaseNode methodsFor: 'transformations' stamp: 'eem 10/29/2012 11:38'!
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newCaseLabels newCases |
	newCaseLabels _ caseLabels collect: [:node| node bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	newCases _ cases collect: [:node| node bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	^(newCaseLabels = caseLabels
	   and: [newCases = cases])
		ifTrue: [self]
		ifFalse: [self shallowCopy
					caseLabels: newCaseLabels;
					cases: newCases;
					yourself]! !

!SlangTBraceCaseNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:12'!
bindVariablesIn: aDictionary

	caseLabels _ caseLabels collect: [:node| node bindVariablesIn: aDictionary].
	cases _ cases collect: [:node| node bindVariablesIn: aDictionary]! !

!SlangTBraceCaseNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 10:27'!
caseLabels
	"Answer the value of caseLabels"

	^ caseLabels! !

!SlangTBraceCaseNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 10:27'!
caseLabels: anObject
	"Set the value of caseLabels"

	caseLabels _ anObject! !

!SlangTBraceCaseNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 10:27'!
cases
	"Answer the value of cases"

	^ cases! !

!SlangTBraceCaseNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 10:27'!
cases: anObject
	"Set the value of cases"

	cases _ anObject! !

!SlangTBraceCaseNode methodsFor: 'copying' stamp: 'dtl 1/20/2014 15:03'!
copyTree

	self flag: #FIXME. "adopt from oscog - get rid of copyTree,  use postCopy instead"
	^self copy
! !

!SlangTBraceCaseNode methodsFor: 'enumerating' stamp: 'eem 11/19/2012 12:12'!
nodesDo: aBlock
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	caseLabels do:
		[:node| node nodesDo: aBlock].
	cases do:
		[:node| node nodesDo: aBlock].
	aBlock value: self! !

!SlangTBraceCaseNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:00'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	caseLabels do:
		[:node| node nodesDo: aBlock parent: self.].
	cases do:
		[:node| node nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!SlangTBraceCaseNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:47'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	caseLabels do:
		[:node| node nodesDo: aBlock unless: cautionaryBlock].
	cases do:
		[:node| node nodesDo: aBlock unless: cautionaryBlock].
	aBlock value: self! !

!SlangTBraceCaseNode methodsFor: 'enumerating' stamp: 'eem 2/11/2009 10:16'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		caseLabels _ caseLabels collect: [:node| node replaceNodesIn: aDictionary].
		cases _ cases collect: [:node| node replaceNodesIn: aDictionary].
		self]! !

!SlangTCaseStmtNode methodsFor: 'as yet unclassified' stamp: 'jpb 5/26/2020 21:08:39'!
assumesCurrentBytecodeMatchesCaseValue: statementList
	"Test for the special case of certain methods that rely on the value of
	the currentBytecode variable to be expanded to a constant. This is a
	performance optimization that permits the next bytecode to be fetched
	early while not affecting the prior value of currentBytecode, which
	will have been translated to a constant.
	
	See senders of #'requires currentBytecode to be expanded to a constant'
	for methods that rely on this behavior."

	| trickySelectors commentString firstLine |
	trickySelectors _ {
			#pushLiteralConstantBytecode .
			#pushLiteralVariableBytecode .
			#pushReceiverVariableBytecode .
			#pushTemporaryVariableBytecode .
			#storeAndPopTemporaryVariableBytecode .
			#storeAndPopReceiverVariableBytecode
		}.
	firstLine _ statementList statements first.
	(firstLine is: #Comment) ifTrue: [
		commentString _ firstLine asString.
		trickySelectors detect: [:e | commentString includesSubString: e]
			ifNone: [^ false].
		^ true].
	^ false! !

!SlangTCaseStmtNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setExpression: expression copyTree
		firsts: firsts copy
		lasts: lasts copy
		cases: (cases collect: [ :case | case copyTree ])! !

!SlangTCaseStmtNode methodsFor: 'as yet unclassified' stamp: 'jpb 5/13/2020 22:40:33'!
customizeCase: caseParseTree forVar: varName from: firstIndex to: lastIndex in: codeGen method: aTMethod
	"Return a collection of copies of the given parse tree, each of which has the value of the case index substituted for the given variable."

	| newCases dict newCase |
	newCases _ OrderedCollection new.
	firstIndex to: lastIndex do: [ :caseIndex |
		dict _ Dictionary new.
		dict at: varName put: (SlangTConstantNode new setValue: caseIndex).
		newCase _ caseParseTree copyTree bindVariableUsesIn: dict.
		self processSharedCodeBlocks: newCase forCase: caseIndex in: codeGen method: aTMethod.
		newCases addLast: newCase.
	].
	^ newCases! !

!SlangTCaseStmtNode methodsFor: 'as yet unclassified' stamp: 'dtl 7/3/2008 09:57'!
customizeShortCasesForDispatchVar: varName in: codeGen method: aTMethod
	"Make customized versions of a short bytecode methods, substituting a constant having the case index value for the given variable. This produces better code for short bytecodes such as instance variable pushes that encode the index of the instance variable in the bytecode."

	| newFirsts newLasts newCases l f case expanded |
	newFirsts _ OrderedCollection new.
	newLasts _ OrderedCollection new.
	newCases _ OrderedCollection new.
	1 to: cases size do: [ :i |
		l _ lasts at: i.
		f _ firsts at: i.
		case _ cases at: i.
		expanded _ false.
		(l - f) > 1 ifTrue: [  "case code covers multiple cases"
			(case nodeCount < 60
				or: [self assumesCurrentBytecodeMatchesCaseValue: case]) ifTrue: [
					newFirsts addAll: (f to: l) asArray.
					newLasts addAll: (f to: l) asArray.
					newCases addAll: (self customizeCase: case forVar: varName from: f to: l in: codeGen method: aTMethod).
					expanded _ true
			]
		].
		expanded ifFalse: [
			self processSharedCodeBlocks: case forCase: f in: codeGen method: aTMethod.
			newFirsts addLast: f.
			newLasts addLast: l.
			newCases addLast: case.
		]
	].
	firsts _ newFirsts asArray.
	lasts _ newLasts asArray.
	cases _ newCases asArray.
! !

!SlangTCaseStmtNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	expression inlineMethodsUsing: aDictionary.
	cases do: [ :c | c inlineMethodsUsing: aDictionary ].! !

!SlangTCaseStmtNode methodsFor: 'as yet unclassified'!
setExpression: aNode firsts: firstsList lasts: lastsList cases: caseList

	expression _ aNode.
	firsts _ firstsList.
	lasts _ lastsList.
	cases _ caseList.! !

!SlangTCaseStmtNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:26'!
bindVariableUsesIn: aDictionary

	expression _ expression bindVariableUsesIn: aDictionary.
	cases _ cases collect: [ :c | c bindVariableUsesIn: aDictionary ].! !

!SlangTCaseStmtNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	expression _ expression bindVariablesIn: aDictionary.
	cases _ cases collect: [ :c | c bindVariablesIn: aDictionary ].! !

!SlangTCaseStmtNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:38'!
mapReceiversIn: aDictionary
	expression mapReceiversIn: aDictionary.
	cases do: [ :c | c mapReceiversIn: aDictionary ]
! !

!SlangTCaseStmtNode methodsFor: 'transformations' stamp: 'jpb 6/1/2020 14:30:52'!
processSharedCodeBlocks: caseTree forCase: caseIndex in: codeGen method: aTMethod
	"Process any shared code blocks in the case parse tree for the given case, either inlining them or making them a 'goto sharedLabel'."
	| map meth sharedNode exitLabel |
	exitLabel _ nil.

	[sharedNode _ nil.
	map _ IdentityDictionary new.
	caseTree nodesDo:[:node|
		(node isSend 
			and:[(meth _ codeGen findMethodNamed: node selector) notNil
			and:[meth sharedCase notNil]]) ifTrue:[
			meth sharedCase = caseIndex ifTrue:[
				sharedNode _ meth.
				map at: node put: (SlangTLabeledCommentNode new setComment: 'goto ', meth sharedLabel).
			] ifFalse:[
				map at: node put: (SlangTGoToNode new setLabel: meth sharedLabel).
			].
		].
	].
	caseTree replaceNodesIn: map.
	"recursively expand"
	sharedNode == nil] whileFalse:[
		meth _ sharedNode copy.
		(meth hasReturn) ifTrue: [
			exitLabel ifNil:[
				exitLabel _ aTMethod unusedLabelForInliningInto: aTMethod.
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
			(SlangTLabeledCommentNode new setLabel: exitLabel comment: 'end case')).

	].! !

!SlangTCaseStmtNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	expression removeAssertions.
	cases do: [ :case | case removeAssertions ].! !

!SlangTCaseStmtNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		expression _ expression replaceNodesIn: aDictionary.
		cases _ cases collect: [ :c | c replaceNodesIn: aDictionary ].
		self]! !

!SlangTCaseStmtNode methodsFor: 'accessing'!
cases

	^cases! !

!SlangTCaseStmtNode methodsFor: 'accessing'!
expression

	^expression! !

!SlangTCaseStmtNode methodsFor: 'accessing' stamp: 'jpb 5/13/2020 22:41:58'!
setExpression: aNode selectors: selectorList arguments: anArray
	"Initialize the node from the given set of selectors."
	"Note: Each case is a statement list with containing one statement, a send to self of a selector from the given selector list. Having statement list nodes makes inlining easier later."

	| selfNode stmt lastSel firstInRun sel |
	expression _ aNode.
	selfNode _ SlangTVariableNode new setName: 'self'.
	firsts _ OrderedCollection new: 400.
	lasts _ OrderedCollection new: 400.
	cases _ OrderedCollection new: 400.
	lastSel _ selectorList first.
	firstInRun _ 0.
	1 to: selectorList size do: [ :i |
		sel _ selectorList at: i.
		sel ~= lastSel ifTrue: [
			firsts add: firstInRun.
			lasts add: i - 2.
			stmt _ SlangTSendNode new setSelector: lastSel receiver: selfNode arguments: anArray.
			cases add: (SlangTStmtListNode new setArguments: #() statements: (Array with: stmt)).
			lastSel _ sel.
			firstInRun _ i - 1.
		].
	].
	firsts add: firstInRun.
	lasts add: selectorList size - 1.
	stmt _ SlangTSendNode new setSelector: lastSel receiver: selfNode arguments: anArray.
	cases add: (SlangTStmtListNode new setArguments: #() statements: (Array with: stmt)).! !

!SlangTCaseStmtNode methodsFor: 'testing'!
isCaseStmt

	^true! !

!SlangTCaseStmtNode methodsFor: 'enumerating'!
nodesDo: aBlock

	expression nodesDo: aBlock.
	cases do: [ :c | c nodesDo: aBlock ].
	aBlock value: self.! !

!SlangTCaseStmtNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:00'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	expression nodesDo: aBlock parent: self.
	cases do: [:c| c nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!SlangTCaseStmtNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:47'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	expression nodesDo: aBlock unless: cautionaryBlock.
	cases do: [ :c | c nodesDo: aBlock  unless: cautionaryBlock].
	aBlock value: self! !

!SlangTCaseStmtNode methodsFor: 'printing'!
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

!SlangTConstantNode methodsFor: 'accessing' stamp: 'acg 12/17/1999 07:19'!
nameOrValue

	^value! !

!SlangTConstantNode methodsFor: 'accessing'!
setValue: anObject

	value _ anObject.! !

!SlangTConstantNode methodsFor: 'accessing'!
value

	^value! !

!SlangTConstantNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setValue: value! !

!SlangTConstantNode methodsFor: 'testing'!
isConstant

	^true! !

!SlangTConstantNode methodsFor: 'testing'!
isLeaf

	^true! !

!SlangTConstantNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:10'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	aBlock value: self value: parent! !

!SlangTConstantNode methodsFor: 'printing' stamp: 'eem 12/12/2012 11:23'!
printOn: aStream level: level
	value isSymbol
		ifTrue: [aStream nextPutAll: (value copyWithout: $:)]
		ifFalse: [value storeOn: aStream]! !

!SlangTDefineNode methodsFor: 'as yet unclassified' stamp: 'ar 7/8/2003 11:11'!
copyTree

	^self class new
		setName: name value: value! !

!SlangTDefineNode methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:05'!
name: aName
	name _ aName! !

!SlangTDefineNode methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:08'!
nameOrValue
	^name! !

!SlangTDefineNode methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:10'!
setName: aName value: aValue
	self name: aName.
	self setValue: aValue.! !

!SlangTGoToNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new setLabel: label! !

!SlangTGoToNode methodsFor: 'testing'!
isGoTo

	^true! !

!SlangTGoToNode methodsFor: 'accessing'!
label

	^label! !

!SlangTGoToNode methodsFor: 'accessing'!
setLabel: aString

	label _ aString.! !

!SlangTGoToNode methodsFor: 'enumerating' stamp: 'eem 10/25/2013 14:43'!
nodesDo: aBlock parent: parent
	aBlock value: self value: parent! !

!SlangTGoToNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.! !

!SlangTInlineNode methodsFor: 'transformations' stamp: 'ar 7/6/2003 20:34'!
bindVariableUsesIn: aDictionary
	method _ method bindVariableUsesIn: aDictionary.
! !

!SlangTInlineNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 14:43'!
mapReceiversIn: aDictionary
	method mapReceiversIn: aDictionary
! !

!SlangTInlineNode methodsFor: 'transformations' stamp: 'ar 7/6/2003 21:30'!
replaceNodesIn: map
	^map at: self ifAbsent: [
		method replaceNodesIn: map.
		self]! !

!SlangTInlineNode methodsFor: 'accessing' stamp: 'ar 7/6/2003 20:15'!
copyTree

	^self class new
		method: method copy! !

!SlangTInlineNode methodsFor: 'accessing' stamp: 'ar 7/6/2003 20:08'!
method
	^method! !

!SlangTInlineNode methodsFor: 'accessing' stamp: 'ar 7/6/2003 20:08'!
method: aTMethod
	method _ aTMethod! !

!SlangTInlineNode methodsFor: 'enumerating' stamp: 'ar 7/6/2003 20:36'!
nodesDo: aBlock
	method parseTree nodesDo: aBlock.
	aBlock value: self.! !

!SlangTInlineNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:47'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	method parseTree nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.! !

!SlangTInlineNode methodsFor: 'printing' stamp: 'ar 7/6/2003 22:00'!
printOn: aStream level: anInteger
	method parseTree printOn: aStream level: anInteger! !

!SlangTLabeledCommentNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setLabel: label
		comment: comment! !

!SlangTLabeledCommentNode methodsFor: 'as yet unclassified'!
unindentOneTab: aStream
	"Remove the last tab from the given stream if possible."

	(aStream isKindOf: ReadWriteStream) ifFalse: [ ^self ].
	aStream position > 0 ifTrue: [
		aStream position: aStream position - 1.
		"restore stream position if previous char was not a tab"
		aStream peek = Character tab ifFalse: [ aStream next ].
	].! !

!SlangTLabeledCommentNode methodsFor: 'testing' stamp: 'jpb 5/26/2020 21:10:36'!
is: query
	"Answer true if the receiver is just a comment (i.e., it has no label)."
	(query = #Comment and: [label = nil]) ifTrue: [^true].
	
	
	#Leaf = query ifTrue: [^true].
	#Label = query ifTrue: [^true].
	
	^super is: query! !

!SlangTLabeledCommentNode methodsFor: 'testing'!
isLeaf

	^true! !

!SlangTLabeledCommentNode methodsFor: 'accessing'!
label

	^label! !

!SlangTLabeledCommentNode methodsFor: 'accessing'!
setComment: commentString

	label _ nil.
	comment _ commentString.! !

!SlangTLabeledCommentNode methodsFor: 'accessing'!
setLabel: labelString

	label _ labelString.! !

!SlangTLabeledCommentNode methodsFor: 'accessing'!
setLabel: labelString comment: commentString

	label _ labelString.
	comment _ commentString.! !

!SlangTLabeledCommentNode methodsFor: 'enumerating' stamp: 'eem 10/25/2013 14:42'!
nodesDo: aBlock parent: parent
	aBlock value: self value: parent! !

!SlangTLabeledCommentNode methodsFor: 'printing'!
printOn: aStream level: level

	self printOptionalLabelOn: aStream.
	aStream nextPut: $".
	aStream nextPutAll: comment.
	aStream nextPut: $".! !

!SlangTLabeledCommentNode methodsFor: 'printing'!
printOptionalLabelOn: aStream

	label ~= nil ifTrue: [
		self unindentOneTab: aStream.
		aStream nextPutAll: label.
		aStream nextPut: $:.
		aStream tab.	
	].! !

!SlangTNotImplementedNode methodsFor: 'accessing' stamp: 'dtl 10/12/2010 19:40'!
parseNode
	"Answer the value of parseNode"

	^ parseNode! !

!SlangTNotImplementedNode methodsFor: 'accessing' stamp: 'dtl 10/12/2010 19:40'!
parseNode: anObject
	"Set the value of parseNode"

	parseNode _ anObject! !

!SlangTReturnNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:26'!
bindVariableUsesIn: aDictionary

	expression _ expression bindVariableUsesIn: aDictionary.! !

!SlangTReturnNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	expression _ expression bindVariablesIn: aDictionary.! !

!SlangTReturnNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:38'!
mapReceiversIn: aDictionary
	expression mapReceiversIn: aDictionary
! !

!SlangTReturnNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	expression removeAssertions! !

!SlangTReturnNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		expression _ expression replaceNodesIn: aDictionary.
		self]! !

!SlangTReturnNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setExpression: expression copyTree! !

!SlangTReturnNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	expression _ expression inlineMethodsUsing: aDictionary.! !

!SlangTReturnNode methodsFor: 'testing' stamp: 'eem 2/11/2009 15:24'!
endsWithReturn

	^true! !

!SlangTReturnNode methodsFor: 'testing'!
isReturn

	^true! !

!SlangTReturnNode methodsFor: 'accessing'!
expression

	^expression! !

!SlangTReturnNode methodsFor: 'accessing'!
setExpression: aNode

	expression _ aNode.! !

!SlangTReturnNode methodsFor: 'enumerating'!
nodesDo: aBlock

	expression nodesDo: aBlock.
	aBlock value: self.! !

!SlangTReturnNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:02'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	expression nodesDo: aBlock parent: self.
	aBlock value: self value: parent! !

!SlangTReturnNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:47'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	expression nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.! !

!SlangTReturnNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream nextPut: $^.
	expression printOn: aStream level: level.! !

!SlangTSendNode methodsFor: 'accessing'!
args

	^arguments! !

!SlangTSendNode methodsFor: 'accessing'!
copyTree

	^self class new
		setSelector: selector
		receiver: receiver copyTree
		arguments: (arguments collect: [ :arg | arg copyTree ])
		isBuiltInOp: isBuiltinOperator! !

!SlangTSendNode methodsFor: 'accessing' stamp: 'dtl 11/11/2009 20:59'!
isExpression
	"Answer the value of isExpression. True if this node is expected to be used
	as an expression. Normally false but may be set by #asExpression to indicate
	that this node should be translated as a simple expression rather than as
	a statement."

	^ isExpression ifNil: [isExpression _ false]! !

!SlangTSendNode methodsFor: 'accessing' stamp: 'dtl 11/7/2006 12:06'!
isExpression: anObject
	"Set the value of isExpression"

	isExpression _ anObject! !

!SlangTSendNode methodsFor: 'accessing'!
receiver

	^receiver! !

!SlangTSendNode methodsFor: 'accessing'!
receiver: aNode

	receiver _ aNode.! !

!SlangTSendNode methodsFor: 'accessing'!
selector

	^selector! !

!SlangTSendNode methodsFor: 'accessing'!
setSelector: aSymbol receiver: rcvrNode arguments: argList

	selector _ aSymbol.
	receiver _ rcvrNode.
	arguments _ argList asArray.
	isBuiltinOperator _ false.! !

!SlangTSendNode methodsFor: 'accessing'!
setSelector: aSymbol receiver: rcvrNode arguments: argList isBuiltInOp: builtinFlag

	selector _ aSymbol.
	receiver _ rcvrNode.
	arguments _ argList asArray.
	isBuiltinOperator _ builtinFlag.! !

!SlangTSendNode methodsFor: 'private' stamp: 'eem 10/29/2012 12:48'!
arguments: aSequence
	arguments _ aSequence! !

!SlangTSendNode methodsFor: 'inlining support' stamp: 'eem 2/11/2009 17:03'!
argumentsForInliningCodeGenerator: aCodeGen
	^(self shouldIncludeReceiverAsFirstArgument: aCodeGen)
		ifTrue: [{receiver}, arguments]
		ifFalse: [arguments]! !

!SlangTSendNode methodsFor: 'converting' stamp: 'dtl 11/7/2006 12:09'!
asExpression
	"Sender expects to use this node as a simple expression rather than as as statement"

	self isExpression: true.
	^self! !

!SlangTSendNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:26'!
bindVariableUsesIn: aDictionary

	receiver _ receiver bindVariableUsesIn: aDictionary.
	arguments _ arguments collect: [ :a | a bindVariableUsesIn: aDictionary ].! !

!SlangTSendNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	receiver _ receiver bindVariablesIn: aDictionary.
	arguments _ arguments collect: [ :a | a bindVariablesIn: aDictionary ].! !

!SlangTSendNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:39'!
mapReceiversIn: aDictionary
	receiver mapReceiversIn: aDictionary.
	arguments collect: [:a | a mapReceiversIn: aDictionary]! !

!SlangTSendNode methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	receiver removeAssertions.
	arguments do: [:arg | arg removeAssertions].! !

!SlangTSendNode methodsFor: 'transformations' stamp: 'dtl 8/20/2011 14:20'!
renameSelector: selectorName as: newSelectorName
	"Rename selectors such that generated code will use the newSelectorName. This
	is intended to allow methods that may have default implementations in the support
	code to be renamed for code generation, such that the renamed versions will
	be referenced rather than the default platform implementations. For example,
	if #pointerForOop: is implemented in Smalltalk, it may be renamed such that
	the generated pointerForOop() function will be renamed to avoid conflict with
	the standard definitions provided in sqMemoryAccess.h."

	selector = selectorName
		ifTrue: [selector _ newSelectorName]! !

!SlangTSendNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		receiver _ receiver replaceNodesIn: aDictionary.
		arguments _ arguments collect: [ :a | a replaceNodesIn: aDictionary ].
		self]! !

!SlangTSendNode methodsFor: 'testing' stamp: 'eem 2/11/2009 15:25'!
endsWithReturn
	^self isReturningIf! !

!SlangTSendNode methodsFor: 'testing' stamp: 'jpb 5/28/2020 17:43:20'!
is: query
	(#Assertion = query)
		ifTrue: [^ (selector beginsWith: 'assert') or: [selector beginsWith: 'verify'] ].
		
	^super is: query! !

!SlangTSendNode methodsFor: 'testing'!
isBuiltinOperator

	^ isBuiltinOperator! !

!SlangTSendNode methodsFor: 'testing'!
isBuiltinOperator: builtinFlag

	isBuiltinOperator _ builtinFlag.! !

!SlangTSendNode methodsFor: 'testing'!
isSend

	^true! !

!SlangTSendNode methodsFor: 'testing' stamp: 'jpb 6/1/2020 14:30:52'!
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
	   and: [(aCodeGen findMethodNamed: selector)
				ifNil: [false]
				ifNotNil: [:method| method isStructAccessor]]]! !

!SlangTSendNode methodsFor: 'testing' stamp: 'jpb 6/1/2020 14:30:52'!
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
	   and: [(aCodeGen findMethodNamed: selector)
				ifNil: [false]
				ifNotNil: [:method| method isStructAccessor]]]! !

!SlangTSendNode methodsFor: 'testing' stamp: 'jpb 5/27/2020 22:01:04'!
requiresCLineTerminator

	^ (self is: #Comment) not
! !

!SlangTSendNode methodsFor: 'testing' stamp: 'jpb 5/21/2020 11:17:58'!
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil.  Right now we don't need or support
	 structure return so this method answers either #pointer or nil."
	selector == #coerceSimple:to: ifTrue:
		[^(aCodeGen isType: arguments last value kind: #pointerToStruct) ifTrue:
			[#pointer]].

	^(aCodeGen selectorReturnsPointerToStruct: selector) ifTrue:
		[#pointer]! !

!SlangTSendNode methodsFor: 'testing' stamp: 'jpb 5/28/2020 17:55:14'!
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil.  Right now we don't need or support
	 structure return so this method answers either #pointer or nil."
	selector == #coerceSimple:to: ifTrue:
		[^(aCodeGen isType: arguments last value kind: #pointerToStruct) ifTrue:
			[#pointer]].

	selector == #addressOf: ifTrue:
		[^#pointer].

	selector == #at: ifTrue:
		[(receiver is: #Variable) ifTrue:
			[(aCodeGen typeOfVariable: receiver name) ifNotNil:
				[:type|
				 type last = $* ifFalse:
					[^receiver structTargetKindIn: aCodeGen].
				 (aCodeGen isVariable: receiver name inDeclaration: type allButLast kind: #struct ) ifTrue:
						[^#struct]]].
		(receiver structTargetKindIn: aCodeGen) ifNotNil:
			[:kind| ^kind]].

	(aCodeGen selectorReturnsPointerToStruct: selector) ifTrue:
		[^#pointer].

	(aCodeGen selectorReturnsStruct: selector) ifTrue:
		[^#struct].

	^nil! !

!SlangTSendNode methodsFor: 'enumerating'!
nodesDo: aBlock

	receiver nodesDo: aBlock.
	arguments do: [ :arg | arg nodesDo: aBlock ].
	aBlock value: self.! !

!SlangTSendNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:03'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	receiver nodesDo: aBlock parent: self.
	arguments do: [:arg| arg nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!SlangTSendNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 21:55'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	receiver nodesDo: aBlock unless: cautionaryBlock.
	arguments do: [ :arg | arg nodesDo: aBlock unless: cautionaryBlock].
	aBlock value: self.! !

!SlangTSendNode methodsFor: 'printing' stamp: 'eem 3/30/2013 14:11'!
printOn: aStream level: level
	| possiblyParenthesize |
	possiblyParenthesize _
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

!SlangTStmtListNode methodsFor: 'accessing'!
args

	^arguments! !

!SlangTStmtListNode methodsFor: 'accessing'!
setArguments: argList

	arguments _ argList.! !

!SlangTStmtListNode methodsFor: 'accessing'!
setArguments: argList statements: statementList
	"Initialize this method using the given information."

	arguments _ argList.
	statements _ statementList.! !

!SlangTStmtListNode methodsFor: 'accessing'!
setStatements: stmtList

	statements _ stmtList asOrderedCollection.! !

!SlangTStmtListNode methodsFor: 'accessing'!
statements

	^statements! !

!SlangTStmtListNode methodsFor: 'converting' stamp: 'dtl 10/28/2006 18:51'!
asExpression

	^ (self statements size = 1)
		ifTrue: [statements first]
		ifFalse: [self error: 'multiple statements can not serve as a simple expression']! !

!SlangTStmtListNode methodsFor: 'transformations' stamp: 'jm 12/10/1998 18:26'!
bindVariableUsesIn: aDictionary

	statements _ statements collect: [ :s | s bindVariableUsesIn: aDictionary ].! !

!SlangTStmtListNode methodsFor: 'transformations'!
bindVariablesIn: aDictionary

	statements _ statements collect: [ :s | s bindVariablesIn: aDictionary ].! !

!SlangTStmtListNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:39'!
mapReceiversIn: aDictionary
	statements do: [ :s | s mapReceiversIn: aDictionary ]
! !

!SlangTStmtListNode methodsFor: 'transformations' stamp: 'jpb 5/28/2020 17:41:37'!
removeAssertions
	| newStatements |
	newStatements _ OrderedCollection new: statements size.
	statements do: [ :stmt |
		(stmt is: #Assertion) ifFalse: [
			newStatements add: (stmt removeAssertions; yourself).
		]
	].
	self setStatements: newStatements asArray! !

!SlangTStmtListNode methodsFor: 'transformations'!
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		statements _ statements collect: [ :s | s replaceNodesIn: aDictionary ].
		self]! !

!SlangTStmtListNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new
		setArguments: arguments copy
		statements: (statements collect: [ :s | s copyTree ])! !

!SlangTStmtListNode methodsFor: 'as yet unclassified' stamp: 'jpb 5/29/2020 21:00:09'!
emitCCodeOn: aStream level: level generator: aCodeGen

	self emitCCommentOn: aStream level: level.
	
	statements do: [:s |
		s emitCCommentOn: aStream level: level.
		aStream tab: level.
		s emitCCodeOn: aStream level: level generator: aCodeGen.
		
		(((self endsWithCloseBracket: aStream) not
			and: [(s is: #Comment) not])
				and: [s requiresCLineTerminator])
			ifTrue: [aStream nextPut: $;].
		aStream newLine].
! !

!SlangTStmtListNode methodsFor: 'as yet unclassified'!
inlineMethodsUsing: aDictionary

	statements do: [ :s | s inlineMethodsUsing: aDictionary ].! !

!SlangTStmtListNode methodsFor: 'testing' stamp: 'jm 11/25/1998 16:26'!
endsWithCloseBracket: aStream
	"Answer true if the given stream ends in a $} character."

	| ch pos |
	(pos _ aStream position) > 0 ifTrue: [
		aStream position: pos - 1.
		ch _ aStream next].
	^ ch = $}
! !

!SlangTStmtListNode methodsFor: 'testing' stamp: 'dtl 12/28/2014 17:13'!
endsWithReturn
	"Answer true if the last statement of this lock is a return."

	^ statements isEmpty not
		and: [statements last isReturn
				or: [statements last isReturningIf]]! !

!SlangTStmtListNode methodsFor: 'testing' stamp: 'jpb 5/28/2020 17:55:34'!
isNilStmtListNode

	|stmt|
	statements size = 1 ifFalse: [^false].
	stmt _ statements at: 1.
	^ (stmt is: #Variable) and: [stmt name = 'nil']! !

!SlangTStmtListNode methodsFor: 'testing'!
isStmtList

	^true! !

!SlangTStmtListNode methodsFor: 'enumerating'!
nodesDo: aBlock

	statements do: [ :s | s nodesDo: aBlock ].	
	aBlock value: self.! !

!SlangTStmtListNode methodsFor: 'enumerating' stamp: 'eem 10/14/2013 15:02'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	statements do: [:s| s nodesDo: aBlock parent: self].
	aBlock value: self value: parent! !

!SlangTStmtListNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:46'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	statements do: [ :s | s nodesDo: aBlock unless: cautionaryBlock ].	
	aBlock value: self! !

!SlangTStmtListNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream nextPut: $[.
	arguments size > 0 ifTrue: [
		arguments do: [ :arg | aStream nextPutAll: ' :', arg ].
		aStream nextPutAll: ' | '.
	].
	self printStatementsOn: aStream level: level.
	aStream nextPut: $].! !

!SlangTStmtListNode methodsFor: 'printing' stamp: 'jpb 5/16/2020 11:03:25'!
printStatementsOn: aStream level: level

	statements size > 1 ifTrue: [
		aStream newLine.
		self tabulateOn: aStream indent: level + 1 ].
	1 to: statements size do: [ :i |
		(statements at: i) printOn: aStream level: level.
		i = statements size ifTrue: [
			(statements size > 1) ifTrue: [
				aStream newLine.
				self tabulateOn: aStream indent: level.
			].
		] ifFalse: [
			aStream nextPut: $..
			aStream newLine.
			self tabulateOn: aStream indent: level + 1.
		].
	].! !

!SlangTSwitchStmtNode methodsFor: 'copying' stamp: 'dtl 1/20/2014 15:02'!
copyTree

	self flag: #FIXME. "adopt from oscog - get rid of copyTree,  use postCopy instead"
	^self copy
! !

!SlangTSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:15'!
bindVariableUsesIn: aDictionary
	expression _ expression bindVariableUsesIn: aDictionary.
	cases _ (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode bindVariableUsesIn: aDictionary].
				   pair last bindVariableUsesIn: aDictionary }]).
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil _ otherwiseOrNil bindVariableUsesIn: aDictionary]! !

!SlangTSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 10/29/2012 12:55'!
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newExpression newCases newOtherwise |
	newExpression _ expression bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	newCases _ cases collect:
					[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
					{ pair first collect: [:labelNode| labelNode bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
					   pair last bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen}].
	newOtherwise _ otherwiseOrNil ifNotNil:
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

!SlangTSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:14'!
bindVariablesIn: aDictionary
	expression _ expression bindVariablesIn: aDictionary.
	cases _ (cases collect:
				[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
				{ pair first collect: [:labelNode| labelNode bindVariablesIn: aDictionary].
				   pair last bindVariablesIn: aDictionary }]).
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil _ otherwiseOrNil bindVariablesIn: aDictionary]! !

!SlangTSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 12:18'!
removeAssertions
	expression removeAssertions.
	cases do:
		[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
		pair first do: [:labelNode| labelNode removeAssertions].
		pair last removeAssertions].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil removeAssertions]! !

!SlangTSwitchStmtNode methodsFor: 'transformations' stamp: 'eem 2/11/2009 17:16'!
replaceNodesIn: aDictionary
	^aDictionary
		at: self
		ifAbsent:
			[expression _ expression replaceNodesIn: aDictionary.
			 cases _ (cases collect:
						[:pair| "<Array with: <Array with: ParseTreeNode> with: TStmtListNode"
						{ pair first collect: [:labelNode| labelNode replaceNodesIn: aDictionary].
						   pair last replaceNodesIn: aDictionary }]).
			 otherwiseOrNil ifNotNil:
				[otherwiseOrNil _ otherwiseOrNil replaceNodesIn: aDictionary].
			 self]! !

!SlangTSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
cases
	"Answer the value of cases"

	^ cases! !

!SlangTSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
cases: anObject
	"Set the value of cases"

	cases _ anObject! !

!SlangTSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
expression
	"Answer the value of expression"

	^ expression! !

!SlangTSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
expression: anObject
	"Set the value of expression"

	expression _ anObject! !

!SlangTSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
otherwiseOrNil
	"Answer the value of otherwiseOrNil"

	^ otherwiseOrNil! !

!SlangTSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 2/9/2009 15:56'!
otherwiseOrNil: anObject
	"Set the value of otherwiseOrNil"

	otherwiseOrNil _ anObject! !

!SlangTSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 10/13/2013 17:20'!
switchVariable
	"Answer the value of switchVariable"

	^ switchVariable! !

!SlangTSwitchStmtNode methodsFor: 'accessing' stamp: 'eem 10/13/2013 17:20'!
switchVariable: anObject
	"Set the value of switchVariable"

	switchVariable _ anObject! !

!SlangTSwitchStmtNode methodsFor: 'instance initialization' stamp: 'eem 2/9/2009 18:47'!
createCasesFromBraceNode: aTBraceNode
	| casesToStrings stringsToLabels newCases |
	casesToStrings _ Dictionary new.
	stringsToLabels _ Dictionary new.
	newCases _ OrderedCollection new: aTBraceNode caseLabels size.
	aTBraceNode caseLabels with: aTBraceNode cases do:
		[:label :case| | printString |
		printString _ casesToStrings at: case put: case printString.
		(stringsToLabels at: printString ifAbsentPut: [OrderedCollection new]) addLast: label].

	aTBraceNode caseLabels with: aTBraceNode cases do:
		[:label :case| | printString labels |
		printString _ casesToStrings at: case.
		label = (labels _ (stringsToLabels at: printString) asArray) first ifTrue:
			[newCases addLast: { labels collect: [:ea| ea statements first]. case}]].

	^newCases! !

!SlangTSwitchStmtNode methodsFor: 'instance initialization' stamp: 'eem 2/9/2009 16:30'!
expression: expr cases: aTBraceNode otherwiseOrNil: otherwiseOrNilNode

	self expression: expr.
	self cases: (self createCasesFromBraceNode: aTBraceNode).
	self otherwiseOrNil: otherwiseOrNilNode! !

!SlangTSwitchStmtNode methodsFor: 'testing' stamp: 'eem 2/10/2009 07:58'!
isSwitch
	^true! !

!SlangTSwitchStmtNode methodsFor: 'enumerating' stamp: 'eem 11/19/2012 12:12'!
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

!SlangTSwitchStmtNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:06'!
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

!SlangTSwitchStmtNode methodsFor: 'enumerating' stamp: 'eem 2/27/2009 16:48'!
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	expression nodesDo: aBlock unless: cautionaryBlock.
	cases do:
		[:pair|
		pair first do: [:node| node nodesDo: aBlock unless: cautionaryBlock].
		pair last nodesDo: aBlock unless: cautionaryBlock].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil nodesDo: aBlock unless: cautionaryBlock]! !

!SlangTSwitchStmtNode methodsFor: 'printing' stamp: 'eem 2/10/2009 19:17'!
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

!SlangTVariableNode methodsFor: 'as yet unclassified' stamp: 'di 6/5/2000 16:56'!
bindVariableUsesIn: aDictionary

	^ (aDictionary at: name ifAbsent: [^ self]) copyTree! !

!SlangTVariableNode methodsFor: 'as yet unclassified' stamp: 'sma 5/24/2000 23:42'!
bindVariablesIn: aDictionary 
	^ (aDictionary at: name ifAbsent: [^ self]) copyTree! !

!SlangTVariableNode methodsFor: 'as yet unclassified'!
copyTree

	^self class new setName: name! !

!SlangTVariableNode methodsFor: 'testing' stamp: 'jpb 5/28/2020 17:47:19'!
is: query
	^#Variable = query or: [ super is: query ].
! !

!SlangTVariableNode methodsFor: 'testing'!
isLeaf

	^true! !

!SlangTVariableNode methodsFor: 'testing' stamp: 'eem 12/11/2010 12:28'!
structTargetKind: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^aCodeGen structTargetKindForVariableName: name! !

!SlangTVariableNode methodsFor: 'testing' stamp: 'eem 10/24/2013 13:02'!
structTargetKindIn: aCodeGen
	"Answer if the recever evaluates to a struct or struct pointer
	 and hence can be dereferenced using . or ->.  Answer any of
	 #struct #pointer or nil"
	^aCodeGen structTargetKindForVariableName: name! !

!SlangTVariableNode methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:28'!
mapReceiversIn: aDictionary
	"Remap the receiver, as when converting a send to objectMemory into a send to self"

	aDictionary
		at: name
		ifPresent: [:newName | name _ newName]
! !

!SlangTVariableNode methodsFor: 'accessing' stamp: 'acg 12/17/1999 07:18'!
nameOrValue

	^name! !

!SlangTVariableNode methodsFor: 'accessing'!
setName: aString

	name _ aString.! !

!SlangTVariableNode methodsFor: 'enumerating' stamp: 'eem 10/13/2013 17:10'!
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	aBlock value: self value: parent! !

!SlangTVariableNode methodsFor: 'printing'!
printOn: aStream level: level

	aStream nextPutAll: name.! !

!AssignmentNode methodsFor: '*Slang-Kernel' stamp: 'jpb 6/1/2020 12:10:44'!
asSlangTranslatorNodeIn: aSlangTMethod 
	  "make a CCodeGenerator equivalent of me"
        ^SlangTAssignmentNode new
                setVariable: (variable asSlangTranslatorNodeIn: aSlangTMethod)
                expression: (value asSlangTranslatorNodeIn: aSlangTMethod);
                comment: comment
! !

!BlockNode methodsFor: '*Slang-Kernel' stamp: 'jpb 6/1/2020 12:10:44'!
asSlangTranslatorNodeIn: aSlangTMethod 
	        "make a CCodeGenerator equivalent of me"
        | statementList |
        statementList _ OrderedCollection new.
        statements do:
                [:s | | newS |
                 newS _ s asSlangTranslatorNodeIn: aSlangTMethod.
                 "inline the statement list returned when a CascadeNode is translated and/or when ifNotNil: is transformed"
                 newS isStmtList
                        ifTrue:  [statementList addAll: newS statements]
                        ifFalse: [statementList add: newS]].

        ^SlangTStmtListNode new
                setArguments: (arguments asArray collect: [:arg | arg key])
                statements: statementList;
                comment: comment! !

!MethodNode methodsFor: '*Slang-Kernel' stamp: 'jpb 6/1/2020 12:11:29'!
asSlangTranslationMethodOfClass: aClass 
	^ aClass new
 	       setSelector: selectorOrFalse
             definingClass: encoder associationForClass value
             args: arguments
             locals: encoder tempsAndBlockArgs
             block: block
             primitive: primitive
             properties: properties
             comment: comment
! !

!LiteralNode methodsFor: '*Slang-Kernel' stamp: 'jpb 6/1/2020 12:10:44'!
asSlangTranslatorNodeIn: aSlangTMethod
	"make a CCodeGenerator equivalent of me"

     ^SlangTConstantNode new setValue: key
! !

!VariableNode methodsFor: '*Slang-Kernel' stamp: 'jpb 6/1/2020 12:10:44'!
asSlangTranslatorNodeIn: aSlangTMethod 
	  "make a CCodeGenerator equivalent of me"
        name = 'true' ifTrue: [^ SlangTConstantNode new setValue: true].
        name = 'false' ifTrue: [^ SlangTConstantNode new setValue: false].
        ^ SlangTVariableNode new setName: name! !

!MessageNode methodsFor: '*Slang-Kernel' stamp: 'jpb 6/1/2020 12:10:44'!
asSlangTranslatorNodeIn: aSlangTMethod 
	"make a CCodeGenerator equivalent of me"
	"selector is sometimes a Symbol, sometimes a SelectorNode!!!!
        On top of this, numArgs is needed due to the (truly grody) use of
        arguments as a place to store the extra expressions needed to generate
        code for in-line to:by:do:, etc.  see below, where it is used."
 	| rcvrOrNil sel args |
  	rcvrOrNil _ receiver ifNotNil: [receiver asSlangTranslatorNodeIn: aSlangTMethod].
     (rcvrOrNil notNil
        and: [(rcvrOrNil is: #Variable)
        and: [rcvrOrNil name = 'super']]) ifTrue:
                [^aSlangTMethod superExpansionNodeFor: selector key args: arguments].

	sel _ selector isSymbol ifTrue: [selector] ifFalse: [selector key].
	args _ (1 to: sel numArgs) collect:
 		[:i | (arguments at: i) asSlangTranslatorNodeIn: aSlangTMethod].

	(sel = #to:by:do: and: [arguments size = 7 and: [(arguments at: 7) notNil]]) ifTrue:
                ["Restore limit expr that got moved by transformToDo:"
		args _ {
			(arguments at: 7) value asSlangTranslatorNodeIn: aSlangTMethod. 
                args second.
			args third. "add the limit var as a hidden extra argument; we may need it later"
			SlangTVariableNode new setName: arguments first key
		}
	].

	((sel = #ifFalse: or: [sel = #or:])
         and: [arguments size = 2 and: [(arguments at: 2) notNil]]) ifTrue:
                ["Restore argument block that got moved by transformOr: or transformIfFalse:"
                 args at: 1 put: ((arguments at: 2) asSlangTranslatorNodeIn: aSlangTMethod)].

        ^SlangTSendNode new
                setSelector: sel
                receiver: rcvrOrNil
			arguments: args! !

!ReturnNode methodsFor: '*Slang-Kernel' stamp: 'jpb 6/1/2020 12:10:44'!
asSlangTranslatorNodeIn: aSlangTMethod 
	"make a CCodeGenerator equivalent of me"
      ^SlangTReturnNode new 
		setExpression: (expr asSlangTranslatorNodeIn: aSlangTMethod);
           comment: comment
! !
SlangTMethod initialize!
