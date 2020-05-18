# Frequently Asked Questions (FAQ)

## Q: Can Cuis-Slang be used as a 1:1 replacement of the existing VMMaker implementation?

Short answer: No. Cuis Slang isn't intended to be a replacement for the
production VMMaker version of Slang. VMMaker Slang is VMMaker Slang and is
good in it's role. The Cuis Slang packages original intention was to
have a simplified framework in place with which FFI plugin libraries can
be generated and shipped with external FFI interfacing Cuis packages.

For this scenario it was optimized and re-designed. Also the VMMaker
version of Slang has a different class hierarchy, different methods
and different style of structuring things, probably for historical
reasons. For example the Interpreter in VMMaker Slang is a subclass
of InterpreterPrimitives, which the author of this answer finds
highly non-intuitive.


## Q: Why don't you just use [Lowtalk](https://github.com/ronsaldo/lowtalk)?

Lowtalk is a Pharo Smalltalk specific implementation of a general lowlevel
dialect of Smalltalk, so a full language. It's bigger and more tailored
to pharo. This means it's more complex and this is again harder to
maintain. Also the design of it is targeted for putting the source code
of it into files, transpiling/compiling them to the output. This 
is itself a valid direction for this kind of translation, but not of
how the author wants it: no bells and whizzles, just have the basic
infrastructure for translating and simulating code.

And as of the time of writing some of the parts of it isn't clearly
marked as MIT License, whereas the author wants to reduce the possibility
of being sued.
