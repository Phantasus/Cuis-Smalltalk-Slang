'From Squeak5.3 of 3 March 2020 [latest update: #19431] on 8 June 2020 at 8:12:30 am'!
InterpreterPlugin subclass: #Matrix2x3Plugin
	instanceVariableNames: 'm23ResultX m23ResultY m23ArgX m23ArgY'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VMMaker-Plugins'!

!Matrix2x3Plugin methodsFor: 'private' stamp: 'ar (auto pragmas dtl 2010-09-28) 11/9/1998 15:17'!
loadArgumentMatrix: matrix
	"Load the argument matrix"
	<returnTypeC: 'float *'>
	interpreterProxy failed ifTrue:[^nil].
	((interpreterProxy isWords: matrix) and:[(interpreterProxy slotSizeOf: matrix) = 6]) 
		ifFalse:[interpreterProxy primitiveFail.
				^nil].
	^self cCoerce: (interpreterProxy firstIndexableField: matrix) to:'float *'.! !

!Matrix2x3Plugin methodsFor: 'private' stamp: 'ar 11/9/1998 16:17'!
loadArgumentPoint: point
	"Load the argument point into m23ArgX and m23ArgY"
	| oop isInt |
	interpreterProxy failed ifTrue:[^nil].
	"Check class of point"
	(interpreterProxy fetchClassOf: point) = (interpreterProxy classPoint) 
		ifFalse:[^interpreterProxy primitiveFail].
	"Load X value"
	oop := interpreterProxy fetchPointer: 0 ofObject: point.
	isInt := interpreterProxy isIntegerObject: oop.
	(isInt or:[interpreterProxy isFloatObject: oop])
		ifFalse:[^interpreterProxy primitiveFail].
	isInt
		ifTrue:[m23ArgX := interpreterProxy integerValueOf: oop]
		ifFalse:[m23ArgX := interpreterProxy floatValueOf: oop].

	"Load Y value"
	oop := interpreterProxy fetchPointer: 1 ofObject: point.
	isInt := interpreterProxy isIntegerObject: oop.
	(isInt or:[interpreterProxy isFloatObject: oop])
		ifFalse:[^interpreterProxy primitiveFail].
	isInt
		ifTrue:[m23ArgY := interpreterProxy integerValueOf: oop]
		ifFalse:[m23ArgY := interpreterProxy floatValueOf: oop].

! !

!Matrix2x3Plugin methodsFor: 'private' stamp: 'dtl 9/14/2015 20:19'!
okayIntValue: value
	^(value >= -1073741824 asFloat and:[value <= 1073741823 asFloat]) 
! !

!Matrix2x3Plugin methodsFor: 'private' stamp: 'eem 7/10/2010 21:38'!
roundAndStoreResultPoint: nItemsToPop
	"Store the result of a previous operation.
	Fail if we cannot represent the result as SmallInteger"
	m23ResultX := m23ResultX + 0.5.
	m23ResultY := m23ResultY + 0.5.
	(self okayIntValue: m23ResultX) ifFalse:[^interpreterProxy primitiveFail].
	(self okayIntValue: m23ResultY) ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy pop: nItemsToPop thenPush:
		(interpreterProxy makePointwithxValue: m23ResultX asInteger
							yValue: m23ResultY asInteger)! !

!Matrix2x3Plugin methodsFor: 'private' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 17:04'!
roundAndStoreResultRect: dstOop x0: x0 y0: y0 x1: x1 y1: y1
	"Check, round and store the result of a rectangle operation"
	| minX maxX minY maxY originOop cornerOop rectOop |
	<var: #x0 type: 'double '>
	<var: #y0 type: 'double '>
	<var: #x1 type: 'double '>
	<var: #y1 type: 'double '>
	<var: #minX type: 'double '>
	<var: #maxX type: 'double '>
	<var: #minY type: 'double '>
	<var: #maxY type: 'double '>

	minX := x0 + 0.5.
	(self okayIntValue: minX) ifFalse:[^interpreterProxy primitiveFail].
	maxX := x1 + 0.5.
	(self okayIntValue: maxX) ifFalse:[^interpreterProxy primitiveFail].
	minY := y0 + 0.5.
	(self okayIntValue: minY) ifFalse:[^interpreterProxy primitiveFail].
	maxY := y1 + 0.5.
	(self okayIntValue: maxY) ifFalse:[^interpreterProxy primitiveFail].

	interpreterProxy pushRemappableOop: dstOop.
	originOop := interpreterProxy makePointwithxValue: minX asInteger yValue: minY asInteger.
	interpreterProxy pushRemappableOop: originOop.
	cornerOop := interpreterProxy makePointwithxValue: maxX asInteger yValue: maxY asInteger.
	originOop := interpreterProxy popRemappableOop.
	rectOop := interpreterProxy popRemappableOop.
	interpreterProxy storePointer: 0 ofObject: rectOop withValue: originOop.
	interpreterProxy storePointer: 1 ofObject: rectOop withValue: cornerOop.
	^rectOop! !


!Matrix2x3Plugin methodsFor: 'transforming' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 17:02'!
matrix2x3ComposeMatrix: m1 with: m2 into: m3
	"Multiply matrix m1 with m2 and store the result into m3."
	| a11 a12 a13 a21 a22 a23 |
	<var: #m1 type: 'const float *'>
	<var: #m2 type: 'const float *'>
	<var: #m3 type: 'float *'>
	<var: #a11 type: 'double '>
	<var: #a12 type: 'double '>
	<var: #a13 type: 'double '>
	<var: #a21 type: 'double '>
	<var: #a22 type: 'double '>
	<var: #a23 type: 'double '>

	a11 := ((m1 at: 0) * (m2 at: 0)) + ((m1 at: 1) * (m2 at: 3)).
	a12 := ((m1 at: 0) * (m2 at: 1)) + ((m1 at: 1) * (m2 at: 4)).
	a13 := ((m1 at: 0) * (m2 at: 2)) + ((m1 at: 1) * (m2 at: 5)) + (m1 at: 2).
	a21 := ((m1 at: 3) * (m2 at: 0)) + ((m1 at: 4) * (m2 at: 3)).
	a22 := ((m1 at: 3) * (m2 at: 1)) + ((m1 at: 4) * (m2 at: 4)).
	a23 := ((m1 at: 3) * (m2 at: 2)) + ((m1 at: 4) * (m2 at: 5)) + (m1 at: 5).

	m3 at: 0 put: (self cCoerce: a11 to: 'float').
	m3 at: 1 put: (self cCoerce: a12 to: 'float').
	m3 at: 2 put: (self cCoerce: a13 to: 'float').
	m3 at: 3 put: (self cCoerce: a21 to: 'float').
	m3 at: 4 put: (self cCoerce: a22 to: 'float').
	m3 at: 5 put: (self cCoerce: a23 to: 'float').
! !

!Matrix2x3Plugin methodsFor: 'transforming' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 17:02'!
matrix2x3InvertPoint: m
	"Invert the pre-loaded argument point by the given matrix"
	| x y det detX detY |
	<var: #m type: 'float *'>
	<var: #x type: 'double '>
	<var: #y type: 'double '>
	<var: #det type: 'double '>
	<var: #detX type: 'double '>
	<var: #detY type: 'double '>

	x := m23ArgX - (m at: 2).
	y := m23ArgY - (m at: 5).
	det := ((m at: 0) * (m at: 4)) - ((m at: 1) * (m at: 3)).
	det = 0.0 ifTrue:[^interpreterProxy primitiveFail]."Matrix is singular."
	det := 1.0 / det.
	detX := (x * (m at: 4)) - ((m at: 1) * y).
	detY := ((m at: 0) * y) - (x * (m at: 3)).
	m23ResultX := detX * det.
	m23ResultY := detY * det.! !

!Matrix2x3Plugin methodsFor: 'transforming' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 17:03'!
matrix2x3TransformPoint: m
	"Transform the pre-loaded argument point by the given matrix"
	<var: #m type: 'float *'>
	m23ResultX := (m23ArgX * (m at: 0)) + (m23ArgY * (m at: 1)) + (m at: 2).
	m23ResultY := (m23ArgX * (m at: 3)) + (m23ArgY * (m at: 4)) + (m at: 5).! !


!Matrix2x3Plugin methodsFor: 'primitives' stamp: 'dtl 10/14/2010 23:23'!
primitiveComposeMatrix
	| m1 m2 m3 result |
	<export: true>
	<inline: false>
	<var: #m1 type: #'float *'>
	<var: #m2 type: #'float *'>
	<var: #m3 type: #'float *'>
	self cCode: ''  "Make this fail in simulation"
		inSmalltalk: [interpreterProxy success: false. ^ nil].
	m3 := self loadArgumentMatrix: (result := interpreterProxy stackObjectValue: 0).
	m2 := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 1).
	m1 := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 2).
	interpreterProxy failed ifTrue:[^nil].
	self matrix2x3ComposeMatrix: m1 with: m2 into: m3.
	interpreterProxy pop: 3 thenPush: result! !

!Matrix2x3Plugin methodsFor: 'primitives' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 17:03'!
primitiveInvertPoint
	| matrix |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	self loadArgumentPoint: (interpreterProxy stackObjectValue: 0).
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 1).
	interpreterProxy failed ifTrue:[^nil].
	self matrix2x3InvertPoint: matrix.
	interpreterProxy failed ifFalse:[self roundAndStoreResultPoint: 2].! !

!Matrix2x3Plugin methodsFor: 'primitives' stamp: 'dtl 10/14/2010 23:25'!
primitiveInvertRectInto
	| matrix srcOop dstOop originX originY cornerX cornerY minX maxX minY maxY |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	<var: #originX type: 'double '>
	<var: #originY type: 'double '>
	<var: #cornerX type: 'double '>
	<var: #cornerY type: 'double '>
	<var: #minX type: 'double '>
	<var: #maxX type: 'double '>
	<var: #minY type: 'double '>
	<var: #maxY type: 'double '>

	dstOop := interpreterProxy stackObjectValue: 0.
	srcOop := interpreterProxy stackObjectValue: 1.
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 2).
	interpreterProxy failed ifTrue:[^nil].

	(interpreterProxy fetchClassOf: srcOop) = (interpreterProxy fetchClassOf: dstOop)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy isPointers: srcOop)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: srcOop) = 2
		ifFalse:[^interpreterProxy primitiveFail].

	"Load top-left point"
	self loadArgumentPoint: (interpreterProxy fetchPointer: 0 ofObject: srcOop).
	interpreterProxy failed ifTrue:[^nil].
	originX := m23ArgX.
	originY := m23ArgY.
	self matrix2x3InvertPoint: matrix.
	minX := maxX := m23ResultX.
	minY := maxY := m23ResultY.

	"Load bottom-right point"
	self loadArgumentPoint:(interpreterProxy fetchPointer: 1 ofObject: srcOop).
	interpreterProxy failed ifTrue:[^nil].
	cornerX := m23ArgX.
	cornerY := m23ArgY.
	self matrix2x3InvertPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	"Load top-right point"
	m23ArgX := cornerX.
	m23ArgY := originY.
	self matrix2x3InvertPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	"Load bottom-left point"
	m23ArgX := originX.
	m23ArgY := cornerY.
	self matrix2x3InvertPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	interpreterProxy failed ifFalse:[
		dstOop := self roundAndStoreResultRect: dstOop x0: minX y0: minY x1: maxX y1: maxY].
	interpreterProxy failed ifFalse:[
		interpreterProxy pop: 3 thenPush: dstOop
	]
! !

!Matrix2x3Plugin methodsFor: 'primitives' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 17:03'!
primitiveIsIdentity
	| matrix |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 0).
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: 1.
	interpreterProxy pushBool:(
		((matrix at: 0) = (self cCoerce: 1.0 to: 'float')) &
		((matrix at: 1) = (self cCoerce: 0.0 to: 'float')) &
		((matrix at: 2) = (self cCoerce: 0.0 to: 'float')) &
		((matrix at: 3) = (self cCoerce: 0.0 to: 'float')) &
		((matrix at: 4) = (self cCoerce: 1.0 to: 'float')) &
		((matrix at: 5) = (self cCoerce: 0.0 to: 'float'))).! !

!Matrix2x3Plugin methodsFor: 'primitives' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 17:04'!
primitiveIsPureTranslation
	| matrix |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 0).
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: 1.
	interpreterProxy pushBool:(
		((matrix at: 0) = (self cCoerce: 1.0 to: 'float')) &
		((matrix at: 1) = (self cCoerce: 0.0 to: 'float')) &
		((matrix at: 3) = (self cCoerce: 0.0 to: 'float')) &
		((matrix at: 4) = (self cCoerce: 1.0 to: 'float'))).! !

!Matrix2x3Plugin methodsFor: 'primitives' stamp: 'tpr (auto pragmas dtl 2010-09-28) 12/29/2005 17:04'!
primitiveTransformPoint
	| matrix |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	self loadArgumentPoint: (interpreterProxy stackObjectValue: 0).
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 1).
	interpreterProxy failed ifTrue:[^nil].
	self matrix2x3TransformPoint: matrix.
	self roundAndStoreResultPoint: 2.! !

!Matrix2x3Plugin methodsFor: 'primitives' stamp: 'dtl 10/14/2010 23:27'!
primitiveTransformRectInto
	| matrix srcOop dstOop originX originY cornerX cornerY minX maxX minY maxY |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	<var: #originX type: 'double '>
	<var: #originY type: 'double '>
	<var: #cornerX type: 'double '>
	<var: #cornerY type: 'double '>
	<var: #minX type: 'double '>
	<var: #maxX type: 'double '>
	<var: #minY type: 'double '>
	<var: #maxY type: 'double '>

	dstOop := interpreterProxy stackObjectValue: 0.
	srcOop := interpreterProxy stackObjectValue: 1.
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 2).
	interpreterProxy failed ifTrue:[^nil].

	(interpreterProxy fetchClassOf: srcOop) = (interpreterProxy fetchClassOf: dstOop)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy isPointers: srcOop)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: srcOop) = 2
		ifFalse:[^interpreterProxy primitiveFail].

	"Load top-left point"
	self loadArgumentPoint: (interpreterProxy fetchPointer: 0 ofObject: srcOop).
	interpreterProxy failed ifTrue:[^nil].
	originX := m23ArgX.
	originY := m23ArgY.
	self matrix2x3TransformPoint: matrix.
	minX := maxX := m23ResultX.
	minY := maxY := m23ResultY.

	"Load bottom-right point"
	self loadArgumentPoint:(interpreterProxy fetchPointer: 1 ofObject: srcOop).
	interpreterProxy failed ifTrue:[^nil].
	cornerX := m23ArgX.
	cornerY := m23ArgY.
	self matrix2x3TransformPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	"Load top-right point"
	m23ArgX := cornerX.
	m23ArgY := originY.
	self matrix2x3TransformPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	"Load bottom-left point"
	m23ArgX := originX.
	m23ArgY := cornerY.
	self matrix2x3TransformPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	dstOop := self roundAndStoreResultRect: dstOop x0: minX y0: minY x1: maxX y1: maxY.
	interpreterProxy failed ifFalse:[
		interpreterProxy pop: 3 thenPush: dstOop
	]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Matrix2x3Plugin class
	instanceVariableNames: ''!

!Matrix2x3Plugin class methodsFor: 'class initialization' stamp: 'sma 3/3/2000 12:39'!
declareCVarsIn: cg 
	cg var: #m23ResultX type: #double.
	cg var: #m23ResultY type: #double.
	cg var: #m23ArgX type: #double.
	cg var: #m23ArgY type: #double! !
