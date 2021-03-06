'From Squeak5.3 of 3 March 2020 [latest update: #19431] on 23 May 2020 at 8:03:49 pm'!
Behavior subclass: #Unsigned
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VMMaker-SmartSyntaxPlugins'!
!Unsigned commentStamp: 'tpr 5/5/2003 12:21' prior: 0!
Coercion specification for 32-bit unsigned numbers within plugins.

Note: "x asOop: Unsigned" can cause garbage collection when x is outside SmallInteger range.!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Unsigned class
	instanceVariableNames: ''!

!Unsigned class methodsFor: 'plugin generation' stamp: 'eem 10/2/2010 14:12'!
ccg: cg generateCoerceToOopFrom: aNode on: aStream
	"N.B.  The is used both for generation and simulation so answer the result (for interpretation)"
	^cg generateCoerceToUnsignedObjectFrom: aNode on: aStream! !

!Unsigned class methodsFor: 'plugin generation' stamp: 'eem 10/3/2010 08:09'!
ccg: cg generateCoerceToValueFrom: aNode on: aStream
	"N.B.  The could be used both for generation and simulation so answer the result (for interpretation)"
	^cg generateCoerceToUnsignedValueFrom: aNode on: aStream! !

!Unsigned class methodsFor: 'plugin generation' stamp: 'eem 11/19/2008 16:05'!
ccg: cg prolog: aBlock expr: aString index: anInteger

	^cg ccgLoad: aBlock expr: aString asUnsignedValueFrom: anInteger! !

!Unsigned class methodsFor: 'plugin generation' stamp: 'acg 9/20/1999 11:30'!
ccgCanConvertFrom: anObject

	anObject isInteger ifFalse: 
		[self error: 'Not an Integer object'. ^false].
	anObject >= 0 ifFalse: 
		[self error: 'Object is negative integer'. ^false].
	anObject < (2 raisedToInteger: 32) ifFalse: 
		[self error: 'Object is too large'. ^false].
	^true! !

!Unsigned class methodsFor: 'plugin generation' stamp: 'eem 11/19/2008 15:57'!
ccgDeclareCForVar: aSymbolOrString

	^'unsigned long ', aSymbolOrString! !


!Unsigned class methodsFor: '*vmmakerjs' stamp: 'bf 9/30/2014 17:06'!
jscg: cg generateCoerceToOopFrom: aNode on: aStream
	"N.B.  The is used both for generation and simulation so answer the result (for interpretation)"
	^cg generateCoerceToUnsignedObjectFrom: aNode on: aStream! !

!Unsigned class methodsFor: '*vmmakerjs' stamp: 'bf 9/30/2014 17:06'!
jscg: cg generateCoerceToValueFrom: aNode on: aStream
	"N.B.  The could be used both for generation and simulation so answer the result (for interpretation)"
	^cg generateCoerceToUnsignedValueFrom: aNode on: aStream! !

!Unsigned class methodsFor: '*vmmakerjs' stamp: 'eem 11/19/2008 16:05'!
jscg: cg prolog: aBlock expr: aString index: anInteger

	^cg jscgLoad: aBlock expr: aString asUnsignedValueFrom: anInteger! !

!Unsigned class methodsFor: '*vmmakerjs' stamp: 'acg 9/20/1999 11:30'!
jscgCanConvertFrom: anObject

	anObject isInteger ifFalse: 
		[self error: 'Not an Integer object'. ^false].
	anObject >= 0 ifFalse: 
		[self error: 'Object is negative integer'. ^false].
	anObject < (2 raisedToInteger: 32) ifFalse: 
		[self error: 'Object is too large'. ^false].
	^true! !
