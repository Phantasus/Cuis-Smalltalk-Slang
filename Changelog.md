# Introduction

This file lists the history of changes made to the repository
in a more wordy fashion of what this was about as an addition
to descriptive commit messages.

## Update 0.001c

Affected versions
  Slang-Tools 1.18, Slang-JavaScript 1.12, Slang-Tools-Tests 1.2, Slang-PluginMaker 1.2

Removes a good amount of the carriage returns from generated code. 

## Update 0.001b

Affected versions
  Slang-Tools 1.16, Slang-JavaScript 1.10, Slang-Tools-Tests 1.2, Slang-PluginMaker 1.2

Previous updates had occured in the meantime. This exported
state changes that some `is*` were moved to `is:` implementations
in the `SlangTParseNode`. Besides this change:

1. Selectors supported by VMMaker Slang were removed:

- `isDefined:inSmalltalk:comment:ifTrue`
- `cCode:inSmalltalk:`
- `cCode:`
- `cppIf:ifTrue:ifFalse:`
- `isDefined:inSmalltalk:comment:ifTrue:ifFalse:`
- `isDefined:inSmalltalk:comment:ifTrue: .`
- `isDefinedTrueExpression:inSmalltalk:comment:ifTrue:ifFalse:`
- `preprocessorExpression:`
- `cPreprocessorDirective:`

2. Adds the "PluginMaker" package, which is at the momemnt
   more a parking ground for classes which are going to be
   deleted or used for constructing actual plugins. I
   actually don't know what I do with them.


## Update 0.001a

Affected versions
  Slang-Tools 1.8, Slang-JavaScript 1.6, Slang-Tools-Tests 1.1
  
Previous interim updates also occured. They were partly done
just to store the current workprogress. This update is only
meant to record the big strokes which were made between 0.001 and
this update:

1. `cCoerce:`, `cCoerceSimple:To:` were renamed to `cCoerce:`,
   `coerceSimple:To` just to drop the C language specifity of
   these constructs as other lowlevel languages have conversion
   facilities too.
   
2. Adds `SlangObject` as superclass for parts of the Slang
   framework to represent an adapter class between the Slang
   classes and the environment Smalltalk System, which should
   make upcoming porting easier.

3. Adds `SlangCTypeRepository` which is a repository of C type
   information. Repository just means some kind of Database like
   in Martin Fowler's definition of the repository pattern. Surely
   I maybe use it incorrectly, but the idea is to have a place to
   store these things, which are outside of the code generator,
   so the code generator gets smaller.
   
4. "Fixes" the Undeclared class references, so that they point
   to the currently correct classes. I marked the methods which
   use the currently not implemented `emitJS*` methdos with
   `self flag: #fixme` sadly not all.
   
5. Removed `isTypePointerToStruct:` from the class and moved it
   to the `SlangCTypeRepository`, so that these things can be
   replaced, configured and tested.
   

## Update 0.001

Affected versions
  Slang-Tools 1.4, Slang-JavaScript 1.2, Slang-Tools-Tests 1.1

Is a highly expiremental and work in progress status update.
Production use or any other use besides looking around at it
and giving feedback to the "author" is discuraged. The VMMaker
extracted SlangTest and partially removed testcases now pass.
Which means that some of the basic functionality in the C
related part of Slang code generation works as it was intended
in VMMaker.

Adds this Changelog file and the other initial commits and
references of base packages. So some of the initial work
of refactoring slang to a package was achieved successfully,
yeah?!
