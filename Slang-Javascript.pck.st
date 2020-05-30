'From Cuis 5.0 [latest update: #4112] on 30 May 2020 at 10:44:48 pm'!
'Description License: MIT'!
!provides: 'Slang-Javascript' 1 14!
SystemOrganization addCategory: #'Slang-Javascript'!


!classDefinition: #JSCodeGenerator category: #'Slang-Javascript'!
SlangCodeGenerator subclass: #JSCodeGenerator
	instanceVariableNames: 'translationDict inlineList constants variables variableDeclarations scopeStack methods preparedMethodList variablesSetCache headerFiles globalVariableUsage useSymbolicConstants generateDeadCode doNotRemoveMethodList asArgumentTranslationDict receiverDict originClass currentMethod logger declareMethodsStatic permitMethodPruning pools abstractDeclarations uncheckedAbstractMethods cCodeTranslationDict oneBasedArrays typeRepository'
	classVariableNames: 'IsActive UseRightShiftForDivide'
	poolDictionaries: ''
	category: 'Slang-Javascript'!
!classDefinition: 'JSCodeGenerator class' category: #'Slang-Javascript'!
JSCodeGenerator class
	instanceVariableNames: ''!

!classDefinition: #JSMethod category: #'Slang-Javascript'!
Object subclass: #JSMethod
	instanceVariableNames: 'selector returnType args locals declarations primitive parseTree labels possibleSideEffectsCache complete export static sharedLabel sharedCase comment definingClass globalStructureBuildMethodHasFoo canAsmLabel mustAsmLabel properties cascadeVariableNumber extraVariableNumber oneBasedArrays'
	classVariableNames: 'CaseStatements'
	poolDictionaries: ''
	category: 'Slang-Javascript'!
!classDefinition: 'JSMethod class' category: #'Slang-Javascript'!
JSMethod class
	instanceVariableNames: ''!


!JSCodeGenerator commentStamp: 'bf 10/4/2014 13:42' prior: 0!
This class is a copy of CCodeGenerator hacked to generate JavaScript instead of C for use with the SqueakJS virtual machine.

C and JS semantics are pretty close except for pointers, types, and divide/modulo/shift operations. !

!JSMethod commentStamp: 'bf 10/3/2014 04:14' prior: 0!
A JSMethod is a translation method, representing a MethodNode that is to be translated to JavaScript source. It has a parseTree of translation nodes that mirrors the parse tree of the corresponding Smalltalk method.!

!JSMethod methodsFor: 'accessing' stamp: 'hg 8/14/2000 15:57'!
comment: aComment

	comment _ aComment ! !

!JSMethod methodsFor: 'printing' stamp: 'TPR 3/2/2000 18:36'!
printOn: aStream

	super printOn: aStream.
	aStream nextPutAll: ' (', selector, ')'.! !

!JSCodeGenerator methodsFor: 'public' stamp: 'TPR 3/2/2000 11:22'!
addAllClassVarsFor: aClass
	"Add the class variables for the given class (and its superclasses) to the code base as constants."

	| allClasses |
	allClasses _ aClass withAllSuperclasses.
	allClasses do: [:c | self addClassVarsFor: c].
! !

!JSCodeGenerator methodsFor: 'public' stamp: 'jpb 5/19/2020 15:59:56'!
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
	originClass ifNil: [self vmClass: aClass].
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

!JSCodeGenerator methodsFor: 'public' stamp: 'jpb 5/21/2020 00:01:05'!
addClassVarsFor: aClass
	"Add the class variables for the given class to the code base as constants."
	| val node |
	aClass classPool associationsDo: [:assoc | 
		val _ assoc value.
		(useSymbolicConstants and:[self isJSLiteral: val])
			ifTrue:[node _ SlangTDefineNode new setName: assoc key asString value: assoc value]
			ifFalse:[node _ SlangTConstantNode new setValue: assoc value].
		constants at: assoc key asString put: node].
! !

!JSCodeGenerator methodsFor: 'public' stamp: 'ar 2/14/1999 01:08'!
addHeaderFile: aString
	"Add a header file. The argument must be a quoted string!!"
	headerFiles addLast: aString.! !

!JSCodeGenerator methodsFor: 'public' stamp: 'bf 10/14/2014 15:45'!
addMethodsForPrimitives: classAndSelectorList 
	| sel aClass source verbose meth primInstVars sharedInstVars assignedInstVars |
	classAndSelectorList do:[:classAndSelector | 
		aClass _ Smalltalk at: (classAndSelector at: 1) ifAbsent:[nil].
		aClass ifNotNil:[
			self addAllClassVarsFor: aClass.
			"TPR - should pool vars also be added here?"

			"find the method in either the class or the metaclass"
			sel _ classAndSelector at: 2.
			(aClass includesSelector: sel)
				ifTrue: [source _ aClass sourceCodeAt: sel ifAbsent:[nil]]
				ifFalse: [source _ aClass class sourceCodeAt: sel ifAbsent:[nil]].
		].
		source ifNil:[
			Transcript cr; show: 'WARNING: Compiled primitive ', classAndSelector first, '>>', classAndSelector last, ' not present'.
		] ifNotNil:[
			"compile the method source and convert to a suitable translation 
			method "
			meth _ (Compiler new
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
	verbose _ false.
	self prepareMethods.
	verbose
		ifTrue: 
			[self printUnboundCallWarnings.
			self printUnboundVariableReferenceWarnings.
			Transcript cr].

	"code generation"
	"self doInlining: false"

	primInstVars _ Set new.			"inst vars used in primitives"
	sharedInstVars _ Set new.			"inst vars used in non-primitives"
	assignedInstVars _  Set new.		"inst vars modified in non-primitives"
	methods do:[:m|
		m primitive > 0 ifTrue: [
			primInstVars addAll: m freeVariableReferences.
		] ifFalse: [
			sharedInstVars addAll: m freeVariableReferences.
			assignedInstVars addAll: m variablesAssignedTo.
		].
	].
	methods do:[:m|
		"if this method is supposed to be a primitive (rather than a helper 
		routine), add assorted prolog and epilog items"
		m primitive > 0 ifTrue: [
			m preparePrimitivePrologueShared: sharedInstVars assigned: assignedInstVars ].
		"check for one-based array access"	
		m oneBasedArrays ifNotNil: [self oneBasedArrays: true].
	].
	"Add declarations for inst vars used in both prims and non-prims as global"
	((primInstVars intersection: sharedInstVars) difference: variables) do: [:var |
		methods do:[:m|
			m declarations at: var ifPresent: [:decl |
				variableDeclarations at: var
					ifPresent: [:existing |
						decl = existing ifFalse: [self error: 'decls do not match']]
					ifAbsent: [variableDeclarations at: var put: decl]]].
		variables add: var].
	"Add non-shared inst vars as local"
	methods do:[:m|
		m locals addAll: (m freeVariableReferences difference: sharedInstVars)].
	! !

!JSCodeGenerator methodsFor: 'public' stamp: 'jpb 5/21/2020 00:01:15'!
addPoolVarsFor: aClass 
	"Add the pool variables for the given class to the code base as constants."

	(aClass sharedPools reject: [:pool| pools includes: pool]) do:
		[:pool |
		pools add: pool.
		pool bindingsDo: [:assoc | | val node |
			val _ assoc value.
			node _ (useSymbolicConstants and:[self isJSLiteral: val])
						ifTrue:[SlangTDefineNode new setName: assoc key asString value: assoc value]
						ifFalse:[SlangTConstantNode new setValue: assoc value].
			constants at: assoc key asString put: node]].! !

!JSCodeGenerator methodsFor: 'public' stamp: 'ikp 9/26/97 14:48'!
codeString
	"Return a string containing all the C code for the code base. Used for testing."

	| stream |
	stream _ ReadWriteStream on: (String new: 1000).
	self emitJSCodeOn: stream doInlining: true doAssertions: true.
	^stream contents! !

!JSCodeGenerator methodsFor: 'public' stamp: 'eem 2/11/2009 08:52'!
declareVar: varName type: type
	"This both creates a varable and provides its type"
	self var: (variables add: varName asString) type: type! !

!JSCodeGenerator methodsFor: 'public' stamp: 'dtl 2/5/2007 07:45'!
exportedPrimitiveNames
	"Return an array of all exported primitives"
	^methods select:[:m| m export] thenCollect:[:m| m selectorForCodeGeneration copyWithout: $:].
! !

!JSCodeGenerator methodsFor: 'public'!
globalsAsSet
	"Used by the inliner to avoid name clashes with global variables."

	((variablesSetCache == nil) or:
	 [variablesSetCache size ~= variables size]) ifTrue: [
		variablesSetCache _ variables asSet.
	].
	^ variablesSetCache! !

!JSCodeGenerator methodsFor: 'public' stamp: 'bf 10/6/2014 23:48'!
ignoredMethods
	^#()! !

!JSCodeGenerator methodsFor: 'public' stamp: 'jpb 5/28/2020 16:23:25'!
initialize
	translationDict _ Dictionary new.
	inlineList _ Array new.
	constants _ Dictionary new: 100.
	
	variables _ OrderedCollection new: 100.
	variableDeclarations _ Dictionary new: 100.
	methods _ Dictionary new: 500.
	
	typeRepository _ SlangCTypeRepository new.
	
	self initializeTranslationDictionary.
	
	receiverDict _ Dictionary new.
	headerFiles _ OrderedCollection new.
	globalVariableUsage _ Dictionary new.
	useSymbolicConstants _ true.
	scopeStack _ OrderedCollection new.
	pools _ IdentitySet new.
	abstractDeclarations _ IdentitySet new.
	uncheckedAbstractMethods _ OrderedCollection new.
! !

!JSCodeGenerator methodsFor: 'public' stamp: 'JMM 11/28/2002 11:52'!
isGlobalStructureBuild
	^false! !

!JSCodeGenerator methodsFor: 'public' stamp: 'bf 10/1/2014 16:30'!
storeCodeOnFile: fileName doInlining: inlineFlag
	"Store JS code for this code base on the given file."

	self storeCodeOnFile: fileName doInlining: inlineFlag doAssertions: true! !

!JSCodeGenerator methodsFor: 'public' stamp: 'jpb 5/20/2020 23:38:31'!
storeCodeOnFile: fileName doInlining: inlineFlag doAssertions: assertionFlag
	"Store JS code for this code base on the given file."

	| stream |
	[
		stream _ systemAdapter openNewFileNamed: fileName.
		self emitJSCodeOn: stream doInlining: inlineFlag doAssertions: assertionFlag.
	] ensure: [stream close]! !

!JSCodeGenerator methodsFor: 'public' stamp: 'eem 7/16/2009 14:07'!
var: varName declareC: declarationString
	"Record the given C declaration for a global variable."

	(declarationString includesSubString: varName) ifFalse:
		[self error: 'declaration omits variable name.  probably an error.  use e.g. var:type:'].
	variableDeclarations at: varName asString put: declarationString.! !

!JSCodeGenerator methodsFor: 'public' stamp: 'jpb 5/16/2020 23:14:25'!
var: varName type: type
"Use this in preference to #var:declareC: whenver possible since it avoids typing the varname twice and thus avoids the potential for a typo. See also #var:type:array:"
	self var: varName declare: type , ' ' , varName! !

!JSCodeGenerator methodsFor: 'public' stamp: 'bf 10/5/2014 15:30'!
var: varName type: type array: array
"use this in preference to #var:declareC: when possible. This produces a JS statment of the form
var fooArray = [1,2,3]
See also #var:type: for simple var decls" 
	self
		var: varName
		declareC: (String streamContents: [:s |
			s nextPutAll: type.
			s space.
			s nextPutAll: varName.
			s nextPutAll: ' = ['.
			self printArray: array on: s.
			s nextPut: $]])! !

!JSCodeGenerator methodsFor: 'public' stamp: 'jpb 5/19/2020 15:59:56'!
vmClass
	"Answer the interpreter classs if any.  This is nil other than for the core VM."
	^originClass! !

!JSCodeGenerator methodsFor: 'public' stamp: 'jpb 5/19/2020 15:59:56'!
vmClass: aClass
	"Set the interpreter class if any.  This is nil other than for the core VM."
	originClass _ aClass! !

!JSCodeGenerator methodsFor: 'composition' stamp: 'dtl 1/25/2012 05:18'!
addClass: aClass selectorPrefix: prefix
	"Incorporate the methods of aClass, and rename with prefixes reflecting the
	variable name. This is a simple transformation intended to support MemoryAccess,
	with renaming to avoid conflict with standard sqMemoryAccess.h macros."

	self addClass: aClass.
	aClass selectors do: [:sel |
		self renameSelector: sel
			as: (prefix, '_', sel) asSymbol].
! !

!JSCodeGenerator methodsFor: 'composition' stamp: 'dtl 4/11/2012 21:28'!
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
				cls _ cls superclass]
! !

!JSCodeGenerator methodsFor: 'composition' stamp: 'dtl 4/11/2012 18:52'!
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

!JSCodeGenerator methodsFor: 'composition' stamp: 'dtl 8/20/2011 14:32'!
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

!JSCodeGenerator methodsFor: 'utilities'!
addMethod: aJSMethod
	"Add the given method to the code base."

	(methods includesKey:  aJSMethod selector) ifTrue: [
		self error: 'Method name conflict: ', aJSMethod selector.
	].
	methods at: aJSMethod selector put: aJSMethod.! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/28/2020 17:08:12'!
addMethodFor: aClass selector: selector
	"Add the given method to the code base and answer its translation
	 or nil if it shouldn't be translated."

	| method tmethod |
	method _ aClass compiledMethodAt: selector.
	"Not implemented yet: 
	    method requiresConcreteImplementation ifTrue: [abstractDeclarations add: selector].
	   method isAbstract ifTrue: [^nil]."
	
	(method pragmaAt: #doNotGenerate) ifNotNil: [^nil].
	
	tmethod _ self compileToJSMethodSelector: selector in: aClass.
	tmethod hasDoNotGenerateStatement ifTrue: [^nil].
	
	self addMethod: tmethod.
	
	^tmethod! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'eem 2/12/2009 13:44'!
checkDeleteVariable: aName
	"Hook for debugging variable deletion."! !

!JSCodeGenerator methodsFor: 'utilities'!
checkForGlobalUsage: vars in: aJSMethod 
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
					item add: aJSMethod selector]].
	aJSMethod referencesGlobalStructMakeZero! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'eem 2/12/2009 10:50'!
compileToJSMethodSelector: selector in: aClass
	"Compile a method to a JSMethod"

	^(Compiler new
		parse: (aClass sourceCodeAt: selector)
		in: aClass
		notifying: nil)
			asTranslationMethodOfClass: self translationMethodClass! !

!JSCodeGenerator methodsFor: 'utilities' stamp: '2/7/08 14:57'!
emitBuiltinConstructAsArgumentFor: msgNode on: aStream level: level
	"If the given selector is in the translation dictionary, translate it into a target code construct and return true. Otherwise, do nothing and return false."

	| action |
	action _ asArgumentTranslationDict
				at: msgNode selector
				ifAbsent: [translationDict at: msgNode selector ifAbsent: [ ^false ]].
	self perform: action with: msgNode with: aStream with: level.
	^true! !

!JSCodeGenerator methodsFor: 'utilities'!
emitBuiltinConstructFor: msgNode on: aStream level: level
	"If the given selector is in the translation dictionary, translate it into a target code construct and return true. Otherwise, do nothing and return false."

	| action |
	action _ translationDict at: msgNode selector ifAbsent: [ ^false ].
	self perform: action with: msgNode with: aStream with: level.
	^true! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/20/2020 21:52:16'!
findCodeForMethod: selector
	"Answer a string containing the C code for the given method."
	"Example:
		((JSCodeGenerator new initialize addClass: TestCClass1; prepareMethods)
			cCodeForMethod: #ifTests)"

	| m s |
	m _ self methodNamed: selector.
	m = nil ifTrue: [ self error: 'method not found in code base: ', selector ].

	s _ (ReadWriteStream on: '').
	m emitJSCodeOn: s generator: self.
	^ s contents! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'eem 7/19/2013 10:32'!
isBuiltinSelector: sel
	"Answer true if the given selector is one of the builtin selectors."

	^(self isKernelSelector: sel) or: [translationDict includesKey: sel]! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/21/2020 11:19:55'!
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
		 coerce:to: coerceSimple:to:)
			includes: sel)! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/28/2020 19:09:17'!
localizeGlobalVariables
	| candidates procedure |
	self flag: #fixme.

	"find all globals used in only one method"
	candidates _ globalVariableUsage select: [:e | e size = 1].
	(candidates keys select: [:k|  false "FIXME: Mechanism for determining if a variable must be global was removed"  ]) do:
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

!JSCodeGenerator methodsFor: 'utilities' stamp: 'dtl 7/3/2008 12:16'!
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

!JSCodeGenerator methodsFor: 'utilities'!
methodNamed: selector
	"Answer the method in the code base with the given selector."

	^ methods at: selector ifAbsent: [ nil ]! !

!JSCodeGenerator methodsFor: 'utilities'!
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

!JSCodeGenerator methodsFor: 'utilities'!
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

!JSCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/20/2020 22:49:14'!
nilOrBooleanConstantReceiverOf: sendNode
	"Answer nil or the boolean constant that is the receiver of the given message send. Used to suppress conditional code when the condition is a translation-time constant."

	| rcvr val |
	rcvr _ sendNode receiver.
	rcvr isConstant ifTrue: [
		val _ rcvr value.
		((val == true) or: [val == false]) ifTrue: [^ val]].
	^ nil
! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'dtl 1/22/2012 14:34'!
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

!JSCodeGenerator methodsFor: 'utilities' stamp: 'eem 4/17/2009 14:40'!
removeMethodForSelector: aSelector
	"Remove the given method from the code base"
	methods removeKey:  aSelector ifAbsent: []! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'jpb 5/28/2020 18:52:30'!
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
						, ' doesn''t exist or has already been removed'
					]].
			
	variableDeclarations removeKey: aName ifAbsent: []! !

!JSCodeGenerator methodsFor: 'utilities'!
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
					Transcript show: m selector, ' is recursive'; cr.
				] ifFalse: [
					(visited includes: sel) ifFalse: [
						called _ self methodNamed: sel.
						called = nil ifFalse: [ newCalls addAll: called allCalls ].
					].
					visited add: sel.
				].
			].
			calls _ newCalls asOrderedCollection.
		].
	].! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'bf 10/7/2014 00:06'!
returnPrefixFromVariable: aName
	aName = 'class'
		ifTrue: [^'sq_class'].
	aName = 'in'
		ifTrue: [^'in_'].
	^aName! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'eem 5/20/2010 20:46'!
sortMethods: aJSMethodCollection
	"We need to define this since different Squeak versions answer different results
	 for asSortedCollection and if sort order changes, generated code changes too."
	^aJSMethodCollection asSortedCollection:
		[:a :b| a selector caseSensitiveLessOrEqual: b selector]! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'bf 9/30/2014 22:38'!
translationMethodClass
	"return the class used to produce JS translation methods from MethodNodes"
	^JSMethod! !

!JSCodeGenerator methodsFor: 'utilities' stamp: 'ar 7/17/1999 15:06'!
unreachableMethods
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

!JSCodeGenerator methodsFor: 'error notification' stamp: 'dtl 6/17/2012 23:05'!
checkAbstractMethods
	"For each method that has been declared abstract, ensure that a concrete
	implementation has been provided. This check should be performed prior to
	inlining because methods may be removed during the inlining process."

	| selectors |
	selectors _ methods keys, self uncheckedAbstractMethods.
	abstractDeclarations do: [:sel |
		(selectors includes: sel)
			ifFalse: [self notify: 'missing implementation for ', sel]]
! !

!JSCodeGenerator methodsFor: 'error notification' stamp: 'jpb 5/21/2020 11:09:54'!
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
			meth isAbstract not and: [(meth pragmaAt: #doNotGenerate) isNil]]) ifTrue:
				[self error: 'Method ', sel, ' was defined in a previously added class.']]! !

!JSCodeGenerator methodsFor: 'error notification'!
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

	Transcript cr.
	undefinedCalls keys asSortedCollection do: [ :undefined |
		Transcript show: undefined, ' -- undefined method sent by:'; cr.
		(undefinedCalls at: undefined) do: [ :caller |
			Transcript tab; show: caller; cr.
		].
	].! !

!JSCodeGenerator methodsFor: 'error notification'!
printUnboundVariableReferenceWarnings
	"Print a warning message for every unbound variable reference in the code base."

	| undefinedRefs globalVars knownVars |
	undefinedRefs _ Dictionary new.
	globalVars _ Set new: 100.
	globalVars addAll: variables.
	methods do: [ :m |
		knownVars _ globalVars copy.
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

!JSCodeGenerator methodsFor: 'private' stamp: 'bf 11/12/2014 11:01'!
checkNonPointer: node op: op
	self ifPointerVar: node then: [:type |
		self halt: 'cannot do ', op, ' with ', type]! !

!JSCodeGenerator methodsFor: 'private' stamp: 'jpb 5/28/2020 17:51:24'!
ifPointerVar: node then: aBlock
	(node isSend and: [node selector = #+]) ifTrue: [
		^self ifPointerVar: node receiver then: aBlock].
	
	(node is: #Variable) ifTrue: [
		(self typeOfVariable: node name) ifNotNil: [:type |
			(type includes: $*) ifTrue: [aBlock value: type]]].
! !

!JSCodeGenerator methodsFor: 'private' stamp: 'bf 11/12/2014 11:03'!
isPointer: node
	self ifPointerVar: node then: [:type | ^true].
	^false! !

!JSCodeGenerator methodsFor: 'private' stamp: 'sma 3/3/2000 12:08'!
printArray: array on: aStream
	| first |
	first _ true.
	1 to: array size do:
		[:i |
		first 
			ifTrue: [first _ false]
			ifFalse: [aStream nextPutAll: ', '].
		i \\ 16 = 1 ifTrue: [aStream cr].
		self printInt: (array at: i) on: aStream]! !

!JSCodeGenerator methodsFor: 'private' stamp: 'bf 10/5/2014 15:31'!
printInt: int on: aStream
	aStream print: int.
! !

!JSCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/27/2020 21:02:18'!
collectInlineList
	"Make a list of methods that should be inlined."
	"Details: The method must not include any inline C, since the translator cannot
	currently map variable names in inlined C code. The #inline: directive may be
	used to override this for cases in which the C code or declarations are harmless.
	Methods to be inlined must be small or called from only one place."

	| methodsNotToInline callsOf inlineIt hasCCode nodeCount senderCount
sel |
	methodsNotToInline _ Set new: methods size.

	"build dictionary to record the number of calls to each method"
	callsOf _ Dictionary new: methods size * 2.
	methods keys do: [ :s | callsOf at: s put: 0 ].

	"For each method, scan its parse tree once to:
		1. determine if the method contains C code or declarations
		2. determine how many nodes it has
		3. increment the sender counts of the methods it calls
		4. determine if it includes any C declarations or code"
	inlineList _ Set new: methods size * 2.
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
			].
		].
	].

	callsOf associationsDo: [ :assoc |
		((assoc value = 1) and: [(methodsNotToInline includes: assoc key)
not]) ifTrue: [
			inlineList add: assoc key.
		].
	].! !

!JSCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/24/2020 10:35:16'!
doBasicInlining: inlineFlag
	"Inline the bodies of all methods that are suitable for inlining.
	This method does only the basic inlining suitable for both the core VM and plugins - no bytecode inlining etc"

	inlineFlag ifFalse: [^self].
	self collectInlineList.
	self tryMethodInliningWithProgressNotification.
! !

!JSCodeGenerator methodsFor: 'inlining' stamp: 'dtl 8/21/2011 21:12'!
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

!JSCodeGenerator methodsFor: 'inlining' stamp: 'dtl 6/21/2008 12:54'!
inlineCaseStatementBranchesInMethodNamed: selector localizingVars: varsList 
	"Inline case statement branches in the method with the given name."
	(self methodNamed: selector)
		ifNotNilDo: [:m | m inlineCaseStatementBranchesIn: self localizingVars: varsList]! !

!JSCodeGenerator methodsFor: 'inlining' stamp: 'ar 7/8/2003 11:27'!
inlineDispatchesInMethodNamed: selector localizingVars: varsList
	"Inline dispatches (case statements) in the method with the given name."

	| m varString |
	m _ self methodNamed: selector.
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

!JSCodeGenerator methodsFor: 'inlining' stamp: 'eem 7/30/2013 16:26'!
isAssertSelector: selector
	^#(assert: asserta: assert:l: asserta:l:) includes: selector! !

!JSCodeGenerator methodsFor: 'inlining'!
mayInline: sel
	"Answer true if the method with the given selector may be inlined."

	^ inlineList includes: sel! !

!JSCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/27/2020 21:16:27'!
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

!JSCodeGenerator methodsFor: 'inlining' stamp: 'ar 2/3/2001 17:08'!
pruneMethods: selectorList
	"Explicitly prune some methods"
	selectorList do:[:sel| methods removeKey: sel ifAbsent:[]].! !

!JSCodeGenerator methodsFor: 'inlining' stamp: 'tpr 3/2/2004 11:09'!
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

!JSCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/28/2020 17:41:15'!
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

!JSCodeGenerator methodsFor: 'inlining' stamp: 'dtl 6/21/2008 09:21'!
removeMethodsReferingToGlobals: varList except: methodNames
	"Remove any methods (presumably inlined) that still contain references to the given obsolete global variables."

	| varListAsStrings mVars |
	varListAsStrings _ varList collect: [ :sym | sym asString ].
		(methods keys copyWithoutAll: methodNames) do: [ :sel |
			mVars _ (self methodNamed: sel) freeVariableReferences asSet.
			(mVars includesAnyOf: varListAsStrings)
				ifTrue: [methods removeKey: sel ifAbsent: []]]
! !

!JSCodeGenerator methodsFor: 'inlining' stamp: 'tpr 2/27/2004 18:49'!
retainMethods: aListOfMethodsToKeep
"add aListOfMethodsToKeep to doNotRemoveMethodList so that they will not be pruned"
	doNotRemoveMethodList ifNil:[doNotRemoveMethodList _ Set new:100].
	doNotRemoveMethodList addAll: aListOfMethodsToKeep.
	^aListOfMethodsToKeep! !

!JSCodeGenerator methodsFor: 'inlining' stamp: 'jpb 5/24/2020 10:34:44'!
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

!JSCodeGenerator methodsFor: 'accessing' stamp: 'eem 7/2/2008 16:01'!
currentMethod
	^currentMethod! !

!JSCodeGenerator methodsFor: 'accessing' stamp: 'eem 7/2/2008 16:01'!
currentMethod: aJSMethod
	currentMethod _ aJSMethod! !

!JSCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 17:25'!
declareMethodsStatic
	"If true generated methods will be declared static. Default is true,
	appropriate for plugins."
	^ declareMethodsStatic
		ifNil: [declareMethodsStatic _ true]! !

!JSCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 17:26'!
declareMethodsStatic: aBoolean
	"If set false, generated methods will be not declared static.
	Default value is true."
	declareMethodsStatic _ aBoolean! !

!JSCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 18:54'!
permitMethodPruning
	"If false, pruning unreferenced methods will be disabled"
	^ permitMethodPruning ~= false! !

!JSCodeGenerator methodsFor: 'accessing' stamp: 'dtl 8/21/2011 18:53'!
permitMethodPruning: aBoolean
	"If false, pruning unreferenced methods will be disabled"
	permitMethodPruning _ aBoolean! !

!JSCodeGenerator methodsFor: 'accessing' stamp: 'dtl 6/17/2012 23:01'!
uncheckedAbstractMethods
	"Answer the selectors for methods that should not be checked to ensure existence
	of concrete implementations, such as methods that are generated directly by the
	code generator itself."

	^uncheckedAbstractMethods

! !

!JSCodeGenerator methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:23'!
useSymbolicConstants
	"Answer whether we should generate symbolic constants instead of their actual values"
	^useSymbolicConstants! !

!JSCodeGenerator methodsFor: 'accessing' stamp: 'ar 7/8/2003 11:23'!
useSymbolicConstants: aBool
	"Indicate whether we should generate symbolic constants instead of their actual values"
	useSymbolicConstants _ aBool! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/29/2020 20:56:05'!
emitExportsOn: aStream
	"Store all the exported primitives in a form to be used by the internal named prim system"
	aStream nextPutAll:'

void* vm_exports[][3] = {'.
	self exportedPrimitiveNames do:[:primName|
		aStream newLine;
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

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/26/2020 21:53:46'!
emitJSCodeOn: aStream 
	"Emit C code for all methods in the code base onto the given stream. All inlined method calls should already have been expanded."

	self emitJSHeaderOn: aStream.
	self emitJSTypesOn: aStream.
	self emitJSConstantsOn: aStream.
	self emitJSVariablesOn: aStream.

	systemAdapter
		showProgressIn: preparedMethodList 
		label: 'Emitting Javascript Code'
		do:  [ :progress :m :i | "bar value: i."
			m emitJSCodeOn: aStream generator: self].
		
	self emitExportsOn: aStream.
! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/26/2020 21:53:46'!
emitJSCodeOn: aStream doInlining: inlineFlag doAssertions: assertionFlag
	"Emit C code for all methods in the code base onto the given stream. All inlined method calls should already have been expanded."

	self prepareMethodsInlined: inlineFlag doAssertions: assertionFlag.
	^ self emitJSCodeOn: aStream ! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 10/6/2014 15:40'!
emitJSConstantsOn: aStream
	"Store the global variable declarations on the given stream."
	| unused constList node |
	unused _ constants keys asSet.
	methods do: [ :meth |
		meth parseTree nodesDo: [ :n |
			n isConstant ifTrue: [ unused remove: n name ifAbsent: []]]].
	constList _ constants keys reject: [ :any | unused includes: any].
	constList isEmpty ifTrue: [^self].
	aStream nextPutAll: '/*** Constants ***/';
		 cr.
	constList asSortedCollection do: [ :varName |
		node _ constants at: varName.
		node name isEmpty ifFalse: [
			aStream nextPutAll: 'var '.
			aStream nextPutAll: node name.
			aStream nextPutAll: ' = '.
			aStream nextPutAll: (self jsLiteralFor: node value).
			aStream nextPut: $;.
			aStream cr
		].
	].
	aStream cr.! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 11/3/2014 13:22'!
emitJSExpression: aParseNode on: aStream 
	"Emit C code for the expression described by the given parse node."

	aParseNode isLeafOrFunc 
		ifTrue: 
			["omit parens"
			 aParseNode emitJSCodeAsExpressionOn: aStream level: 0 generator: self]
		ifFalse: 
			[aStream nextPut: $(.
			 aParseNode emitJSCodeAsExpressionOn: aStream level: 0 generator: self.
			 aStream nextPut: $)]! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 10/6/2014 15:34'!
emitJSHeaderOn: aStream
	self halt.! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 10/6/2014 15:38'!
emitJSTestBlock: aBlockNode on: aStream
	"Emit JS code for the given block node to be used as a loop test."

	aBlockNode statements size > 1 ifTrue: [
		aBlockNode emitJSCodeOn: aStream level: 0 generator: self.
	] ifFalse: [
		aBlockNode statements first asExpression emitJSCodeOn: aStream level: 0 generator: self.
	].! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/19/2020 15:59:56'!
emitJSTypesOn: aStream 
	"Store local type declarations on the given stream."
	originClass ifNotNil:
		[originClass ancilliaryStructClasses do:
			[:structClass|
			(originClass shouldGenerateTypedefFor: structClass) ifTrue:
				[structClass printTypedefOn: aStream.
				 aStream cr; cr]]]! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 10/6/2014 12:44'!
emitJSVariablesOn: aStream 
	"Store the global variable declarations on the given stream."
	aStream nextPutAll: '/*** Variables ***/'; cr.
	variables asSortedCollection
		do: [:var | 	| varString varDecl |
			varString _ var asString.
			aStream nextPutAll: 'var ', varString.
			varDecl _ variableDeclarations at: varString ifAbsent: [''].
			(varDecl includes: $=)
				ifTrue: [ | const |
					const _ ((varDecl copyAfter: $=) replaceAll: ${ with: $[) replaceAll: $} with: $].
					aStream nextPutAll: ' =', const]
				ifFalse: [(varDecl includesAnyOf: '*[')
					ifTrue: [(varDecl includes: $[)
						ifTrue: [ | size |
							size _ (varDecl copyAfter: $[) copyUpTo: $].
							size ifEmpty: [self halt].
							aStream nextPutAll: ' = new Array(', size, ')']
						ifFalse: [aStream nextPutAll: ' = null']]
					ifFalse: [aStream nextPutAll: ' = 0']].
			aStream nextPutAll: ';'; cr].
	aStream cr.
! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/20/2020 23:53:07'!
fileHeaderVersionStampForSourceClass: sourceClass
	"Answer a suitable version stamp to include in the header."
	| slangDescription sourceDescription |
	slangDescription _ systemAdapter findSlangDescriptionBy: self class.
	sourceClass ifNotNil: [sourceDescription _ systemAdapter findSourceDescriptionBy: sourceClass].
	
	^String streamContents:
		[:s| 
		s nextPutAll: '/* Automatically generated by\	' .
		s nextPutAll: slangDescription.
		sourceDescription ifNotNil:
			[s nextPutAll: '\   from\	' ; nextPutAll: sourceDescription ].
		s newLine; nextPutAll: ' */'; newLine]! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 10/6/2014 15:39'!
isJSLiteral: anObject
	(anObject isKindOf: Integer) ifTrue: [^true].
	(anObject isKindOf: String) ifTrue: [^true].
	(anObject isKindOf: Float) ifTrue: [^true].
	anObject == nil ifTrue: [^true].
	anObject == true ifTrue: [^true].
	anObject == false ifTrue: [^true].
	^false! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/28/2020 19:02:39'!
isNonArgumentImplicitReceiverVariableName: aString
	^(self typeOfVariable: aString) == #implicit
	    or: [ #('interpreterProxy' 'self') includes: aString ]
	 	! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/21/2020 18:39:05'!
isPointerToStructVariableName: varName "<String>"
	^self isType: (self typeOfVariable: varName) kind: #pointerToStruct! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/21/2020 09:56:57'!
isTypedPointerToStruct: type "<String>"
	^originClass notNil
	  and: [originClass isTypedPointerToStruct: type]! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 10/6/2014 15:41'!
jsFunctionNameFor: aSelector
	"Create a JS function name from the given selector by omitting colons
	and prefixing with the plugin name if the method is exported."
	^aSelector copyWithout: $:! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 10/6/2014 15:40'!
jsLiteralFor: anObject
	"Return a string representing theJS literal value for the given object."
	(anObject isKindOf: Integer) ifTrue: [^ anObject printString].
	(anObject isKindOf: String) ifTrue: [^ '"', anObject, '"' ].
	(anObject isKindOf: Float) ifTrue: [^ anObject printString ].
	anObject == nil ifTrue: [^ 'null' ].
	anObject == true ifTrue: [^ 'true' ].
	anObject == false ifTrue: [^ 'false' ].
	self error:
		'Warning: A Smalltalk literal could not be translated into a JS constant: ', anObject printString.
	^'"XXX UNTRANSLATABLE CONSTANT XXX"'! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/27/2020 21:01:23'!
prepareMethodsInlined: inlineFlag doAssertions: assertionFlag
	"Prepare to emit JS code for all methods in the code base. All inlined method calls should be expanded. Answer a list of methods to be emitted as C code."

	| verbose methodList |
	"method preparation"
	verbose _ false.
	self pruneMethods: self ignoredMethods.
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

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'eem 7/2/2008 14:21'!
pushScope: variableToType "<Dictionary>" while: aBlock
	scopeStack addLast: variableToType.
	^aBlock ensure: [scopeStack removeLast]! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/21/2020 09:56:57'!
selectorReturnsPointerToStruct: selector "<Symbol>"
	| tMethod |
	^originClass notNil
	  and: [(tMethod _ methods at: selector ifAbsent: []) notNil
	  and: [originClass isTypedPointerToStruct: tMethod returnType]]! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'eem 2/10/2009 15:05'!
shortMonticelloDescriptionForClass: aClass
	"Answer a suitable Monticello package stamp to include in a moduleName."
	| mdesc |
	mdesc _ [self monticelloDescriptionFor: aClass]
				on: Error
				do: [:ex| ^' ', Date today asString].
	^mdesc copyFrom: 1 to: (mdesc indexOfSubCollection: ' uuid:') - 1! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'jpb 5/21/2020 11:31:54'!
structTargetKindForVariableName: varName "<String>"
	^typeRepository findStructTargetKindForDeclaration: (self typeOfVariable: varName)! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'bf 10/2/2014 18:36'!
typeOfArgument: argIndex in: selector
	| method |
	method _ methods at: selector.
	^method declarations at: (method args at: argIndex).
! !

!JSCodeGenerator methodsFor: 'JS code generator' stamp: 'eem 2/9/2009 20:39'!
typeOfVariable: varName "<String>" 
	scopeStack reverseDo:
		[:dict|
		(dict includesKey: varName) ifTrue:
			[^dict at: varName]].
	^variableDeclarations at: varName ifAbsent: nil! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:09'!
generateAddressOf: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	aStream nextPut: $(; nextPut: $&.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPut: $)! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:09'!
generateAnd: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' && '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/5/2014 23:01'!
generateAsFloat: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	self emitJSExpression: msgNode receiver on: aStream.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/5/2014 21:36'!
generateAsInteger: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	aStream nextPutAll:'('.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: '|0)'! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/6/2014 15:41'!
generateAsSymbol: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream.
	 The receiver is expected to be a JSConstantNode."

	aStream nextPutAll: (self jsFunctionNameFor: msgNode receiver nameOrValue)! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:26'!
generateAsUnsignedInteger: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	aStream nextPutAll:'((usqInt)'.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPut: $)! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'jpb 5/28/2020 17:49:56'!
generateAt: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	| arrayNode indexNode subtractOne complex coerceTo |
	arrayNode _ msgNode receiver.
	(arrayNode isSend and: [arrayNode selector = #coerce:to: and: [arrayNode args first is: #Variable]]) ifTrue: [
		coerceTo _ (arrayNode args second value) copyWithout: $ .
		arrayNode _ arrayNode args first.
		aStream nextPutAll: '('].
	indexNode _ msgNode args first.
	subtractOne _ self isOneBasedArray: arrayNode name in: currentMethod.
	(subtractOne and: [indexNode isPlusOne]) ifTrue: [
		subtractOne _ false.
		indexNode _ indexNode receiver.	"remove + 1"
	].
	complex _ subtractOne and: [indexNode isLeafOrFunc not].
	self emitJSExpression: arrayNode on: aStream.
	aStream nextPut: $[.
	complex ifTrue: [aStream nextPut: $(].
	indexNode emitJSCodeAsExpressionOn: aStream level: level + 1 generator: self.
	complex ifTrue: [aStream nextPut: $)].
	subtractOne ifTrue: [aStream nextPutAll: ' - 1'].
	aStream nextPut: $].
	coerceTo ifNotNil: [
		coerceTo = 'int*' ifFalse: [self halt].
		aStream nextPutAll: '|0)'].
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'jpb 5/21/2020 11:18:34'!
generateAtPut: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	| putExpr incExpr |
	(msgNode receiver isSend and: [msgNode receiver selector = #coerce:to:]) ifTrue: [
		msgNode receiver args asString =  '{deltaST . ''int *''}'
			ifTrue: [msgNode receiver: msgNode receiver args first]].	"HACK!!"
	self generateAt: msgNode on: aStream indent: level.

	(putExpr _ msgNode args last) isPlusOne ifTrue: [
		((incExpr _ putExpr receiver) isSend and: [incExpr selector = #at: and: [
			incExpr receiver asString = msgNode receiver asString and: [
			incExpr args first asString = msgNode args first asString]]])
				ifTrue: [^aStream nextPutAll: '++'.]].

	aStream nextPutAll: ' = '.
	self emitJSExpression: putExpr on: aStream! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:27'!
generateBaseHeaderSize: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	aStream nextPutAll: 'BASE_HEADER_SIZE'

! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:27'!
generateBetweenAnd: msgNode on: aStream indent: level
	"Generate the JS code for the between:and: message onto the given stream."

	aStream nextPutAll: '(('.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' >= '.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') && ('.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' <= '.
	self emitJSExpression: msgNode args second on: aStream.
	aStream nextPutAll: '))'! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:27'!
generateBitAnd: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' & '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:27'!
generateBitClear: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: '(('.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' | '.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') - '.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPut: '|0))'! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:27'!
generateBitInvert32: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPut: $~.
	self emitJSExpression: msgNode receiver on: aStream! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:27'!
generateBitOr: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' | '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'jpb 5/21/2020 11:18:39'!
generateBitShift: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	| arg rcvr |
	arg _ msgNode args first.
	rcvr _ msgNode receiver.
	arg isConstant ifTrue: [
		"bit shift amount is a constant"
		arg value < 0 ifTrue: [
			"skip unneeded coercion to unsigned"
			(rcvr isSend and: [rcvr selector = #coerce:to: and: [rcvr args second value = 'unsigned']])
				ifTrue: [self emitJSExpression: rcvr args first on: aStream]
				ifFalse: [self emitJSExpression: rcvr on: aStream].
			aStream nextPutAll: ' >>> ', arg value negated printString.
		] ifFalse: [
			self emitJSExpression: rcvr on: aStream.
			aStream nextPutAll: ' << ', arg value printString.
		].
	] ifFalse: [
		"bit shift amount is an expression"
		aStream nextPutAll: 'SHIFT('.
		self emitJSExpression: rcvr on: aStream.
		aStream nextPutAll: ', '.
		self emitJSExpression: arg on: aStream.
		aStream nextPutAll: ')'.
	].! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:27'!
generateBitXor: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' ^ '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:27'!
generateBytesPerWord: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	aStream nextPutAll: 'BYTES_PER_WORD'
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 11/12/2014 17:43'!
generateCCoercion: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	| expr cType |.
	expr _ msgNode args first.
	cType _ msgNode args second value.
	(expr isSend and: [expr receiver name = 'interpreterProxy' and: [expr selector = #firstIndexableField:]]) ifTrue: [
		cType _ msgNode args second value.
		self emitJSExpression: expr args first on: aStream.
		cType = 'unsigned char *' ifTrue: [^aStream nextPutAll: '.bytes'].
		cType = 'unsigned int *' ifTrue: [^aStream nextPutAll: '.words'].
		cType = 'int *' ifTrue: [^aStream nextPutAll: '.wordsAsInt32Array()'].
		cType = 'short *' ifTrue: [^aStream nextPutAll: '.wordsAsInt16Array()'].
		cType = 'float *' ifTrue: [^aStream nextPutAll: '.wordsAsFloat32Array()'].
		cType = 'double *' ifTrue: [^aStream nextPutAll: '.wordsAsFloat64Array()'].
		self halt.
	] ifFalse: [
		(#('int') includes: cType) ifTrue: [
			aStream nextPutAll: '('.
			self emitJSExpression: expr on: aStream.
			^aStream nextPutAll: '|0)'].
		(#('unsigned int' 'unsigned' ) includes: cType) ifTrue: [
				aStream nextPutAll: '('.
				self emitJSExpression: expr on: aStream.
				^ aStream nextPutAll: '>>>0)'].
		((#('double' 'float') includes: cType) or: [('sqInt (*)(*)'match: cType)
			or: [#(transformPoint:into:) includes: currentMethod selector]])
			ifFalse: [self halt].
		self emitJSExpression: expr on: aStream.
	]
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 11/12/2014 11:22'!
generateDivide: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	| rcvr arg divisor |
	rcvr _ msgNode receiver.
	arg _ msgNode args first.
	msgNode selector == #/ ifTrue: [
		(#('Matrix2x3Plugin' 'ScratchPlugin' 'FloatArrayPlugin' 'KedamaPlugin' 'KedamaPlugin2' 'FFTPlugin' 'Klatt' 'B2DPlugin') includes: self pluginName) ifFalse: [self halt: msgNode].
		self emitJSExpression: rcvr on: aStream.
		aStream nextPutAll: ' / '.
		^self emitJSExpression: arg on: aStream].
	(arg isConstant and:
	 [UseRightShiftForDivide and:
	 [(divisor _ arg value) isInteger and:
	 [divisor isPowerOfTwo and:
	 [divisor > 0 and:
	 [divisor <= (1 bitShift: 31)]]]]])
	ifTrue: [
		"use signed (arithmetic) right shift instead of divide"
		self emitJSExpression: rcvr on: aStream.
		aStream nextPutAll: ' >> ', (divisor log: 2) asInteger printString.
	] ifFalse: [
		"use float divide and coerce to integer"
		aStream nextPutAll: 'DIV('.
		self emitJSExpression: rcvr on: aStream.
		aStream nextPutAll: ', '.
		self emitJSExpression: arg on: aStream.
		aStream nextPutAll: ')'.
	].
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'dtl 11/9/2006 06:24'!
generateDoWhileFalse: msgNode on: aStream indent: level
	"Generate do {stmtList} while(!!(cond))"

	| stmts testStmt |
	stmts _ msgNode receiver statements asOrderedCollection.
	testStmt _ stmts removeLast.
	msgNode receiver setStatements: stmts.
	aStream nextPutAll: 'do {'; cr.
	msgNode receiver emitJSCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '} while(!!('.
	testStmt asExpression emitJSCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: '))'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'dtl 11/9/2006 06:24'!
generateDoWhileTrue: msgNode on: aStream indent: level
	"Generate do {stmtList} while(cond)"

	| stmts testStmt |
	stmts _ msgNode receiver statements asOrderedCollection.
	testStmt _ stmts removeLast.
	msgNode receiver setStatements: stmts.
	aStream nextPutAll: 'do {'; cr.
	msgNode receiver emitJSCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '} while('.
	testStmt asExpression emitJSCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: ')'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/6/2014 15:20'!
generateEqual: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	| argNode test |
	argNode _  msgNode args first.
	"quick test for nil, true, false"
	argNode isInterpreterProxyConstant ifTrue: [
		test _ #(isNil isTrue isFalse) at: (#(nilObject trueObject falseObject) indexOf: argNode selector).
		self emitJSExpression: msgNode receiver on: aStream.
		^aStream nextPut: $.; nextPutAll: test].
	"cannot compare pointers to 0"
	(argNode isConstantNull or: [argNode isConstantZero and: [self isPointer: msgNode receiver]]) ifTrue: [
		aStream nextPutAll: '!!'.
		^self emitJSExpression: msgNode receiver on: aStream].
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' === '.
	self emitJSExpression: argNode on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:28'!
generateGreaterThan: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' > '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:28'!
generateGreaterThanOrEqual: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' >= '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'jpb 5/21/2020 11:38:46'!
generateIfFalse: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self flag: #fixme. "Fix to the correct emit calls"
	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if ('.
			self generateNot: (SlangTSendNode new
					setSelector: #not receiver: msgNode receiver arguments: #())
				on: aStream indent: level + 1.
			aStream nextPutAll: ') {'; cr.
			"FIXME: msgNode args last emitJSCodeOn: aStream level: level + 1 generator: self."
			level timesRepeat: [aStream tab].
			aStream nextPut: $}]
		ifNotNil:
			[:const |
			const ifFalse:
				["FIXME: msgNode args first emitJSCodeOn: aStream level: level generator: self"]]! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:26'!
generateIfFalseAsArgument: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			 msgNode receiver emitJSCodeAsArgumentOn: aStream level: level generator: self.
			 aStream crtab: level + 1; nextPutAll: ' ? 0 : '.
			 msgNode args first emitJSCodeAsArgumentOn: aStream level: level + 2 generator: self.
			 aStream crtab: level + 1; nextPut: $)]
		ifNotNil:
			[:const|
			const ifFalse:
				[msgNode args first emitJSCodeAsArgumentOn: aStream level: level generator: self]]! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:28'!
generateIfFalseIfTrue: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if ('.
			msgNode receiver emitJSCodeAsExpressionOn: aStream level: level generator: self.
			aStream nextPutAll: ') {'; cr.
			msgNode args last emitJSCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}; nextPutAll: ' else {'; cr.
			msgNode args first emitJSCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}]
		ifNotNil:
			[:const |
			 (const ifTrue: [msgNode args last] ifFalse: [msgNode args first])
				emitJSCodeOn: aStream level: level generator: self]! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:28'!
generateIfFalseIfTrueAsArgument: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			msgNode receiver emitJSCodeAsArgumentOn: aStream level: level generator: self.
			aStream crtab: level + 1; nextPut: $?; space.
			msgNode args last emitJSCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream crtab: level + 1; nextPut: $:; space.
			msgNode args first emitJSCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream nextPut: $)]
		ifNotNil:
			[:const|
			(const
				ifTrue: [msgNode args last]
				ifFalse: [msgNode args first])
					emitJSCodeAsArgumentOn: aStream level: level generator: self]! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:29'!
generateIfTrue: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if ('.
			msgNode receiver emitJSCodeAsExpressionOn: aStream level: level generator: self.
			aStream nextPutAll: ') {'; cr.
			msgNode args first emitJSCodeOn: aStream level: level + 1 generator: self.
			level timesRepeat: [ aStream tab ].
			aStream nextPut: $}]
		ifNotNil:
			[:const |
			const ifTrue:
				[msgNode args first emitJSCodeOn: aStream level: level generator: self]]! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:29'!
generateIfTrueAsArgument: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			 msgNode receiver emitJSCodeAsArgumentOn: aStream level: level generator: self.
			 aStream crtab: level + 1; nextPut: $?; space.
			 msgNode args first emitJSCodeAsArgumentOn: aStream level: level + 2 generator: self.
			 aStream crtab: level + 1; nextPutAll: ': 0)']
		ifNotNil:
			[:const|
			const ifTrue:
				[msgNode args first emitJSCodeAsArgumentOn: aStream level: level generator: self]]! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:29'!
generateIfTrueIfFalse: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPutAll: 'if ('.
			msgNode receiver emitJSCodeAsExpressionOn: aStream level: level generator: self.
			aStream nextPutAll: ') {'; cr.
			msgNode args first emitJSCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}; nextPutAll: ' else {'; cr.
			msgNode args last emitJSCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level; nextPut: $}]
		ifNotNil:
			[:const |
			(const ifTrue: [msgNode args first] ifFalse: [msgNode args last])
				emitJSCodeOn: aStream level: level generator: self]! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:29'!
generateIfTrueIfFalseAsArgument: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode)
		ifNil:
			[aStream nextPut: $(.
			msgNode receiver emitJSCodeAsArgumentOn: aStream level: level generator: self.
			aStream crtab: level + 1; nextPut: $?; space.
			msgNode args first emitJSCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream crtab: level + 1; nextPut: $:; space.
			msgNode args last emitJSCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream nextPut: $)]
		ifNotNil:
			[:const|
			(const ifTrue: [msgNode args first] ifFalse: [msgNode args last])
				emitJSCodeAsArgumentOn: aStream level: level generator: self]! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:31'!
generateInlineDirective: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: '/* inline: '.
	aStream nextPutAll: msgNode args first value asString.
	aStream nextPutAll: ' */'.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:38'!
generateIntegerObjectOf: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode args first on: aStream.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:39'!
generateIntegerValueOf: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode args first on: aStream.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:39'!
generateIsIntegerObject: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: 'typeof '.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' === "number"'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/6/2014 13:04'!
generateIsNil: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: '!!'.
	self emitJSExpression: msgNode receiver on: aStream.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 11/3/2014 12:27'!
generateJSCodeForCcode: cCode on: aStream indent: level
	cCode = '' ifTrue: [^self].
	aStream nextPutAll: (cCodeTranslationDict at: cCode ifAbsent: [
		(#('sqrt' 'sin' 'cos' 'tan' 'atan' 'atan2' 'log' 'exp' 'min' 'max' 'floor') anySatisfy: [:fn | fn,'(*)' match: cCode])
			ifTrue: ['Math.', cCode] ifFalse: [
		('opTable[*] = (void *)*' match: cCode)
			ifTrue: [cCode copyReplaceAll: '(void *)' with: ''] ifFalse: [
		('fn(*Handle, &*Pitch, *)' match: cCode)
			ifTrue: [(cCode copyReplaceAll: '&' with: 'function(p){') copyReplaceAll: 'Pitch' with: 'Pitch = p}'] ifFalse: [
		(' ((*)querySurfaceFn)*(handle, &destWidth, &destHeight, &destDepth, &destMSB)' match: cCode)
			ifTrue: [ 'querySurfaceFn(handle, function(w, h, d, m){destWidth = w; destHeight = h; destDepth = d; destMSB = m; })'] ifFalse: [
		(' ((*)querySurfaceFn)*(handle, &sourceWidth, &sourceHeight, &sourceDepth, &sourceMSB)' match: cCode)
			ifTrue: [ 'querySurfaceFn(handle, function(w, h, d, m){sourceWidth = w; sourceHeight = h; sourceDepth = d; sourceMSB = m; })'] ifFalse: [
		(#('fn(destHandle, affectedL, affectedT, affectedR-affectedL, affectedB-affectedT)',
			'fn(sourceHandle, 0, 0, 0, 0)') includes: cCode)
			ifTrue: [cCode] ifFalse: [
		"See initializeCTranslationDictionary"
		self error: 'C: ' , cCode]]]]]]])
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:38'!
generateLessThan: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' < '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:38'!
generateLessThanOrEqual: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' <= '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 11/3/2014 12:43'!
generateMath: msgNode on: aStream indent: level
	"Generate the JS code for the message onto the given stream."
	aStream nextPutAll: 'Math.'; nextPutAll: msgNode selector; nextPut: $(.
	msgNode receiver emitJSCodeAsExpressionOn: aStream level: 0 generator: self.
	aStream nextPut: $).
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:06'!
generateMax: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: 'Math.max('.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ', '.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPutAll: ')'.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:06'!
generateMin: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: 'Math.min('.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ', '.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPutAll: ')'.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/3/2014 02:13'!
generateMinus: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	self checkNonPointer: msgNode receiver op: '-'.
	self checkNonPointer: msgNode args first op: '-'.

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' - '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/4/2014 14:06'!
generateModulo: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: 'MOD('.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ', '.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPutAll: ')'.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:08'!
generateNegated: msgNode on: aStream indent: level
	"Generate the JS code for the negated message onto the given stream."

	"-0 is a float, 0 - 0 an integer"
	aStream nextPutAll: '(0 - '.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ')'.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/6/2014 14:26'!
generateNot: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	| expr |
	expr _ msgNode receiver.
	"generate (a !!= b) instead of !!(a == b)"
	expr isEqualityTest ifTrue: [
		^(msgNode selector includes: $~)
			ifTrue: [self generateEqual: expr on: aStream indent: level]
			ifFalse: [self generateNotEqual: expr on: aStream indent: level]].
	"eliminate not not"
	(expr isSend and: [expr selector = #not]) ifTrue: [
		^self emitJSExpression: expr receiver on: aStream].
	aStream nextPutAll: '!!'.
	self emitJSExpression: expr on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/6/2014 15:16'!
generateNotEqual: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	| argNode test |
	argNode _  msgNode args first.
	"quick test for nil, true, false"
	argNode isInterpreterProxyConstant ifTrue: [
		test _ #(isNil isTrue isFalse) at: (#(nilObject trueObject falseObject) indexOf: argNode selector).
		aStream nextPut: $!!.
		self emitJSExpression: msgNode receiver on: aStream.
		^aStream nextPut: $.; nextPutAll: test].
	"cannot compare pointers to 0"
	(argNode isConstantNull or: [argNode isConstantZero and: [self isPointer: msgNode receiver]]) ifTrue: [
		aStream nextPutAll: '!!!!'.
		^self emitJSExpression: msgNode receiver on: aStream].
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' !!== '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/6/2014 13:04'!
generateNotNil: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: '!!!!'.
	self emitJSExpression: msgNode receiver on: aStream.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:40'!
generateOr: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' || '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:40'!
generatePerform: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPut: $(.
	(msgNode args copyFrom: 2 to: msgNode args size) do:[:arg|
		self emitJSExpression: arg on: aStream.
	] separatedBy:[aStream nextPutAll:', '].
	aStream nextPut: $)! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 11/12/2014 11:09'!
generatePlus: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	msgNode receiver isBitBltPtr ifFalse: [
		self checkNonPointer: msgNode args first op: '+'.
		self ifPointerVar: msgNode receiver then: [:type |
			(self generatePointerPlus: msgNode type: type on: aStream indent: level)
				ifTrue: [^self].
			self halt: 'cannot do + with ', type].
		self emitJSExpression: msgNode receiver on: aStream.
		aStream nextPutAll: ' + '].
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 11/13/2014 18:49'!
generatePointerPlus: msgNode type: type on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	(#('B2DPlugin' 'GeniePlugin') includes: self pluginName) ifFalse: [self halt].
	msgNode emitJSPointerArithmetic: type on: aStream level: level generator: self type: type top: true.
	^true
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'jpb 5/28/2020 17:50:57'!
generatePreDecrement: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	| varNode |
	varNode _ msgNode receiver.
	(varNode is: #Variable)
		ifFalse: [ self error: 'preDecrement can only be applied to variables' ].
		
	self checkNonPointer: varNode op: '--'.
	aStream nextPutAll: '--'.
	aStream nextPutAll: (self returnPrefixFromVariable: varNode name).
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'jpb 5/28/2020 17:51:08'!
generatePreIncrement: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	| varNode |
	varNode _ msgNode receiver.
	(varNode is: #Variable)
		ifFalse: [ self error: 'preIncrement can only be applied to variables' ].
	aStream nextPutAll: '++'.
	self checkNonPointer: varNode op: '++'.
	aStream nextPutAll: (self returnPrefixFromVariable: varNode name).
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:42'!
generateRaisedTo: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll:'Math.pow('.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPutAll:')'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:42'!
generateRepeat: msgNode on: aStream indent: level
	"Generate while(true) { stmtList } "

	aStream nextPutAll: 'while(true) {'; cr.
	msgNode receiver emitJSCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:43'!
generateSequentialAnd: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' && ('.
	self emitJSTestBlock: msgNode args first on: aStream.
	aStream nextPut: $)! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:43'!
generateSequentialOr: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' || ('.
	self emitJSTestBlock: msgNode args last on: aStream.
	aStream nextPutAll: ')'! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:44'!
generateSharedCodeDirective: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: '/* common code: '.
	aStream nextPutAll: msgNode args first value.
	aStream nextPutAll: ' */'.
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/4/2014 14:12'!
generateShiftLeft: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	| arg rcvr |
	rcvr _ msgNode receiver.
	arg _ msgNode args first.
	arg isConstant ifTrue: [
		"bit shift amount is a constant"
		arg value < 31 ifTrue: [
			self emitJSExpression: rcvr on: aStream.
				aStream nextPutAll: ' << ', arg value printString.
		] ifFalse: [
			self error: 'cannot shift by more than 31'
		].
	] ifFalse: [
		"bit shift amount is an expression"
		aStream nextPutAll: 'SHL('.
		self emitJSExpression: rcvr on: aStream.
		aStream nextPutAll: ', '.
		self emitJSExpression: arg on: aStream.
		aStream nextPutAll: ')'.
	].! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/4/2014 14:12'!
generateShiftRight: msgNode on: aStream indent: level
	"Generate the JS code for unsigned right-shift onto the given stream."
	| rcvr arg |

	rcvr _ msgNode receiver.
	arg _ msgNode args first.
	arg isConstant ifTrue: [
		"bit shift amount is a constant"
		arg value < 31 ifTrue: [
			self emitJSExpression: rcvr on: aStream.
				aStream nextPutAll: ' >>> ', arg value printString.
		] ifFalse: [
			self error: 'cannot shift by more than 31'
		].
	] ifFalse: [
		"bit shift amount is an expression"
		aStream nextPutAll: 'SHR('.
		self emitJSExpression: rcvr on: aStream.
		aStream nextPutAll: ', '.
		self emitJSExpression: arg on: aStream.
		aStream nextPutAll: ')'.
	].! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/6/2014 14:51'!
generateSignedBitShift: msgNode on: aStream indent: level
	"Generate the JS code for signedBitShift: onto the given stream."

	| arg rcvr |
	arg _ msgNode args first.
	rcvr _ msgNode receiver.
	arg isConstant ifTrue: [
		"bit shift amount is a constant"
		self emitJSExpression: rcvr on: aStream.
		arg value < 0 ifTrue: [
			arg value < -31 ifTrue: [self error: 'cannot shift by more than 31']. 
			aStream nextPutAll: ' >> ', arg value negated printString.
		] ifFalse: [
			arg value > 31 ifTrue: [self error: 'cannot shift by more than 31']. 
			aStream nextPutAll: ' << ', arg value printString.
		].
	] ifFalse: [
		self error: 'non-constant signed shift not implemented yet'
	].! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:45'!
generateSignedIntFromLong: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	aStream nextPutAll: '((sqInt) '.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:46'!
generateSignedIntFromShort: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	aStream nextPutAll: '((short)'.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:46'!
generateSignedIntToLong: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	aStream nextPutAll: '((usqInt) '.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:46'!
generateSignedIntToShort: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
self halt.
	aStream nextPutAll: '((usqInt) (short)'.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPut: $)

! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:46'!
generateSmalltalkMetaError: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	aStream nextPutAll: 'throw Error("'; nextPutAll: msgNode selector; nextPutAll: '")'! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:47'!
generateTimes: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' * '.
	self emitJSExpression: msgNode args first on: aStream.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/4/2014 14:45'!
generateToByDo: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	"N.B. MessageNode>>asTranslatorNodeIn: adds the limit var as a hidden fourth argument."
	| blockExpr iterationVar limitExpr mayHaveSideEffects limitVar step negative |
	blockExpr _ msgNode args third.
	blockExpr args size = 1 ifFalse:
		[self error: 'wrong number of block arguments'].
	iterationVar _ blockExpr args first.
	limitExpr _ msgNode args first.
	aStream nextPutAll: 'for (', iterationVar, ' = '.
	self emitJSExpression: msgNode receiver on: aStream.
	mayHaveSideEffects _ msgNode args size = 4. "See TMethod>>prepareMethodIn:"
	mayHaveSideEffects ifTrue:
		[limitVar _ msgNode args last.
		 aStream nextPutAll: ', ', limitVar name, ' = '.
		 self emitJSExpression: limitExpr on: aStream.
		 limitExpr _ limitVar].
	aStream nextPutAll: '; ', iterationVar.
	negative _ ((step _ msgNode args at: 2) isConstant and: [step value < 0])
				or: [step isSend and: [step selector == #negated
					and: [step receiver isConstant and: [step receiver value >= 0]]]].
	aStream nextPutAll: (negative ifTrue: [' >= '] ifFalse: [' <= ']).
	self emitJSExpression: limitExpr on: aStream.
	(step isConstant and: step value = 1)
		ifTrue: [aStream nextPutAll: '; ', iterationVar, '++']
		ifFalse: [aStream nextPutAll: '; ', iterationVar, ' += '.
			self emitJSExpression: step on: aStream].
	aStream nextPutAll: ') {'; cr.
	blockExpr emitJSCodeOn: aStream level: level + 1 generator: self.
	aStream tab: level.
	aStream nextPut: $}! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:48'!
generateToDo: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."

	| iterationVar |
	(msgNode args last args size = 1) ifFalse: [
		self error: 'wrong number of block arguments'.
	].
	iterationVar _ msgNode args last args first.
	aStream nextPutAll: 'for (', iterationVar, ' = '.
	self emitJSExpression: msgNode receiver on: aStream.
	aStream nextPutAll: '; ', iterationVar, ' <= '.
	self emitJSExpression: msgNode args first on: aStream.
	aStream nextPutAll: '; ', iterationVar, '++) {'; cr.
	msgNode args last emitJSCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:48'!
generateTouch: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream - which is to say absolutely nothing"
! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:50'!
generateWhileFalse: msgNode on: aStream indent: level
	"Generate JS code for a loop in one of the following formats, as appropriate:
		while(!!(cond)) { stmtList }
		do {stmtList} while(!!(cond))
		while(true) {stmtListA; if (cond) break; stmtListB}"

	msgNode receiver statements size <= 1
		ifTrue: [^self generateWhileFalseLoop: msgNode on: aStream indent: level].
	msgNode args first isNilStmtListNode
		ifTrue: [^self generateDoWhileFalse: msgNode on: aStream indent: level].
	^self generateWhileForeverBreakTrueLoop: msgNode on: aStream indent: level! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'acg 12/22/1999 01:41'!
generateWhileFalseLoop: msgNode on: aStream indent: level
	"Generate while(!!(cond)) {stmtList}."

	aStream nextPutAll: 'while (!!('.
	self emitJSTestBlock: msgNode receiver on: aStream.
	aStream nextPutAll: ')) {'; cr.
	msgNode args first isNilStmtListNode ifFalse:
		[msgNode args first emitJSCodeOn: aStream level: level + 1 generator: self].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:50'!
generateWhileForeverBreakFalseLoop: msgNode on: aStream indent: level
	"Generate while(true) {stmtListA; if(!!(cond)) break; stmtListB}."

	| stmts testStmt |
	stmts _ msgNode receiver statements asOrderedCollection.
	testStmt _ stmts removeLast.
	msgNode receiver setStatements: stmts.
	level - 1 timesRepeat: [ aStream tab ].
	aStream nextPutAll: 'while (true) {'; cr.
	msgNode receiver emitJSCodeOn: aStream level: level + 1 generator: self.
	(level + 1) timesRepeat: [ aStream tab ].
	aStream nextPutAll: 'if (!!('.
	testStmt asExpression emitJSCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: ')) break;'; cr.
	msgNode args first emitJSCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:49'!
generateWhileForeverBreakTrueLoop: msgNode on: aStream indent: level
	"Generate while(true) {stmtListA; if(cond) break; stmtListB}."

	| stmts testStmt |
	stmts _ msgNode receiver statements asOrderedCollection.
	testStmt _ stmts removeLast.
	msgNode receiver setStatements: stmts.
	level - 1 timesRepeat: [ aStream tab ].
	aStream nextPutAll: 'while (true) {'; cr.
	msgNode receiver emitJSCodeOn: aStream level: level + 1 generator: self.
	(level + 1) timesRepeat: [ aStream tab ].
	aStream nextPutAll: 'if ('.
	testStmt asExpression emitJSCodeOn: aStream level: 0 generator: self.
	aStream nextPutAll: ') break;'; cr.
	msgNode args first emitJSCodeOn: aStream level: level + 1 generator: self.
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'bf 10/1/2014 14:50'!
generateWhileTrue: msgNode on: aStream indent: level
	"Generate C code for a loop in one of the following formats, as appropriate:
		while(cond) { stmtList }
		do {stmtList} while(cond)
		while(true) {stmtListA; if (!!(cond)) break; stmtListB}"

	msgNode receiver statements size <= 1
		ifTrue: [^self generateWhileTrueLoop: msgNode on: aStream indent: level].
	msgNode args first isNilStmtListNode
		ifTrue: [^self generateDoWhileTrue: msgNode on: aStream indent: level].
	^self generateWhileForeverBreakFalseLoop: msgNode on: aStream indent: level! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'acg 12/22/1999 01:38'!
generateWhileTrueLoop: msgNode on: aStream indent: level
	"Generate while(cond) {stmtList}."

	aStream nextPutAll: 'while ('.
	self emitJSTestBlock: msgNode receiver on: aStream.
	aStream nextPutAll: ') {'; cr.
	msgNode args first isNilStmtListNode ifFalse:
		[msgNode args first emitJSCodeOn: aStream level: level + 1 generator: self].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!JSCodeGenerator methodsFor: 'JS translation' stamp: 'jpb 5/27/2020 21:57:28'!
initializeTranslationDictionary 
	"Initialize the dictionary mapping message names to actions for JS code generation."

	| pairs |
	translationDict _ Dictionary new: 200.
	pairs _ #(
	#&				#generateAnd:on:indent:
	#|				#generateOr:on:indent:
	#and:			#generateSequentialAnd:on:indent:
	#or:			#generateSequentialOr:on:indent:
	#not			#generateNot:on:indent:

	#+				#generatePlus:on:indent:
	#-				#generateMinus:on:indent:
	#negated		#generateNegated:on:indent:
	#abs			#generateMath:on:indent:
	#sqrt			#generateMath:on:indent:
	#sin			#generateMath:on:indent:
	#cos			#generateMath:on:indent:
	#tan			#generateMath:on:indent:
	#atan			#generateMath:on:indent:
	#exp			#generateMath:on:indent:
	#log			#generateMath:on:indent:
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
	#cPreprocessorDirective:	#generateInlineCPreprocessorDirective:on:indent:

	#coerce:to:				#generateCCoercion:on:indent:
	#coerceSimple:to:			#generateCCoercion:on:indent:
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

	#shouldNotImplement				#generateSmalltalkMetaError:on:indent:
	#shouldBeImplemented				#generateSmalltalkMetaError:on:indent:

	"optimized interpreterProxy calls"
	#firstIndexableField:				#generateFirstIndexableField:on:indent:
	#slotSizeOf:						#generateSlotSizeOf:on:indent:
	#stSizeOf:							#generateSlotSizeOf:on:indent:
	#byteSizeOfBytes:					#generateByteSizeOf:on:indent:
	#byteSizeOf:						#generateByteSizeOf:on:indent:
	#fetchClassOf:						#generateFetchClassOf:on:indent:
	#superclassOf:						#generateSuperclassOf:on:indent:
	#instanceSizeOf:					#generateInstanceSizeOf:on:indent:
	#is:KindOf: 							#generateIsKindOf:on:indent:
	#isFloatObject:						#generateIsFloatObject:on:indent:
	#cDigitCopyFrom:to:len:				#generateCDigitCopy:on:indent:
	#sizeOfSTArrayFromCPrimitive:		#generateSizeOfSTArrayFromCPrimitive:on:indent:
	#asciiValue							#generateIdentityUnary:on:indent:
	#primitiveFail						#generateInterpreterProxyCall:on:indent:
	#intAtPointer:						#generateIntAtPointer:on:indent:
	#byteAtPointer:						#generateByteAtPointer:on:indent:
	#oopForPointer:					#generateOopForPointer:on:indent:
	#long32At:							#generateLong32At:on:indent:
	#srcLongAt:						#generateSrcLongAt:on:indent:
	#dstLongAt:						#generateDstLongAt:on:indent:
	#dstLongAt:put:					#generateDstLongAtPut:on:indent:
	).

	1 to: pairs size by: 2 do: [:i |
		translationDict at: (pairs at: i) put: (pairs at: i + 1)].

	pairs _ #(
	#ifTrue:				#generateIfTrueAsArgument:on:indent:	
	#ifFalse:			#generateIfFalseAsArgument:on:indent:
	#ifTrue:ifFalse:		#generateIfTrueIfFalseAsArgument:on:indent:
	#ifFalse:ifTrue:		#generateIfFalseIfTrueAsArgument:on:indent:
	).

	asArgumentTranslationDict _ Dictionary new: 8.
	1 to: pairs size by: 2 do: [:i |
		asArgumentTranslationDict at: (pairs at: i) put: (pairs at: i + 1)].

	cCodeTranslationDict _ Dictionary new: 8.
	pairs _ #(
		'fprintf(stderr, "\n%s: %s", moduleName, s)'					'console.log(moduleName + ": " + s)'
		'interpreterProxy->majorVersion() == VM_PROXY_MAJOR'	'interpreterProxy.majorVersion() == VM_PROXY_MAJOR'
		'interpreterProxy->minorVersion() >= VM_PROXY_MINOR'	'interpreterProxy.minorVersion() >= VM_PROXY_MINOR'
		'rand()'														'Math.random()'
		'*src++'													'src[_src++]' 	
		'*dst++ = max'												'dst[_dst++] = max'
		'src++'		 												'_src++'
		'*dst++ = *src; src += 2'									'dst[_dst++] = src[_src]; _src += 2'
		'tX'															'tX'
		'tY'															'tY'
		'((sqInt (*)(sqInt, sqInt, sqInt))copyBitsFn)(x0, x1, yValue)'	'copyBitsFn(x0, x1, yValue)'
		'((sqInt (*)(sqInt))loadBBFn)(bbObj)'							'loadBBFn(bbObj)'
	).
	1 to: pairs size by: 2 do: [:i |
		cCodeTranslationDict at: (pairs at: i) put: (pairs at: i + 1)].
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/6/2014 01:43'!
generateByteAtPointer: msgNode on: aStream indent: level
	msgNode args first asString = 'sourcePtr + charIndex - 1'
		ifTrue: [^aStream nextPutAll: 'sourcePtr[charIndex - 1]'].
	self halt
	! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/5/2014 18:07'!
generateByteSizeOf: msgNode on: aStream indent: level
	aStream nextPutAll: 'BYTESIZEOF('.
	msgNode args first emitJSCodeOn: aStream level: level generator: self.
	aStream nextPutAll: ')'.
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/4/2014 14:55'!
generateCDigitCopy: msgNode on: aStream indent: level
	"LargeIntegerPlugin>>cDigitReplace:from:to:with:startingAt: uses pointer arithmetic. Replace it here"
	msgNode args first selector = #+ ifFalse: [
		^msgNode emitJSCodeAsFunctionCallOn: aStream level: level generator: self].
	msgNode asString = 'self cDigitCopyFrom: pFrom + repStart to: pTo + start len: stop - start + 1'
		ifFalse: [self halt: 'not handled: ', msgNode asString].
	aStream nextPutAll: 'function() {
		// inlining ', msgNode asString, '
		var len = stop - start + 1;
		for (var i = 0; i < len; i++) {
			pTo[i + start] = pFrom[i + repStart];
		}
		return 0;
	}();
'! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/6/2014 14:36'!
generateDstLongAt: msgNode on: aStream indent: level
	aStream nextPutAll: 'destBits['.
	msgNode args first emitJSCodeAsExpressionOn: aStream level: level generator: self.
	aStream nextPutAll: ' >>> 2]'.
	
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/6/2014 14:36'!
generateDstLongAtPut: msgNode on: aStream indent: level
	aStream nextPutAll: 'destBits['.
	msgNode args first emitJSCodeAsExpressionOn: aStream level: level generator: self.
	aStream nextPutAll: ' >>> 2] = '.
	msgNode args second emitJSCodeOn: aStream level: level generator: self.
	
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/5/2014 16:46'!
generateFetchClassOf: msgNode on: aStream indent: level
	aStream nextPutAll: 'CLASSOF('.
	msgNode args first emitJSCodeOn: aStream level: level generator: self.
	aStream nextPut: $).
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'jpb 5/21/2020 11:37:27'!
generateFirstIndexableField: msgNode on: aStream indent: level
	| parent cType accessor |
	self flag: #fixme.
	
	self oneBasedArrays: false.
	"HACK: detect cType from parent node"
	parent _ thisContext sender sender sender.
	
	cType _ parent method == (SlangTAssignmentNode>>#emitJSCodeOn:level:generator:) 
			ifTrue: [self typeOfVariable: parent receiver variable name] ifFalse: [
		parent method == (SlangTSendNode>>#emitJSCodeAsFunctionCallOn:level:generator:)
			ifTrue: [self typeOfArgument: (parent receiver args indexOf: msgNode) in: parent receiver selector] ifFalse: [
		msgNode asString = 'interpreterProxy firstIndexableField: mapOop'
			ifTrue: ['unsigned int*'] ifFalse: [
		msgNode asString = 'interpreterProxy firstIndexableField: blockOop'
			ifTrue: ['int*'] ifFalse: [
		parent method == (SlangTReturnNode>>#emitJSCodeOn:level:generator:)
			ifTrue: [currentMethod returnType] ifFalse: [
		self halt]]]]].

	cType ifNotNil: [
		cType _ cType copyReplaceAll: ' *' with: '* '.
		accessor _ (cType beginsWith: 'unsigned char*') ifTrue: ['.bytes']
			ifFalse: [(cType beginsWith: 'unsigned int*') ifTrue: ['.words']
			ifFalse: [(cType beginsWith: 'int*') ifTrue: ['.wordsAsInt32Array()']
			ifFalse: [(cType beginsWith: 'char*') ifTrue: ['.bytes']
			ifFalse: [(cType beginsWith: 'float*') ifTrue: ['.wordsAsFloat32Array()']
			ifFalse: [self halt: 'need to handle ', cType]]]]].
		accessor ifNotNil: [ "FIXME: msgNode args first emitJSCodeOn: aStream level: level generator: self.
			^aStream nextPutAll: accessor"]].
	
	"generic code below, not needed ever hopefully"
	aStream nextPutAll: 'interpreterProxy.'.
	
	^ nil "FIXME: msgNode emitJSCodeAsFunctionCallOn: aStream level: level generator: self"! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/3/2014 17:25'!
generateIdentityUnary: msgNode on: aStream indent: level
	"ignore this send, just use its value"
	msgNode receiver emitJSCodeOn: aStream level: level generator: self.
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/5/2014 16:44'!
generateInstanceSizeOf: msgNode on: aStream indent: level
	msgNode args first emitJSCodeOn: aStream level: level generator: self.
	aStream nextPutAll: '.classInstSize()'.
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'jpb 5/21/2020 11:18:45'!
generateIntAtPointer: msgNode on: aStream indent: level
	msgNode args first asString = 'self coerce: argPtr + i to: ''char*'''
		ifTrue: [^aStream nextPutAll: 'argPtr[i]'].
	self halt
	! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/4/2014 13:11'!
generateInterpreterProxyCall: msgNode on: aStream indent: level
	aStream nextPutAll: 'interpreterProxy.'.
	^ msgNode emitJSCodeAsFunctionCallOn: aStream level: level generator: self! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/5/2014 21:48'!
generateIsFloatObject: msgNode on: aStream indent: level
	msgNode args first emitJSCodeOn: aStream level: level generator: self.
	aStream nextPutAll: '.isFloat'.
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 11/12/2014 16:11'!
generateLoadPointInt: msgNode on: aStream indent: level
	aStream nextPutAll: '('.
	self emitJSExpression: msgNode args second on: aStream. 
	aStream nextPutAll: '['.
	self emitJSExpression: msgNode args first on: aStream. 
	aStream nextPutAll: ']|0)'.
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'jpb 5/28/2020 17:50:38'!
generateLoadPointShort: msgNode on: aStream indent: level
	(msgNode args second is: #Variable) ifFalse: [self halt].
	msgNode args second name = 'points' ifFalse: [self halt].
	
	aStream nextPutAll: '(points.int16Array || (points.int16Array = new Int16Array(points.buffer, points.byteOffset)))['.
	 msgNode args first emitJSCodeAsExpressionOn: aStream level: 0 generator: self.
	aStream nextPutAll: ']'.
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/6/2014 14:42'!
generateLong32At: msgNode on: aStream indent: level
	| expr index |
	expr _ msgNode args first.
	(expr isSend and: [expr selector = #+]) ifFalse: [self halt].
	expr receiver emitJSCodeOn: aStream level: level generator: self.
	index _ expr args first.
	aStream nextPut: $[.
	index isTimesFour
		ifTrue: [index receiver emitJSCodeOn: aStream level: level generator: self]
		ifFalse: [
			index emitJSCodeAsExpressionOn: aStream level: level generator: self.
			aStream nextPutAll: ' >>> 2'].
	aStream nextPut: $].
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'jpb 5/21/2020 11:19:38'!
generateMakeUnsignedFrom: msgNode on: aStream indent: level
	"Generate the JS code for this message onto the given stream."
	| expr type coerce |	
	msgNode args size = 1 ifFalse: [self halt].
	expr _ msgNode args first.
	(expr isSend and: [expr selector = #at:])
		ifFalse: [^self emitJSExpression: expr on: aStream].
	coerce _ expr receiver.
	(coerce isSend and: [coerce selector = #coerce:to:])
		ifFalse: [^self emitJSExpression: expr on: aStream].
	type _ (coerce args second value) copyWithout: $ .
	type = 'int*' ifFalse: [self halt].
	self emitJSExpression: coerce args first on: aStream.
	aStream nextPut: $[.
		self flag: #fixme.
	"expr args first emitJSCodeAsExpressionOn: aStream level: 0 generator: self."
	aStream nextPut: $].
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/6/2014 01:59'!
generateOopForPointer: msgNode on: aStream indent: level
	| arg |
	arg _ msgNode args first asString.
	arg = 'interpreterProxy firstIndexableField: destBits'
		ifTrue: [^aStream nextPutAll: 'destBits.wordsOrBytes()'].
	arg = 'interpreterProxy firstIndexableField: sourceBits'
		ifTrue: [^aStream nextPutAll: 'sourceBits.wordsOrBytes()'].
	arg =  'interpreterProxy firstIndexableField: halftoneBits'
		ifTrue: [^aStream nextPutAll: 'halftoneBits.wordsOrBytes()'].
	arg =  'interpreterProxy firstIndexableField: sourceMapOop'
		ifTrue: [^aStream nextPutAll: 'sourceMapOop.wordsOrBytes()'].
	self halt
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/4/2014 13:07'!
generateSizeOfSTArrayFromCPrimitive: msgNode on: aStream indent: level
	| cType sizer |
	cType _ self typeOfVariable: msgNode args first name.
	cType ifNotNil: [
		sizer _ (cType includesSubString: 'char *') ifTrue: ['.length'] ifFalse: [
			(cType beginsWith: 'int *') ifTrue: ['.length'] 
			ifFalse: [self halt: 'need to handle ', cType]]].
		sizer ifNotNil: [msgNode args first emitJSCodeOn: aStream level: level generator: self.
			^aStream nextPutAll: sizer].
	self halt.
	"generic code below, not needed ever hopefully"
	aStream nextPutAll: 'interpreterProxy.'.
	^ msgNode emitJSCodeAsFunctionCallOn: aStream level: level generator: self! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/6/2014 11:07'!
generateSlotSizeOf: msgNode on: aStream indent: level
	aStream nextPutAll: 'SIZEOF('.
	msgNode args first emitJSCodeOn: aStream level: level generator: self.
	aStream nextPut: $).
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/6/2014 14:36'!
generateSrcLongAt: msgNode on: aStream indent: level
	aStream nextPutAll: 'sourceBits['.
	msgNode args first emitJSCodeAsExpressionOn: aStream level: level generator: self.
	aStream nextPutAll: ' >>> 2]'.
	
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/5/2014 16:53'!
generateSuperclassOf: msgNode on: aStream indent: level
	msgNode args first emitJSCodeOn: aStream level: level generator: self.
	aStream nextPutAll: '.superclass()'.
! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/4/2014 12:39'!
isOneBasedArray: varName in: method
	^(method isOneBasedArray: varName)
		ifNil: [self oneBasedArrays]
		ifNotNil: [:oneBased | self oneBasedArrays: oneBased]! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/4/2014 12:17'!
oneBasedArrays
	oneBasedArrays ifNil: [oneBasedArrays _ false].
	^oneBasedArrays! !

!JSCodeGenerator methodsFor: 'JS hacks' stamp: 'bf 10/4/2014 12:27'!
oneBasedArrays: aBoolean
	oneBasedArrays ifNil: [^oneBasedArrays _ aBoolean].
	oneBasedArrays = aBoolean ifFalse: [
		self halt: 'mixed one-based and zero-based array access'].
	^aBoolean! !

!JSCodeGenerator class methodsFor: 'preferences' stamp: 'bf 10/14/2014 13:39'!
beActiveDuring: aBlock
	| wasActive |
	wasActive _ self isActive.
	self isActive: true.
	aBlock ensure: [self isActive: wasActive].! !

!JSCodeGenerator class methodsFor: 'preferences' stamp: 'bf 9/30/2014 14:43'!
isActive
	"should I be used instead of CCodeGenerator?"
	^IsActive == true! !

!JSCodeGenerator class methodsFor: 'preferences' stamp: 'bf 9/30/2014 14:45'!
isActive: aBoolean
	"should I be used instead of CCodeGenerator?"
	IsActive _ aBoolean! !

!JSCodeGenerator class methodsFor: 'class initialization' stamp: 'jm 8/19/1998 10:03'!
initialize
	"JSCodeGenerator initialize"

	UseRightShiftForDivide _ true.
		"If UseRightShiftForDivide is true, the translator will generate a right-shift when it encounters a division by a constant that is a small power of two. For example, 'x / 8' will generate '((int) x >> 3)'. The coercion to int is done to make it clear that the C compiler should generate a signed shift."
		"Note: The Kernighan and Ritchie 2nd Edition C manual, p. 49, leaves the semantics of right-shifting a negative number open to the discretion of the compiler implementor. However, it strongly suggests that most compilers should generate an arithmetic right shift (i.e., shifting in the sign bit), which is the same as dividing by a power of two. If your compiler does not generate or simulate an arithmetic shift, then make this class variable false and re-translate."
! !

!JSMethod methodsFor: 'accessing'!
args
	"The arguments of this method."

	^args! !

!JSMethod methodsFor: 'accessing' stamp: 'eem 3/3/2009 08:59'!
declarationAt: aVariableName
	^declarations at: aVariableName ifAbsent: [#sqInt, ' ', aVariableName]! !

!JSMethod methodsFor: 'accessing' stamp: 'eem 3/3/2009 08:42'!
declarationAt: aVariableName  "<String>" put: aDeclaration "<String>" "^aDeclaration"
	^declarations at: aVariableName put: aDeclaration! !

!JSMethod methodsFor: 'accessing'!
declarations
	"The type declaration dictionary of this method."

	^declarations! !

!JSMethod methodsFor: 'accessing' stamp: 'ar 2/3/2001 17:29'!
definingClass
	^definingClass! !

!JSMethod methodsFor: 'accessing' stamp: 'ar 2/3/2001 17:29'!
definingClass: aClass
	definingClass _ aClass.! !

!JSMethod methodsFor: 'accessing' stamp: 'jm 11/24/1998 09:03'!
export

	^ export
! !

!JSMethod methodsFor: 'accessing'!
globalStructureBuildMethodHasFoo: number
	globalStructureBuildMethodHasFoo _ number! !

!JSMethod methodsFor: 'accessing'!
isComplete
	"A method is 'complete' if it does not contain any more inline-able calls."

	^complete! !

!JSMethod methodsFor: 'accessing' stamp: 'dtl 8/21/2011 17:43'!
isStaticIn: aCodeGen
	"If static has been explicitly set, honor that setting. Otherwise defer
	to the code generator for a default setting."
	^static ifNil: [aCodeGen declareMethodsStatic]! !

!JSMethod methodsFor: 'accessing' stamp: 'ar 5/9/2000 12:13'!
labels

	^labels! !

!JSMethod methodsFor: 'accessing' stamp: 'ar 5/9/2000 12:13'!
locals
	"The local variables of this method."

	^locals! !

!JSMethod methodsFor: 'accessing'!
parseTree
	"The parse tree of this method."

	^parseTree! !

!JSMethod methodsFor: 'accessing'!
parseTree: aNode
	"Set the parse tree of this method."

	parseTree _ aNode.! !

!JSMethod methodsFor: 'accessing' stamp: 'jm 2/12/98 11:56'!
primitive
	"The primitive number of this method; zero if not a primitive."

	^ primitive
! !

!JSMethod methodsFor: 'accessing'!
referencesGlobalStructIncrementBy: value
	globalStructureBuildMethodHasFoo _ globalStructureBuildMethodHasFoo + value.! !

!JSMethod methodsFor: 'accessing'!
referencesGlobalStructMakeZero
	globalStructureBuildMethodHasFoo _ 0! !

!JSMethod methodsFor: 'accessing'!
returnType
	"The type of the values returned by this method. This string will be used in the C declaration of this function."

	^returnType! !

!JSMethod methodsFor: 'accessing' stamp: 'eem 8/1/2008 10:34'!
returnType: aString
	"Set the type of the values returned by this method. This string will be used in the C declaration of this function."

	returnType _ aString! !

!JSMethod methodsFor: 'accessing'!
selector
	"The Smalltalk selector of this method."

	^selector! !

!JSMethod methodsFor: 'accessing'!
selector: newSelector

	selector _ newSelector.! !

!JSMethod methodsFor: 'accessing' stamp: 'dtl 12/21/2008 14:55'!
selectorForCodeGeneration
	"Subclasses may allow a directive to override the selector specification."

	^ selector! !

!JSMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:18'!
sharedCase
	^sharedCase! !

!JSMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:41'!
sharedCase: aNumber
	sharedCase _ aNumber.! !

!JSMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:18'!
sharedLabel
	^sharedLabel! !

!JSMethod methodsFor: 'accessing' stamp: 'ar 7/6/2003 21:40'!
sharedLabel: aString
	sharedLabel _ aString! !

!JSMethod methodsFor: 'accessing'!
statements

	parseTree isStmtList
		ifFalse: [ self error: 'expected method parse tree to be a TStmtListNode' ].
	((parseTree args = nil) or: [parseTree args isEmpty])
		ifFalse: [ self error: 'expected method parse tree to have no args' ].

	^parseTree statements! !

!JSMethod methodsFor: 'accessing' stamp: 'eem 2/10/2009 13:53'!
static: aBoolean
	static _ aBoolean! !

!JSMethod methodsFor: 'inlining support'!
addVarsDeclarationsAndLabelsOf: methodToBeInlined
	"Prepare to inline the body of the given method into the receiver by making the args and locals of the argument to the receiver be locals of the receiver. Record any type declarations for these variables. Record labels. Assumes that the variables have already be renamed to avoid name clashes."

	methodToBeInlined args, methodToBeInlined locals do: [ :v |
		(locals includes: v) ifFalse: [ locals addLast: v ].
	].
	methodToBeInlined declarations associationsDo: [ :assoc |
		declarations add: assoc.
	].
	methodToBeInlined labels do: [ :label |
		labels add: label.
	].! !

!JSMethod methodsFor: 'inlining support'!
computePossibleSideEffectsIn: aCodeGen
	"Answer true if this method may have side effects. It has side effects if it assigns to a global variable. It may have side effects if it calls a non-built-in method."

	parseTree nodesDo: [ :node |
		node isSend ifTrue: [
			node isBuiltinOperator ifFalse: [ ^true ].
		].
	].
	^ false! !

!JSMethod methodsFor: 'inlining support'!
endsWithReturn
	"Answer true if the last statement of this method is a return."

	^ parseTree statements last isReturn! !

!JSMethod methodsFor: 'inlining support' stamp: 'dtl 9/19/2010 13:20'!
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

!JSMethod methodsFor: 'inlining support' stamp: 'dtl 8/25/2011 22:37'!
hasDoNotGenerateStatement
	"True if method has a #doNotGenerate statement, equivalent to pragma <doNotGenerate>
	or if it has a #subclassResponsibility statement."
	parseTree statements
		detect: [:stmt | stmt isSend
					and: [stmt selector = #doNotGenerate
						or: [stmt selector = #subclassResponsibility]]]
		ifNone: [^ false].
	^ true! !

!JSMethod methodsFor: 'inlining support'!
maySubstituteGlobal: globalVar in: aCodeGen
	"Answer true if this method does or may have side effects on the given global variable."

	possibleSideEffectsCache = nil ifTrue: [
		"see if this calls any other method and record the result"
		possibleSideEffectsCache _ self computePossibleSideEffectsIn: aCodeGen.
	].
	possibleSideEffectsCache ifTrue: [ ^ false ].

	parseTree nodesDo: [ :node |
		node isAssignment ifTrue: [
			node variable name = globalVar ifTrue: [ ^ false ].
		].
	].

	"if we get here, receiver calls no other method
	 and does not itself assign to the given global variable"
	^ true! !

!JSMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:06'!
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

!JSMethod methodsFor: 'inlining support' stamp: 'jpb 5/26/2020 21:11:24'!
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

!JSMethod methodsFor: 'inlining support' stamp: 'jpb 5/28/2020 18:01:26'!
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

!JSMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:07'!
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

!JSMethod methodsFor: 'inlining support' stamp: 'jm 12/13/1998 10:07'!
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

!JSMethod methodsFor: 'inlining support'!
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

!JSMethod methodsFor: 'utilities'!
allCalls
	"Answer a collection of selectors for the messages sent by this method."

	^parseTree allCalls! !

!JSMethod methodsFor: 'utilities' stamp: 'ar 7/6/2003 21:40'!
copy
	"Make a deep copy of this JSMethod."

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

!JSMethod methodsFor: 'utilities' stamp: 'jpb 5/28/2020 17:51:38'!
freeVariableReferences
	"Answer a collection of variables referenced this method, excluding locals, arguments, and pseudovariables."

	| refs |
	refs _ Set new.
	parseTree nodesDo: [ :node |
		(node is: #Variable) ifTrue: [ refs add: node name asString ].
	].

	args do: [ :var | refs remove: var asString ifAbsent: [] ].
	locals do: [ :var | refs remove: var asString ifAbsent: [] ].
	
	#('self' 'nil' 'true' 'false' 'null') do: [ :var | refs remove: var ifAbsent: [] ].
	^ refs asSortedCollection! !

!JSMethod methodsFor: 'utilities' stamp: 'jpb 5/27/2020 21:16:58'!
hasNoCCode
	"Answer true if the receiver does not use inlined C or C declarations, which are not currently renamed properly by the the inliner."

	declarations isEmpty ifFalse: [ ^ false ].
	^ true! !

!JSMethod methodsFor: 'utilities'!
nodeCount
	"Answer the number of nodes in this method's parseTree (a rough measure of its size)."

	| cnt |
	cnt _ 0.
	parseTree nodesDo: [ :n | cnt _ cnt + 1 ].
	^cnt! !

!JSMethod methodsFor: 'utilities' stamp: 'jpb 5/28/2020 18:01:18'!
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

!JSMethod methodsFor: 'utilities'!
variablesAssignedTo
	"Answer a collection of variables assigned to by this method."

	| refs |
	refs _ Set new.
	parseTree nodesDo: [ :node |
		node isAssignment ifTrue: [ refs add: node variable name ].
	].
	^ refs! !

!JSMethod methodsFor: 'inlining' stamp: 'jpb 5/20/2020 23:59:55'!
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

!JSMethod methodsFor: 'inlining'!
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

!JSMethod methodsFor: 'inlining' stamp: 'jpb 5/21/2020 00:00:11'!
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

!JSMethod methodsFor: 'inlining' stamp: 'jpb 5/21/2020 11:39:14'!
inlineCaseStatementBranchesIn: aCodeGen localizingVars: varsList

	| stmt sel meth newStatements maxTemp usedVars exitLabel v |
	maxTemp _ 0.
	parseTree nodesDo: [ :n |
		n isCaseStmt ifTrue: [
			n cases do: [ :stmtNode |
				stmt _ stmtNode statements first.
				stmt isSend ifTrue: [
					sel _ stmt selector.
					meth _ aCodeGen methodNamed: sel.
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

!JSMethod methodsFor: 'inlining'!
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

!JSMethod methodsFor: 'inlining' stamp: 'dtl 6/3/2010 00:31'!
inlineFunctionCall: aSendNode in: aCodeGen
	"Answer the body of the called function, substituting the actual parameters for the formal argument variables in the method body."
	"Assume caller has established that:
		1. the method arguments are all substitutable nodes, and
		2. the method to be inlined contains no additional embedded returns."

	| sel meth substitutionDict |
	sel _ aSendNode selector.
	meth _ (aCodeGen methodNamed: sel) copy.
	meth renameVarsForInliningInto: self in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth.
	substitutionDict _ Dictionary new: 100.
	meth args with: aSendNode args do: [ :argName :exprNode |
		substitutionDict at: argName put: exprNode.
		locals remove: argName.
		declarations removeKey: argName ifAbsent: []].
	meth parseTree bindVariablesIn: substitutionDict.
	^ meth statements first expression! !

!JSMethod methodsFor: 'inlining' stamp: 'jpb 5/21/2020 11:33:23'!
inlineSend: aSendNode directReturn: directReturn exitVar: exitVar in: aCodeGen
	"Answer a collection of statments to replace the given send. directReturn indicates that the send is the expression of a return statement, so returns can be left in the body of the inlined method. If exitVar is nil, the value returned by the send is not used; thus, returns need not assign to the output variable."

	| sel meth exitLabel labelUsed inlineStmts |
	sel _ aSendNode selector.
	meth _ (aCodeGen methodNamed: sel) copy.
	meth renameVarsForInliningInto: self in: aCodeGen.
	meth renameLabelsForInliningInto: self.
	self addVarsDeclarationsAndLabelsOf: meth.
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

!JSMethod methodsFor: 'inlining'!
inlineableFunctionCall: aNode in: aCodeGen
	"Answer true if the given send node is a call to a 'functional' method--a method whose body is a single return statement of some expression and whose actual parameters can all be directly substituted."

	| m |
	aNode isSend ifFalse: [ ^false ].
	m _ aCodeGen methodNamed: aNode selector.  "nil if builtin or external function"
	((m ~= nil) and: [m isFunctional and: [aCodeGen mayInline: m selector]]) ifTrue: [
		aNode args do: [ :a | (self isSubstitutableNode: a intoMethod: m in: aCodeGen) ifFalse: [ ^false ]].
		^true
	] ifFalse: [
		^false
	].! !

!JSMethod methodsFor: 'inlining'!
inlineableSend: aNode in: aCodeGen
	"Answer true if the given send node is a call to a method that can be inlined."

	| m |
	aNode isSend ifFalse: [ ^false ].
	m _ aCodeGen methodNamed: aNode selector.  "nil if builtin or external function"
	^(m ~= nil) and: [m isComplete and: [aCodeGen mayInline: m selector]]! !

!JSMethod methodsFor: 'inlining'!
isFunctional
	"Answer true if the receiver is a functional method. That is, if it consists of a single return statement of an expression that contains no other returns."

	(parseTree statements size = 1 and:
	 [parseTree statements last isReturn]) ifFalse: [ ^false ].
	parseTree statements last expression nodesDo: [ :n | n isReturn ifTrue: [ ^false ]].
	^true! !

!JSMethod methodsFor: 'inlining' stamp: 'jpb 5/28/2020 17:51:50'!
isSubstitutableNode: aNode
	"Answer true if the given parameter node is either a constant, a local variable, or a formal parameter of the receiver. Such parameter nodes may be substituted directly into the body of the method during inlining. Note that global variables cannot be subsituted because the inlined method might depend on the exact ordering of side effects to the globals."

	aNode isConstant ifTrue: [ ^true ].
	^(aNode is: #Variable) and:
		[(locals includes: aNode name) or:
		[args includes: aNode name]]! !

!JSMethod methodsFor: 'inlining' stamp: 'jpb 5/28/2020 18:00:55'!
isSubstitutableNode: aNode intoMethod: targetMeth in: aCodeGen
	"Answer true if the given parameter node is either a constant, a local variable, or a formal parameter of the receiver. Such parameter nodes may be substituted directly into the body of the method during inlining. Note that global variables cannot be subsituted into methods with possible side effects (i.e., methods that may assign to global variables) because the inlined method might depend on having the value of the global variable captured when it is passed in as an argument."

	| var |
	aNode isConstant ifTrue: [ ^ true ].

	(aNode is: #Variable) ifTrue: [
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

!JSMethod methodsFor: 'inlining' stamp: 'nk 4/5/2005 20:37'!
statementsListsForInlining
	"Answer a collection of statement list nodes that are candidates for inlining. Currently, we cannot inline into the argument blocks of and: and or: messages."

	| stmtLists |
	stmtLists _ OrderedCollection new: 10.
	parseTree nodesDo: [ :node | 
		node isStmtList ifTrue: [ stmtLists add: node ].
	].
	parseTree nodesDo: [ :node | 
		node isSend ifTrue: [
			((node selector = #and:) or: [node selector = #or:]) ifTrue: [
				"Note: the PP 2.3 compiler produces two arg nodes for these selectors"
				stmtLists remove: node args first ifAbsent: [].
				stmtLists remove: node args last ifAbsent: [].
			].
			((node selector = #ifTrue:) or: [node selector = #ifFalse:]) ifTrue: [
				stmtLists remove: node receiver ifAbsent: [].
			].
			((node selector = #ifTrue:ifFalse:) or: [node selector = #ifFalse:ifTrue:]) ifTrue: [
				stmtLists remove: node receiver ifAbsent: [].
			].
			((node selector = #whileFalse:) or: [node selector = #whileTrue:]) ifTrue: [
				"Allow inlining if it is a [...] whileTrue/whileFalse.
				This is identified by having more than one statement in the 
				receiver block in which case the C code wouldn't work anyways"
				node receiver statements size = 1
					ifTrue:[stmtLists remove: node receiver ifAbsent: []].
			].
			(node selector = #to:do:) ifTrue: [
				stmtLists remove: node receiver ifAbsent: [].
				stmtLists remove: node args first ifAbsent: [].
			].
			(node selector = #to:by:do:) ifTrue: [
				stmtLists remove: node receiver ifAbsent: [].
				stmtLists remove: node args first ifAbsent: [].
				stmtLists remove: node args second ifAbsent: [].
			].
		].
		node isCaseStmt ifTrue: [
			"don't inline cases"
			node cases do: [: case | stmtLists remove: case ifAbsent: [] ].
		].
	].
	^stmtLists! !

!JSMethod methodsFor: 'inlining' stamp: 'jm 12/13/1998 10:07'!
tryToInlineMethodsIn: aCodeGen
	"Expand any (complete) inline methods called by this method. Set the complete bit when all inlining has been done. Return true if something was inlined."

	| stmtLists didSomething newStatements inlinedStmts sendsToInline |
	didSomething _ false.

	sendsToInline _ Dictionary new: 100.
	parseTree nodesDo: [ :n |
		(self inlineableFunctionCall: n in: aCodeGen) ifTrue: [
			sendsToInline at: n put: (self inlineFunctionCall: n in: aCodeGen).
		].
	].
	sendsToInline isEmpty ifFalse: [
		didSomething _ true.
		parseTree _ parseTree replaceNodesIn: sendsToInline.
	].

	didSomething ifTrue: [
		possibleSideEffectsCache _ nil.
		^didSomething
	].

	stmtLists _ self statementsListsForInlining.
	stmtLists do: [ :stmtList | 
		newStatements _ OrderedCollection new: 100.
		stmtList statements do: [ :stmt |
			inlinedStmts _ self inlineCodeOrNilForStatement: stmt in: aCodeGen.
			(inlinedStmts = nil) ifTrue: [
				newStatements addLast: stmt.
			] ifFalse: [
				didSomething _ true.
				newStatements addAllLast: inlinedStmts.
			].
		].
		stmtList setStatements: newStatements asArray.
	].

	didSomething ifTrue: [
		possibleSideEffectsCache _ nil.
		^didSomething
	].

	complete ifFalse: [
		self checkForCompleteness: stmtLists in: aCodeGen.
		complete ifTrue: [ didSomething _ true ].  "marking a method complete is progress"
	].
	^didSomething! !

!JSMethod methodsFor: 'inlining'!
unusedLabelForInliningInto: targetMethod

	| usedLabels |
	usedLabels _ labels asSet.
	usedLabels addAll: targetMethod labels.
	^self unusedNamePrefixedBy: 'l' avoiding: usedLabels! !

!JSMethod methodsFor: 'primitive compilation' stamp: 'bf 10/5/2014 20:41'!
argConversionExprFor: varName stackIndex: stackIndex 
	"Return the parse tree for an expression that fetches and converts the 
	primitive argument at the given stack offset."
	| exprList decl stmtList |
	oneBasedArrays ifNil: [oneBasedArrays _ Set new]. "only non-nil in a primitive method"
	exprList _ OrderedCollection new.
	(declarations includesKey: varName) ifTrue:[
		decl _ declarations at: varName.
		(decl includes: $*) ifTrue:["array"
			(decl includesSubString: 'char') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' stackBytes: ',stackIndex printString] ifFalse: [
			(decl beginsWith: 'unsigned int') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' stackWords: ',stackIndex printString] ifFalse: [
			(decl beginsWith: 'unsigned short') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' stackUint16Array: ',stackIndex printString] ifFalse: [
			(decl beginsWith: 'short int') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' stackInt16Array: ',stackIndex printString] ifFalse: [
			(decl beginsWith: 'int') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' stackInt32Array: ',stackIndex printString]
			ifFalse: [self halt]]]]].
			self beOneBasedArray: varName.
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

!JSMethod methodsFor: 'primitive compilation' stamp: 'bf 10/3/2014 14:09'!
checkSuccessExpr
	"Return the parse tree for an expression that aborts the primitive if the successFlag is not true."

	| expr |
	expr _ 'interpreterProxy failed ifTrue: [^ nil ]'.
	^ self statementsFor: expr varName: ''
! !

!JSMethod methodsFor: 'primitive compilation' stamp: 'jpb 5/21/2020 00:01:59'!
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

!JSMethod methodsFor: 'primitive compilation' stamp: 'ar 4/4/2006 21:15'!
fetchRcvrExpr
	"Return the parse tree for an expression that fetches the receiver from the stack."

	| expr |
	expr _ 'rcvr _ ', self vmNameString, ' stackValue: (', args size printString, ')'.
	^ self statementsFor: expr varName: ''
! !

!JSMethod methodsFor: 'primitive compilation' stamp: 'jpb 5/21/2020 00:02:22'!
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
								newStmts addLast: (SlangTSendNode new
									setSelector: #pop:thenPush:
									receiver: (SlangTVariableNode new setName: self vmNameString)
									arguments: {SlangTConstantNode new setValue: argCount + 1. stmt expression}).
								newStmts addLast: (SlangTReturnNode new
									setExpression: (SlangTVariableNode new setName: 'null'))]]
					ifFalse: [
						newStmts addLast: stmt]].
			node setStatements: newStmts asArray]].
! !

!JSMethod methodsFor: 'primitive compilation' stamp: 'bf 10/5/2014 20:42'!
instVarGetExprFor: varName offset: instIndex
	"Return the parse tree for an expression that fetches and converts the value of the instance variable at the given offset."

	| exprList decl stmtList |
	exprList _ OrderedCollection new.
	(declarations includesKey: varName) ifTrue: [
		decl _ declarations at: varName.
		(decl includes: $*) ifTrue: ["array"
			(decl includesSubString: 'char') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' fetchBytes: ', instIndex printString, ' ofObject: rcvr'] ifFalse: [
			(decl includesSubString: 'unsigned int') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' fetchWords: ', instIndex printString, ' ofObject: rcvr'] ifFalse: [
			(decl beginsWith: 'unsigned short') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' fetchUint16Array: ', instIndex printString, ' ofObject: rcvr'] ifFalse: [
			(decl beginsWith: 'short int') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' fetchInt16Array: ', instIndex printString, ' ofObject: rcvr'] ifFalse: [
			(decl beginsWith: 'int') ifTrue:[
				exprList add: varName , ' _ ', self vmNameString, ' fetchInt32Array: ', instIndex printString, ' ofObject: rcvr']
			ifFalse: [self halt]]]]].
			self beOneBasedArray: varName.
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

!JSMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:13'!
instVarPutExprFor: varName offset: instIndex
	"Return the parse tree for an expression that saves the value of the integer instance variable at the given offset."

	| expr |
	(declarations includesKey: varName) ifTrue: [
		self error: 'a primitive method can only modify integer instance variables'.
	].
	expr _ '', self vmNameString, ' storeInteger: ', instIndex printString, ' ofObject: rcvr withValue: ', varName.
	^ self statementsFor: expr varName: varName
! !

!JSMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:13'!
popArgsExpr: argCount
	"Return the parse tree for an expression that pops the given number of arguments from the stack."

	| expr |
	expr _ '', self vmNameString, ' pop: ', argCount printString.
	^ self statementsFor: expr varName: ''
! !

!JSMethod methodsFor: 'primitive compilation' stamp: 'ar 2/3/2001 17:33'!
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

!JSMethod methodsFor: 'primitive compilation' stamp: 'bf 10/14/2014 15:42'!
preparePrimitivePrologueShared: sharedInstVars assigned: assignedInstVars
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
selector == #setInterpreter: ifTrue:[self halt].
	aClass _ definingClass.
	prolog _ OrderedCollection new.
	postlog _ OrderedCollection new.
	instVarsUsed _ self freeVariableReferences asSet union: sharedInstVars.
	varsAssignedTo _ self variablesAssignedTo asSet union: assignedInstVars.
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
			"locals add: varName. -- since we do not inline, we cannot declare these local since they migth be used by inlined methods"
			prolog addAll: (self instVarGetExprFor: varName offset: varIndex - 1).
			(varsAssignedTo includes: varName) ifTrue: [
				postlog addAll: (self instVarPutExprFor: varName offset: varIndex - 1)]]].
	prolog addAll: self checkSuccessExpr.

	locals addAllFirst: args.
	locals addFirst: 'rcvr'.
	args _ args class new.
	locals asSet size = locals size
		ifFalse: [self error: 'local name conflicts with instance variable name'].
	endsWithReturn _ self endsWithReturn.
	self fixUpReturns: primArgCount postlog: postlog.

	endsWithReturn
		ifTrue: [parseTree setStatements: prolog, parseTree statements]
		ifFalse: [
			postlog addAll: (self popArgsExpr: primArgCount).
			parseTree setStatements: prolog, parseTree statements, postlog].
! !

!JSMethod methodsFor: 'primitive compilation' stamp: 'jpb 5/21/2020 11:34:47'!
replaceSizeMessages
	"Replace sends of the message 'size' with calls to sizeOfSTArrayFromCPrimitive."

	parseTree nodesDo: [:n |
		(n isSend and: [n selector = #size]) ifTrue: [
			n
				setSelector: #sizeOfSTArrayFromCPrimitive:
				receiver: (SlangTVariableNode new setName: self vmNameString)
				arguments: (Array with: n receiver)]].
! !

!JSMethod methodsFor: 'primitive compilation' stamp: 'TPR 2/29/2000 18:47'!
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

!JSMethod methodsFor: 'primitive compilation' stamp: 'bf 10/3/2014 13:35'!
vmNameString
	"return the string to use as the vm name in code generated for this method"
	^'interpreterProxy'! !

!JSMethod methodsFor: 'transformations' stamp: 'jpb 5/21/2020 11:39:29'!
asInlineNode
	^SlangTInlineNode new method: self! !

!JSMethod methodsFor: 'transformations'!
bindClassVariablesIn: constantDictionary
	"Class variables are used as constants. This method replaces all references to class variables in the body of this method with the corresponding constant looked up in the class pool dictionary of the source class. The source class class variables should be initialized before this method is called."

	parseTree _ parseTree bindVariablesIn: constantDictionary.! !

!JSMethod methodsFor: 'transformations' stamp: 'ar 7/6/2003 20:35'!
bindVariableUsesIn: aDictionary
	parseTree _ parseTree bindVariableUsesIn: aDictionary.! !

!JSMethod methodsFor: 'transformations' stamp: 'jpb 5/21/2020 00:01:36'!
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

!JSMethod methodsFor: 'transformations' stamp: 'jpb 5/21/2020 00:02:52'!
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

!JSMethod methodsFor: 'transformations' stamp: 'eem 9/20/2008 18:26'!
extractExpandCaseDirective
	"Scan the top-level statements for an inlining directive of the form:
		self expandCases
	 and remove the directive from the method body. Answer whether
	 there was such a directive."

	^self
		extractDirective: #expandCases
		valueBlock: [:sendNode| true]
		default: false! !

!JSMethod methodsFor: 'transformations' stamp: 'dtl 9/19/2010 12:19'!
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

!JSMethod methodsFor: 'transformations' stamp: 'eem 11/18/2008 12:44'!
extractLabelDirective
	"Scan the top-level statements for an inlining directive of the form:

		self asmLabel: <boolean>

	 and remove the directive from the method body. Answer the
	 argument of the directive or true if there is no export directive."

	^self
		extractDirective: #asmLabel:
		valueBlock: [:sendNode| sendNode args first value ~= false and: [mustAsmLabel _ true. true]]
		default: true! !

!JSMethod methodsFor: 'transformations' stamp: 'ar 7/7/2003 00:56'!
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

!JSMethod methodsFor: 'transformations' stamp: 'dtl 7/4/2012 10:58'!
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

!JSMethod methodsFor: 'transformations' stamp: 'dtl 1/22/2012 19:38'!
mapReceiversIn: aDictionary
	parseTree mapReceiversIn: aDictionary.! !

!JSMethod methodsFor: 'transformations' stamp: 'dtl 1/15/2014 21:55'!
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
								 limitExpr _ node args first.
								 (limitExpr anySatisfy:
										[:subNode|
										subNode isSend
										and: [(aCodeGen isBuiltinSelector: subNode selector) not
										and: [(subNode isStructSendIn: aCodeGen) not]]])
									ifTrue: [ | limitVar |
										limitVar _ node args last name.
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

!JSMethod methodsFor: 'transformations' stamp: 'jpb 5/28/2020 19:55:58'!
recordDeclarations
	"Record C type declarations of the forms

		self returnType: 'float'.
		self var: #foo declareC: 'float foo'
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

!JSMethod methodsFor: 'transformations' stamp: 'ikp 9/26/97 14:50'!
removeAssertions
	parseTree removeAssertions! !

!JSMethod methodsFor: 'transformations' stamp: 'jpb 5/28/2020 17:52:10'!
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

!JSMethod methodsFor: 'transformations' stamp: 'dtl 8/20/2011 14:28'!
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

!JSMethod methodsFor: 'transformations' stamp: 'ar 7/6/2003 21:31'!
replaceNodesIn: map
	parseTree _ parseTree replaceNodesIn: map.! !

!JSMethod methodsFor: 'JS code generation' stamp: 'bf 10/3/2014 17:33'!
beOneBasedArray: varName
	oneBasedArrays add: varName.
! !

!JSMethod methodsFor: 'JS code generation' stamp: 'ikp 6/9/2004 16:15'!
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
	parseTree emitJSCodeOn: aStream level: level+1 generator: aCodeGen.
	aStream tab: level; nextPutAll: '}'; cr.! !

!JSMethod methodsFor: 'JS code generation' stamp: 'bf 11/12/2014 00:38'!
emitJSCodeOn: aStream generator: aCodeGen
	"Emit JS code for this method onto the given stream. All calls to inlined methods should already have been expanded."
	aCodeGen currentMethod: self.
	aCodeGen pushScope: declarations while: [
		self emitJSCommentOn: aStream.	"place method comment before function"
		self emitJSHeaderOn: aStream generator: aCodeGen.
		(self emitJSSpecialOn:  aStream level: 1 generator: aCodeGen)
			ifFalse: [parseTree emitJSCodeOn: aStream level: 1 generator: aCodeGen].
		aStream nextPutAll: '}'; cr]! !

!JSMethod methodsFor: 'JS code generation' stamp: 'hg 8/14/2000 16:09'!
emitJSCommentOn: aStream
	"Emit the transferred Smalltalk comments as C comments."

	comment ifNotNil: [
		aStream cr;cr.
		1 to: comment size do: [:index | 
			aStream 
				nextPutAll: '/*'; tab;
				nextPutAll: (comment at: index);
				nextPutAll: ' */';
				cr]]! !

!JSMethod methodsFor: 'JS code generation' stamp: 'bf 10/1/2014 13:34'!
emitJSFunctionHeader: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	properties ifNotNil:
		[(properties at: #api: ifAbsent: []) ifNotNil:
			[:pragma|
			aStream nextPutAll: (pragma argumentAt: 1).
			^self]].
	self emitJSFunctionHeader: aStream generator: aCodeGen newlineBeforeName: false! !

!JSMethod methodsFor: 'JS code generation' stamp: 'jpb 5/24/2020 08:45:39'!
emitJSFunctionHeader: aStream generator: aCodeGen newlineBeforeName: newlineBeforeName "<Boolean>"
	"Emit a JS function header for this method onto the given stream."

	aStream nextPutAll: 'function'.
	newlineBeforeName ifTrue: [aStream cr] ifFalse: [aStream space].
	(returnType last = $)
	and: [returnType includesSubString: (aCodeGen jsFunctionNameFor: self selectorForCodeGeneration)]) ifTrue:
		["Hack fix for e.g. <returnType: 'void (*setInterruptCheckChain(void (*aFunction)(void)))()'>"
		 ^self].
	aStream
		nextPutAll: (aCodeGen jsFunctionNameFor: self selectorForCodeGeneration);
		nextPut: $(.
	args
		do: [:arg | aStream nextPutAll: (aCodeGen returnPrefixFromVariable: arg)]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $)! !

!JSMethod methodsFor: 'JS code generation' stamp: 'bf 10/7/2014 00:25'!
emitJSHeaderOn: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	aStream cr. 
	self emitJSFunctionHeader: aStream generator: aCodeGen.
	aStream nextPutAll: ' {'; cr.
	self emitGlobalStructReferenceOn: aStream.
	locals do: [ :var | | varDecl |
		aStream nextPutAll: '	var ', (aCodeGen returnPrefixFromVariable: var).
		varDecl _ declarations at: var asString ifAbsent: [''].
		(varDecl includes: $=)
			ifTrue: [ | const |
				const _ ((varDecl copyAfter: $=) replaceAll: ${ with: $[) replaceAll: $} with: $].
				aStream nextPutAll: ' =', const]
			ifFalse: [(varDecl includes: $[)
					ifTrue: [ | size |
						size _ (varDecl copyAfter: $[) copyUpTo: $].
						size ifEmpty: [self halt].
						aStream nextPutAll: ' = new Array(', size, ')']].
		aStream nextPutAll: ';'; cr
	].
	(#(primitiveExtractChannel primitiveCondenseSound) includes: selector)
		ifTrue: [#(src dst) do: [:v | aStream nextPutAll: '	var _', v, ' = 0;'; cr]].
	locals isEmpty ifFalse: [ aStream cr ].! !

!JSMethod methodsFor: 'JS code generation' stamp: 'bf 10/6/2014 15:42'!
emitProxyFunctionPrototype: aStream generator: aCodeGen
	"Emit an indirect C function header for this method onto the given stream."

	| arg |
	aStream nextPutAll: returnType; space.
	aStream nextPutAll: '(*', (aCodeGen jsFunctionNameFor: self selectorForCodeGeneration), ')('.
	args isEmpty ifTrue: [ aStream nextPutAll: 'void' ].
	1 to: args size do: [ :i |
		arg _ args at: i.
		(declarations includesKey: arg) ifTrue: [
			aStream nextPutAll: (declarations at: arg).
		] ifFalse: [
			aStream nextPutAll: 'sqInt ', (args at: i).
		].
		i < args size ifTrue: [ aStream nextPutAll: ', ' ].
	].
	aStream nextPutAll: ')'.! !

!JSMethod methodsFor: 'JS code generation' stamp: 'bf 10/4/2014 12:22'!
isOneBasedArray: varName
	^oneBasedArrays ifNotNil: [oneBasedArrays includes: varName].
! !

!JSMethod methodsFor: 'JS code generation' stamp: 'bf 10/4/2014 12:33'!
oneBasedArrays
	^oneBasedArrays! !

!JSMethod methodsFor: 'JS hacks' stamp: 'jpb 5/21/2020 11:20:12'!
emitJSSpecialOn: aStream level: level generator: aCodeGen
	| expr type |
	aCodeGen pluginName = 'B2DPlugin' ifFalse: [^false].
	(returnType includes: $*) ifFalse: [^false].
	parseTree statements first isReturn ifFalse: [^false].
	expr _ parseTree statements first expression.
	expr isSend ifFalse: [^false].
	type _ returnType.
	expr selector = #coerce:to: ifTrue: [
		type = expr args second value ifFalse: [self halt].
		expr _ expr args first.
	].
	expr selector = #+ ifFalse: [^false].
	aStream tab: level; nextPutAll: 'return '.
	
	self flag: #fixme.
	"expr emitJSPointerArithmetic: type on: aStream level: level generator: aCodeGen type: type top: true."
	aStream nextPutAll: ';'; cr. 
	^true
! !

!JSMethod methodsFor: 'testing'!
hasReturn
	"Answer true if this method contains a return statement."

	parseTree nodesDo: [ :n | n isReturn ifTrue: [ ^ true ]].
	^ false! !

!JSMethod methodsFor: 'testing' stamp: 'jpb 5/28/2020 17:45:06'!
is: query
	#Assertion = query
		ifTrue: [ ^(selector beginsWith: 'assert') or: [selector beginsWith: 'verify'] ].
		
	^super is: query! !

!JSMethod methodsFor: 'initialization' stamp: 'jpb 5/21/2020 11:34:40'!
newCascadeTempFor: aTParseNode
	| varNode |
	self flag: #fixme.
	cascadeVariableNumber _ cascadeVariableNumber
								ifNil: [0]
								ifNotNil: [cascadeVariableNumber + 1].
	varNode _ SlangTVariableNode new setName: 'cascade', cascadeVariableNumber printString.
	aTParseNode isLeaf ifFalse:
		[declarations
			at: varNode name
			put: [:cg| "FIXME: self determineTypeFor: aTParseNode in: cg"]].
	^varNode! !

!JSMethod methodsFor: 'initialization' stamp: 'dtl 9/19/2010 14:58'!
setSelector: sel definingClass: class args: argList locals: localList block: aBlockNode primitive: aNumber properties: methodProperties comment: aComment
	"Initialize this method using the given information."

	selector _ sel.
	definingClass _ class.
	returnType _ #sqInt. 	 "assume return type is long for now"
	args _ argList asOrderedCollection collect: [:arg | arg key].
	locals _ (localList asSortedCollection: [:a :b| a key < b key]) collect: [:arg | arg key].
	declarations _ Dictionary new.
	"self addTypeForSelf." "<- Cog feature to be added later"
	primitive _ aNumber.
	properties _ methodProperties.
	comment _ aComment.
	parseTree _ aBlockNode asTranslatorNodeIn: self.
	labels _ OrderedCollection new.
	complete _ false.  "set to true when all possible inlining has been done"
	export _ self extractExportDirective.
	static _ self extractStaticDirective.
	canAsmLabel _ self extractLabelDirective.
	self extractSharedCase.
	self removeFinalSelfReturn.	"must preceed recordDeclarations because this may set returnType"
	self recordDeclarations.
	globalStructureBuildMethodHasFoo _ 0! !

!JSMethod methodsFor: 'initialization' stamp: 'jm 2/12/98 11:55'!
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

!JSMethod methodsFor: 'private' stamp: 'TPR 2/29/2000 18:45'!
printTempsAndVar: varName on: aStream 
	"add the required temps and the varname to the stream"
	aStream nextPutAll: '| rcvr stackPointer successFlag ' , varName , ' |';
	 cr! !

!JSMethod class methodsFor: 'class initialization' stamp: 'ar 11/18/1999 20:06'!
initialize
	"JSMethod initialize"	
	CaseStatements _ IdentitySet new: 10.
	CaseStatements addAll: #(dispatchOn:in: dispatchOn:in:with: dispatchOn:in:with:with:).! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:09:42'!
emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen
	^self emitJSCodeOn: aStream level: level generator: aCodeGen! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:09:52'!
emitJSCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitJSCodeOn: aStream level: level generator: aCodeGen! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:10:04'!
emitJSCodeOn: aStream level: lev generator: gen
	self subclassResponsibility.! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:10:12'!
emitJSCommentOn: aStream level: level
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

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:10:20'!
isBitBltPtr
	^false! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:10:32'!
isConstantNull
	^false! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:10:41'!
isConstantZero
	^false! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:10:50'!
isEqualityTest
	^false! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:10:59'!
isInterpreterProxyConstant
	^false! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:11:11'!
isLeafOrFunc
	^self isLeaf! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:11:21'!
isPlusOne
	^false! !

!SlangTParseNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:11:51'!
isTimesFour
	^false! !

!SlangTAssignmentNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:03:42'!
emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen
	aStream nextPut: $(.
	self emitJSCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPut: $)! !

!SlangTAssignmentNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:04:11'!
emitJSCodeAsExpressionOn: aStream level: level generator: aCodeGen
	aStream nextPut: $(.
	self emitJSCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPut: $)! !

!SlangTAssignmentNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:04:25'!
emitJSCodeOn: aStream level: level generator: aCodeGen
	expression isSwitch ifTrue:
		[^expression emitJSCodeOn: aStream addToEndOfCases: self level: level generator: aCodeGen].
	(self isVariableUpdatingAssignment and: [(aCodeGen isPointer: variable) not])
		ifTrue:
			[(expression args first isConstant and: [expression args first value = 1])
				ifTrue: [aStream nextPutAll: expression selector, expression selector.
					variable emitJSCodeOn: aStream level: level generator: aCodeGen]
				ifFalse: [
					variable emitJSCodeOn: aStream level: level generator: aCodeGen.
					aStream nextPutAll: ' ', expression selector, '= '.
					expression args first emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen]]
		ifFalse:
			[ | coerceToInt |
			coerceToInt := (variable isFloatIn: aCodeGen) not and: [expression isFloatIn: aCodeGen].
			variable emitJSCodeOn: aStream level: level generator: aCodeGen.
			aStream nextPutAll: ' = '.
			expression emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen.
			coerceToInt ifTrue: [aStream nextPutAll: '|0'].]! !

!SlangTAssignmentNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:04:51'!
isFloatIn: aCodeGen
	^variable isFloatIn: aCodeGen! !

!SlangTCaseStmtNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:05:32'!
emitJSCodeOn: aStream level: level generator: aCodeGen

	| indent |
	indent := (String new: level) collect: [ :ch | Character tab ].
	aStream nextPutAll: 'switch ('.
	expression asExpression emitJSCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'; cr.
	1 to: cases size do: [ :i |
		(firsts at: i) to: (lasts at: i) do: [ :caseIndex |
			aStream nextPutAll: indent, 'case ', caseIndex printString, ':'; cr.
		].
		(cases at: i) emitJSCodeOn: aStream level: level + 1 generator: aCodeGen.
		aStream nextPutAll: indent; tab; nextPutAll: 'break;'.
		aStream cr.
	].
	level timesRepeat: [ aStream tab ].
	aStream nextPutAll: '}'.! !

!SlangTConstantNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:06:03'!
emitJSCodeOn: aStream level: level generator: aCodeGen
	"Emit a C literal."

	aStream nextPutAll: (aCodeGen jsLiteralFor: value).! !

!SlangTConstantNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:06:20'!
isConstantZero
	^ value = 0! !

!SlangTConstantNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:06:31'!
isFloatIn: aCodeGen
	^value isFloat! !

!SlangTDefineNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:07:00'!
emitJSCodeOn: aStream level: level generator: aCodeGen
	"Emit a C literal."

	aStream nextPutAll: name.! !

!SlangTGoToNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:07:26'!
emitJSCodeOn: aStream level: level generator: aCodeGen
	"Emit a C goto statement."

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.! !

!SlangTInlineNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:08:13'!
emitJSCodeOn: aStream level: level generator: aCodeGen
	method emitInlineOn: aStream level: level generator: aCodeGen.! !

!SlangTLabeledCommentNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:08:41'!
emitJSCodeOn: aStream level: level generator: aCodeGen
	"Emit a C comment with optional label."

	self printOptionalLabelOn: aStream.
	aStream nextPutAll: '/* '.
	aStream nextPutAll: comment.
	aStream nextPutAll: ' */'.! !

!SlangTNotImplementedNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:09:12'!
emitJSCodeOn: aStream level: level generator: aCodeGen
	"Emit a comment only"

	aStream cr; nextPutAll: '/*** ';
		nextPutAll: self printString;
		nextPutAll: ' cannot translate: '; cr;
		nextPutAll: parseNode printString;
		cr; nextPutAll: ' ***/'; cr
! !

!SlangTReturnNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:12:08'!
emitJSCodeOn: aStream level: level generator: aCodeGen

	(expression isSwitch
	 or: [expression isCaseStmt]) ifTrue:
		[^expression emitJSCodeOn: aStream addToEndOfCases: self level: level generator: aCodeGen].

	('void' = aCodeGen currentMethod returnType) ifTrue: [
		"If the function is void, don't say 'return x' instead say ' x; return' "
		expression isLeaf ifFalse: [
			expression emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen.	
			aStream nextPutAll: ';'; space.
		].
		aStream nextPutAll: 'return'.
	] ifFalse: [
		aStream nextPutAll: 'return'.
		aStream space.
		expression emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen
	].! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:12:30'!
emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen
	"Emit the receiver in a form that can be passed as an argument."

	"If the selector is a built-in construct, translate it and return"
	(aCodeGen emitBuiltinConstructAsArgumentFor: self asExpression on: aStream level: level) ifFalse:
		["If it is a pointer dereference generate it"
		(self emitJSCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen) ifFalse:
			["Otherwise generate the vanilla C function call."
			 self emitJSCodeAsFunctionCallOn: aStream level: level generator: aCodeGen]]! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:12:40'!
emitJSCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:12:48'!
emitJSCodeAsFunctionCallOn: aStream level: level generator: aCodeGen

	"Translate this message send into a JS function call"
	"Special case for pluggable modules. Replace messages to interpreterProxy
	 by interpreterProxy->message(..) if the message is not builtin"
	(aCodeGen isGeneratingPluginCode
	 and: [receiver isVariable
	 and: ['interpreterProxy' = receiver name
	 and: [self isBuiltinOperator not]]]) ifTrue:
		[aStream nextPutAll:'interpreterProxy.'].
	"Translate this message send into a JS function call."
	aStream nextPutAll: (aCodeGen jsFunctionNameFor: selector); nextPut: $(.
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it."
	(self shouldIncludeReceiverAsFirstArgument: aCodeGen) ifTrue:
		[receiver emitJSCodeOn: aStream level: level generator: aCodeGen.
		arguments isEmpty ifFalse:
			[aStream nextPutAll: ', ']].
	arguments do:
		[ :arg| arg emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen]
		separatedBy: [aStream nextPut: $,; space].
	aStream nextPut: $)! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:13:01'!
emitJSCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen
	"If appropriate, translate this message send as a pointer dereference"

	(self isStructSend: aCodeGen) ifFalse:
		[^false].

	aStream nextPut: $(.
	receiver  emitJSCodeAsExpressionOn: aStream level: 0 generator: aCodeGen.
	aStream nextPut: $-; nextPut: $>.
	aStream nextPutAll: (aCodeGen jsFunctionNameFor: selector).
	arguments isEmpty ifFalse:
		[self assert: arguments size = 1.
		 aStream nextPutAll: ' = '.
		 arguments first emitJSCodeAsExpressionOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $).
	^true! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:13:11'!
emitJSCodeOn: aStream level: level generator: aCodeGen
	"Emit the receiver as a statement."

	"If the selector is a built-in construct, translate it and return"
	(aCodeGen emitBuiltinConstructFor: self on: aStream level: level) ifFalse:
		["If it is a pointer dereference generate it"
		(self emitJSCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen) ifFalse:
			["Otherwise generate the vanilla C function call."
			 self emitJSCodeAsFunctionCallOn: aStream level: level generator: aCodeGen]]! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:13:27'!
emitJSPointerArithmetic: type on: aStream level: level generator: aGenerator type: cType top: top
	(selector = #+) ifFalse: [self halt].
	receiver isVariable
		ifTrue: [ | func |
			func := ({'int' -> 'PTR_ADD'. 'float' -> 'FPTR_ADD'} as: Dictionary)
				at: ((cType copyUpTo: $*) copyWithout: $ ).
			aStream nextPutAll: func, '(',  receiver name, ', ']
		ifFalse: [receiver emitJSPointerArithmetic: type on: aStream level: level generator: aGenerator type: cType top: false.
			aStream nextPutAll: ' + '].
	aGenerator emitJSExpression: arguments first on: aStream.
	top ifTrue: [aStream nextPutAll: ')'].! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:13:36'!
isEqualityTest
	^#(= == ~= ~~) includes: self selector! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:13:45'!
isFloatIn: aCodeGen
	selector precedence = 2 ifFalse: [^false].
	^ (receiver isFloatIn: aCodeGen)
		or: [arguments first isFloatIn: aCodeGen]! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:13:59'!
isInterpreterProxyConstant
	^#(nilObject trueObject falseObject) includes: self selector! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:14:07'!
isLeafOrFunc
	selector precedence = 2 ifTrue: [^false].
	(#(and: or: bitAnd: bitOr: bitXor: bitShift:) includes: selector) ifTrue: [^false].
	^true! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:14:21'!
isPlusOne
	^ self selector = #+ and: [self args first isConstant and: [self args first value = 1]]! !

!SlangTSendNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:14:28'!
isTimesFour
	^self args first isConstant and:
		[(self selector = #* and: [self args first value = 4])
		or: [self selector = #<< and: [self args first value = 2]]]! !

!SlangTStmtListNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:15:03'!
emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen

	| statementWasComment |
	statementWasComment := false.
	statements
		do:
			[:s |
			s emitJSCommentOn: aStream level: level.
			s emitJSCodeAsArgumentOn: aStream level: 0 generator: aCodeGen.
			statementWasComment := s is: #Comment]
		separatedBy:
			[((self endsWithCloseBracket: aStream)
			  or: [statementWasComment]) ifFalse: [aStream nextPut: $,]]! !

!SlangTStmtListNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:15:06'!
emitJSCodeAsExpressionOn: aStream level: level generator: aCodeGen
	^self emitJSCodeAsArgumentOn: aStream level: level generator: aCodeGen! !

!SlangTStmtListNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:15:19'!
emitJSCodeOn: aStream level: level generator: aCodeGen

	self emitJSCommentOn: aStream level: level.
	statements do: [:s |
		s emitJSCommentOn: aStream level: level.
		aStream tab: level.
		s emitJSCodeOn: aStream level: level generator: aCodeGen.
		(((self endsWithCloseBracket: aStream) not
			and: [(s is: #Comment) not])
				and: [s requiresCLineTerminator])
			ifTrue: [aStream nextPut: $;].
		aStream cr].
! !

!SlangTVariableNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:15:35'!
emitJSCodeOn: aStream level: level generator: aCodeGen

	name = 'nil'
		ifTrue: [ aStream nextPutAll: (aCodeGen jsLiteralFor: nil) ]
		ifFalse: [ aStream nextPutAll: (aCodeGen returnPrefixFromVariable: name) ].! !

!SlangTVariableNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:15:44'!
isBitBltPtr
	^#('sourceBits' 'destBits') includes: self name! !

!SlangTVariableNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:15:52'!
isConstantNull
	^ name = 'nil'! !

!SlangTVariableNode methodsFor: '*Slang-Javascript' stamp: 'jpb 5/30/2020 12:16:00'!
isFloatIn: aCodeGen
	| type |
	type := aCodeGen typeOfVariable: name.
	type isNil ifTrue: [^false].
	(type includes: $*) ifTrue: [^false].
	(type beginsWithAnyOf: #('register ' 'static ')) ifTrue: [type := type copyAfter: $ ].
	(type beginsWithAnyOf: #('double ' 'float ')) ifTrue: [^true].
	(type beginsWithAnyOf: #('int ' 'unsigned ' 'sqInt ' 'usqInt ' 'var ')) ifTrue: [^false].
	self halt: 'need to handle ', type! !
JSCodeGenerator initialize!
JSMethod initialize!
