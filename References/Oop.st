'From Squeak5.3 of 3 March 2020 [latest update: #19431] on 23 May 2020 at 8:03:45 pm'!
Behavior subclass: #Oop
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VMMaker-SmartSyntaxPlugins'!
!Oop commentStamp: '<historical>' prior: 0!
Cooercion specification for Identity coercions:

	x asOop: Oop == x
	y asValue: Oop == y!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Oop class
	instanceVariableNames: ''!

!Oop class methodsFor: 'plugin generation' stamp: 'eem 10/2/2010 14:12'!
ccg: cg generateCoerceToOopFrom: aNode on: aStream
	"N.B.  The is used both for generation and simulation so answer the result (for interpretation)"
	^cg emitCExpression: aNode on: aStream! !

!Oop class methodsFor: 'plugin generation' stamp: 'eem 10/3/2010 08:09'!
ccg: cg generateCoerceToValueFrom: aNode on: aStream
	"N.B.  The could be used both for generation and simulation so answer the result (for interpretation)"
	^cg emitCExpression: aNode on: aStream! !

!Oop class methodsFor: 'plugin generation' stamp: 'acg 9/18/1999 15:58'!
ccg: cg prolog: aBlock expr: aString index: anInteger

	^cg ccgLoad: aBlock expr: aString asRawOopFrom: anInteger! !

!Oop class methodsFor: 'plugin generation' stamp: 'acg 9/20/1999 11:17'!
ccgCanConvertFrom: anObject

	^(anObject isKindOf: SmallInteger) not! !

!Oop class methodsFor: 'plugin generation' stamp: 'ikp 3/31/2005 14:20'!
ccgDeclareCForVar: aSymbolOrString

	^'sqInt ', aSymbolOrString! !


!Oop class methodsFor: '*vmmakerjs' stamp: 'bf 9/30/2014 17:04'!
jscg: cg generateCoerceToOopFrom: aNode on: aStream
	"N.B.  The is used both for generation and simulation so answer the result (for interpretation)"
	^cg emitJSExpression: aNode on: aStream! !

!Oop class methodsFor: '*vmmakerjs' stamp: 'bf 9/30/2014 17:04'!
jscg: cg generateCoerceToValueFrom: aNode on: aStream
	"N.B.  The could be used both for generation and simulation so answer the result (for interpretation)"
	^cg emitJSExpression: aNode on: aStream! !

!Oop class methodsFor: '*vmmakerjs' stamp: 'bf 9/30/2014 17:04'!
jscg: cg prolog: aBlock expr: aString index: anInteger

	^cg jscgLoad: aBlock expr: aString asRawOopFrom: anInteger! !

!Oop class methodsFor: '*vmmakerjs' stamp: 'bf 9/30/2014 17:04'!
jscgCanConvertFrom: anObject

	^(anObject isKindOf: SmallInteger) not! !
