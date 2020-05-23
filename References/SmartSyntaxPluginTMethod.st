'From Squeak5.3 of 3 March 2020 [latest update: #19431] on 23 May 2020 at 7:25:01 pm'!
TMethod subclass: #SmartSyntaxPluginTMethod
	instanceVariableNames: 'isPrimitive suppressingFailureGuards selectorOverride fullArgs parmSpecs rcvrSpec'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VMMaker-SmartSyntaxPlugins'!
!SmartSyntaxPluginTMethod commentStamp: '<historical>' prior: 0!
Variation of TMethod node of the Smalltalk C Code Generator, used in conjunction with TestCodeGenerator and TestInterpreterPlugin to generate named primitives with type coercion specifications.!


!SmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'acg 9/19/1999 11:19'!
args: anInteger

	^args := anInteger! !

!SmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'acg 9/19/1999 11:18'!
parmSpecs

	^parmSpecs! !

!SmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'acg 9/19/1999 11:50'!
rcvrSpec

	^rcvrSpec! !

!SmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'dtl 2/3/2007 11:23'!
selectorForCodeGeneration
	"A primitive directive my override the selector specification."

	^ self selectorOverride ifNil: [self selector]! !

!SmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'dtl 2/3/2007 11:21'!
selectorOverride
	"A primitive directive allows the selector to be overridden in order to specify
	a preferred name for the generated primitive."

	^ selectorOverride! !

!SmartSyntaxPluginTMethod methodsFor: 'accessing' stamp: 'dtl 2/3/2007 11:21'!
selectorOverride: preferredSelectorName
	"A primitive directive allows the selector to be overridden in order to specify
	a preferred name for the generated primitive."

	selectorOverride := preferredSelectorName! !


!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'acg 12/15/1999 06:31'!
assign: variable expression: expression

	^TAssignmentNode new
		setVariable: variable
		expression: expression! !

!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'dtl 5/21/2011 21:14'!
checkSuccessExpr
	"Return the parse tree for an expression that aborts the primitive if primFailCode is set."

	| expr |
	expr := 'interpreterProxy failed ifTrue: [^nil]'.
	^ self statementsFor: expr varName: ''
! !

!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'acg 12/18/1999 10:47'!
generateFailureGuardOn: sStream
	suppressingFailureGuards ifTrue: [^nil].
	sStream nextPutAll: self checkSuccessExpr
! !

!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'acg 12/15/1999 05:50'!
nullReturnExpr

	^ TReturnNode new
		setExpression: (TVariableNode new setName: 'null')! !

!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'acg 9/20/1999 14:04'!
oldReplaceSizeMessages
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
				receiver: (TVariableNode new setName: 'interpreterProxy')
				arguments: (Array with: argExpr)]].
! !

!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'ikp 3/31/2005 14:23'!
oopVariable: aString

	(locals includes: aString) ifFalse:
		[locals add: aString.
		 declarations
			at: aString 
			put: 'sqInt ', aString].
	^TVariableNode new setName: aString! !

!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'acg 12/15/1999 05:55'!
pop: anInteger thenReturnExpr: anExpression

	^TSendNode new
		setSelector: #pop:thenPush:
		receiver: (TVariableNode new setName: 'interpreterProxy')
		arguments: (Array 
			with: (TConstantNode new 
				setValue: anInteger)
			with: anExpression)! !

!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'acg 12/15/1999 05:45'!
popExpr: anInteger

	^ TSendNode new
			 setSelector: #pop:
			 receiver: (TVariableNode new setName: 'interpreterProxy')
			 arguments: (Array 
				with: (TConstantNode new 
					setValue: anInteger))! !

!SmartSyntaxPluginTMethod methodsFor: 'private' stamp: 'TPR 3/2/2000 12:39'!
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


!SmartSyntaxPluginTMethod methodsFor: 'generating C code' stamp: 'ikp 3/31/2005 14:23'!
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


!SmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'dtl 2/3/2007 11:40'!
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

!SmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'ar 4/4/2006 21:10'!
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
					ccg:		SmartSyntaxPluginCodeGenerator new
					prolog:  [:expr | aStmt variable name, ' := ', expr]
					expr: 	aStmt variable name
					index: 	(fullArgs size))
			varName: '')].

	"only add the failure guard if there are args or it is an assignment"
	(fullArgs isEmpty not or:[aStmt isAssignment]) ifTrue:[self generateFailureGuardOn: sStream].
	^true.
! !

!SmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'TPR 2/10/2000 17:43'!
isPrimitiveDirectiveSend: stmt
	
	stmt isSend ifTrue:
		[stmt selector = #primitive: ifTrue:
			[^self primitive: 	stmt args first value
				   parameters:	(Array new: args size withAll: #Oop)
				   receiver:		#Oop].
		 stmt selector = #primitive:parameters: ifTrue:
			[^self primitive: 	stmt args first value
				   parameters: 	stmt args second value
				   receiver:		#Oop].
		 stmt selector = #primitive:parameters:receiver: ifTrue:
			[^self primitive:		stmt args first value
				   parameters:	stmt args second value
				   receiver:		stmt args third value].
		^false].
	^false.
! !

!SmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'ar 4/4/2006 21:10'!
namedPrimitiveProlog

	| cg |
	cg := SmartSyntaxPluginCodeGenerator new.
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

!SmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'dtl 2/3/2007 11:29'!
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

!SmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'acg 9/17/1999 22:41'!
primitiveDirectiveWasHandled: stmt on: sStream

	(self isPrimitiveDirectiveSend: stmt) ifTrue:
		[^self handlePrimitiveDirective: stmt on: sStream].
	(stmt isAssignment and: 
		[self isPrimitiveDirectiveSend: stmt expression]) ifTrue:
			[^self handlePrimitiveDirective: stmt on: sStream].
	^false.
! !

!SmartSyntaxPluginTMethod methodsFor: 'specifying primitives' stamp: 'tpr 6/9/2003 16:38'!
simulatePrologInContext: aContext

	|cg instructions |
	cg := SmartSyntaxPluginCodeGenerator new.
	parmSpecs keysAndValuesDo: 
		[:index :each |
		 instructions := ((parmSpecs at: index)
			ccg: cg 
			prolog: (cg ccgTVarBlock: index) 
			expr: '<foo>' 
			index: args size - index).
		 Compiler new 
			evaluate: instructions
			in: aContext 
			to: aContext receiver
			notifying: nil
			ifFail: nil].
	instructions := (rcvrSpec
		ccg: cg 
		prolog: [:expr | '^', expr]
		expr: '<foo>' 
		index: args size).
	 ^Compiler new 
		evaluate: instructions
		in: aContext 
		to: aContext receiver
		notifying: nil
		ifFail: nil! !


!SmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'acg 12/18/1999 10:39'!
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

!SmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'TPR 3/1/2000 20:21'!
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

!SmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'acg 9/18/1999 01:49'!
fixUpReturns
	"Replace each return statement in this method with (a) the given postlog, (b) code to pop the receiver and the given number of arguments, and (c) code to push the integer result and return."

	parseTree nodesDo: [:node |
		node isStmtList ifTrue: [
			node setStatements: (Array streamContents:
				[:sStream |
				 node statements do: 
					[:stmt | self fixUpReturnOneStmt: stmt on: sStream]])]]! !

!SmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'dtl 9/19/2010 22:56'!
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

!SmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'acg 9/17/1999 18:18'!
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

!SmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'TPR 3/2/2000 19:07'!
replaceArraySizeMessages
	"Replace sends of the message 'size' with calls to sizeOfSTArrayFromCPrimitive. Specialised version for generating primitives outside a plugin"

	super replaceSizeMessages
! !

!SmartSyntaxPluginTMethod methodsFor: 'transforming' stamp: 'acg 9/20/1999 14:04'!
replaceSizeMessages
	"Replace sends of the message 'size' with calls to sizeOfSTArrayFromCPrimitive."

	parseTree nodesDo: [:n |
		(n isSend and: [n selector = #size]) ifTrue: [
			n
				setSelector: #sizeOfSTArrayFromCPrimitive:
				receiver: (TVariableNode new setName: 'interpreterProxy')
				arguments: (Array with: n receiver)]].
! !


!SmartSyntaxPluginTMethod methodsFor: 'initializing' stamp: 'acg 9/19/1999 11:46'!
fromContext: aContext primitive: aString parameters: aClassList receiver: aClass

	fullArgs := args := aContext tempNames
				copyFrom: 1
				to: aContext method numArgs.
	self 
		primitive: aString
		parameters: aClassList
		receiver: aClass! !

!SmartSyntaxPluginTMethod methodsFor: 'initializing' stamp: 'eem 10/2/2009 11:32'!
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


!SmartSyntaxPluginTMethod methodsFor: 'primitive compilation' stamp: 'TPR 3/2/2000 16:07'!
vmNameString
	"return the string to use as the vm name in code generated for this method"
	^'interpreterProxy'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SmartSyntaxPluginTMethod class
	instanceVariableNames: ''!

!SmartSyntaxPluginTMethod class methodsFor: 'as yet unclassified' stamp: 'acg 9/19/1999 11:47'!
fromContext: aContext primitive: aString parameters: aClassList receiver: aClass

	^super new 
		fromContext: aContext 
		primitive: aString 
		parameters: aClassList 
		receiver: aClass
! !
