'From Cuis 5.0 [latest update: #4191] on 15 June 2020 at 8:41:04 pm'!
'Description Contains tools for dealing with Slang, for example specialized browsers.

License: MIT
Author: Josef Philip Bernhart'!
!provides: 'Slang-Tools' 1 26!
!requires: 'Slang-Kernel' 1 0 nil!
SystemOrganization addCategory: #'Slang-Tools'!


!classDefinition: #SlangBrowser category: #'Slang-Tools'!
Browser subclass: #SlangBrowser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Slang-Tools'!
!classDefinition: 'SlangBrowser class' category: #'Slang-Tools'!
SlangBrowser class
	instanceVariableNames: ''!


!SlangBrowser commentStamp: '<historical>' prior: 0!
A codeprovider which supports in addition to the normal one translating it to installed Slang target languages!

!SlangBrowser methodsFor: 'controls' stamp: 'jpb 6/15/2020 20:39:51'!
contentsSymbolQuints
	| slangSymbolQuints |
	slangSymbolQuints _ {
		self makeSlangCContentQuint.
		self makeSlangJSContentQuint.
	} select: [:quint| quint isNil not ].

	^super contentsSymbolQuints , slangSymbolQuints! !

!SlangBrowser methodsFor: 'controls' stamp: 'jpb 6/15/2020 20:39:37'!
makeSlangCContentQuint
	Smalltalk at: #SlangCCodeGenerator ifAbsent: [^nil].

	^#(slangCSource                   toggleShowCSource 			showingCSourceString
		'translated to C'			'the code translated to C')! !

!SlangBrowser methodsFor: 'controls' stamp: 'jpb 6/15/2020 20:40:36'!
makeSlangJSContentQuint
	Smalltalk at: #SlangJSCodeGenerator ifAbsent: [^nil].
	
	
	^#(slangJSSource                 toggleShowJSSource                       showingJSSourceString
		'translated to JavaScript'       'the code translated to JavaScript')! !

!SlangBrowser methodsFor: 'controls' stamp: 'jpb 5/31/2020 20:56:18'!
selectedMessage
	"Answer a copy of the source code for the selected message."
	self showingCSource
		ifTrue: [ ^self translatedCSource ].

	self showingJSSource
		ifTrue: [ ^self translatedJSSource ].
		
	^super selectedMessage! !

!SlangBrowser methodsFor: 'Translation to C' stamp: 'jpb 5/30/2020 21:57:41'!
showCSource: aBoolean
	aBoolean
		ifTrue: [ self contentsSymbol: #slangCSource ]
		ifFalse: [ self contentsSymbol: #source ]! !

!SlangBrowser methodsFor: 'Translation to C' stamp: 'jpb 5/30/2020 21:55:07'!
showingCSource
	^self contentsSymbol == #slangCSource! !

!SlangBrowser methodsFor: 'Translation to C' stamp: 'jpb 5/30/2020 21:53:52'!
showingCSourceString
	^ (self showingCSource 
		ifTrue:
			['<yes>']
		ifFalse:
			['<no>']), 'C source'! !

!SlangBrowser methodsFor: 'Translation to C' stamp: 'jpb 5/30/2020 21:53:07'!
toggleShowCSource
	self showCSource: self showingCSource not! !

!SlangBrowser methodsFor: 'Translation to C' stamp: 'jpb 6/1/2020 14:30:52'!
translatedCSource
	"Returns the C source of the selected class using Slang as generating"
	 | selectedClass selector codeGenerator translatedSource methodNode |
	selectedClass _ self selectedClassOrMetaClass.
	
	(selectedClass isNil or: [(selector _ self selectedMessageName) isNil]) ifTrue: [^ ''].
	selectedClass compiledMethodAt: selector ifAbsent: [^ ''].

	codeGenerator _ SlangCCodeGenerator new initialize.
	codeGenerator declareMethodsStatic: false.
	codeGenerator permitMethodPruning: true.
	codeGenerator prepareMethodsInlined: false doAssertions: true.
	
	codeGenerator addClass: selectedClass.
	methodNode _ codeGenerator findMethodNamed: selector.
	translatedSource _ ReadWriteStream on: String new.
	methodNode emitCCodeOn: translatedSource generator: codeGenerator.
	
	^translatedSource contents! !

!SlangBrowser methodsFor: 'Translation to JavaScript' stamp: 'jpb 5/31/2020 20:40:59'!
showJSSource: aBoolean
	aBoolean
		ifTrue: [ self contentsSymbol: #slangJSource ]
		ifFalse: [ self contentsSymbol: #source ]! !

!SlangBrowser methodsFor: 'Translation to JavaScript' stamp: 'jpb 5/31/2020 20:40:30'!
showingJSSource
	^self contentsSymbol == #slangJSource! !

!SlangBrowser methodsFor: 'Translation to JavaScript' stamp: 'jpb 5/31/2020 20:50:59'!
showingJSSourceString
	^ (self showingJSSource 
		ifTrue:
			['<yes>']
		ifFalse:
			['<no>']), 'JavaScript source'! !

!SlangBrowser methodsFor: 'Translation to JavaScript' stamp: 'jpb 5/31/2020 20:40:52'!
toggleShowJSSource
	self showJSSource: self showingJSSource not! !

!SlangBrowser methodsFor: 'Translation to JavaScript' stamp: 'jpb 6/1/2020 14:30:52'!
translatedJSSource
	"Returns the C source of the selected class using Slang as generating"
	 | selectedClass selector codeGenerator translatedSource methodNode |
	selectedClass _ self selectedClassOrMetaClass.
	
	(selectedClass isNil or: [(selector _ self selectedMessageName) isNil]) ifTrue: [^ ''].
	selectedClass compiledMethodAt: selector ifAbsent: [^ ''].
	
	codeGenerator _ SlangJSCodeGenerator new initialize.
	codeGenerator declareMethodsStatic: false.
	codeGenerator permitMethodPruning: true.
	codeGenerator prepareMethodsInlined: false doAssertions: true.

	codeGenerator addClass: selectedClass.
	methodNode _ codeGenerator findMethodNamed: selector.
	translatedSource _ ReadWriteStream on: String new.
	methodNode emitJSCodeOn: translatedSource generator: codeGenerator.
	
	^translatedSource contents! !
