'From Cuis 5.0 [latest update: #4191] on 20 June 2020 at 6:56:19 pm'!
'Description Slang based plugin maker for the OpenSmalltalk-VM (OSVM) on which Squeak, Pharo, Cuis, Newspeak implementations are currently running. 

License: MIT'!
!provides: 'OSVMPluginMaker' 1 8!
!requires: 'Slang-C' 1 19 nil!
SystemOrganization addCategory: #OSVMPluginMaker!


!classDefinition: #OSVMBasicConstants category: #OSVMPluginMaker!
SharedPool subclass: #OSVMBasicConstants
	instanceVariableNames: ''
	classVariableNames: 'IMMUTABILITY PrimErrFFIException PrimErrNoMemory PrimErrOSError PrimErrOperationFailed PrimNoErr'
	poolDictionaries: ''
	category: 'OSVMPluginMaker'!
!classDefinition: 'OSVMBasicConstants class' category: #OSVMPluginMaker!
OSVMBasicConstants class
	instanceVariableNames: ''!

!classDefinition: #OSVMPlugin category: #OSVMPluginMaker!
SlangPlugin subclass: #OSVMPlugin
	instanceVariableNames: 'interpreterProxy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'OSVMPluginMaker'!
!classDefinition: 'OSVMPlugin class' category: #OSVMPluginMaker!
OSVMPlugin class
	instanceVariableNames: ''!

!classDefinition: #OSVMPluginHeaderBuilder category: #OSVMPluginMaker!
SlangObject subclass: #OSVMPluginHeaderBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'OSVMPluginMaker'!
!classDefinition: 'OSVMPluginHeaderBuilder class' category: #OSVMPluginMaker!
OSVMPluginHeaderBuilder class
	instanceVariableNames: ''!

!classDefinition: #OSVMInterpreterProxy category: #OSVMPluginMaker!
Object subclass: #OSVMInterpreterProxy
	instanceVariableNames: 'primFailCode remapBuffer stack method argumentCount bb thisSessionID osErrorCode exceptionPC'
	classVariableNames: ''
	poolDictionaries: 'OSVMBasicConstants'
	category: 'OSVMPluginMaker'!
!classDefinition: 'OSVMInterpreterProxy class' category: #OSVMPluginMaker!
OSVMInterpreterProxy class
	instanceVariableNames: ''!


!OSVMBasicConstants commentStamp: '<historical>' prior: 0!
I am a shared pool for basic constants upon which the VM as a whole depends.

self ensureClassPool.
self classPool declare: #BytesPerWord from: VMSqueakV3ObjectRepresentationConstants classPool.
self classPool declare: #BaseHeaderSize from: VMSqueakV3ObjectRepresentationConstants classPool
(ObjectMemory classPool keys select: [:k| k beginsWith: 'Byte']) do:
	[:k| self classPool declare: k from: ObjectMemory classPool]!

!OSVMPlugin commentStamp: '<historical>' prior: 0!
Represents an external plugin for the opensmalltalk-vm on which Squeak, Pharo, Cuis and Newspeak are running on!

!OSVMPluginHeaderBuilder commentStamp: '<historical>' prior: 0!
This class is a builder for Opensmalltalk-VM plugin header files.!

!OSVMInterpreterProxy commentStamp: 'eem 8/24/2018 15:43' prior: 0!
This class should provide the definition of what interpreter support plugins need and can have access to. Note that the proxy related files platforms - Cross - vm - sqVirtualMachine.[ch] are kept under the git tree at http://www.github.com/opensmalltalk/vm.
The main use of the class is to support the vm simulator and the RSqueak VM, which implements as many primitives as possible in Smalltalk.!

!OSVMPlugin methodsFor: 'as yet unclassified' stamp: 'jpb 6/18/2020 20:52:47'!
getInterpreter
	"Note: This is coded so that plugins can be run from Squeak."

	<returnType: 'VirtualMachine *'>
	^interpreterProxy! !

!OSVMPlugin methodsFor: 'as yet unclassified' stamp: 'jpb 6/20/2020 10:55:56'!
getModuleName
	"Note: This is hardcoded so it can be run from Squeak.
	The module name is used for validating a module *after*
	it is loaded to check if it does really contain the module
	we're thinking it contains. This is important!!"
	<returnType: 'const char*'>
	<export: true>
	
	^'OSVMPlugin (e)'! !

!OSVMPlugin methodsFor: 'as yet unclassified' stamp: 'jpb 6/18/2020 20:55:34'!
setInterpreter: anInterpreter 
	"Note: This is coded so that is can be run from Squeak."

	<export: true>
	<var: #anInterpreter type: #'struct VirtualMachine*'>

	interpreterProxy _ anInterpreter.

	^true! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/20/2020 17:41:00'!
emit64BitAccessorsOn: writer
	
	writer nextPutComment: '64-Bit Integer Accessor functions'.
	writer nextPutLine: '#if VM_PROXY_MINOR > 4'.
	writer nextPutLine: 'sqInt  (*positive64BitIntegerFor)(usqLong integerValue);'.
	writer nextPutLine: 'usqLong(*positive64BitValueOf)(sqInt oop);'.
	writer nextPutLine: 'sqInt  (*signed64BitIntegerFor)(sqLong integerValue);'.
	writer nextPutLine: 'sqLong (*signed64BitValueOf)(sqInt oop);'.
	writer nextPutLine: '#endif'.
	writer newLine.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/20/2020 17:27:45'!
emitBitBlitSupportOn: writer
	| lines | 
	lines _ #(
		'#if VM_PROXY_MINOR > 1'
		'/* InterpreterProxy methodsFor: ''BitBlt support'' */'
		'sqInt (*loadBitBltFrom)(sqInt bbOop);'
		'sqInt (*copyBits)(void);'
		'sqInt (*copyBitsFromtoat)(sqInt leftX, sqInt rightX, sqInt yValue);'
		'#endif'
	).
	
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/20/2020 17:27:10'!
emitCompilerHelpersOn: writer
	| lines |
	
	lines _ #(
		'# if VM_PROXY_MINOR > 13'
		'/* Reuse these now that Cog provides a production JIT. */'
		'sqInt (*statNumGCs)(void);'
		'sqInt (*stringForCString)(char *nullTerminatedCString);'
		'# else'
		'/* InterpreterProxy methodsFor: ''compiler'' */'
		'CompilerHook *(*compilerHookVector)(void);'
		'sqInt         (*setCompilerInitialized)(sqInt initFlag);'
		'# endif'
	).
	
	lines do: [ :line| writer nextPutLine: line ].
	writer newLine.
! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/20/2020 16:30:41'!
emitConstantsOn: writer
	"Writes certain constant constructs used by primitives"
	writer nextPutLine: '#define VM_PROXY_MAJOR ' , self findProxyMajorVersion asString.
	writer nextPutLine: '#define VM_PROXY_MINOR ' , self findProxyMinorVersion asString.
	writer nextPutLine: '#define VM_WORD_SIZE ' , self findWordSize asString.
	
	writer nextPutLine: '#define VM_PLATFORM_NAME "' , self findPlatformName , '"'.
	writer nextPutLine: '#define VM_PLATFORM_PROCESSOR "' , self findPlatformSubtype , '"'.

	writer nextPutLine: '#define VM_OS_VERSION "' , self findOSVersion , '"'.
	writer nextPutLine: '#define VM_VERSION "' , self findVMVersion , '"'.
	
	writer newLine.
	self emitPrimitiveConstantsOn: writer.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/20/2020 17:26:59'!
emitFFISupportOn: writer

	|lines |
	lines _ #(
		'#if VM_PROXY_MINOR > 2'
	     'sqInt (*classLargeNegativeInteger)(void);'
		'sqInt (*signed32BitIntegerFor)(sqInt integerValue);'
		'int   (*signed32BitValueOf)(sqInt oop);'
		'sqInt (*includesBehaviorThatOf)(sqInt aClass, sqInt aSuperClass);'
		'sqInt (*primitiveMethod)(void);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.
		
	lines _ #(
		'/* InterpreterProxy methodsFor: ''FFI support'' */'
		'sqInt (*classExternalAddress)(void);'
		'sqInt (*classExternalData)(void);'
		'sqInt (*classExternalFunction)(void);'
		'sqInt (*classExternalLibrary)(void);'
		'sqInt (*classExternalStructure)(void);'
		'void *(*ioLoadModuleOfLength)(sqInt modIndex, sqInt modLength);'
		'void *(*ioLoadSymbolOfLengthFromModule)(sqInt fnIndex, sqInt fnLength, sqInt handle);'
		'sqInt (*isInMemory)(sqInt address);'
		'#endif'
	).
	
	lines do: [:line | writer nextPutLine: line ].
	writer newLine! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/19/2020 21:37:25'!
emitHeaderOn: writer
	writer nextPutLine: '#ifndef OSVM_PLUGIN_H'.
	writer nextPutLine: '#define OSVM_PLUGIN_H'.
	writer enableAutoIndent.
	
	self emitConstantsOn: writer.
	writer newLine.

	self emitTypedefsOn: writer.
	writer newLine.
	self emitInterpreterProxyStructOn: writer.
	
	writer disableAutoIndent.
	writer nextPutLine: '#endif'! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:37:17'!
emitInstanceCreatersOn: writer 
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''instance creation'''.

	lines _ #(
		'sqInt (*clone)(sqInt oop);'
		'sqInt (*instantiateClassindexableSize)(sqInt classPointer, sqInt size);'
		'sqInt (*makePointwithxValueyValue)(sqInt xValue, sqInt yValue);'
		'sqInt (*popRemappableOop)(void);'
		'sqInt (*pushRemappableOop)(sqInt oop);'
	).
	
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/20/2020 17:38:24'!
emitInterpreterProxyStructOn: writer
	writer nextPutLine: 'typedef struct VirtualMachine {'.
	writer autoIndentBy: 2.

	self emitVersionGettersOn: writer.
	self emitStackAccessorsOn: writer.
	self emitObjectAccessorsOn: writer.
	self emitObjectTestersOn: writer.
	self emitObjectConvertersOn: writer.
	self emitSpecialObjectsOn: writer.
	self emitSpecialClassesOn: writer.
	self emitInstanceCreatersOn: writer.
	self emitOtherHelpersOn: writer.
	
	self emitCompilerHelpersOn: writer.
	self emitBitBlitSupportOn: writer.
	self emitFFISupportOn: writer.
	self emit64BitAccessorsOn: writer.

	writer autoIndentBy: 1.
	writer nextPutLine: '} VirtualMachine;'.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:37:41'!
emitObjectAccessorsOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''object access'''.
	lines _ #(
		'sqInt  (*argumentCountOf)(sqInt methodPointer);'
		'void  *(*arrayValueOf)(sqInt oop);'
		'sqInt  (*byteSizeOf)(sqInt oop);'
		'void  *(*fetchArrayofObject)(sqInt fieldIndex, sqInt objectPointer);'
		'sqInt  (*fetchClassOf)(sqInt oop);'
		'double (*fetchFloatofObject)(sqInt fieldIndex, sqInt objectPointer);'
		'sqInt  (*fetchIntegerofObject)(sqInt fieldIndex, sqInt objectPointer);'
		'sqInt  (*fetchPointerofObject)(sqInt fieldIndex, sqInt oop);'
		'sqInt  (*obsoleteDontUseThisFetchWordofObject)(sqInt fieldFieldIndex, sqInt oop);'
		'void  *(*firstFixedField)(sqInt oop);'
		'void  *(*firstIndexableField)(sqInt oop);'
		'sqInt  (*literalofMethod)(sqInt offset, sqInt methodPointer);'
		'sqInt  (*literalCountOf)(sqInt methodPointer);'
		'sqInt  (*methodArgumentCount)(void);'
		'sqInt  (*methodPrimitiveIndex)(void);'
		'sqInt  (*primitiveIndexOf)(sqInt methodPointer);'
		'sqInt  (*sizeOfSTArrayFromCPrimitive)(void *cPtr);'
		'sqInt  (*slotSizeOf)(sqInt oop);'
		'sqInt  (*stObjectat)(sqInt array, sqInt fieldIndex);'
		'sqInt  (*stObjectatput)(sqInt array, sqInt fieldIndex, sqInt value);'
		'sqInt  (*stSizeOf)(sqInt oop);'
		'sqInt  (*storeIntegerofObjectwithValue)(sqInt fieldIndex, sqInt oop, sqInt integer);'
		'sqInt  (*storePointerofObjectwithValue)(sqInt fieldIndex, sqInt oop, sqInt valuePointer);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:38:01'!
emitObjectConvertersOn: writer
	| lines |
	
	writer nextPutComment: 'InterpreterProxy methodsFor: ''converting'''.

	lines _ #(
		'sqInt  (*booleanValueOf)(sqInt obj);'
		'sqInt  (*checkedIntegerValueOf)(sqInt intOop);'
		'sqInt  (*floatObjectOf)(double aFloat);'
		'double (*floatValueOf)(sqInt oop);'
		'sqInt  (*integerObjectOf)(sqInt value);'
		'sqInt  (*integerValueOf)(sqInt oop);'
		'sqInt  (*positive32BitIntegerFor)(unsigned int integerValue);'
		'usqInt (*positive32BitValueOf)(sqInt oop);'
	).
	
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:40:14'!
emitObjectTestersOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''testing'''.
	
	lines _ #(
		'sqInt (*isKindOf)(sqInt oop, char *aString);'
		'sqInt (*isMemberOf)(sqInt oop, char *aString);'
		'sqInt (*isBytes)(sqInt oop);'
		'sqInt (*isFloatObject)(sqInt oop);'
		'sqInt (*isIndexable)(sqInt oop);'
		'sqInt (*isIntegerObject)(sqInt oop);'
		'sqInt (*isIntegerValue)(sqInt intValue);'
		'sqInt (*isPointers)(sqInt oop);'
		'sqInt (*isWeak)(sqInt oop);'
		'sqInt (*isWords)(sqInt oop);'
		'sqInt (*isWordsOrBytes)(sqInt oop);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:38:14'!
emitOtherHelpersOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''other'''.

	lines _ #(
		'sqInt (*becomewith)(sqInt array1, sqInt array2);'
		'sqInt (*byteSwapped)(sqInt w);'
		'sqInt (*failed)(void);'
		'sqInt (*fullDisplayUpdate)(void);'
		'void (*fullGC)(void);'
		'void (*incrementalGC)(void);'
		'sqInt (*primitiveFail)(void);'
		'sqInt (*showDisplayBitsLeftTopRightBottom)(sqInt aForm, sqInt l, sqInt t, sqInt r, sqInt b);'
		'sqInt (*signalSemaphoreWithIndex)(sqInt semaIndex);'
		'sqInt (*success)(sqInt aBoolean);'
		'sqInt (*superclassOf)(sqInt classPointer);'
	).
	lines do: [:line| writer nextPutLine: line].
	writer newLine.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/19/2020 21:44:20'!
emitPrimitiveConstantsOn: writer
	"Writes the primitives constants on the given writer"
	| majorVersion lines |
	majorVersion _ self findProxyMajorVersion.
	
	majorVersion <= 8 ifTrue: [ ^self ].
	
	writer nextPutSectionComment: 'Primitive constants'.
	
	lines _ #(
		'#define PrimNoErr 0'
		'#define PrimErrGenericFailure 1'
		'#define PrimErrBadReceiver 2'
		'#define PrimErrBadArgument 3'
		'#define PrimErrBadIndex 4'
		'#define PrimErrBadNumArgs 5'
		'#define PrimErrInappropriate 6'
		'#define PrimErrUnsupported 7'
		'#define PrimErrNoModification 8'
		'#define PrimErrNoMemory 9'
		'#define PrimErrNoCMemory 10'
		'#define PrimErrNotFound 11'
		'#define PrimErrBadMethod 12'
		'#define PrimErrNamedInternal 13'
		'#define PrimErrObjectMayMove 14'
		'#define PrimErrLimitExceeded 15'
		'#define PrimErrObjectIsPinned 16'
		'#define PrimErrWritePastObject 17'
		'#define PrimErrObjectMoved 18'
		'#define PrimErrObjectNotPinned 19'
		'#define PrimErrCallbackError 20'
		'#define PrimErrOSError 21'
		'#define PrimErrFFIException 22'
		'#define PrimErrNeedCompaction 23'
		'#define PrimErrOperationFailed 24'
	).
	
	lines do: [:line | writer nextPutLine: line ].! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:28:13'!
emitSpecialClassesOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''special classes'''.

	lines _ #(
		'sqInt (*classArray)(void);'
		'sqInt (*classBitmap)(void);'
		'sqInt (*classByteArray)(void);'
		'sqInt (*classCharacter)(void);'
		'sqInt (*classFloat)(void);'
		'sqInt (*classLargePositiveInteger)(void);'
		'sqInt (*classPoint)(void);'
		'sqInt (*classSemaphore)(void);'
		'sqInt (*classSmallInteger)(void);'
		'sqInt (*classString)(void);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:26:02'!
emitSpecialObjectsOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''special objects'''. 

	lines _ #(
		'sqInt (*characterTable)(void);'
		'sqInt (*displayObject)(void);'
		'sqInt (*falseObject)(void);'
		'sqInt (*nilObject)(void);'
		'sqInt (*trueObject)(void);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine.! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/19/2020 21:51:48'!
emitSqIntTypedefsOn: writer

	"Here we use GCC macros for generating the types https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html#Common-Predefined-Macros"

	"for 32bit images"
	writer nextPutLine: '#if (__SIZEOF_INT__ == VM_WORD_SIZE)'.
	writer nextPutLine: 'typedef int sqInt;'.
	writer nextPutLine: 'typedef unsigned int usqInt;'.
	
	"for 64bit"
	writer nextPutLine: '#elif (__SIZEOF_LONG__ == VM_WORD_SIZE)'.
	writer nextPutLine: 'typedef long sqInt;'.
	writer nextPutLine: 'typedef unsigned long usqInt;'.
	
	writer nextPutLine: '#elif (__SIZEOF_LONG_LONG__ == VM_WORD_SIZE)'.
	writer nextPutLine: 'typedef long long sqInt;'.
	writer nextPutLine: 'typedef unsigned long long usqInt;'.
	writer nextPutLine: '#endif'! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/20/2020 17:36:54'!
emitSqLongTypedefsOn: writer
	| lines |
	lines _ #(
		'#  if !!defined(sqLong)'
		'#   if _MSC_VER'
		'#     define sqLong __int64'
		'#     define usqLong unsigned __int64'
		'#   else'
		'#     define sqLong long long'
		'#     define usqLong unsigned long long'
		'#   endif'
		'#  endif'
	).
	
	lines do: [:line | writer nextPutLine: line ].
	writer newLine! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 22:39:45'!
emitStackAccessorsOn: writer
	| lines |
	writer nextPutComment: 'InterpreterProxy methodsFor: ''stack access'''.
	lines _ #(
		'sqInt  (*pop)(sqInt nItems);'
		'sqInt  (*popthenPush)(sqInt nItems, sqInt oop);'
		'sqInt  (*push)(sqInt object);'
	 	'sqInt  (*pushBool)(sqInt trueOrFalse);'
	 	'sqInt  (*pushFloat)(double f);'
	 	'sqInt  (*pushInteger)(sqInt integerValue);'
	 	'double (*stackFloatValue)(sqInt offset);'
	 	'sqInt  (*stackIntegerValue)(sqInt offset);'
	 	'sqInt  (*stackObjectValue)(sqInt offset);'
	 	'sqInt  (*stackValue)(sqInt offset);'
	).
	lines do: [:line | writer nextPutLine: line ].
	writer newLine! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/20/2020 17:37:11'!
emitTypedefsOn: writer
	writer nextPutSectionComment: 'OpenSmalltalk Types'.
	
	self emitSqIntTypedefsOn: writer.
	self emitSqLongTypedefsOn: writer.
	
	writer nextPutLine: 'typedef sqInt (*CompilerHook)(void);'.
	writer newLine.
! !

!OSVMPluginHeaderBuilder methodsFor: 'C Header generation' stamp: 'jpb 6/6/2020 21:40:23'!
emitVersionGettersOn: writer
	writer nextPutAll: 'sqInt (*minorVersion)(void);'; newLine.
	writer nextPutAll: 'sqInt (*majorVersion)(void);'; newLine.
! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/6/2020 20:11:23'!
findInterpreterProxyVersion
	"Only implemented for VMs which can generate 1:1 the interpreterProxy interface, which is only possible of a VM which inherits from the opensmalltalk-vm"
	^{Smalltalk vmParameterAt: 70. Smalltalk vmParameterAt: 71}! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/19/2020 22:08:12'!
findOSVersion
	^Smalltalk osVersion ! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/7/2020 18:49:04'!
findOoPointerSize
	"Returns the size in bytes of the commonly used object oriented pointer (OOP) size used in the VM"
	^Smalltalk vmParameterAt: 40! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/19/2020 21:59:30'!
findPlatformName
	^Smalltalk platformName ! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/19/2020 22:08:01'!
findPlatformSubtype
	^Smalltalk platformSubtype ! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/19/2020 21:35:44'!
findProxyMajorVersion
	^Smalltalk vmParameterAt: 70.! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/19/2020 21:35:56'!
findProxyMinorVersion
	^Smalltalk vmParameterAt: 71! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/19/2020 21:53:14'!
findVMVersion
	^Smalltalk vmVersion ! !

!OSVMPluginHeaderBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 6/7/2020 18:49:24'!
findWordSize
	"Returns the word size within the VM"
	^ Smalltalk wordSize! !

!OSVMPluginHeaderBuilder class methodsFor: 'as yet unclassified' stamp: 'jpb 6/19/2020 21:58:45'!
writeHeader
	"Writes the header to a file"
	| builder fileEntry writer |
	builder _ self new.
	fileEntry _ 'osvm_plugin.h' asFileEntry.
	
	fileEntry writeStreamDo: [:headerStream | 
		writer _ SlangCLanguageWriter on: headerStream.
	
		builder emitHeaderOn: writer.
	].! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:40'!
argumentCountOf: methodPointer
	^methodPointer numArgs! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'jpb 6/18/2020 20:03:44'!
arrayValueOf: oop
	<returnType: 'void *'>
	self success: (self isWordsOrBytes: oop).
	^SlangCArrayAccessor on: oop.! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'eem 10/18/2018 13:51'!
byteSizeOf: oop
	"Return the size of the receiver in bytes"
	^oop class isBits
		ifTrue: [oop basicSize * oop class elementSize]
		ifFalse: [(self slotSizeOf: oop) * Smalltalk wordSize]! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'eem 6/8/2016 10:56'!
characterObjectOf: characterCode
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^StackInterpreter objectMemoryClass characterObjectOf: characterCode! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'eem 10/31/2013 00:27'!
characterValueOf: aCharacter
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^aCharacter asInteger! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'jpb 6/18/2020 20:04:24'!
fetchArray: fieldIndex ofObject: objectPointer
	"Fetch the instance variable at the given index of the given object. Return the address of first indexable field of resulting array object, or fail if the instance variable does not contain an indexable bytes or words object."
	"Note: May be called by translated primitive code."

	| arrayOop |
	<returnType: 'void *'>
	arrayOop := self fetchPointer: fieldIndex ofObject: objectPointer.
	^ self arrayValueOf: arrayOop
! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:07'!
fetchClassOf: oop
	^oop class! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'jpb 6/18/2020 20:04:29'!
fetchFloat: fieldIndex ofObject: objectPointer
	"Fetch the instance variable at the given index of the given object. Return the C double precision floating point value of that instance variable, or fail if it is not a Float."
	"Note: May be called by translated primitive code."

	| floatOop |
	<returnType: 'double'>
	floatOop := self fetchPointer: fieldIndex ofObject: objectPointer.
	^ self floatValueOf: floatOop! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'tpr (auto pragmas 12/08) 3/15/2004 20:20'!
fetchInteger: fieldIndex ofObject: objectPointer
	"Note: May be called by translated primitive code."

	| intOop |
	<inline: false>
	intOop := self fetchPointer: fieldIndex ofObject: objectPointer.
	^self checkedIntegerValueOf: intOop! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'tpr 6/6/2005 19:11'!
fetchLong32: fieldIndex ofObject: oop
"fetchWord:ofObject: is rescinded as of VMMaker 3.8 64bit VM. This is the same code as used therein and may need revision for 64 bit cleanliness"
	^oop instVarAt: fieldIndex+1! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 10/10/1998 16:04'!
fetchPointer: index ofObject: oop
	^oop instVarAt: index+1! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'jpb 6/19/2020 20:07:20'!
firstFixedField: oop
	<returnType:'void *'>
	^SlangCObjectAccessor on: oop! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'jpb 6/18/2020 20:03:51'!
firstIndexableField: oop
	<returnType:'void *'>
	^SlangCArrayAccessor on: oop! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'eem 11/18/2009 15:50'!
instanceSizeOf: classObj
	^classObj instSize! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'eem 1/20/2016 19:03'!
isOopImmutable: oop
	<option: #IMMUTABILITY>
	^StackInterpreter objectMemoryClass isOopImmutable: oop! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'eem 5/23/2011 17:14'!
literal: offset ofMethod: methodPointer
	^methodPointer literalAt: offset+1! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:40'!
literalCountOf: methodPointer
	^methodPointer numLiterals! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 10/7/1998 18:43'!
methodArgumentCount
	^argumentCount! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 10/7/1998 18:43'!
methodPrimitiveIndex
	^method primitive! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'tpr 6/6/2005 19:28'!
obsoleteDontUseThisFetchWord: fieldIndex ofObject: oop
"fetchWord:ofObject: is rescinded as of VMMaker 3.8 64bit VM. This is a placeholder to sit in the sqVirtualMachine structure to support older plugins for a while"
	self halt: 'deprecated method'! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'eem 10/31/2013 00:29'!
pinObject: anObject
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^self shouldBeImplemented! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:39'!
primitiveIndexOf: methodPointer
	^methodPointer primitive! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 11/28/1999 17:43'!
primitiveMethod
	"Return the method an external primitive was defined in"
	^method! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'tpr (auto pragmas 12/08) 12/29/2005 16:35'!
sizeOfSTArrayFromCPrimitive: cPtr
	"Note: Only called by translated primitive code."
	<var: #cPtr type: 'void *'>
	^self shouldNotImplement! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 10/7/1998 18:24'!
slotSizeOf: oop
	"Returns the number of slots in the receiver.
	If the receiver is a byte object, return the number of bytes.
	Otherwise return the number of words."
	^(oop basicSize) + (oop class instSize)! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:53'!
stObject: array at: index
	^array at: index! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 9/16/1998 01:53'!
stObject: array at: index put: value
	^array at: index put: value! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 10/7/1998 18:26'!
stSizeOf: oop
	"Return the number of indexable fields in the receiver"
	^oop basicSize! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 10/25/1998 16:16'!
storeInteger: index ofObject: oop withValue: integer
	(self isIntegerValue: integer) 
		ifTrue:[^self storePointer: index ofObject: oop withValue: integer]
		ifFalse:[^self primitiveFail]! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'ar 10/10/1998 21:25'!
storePointer: index ofObject: oop withValue: valuePointer
	^oop instVarAt: index+1 put: valuePointer! !

!OSVMInterpreterProxy methodsFor: 'object access' stamp: 'eem 7/28/2014 07:12'!
unpinObject: anObject
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^self shouldBeImplemented! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:02:18'!
become: array1 with: array2
	<returnType: #sqInt>
	array1 elementsExchangeIdentityWith: array2! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'nice 4/5/2016 23:19'!
byteSwapped32IfBigEndian: anInteger
	"Note: for simulation only.
	This message is not generated in C but replaced with a macro"
	<doNotGenerate>
	self vmEndianness = 1 ifTrue: [^anInteger byteSwap32].
	^anInteger! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'nice 4/5/2016 23:19'!
byteSwapped64IfBigEndian: anInteger
	"Note: for simulation only.
	This message is not generated in C but replaced with a macro"
	<doNotGenerate>
	self vmEndianness = 1 ifTrue: [^anInteger byteSwap64].
	^anInteger! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'eem 11/1/2007 16:05'!
failed

	^primFailCode ~= 0! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:05:30'!
fullDisplayUpdate
	<returnType: #sqInt>
	Display display! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:05:42'!
fullGC
	<returnType: #sqInt>
	Smalltalk garbageCollect! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'eem 1/23/2013 15:53'!
getInterruptPending
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:05:47'!
getStackPointer
	<returnType: #'sqInt *'>
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'eem 1/15/2018 14:04'!
getThisSessionID
	"Answer a session identifier which represents the current instance of Squeak.
	The identifier is expected to be unique among all instances of Squeak on a
	network at any point in time."

	[thisSessionID = 0]
		whileTrue:
			[thisSessionID := (Random new next * (SmallInteger maxVal min: 16rFFFFFFFF)) asInteger].
	^ thisSessionID! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'ar 9/16/1998 20:52'!
incrementalGC
	Smalltalk garbageCollectMost.! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'ar 5/13/2000 14:55'!
ioMicroMSecs
	^Time millisecondClockValue! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'tfel 2/11/2016 09:03'!
majorVersion
	^ 1! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'tfel 2/11/2016 09:03'!
minorVersion
	^ 8! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:08:44'!
primitiveFail
	<returnType: #sqInt>
	
	"Set general (unspecified) primitive failure."
	self primitiveFailFor: 1! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'tfel 4/30/2015 07:54'!
primitiveFailFor: reasonCode
	"Set specific primitive failure.
	N.B. primitiveFailFor: PrimNoErr is expected to clear the primFailCode.
	Primitive 255 is called to indicate that we are currently simulating a primitive that should fail and the VM should handle that case appropriately (if supported by the VM)."
	<primitive: 255>
	^ primFailCode := reasonCode! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'eem 12/18/2018 17:42'!
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

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'eem 12/18/2018 17:42'!
primitiveFailForOSError: osError
	<var: 'osError' type: #sqLong>
	<option: #(atLeastVMProxyMajor:minor: 1 14)>
	"Set PrimErrOSError primitive failure and associated osErrorCode.
	 Primitive 255 is called to indicate that we are currently simulating a primitive that should fail and the VM should handle that case appropriately (if supported by the VM)."
	<primitive: 255>
	osErrorCode := osError.
	^primFailCode := PrimErrOSError! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'eem 11/25/2009 10:39'!
primitiveFailureCode
	^primFailCode! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:09:57'!
setInterruptCheckChain: aFunction
	<returnType: #'void *'>
	<var: #aFunction declare: 'void (*aFunction)()'>
	
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'tfel 3/3/2016 17:06'!
showDisplayBits: aForm Left: l Top: t Right: r Bottom: b
	aForm == Display ifTrue:[
		Display class isDeferringUpdates ifTrue: [^ nil].
		Display forceToScreen: (Rectangle left: l right: r top: t bottom: b)].! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:10:01'!
signalSemaphoreWithIndex: semaIndex
	<returnType: #sqInt>
	((Smalltalk externalObjects) at: semaIndex) signal! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'eem 12/18/2018 17:41'!
statNumGCs
	<option: #(atLeastVMProxyMajor:minor: 1 14)>
	^(Smalltalk vmParameterAt: 7 "statFullGCs") + (Smalltalk vmParameterAt: 9 "statScavenges/statIncrGCs")! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:11:02'!
success: aBoolean
	<returnType: #sqInt>
	
	aBoolean ifTrue: [^self].
	primFailCode = 0 ifTrue: [self primitiveFailFor: 1]! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'ar 9/16/1998 20:51'!
superclassOf: classPointer
	^classPointer superclass! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'jpb 6/18/2020 20:11:07'!
tenuringIncrementalGC
	<returnType: #void>
	
	Smalltalk forceTenuring; garbageCollectMost! !

!OSVMInterpreterProxy methodsFor: 'other' stamp: 'tpr 12/22/2005 17:48'!
vmEndianness
	"return 0 for little endian, 1 for big endian"
	^SmalltalkImage current endianness =#big ifTrue:[1] ifFalse:[0]! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'ar 10/10/1998 21:27'!
booleanValueOf: obj
	obj == true ifTrue:[^true].
	obj == false ifTrue:[^false].
	self primitiveFail.
	^nil! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'ar 10/4/1998 15:47'!
checkedIntegerValueOf: intOop
	(self isIntegerObject: intOop)
		ifTrue:[^self integerValueOf: intOop]
		ifFalse:[self primitiveFail. ^0].! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:05:18'!
floatObjectOf: aFloat
	<returnType: #sqInt> "...because answering the float argument causes the type inferencer to say this answers a float."
	<var: #aFloat type: #double>
	
	aFloat isFloat ifFalse: [self error:'Not a float object'].
	^aFloat! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:05:24'!
floatValueOf: oop
	<returnType: #double>
	
	oop isFloat
		ifTrue:[^oop]
		ifFalse:[self primitiveFail. ^0.0].! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'ar 10/10/1998 16:13'!
integerObjectOf: value
	value class == SmallInteger ifFalse:[self error:'Not a SmallInteger object'].
	^value! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'ar 10/10/1998 16:10'!
integerValueOf: oop
	oop class == SmallInteger ifFalse:[self error:'Not a SmallInteger'].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'eem 12/6/2012 16:01'!
ioFilename: aCharBuffer fromString: aFilenameString ofLength: filenameLength resolveAliases: aBoolean
	<var: #aCharBuffer type: #'char *'>
	<var: #aFilenameString type: #'char *'>
	"the vm has to convert aFilenameString via any canonicalization and char-mapping and put the result in aCharBuffer. This doesn't translate well in Smalltalk since we know how long strings are rather than considering them terminated by a 0 char. Do the best we can.
Note the resolveAliases flag - this is an awful artefact of OSX and Apples demented alias handling. When opening a file, the flag must be  true, when closing or renaming it must be false. Sigh."
	aCharBuffer replaceFrom:1 to: filenameLength with: aFilenameString! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:08:18'!
positive32BitIntegerFor: integerValue
	<returnType: #sqInt>
	<var: 'integerValue' type: #'unsigned int'>
	
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue > 0
		ifTrue:[integerValue]
		ifFalse:[ (1 bitShift: 32) + integerValue]! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:08:24'!
positive32BitValueOf: oop
	<returnType: #usqInt>
	
	oop isInteger ifFalse:[self error:'Not an integer object'].
	oop < 0 
		ifTrue:[self primitiveFail. ^0]
		ifFalse:[^oop]! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:08:29'!
positive64BitIntegerFor: integerValue
	<api>
	<returnType: #sqInt> "...because answering the 64-bit argument causes the type inferencer to say this answers 64-bits."
	<var: 'integerValue' type: #usqLong>
	
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue > 0
		ifTrue:[integerValue]
		ifFalse:[ (1 bitShift: 64) + integerValue]! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:08:34'!
positive64BitValueOf: oop
	<returnType: #usqLong>
	
	oop isInteger ifFalse:[self error:'Not an integer object'].
	oop < 0 
		ifTrue:[self primitiveFail. ^0]
		ifFalse:[^oop]! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:08:38'!
positiveMachineIntegerValueOf: oop
	<returnType: #'usqIntptr_t'>
	
	oop isInteger ifFalse:[self error: 'Not an integer object'].
	^oop < 0 
		ifTrue: [self primitiveFail. 0]
		ifFalse: [oop]! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'ar 11/29/1999 22:01'!
signed32BitIntegerFor: integerValue
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:10:07'!
signed32BitValueOf: oop
	<returnType: #int>
	
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:10:11'!
signed64BitIntegerFor: integerValue
	<returnType: #sqInt> "...because answering the 64-bit argument causes the type inferencer to say this answers 64-bits."
	<var: 'integerValue' type: #sqLong>
	
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:10:18'!
signed64BitValueOf: oop
	<returnType: #sqLong>
	
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'converting' stamp: 'jpb 6/18/2020 20:10:36'!
signedMachineIntegerValueOf: oop
	<returnType: #'sqIntptr_t'>
	
	oop isInteger ifFalse:[self error:'Not an integer object'].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'ar 9/18/1998 21:11'!
byteAt: accessor
	^accessor byteAt: 0! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'ar 9/18/1998 21:12'!
byteAt: accessor put: value
	^accessor byteAt: 0 put: value! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'tfel 3/3/2016 15:41'!
byteAtPointer: accessor
	^ self byteAt: accessor! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'ar 10/27/1999 14:13'!
fetchIntegerOrTruncFloat: fieldIndex ofObject: objectPointer
	"Support for BitBlt simulation only"
	| intOrFloat |
	intOrFloat := self fetchPointer: fieldIndex ofObject: objectPointer.
	(self isIntegerObject: intOrFloat) ifTrue: [^ self integerValueOf: intOrFloat].
	intOrFloat isFloat ifTrue:[^intOrFloat truncated].
	^self primitiveFail.! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'ar 10/27/1999 14:21'!
isInterpreterProxy
	"Return true since I am not a real Interpreter simulation"
	^true! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'tfel 2/23/2016 18:34'!
long32At: arrayOffset

	^ arrayOffset long32At: 0
! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'ar 9/18/1998 21:11'!
longAt: accessor
	^accessor longAt: 0! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'ar 9/18/1998 21:11'!
longAt: accessor put: value
	^accessor longAt: 0 put: value! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'eem 1/23/2013 15:53'!
notYetImplementedError
	^self error: 'not yet implemented in Smalltalk'! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'jpb 6/18/2020 20:08:00'!
pop: nItems thenPushBool: boolean
	<returnType: #sqInt>
	self pop: nItems.
	self push: (boolean ifTrue: [self trueObject] ifFalse: [self falseObject])! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'jpb 6/18/2020 20:08:04'!
pop: nItems thenPushFloat: float
	<var: #float type: #double>
	<returnType: #sqInt>
	self pop: nItems.
	self push: (self floatObjectOf: float)! !

!OSVMInterpreterProxy methodsFor: 'private' stamp: 'jpb 6/18/2020 20:08:09'!
pop: nItems thenPushInteger: integer
	<returnType: #sqInt>
	self pop: nItems.
	self push: (self integerObjectOf: integer)! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'jpb 6/18/2020 20:04:01'!
cStringOrNullFor: oop
	"Answer either a malloced string with the null-terminated contents of oop if oop is a string,
	 or the null pointer if oop is nil, or fail.  It is the client's responsibility to free the string later."
	<returnType: #'char *'>
	oop isString ifTrue: [^oop] ifFalse: [self primitiveFail. ^0]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'ar 11/17/1999 22:04'!
includesBehavior: aClass ThatOf: aSuperclass
	^aClass includesBehavior: aSuperclass! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'jpb 6/18/2020 20:06:56'!
is: oop KindOf: aString
	"InterpreterProxy new is: 42 KindOf: 'Number'"
	<var: #aString type: 'char *'>
	<returnType: #sqInt>
	
	(Smalltalk at: aString asSymbol ifAbsent:[nil])
		ifNil:[false]
		ifNotNil: [:theClass| oop isKindOf: theClass]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 10/28/2009 15:12'!
is: oop KindOfClass: aClass
	"InterpreterProxy new is: 42 KindOfClass: Number"
	^oop isKindOf: aClass! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'tpr (auto pragmas 12/08) 12/29/2005 16:35'!
is: oop MemberOf: aString
	"InterpreterProxy new is: 42 MemberOf:'SmallInteger'"
	| theClass |
	<var: #aString type:'char *'>
	theClass := Smalltalk at: aString asSymbol ifAbsent:[nil].
	^theClass isNil
		ifTrue:[false]
		ifFalse:[^oop isMemberOf: theClass]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 1/30/2014 16:06'!
isArray: oop
	^(self isNonImmediate: oop) and: [oop class instSpec = 2]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 12/18/2018 17:45'!
isBooleanObject: oop
	<option: #(atLeastVMProxyMajor:minor: 1 15)>
	^oop == true or: [oop == false]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:04'!
isBytes: oop
	^oop class isBytes! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 10/31/2013 00:27'!
isCharacterObject: oop
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^oop isCharacter! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 10/31/2013 00:27'!
isCharacterValue: anInteger
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^(self isIntegerValue: anInteger) and: [anInteger >= 0]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 11/20/2014 17:56'!
isFloatObject: oop
	^oop isFloat! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 10/31/2013 00:27'!
isImmediate: anObject
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^StackInterpreter objectMemoryClass isImmediate: anObject! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'acg 9/19/1999 13:11'!
isIndexable: oop
	^oop class isVariable! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:12'!
isIntegerObject: objectPointer
	^objectPointer class == SmallInteger! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:13'!
isIntegerValue: intValue
	^intValue class == SmallInteger! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'nice 4/18/2016 23:17'!
isKindOfInteger: objectOrientedPointer
	^objectOrientedPointer isInteger! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'nice 4/18/2016 23:37'!
isLargeIntegerObject: objectOrientedPointer
	^objectOrientedPointer isKindOf: LargePositiveInteger! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'nice 4/19/2016 21:45'!
isLargeNegativeIntegerObject: objectOrientedPointer
	^objectOrientedPointer isMemberOf: LargeNegativeInteger! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'nice 4/19/2016 21:44'!
isLargePositiveIntegerObject: objectOrientedPointer
	^objectOrientedPointer isMemberOf: LargePositiveInteger! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'tfel 2/11/2016 09:17'!
isNonImmediate: anObject

	^ (self isImmediate: anObject) not! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 1/23/2013 15:54'!
isOopMutable: anOop
	<api>
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 10/31/2013 00:28'!
isPinned: anObject
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^self shouldBeImplemented! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:04'!
isPointers: oop
	^oop class isPointers! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'eem 12/18/2018 17:40'!
isPositiveMachineIntegerObject: oop
	<option: #(atLeastVMProxyMajor:minor: 1 15)>
	^oop isInteger and: [oop >= 0 and: [oop digitLength <= Smalltalk wordSize]]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:16'!
isWeak: oop
	^oop class isWeak! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'ar 10/9/1998 22:19'!
isWords: oop
	^oop class isPointers not and:[oop class isBytes not]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'ar 9/16/1998 01:05'!
isWordsOrBytes: oop
	^(self isBytes: oop) or:[self isWords: oop]! !

!OSVMInterpreterProxy methodsFor: 'testing' stamp: 'jpb 6/18/2020 20:10:57'!
stringForCString: aCString
	"Answer a ByteString object containing the bytes (possibly UTF-8?) in the null-terminated C string aCString."
	<option: #(atLeastVMProxyMajor:minor: 1 14)>
	<returnType: #sqInt>
	<var: #aCString type: #'char *'>
	
	self notYetImplemented! !

!OSVMInterpreterProxy methodsFor: 'callback support' stamp: 'eem 1/23/2013 15:53'!
callbackEnter: callbackID
	"Re-enter the interpreter for executing a callback"
	<var: #callbackID type: #'sqInt *'>
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'callback support' stamp: 'eem 5/19/2015 14:08'!
callbackLeave: cbID
	"Leave from a previous callback"
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'callback support' stamp: 'jpb 6/18/2020 20:09:17'!
reestablishContextPriorToCallback: callbackContext
	"callbackContext is an activation of invokeCallback:stack:registers:jmpbuf:.  Its sender
	is the interpreter's state prior to the callback.  Reestablish that state."
	<returnType: #sqInt>
	self notYetImplemented! !

!OSVMInterpreterProxy methodsFor: 'callback support' stamp: 'jpb 6/18/2020 20:09:22'!
returnAs: returnTypeOop ThroughCallback: vmCallbackContext Context: callbackMethodContext
	<returnType: #sqInt>
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	
	"callbackMethodContext is an activation of invokeCallback:[stack:registers:jmpbuf:].
	 Its sender is the VM's state prior to the callback.  Reestablish that state (via longjmp),
	 and mark callbackMethodContext as dead."
	self notYetImplemented! !

!OSVMInterpreterProxy methodsFor: 'callback support' stamp: 'jpb 6/18/2020 20:09:27'!
sendInvokeCallback: thunkPtr Stack: stackPtr Registers: regsPtr Jmpbuf: jmpBufPtr
	"Send the 4 argument callback message invokeCallback:stack:registers:jmpbuf:
	 to Alien class with the supplied args.  The arguments are raw C addresses
	 and are converted to integer objects on the way."
	<returnType: #sqInt>
	self notYetImplemented! !

!OSVMInterpreterProxy methodsFor: 'callback support' stamp: 'jpb 6/18/2020 20:09:50'!
sendInvokeCallbackContext: vmCallbackContext
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	
	"Send the calllback message to Alien class with the supplied arg(s).  Use either the
	 1 arg invokeCallbackContext: or the 4 arg invokeCallback:stack:registers:jmpbuf:
	 message, depending on what selector is installed in the specialObjectsArray.
	 Note that if invoking the legacy invokeCallback:stack:registers:jmpbuf: we pass the
	 vmCallbackContext as the jmpbuf argument (see reestablishContextPriorToCallback:).
	 The arguments are raw C addresses and are converted to integer objects on the way."
	<returnType: #sqInt>
	self notYetImplemented! !

!OSVMInterpreterProxy methodsFor: 'callback support' stamp: 'eem 1/23/2013 15:54'!
signalNoResume: aSemaphore
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 21:43'!
characterTable
	^Character characterTable! !

!OSVMInterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 21:42'!
displayObject
	^Display! !

!OSVMInterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 20:40'!
falseObject
	^false! !

!OSVMInterpreterProxy methodsFor: 'special objects' stamp: 'eem 3/14/2014 16:45'!
getDeferDisplayUpdates
	^false! !

!OSVMInterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 20:40'!
nilObject
	^nil! !

!OSVMInterpreterProxy methodsFor: 'special objects' stamp: 'eem 10/29/2009 10:51'!
primitiveErrorTable
	^Smalltalk primitiveErrorTable! !

!OSVMInterpreterProxy methodsFor: 'special objects' stamp: 'ar 9/16/1998 20:41'!
trueObject
	^true! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'eem 11/26/2007 17:47'!
classAlien
        ^Smalltalk at: #Alien ifAbsent: [nil]! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:03'!
classExternalAddress
	^Smalltalk at: #ExternalAddress ifAbsent:[nil]! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:03'!
classExternalData
	^Smalltalk at: #ExternalData ifAbsent:[nil]! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:03'!
classExternalFunction
	^Smalltalk at: #ExternalFunction ifAbsent:[nil]! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:04'!
classExternalLibrary
	^Smalltalk at: #ExternalLibrary ifAbsent:[nil]! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/29/1999 22:04'!
classExternalStructure
	^Smalltalk at: #ExternalStructure ifAbsent:[nil]! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'eem 4/18/2008 15:17'!
classUnsafeAlien
        ^Smalltalk at: #UnsafeAlien ifAbsent: [nil]! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'eem 1/23/2013 15:53'!
disownVM: flags
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'jpb 6/18/2020 20:05:54'!
ioLoadFunction: functionName From: moduleName
	<returnType: #'void *'>
	<var: #functionName type: #'char *'>
	<var: #moduleName type: #'char *'>
	"Dummy - provided by support code"
	^0! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'jpb 6/18/2020 20:05:59'!
ioLoadFunction: functionName From: moduleName AccessorDepthInto: accessorDepthPtr
	<returnType: #'void *'>
	<var: #functionName type: #'char *'>
	<var: #moduleName type: #'char *'>
	<var: #accessorDepthPtr type: #'sqInt *'>
	"Dummy - provided by support code"
	^0! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'jpb 6/18/2020 20:06:04'!
ioLoadModule: moduleNameIndex OfLength: moduleLength
	<returnType: #'void *'>
	"Dummy - provided by support code"
	^0! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'jpb 6/18/2020 20:06:09'!
ioLoadSymbol: functionNameIndex OfLength: functionLength FromModule: moduleHandle
	<returnType: #'void *'>
	"Dummy - provided by support code"
	^0! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'ar 11/28/1999 19:04'!
isInMemory: address
	"Return true if the given address is in ST object memory"
	^true! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'eem 1/23/2013 15:54'!
isYoung: anOop
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'FFI support' stamp: 'eem 1/23/2013 15:53'!
ownVM: flags
	^self notYetImplementedError! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:42'!
classArray
	^Array! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classBitmap
	^Bitmap! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classByteArray
	^ByteArray! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classCharacter
	^Character! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:10'!
classDoubleByteArray
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #DoubleByteArray ifAbsent: [nil]! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:10'!
classDoubleWordArray
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #DoubleWordArray ifAbsent: [nil]! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classFloat
	^Float! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:15'!
classFloat32Array
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #FloatArray ifAbsent: [nil]! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:15'!
classFloat64Array
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #Float64Array ifAbsent: [nil]! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 11/19/1999 14:29'!
classLargeNegativeInteger
	^LargeNegativeInteger! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classLargePositiveInteger
	^LargePositiveInteger! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classPoint
	^Point! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 20:43'!
classSemaphore
	^Semaphore! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'ar 9/16/1998 21:43'!
classSmallInteger
	^SmallInteger! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'eem 10/7/2010 12:26'!
classString
	^ByteString! !

!OSVMInterpreterProxy methodsFor: 'special classes' stamp: 'eem 1/16/2020 20:10'!
classWordArray
	<option: #(atLeastVMProxyMajor:minor: 1 16)>
	^Smalltalk at: #WordArray ifAbsent: [nil]! !

!OSVMInterpreterProxy methodsFor: 'instance creation' stamp: 'dtl 2/14/2014 19:32'!
clone: oop
	^oop shallowCopy! !

!OSVMInterpreterProxy methodsFor: 'instance creation' stamp: 'ar 9/16/1998 01:11'!
instantiateClass: classPointer indexableSize: size
	^size = 0 
		ifTrue:[classPointer basicNew]
		ifFalse:[classPointer basicNew: size]! !

!OSVMInterpreterProxy methodsFor: 'instance creation' stamp: 'ar 10/10/1998 16:14'!
makePointwithxValue: xValue yValue: yValue
	(xValue class == SmallInteger and:[yValue class == SmallInteger]) 
		ifFalse:[self error:'Not SmallInteger objects'].
	^xValue@yValue! !

!OSVMInterpreterProxy methodsFor: 'instance creation' stamp: 'ar 9/16/1998 01:14'!
popRemappableOop
	^remapBuffer removeLast! !

!OSVMInterpreterProxy methodsFor: 'instance creation' stamp: 'jpb 6/18/2020 20:09:11'!
pushRemappableOop: oop
	<returnType: #sqInt>
	remapBuffer addLast: oop! !

!OSVMInterpreterProxy methodsFor: 'instance creation' stamp: 'ar 3/6/2009 11:09'!
topRemappableOop
	"Returns the top of the remappable oop. Useful when writing loops."
	^remapBuffer last! !

!OSVMInterpreterProxy methodsFor: 'BitBlt support' stamp: 'jpb 6/18/2020 20:04:10'!
copyBits
	<returnType: #sqInt>
	bb copyBits! !

!OSVMInterpreterProxy methodsFor: 'BitBlt support' stamp: 'jpb 6/18/2020 20:04:15'!
copyBitsFrom: leftX to: rightX at: yValue
	<returnType: #sqInt>
	bb copyBitsFrom: leftX to: rightX at: yValue.! !

!OSVMInterpreterProxy methodsFor: 'BitBlt support' stamp: 'jpb 6/18/2020 20:07:02'!
loadBitBltFrom: bbOop
	<returnType: #sqInt>
	bb := bbOop! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:05:09'!
floatArg: offset
	"Like #stackFloatValue: but access method arguments left-to-right"
	"Obsolete; was never used; replaced with methodReturnString: in the VirtualMachine struct."
	| oop |
	<returnType: #double>
	self flag: #deprecated.
	
	oop := self methodArg: offset.
	(self isFloatObject: oop) ifFalse: [self primitiveFail. ^0.0].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:32'!
integerArg: offset
	"Like #stackIntegerValue: but access method arguments left-to-right"
	"Obsolete; was never used; replaced with methodReturnInteger: in the VirtualMachine struct."
	| oop |
	self deprecated.
	oop := self methodArg: offset.
	(self isIntegerObject: oop) ifFalse: [self primitiveFail. ^0].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:35'!
methodArg: offset
	"Like #stackValue: but access method arguments left-to-right"
	"Obsolete; was never used; replaced with methodReturnBool: in the VirtualMachine struct."
	self deprecated.
	offset > argumentCount + 1 ifTrue:[^self primitiveFail].
	^self stackValue: argumentCount - offset! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 03/16/2018 14:10'!
methodReturnBool: boolean
	"Sets the return value for a method"
	self pop: argumentCount+1 thenPushBool: boolean.
	^0! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:22'!
methodReturnFloat: aFloat
	"Sets the return value for a method"
	<var: 'aFloat' type: #double>
	self pop: argumentCount+1 thenPushFloat: aFloat.
	^0! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 03/16/2018 14:10'!
methodReturnInteger: integer
	"Sets the return value for a method"
	self pop: argumentCount+1 thenPushInteger: integer.
	^0! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'ul 4/17/2018 16:02'!
methodReturnReceiver
	"Sets the return value for a method"
	self pop: argumentCount.
	^0! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 7/24/2019 12:28'!
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

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 11/7/2009 11:13'!
methodReturnValue: oop
	"Sets the return value for a method"
	self pop: argumentCount+1 thenPush: oop.
	^0! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 3/16/2018 15:34'!
objectArg: offset
	"Like #stackObjectValue: but access method arguments left-to-right"
	"Obsolete; was never used; replaced with methodReturnFloat: in the VirtualMachine struct."
	| oop |
	self deprecated.
	oop := self methodArg: offset.
	(self isImmediate: oop) ifTrue: [self primitiveFail. ^ nil].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:07:07'!
pop: nItems
	<returnType: #sqInt>
	1 to: nItems do:[:i| stack removeLast].! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:07:11'!
pop: nItems thenPush: oop
	<returnType: #sqInt>
	self pop: nItems.
	self push: oop! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:08:50'!
push: object
	<returnType: #sqInt>
	
	stack addLast: object! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:08:55'!
pushBool: trueOrFalse
	<returnType: #sqInt>
	
	(trueOrFalse == true or:[trueOrFalse == false]) ifFalse:[self error:'Not a Boolean'].
	self push: trueOrFalse! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:09:01'!
pushFloat: f
	<returnType: #sqInt>
	<var: #f type: 'double '>
	
	f isFloat ifFalse:[^self error:'Not a Float'].
	self push: f.! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:09:06'!
pushInteger: integerValue
	<returnType: #sqInt>
	
	self push: (self integerObjectOf: integerValue).! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:10:42'!
stackFloatValue: offset
	| oop |
	<returnType: 'double'>
	
	oop := self stackValue: offset.
	(self isFloatObject: oop) ifFalse: [self primitiveFail. ^0.0].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'ar 9/16/1998 22:07'!
stackIntegerValue: offset
	| oop |
	oop := self stackValue: offset.
	(self isIntegerObject: oop) ifFalse: [self primitiveFail. ^0].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'eem 1/30/2014 12:37'!
stackObjectValue: offset
	| oop |
	oop := self stackValue: offset.
	(self isImmediate: oop) ifTrue: [self primitiveFail. ^ nil].
	^oop! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:10:46'!
stackPositiveMachineIntegerValue: offset
	<returnType: #'usqIntptr_t'>
	
	^self positiveMachineIntegerValueOf: (self stackValue: offset)! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'jpb 6/18/2020 20:10:51'!
stackSignedMachineIntegerValue: offset
	<returnType: #'sqIntptr_t'>
	
	^self signedMachineIntegerValueOf: (self stackValue: offset)! !

!OSVMInterpreterProxy methodsFor: 'stack access' stamp: 'ar 9/16/1998 11:47'!
stackValue: offset
	^stack at: stack size - offset.! !

!OSVMInterpreterProxy methodsFor: 'initialize' stamp: 'eem 11/1/2007 16:05'!
initialize
	primFailCode := 0.
	remapBuffer := OrderedCollection new.
	stack := OrderedCollection new.! !

!OSVMInterpreterProxy methodsFor: 'initialize' stamp: 'ar 10/3/1998 18:50'!
loadStackFrom: aContext
	self push: aContext receiver.
	method := aContext method.
	argumentCount := method numArgs.
	1 to: argumentCount do:[:i| self push: (aContext at: i) ].! !

!OSVMInterpreterProxy methodsFor: 'initialize' stamp: 'tfel 3/30/2015 16:13'!
synthesizeStackFor: receiver with: args
	<doNotGenerate>
	self push: receiver.
	argumentCount := args size.
	1 to: argumentCount do: [:i | self push: (args at: i)].! !

!OSVMInterpreterProxy class methodsFor: 'translation' stamp: 'eem 12/6/2012 15:49'!
implicitReturnTypeFor: aSelector
	"Answer the return type for methods that don't have an explicit return."
	^#sqInt! !

!OSVMInterpreterProxy class methodsFor: 'private' stamp: 'jpb 6/20/2020 10:53:23'!
validateProxyImplementation: anInterpreter 
	"InterpreterProxy validateProxyImplementation: Interpreter"

	| proxyClass catList |
	proxyClass := OSVMInterpreterProxy.
	catList := proxyClass organization categories copy asOrderedCollection.
	catList remove: 'initialize' ifAbsent:[].
	catList remove: 'private' ifAbsent:[].
	catList do:[:categ|
		(proxyClass organization listAtCategoryNamed: categ) do:[:selector|
			(anInterpreter canUnderstand: selector) 
				ifFalse:
					[self notifyWithLabel: selector, ' is not implemented in ', anInterpreter name]]]! !
