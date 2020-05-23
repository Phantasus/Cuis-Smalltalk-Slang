'From Squeak5.3 of 3 March 2020 [latest update: #19431] on 23 May 2020 at 7:24:54 pm'!
VMPluginCodeGenerator subclass: #SmartSyntaxPluginCodeGenerator
	instanceVariableNames: 'debugFlag'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VMMaker-SmartSyntaxPlugins'!
!SmartSyntaxPluginCodeGenerator commentStamp: 'tpr 5/5/2003 16:03' prior: 0!
Subclass of CCodeGenerator, used in connection with TestInterpreterPlugin to generate named primitives with type coercion specifications. See the plugins implemeted as subclasses of TestInterpreterPlugin!


!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:32'!
ccgLoad: aBlock expr: aString asBooleanValueFrom: anInteger
	"Answer codestring for boolean coercion (with validating side-effect) of object, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy booleanValueOf:';
		crtab: 2;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	')'])! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asFloatValueFrom: anInteger
	"Answer codestring for double precision coercion (with validating side-effect) of oop, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackFloatValue: ';
		nextPutAll: anInteger asString])! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asIntegerValueFrom: anInteger
	"Answer codestring for integer coercion (with validating side-effect) of oop, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackIntegerValue: ';
		nextPutAll: anInteger asString])! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 9/19/1999 20:28'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 9/19/1999 20:28'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:29'!
ccgLoad: aBlock expr: aString asNonIntegerValueFrom: anInteger
	"Answer codestring for oop (with validating side effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackObjectValue: ';
		nextPutAll: anInteger asString])! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:32'!
ccgLoad: aBlock expr: aString asRawOopFrom: anInteger
	"Answer a string for a Slang expression that will load an oop (without validation) from stack index anInteger.  Apply aBlock, a BlockContext instance that when passed an expression, will return a string assigning the expression to the desired identifier, to the string before answering.  aString is a Slang expression that refers to the stack value, once it has been loaded."

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackValue: ';
		nextPutAll: anInteger asString])! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
ccgLoad: aBlock expr: aString asUnsignedValueFrom: anInteger
	"Answer a codestring for positive integer coercion (with validating side-effect) of oop, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy positive32BitValueOf:';
		crtab: 2;
		nextPutAll: '(interpreterProxy stackValue:';
		nextPutAll: anInteger asString;
		nextPutAll:	')'])! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 12/17/1999 07:31'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'ar 4/4/2006 21:10'!
ccgSetBlock: aString

	^[:expr | aString, ' := ', expr]! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'acg 9/19/1999 13:05'!
ccgTVarBlock: anInteger

	^[:expr | '(thisContext tempAt: 1) tempAt: ', anInteger asString, ' put: (', expr, ')']! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'coercing' stamp: 'EstebanLorenzano 12/6/2010 19:19'!
ccgValBlock: valString
	^[:index | String streamContents:
		[:aStream | aStream
			nextPutAll: 'interpreterProxy success: (interpreterProxy ';
			nextPutAll: valString;
			nextPutAll: ': (interpreterProxy stackValue: ';
			nextPutAll: index asString;
			nextPutAll: '))']]! !


!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asBooleanValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: ' = interpreterProxy->booleanValueOf(';
		crtab: 2;
		nextPutAll: 'interpreterProxy->stackValue(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asCharPtrFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = (char *) interpreterProxy->firstIndexableField(';
		crtab: 2;
		nextPutAll: 	'interpreterProxy->stackValueOf(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asFloatPtrFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = (float *) interpreterProxy->firstIndexableField(';
		crtab: 2;
		nextPutAll: 	'interpreterProxy->stackValueOf(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asFloatValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = interpreterProxy->stackFloatValue(';
		nextPutAll: anInteger asString;
		nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asIntPtrFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = (int *) interpreterProxy->firstIndexableField(';
		crtab: 2;
		nextPutAll: 	'interpreterProxy->stackValueOf(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:43'!
emitLoad: aString asIntegerValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = interpreterProxy stackIntegerValue(';
		nextPutAll: anInteger asString;
		nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:42'!
emitLoad: aString asKindOf: aClass from: anInteger on: aStream

	self emitLoad: aString asNakedOopFrom: anInteger on: aStream.
	aStream
		crtab;
		nextPutAll: 'interpreterProxy->success(interpreterProxy->isKindOf(';
		nextPutAll: aString;
		nextPutAll: 	', ''';
		nextPutAll:	aClass asString;
		nextPutAll: '''))'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'bf 3/16/2000 19:20'!
emitLoad: aString asMemberOf: aClass from: anInteger on: aStream

	self emitLoad: aString asNakedOopFrom: anInteger on: aStream.
	aStream
		crtab;
		nextPutAll: 'interpreterProxy->success(interpreterProxy->isMemberOf(';
		nextPutAll: aString;
		nextPutAll: 	', ''';
		nextPutAll:	aClass asString;
		nextPutAll: '''))'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/18/1999 14:23'!
emitLoad: aString asNakedOopFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: ' = interpreterProxy stackValue(';
		nextPutAll: anInteger asString;
		nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:44'!
emitLoad: aString asNonIntegerValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = interpreterProxy stackObjectValue(';
		nextPutAll: anInteger asString;
		nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'linking' stamp: 'acg 9/17/1999 01:44'!
emitLoad: aString asUnsignedValueFrom: anInteger on: aStream

	aStream
		nextPutAll: aString;
		nextPutAll: 	' = interpreterProxy->positive32BitValueOf(';
		crtab: 2;
		nextPutAll: 	'interpreterProxy->stackValue(';
		nextPutAll: anInteger asString;
		nextPutAll: '))'! !


!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:08'!
generateAsBooleanObj: aNode on: aStream indent: anInteger

	aStream nextPutAll: '('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: 
		') ? interpreterProxy->trueObject(): interpreterProxy->falseObject()'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:09'!
generateAsCBoolean: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->booleanValueOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:09'!
generateAsCDouble: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->floatValueOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 21:53'!
generateAsCInt: aNode on: aStream indent: anInteger

	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ' >> 1'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:09'!
generateAsCUnsigned: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->positive32BitValueOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:10'!
generateAsCharPtr: aNode on: aStream indent: anInteger

	aStream nextPutAll: '(char *) interpreterProxy->firstIndexableField('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:10'!
generateAsFloatObj: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->floatObjectOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'TPR 2/25/2000 16:21'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'TPR 2/25/2000 16:41'!
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
	fetchNode := TSendNode new
		setSelector: #fetchPointer:ofObject:
		receiver: (TVariableNode new setName: 'interpreterProxy')
		arguments: (Array
			with: (TConstantNode new setValue: index - 1)
			with: aNode receiver).
	cName := aNode args third nameOrValue.
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'third arg must identify class'].
	class ccg: self generateCoerceToValueFrom: fetchNode on: aStream
! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'TPR 2/25/2000 16:41'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:10'!
generateAsIntPtr: aNode on: aStream indent: anInteger

	aStream nextPutAll: '(int *) interpreterProxy->firstIndexableField('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 12/17/1999 07:23'!
generateAsOop: aNode on: aStream indent: anInteger

	| cName class |
	cName := aNode args first nameOrValue.
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'first arg must identify class'].
	class ccg: self generateCoerceToOopFrom: aNode receiver on: aStream! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:10'!
generateAsPositiveIntegerObj: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->positive32BitIntegerFor('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:47'!
generateAsSmallIntegerObj: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->integerObjectOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 12/17/1999 07:22'!
generateAsValue: aNode on: aStream indent: anInteger

	| cName class |
	cName := aNode args first nameOrValue.
	class := Smalltalk 
		at: (cName asSymbol) 
		ifAbsent: [nil].
	(class isNil not and: [class isBehavior]) ifFalse: 
		[^self error: 'first arg must identify class'].
	class ccg: self generateCoerceToValueFrom: aNode receiver on: aStream! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'dtl 5/19/2010 21:35'!
generateCPtrAsOop: aNode on: aStream indent: anInteger 

	aStream nextPutAll: '('.
	aStream nextPutAll: 'oopForPointer( '.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ' ) - BASE_HEADER_SIZE)'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:11'!
generateClass: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->fetchClassOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'sr 4/8/2000 02:38'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:11'!
generateField: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->fetchPointerofObject('.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 23:40'!
generateFieldPut: aNode on: aStream indent: anInteger
		
	aStream nextPutAll: 'interpreterProxy->storePointerofObjectwithValue('.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args second on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/16/1999 08:02'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:50'!
generateIsBytes: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isBytes('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:50'!
generateIsFloat: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isFloatObject('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:49'!
generateIsIndexable: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isIndexable('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 20:49'!
generateIsInteger: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isIntegerValue('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:13'!
generateIsIntegerOop: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isIntegerObject('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:13'!
generateIsIntegerValue: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isIntegerValue('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:20'!
generateIsKindOf: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isKindOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','''.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ''')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:20'!
generateIsMemberOf: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isMemberOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','''.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ''')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:14'!
generateIsPointers: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isPointers('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:14'!
generateIsWords: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isWords('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:13'!
generateIsWordsOrBytes: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->isWordsOrBytes('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/19/1999 01:56'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 12/31/1999 16:37'!
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

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:15'!
generateStAt: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->stObjectat('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ')'
! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 9/15/1999 22:17'!
generateStAtPut: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->stObjectatput('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args first on: aStream.
	aStream nextPutAll: ','.
	self emitCExpression: aNode args second on: aStream.
	aStream nextPutAll: ')'
! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'acg 1/1/2000 22:41'!
generateStSize: aNode on: aStream indent: anInteger

	aStream nextPutAll: 'interpreterProxy->stSizeOf('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ')'.! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'translating builtins' stamp: 'dtl 3/18/2013 18:24'!
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


!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 12/25/1999 10:00'!
generateCoerceToBooleanObjectFrom: aNode on: aStream

	aStream nextPutAll: '('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: '? interpreterProxy->trueObject(): interpreterProxy->falseObject())'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:07'!
generateCoerceToBooleanValueFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->booleanValueOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:03'!
generateCoerceToFloatObjectFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->floatObjectOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 05:53'!
generateCoerceToFloatValueFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->floatValueOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'dtl 5/19/2010 21:34'!
generateCoerceToObjectFromPtr: aNode on: aStream
	"This code assumes no named instance variables"

	aStream nextPutAll: 'oopForPointer('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ') - BASE_HEADER_SIZE'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 05:57'!
generateCoerceToPtr: aString fromObject: aNode on: aStream
	"This code assumes no named instance variables"

	aStream 
		nextPutAll: '((';
		nextPutAll: aString;
		nextPutAll: ') interpreterProxy->firstIndexableField('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: '))'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:03'!
generateCoerceToSmallIntegerObjectFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->integerObjectOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 05:59'!
generateCoerceToSmallIntegerValueFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->integerValueOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:03'!
generateCoerceToUnsignedObjectFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->positive32BitIntegerFor('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'asOop:/asValue:' stamp: 'acg 10/5/1999 06:00'!
generateCoerceToUnsignedValueFrom: aNode on: aStream

	aStream nextPutAll: 'interpreterProxy->positive32BitValueOf('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ')'! !


!SmartSyntaxPluginCodeGenerator methodsFor: 'debug code' stamp: 'sr 4/8/2000 00:52'!
generateDebugCode
	^ debugFlag! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'debug code' stamp: 'sr 4/8/2000 00:52'!
generateDebugCode: aBool 
	debugFlag := aBool! !


!SmartSyntaxPluginCodeGenerator methodsFor: 'initialize' stamp: 'sr 4/8/2000 00:53'!
initialize
	super initialize.
	debugFlag := false! !

!SmartSyntaxPluginCodeGenerator methodsFor: 'initialize' stamp: 'tpr 6/9/2003 16:40'!
translationMethodClass
	"return the class used to produce C translation methods from MethodNodes"
	^SmartSyntaxPluginTMethod! !


!SmartSyntaxPluginCodeGenerator methodsFor: 'transforming' stamp: 'ar 3/10/2000 17:59'!
var: varName as: aClass
	"Record the given C declaration for a global variable"

	variableDeclarations at: varName asString put: (aClass ccgDeclareCForVar: varName)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SmartSyntaxPluginCodeGenerator class
	instanceVariableNames: ''!

!SmartSyntaxPluginCodeGenerator class methodsFor: '*vmmakerjs' stamp: 'bf 9/30/2014 14:41'!
new
	JSCodeGenerator isActive ifTrue: [^JSSmartSyntaxPluginCodeGenerator new].
	^super new! !
