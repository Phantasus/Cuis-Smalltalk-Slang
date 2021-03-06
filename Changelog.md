# Introduction

This file lists the history of changes made to the repository
in a more wordy fashion of what this was about as an addition
to descriptive commit messages.


## Update 0.001j2

Affected versions:
- Slang-C 1.22
- OSVMPluginMaker 1.8
- Slang-Examples 1.4
- Slang-Kernel 1.12

Adds further definitions copied from `sqVirtualMachine.h` to the
`OSVMPluginHeaderBuilder` still a couple of lines to go to have the
full InterpreterProxy covered. Reformats the Matrix plugin so that
it is readable a little bit more. Fixes an issue with C language
code writer, so that indentation now works, I like readability
and my own definition of it, which is currently the only truth.


## Update 0.001j1

Affected versions:
- Slang-C 1.21
- OSVMPluginMaker 1.7
- Slang-Examples 1.3

Adds the OpenSmalltalk-VM (OSVM) PluginMaker, which is not
to be confused with the `Slang-PluginMaker.pck.st` package,
which currently only holds old stuff yet-to-be-refactored or
thrown away. Adds some minor cleanups here to other packages.
Besides that the `InterpreterProxy` from VMMaker is added so that
in theory plugins could be "simulated". Adds also the `OSVMPluginHeaderBuilder`
which builds plugin headers from the current image to VM introspection
settings.


## Update 0.001i1

Affected versions:
  - Slang-C 1.18
  - Slang-JavaScript 1.26
  - Slang-Kernel 1.11
  - Slang-Tools 1.26
  
Moves the Slang Browser code content generation quints into the `Slang-Tools`
package and adds adding the translate to X selectors only when the generator
classes are loaded. In the past the extension category caused an error
on loadtime of the package as Slang-C or the js version weren't present.

## Update 0.001k2

Affected versions:
  - Slang-Tools 1.27
  
Fixes an issue which was caused by a recent refactoring of the language
writers. So only streams are supported which support language specific
serialization extensions.

  
## Update 0.001k1

Affected versions:
  - Slang-C 1.17
  - Slang-Examples 1.1
  - Slang-JavaScript 1.25
  - Slang-Kernel 1.11
  - Slang-Tools 1.25
  
Removed the explicit `-Test.pck.st` packages as the package
tool didn't correctly detect that `Slang-Kernel` and `Slang-Kernel-Tests`
are two separate packages, so classes which were defined for `Slang-Kernel-Tests`
were visible in `Slang-Kernel`. So just deleting them until I find a better
naming scheme for the packages.


## Update 0.001k1

Affected versions:
  - Slang-C 1.17
  - Slang-Examples 1.1
  - Slang-JavaScript 1.25
  - Slang-Kernel-Tests 1.0
  
Adds `Slang-Examples` packages which contains examples of howto
use Slang as this is all a highly experimental work-in-progress,
this is too is unfinished. The first addition is the Squeak VMMaker
`Matrix2x3Plugin`. Adapts the `Slang-C` so that the complexer matrix
plugin can be generated with the `SlangCCodeGenerator`. Also adds
to the `Slang-JavaScript` package the code needed to generate a
javascript version of the matrix plugin. Also fixes the testcases
with the changed code. Adds also a first version of a "Howto" guide
of howto port an existing vmmaker plugin to Cuis Slang.

## Update 0.001j2

Affected versions
  - Slang-C 1.12

Adds OpenSmalltalk VM header generation using the predefined
standard GCC macros `__SIZEOF_INT`, etc.

## Update 0.001j1

Affected versions
  - Slang-Tools 1.25
  - Slang-C 1.11
  - Slang-C-Tests 1.2
  - Slang-Javascript 1.24
  - Slang-Kernel 1.8
  - Slang-Kernel-Tests 1.0
  - Slang-Tools 1.25

Adds to `SlangWriter` auto indentation for better indentation of
source code. Adds `SlangOSVMHeaderBuilder` for generating plugin
header files. I still need a way of finding out the size of `int`
on the platform so that it works with `sqInt`. Maybe generating
a program which generates a program so that `sizeof(int)` works
at generating the source code. As I have notice that `#if (sizeof(int) == 8)`
doesn't work in C. One behaviour I wasn't expecting.


## Update 0.001i1

Affected versions
  - Slang-Tools 1.25
  - Slang-C 1.6
  - Slang-C-Tests 1.2
  - Slang-Javascript 1.23
  - Slang-Kernel 1.5
  - Slang-Kernel-Tests 1.0
  - Slang-Tools 1.25

Removes unimplemented messages. And adds the `SlangWriter`,
replaces also calls to `crtab` with `newLine; tab`.


## Update 0.001h1

Affected versions
  - Slang-Tools 1.25
  - Slang-C 1.4
  - Slang-C-Tests 1.2
  - Slang-Javascript 1.21
  - Slang-Kernel 1.3
  - Slang-Kernel-Tests 1.0
  - Slang-Tools 1.25
  
Sets default to non-`static` methods (so public). Removes
generation of `vm_exports` and builtinfo generation. Also
adds escaping of Strings so that they can be stored into
C strings. Replaces the usage of a dumb `ReadWriteStream`
for all the C code generation codes and uses instead a
wrapped stream in `SlangCLanguageWriter`.

## Update 0.001g1

Affected versions
  - Slang-Tools 1.25
  - Slang-C 1.3
  - Slang-C-Tests 1.2
  - Slang-Javascript 1.20
  - Slang-Kernel 1.2
  - Slang-Kernel-Tests 1.0
  - Slang-Tools 1.4
  
Adds a `SlangConformist` which encapsulates the knowledge of what
a Slang construct is and what is not. Removes `preIncrement`, `postIncrement`,
`generateBaseHeaderSize`, `bytesPerWord` as these were not used in
the codebase or were leaking C abstractions to begin with (`++` and `--`
are questionable).


## Update 0.001f1

Affected versions
  - Slang-Tools 1.24
  - Slang-C 1.1
  - Slang-C-Tests 1.2
  - Slang-Javascript 1.18
  - Slang-Kernel 1.0
  - Slang-Kernel-Tests 1.0
  - Slang-Tools 1.4
  
Modularizes the Slang packages so that the C specific stuff goes into
Slang-C, the Tools related stuff is now placed in Tools (like Browser UI)
and the Basic functionality stuff is put into the Kernel, which has a
lower version number because it was created afterwards. Earlier the Slang-Tools
package contained everything.


## Update 0.001e1

Affected versions
  Slang-Tools 1.21, Slang-JavaScript 1.16, Slang-Tools-Tests 1.2, Slang-PluginMaker 1.2

Adds to SlangBrowser to translate to JavaScript and to the Slang-JavaScript package
to print source without ending the basic constructs with CRs.

## Update 0.001d2

Affected versions
  Slang-Tools 1.20, Slang-JavaScript 1.14, Slang-Tools-Tests 1.2, Slang-PluginMaker 1.2

Adds the SlangBrowser, a standard browser which can also translate methods to C
using the SlangCCodegenerator.


## Update 0.001d1

Affected versions
  Slang-Tools 1.19, Slang-JavaScript 1.13, Slang-Tools-Tests 1.2, Slang-PluginMaker 1.2

Adds from the VMMakerJS the actual implementations of the translation parse nodes
vmmaker-js implementations. For historical records. These methods were originally
written by Bert Freudenberg.

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
