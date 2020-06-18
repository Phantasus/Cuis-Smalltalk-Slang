'From Squeak5.3 of 3 March 2020 [latest update: #19431] on 18 June 2020 at 6:14:03 pm'!
Object subclass: #InterpreterProxy
	instanceVariableNames: 'primFailCode remapBuffer stack method argumentCount bb thisSessionID osErrorCode exceptionPC'
	classVariableNames: ''
	poolDictionaries: 'VMBasicConstants'
	category: 'VMMaker-InterpreterSimulation'!
!InterpreterProxy commentStamp: 'eem 8/24/2018 15:43' prior: 0!
This class should provide the definition of what interpreter support plugins need and can have access to. Note that the proxy related files platforms - Cross - vm - sqVirtualMachine.[ch] are kept under the git tree at http://www.github.com/opensmalltalk/vm.
The main use of the class is to support the vm simulator and the RSqueak VM, which implements as many primitives as possible in Smalltalk.!


!InterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:40'!
argumentCountOf: methodPointer
	^methodPointer numArgs! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar (auto pragmas 12/08) 10/11/1998 03:01'!
arrayValueOf: oop
	<returnTypeC: 'void *'>
	self success: (self isWordsOrBytes: oop).
	^CArrayAccessor on: oop.! !

!InterpreterProxy methodsFor: 'object access' stamp: 'eem 10/18/2018 13:51'!
byteSizeOf: oop
	"Return the size of the receiver in bytes"
	^oop class isBits
		ifTrue: [oop basicSize * oop class elementSize]
		ifFalse: [(self slotSizeOf: oop) * Smalltalk wordSize]! !

!InterpreterProxy methodsFor: 'object access' stamp: 'eem 6/8/2016 10:56'!
characterObjectOf: characterCode
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^StackInterpreter objectMemoryClass characterObjectOf: characterCode! !

!InterpreterProxy methodsFor: 'object access' stamp: 'eem 10/31/2013 00:27'!
characterValueOf: aCharacter
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^aCharacter asInteger! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar (auto pragmas 12/08) 10/10/1998 21:22'!
fetchArray: fieldIndex ofObject: objectPointer
	"Fetch the instance variable at the given index of the given object. Return the address of first indexable field of resulting array object, or fail if the instance variable does not contain an indexable bytes or words object."
	"Note: May be called by translated primitive code."

	| arrayOop |
	<returnTypeC: 'void *'>
	arrayOop := self fetchPointer: fieldIndex ofObject: objectPointer.
	^ self arrayValueOf: arrayOop
! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:07'!
fetchClassOf: oop
	^oop class! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar (auto pragmas 12/08) 10/10/1998 21:21'!
fetchFloat: fieldIndex ofObject: objectPointer
	"Fetch the instance variable at the given index of the given object. Return the C double precision floating point value of that instance variable, or fail if it is not a Float."
	"Note: May be called by translated primitive code."

	| floatOop |
	<returnTypeC: 'double'>
	floatOop := self fetchPointer: fieldIndex ofObject: objectPointer.
	^ self floatValueOf: floatOop! !

!InterpreterProxy methodsFor: 'object access' stamp: 'tpr (auto pragmas 12/08) 3/15/2004 20:20'!
fetchInteger: fieldIndex ofObject: objectPointer
	"Note: May be called by translated primitive code."

	| intOop |
	<inline: false>
	intOop := self fetchPointer: fieldIndex ofObject: objectPointer.
	^self checkedIntegerValueOf: intOop! !

!InterpreterProxy methodsFor: 'object access' stamp: 'tpr 6/6/2005 19:11'!
fetchLong32: fieldIndex ofObject: oop
"fetchWord:ofObject: is rescinded as of VMMaker 3.8 64bit VM. This is the same code as used therein and may need revision for 64 bit cleanliness"
	^oop instVarAt: fieldIndex+1! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 10/10/1998 16:04'!
fetchPointer: index ofObject: oop
	^oop instVarAt: index+1! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar (auto pragmas 12/08) 9/18/1998 20:26'!
firstFixedField: oop
	<returnTypeC:'void *'>
	^CObjectAccessor on: oop! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar (auto pragmas 12/08) 10/10/1998 16:22'!
firstIndexableField: oop
	<returnTypeC:'void *'>
	^CArrayAccessor on: oop! !

!InterpreterProxy methodsFor: 'object access' stamp: 'eem 11/18/2009 15:50'!
instanceSizeOf: classObj
	^classObj instSize! !

!InterpreterProxy methodsFor: 'object access' stamp: 'eem 1/20/2016 19:03'!
isOopImmutable: oop
	<option: #IMMUTABILITY>
	^StackInterpreter objectMemoryClass isOopImmutable: oop! !

!InterpreterProxy methodsFor: 'object access' stamp: 'eem 5/23/2011 17:14'!
literal: offset ofMethod: methodPointer
	^methodPointer literalAt: offset+1! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:40'!
literalCountOf: methodPointer
	^methodPointer numLiterals! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 10/7/1998 18:43'!
methodArgumentCount
	^argumentCount! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 10/7/1998 18:43'!
methodPrimitiveIndex
	^method primitive! !

!InterpreterProxy methodsFor: 'object access' stamp: 'tpr 6/6/2005 19:28'!
obsoleteDontUseThisFetchWord: fieldIndex ofObject: oop
"fetchWord:ofObject: is rescinded as of VMMaker 3.8 64bit VM. This is a placeholder to sit in the sqVirtualMachine structure to support older plugins for a while"
	self halt: 'deprecated method'! !

!InterpreterProxy methodsFor: 'object access' stamp: 'eem 10/31/2013 00:29'!
pinObject: anObject
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^self shouldBeImplemented! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:39'!
primitiveIndexOf: methodPointer
	^methodPointer primitive! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 11/28/1999 17:43'!
primitiveMethod
	"Return the method an external primitive was defined in"
	^method! !

!InterpreterProxy methodsFor: 'object access' stamp: 'tpr (auto pragmas 12/08) 12/29/2005 16:35'!
sizeOfSTArrayFromCPrimitive: cPtr
	"Note: Only called by translated primitive code."
	<var: #cPtr type: 'void *'>
	^self shouldNotImplement! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 10/7/1998 18:24'!
slotSizeOf: oop
	"Returns the number of slots in the receiver.
	If the receiver is a byte object, return the number of bytes.
	Otherwise return the number of words."
	^(oop basicSize) + (oop class instSize)! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:53'!
stObject: array at: index
	^array at: index! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:53'!
stObject: array at: index put: value
	^array at: index put: value! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 10/7/1998 18:26'!
stSizeOf: oop
	"Return the number of indexable fields in the receiver"
	^oop basicSize! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 10/25/1998 16:16'!
storeInteger: index ofObject: oop withValue: integer
	(self isIntegerValue: integer) 
		ifTrue:[^self storePointer: index ofObject: oop withValue: integer]
		ifFalse:[^self primitiveFail]! !

!InterpreterProxy methodsFor: 'object access' stamp: 'ar 10/10/1998 21:25'!
storePointer: index ofObject: oop withValue: valuePointer
	^oop instVarAt: index+1 put: valuePointer! !

!InterpreterProxy methodsFor: 'object access' stamp: 'eem 7/28/2014 07:12'!
unpinObject: anObject
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^self shouldBeImplemented! !


!InterpreterProxy methodsFor: 'other' stamp: 'eem 1/5/2018 00:02'!
become: array1 with: array2
	<returnTypeC: #sqInt>
	array1 elementsExchangeIdentityWith: array2! !

!InterpreterProxy methodsFor: 'other' stamp: 'nice 4/5/2016 23:19'!
byteSwapped32IfBigEndian: anInteger
	"Note: for simulation only.
	This message is not generated in C but replaced with a macro"
	<doNotGenerate>
	self vmEndianness = 1 ifTrue: [^anInteger byteSwap32].
	^anInteger! !

!InterpreterProxy methodsFor: 'other' stamp: 'nice 4/5/2016 23:19'!
byteSwapped64IfBigEndian: anInteger
	"Note: for simulation only.
	This message is not generated in C but replaced with a macro"
	<doNotGenerate>
	self vmEndianness = 1 ifTrue: [^anInteger byteSwap64].
	^anInteger! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 11/1/2007 16:05'!
failed

	^primFailCode ~= 0! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 1/5/2018 00:03'!
fullDisplayUpdate
	<returnTypeC: #sqInt>
	Display display! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 2/16/2015 14:04'!
fullGC
	<returnTypeC: #sqInt>
	Smalltalk garbageCollect! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 1/23/2013 15:53'!
getInterruptPending
	^self notYetImplementedError! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 1/23/2013 15:53'!
getStackPointer
	<returnTypeC: #'sqInt *'>
	^self notYetImplementedError! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 1/15/2018 14:04'!
getThisSessionID
	"Answer a session identifier which represents the current instance of Squeak.
	The identifier is expected to be unique among all instances of Squeak on a
	network at any point in time."

	[thisSessionID = 0]
		whileTrue:
			[thisSessionID := (Random new next * (SmallInteger maxVal min: 16rFFFFFFFF)) asInteger].
	^ thisSessionID! !

!InterpreterProxy methodsFor: 'other' stamp: 'ar 9/16/1998 20:52'!
incrementalGC
	Smalltalk garbageCollectMost.! !

!InterpreterProxy methodsFor: 'other' stamp: 'ar 5/13/2000 14:55'!
ioMicroMSecs
	^Time millisecondClockValue! !

!InterpreterProxy methodsFor: 'other' stamp: 'tfel 2/11/2016 09:03'!
majorVersion
	^ 1! !

!InterpreterProxy methodsFor: 'other' stamp: 'tfel 2/11/2016 09:03'!
minorVersion
	^ 8! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 10/30/2013 14:08'!
primitiveFail
	<returnTypeC: #sqInt>
	"Set general (unspecified) primitive failure."
	self primitiveFailFor: 1! !

!InterpreterProxy methodsFor: 'other' stamp: 'tfel 4/30/2015 07:54'!
primitiveFailFor: reasonCode
	"Set specific primitive failure.
	N.B. primitiveFailFor: PrimNoErr is expected to clear the primFailCode.
	Primitive 255 is called to indicate that we are currently simulating a primitive that should fail and the VM should handle that case appropriately (if supported by the VM)."
	<primitive: 255>
	^ primFailCode := reasonCode! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 12/18/2018 17:42'!
primitiveFailForFFIException: exceptionCode at: pc
	<var: 'exceptionCode' type: #usqLong>
	<var: 'pc' type: #usqInt>
	<option: #(atLeastVMProxyMajor:minor: 1 14)>
	"Set PrimErrFFIException primitive failure and associated exceptionCode (a.k.a. 
	 osErrorCode) and exceptionPC."
	<primitive: 255>
	osErrorCode := exceptionCode.
	exceptionPC := pc.
	^primFailCode := PrimErrFFIException! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 12/18/2018 17:42'!
primitiveFailForOSError: osError
	<var: 'osError' type: #sqLong>
	<option: #(atLeastVMProxyMajor:minor: 1 14)>
	"Set PrimErrOSError primitive failure and associated osErrorCode.
	 Primitive 255 is called to indicate that we are currently simulating a primitive that should fail and the VM should handle that case appropriately (if supported by the VM)."
	<primitive: 255>
	osErrorCode := osError.
	^primFailCode := PrimErrOSError! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 11/25/2009 10:39'!
primitiveFailureCode
	^primFailCode! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 4/10/2020 15:28'!
setInterruptCheckChain: aFunction
	<returnTypeC: #'void *'>
	<var: #aFunction declareC: 'void (*aFunction)()'>
	^self notYetImplementedError! !

!InterpreterProxy methodsFor: 'other' stamp: 'tfel 3/3/2016 17:06'!
showDisplayBits: aForm Left: l Top: t Right: r Bottom: b
	aForm == Display ifTrue:[
		Display class isDeferringUpdates ifTrue: [^ nil].
		Display forceToScreen: (Rectangle left: l right: r top: t bottom: b)].! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 2/16/2015 14:02'!
signalSemaphoreWithIndex: semaIndex
	<returnTypeC: #sqInt>
	((Smalltalk externalObjects) at: semaIndex) signal! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 12/18/2018 17:41'!
statNumGCs
	<option: #(atLeastVMProxyMajor:minor: 1 14)>
	^(Smalltalk vmParameterAt: 7 "statFullGCs") + (Smalltalk vmParameterAt: 9 "statScavenges/statIncrGCs")! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 2/16/2015 13:59'!
success: aBoolean
	<returnTypeC: #sqInt>
	aBoolean ifTrue: [^self].
	primFailCode = 0 ifTrue: [self primitiveFailFor: 1]! !

!InterpreterProxy methodsFor: 'other' stamp: 'ar 9/16/1998 20:51'!
superclassOf: classPointer
	^classPointer superclass! !

!InterpreterProxy methodsFor: 'other' stamp: 'eem 7/10/2015 13:51'!
tenuringIncrementalGC
	<returnTypeC: #void>
	Smalltalk forceTenuring; garbageCollectMost! !

!InterpreterProxy methodsFor: 'other' stamp: 'tpr 12/22/2005 17:48'!
vmEndianness
	"return 0 for little endian, 1 for big endian"
	^SmalltalkImage current endianness =#big ifTrue:[1] ifFalse:[0]! !


!InterpreterProxy methodsFor: 'converting' stamp: 'ar 10/10/1998 21:27'!
booleanValueOf: obj
	obj == true ifTrue:[^true].
	obj == false ifTrue:[^false].
	self primitiveFail.
	^nil! !

!InterpreterProxy methodsFor: 'converting' stamp: 'ar 10/4/1998 15:47'!
checkedIntegerValueOf: intOop
	(self isIntegerObject: intOop)
		ifTrue:[^self integerValueOf: intOop]
		ifFalse:[self primitiveFail. ^0].! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 3/16/2018 14:13'!
floatObjectOf: aFloat
	<returnTypeC: #sqInt> "...because answering the float argument causes the type inferencer to say this answers a float."
	<var: #aFloat type: #double>
	aFloat isFloat ifFalse: [self error:'Not a float object'].
	^aFloat! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 11/14/2019 13:43'!
floatValueOf: oop
	<returnTypeC: #double>
	oop isFloat
		ifTrue:[^oop]
		ifFalse:[self primitiveFail. ^0.0].! !

!InterpreterProxy methodsFor: 'converting' stamp: 'ar 10/10/1998 16:13'!
integerObjectOf: value
	value class == SmallInteger ifFalse:[self error:'Not a SmallInteger object'].
	^value! !

!InterpreterProxy methodsFor: 'converting' stamp: 'ar 10/10/1998 16:10'!
integerValueOf: oop
	oop class == SmallInteger ifFalse:[self error:'Not a SmallInteger'].
	^oop! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 12/6/2012 16:01'!
ioFilename: aCharBuffer fromString: aFilenameString ofLength: filenameLength resolveAliases: aBoolean
	<var: #aCharBuffer type: #'char *'>
	<var: #aFilenameString type: #'char *'>
	"the vm has to convert aFilenameString via any canonicalization and char-mapping and put the result in aCharBuffer. This doesn't translate well in Smalltalk since we know how long strings are rather than considering them terminated by a 0 char. Do the best we can.
Note the resolveAliases flag - this is an awful artefact of OSX and Apples demented alias handling. When opening a file, the flag must be  true, when closing or renaming it must be false. Sigh."
	aCharBuffer replaceFrom:1 to: filenameLength with: aFilenameString! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 1/3/2018 15:40'!
positive32BitIntegerFor: integerValue
	<returnTypeC: #sqInt>
	<var: 'integerValue' type: #'unsigned int'>
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue > 0
		ifTrue:[integerValue]
		ifFalse:[ (1 bitShift: 32) + integerValue]! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 6/28/2014 19:12'!
positive32BitValueOf: oop
	<returnTypeC: #usqInt>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	oop < 0 
		ifTrue:[self primitiveFail. ^0]
		ifFalse:[^oop]! !

!InterpreterProxy methodsFor: 'converting' stamp: 'nice 3/5/2015 00:05'!
positive64BitIntegerFor: integerValue
	<api>
	<returnTypeC: #sqInt> "...because answering the 64-bit argument causes the type inferencer to say this answers 64-bits."
	<var: 'integerValue' type: #usqLong>
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue > 0
		ifTrue:[integerValue]
		ifFalse:[ (1 bitShift: 64) + integerValue]! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 6/28/2014 19:12'!
positive64BitValueOf: oop
	<returnTypeC: #usqLong>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	oop < 0 
		ifTrue:[self primitiveFail. ^0]
		ifFalse:[^oop]! !

!InterpreterProxy methodsFor: 'converting' stamp: 'nice 7/8/2016 01:56'!
positiveMachineIntegerValueOf: oop
	<returnTypeC: #'usqIntptr_t'>
	oop isInteger ifFalse:[self error: 'Not an integer object'].
	^oop < 0 
		ifTrue: [self primitiveFail. 0]
		ifFalse: [oop]! !

!InterpreterProxy methodsFor: 'converting' stamp: 'ar 11/29/1999 22:01'!
signed32BitIntegerFor: integerValue
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 12/7/2012 11:29'!
signed32BitValueOf: oop
	<returnTypeC: #int>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 1/9/2014 14:02'!
signed64BitIntegerFor: integerValue
	<returnTypeC: #sqInt> "...because answering the 64-bit argument causes the type inferencer to say this answers 64-bits."
	<var: 'integerValue' type: #sqLong>
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue! !

!InterpreterProxy methodsFor: 'converting' stamp: 'eem 12/6/2012 16:04'!
signed64BitValueOf: oop
	<returnTypeC: #sqLong>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop! !

!InterpreterProxy methodsFor: 'converting' stamp: 'nice 7/13/2016 09:44'!
signedMachineIntegerValueOf: oop
	<returnTypeC: #'sqIntptr_t'>
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop! !


!InterpreterProxy methodsFor: 'private' stamp: 'ar 9/18/1998 21:11'!
byteAt: accessor
	^accessor byteAt: 0! !

!InterpreterProxy methodsFor: 'private' stamp: 'ar 9/18/1998 21:12'!
byteAt: accessor put: value
	^accessor byteAt: 0 put: value! !

!InterpreterProxy methodsFor: 'private' stamp: 'tfel 3/3/2016 15:41'!
byteAtPointer: accessor
	^ self byteAt: accessor! !

!InterpreterProxy methodsFor: 'private' stamp: 'ar 10/27/1999 14:13'!
fetchIntegerOrTruncFloat: fieldIndex ofObject: objectPointer
	"Support for BitBlt simulation only"
	| intOrFloat |
	intOrFloat := self fetchPointer: fieldIndex ofObject: objectPointer.
	(self isIntegerObject: intOrFloat) ifTrue: [^ self integerValueOf: intOrFloat].
	intOrFloat isFloat ifTrue:[^intOrFloat truncated].
	^self primitiveFail.! !

!InterpreterProxy methodsFor: 'private' stamp: 'ar 10/27/1999 14:21'!
isInterpreterProxy
	"Return true since I am not a real Interpreter simulation"
	^true! !

!InterpreterProxy methodsFor: 'private' stamp: 'tfel 2/23/2016 18:34'!
long32At: arrayOffset

	^ arrayOffset long32At: 0
! !

!InterpreterProxy methodsFor: 'private' stamp: 'ar 9/18/1998 21:11'!
longAt: accessor
	^accessor longAt: 0! !

!InterpreterProxy methodsFor: 'private' stamp: 'ar 9/18/1998 21:11'!
longAt: accessor put: value
	^accessor longAt: 0 put: value! !

!InterpreterProxy methodsFor: 'private' stamp: 'eem 1/23/2013 15:53'!
notYetImplementedError
	^self error: 'not yet implemented in Smalltalk'! !

!InterpreterProxy methodsFor: 'private' stamp: 'eem 3/16/2018 14:12'!
pop: nItems thenPushBool: boolean
	<returnTypeC: #sqInt>
	self pop: nItems.
	self push: (boolean ifTrue: [self trueObject] ifFalse: [self falseObject])! !

!InterpreterProxy methodsFor: 'private' stamp: 'eem 3/16/2018 14:12'!
pop: nItems thenPushFloat: float
	<var: #float type: #double>
	<returnTypeC: #sqInt>
	self pop: nItems.
	self push: (self floatObjectOf: float)! !

!InterpreterProxy methodsFor: 'private' stamp: 'eem 3/16/2018 14:14'!
pop: nItems thenPushInteger: integer
	<returnTypeC: #sqInt>
	self pop: nItems.
	self push: (self integerObjectOf: integer)! !


!InterpreterProxy methodsFor: 'testing' stamp: 'eem 3/17/2017 11:11'!
cStringOrNullFor: oop
	"Answer either a malloced string with the null-terminated contents of oop if oop is a string,
	 or the null pointer if oop is nil, or fail.  It is the client's responsibility to free the string later."
	<returnTypeC: #'char *'>
	oop isString ifTrue: [^oop] ifFalse: [self primitiveFail. ^0]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'ar 11/17/1999 22:04'!
includesBehavior: aClass ThatOf: aSuperclass
	^aClass includesBehavior: aSuperclass! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 9/18/2018 15:43'!
is: oop KindOf: aString
	"InterpreterProxy new is: 42 KindOf: 'Number'"
	<var: #aString type: 'char *'>
	<returnTypeC: #sqInt>
	(Smalltalk at: aString asSymbol ifAbsent:[nil])
		ifNil:[false]
		ifNotNil: [:theClass| oop isKindOf: theClass]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 10/28/2009 15:12'!
is: oop KindOfClass: aClass
	"InterpreterProxy new is: 42 KindOfClass: Number"
	^oop isKindOf: aClass! !

!InterpreterProxy methodsFor: 'testing' stamp: 'tpr (auto pragmas 12/08) 12/29/2005 16:35'!
is: oop MemberOf: aString
	"InterpreterProxy new is: 42 MemberOf:'SmallInteger'"
	| theClass |
	<var: #aString type:'char *'>
	theClass := Smalltalk at: aString asSymbol ifAbsent:[nil].
	^theClass isNil
		ifTrue:[false]
		ifFalse:[^oop isMemberOf: theClass]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 1/30/2014 16:06'!
isArray: oop
	^(self isNonImmediate: oop) and: [oop class instSpec = 2]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 12/18/2018 17:45'!
isBooleanObject: oop
	<option: #(atLeastVMProxyMajor:minor: 1 15)>
	^oop == true or: [oop == false]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:04'!
isBytes: oop
	^oop class isBytes! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 10/31/2013 00:27'!
isCharacterObject: oop
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^oop isCharacter! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 10/31/2013 00:27'!
isCharacterValue: anInteger
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^(self isIntegerValue: anInteger) and: [anInteger >= 0]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 11/20/2014 17:56'!
isFloatObject: oop
	^oop isFloat! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 10/31/2013 00:27'!
isImmediate: anObject
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^StackInterpreter objectMemoryClass isImmediate: anObject! !

!InterpreterProxy methodsFor: 'testing' stamp: 'acg 9/19/1999 13:11'!
isIndexable: oop
	^oop class isVariable! !

!InterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:12'!
isIntegerObject: objectPointer
	^objectPointer class == SmallInteger! !

!InterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:13'!
isIntegerValue: intValue
	^intValue class == SmallInteger! !

!InterpreterProxy methodsFor: 'testing' stamp: 'nice 4/18/2016 23:17'!
isKindOfInteger: objectOrientedPointer
	^objectOrientedPointer isInteger! !

!InterpreterProxy methodsFor: 'testing' stamp: 'nice 4/18/2016 23:37'!
isLargeIntegerObject: objectOrientedPointer
	^objectOrientedPointer isKindOf: LargePositiveInteger! !

!InterpreterProxy methodsFor: 'testing' stamp: 'nice 4/19/2016 21:45'!
isLargeNegativeIntegerObject: objectOrientedPointer
	^objectOrientedPointer isMemberOf: LargeNegativeInteger! !

!InterpreterProxy methodsFor: 'testing' stamp: 'nice 4/19/2016 21:44'!
isLargePositiveIntegerObject: objectOrientedPointer
	^objectOrientedPointer isMemberOf: LargePositiveInteger! !

!InterpreterProxy methodsFor: 'testing' stamp: 'tfel 2/11/2016 09:17'!
isNonImmediate: anObject

	^ (self isImmediate: anObject) not! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 1/23/2013 15:54'!
isOopMutable: anOop
	<api>
	^self notYetImplementedError! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 10/31/2013 00:28'!
isPinned: anObject
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^self shouldBeImplemented! !

!InterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:04'!
isPointers: oop
	^oop class isPointers! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 12/18/2018 17:40'!
isPositiveMachineIntegerObject: oop
	<option: #(atLeastVMProxyMajor:minor: 1 15)>
	^oop isInteger and: [oop >= 0 and: [oop digitLength <= Smalltalk wordSize]]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:16'!
isWeak: oop
	^oop class isWeak! !

!InterpreterProxy methodsFor: 'testing' stamp: 'ar 10/9/1998 22:19'!
isWords: oop
	^oop class isPointers not and:[oop class isBytes not]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:05'!
isWordsOrBytes: oop
	^(self isBytes: oop) or:[self isWords: oop]! !

!InterpreterProxy methodsFor: 'testing' stamp: 'eem 12/18/2018 17:42'!
stringForCString: aCString
	"Answer a ByteString object containing the bytes (possibly UTF-8?) in the null-terminated C string aCString."
	<option: #(atLeastVMProxyMajor:minor: 1 14)>
	<returnTypeC: #sqInt>
	<var: #aCString type: #'char *'>
	self notYetImplemented! !


!InterpreterProxy methodsFor: 'callback support' stamp: 'eem 1/23/2013 15:53'!
callbackEnter: callbackID
	"Re-enter the interpreter for executing a callback"
	<var: #callbackID type: #'sqInt *'>
	^self notYetImplementedError! !

!InterpreterProxy methodsFor: 'callback support' stamp: 'eem 5/19/2015 14:08'!
callbackLeave: cbID
	"Leave from a previous callback"
	^self notYetImplementedError! !

!InterpreterProxy methodsFor: 'callback support' stamp: 'eem 1/5/2018 00:01'!
reestablishContextPriorToCallback: callbackContext
	"callbackContext is an activation of invokeCallback:stack:registers:jmpbuf:.  Its sender
	is the interpreter's state prior to the callback.  Reestablish that state."
	<returnTypeC: #sqInt>
	self notYetImplemented! !

!InterpreterProxy methodsFor: 'callback support' stamp: 'eem 2/16/2015 14:03'!
returnAs: returnTypeOop ThroughCallback: vmCallbackContext Context: callbackMethodContext
	<returnTypeC: #sqInt>
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	"callbackMethodContext is an activation of invokeCallback:[stack:registers:jmpbuf:].
	 Its sender is the VM's state prior to the callback.  Reestablish that state (via longjmp),
	 and mark callbackMethodContext as dead."
	self notYetImplemented! !

!InterpreterProxy methodsFor: 'callback support' stamp: 'eem 1/5/2018 00:01'!
sendInvokeCallback: thunkPtr Stack: stackPtr Registers: regsPtr Jmpbuf: jmpBufPtr
	"Send the 4 argument callback message invokeCallback:stack:registers:jmpbuf:
	 to Alien class with the supplied args.  The arguments are raw C addresses
	 and are converted to integer objects on the way."
	<returnTypeC: #sqInt>
	self notYetImplemented! !

!InterpreterProxy methodsFor: 'callback support' stamp: 'eem 1/5/2018 00:01'!
sendInvokeCallbackContext: vmCallbackContext
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	"Send the calllback message to Alien class with the supplied arg(s).  Use either the
	 1 arg invokeCallbackContext: or the 4 arg invokeCallback:stack:registers:jmpbuf:
	 message, depending on what selector is installed in the specialObjectsArray.
	 Note that if invoking the legacy invokeCallback:stack:registers:jmpbuf: we pass the
	 vmCallbackContext as the jmpbuf argument (see reestablishContextPriorToCallback:).
	 The arguments are raw C addresses and are converted to integer objects on the way."
	<returnTypeC: #sqInt>
	self notYetImplemented! !

!InterpreterProxy methodsFor: 'callback support' stamp: 'eem 1/23/2013 15:54'!
signalNoResume: aSemaphore
	^self notYetImplementedError! !


!InterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 21:43'!
characterTable
	^Character characterTable! !

!InterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 21:42'!
displayObject
	^Display! !

!InterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 20:40'!
falseObject
	^false! !

!InterpreterProxy methodsFor: 'special objects' stamp: 'eem 3/14/2014 16:45'!
getDeferDisplayUpdates
	^false! !

!InterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 20:40'!
nilObject
	^nil! !

!InterpreterProxy methodsFor: 'special objects' stamp: 'eem 10/29/2009 10:51'!
primitiveErrorTable
	^Smalltalk primitiveErrorTable! !

!InterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 20:41'!
trueObject
	^true! !


!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 11/26/2007 17:47'!
classAlien
        ^Smalltalk at: #Alien ifAbsent: [nil]! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:03'!
classExternalAddress
	^Smalltalk at: #ExternalAddress ifAbsent:[nil]! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:03'!
classExternalData
	^Smalltalk at: #ExternalData ifAbsent:[nil]! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:03'!
classExternalFunction
	^Smalltalk at: #ExternalFunction ifAbsent:[nil]! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:04'!
classExternalLibrary
	^Smalltalk at: #ExternalLibrary ifAbsent:[nil]! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:04'!
classExternalStructure
	^Smalltalk at: #ExternalStructure ifAbsent:[nil]! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 4/18/2008 15:17'!
classUnsafeAlien
        ^Smalltalk at: #UnsafeAlien ifAbsent: [nil]! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 1/23/2013 15:53'!
disownVM: flags
	^self notYetImplementedError! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 12/7/2012 14:18'!
ioLoadFunction: functionName From: moduleName
	<returnTypeC: #'void *'>
	<var: #functionName type: #'char *'>
	<var: #moduleName type: #'char *'>
	"Dummy - provided by support code"
	^0! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 1/16/2018 10:35'!
ioLoadFunction: functionName From: moduleName AccessorDepthInto: accessorDepthPtr
	<returnTypeC: #'void *'>
	<var: #functionName type: #'char *'>
	<var: #moduleName type: #'char *'>
	<var: #accessorDepthPtr type: #'sqInt *'>
	"Dummy - provided by support code"
	^0! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 12/7/2012 14:18'!
ioLoadModule: moduleNameIndex OfLength: moduleLength
	<returnTypeC: #'void *'>
	"Dummy - provided by support code"
	^0! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 12/7/2012 14:19'!
ioLoadSymbol: functionNameIndex OfLength: functionLength FromModule: moduleHandle
	<returnTypeC: #'void *'>
	"Dummy - provided by support code"
	^0! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/28/1999 19:04'!
isInMemory: address
	"Return true if the given address is in ST object memory"
	^true! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 1/23/2013 15:54'!
isYoung: anOop
	^self notYetImplementedError! !

!InterpreterProxy methodsFor: 'FFI support' stamp: 'eem 1/23/2013 15:53'!
ownVM: flags
	^self notYetImplementedError! !


!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:42'!
classArray
	^Array! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classBitmap
	^Bitmap! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classByteArray
	^ByteArray! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classCharacter
	^Character! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:10'!
classDoubleByteArray
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #DoubleByteArray ifAbsent: [nil]! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:10'!
classDoubleWordArray
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #DoubleWordArray ifAbsent: [nil]! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classFloat
	^Float! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:15'!
classFloat32Array
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #FloatArray ifAbsent: [nil]! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:15'!
classFloat64Array
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #Float64Array ifAbsent: [nil]! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 11/19/1999 14:29'!
classLargeNegativeInteger
	^LargeNegativeInteger! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classLargePositiveInteger
	^LargePositiveInteger! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classPoint
	^Point! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classSemaphore
	^Semaphore! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 21:43'!
classSmallInteger
	^SmallInteger! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'eem 10/7/2010 12:26'!
classString
	^ByteString! !

!InterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:10'!
classWordArray
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #WordArray ifAbsent: [nil]! !


!InterpreterProxy methodsFor: 'instance creation' stamp: 'dtl 2/14/2014 19:32'!
clone: oop
	^oop shallowCopy! !

!InterpreterProxy methodsFor: 'instance creation' stamp: 'ar 9/16/1998 01:11'!
instantiateClass: classPointer indexableSize: size
	^size = 0 
		ifTrue:[classPointer basicNew]
		ifFalse:[classPointer basicNew: size]! !

!InterpreterProxy methodsFor: 'instance creation' stamp: 'ar 10/10/1998 16:14'!
makePointwithxValue: xValue yValue: yValue
	(xValue class == SmallInteger and:[yValue class == SmallInteger]) 
		ifFalse:[self error:'Not SmallInteger objects'].
	^xValue@yValue! !

!InterpreterProxy methodsFor: 'instance creation' stamp: 'ar 9/16/1998 01:14'!
popRemappableOop
	^remapBuffer removeLast! !

!InterpreterProxy methodsFor: 'instance creation' stamp: 'eem 2/16/2015 13:57'!
pushRemappableOop: oop
	<returnTypeC: #sqInt>
	remapBuffer addLast: oop! !

!InterpreterProxy methodsFor: 'instance creation' stamp: 'ar 3/6/2009 11:09'!
topRemappableOop
	"Returns the top of the remappable oop. Useful when writing loops."
	^remapBuffer last! !


!InterpreterProxy methodsFor: 'BitBlt support' stamp: 'eem 1/4/2018 23:59'!
copyBits
	<returnTypeC: #sqInt>
	bb copyBits! !

!InterpreterProxy methodsFor: 'BitBlt support' stamp: 'eem 1/4/2018 23:59'!
copyBitsFrom: leftX to: rightX at: yValue
	<returnTypeC: #sqInt>
	bb copyBitsFrom: leftX to: rightX at: yValue.! !

!InterpreterProxy methodsFor: 'BitBlt support' stamp: 'eem 1/5/2018 00:04'!
loadBitBltFrom: bbOop
	<returnTypeC: #sqInt>
	bb := bbOop! !


!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:32'!
floatArg: offset
	"Like #stackFloatValue: but access method arguments left-to-right"
	"Obsolete; was never used; replaced with methodReturnString: in the VirtualMachine struct."
	| oop |
	<returnTypeC: #double>
	self deprecated.
	oop := self methodArg: offset.
	(self isFloatObject: oop) ifFalse: [self primitiveFail. ^0.0].
	^oop! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:32'!
integerArg: offset
	"Like #stackIntegerValue: but access method arguments left-to-right"
	"Obsolete; was never used; replaced with methodReturnInteger: in the VirtualMachine struct."
	| oop |
	self deprecated.
	oop := self methodArg: offset.
	(self isIntegerObject: oop) ifFalse: [self primitiveFail. ^0].
	^oop! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:35'!
methodArg: offset
	"Like #stackValue: but access method arguments left-to-right"
	"Obsolete; was never used; replaced with methodReturnBool: in the VirtualMachine struct."
	self deprecated.
	offset > argumentCount + 1 ifTrue:[^self primitiveFail].
	^self stackValue: argumentCount - offset! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 03/16/2018 14:10'!
methodReturnBool: boolean
	"Sets the return value for a method"
	self pop: argumentCount+1 thenPushBool: boolean.
	^0! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:22'!
methodReturnFloat: aFloat
	"Sets the return value for a method"
	<var: 'aFloat' type: #double>
	self pop: argumentCount+1 thenPushFloat: aFloat.
	^0! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 03/16/2018 14:10'!
methodReturnInteger: integer
	"Sets the return value for a method"
	self pop: argumentCount+1 thenPushInteger: integer.
	^0! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'ul 4/17/2018 16:02'!
methodReturnReceiver
	"Sets the return value for a method"
	self pop: argumentCount.
	^0! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 7/24/2019 12:28'!
methodReturnString: aCString
	"Attempt to answer a ByteString for a given C string as the result of a primitive."
	<var: 'aCString' type: #'char *'>
	aCString
		ifNil: [primFailCode := PrimErrOperationFailed]
		ifNotNil:
			[(self stringForCString: aCString)
				ifNil: [primFailCode := PrimErrNoMemory]
				ifNotNil: [:result| self pop: argumentCount+1 thenPush: result]].
	^0! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 11/7/2009 11:13'!
methodReturnValue: oop
	"Sets the return value for a method"
	self pop: argumentCount+1 thenPush: oop.
	^0! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:34'!
objectArg: offset
	"Like #stackObjectValue: but access method arguments left-to-right"
	"Obsolete; was never used; replaced with methodReturnFloat: in the VirtualMachine struct."
	| oop |
	self deprecated.
	oop := self methodArg: offset.
	(self isImmediate: oop) ifTrue: [self primitiveFail. ^ nil].
	^oop! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 2/16/2015 13:56'!
pop: nItems
	<returnTypeC: #sqInt>
	1 to: nItems do:[:i| stack removeLast].! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 2/16/2015 13:57'!
pop: nItems thenPush: oop
	<returnTypeC: #sqInt>
	self pop: nItems.
	self push: oop! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 2/16/2015 14:00'!
push: object
	<returnTypeC: #sqInt>
	stack addLast: object! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 2/16/2015 13:57'!
pushBool: trueOrFalse
	<returnTypeC: #sqInt>
	(trueOrFalse == true or:[trueOrFalse == false]) ifFalse:[self error:'Not a Boolean'].
	self push: trueOrFalse! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 2/16/2015 14:07'!
pushFloat: f
	<returnTypeC: #sqInt>
	<var: #f type: 'double '>
	f isFloat ifFalse:[^self error:'Not a Float'].
	self push: f.! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 2/16/2015 13:57'!
pushInteger: integerValue
	<returnTypeC: #sqInt>
	self push: (self integerObjectOf: integerValue).! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'ar (auto pragmas 12/08) 9/27/1998 15:22'!
stackFloatValue: offset
	| oop |
	<returnTypeC: 'double'>
	oop := self stackValue: offset.
	(self isFloatObject: oop) ifFalse: [self primitiveFail. ^0.0].
	^oop! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'ar 9/16/1998 22:07'!
stackIntegerValue: offset
	| oop |
	oop := self stackValue: offset.
	(self isIntegerObject: oop) ifFalse: [self primitiveFail. ^0].
	^oop! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'eem 1/30/2014 12:37'!
stackObjectValue: offset
	| oop |
	oop := self stackValue: offset.
	(self isImmediate: oop) ifTrue: [self primitiveFail. ^ nil].
	^oop! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'nice 7/13/2016 09:58'!
stackPositiveMachineIntegerValue: offset
	<returnTypeC: #'usqIntptr_t'>
	^self positiveMachineIntegerValueOf: (self stackValue: offset)! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'nice 7/22/2016 00:48'!
stackSignedMachineIntegerValue: offset
	<returnTypeC: #'sqIntptr_t'>
	^self signedMachineIntegerValueOf: (self stackValue: offset)! !

!InterpreterProxy methodsFor: 'stack access' stamp: 'ar 9/16/1998 11:47'!
stackValue: offset
	^stack at: stack size - offset.! !


!InterpreterProxy methodsFor: 'initialize' stamp: 'eem 11/1/2007 16:05'!
initialize
	primFailCode := 0.
	remapBuffer := OrderedCollection new.
	stack := OrderedCollection new.! !

!InterpreterProxy methodsFor: 'initialize' stamp: 'ar 10/3/1998 18:50'!
loadStackFrom: aContext
	self push: aContext receiver.
	method := aContext method.
	argumentCount := method numArgs.
	1 to: argumentCount do:[:i| self push: (aContext at: i) ].! !

!InterpreterProxy methodsFor: 'initialize' stamp: 'tfel 3/30/2015 16:13'!
synthesizeStackFor: receiver with: args
	<doNotGenerate>
	self push: receiver.
	argumentCount := args size.
	1 to: argumentCount do: [:i | self push: (args at: i)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

InterpreterProxy class
	instanceVariableNames: ''!

!InterpreterProxy class methodsFor: 'translation' stamp: 'eem 12/6/2012 15:49'!
implicitReturnTypeFor: aSelector
	"Answer the return type for methods that don't have an explicit return."
	^#sqInt! !


!InterpreterProxy class methodsFor: 'private' stamp: 'tpr 12/22/2005 17:13'!
validateProxyImplementation: anInterpreter 
	"InterpreterProxy validateProxyImplementation: Interpreter"

	| proxyClass catList |
	proxyClass := InterpreterProxy.
	catList := proxyClass organization categories copy asOrderedCollection.
	catList remove: 'initialize' ifAbsent:[].
	catList remove: 'private' ifAbsent:[].
	catList do:[:categ|
		(proxyClass organization listAtCategoryNamed: categ) do:[:selector|
			(anInterpreter canUnderstand: selector) 
				ifFalse:
					[self notifyWithLabel: selector, ' is not implemented in ', anInterpreter name]]]! !
