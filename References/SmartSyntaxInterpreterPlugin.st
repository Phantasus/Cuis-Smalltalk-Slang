'From Squeak5.3 of 3 March 2020 [latest update: #19431] on 23 May 2020 at 7:24:50 pm'!
InterpreterPlugin subclass: #SmartSyntaxInterpreterPlugin
	instanceVariableNames: 'simulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'VMMaker-SmartSyntaxPlugins'!
!SmartSyntaxInterpreterPlugin commentStamp: '<historical>' prior: 0!
Subclass of InterpreterPlugin, used in connection with TestCodeGenerator for named primitives with type coercion specifications!


!SmartSyntaxInterpreterPlugin methodsFor: 'accessing' stamp: 'eem 10/3/2010 08:31'!
simulator
	<doNotGenerate>
	^simulator! !

!SmartSyntaxInterpreterPlugin methodsFor: 'accessing' stamp: 'eem 10/2/2010 10:02'!
simulator: aSmartSyntaxPluginSimulator
	<doNotGenerate>
	simulator := aSmartSyntaxPluginSimulator! !


!SmartSyntaxInterpreterPlugin methodsFor: 'debugging' stamp: 'sr 12/24/2001 00:29'!
sqAssert: aBool 
	self
		debugCode: [aBool
				ifFalse: [self error: 'Assertion failed!!'].
			^ aBool]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SmartSyntaxInterpreterPlugin class
	instanceVariableNames: ''!

!SmartSyntaxInterpreterPlugin class methodsFor: 'private' stamp: 'tpr 6/9/2003 16:36'!
codeGeneratorClass
	"return the appropriate class of code generator for this kind ofplugin"

	^SmartSyntaxPluginCodeGenerator! !


!SmartSyntaxInterpreterPlugin class methodsFor: 'instance creation' stamp: 'tpr 6/28/2003 17:28'!
doPrimitive: primitiveName withArguments: argArray
	| proxy plugin |
	proxy := InterpreterProxy new.
	proxy loadStackFrom: thisContext sender.
	plugin := (self simulatorClass ifNil: [self]) new.
	plugin setInterpreter: proxy.
	^plugin perform: primitiveName asSymbol withArguments: argArray! !


!SmartSyntaxInterpreterPlugin class methodsFor: 'translation' stamp: 'tpr 6/9/2003 16:44'!
shouldBeTranslated
"SmartSyntaxInterpreterPlugin should not be translated but its subclasses should"
	^self ~= SmartSyntaxInterpreterPlugin! !


!SmartSyntaxInterpreterPlugin class methodsFor: 'simulation' stamp: 'tpr 6/28/2003 17:28'!
simulatorClass
	"For running from Smalltalk - answer a class that can be used to simulate the receiver, or nil if you want the primitives in this module to always fail, causing simulation to fall through to the Smalltalk code.
	By default SmartSyntaxInterpreterPlugin answers nil because methods in these plugins are intended to be embedded in code that pushes and pops from the stack and therefore cannot be run independently.  This wrapper code is generated when translated to C.  But, unfortunately, this code is missing during simulation.  There was an attempt to simulate this, but only the prologue code (getting arg from the stack) is simulated (see simulatePrologInContext:). The epologue code (popping args and pushing result) is not.  So I am making this nil until this can be fixed.
	Also, beware that primitive methods that take no args exactly match their primitive name (faking out InterpreterSimulator>>callExternalPrimitive:).  They should only be called from within wrapper code that simulates the prologue and epilogue.  Primitive method that take args don't have this accidental matching problem since their names contain colons while their primitive names do not. - ajh 8/21/2002"

	^ nil! !
