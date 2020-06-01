'From Cuis 5.0 [latest update: #4112] on 1 June 2020 at 12:45:38 pm'!
'Description Contains tools for dealing with Slang, for example specialized browsers.

License: MIT
Author: Josef Philip Bernhart'!
!provides: 'Slang-Tools' 1 24!
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

!SlangBrowser methodsFor: 'controls' stamp: 'jpb 5/31/2020 20:39:36'!
contentsSymbolQuints
	| slangSymbolQuints |
	slangSymbolQuints _ #(
		(slangCSource                   toggleShowCSource 			showingCSourceString
		'translated to C'			'the code translated to C')
		(slangJSSource                 toggleShowJSSource                       showingJSSourceString
		'translated to JavaScript'       'the code translated to JavaScript')
	).
	

	^super contentsSymbolQuints , slangSymbolQuints! !

!SlangBrowser methodsFor: 'controls' stamp: 'jpb 5/31/2020 20:56:18'!
selectedMessage
	"Answer a copy of the source code for the selected message."
	self showingCSource
		ifTrue: [ ^self translatedCSource ].

	self showingJSSource
		ifTrue: [ ^self translatedJSSource ].
		
	^super selectedMessage! !
