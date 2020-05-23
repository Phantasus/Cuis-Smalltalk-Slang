'From Cuis 5.0 [latest update: #4112] on 23 May 2020 at 11:07:15 pm'!
'Description Temporary package for storing plugin related classes, which don''t quiet fit into the Slang-Tools package, it''s supposed to be merged into the main one as it seems that the SmartSyntaxPlugins are trying to implement an extension which should be standard. 

License: MIT'!
!provides: 'Slang-PluginMaker' 1 0!
SystemOrganization addCategory: #'Slang-PluginMaker'!


!classDefinition: #SlangSmartSyntaxPluginTest category: #'Slang-PluginMaker'!
TestCase subclass: #SlangSmartSyntaxPluginTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-PluginMaker'!
!classDefinition: 'SlangSmartSyntaxPluginTest class' category: #'Slang-PluginMaker'!
SlangSmartSyntaxPluginTest class
	instanceVariableNames: ''!

!classDefinition: #SlangInterpreterPlugin category: #'Slang-PluginMaker'!
SlangPlugin subclass: #SlangInterpreterPlugin
	instanceVariableNames: 'interpreterProxy moduleName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-PluginMaker'!
!classDefinition: 'SlangInterpreterPlugin class' category: #'Slang-PluginMaker'!
SlangInterpreterPlugin class
	instanceVariableNames: ''!

!classDefinition: #SlangSmartSyntaxInterpreterPlugin category: #'Slang-PluginMaker'!
SlangInterpreterPlugin subclass: #SlangSmartSyntaxInterpreterPlugin
	instanceVariableNames: 'simulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-PluginMaker'!
!classDefinition: 'SlangSmartSyntaxInterpreterPlugin class' category: #'Slang-PluginMaker'!
SlangSmartSyntaxInterpreterPlugin class
	instanceVariableNames: ''!

!classDefinition: #SlangTestSupportSSIP category: #'Slang-PluginMaker'!
SlangSmartSyntaxInterpreterPlugin subclass: #SlangTestSupportSSIP
	instanceVariableNames: 'cg inlineFlag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-PluginMaker'!
!classDefinition: 'SlangTestSupportSSIP class' category: #'Slang-PluginMaker'!
SlangTestSupportSSIP class
	instanceVariableNames: ''!

!classDefinition: #SlangSmartSyntaxPluginCodeGenerator category: #'Slang-PluginMaker'!
SlangVMPluginCodeGenerator subclass: #SlangSmartSyntaxPluginCodeGenerator
	instanceVariableNames: 'debugFlag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-PluginMaker'!
!classDefinition: 'SlangSmartSyntaxPluginCodeGenerator class' category: #'Slang-PluginMaker'!
SlangSmartSyntaxPluginCodeGenerator class
	instanceVariableNames: ''!

!classDefinition: #SlangSmartSyntaxPluginTMethod category: #'Slang-PluginMaker'!
SlangTMethod subclass: #SlangSmartSyntaxPluginTMethod
	instanceVariableNames: 'isPrimitive suppressingFailureGuards selectorOverride fullArgs parmSpecs rcvrSpec'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-PluginMaker'!
!classDefinition: 'SlangSmartSyntaxPluginTMethod class' category: #'Slang-PluginMaker'!
SlangSmartSyntaxPluginTMethod class
	instanceVariableNames: ''!

!classDefinition: #SlangInterpreterProxy category: #'Slang-PluginMaker'!
Object subclass: #SlangInterpreterProxy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-PluginMaker'!
!classDefinition: 'SlangInterpreterProxy class' category: #'Slang-PluginMaker'!
SlangInterpreterProxy class
	instanceVariableNames: ''!


!SlangInterpreterPlugin commentStamp: 'tpr 5/5/2003 11:43' prior: 0!
This class provides the basic framework for creating VM plugins. Most of the useful methods are on the class side; particularly take note of the messages like #shouldBeTranslated and #requiresPlatformFiles.!

!SlangSmartSyntaxInterpreterPlugin commentStamp: '<historical>' prior: 0!
Subclass of InterpreterPlugin, used in connection with TestCodeGenerator for named primitives with type coercion specifications!

!SlangTestSupportSSIP commentStamp: 'dtl 9/19/2010 11:38' prior: 0!
SlangTestSupportSSIP implements translatable methods for use in SlangTest unit tests.
It is a subclass of SlangSmartSyntaxInterpreterPlugin, which requires additional
test coverage.

	"VMMaker clearCacheEntriesFor: SlangTestSupportSSIP.
	SlangTestSupportSSIP asCString"!

!SlangSmartSyntaxPluginCodeGenerator commentStamp: 'tpr 5/5/2003 16:03' prior: 0!
Subclass of CCodeGenerator, used in connection with TestInterpreterPlugin to generate named primitives with type coercion specifications. See the plugins implemeted as subclasses of TestInterpreterPlugin!

!SlangSmartSyntaxPluginTMethod commentStamp: '<historical>' prior: 0!
Variation of TMethod node of the Smalltalk C Code Generator, used in conjunction with TestCodeGenerator and TestInterpreterPlugin to generate named primitives with type coercion specifications.!

!SlangInterpreterPlugin class methodsFor: 'accessing' stamp: 'tpr 12/17/2003 16:52'!
allCallsOn
	"Answer a SortedCollection of all the methods that refer to me. Most classes simply defer to SystemDictionary>allCallsOn: but some have special requirements - plugins may have a module name that does not match the class name"

	self theNonMetaClass name ~= self moduleName asSymbol
		ifTrue:[^super allCallsOn, (self systemNavigation allCallsOn: self moduleName asSymbol)]
		ifFalse:[^super allCallsOn]! !

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:42'!
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

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:48'!
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

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:43'!
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

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:43'!
testSSIPDoNotGenerateByMethod
	"A doNotdoNotGenerate statement should prevent code generation"

	| stss m |
	stss := SlangTestSupportSSIP inline: false.
	self assert: (SlangTestSupportSSIP canUnderstand: #doNotGenerateByMethod).
	m := stss asCString: #doNotGenerateByMethod.
	self assert: (m includesSubString: 'No source has been generated').
	self deny: (stss asCString includesSubString: 'doNotGenerateByMethod').
	self assert: (stss doNotGenerateByMethod = 4)! !

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:44'!
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

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:44'!
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

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:45'!
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

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:45'!
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

!SlangSmartSyntaxPluginTest methodsFor: 'testing ssip plugins' stamp: 'dtl 3/18/2013 18:45'!
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

!SlangInterpreterPlugin methodsFor: 'initialize' stamp: 'ikp (auto pragmas 12/08) 8/3/2004 19:18'!
getInterpreter
	"Note: This is coded so that plugins can be run from Squeak."

	<returnTypeC: 'VirtualMachine *'>
	^interpreterProxy! !

!SlangInterpreterPlugin methodsFor: 'initialize' stamp: 'ar (auto pragmas dtl 2010-09-28) 5/13/2000 02:00'!
getModuleName
	"Note: This is hardcoded so it can be run from Squeak.
	The module name is used for validating a module *after*
	it is loaded to check if it does really contain the module
	we're thinking it contains. This is important!!"
	<returnTypeC: 'const char*'>
	<export: true>
	^moduleName! !

!SlangInterpreterPlugin methodsFor: 'initialize' stamp: 'ar (auto pragmas 12/08) 4/4/2006 20:53'!
setInterpreter: anInterpreter 
	"Note: This is coded so that is can be run from Squeak."

	| ok |
	<export: true>
	<var: #anInterpreter type: #'struct VirtualMachine*'>
	interpreterProxy := anInterpreter.
	ok := self cCode: 'interpreterProxy->majorVersion() == VM_PROXY_MAJOR'.
	ok == false ifTrue: [^ false].
	ok := self cCode: 'interpreterProxy->minorVersion() >= VM_PROXY_MINOR'.
	^ ok! !

!SlangInterpreterPlugin methodsFor: 'debugging' stamp: 'yo 1/1/2004 11:09'!
halt
	self cCode: '' inSmalltalk: [nil halt].! !

!SlangInterpreterPlugin methodsFor: 'debugging' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 16:34'!
msg: s 
	<var: #s type: 'char *'>
	self cCode: 'fprintf(stderr, "\n%s: %s", moduleName, s)' inSmalltalk: [Transcript cr; show: self class moduleName , ': ' , s; endEntry]! !

!SlangInterpreterPlugin class methodsFor: 'accessing' stamp: 'RMF 3/27/2000 09:39'!
isCPP
	^ false! !

!SlangInterpreterPlugin class methodsFor: 'accessing' stamp: 'bf 10/3/2014 04:20'!
moduleExtension
	Smalltalk at: #JSCodeGenerator ifPresent: [:js | js isActive ifTrue: [^'.js']].
	^ self isCPP ifTrue: ['.cpp'] ifFalse: ['.c']! !

!SlangInterpreterPlugin class methodsFor: 'accessing' stamp: 'bf 10/1/2014 10:02'!
moduleFileName
	"Answer the file name to generate our source code in"

	^ self moduleName, self moduleExtension! !

!SlangInterpreterPlugin class methodsFor: 'accessing' stamp: 'sma 3/3/2000 12:24'!
moduleName
	"Answer the receiver's module name that is used for the plugin's C code."

	^ self name asString! !

!SlangInterpreterPlugin class methodsFor: 'accessing' stamp: 'TPR 5/23/2000 15:33'!
moduleNameAndVersion
	"Answer the receiver's module name and version info that is used for the plugin's C code. The default is to append the code generation date, but any useful text is ok (keep it short)"

	^ self moduleName, Character space asString, Date today asString! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'dtl 8/21/2011 21:10'!
buildCodeGenerator
	"Build a CCodeGenerator for the plugin"
	 | cg |
	cg := self codeGeneratorClass new initialize.
	cg pluginName: self moduleName.
	"Add an extra declaration for module name"
	cg declareModuleName: self moduleNameAndVersion.
	cg declareMethodsStatic: true.
	"Certain plugins expect their methods to be referenced by support code
	even if not so declared. Do not prune methods for those plugins."
	cg permitMethodPruning: (self doNotPruneClasses includes: self moduleName) not.
	^self initializeCodeGenerator: cg.
! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'dtl 8/6/2016 19:13'!
buildCodeGeneratorUpTo: aPluginClass
	"Build a CCodeGenerator for the plugin - Deprecated and here only in case old plugin code tries to use it"
	self deprecated: 'in case old plugin code tries to use it'.
	^self buildCodeGenerator! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'ar 5/12/2000 00:34'!
declareCVarsIn: aCCodeGenerator
	"Note: This method must be implemented by all subclasses to declare variables."

	aCCodeGenerator 
		var: #interpreterProxy 
		type: #'struct VirtualMachine*'.
	self declareHeaderFilesIn: aCCodeGenerator.! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'tpr 5/23/2001 17:14'!
declareHeaderFilesIn: aCCodeGenerator
	self hasHeaderFile ifTrue:[
		aCCodeGenerator addHeaderFile: '"', self moduleName,'.h"'].! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'dtl 8/21/2011 23:00'!
doNotPruneClasses
	"Classes identified by these module names are known to have methods
	that are not exported, but are required by support code. For these classes,
	do not attempt to prune unreference methods in code generation."

	^ { 'RomePlugin' }

! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'tpr 5/23/2001 17:03'!
hasHeaderFile
	"If there is a single intrinsic header file to be associated with the plugin, here is where you want to flag"
	^false! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'jpb 5/23/2020 22:11:00'!
initializeCodeGenerator: cg
	"Load a code generator with classes in a manner suitable for generating
	code for this class."

	super initializeCodeGenerator: cg.

	^cg
! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'tpr 5/28/2008 19:03'!
isSuitablePluginForPlatform: platName
"Is this plugin one that should be built for platName? We do NOT test for the existence of any external files here"
	"generic answer is true"
	^true! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'tpr 2/27/2004 19:05'!
requiredMethodNames
	"return the list of method names that should be retained for export or other support reasons"
	"just which methods?"
	^#()! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'tpr 7/2/2001 16:33'!
requiresCrossPlatformFiles
	"default is ok for most, any plugin needing cross platform files aside from a normal header must say so. See SoundCodecPlugin for example"
	^self hasHeaderFile! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'tpr 11/21/2000 11:53'!
requiresPlatformFiles
	"default is ok for most, any plugin needing platform specific files must say so"
	^false! !

!SlangInterpreterPlugin class methodsFor: 'translation' stamp: 'tpr 5/14/2001 12:05'!
shouldBeTranslated
"is this class intended to be translated as a plugin? Most subclasses should answer true, but some such as:-
	TestInterpreterPlugin
	FlippArrayPlugin2
	InflatePlugin
	should answer false for various reasons."
	^true! !

!SlangInterpreterPlugin class methodsFor: 'private' stamp: 'jpb 5/23/2020 22:11:11'!
codeGeneratorClass
	"return the appropriate class of code generator for this kind ofplugin"

	^SlangVMPluginCodeGenerator! !

!SlangInterpreterPlugin class methodsFor: 'instance creation' stamp: 'jpb 5/23/2020 22:06:09'!
doPrimitive: primitiveName 
	| proxy plugin |
	proxy := SlangInterpreterProxy new.
	proxy loadStackFrom: thisContext sender.
	plugin := self simulatorClass new.
	plugin setInterpreter: proxy.
	(plugin respondsTo: #initialiseModule) ifTrue:[plugin initialiseModule].
	plugin perform: primitiveName asSymbol.
	^ proxy stackValue: 0! !

!SlangInterpreterPlugin class methodsFor: 'class initialization' stamp: 'ar 9/16/1998 20:26'!
initialize
	"Nothing to do ..."! !

!SlangInterpreterPlugin class methodsFor: 'simulation' stamp: 'eem 10/1/2010 20:35'!
newFor: anUnsimulatedInterpreterPluginClass
	"Overridden by SmartSyntaxPluginSimulator to wrap a specific plugin class."
	^self new! !

!SlangInterpreterPlugin class methodsFor: 'simulation' stamp: 'ajh 8/21/2002 21:43'!
simulatorClass
	"For running from Smalltalk - answer a class that can be used to simulate the receiver, or nil if you want the primitives in this module to always fail, causing simulation to fall through to the Smalltalk code.  By default every non-TestInterpreterPlugin can simulate itself."

	^ self! !

!SlangInterpreterPlugin class methodsFor: 'as yet unclassified' stamp: 'tpr 11/23/2015 16:46'!
pruneUnusedInterpreterPluginMethodsIn: ignored
	"In the Cog VMMaker/InterpreterPlugin this method removes unneeded plugin methods. Here, now, it does nothing"! !

!SlangSmartSyntaxInterpreterPlugin methodsFor: 'accessing' stamp: 'eem 10/3/2010 08:31'!
simulator
	<doNotGenerate>
	^simulator! !

!SlangSmartSyntaxInterpreterPlugin methodsFor: 'accessing' stamp: 'eem 10/2/2010 10:02'!
simulator: aSmartSyntaxPluginSimulator
	<doNotGenerate>
	simulator := aSmartSyntaxPluginSimulator! !

!SlangSmartSyntaxInterpreterPlugin methodsFor: 'debugging' stamp: 'sr 12/24/2001 00:29'!
sqAssert: aBool 
	self
		debugCode: [aBool
				ifFalse: [self error: 'Assertion failed!!'].
			^ aBool]! !

!SlangSmartSyntaxInterpreterPlugin class methodsFor: 'private' stamp: 'jpb 5/23/2020 22:08:15'!
codeGeneratorClass
	"return the appropriate class of code generator for this kind ofplugin"

	^SlangSmartSyntaxPluginCodeGenerator! !

!SlangSmartSyntaxInterpreterPlugin class methodsFor: 'instance creation' stamp: 'jpb 5/23/2020 22:06:15'!
doPrimitive: primitiveName withArguments: argArray
	| proxy plugin |
	proxy := SlangInterpreterProxy new.
	proxy loadStackFrom: thisContext sender.
	plugin := (self simulatorClass ifNil: [self]) new.
	plugin setInterpreter: proxy.
	^plugin perform: primitiveName asSymbol withArguments: argArray! !

!SlangSmartSyntaxInterpreterPlugin class methodsFor: 'translation' stamp: 'jpb 5/23/2020 21:51:44'!
shouldBeTranslated
"SmartSyntaxInterpreterPlugin should not be translated but its subclasses should"
	^self ~= SlangSmartSyntaxInterpreterPlugin! !

!SlangSmartSyntaxInterpreterPlugin class methodsFor: 'simulation' stamp: 'tpr 6/28/2003 17:28'!
simulatorClass
	"For running from Smalltalk - answer a class that can be used to simulate the receiver, or nil if you want the primitives in this module to always fail, causing simulation to fall through to the Smalltalk code.
	By default SmartSyntaxInterpreterPlugin answers nil because methods in these plugins are intended to be embedded in code that pushes and pops from the stack and therefore cannot be run independently.  This wrapper code is generated when translated to C.  But, unfortunately, this code is missing during simulation.  There was an attempt to simulate this, but only the prologue code (getting arg from the stack) is simulated (see simulatePrologInContext:). The epologue code (popping args and pushing result) is not.  So I am making this nil until this can be fixed.
	Also, beware that primitive methods that take no args exactly match their primitive name (faking out InterpreterSimulator>>callExternalPrimitive:).  They should only be called from within wrapper code that simulates the prologue and epilogue.  Primitive method that take args don't have this accidental matching problem since their names contain colons while their primitive names do not. - ajh 8/21/2002"

	^ nil! !

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

!SlangTestSupportSSIP methodsFor: 'translation' stamp: 'jpb 5/23/2020 22:00:47'!
cg
	"Lazy initialize, once per test"

	cg ifNil: [
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

!SlangTestSupportSSIP class methodsFor: 'translation' stamp: 'jpb 5/23/2020 22:08:24'!
buildCodeGeneratorInlined: doInlining
	"Build a CCodeGenerator for this class."

	 | cg |
	cg := SlangSmartSyntaxPluginCodeGenerator new initialize.
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

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:32'!
ccgLoad: aBlock expr: aString asBooleanValueFrom: anInteger
	"Answer codestring for boolean coercion (with validating side-effect) of object, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy booleanValueOf:';
		crtab: 2;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	')'])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asCharPtrFrom: anInteger
	"Answer codestring for character pointer to first indexable field of object (without validating side-effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy firstIndexableField:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''char *'''])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asCharPtrFrom: anInteger andThen: valBlock
	"Answer codestring for character pointer to first indexable field of object (without validating side-effect unless specified in valBlock), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^(valBlock value: anInteger), '.',
	 (aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy firstIndexableField:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''char *''']))
	 ! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asFloatValueFrom: anInteger
	"Answer codestring for double precision coercion (with validating side-effect) of oop, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackFloatValue: ';
		nextPutAll: anInteger asString])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asIntPtrFrom: anInteger
	"Answer codestring for integer pointer to first indexable field of object (without validating side-effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy firstIndexableField:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''int *'''])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asIntPtrFrom: anInteger andThen: valBlock
	"Answer codestring for integer pointer to first indexable field of object (without validating side-effect unless specified in valBlock), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^(valBlock value: anInteger), '.',
	 (aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy firstIndexableField:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''int *''']))! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asIntegerValueFrom: anInteger
	"Answer codestring for integer coercion (with validating side-effect) of oop, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackIntegerValue: ';
		nextPutAll: anInteger asString])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 9/19/1999 20:28'!
ccgLoad: aBlock expr: aString asKindOf: aClass from: anInteger

	^String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy success: (interpreterProxy';
		crtab: 2;
		nextPutAll: 'is: (interpreterProxy stackValue: ';
		nextPutAll: anInteger asString;
		nextPutAll: ')';
		crtab: 2;
		nextPutAll: 	'KindOf: ''';
		nextPutAll:	aClass asString;
		nextPutAll: ''').';
		crtab;
		nextPutAll: (self 
						ccgLoad: aBlock 
						expr: aString 
						asRawOopFrom: anInteger)]! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 9/19/1999 20:28'!
ccgLoad: aBlock expr: aString asMemberOf: aClass from: anInteger

	^String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy success: (interpreterProxy';
		crtab: 2;
		nextPutAll: 'is: (interpreterProxy stackValue: ';
		nextPutAll: anInteger asString;
		nextPutAll: ')';
		crtab: 2;
		nextPutAll: 	'MemberOf: ''';
		nextPutAll:	aClass asString;
		nextPutAll: ''').';
		crtab;
		nextPutAll: (self 
						ccgLoad: aBlock 
						expr: aString 
						asRawOopFrom: anInteger)]! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: exprString asNamedPtr: recordString from: anInteger
	"Answer codestring for integer pointer to first indexable field of object (without validating side-effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy firstIndexableField:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''';
		nextPutAll: recordString;
		nextPutAll: ' *'''])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: exprString asNamedPtr: recordString from: anInteger andThen: valBlock
	"Answer codestring for integer pointer to first indexable field of object (without validating side-effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^(valBlock value: anInteger), '.',
	 (aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy firstIndexableField:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''';
		nextPutAll: recordString;
		nextPutAll: ' *''']))! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asNonIntegerValueFrom: anInteger
	"Answer codestring for oop (with validating side effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackObjectValue: ';
		nextPutAll: anInteger asString])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:32'!
ccgLoad: aBlock expr: aString asRawOopFrom: anInteger
	"Answer a string for a Slang expression that will load an oop (without validation) from stack index anInteger.  Apply aBlock, a BlockContext instance that when passed an expression, will return a string assigning the expression to the desired identifier, to the string before answering.  aString is a Slang expression that refers to the stack value, once it has been loaded."

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackValue: ';
		nextPutAll: anInteger asString])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
ccgLoad: aBlock expr: aString asUnsignedPtrFrom: anInteger andThen: valBlock
	"Answer a codestring for integer pointer to first indexable field of object (without validating side-effect unless specified in valBlock), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^(valBlock value: anInteger), '.',
	 (aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy firstIndexableField:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''unsigned *''']))! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
ccgLoad: aBlock expr: aString asUnsignedValueFrom: anInteger
	"Answer a codestring for positive integer coercion (with validating side-effect) of oop, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy positive32BitValueOf:';
		crtab: 2;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	')'])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
ccgLoad: aBlock expr: aString asWBCharPtrFrom: anInteger
	"Answer codestring for char pointer to first indexable field of object (with validating side-effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy arrayValueOf:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''char *'''])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
ccgLoad: aBlock expr: aString asWBFloatPtrFrom: anInteger
	"Answer codestring for single-precision float pointer to first indexable field of object (with validating side-effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy arrayValueOf:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''float *'''])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
ccgLoad: aBlock expr: aString asWBIntPtrFrom: anInteger
	"Answer codestring for integer pointer to first indexable field of object (with validating side-effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'self cCoerce: (interpreterProxy arrayValueOf:';
		crtab: 4;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	'))';
		crtab: 3;
		nextPutAll: 'to: ''int *'''])! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'ar 4/4/2006 21:10'!
ccgSetBlock: aString

	^[:expr | aString, ' := ', expr]! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 9/19/1999 13:05'!
ccgTVarBlock: anInteger

	^[:expr | '(thisContext tempAt: 1) tempAt: ', anInteger asString, ' put: (', expr, ')']! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'EstebanLorenzano 12/6/2010 19:19'!
ccgValBlock: valString
	^[:index | String streamContents:
		[:aStream | aStream
			nextPutAll: 'interpreterProxy success: (interpreterProxy ';
			nextPutAll: valString;
			nextPutAll: ': (interpreterProxy stackValue: ';
			nextPutAll: index asString;
			nextPutAll: '))']]! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asBooleanValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: ' = interpreterProxy->booleanValueOf(';
		crtab: 2;
		nextPutAll: 'interpreterProxy->stackValue(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asCharPtrFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = (char *) interpreterProxy->firstIndexableField(';
		crtab: 2;
		nextPutAll: 	'interpreterProxy->stackValueOf(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asFloatPtrFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = (float *) interpreterProxy->firstIndexableField(';
		crtab: 2;
		nextPutAll: 	'interpreterProxy->stackValueOf(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asFloatValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = interpreterProxy->stackFloatValue(';
		nextPutAll: anInteger asString;
		nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asIntPtrFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = (int *) interpreterProxy->firstIndexableField(';
		crtab: 2;
		nextPutAll: 	'interpreterProxy->stackValueOf(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asIntegerValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = interpreterProxy stackIntegerValue(';
		nextPutAll: anInteger asString;
		nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:42'!
emitLoad: aString asKindOf: aClass from: anInteger on: aStream

	self emitLoad: aString asNakedOopFrom: anInteger on: aStream.
	aStream
		crtab;
		nextPutAll: 'interpreterProxy->success(interpreterProxy->isKindOf(';
		nextPutAll: aString;
		nextPutAll: 	', ''';
		nextPutAll:	aClass asString;
		nextPutAll: '''))'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'bf 3/16/2000 19:20'!
emitLoad: aString asMemberOf: aClass from: anInteger on: aStream

	self emitLoad: aString asNakedOopFrom: anInteger on: aStream.
	aStream
		crtab;
		nextPutAll: 'interpreterProxy->success(interpreterProxy->isMemberOf(';
		nextPutAll: aString;
		nextPutAll: 	', ''';
		nextPutAll:	aClass asString;
		nextPutAll: '''))'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/18/1999 14:23'!
emitLoad: aString asNakedOopFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: ' = interpreterProxy stackValue(';
		nextPutAll: anInteger asString;
		nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:44'!
emitLoad: aString asNonIntegerValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = interpreterProxy stackObjectValue(';
		nextPutAll: anInteger asString;
		nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:44'!
emitLoad: aString asUnsignedValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = interpreterProxy->positive32BitValueOf(';
		crtab: 2;
		nextPutAll: 	'interpreterProxy->stackValue(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:08'!
generateAsBooleanObj: aNode on: aStream indent: anInteger

	aStream nextPutAll: '('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: 
		') ? interpreterProxy->trueObject(): interpreterProxy->falseObject()'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:09'!
generateAsCBoolean: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->booleanValueOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:09'!
generateAsCDouble: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->floatValueOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 21:53'!
generateAsCInt: aNode on: aStream indent: anInteger

	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ' >> 1'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:09'!
generateAsCUnsigned: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->positive32BitValueOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:10'!
generateAsCharPtr: aNode on: aStream indent: anInteger

	aStream nextPutAll: '(char *) interpreterProxy->firstIndexableField('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:10'!
generateAsFloatObj: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->floatObjectOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'TPR 2/25/2000 16:21'!
generateAsIfVar: aNode on: aStream indent: anInteger

	| cName fName class index |
	cName := String streamContents: 
		[:scStr | self emitCExpression: aNode args first on: scStr].
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'first arg must identify class'].
	fName := aNode args second value.
	index := class allInstVarNames
		indexOf: fName
		ifAbsent: [^self error: 'second arg must be instVar'].
	aStream 
		nextPutAll: 'interpreterProxy->fetchPointerofObject(';
		nextPutAll: (index - 1) asString;
		nextPutAll: ','.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'jpb 5/23/2020 22:09:05'!
generateAsIfVarAsValue: aNode on: aStream indent: anInteger

	| cName fName class index fetchNode |
	cName := String streamContents: 
		[:scStr | self emitCExpression: aNode args first on: scStr].
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'first arg must identify class'].
	fName := aNode args second value.
	index := class allInstVarNames
		indexOf: fName
		ifAbsent: [^self error: 'second arg must be instVar'].
	fetchNode := SlangTSendNode new
		setSelector: #fetchPointer:ofObject:
		receiver: (SlangTVariableNode new setName: 'interpreterProxy')
		arguments: (Array
			with: (SlangTConstantNode new setValue: index - 1)
			with: aNode receiver).
	cName := aNode args third nameOrValue.
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'third arg must identify class'].
	class ccg: self generateCoerceToValueFrom: fetchNode on: aStream
! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'TPR 2/25/2000 16:41'!
generateAsIfVarPut: aNode on: aStream indent: anInteger

	| cName fName class index |
	cName := String streamContents: 
		[:scStr | self emitCExpression: aNode args first on: scStr].
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'first arg must identify class'].
	fName := aNode args second value.
	index := class allInstVarNames
		indexOf: fName
		ifAbsent: [^self error: 'second arg must be instVar'].
	aStream 
		nextPutAll: 'interpreterProxy->storePointerofObjectwithValue(';
		nextPutAll: (index - 1) asString;
		nextPutAll: ','.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args third on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:10'!
generateAsIntPtr: aNode on: aStream indent: anInteger

	aStream nextPutAll: '(int *) interpreterProxy->firstIndexableField('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 12/17/1999 07:23'!
generateAsOop: aNode on: aStream indent: anInteger

	| cName class |
	cName := aNode args first nameOrValue.
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'first arg must identify class'].
	class ccg: self generateCoerceToOopFrom: aNode receiver on: aStream! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:10'!
generateAsPositiveIntegerObj: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->positive32BitIntegerFor('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:47'!
generateAsSmallIntegerObj: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->integerObjectOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 12/17/1999 07:22'!
generateAsValue: aNode on: aStream indent: anInteger

	| cName class |
	cName := aNode args first nameOrValue.
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'first arg must identify class'].
	class ccg: self generateCoerceToValueFrom: aNode receiver on: aStream! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'dtl 5/19/2010 21:35'!
generateCPtrAsOop: aNode on: aStream indent: anInteger 

	aStream nextPutAll: '('.
	aStream nextPutAll: 'oopForPointer( '.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ' ) - BASE_HEADER_SIZE)'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:11'!
generateClass: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->fetchClassOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'sr 4/8/2000 02:38'!
generateDebugCode: aNode on: aStream indent: level 
	"Generate the C debug code for this message onto the given stream, if  
	compiled in debugMode."
	self generateDebugCode
		ifTrue: 
			[aStream nextPutAll: '/* DebugCode... */';
			 cr.
			aNode args first
				emitCCodeOn: aStream
				level: level
				generator: self.
			aStream tab: level.
			aStream nextPutAll: '/* ...DebugCode */']
		ifFalse: [aStream nextPutAll: '/* missing DebugCode */']! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:11'!
generateField: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->fetchPointerofObject('.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 23:40'!
generateFieldPut: aNode on: aStream indent: anInteger
		
	aStream nextPutAll: 'interpreterProxy->storePointerofObjectwithValue('.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args second on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/16/1999 08:02'!
generateFromStack: aNode on: aStream indent: anInteger

	| idList |
	aNode args first isConstant ifFalse: [^self error: 'arg must be constant'].
	idList := aNode args first value.
	(1 to: idList size)
		do: [:i | 
			aStream 
				nextPutAll: (idList at: i);
				nextPutAll: ' = interpreterProxy->stackValue(';
				nextPutAll: (idList size - i) asString;
				nextPutAll: ')']
		separatedBy: [aStream nextPut: $;; crtab: anInteger].
! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:50'!
generateIsBytes: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isBytes('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:50'!
generateIsFloat: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isFloatObject('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:49'!
generateIsIndexable: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isIndexable('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:49'!
generateIsInteger: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isIntegerValue('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:13'!
generateIsIntegerOop: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isIntegerObject('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:13'!
generateIsIntegerValue: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isIntegerValue('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:20'!
generateIsKindOf: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isKindOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','''.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ''')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:20'!
generateIsMemberOf: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isMemberOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','''.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ''')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:14'!
generateIsPointers: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isPointers('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:14'!
generateIsWords: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isWords('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:13'!
generateIsWordsOrBytes: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isWordsOrBytes('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 01:56'!
generateNext: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| varNode |
	varNode := msgNode receiver.
	varNode isVariable
		ifFalse: [ self error: 'next can only be applied to variables' ].
	aStream nextPutAll: '*'.
	aStream nextPutAll: varNode name.
	aStream nextPutAll: '++'
! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 12/31/1999 16:37'!
generateRemapOopIn: aNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| idList |
	idList := aNode args first nameOrValue.
	idList class == Array ifFalse: [idList := Array with: idList].
	idList do:
		[:each | 
		 aStream 
			nextPutAll: 'interpreterProxy->pushRemappableOop(';
			nextPutAll: each asString;
			nextPutAll: ');']
		separatedBy: [aStream crtab: level].
	aStream cr.
	aNode args second emitCCodeOn: aStream level: level generator: self.
	level timesRepeat: [aStream tab].
	idList reversed do:
		[:each |
		 aStream 
			nextPutAll: each asString;
			nextPutAll: ' = interpreterProxy->popRemappableOop()']
		separatedBy: [aStream nextPut: $;; crtab: level].! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:15'!
generateStAt: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->stObjectat('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ')'
! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:17'!
generateStAtPut: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->stObjectatput('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args second on: aStream.
	aStream nextPutAll: ')'
! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 1/1/2000 22:41'!
generateStSize: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->stSizeOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'dtl 3/18/2013 18:24'!
initializeCTranslationDictionary 
	"Initialize the dictionary mapping message names to actions for C code generation."

	| pairs |
	super initializeCTranslationDictionary.
	pairs := #(
		#asCInt						#generateAsCInt:on:indent:
		#asCUnsigned				#generateAsCUnsigned:on:indent:
		#asCBoolean					#generateAsCBoolean:on:indent:
		#asCDouble					#generateAsCDouble:on:indent:

		#asSmallIntegerObj			#generateAsSmallIntegerObj:on:indent:
		#asPositiveIntegerObj		#generateAsPositiveIntegerObj:on:indent:
		#asBooleanObj				#generateAsBooleanObj:on:indent:
		#asFloatObj					#generateAsFloatObj:on:indent:

		#asIf:var:					#generateAsIfVar:on:indent:
		#asIf:var:asValue:			#generateAsIfVarAsValue:on:indent:
		#asIf:var:put:				#generateAsIfVarPut:on:indent:
		#field:						#generateField:on:indent:
		#field:put:					#generateFieldPut:on:indent:
		
		#class						#generateClass:on:indent:

		#stSize						#generateStSize:on:indent:
		#stAt:						#generateStAt:on:indent:
		#stAt:put:					#generateStAtPut:on:indent:

		#asCharPtr					#generateAsCharPtr:on:indent:
		#asIntPtr					#generateAsIntPtr:on:indent:
		#cPtrAsOop					#generateCPtrAsOop:on:indent:
		#next						#generateNext:on:indent:

		#asOop:						#generateAsOop:on:indent:
		#asValue:					#generateAsValue:on:indent:

		#isFloat						#generateIsFloat:on:indent:
		#isIndexable					#generateIsIndexable:on:indent:
		#isIntegerOop				#generateIsIntegerOop:on:indent:
		#isIntegerValue				#generateIsIntegerValue:on:indent:
		"#FloatOop					#generateIsFloatValue:on:indent:"		"unused, never implemented"
		#isWords					#generateIsWords:on:indent:
		#isWordsOrBytes				#generateIsWordsOrBytes:on:indent:
		#isPointers					#generateIsPointers:on:indent:
		#isNil						#generateIsNil:on:indent:
		#isMemberOf:				#generateIsMemberOf:on:indent:
		#isKindOf:					#generateIsKindOf:on:indent:

		#fromStack:					#generateFromStack:on:indent:
		"#clone						#generateClone:on:indent:"				"unused, never implemented"
		"#new						#generateNew:on:indent:"				"unused, never implemented"
		"#new:						#generateNewSize:on:indent:"			"unused, never implemented"
		"#superclass					#generateSuperclass:on:indent:"	"unused, never implemented"
		#remapOop:in:				#generateRemapOopIn:on:indent:
		#debugCode:					#generateDebugCode:on:indent:
	).

	1 to: pairs size by: 2 do: [:i |
		translationDict at: (pairs at: i) put: (pairs at: i + 1)].
! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 12/25/1999 10:00'!
generateCoerceToBooleanObjectFrom: aNode on: aStream

	aStream nextPutAll: '('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: '? interpreterProxy->trueObject(): interpreterProxy->falseObject())'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:07'!
generateCoerceToBooleanValueFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->booleanValueOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:03'!
generateCoerceToFloatObjectFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->floatObjectOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 05:53'!
generateCoerceToFloatValueFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->floatValueOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'dtl 5/19/2010 21:34'!
generateCoerceToObjectFromPtr: aNode on: aStream
	"This code assumes no named instance variables"

	aStream nextPutAll: 'oopForPointer('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ') - BASE_HEADER_SIZE'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 05:57'!
generateCoerceToPtr: aString fromObject: aNode on: aStream
	"This code assumes no named instance variables"

	aStream 
		nextPutAll: '((';
		nextPutAll: aString;
		nextPutAll: ') interpreterProxy->firstIndexableField('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: '))'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:03'!
generateCoerceToSmallIntegerObjectFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->integerObjectOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 05:59'!
generateCoerceToSmallIntegerValueFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->integerValueOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:03'!
generateCoerceToUnsignedObjectFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->positive32BitIntegerFor('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:00'!
generateCoerceToUnsignedValueFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->positive32BitValueOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'debug code' stamp: 'sr 4/8/2000 00:52'!
generateDebugCode
	^ debugFlag! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'debug code' stamp: 'sr 4/8/2000 00:52'!
generateDebugCode: aBool 
	debugFlag := aBool! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'initialize' stamp: 'sr 4/8/2000 00:53'!
initialize
	super initialize.
	debugFlag := false! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'initialize' stamp: 'jpb 5/23/2020 20:32:23'!
translationMethodClass
	"return the class used to produce C translation methods from MethodNodes"
	^SlangSmartSyntaxPluginTMethod! !

!SlangSmartSyntaxPluginCodeGenerator methodsFor: 'transforming' stamp: 'ar 3/10/2000 17:59'!
var: varName as: aClass
	"Record the given C declaration for a global variable"

	variableDeclarations at: varName asString put: (aClass ccgDeclareCForVar: varName)! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'acg 9/19/1999 11:19'!
args: anInteger

	^args := anInteger! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'acg 9/19/1999 11:18'!
parmSpecs

	^parmSpecs! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'acg 9/19/1999 11:50'!
rcvrSpec

	^rcvrSpec! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'dtl 2/3/2007 11:23'!
selectorForCodeGeneration
	"A primitive directive my override the selector specification."

	^ self selectorOverride ifNil: [self selector]! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'dtl 2/3/2007 11:21'!
selectorOverride
	"A primitive directive allows the selector to be overridden in order to specify
	a preferred name for the generated primitive."

	^ selectorOverride! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'dtl 2/3/2007 11:21'!
selectorOverride: preferredSelectorName
	"A primitive directive allows the selector to be overridden in order to specify
	a preferred name for the generated primitive."

	selectorOverride := preferredSelectorName! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'jpb 5/23/2020 22:08:36'!
assign: variable expression: expression

	^SlangTAssignmentNode new
		setVariable: variable
		expression: expression! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'dtl 5/21/2011 21:14'!
checkSuccessExpr
	"Return the parse tree for an expression that aborts the primitive if primFailCode is set."

	| expr |
	expr := 'interpreterProxy failed ifTrue: [^nil]'.
	^ self statementsFor: expr varName: ''
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'acg 12/18/1999 10:47'!
generateFailureGuardOn: sStream
	suppressingFailureGuards ifTrue: [^nil].
	sStream nextPutAll: self checkSuccessExpr
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'jpb 5/23/2020 22:09:57'!
nullReturnExpr

	^ SlangTReturnNode new
		setExpression: (SlangTVariableNode new setName: 'null')! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'jpb 5/23/2020 22:09:18'!
oldReplaceSizeMessages
	"Replace sends of the message 'size' with calls to sizeOfSTArrayFromCPrimitive."

	| argExpr |
	parseTree nodesDo: [:n |
		(n isSend and: [n selector = #size]) ifTrue: [
			argExpr := SlangTSendNode new
				setSelector: #+
				receiver: n receiver
				arguments: (Array with: (SlangTConstantNode new setValue: 1)).
			n
				setSelector: #sizeOfSTArrayFromCPrimitive:
				receiver: (SlangTVariableNode new setName: 'interpreterProxy')
				arguments: (Array with: argExpr)]].
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'jpb 5/23/2020 22:10:11'!
oopVariable: aString

	(locals includes: aString) ifFalse:
		[locals add: aString.
		 declarations
			at: aString 
			put: 'sqInt ', aString].
	^SlangTVariableNode new setName: aString! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'jpb 5/23/2020 22:09:30'!
pop: anInteger thenReturnExpr: anExpression

	^SlangTSendNode new
		setSelector: #pop:thenPush:
		receiver: (SlangTVariableNode new setName: 'interpreterProxy')
		arguments: (Array 
			with: (SlangTConstantNode new 
				setValue: anInteger)
			with: anExpression)! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'jpb 5/23/2020 22:09:44'!
popExpr: anInteger

	^ SlangTSendNode new
			 setSelector: #pop:
			 receiver: (SlangTVariableNode new setName: 'interpreterProxy')
			 arguments: (Array 
				with: (SlangTConstantNode new 
					setValue: anInteger))! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'TPR 3/2/2000 12:39'!
printTempsAndVar: varName on: aStream 
	"add the required temps and the varname to the stream"
	aStream nextPutAll: '| '.
	(#('rcvr' 'stackPointer' 'successFlag' 'interpreterProxy' ) reject: [:each | locals includes: each])
		do: [:each | aStream nextPutAll: each;
			 space].
	(locals reject: [:each | each first = $_])
		do: [:each | aStream nextPutAll: each;
			 space].
"don't add varName twice. Probably a deeper reason for this, but WTH. TPR"
	(locals includes: varName) ifFalse:[aStream nextPutAll: varName].
	aStream nextPutAll: '|';
	 cr! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'generating C code' stamp: 'ikp 3/31/2005 14:23'!
emitCHeaderOn: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	aStream cr.
	self emitCFunctionPrototype: aStream generator: aCodeGen.
	aStream nextPutAll: ' {'; cr.
	locals do: [ :var |
		aStream 
			tab; 
			nextPutAll: (declarations 
				at: var 
				ifAbsent: [ 'sqInt ', var]);
			nextPut: $;; 
			cr].
	locals isEmpty ifFalse: [ aStream cr ].! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'dtl 2/3/2007 11:40'!
extractPrimitiveDirectives
	"Set selectorOverride, and save args in fullArgs.  Scan top-level statements for a directive of the form:

		self	
			primitive: 	<string>
or
		self
			primitive:	<string>
			parameters: <list of class names>
or
		self
			primitive:	<string>
			parameters: <list of class names>
			receiver: <class name>

or an assignment of that expression to a local, and manipulate the state and parse tree accordingly."

	parseTree setStatements: (Array streamContents:
		[:sStream |
			parseTree statements do:
				[:stmt |
				 (self primitiveDirectiveWasHandled: stmt on: sStream)
					ifFalse: [sStream nextPut: stmt]]]).
	isPrimitive 
		ifTrue:
			[export := true.
			 parseTree 
				setStatements: self namedPrimitiveProlog, 
								parseTree statements.
			 self fixUpReturns.
			 self replaceSizeMessages.
			 ^true]
		ifFalse: [self removeFinalSelfReturn].
	^false! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'jpb 5/23/2020 20:31:11'!
handlePrimitiveDirective: aStmt on: sStream

	isPrimitive := true.
	fullArgs := args.
	locals addAll: args.
	args := OrderedCollection new.
	fullArgs with: parmSpecs do:
		[:argName :spec |
			declarations
				at: argName
				put: (spec ccgDeclareCForVar: argName)].
	aStmt isAssignment ifTrue:
		[declarations
			at: aStmt variable name
			put: (rcvrSpec ccgDeclareCForVar: aStmt variable name).
		 sStream nextPutAll: (self
			statementsFor:
				(rcvrSpec
					ccg:		SlangSmartSyntaxPluginCodeGenerator new
					prolog:  [:expr | aStmt variable name, ' := ', expr]
					expr: 	aStmt variable name
					index: 	(fullArgs size))
			varName: '')].

	"only add the failure guard if there are args or it is an assignment"
	(fullArgs isEmpty not or:[aStmt isAssignment]) ifTrue:[self generateFailureGuardOn: sStream].
	^true.
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'jpb 5/23/2020 20:29:52'!
isPrimitiveDirectiveSend: stmt
	
	stmt isSend ifTrue:
		[stmt selector = #primitive: ifTrue:
			[^self primitive: 	stmt args first value
				   parameters:	(Array new: args size withAll: #SlangOop)
				   receiver:		#SlangOop].
		 stmt selector = #primitive:parameters: ifTrue:
			[^self primitive: 	stmt args first value
				   parameters: 	stmt args second value
				   receiver:		#SlangOop].
		 stmt selector = #primitive:parameters:receiver: ifTrue:
			[^self primitive:		stmt args first value
				   parameters:	stmt args second value
				   receiver:		stmt args third value].
		^false].
	^false.
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'jpb 5/23/2020 20:31:11'!
namedPrimitiveProlog

	| cg |
	cg := SlangSmartSyntaxPluginCodeGenerator new.
	^Array streamContents: [:sStream |
		1 to: fullArgs size do:
			[:i |
			 sStream nextPutAll: 
				(self 
					statementsFor: 
						((parmSpecs at: i) 
							ccg: 	cg
							prolog:  [:expr | (fullArgs at: i), ' := ', expr]
							expr: (fullArgs at: i)
							index: (fullArgs size - i))
					varName: '')]]! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'dtl 2/3/2007 11:29'!
primitive: aString parameters: anArray receiver: aClassSymbol

	self selectorOverride: aString asSymbol.
	anArray size == args size ifFalse: 
		[^self error: self selectorOverride, ': incorrect number of parameter specifications'].
	parmSpecs := anArray collect:
		[:each | Smalltalk at: each ifAbsent:
			[^self error: self selectorOverride, ': parameter spec must be a Behavior']].
	parmSpecs do: [:each | each isBehavior ifFalse:
		[^self error: self selectorOverride, ': parameter spec must be a Behavior']].
	rcvrSpec := Smalltalk at: aClassSymbol asSymbol ifAbsent:
		[^self error: self selectorOverride, ': receiver spec must be a Behavior'].
	rcvrSpec isBehavior ifFalse:
		[^self error: self selectorOverride, ': receiver spec must be a Behavior'].
	^true! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'acg 9/17/1999 22:41'!
primitiveDirectiveWasHandled: stmt on: sStream

	(self isPrimitiveDirectiveSend: stmt) ifTrue:
		[^self handlePrimitiveDirective: stmt on: sStream].
	(stmt isAssignment and: 
		[self isPrimitiveDirectiveSend: stmt expression]) ifTrue:
			[^self handlePrimitiveDirective: stmt on: sStream].
	^false.
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'acg 12/18/1999 10:39'!
extractSuppressFailureGuardDirective
	"Scan the top-level statements for a pragma directive of the form:

		self suppressFailureGuards: <boolean>

	 and remove the directive from the method body. Answer the argument of the directive or false if there is no #supressFailureGuards: directive."

	| result newStatements |
	result := false.
	newStatements := OrderedCollection new: parseTree statements size.
	parseTree statements do: [ :stmt |
		(stmt isSend and: [stmt selector = #suppressFailureGuards:]) ifTrue: [
			result := stmt args first name = 'true'.
		] ifFalse: [
			newStatements add: stmt.
		].
	].
	parseTree setStatements: newStatements asArray.
	^ result! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'TPR 3/1/2000 20:21'!
fixUpReturnOneStmt: stmt on: sStream

	stmt isReturn ifFalse: [^sStream nextPut: stmt].
	(stmt expression isSend and: ['primitiveFail' = stmt expression selector]) ifTrue: 
		["failure return"
		 sStream nextPut: stmt expression.
		 sStream nextPut: self nullReturnExpr.
		 ^nil].
	(stmt expression isVariable and: ['nil' = stmt expression name]) ifTrue: 
		["^ nil -- this is never right unless automatically generated"
		 sStream nextPut: stmt.
		 ^nil].
	(stmt expression isVariable and: ['self' = stmt expression name]) ifTrue: 
		["^ self"
		 self generateFailureGuardOn: sStream.
		 fullArgs isEmpty ifFalse:[ sStream nextPut: (self popExpr: fullArgs size)].
		 sStream nextPut: self nullReturnExpr.
		 ^nil].
	(stmt expression isVariable | stmt expression isConstant | suppressingFailureGuards) ifTrue:
		["^ variable or ^ constant or ^ expr without guardchecking"
		 self generateFailureGuardOn: sStream.
		 sStream nextPut: (self pop: fullArgs size + 1 thenReturnExpr: stmt expression).
		 sStream nextPut: self nullReturnExpr.
		 ^nil].
	"^ expr with guardchecking"
	sStream nextPut: (self assign: (self oopVariable: '_return_value') expression: stmt expression).
	self generateFailureGuardOn: sStream.
	sStream nextPut: (self pop: fullArgs size + 1 thenReturnExpr: (self oopVariable: '_return_value')).
	sStream nextPut: self nullReturnExpr
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'acg 9/18/1999 01:49'!
fixUpReturns
	"Replace each return statement in this method with (a) the given postlog, (b) code to pop the receiver and the given number of arguments, and (c) code to push the integer result and return."

	parseTree nodesDo: [:node |
		node isStmtList ifTrue: [
			node setStatements: (Array streamContents:
				[:sStream |
				 node statements do: 
					[:stmt | self fixUpReturnOneStmt: stmt on: sStream]])]]! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'dtl 9/19/2010 22:56'!
recordDeclarations
	"Record C type declarations of the forms

		self returnTypeC: 'float'.
		self var: #foo declareC: 'float foo'
		self var: #foo as: Class
		self var: #foo type: 'float'.

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
			 pragma keyword = #var:as: ifTrue:
				[| theClass |
				 theClass := Smalltalk at: pragma arguments last name asSymbol ifAbsent: [nil].
				 (theClass isKindOf: Behavior) ifFalse:
					[^self error: 'declarator must be a Behavior'].
				 self declarationAt: pragma arguments first value asString 
					put: (theClass ccgDeclareCForVar: pragma arguments first asString)].
			pragma keyword = #returnTypeC: ifTrue:
				[returnType := pragma arguments last].
			pragma keyword = #doNotGenerate: ifTrue:
				[locals removeKey: pragma arguments last]]].
	newStatements := OrderedCollection new: parseTree statements size.
	parseTree statements do: 
		[:stmt | | isDeclaration |
		 isDeclaration := false.
		 stmt isSend ifTrue: 
			[stmt selector = #var:declareC: ifTrue:
				[isDeclaration := true.
				self declarationAt: stmt args first value asString put: stmt args last value].
			stmt selector = #var:type: ifTrue: [
				| varName varType |
				isDeclaration := true.
				varName := stmt args first value asString.
				varType := stmt args last value.
				varType last = $* ifFalse: [varType := varType, ' '].
				self declarationAt: varName put: varType, varName.
			].
			 stmt selector = #var:as: ifTrue:
				[| theClass |
				 isDeclaration := true.
				 theClass := Smalltalk  at: stmt args last name asSymbol ifAbsent: [nil].
				 (theClass isKindOf: Behavior) ifFalse:
					[^self error: 'declarator must be a Behavior'].
				 self declarationAt: stmt args first value asString 
					put: (theClass ccgDeclareCForVar: stmt args first value asString)].
			 stmt selector = #returnTypeC: ifTrue: 
				[isDeclaration := true.
				 returnType := stmt args last value]].
		 isDeclaration ifFalse: [newStatements add: stmt]].
	parseTree setStatements: newStatements asArray! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'acg 9/17/1999 18:18'!
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

!SlangSmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'TPR 3/2/2000 19:07'!
replaceArraySizeMessages
	"Replace sends of the message 'size' with calls to sizeOfSTArrayFromCPrimitive. Specialised version for generating primitives outside a plugin"

	super replaceSizeMessages
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'jpb 5/23/2020 22:10:17'!
replaceSizeMessages
	"Replace sends of the message 'size' with calls to sizeOfSTArrayFromCPrimitive."

	parseTree nodesDo: [:n |
		(n isSend and: [n selector = #size]) ifTrue: [
			n
				setSelector: #sizeOfSTArrayFromCPrimitive:
				receiver: (SlangTVariableNode new setName: 'interpreterProxy')
				arguments: (Array with: n receiver)]].
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'initializing' stamp: 'acg 9/19/1999 11:46'!
fromContext: aContext primitive: aString parameters: aClassList receiver: aClass

	fullArgs := args := aContext tempNames
				copyFrom: 1
				to: aContext method numArgs.
	self 
		primitive: aString
		parameters: aClassList
		receiver: aClass! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'initializing' stamp: 'eem 10/2/2009 11:32'!
setSelector: sel definingClass: class args: argList locals: localList block: aBlockNode primitive: aNumber properties: methodProperties comment: aComment
	"Initialize this method using the given information."

	selector := sel.
	definingClass := class.
	returnType := #sqInt. 	 "assume return type is sqInt for now"
	args := argList asOrderedCollection collect: [:arg | arg key].
	locals := localList asOrderedCollection collect: [:arg | arg key].
	declarations := Dictionary new.
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
	isPrimitive := false.  "set to true only if you find a primtive direction."
	suppressingFailureGuards := self extractSuppressFailureGuardDirective.
	self recordDeclarations.
	self extractPrimitiveDirectives.
! !

!SlangSmartSyntaxPluginTMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:07'!
vmNameString
	"return the string to use as the vm name in code generated for this method"
	^'interpreterProxy'! !

!SlangSmartSyntaxPluginTMethod class methodsFor: 'as yet unclassified' stamp: 'acg 9/19/1999 11:47'!
fromContext: aContext primitive: aString parameters: aClassList receiver: aClass

	^super new 
		fromContext: aContext 
		primitive: aString 
		parameters: aClassList 
		receiver: aClass
! !

!SlangInterpreterProxy methodsFor: 'as yet unclassified' stamp: 'jpb 5/23/2020 22:04:37'!
loadStackFrom: obj! !

!SlangInterpreterProxy methodsFor: 'as yet unclassified' stamp: 'jpb 5/23/2020 22:04:50'!
stackValue: newValue! !
SlangInterpreterPlugin initialize!
