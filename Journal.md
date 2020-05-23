# Project journal

This file is intended to record the history of this project. So that
when it get's abandoned people can take it up again from where it was
left off. The rule of the structure is that newest is at top, oldest
entry is at the bottom. And people mention the author of the entry
by his shortcut. Also people add their shortcuts to the list of
authors at the end of the file.

# Entries

## 23th May 2020 (jpb)

Today there was a Jitsi Meeting with Cuis developers and the
topic of a faster call of external libraries came up. For this
case the current old Squeak FFI interface which is used by
Cuis is for rapid callbacks too slow as it seems to do too much
conversions. So the case for packaging external libraries as
external VM plugins came up. To my suprise there would be a
concrete usecase for my current extracting efforts of Slang
as I would also want to use it for calling a library.
That's energizing, but sadly also stressful. How do I get
that done correctly?

What makes a `SmartSyntaxPlugin` "smart"? It seems to generate
code in a different way, but that is the only thing I can deduce
from skimming over it. It adds again multiple special typecasting
methods on different object classes, which isn't great.


## 21th May 2020 (jpb)

Today I wrote a small [Design document](docs/Design.md) which has
only the intention of showing what is the broad structure of the
Slang package, when I don't lose focuse I'll add to it during the
progress of this "enterprise".

I found and interesting tutorial about writing interpreters in
[PyPy](https://morepypy.blogspot.com/2011/04/tutorial-writing-interpreter-with-pypy.html)
which can contribute a couple of ideas of using it at some time in
the future, IF the project progresses that far, for how Slang is
supposed to feel like when writing an interpreter. Usability is a big
thing.

Renamed `isTypePointerToStruct:` to `isTypedPointerToStruct:`, because
I think it reads a little bit more nicely. As it's about the the pointer
is typed and not the type pointer .. whatever. I added a specialized
repository for looking up types called `SlangCTypeRepository` for handling
these issues as currently this is implemented by delegating wild into the
class hierarchy and returning `false` on an error if `isTypePointerToStruct:`
is not implemented. This is according to my always flawless taste about code
(That is supposed to be ironic) the better choice of handling this.

I renamed `cCoerceSimple:to:` to `coerceSimple:to:` as this fits more
into my interpretation of Slang. When writing code I don't want to always
say with my method usages, that it's a C construct. I mean type coercion
is not in this case a C construct, but a Slang construct. So what is Slang?
Surely a typed language with really simple types like integers, strings,
structs, pointers and arrays. Which can be implemented on the translation level
with some hacks ontop of other languages which implement some superset of C.

What really would be interesting is if you could pass into a code generator
any object and it will try to translate it to C or any supported programming
language. So that would mean in that case, that the input object is written
in a way, which is "almost Slang" as only something supported in Slang
could be translated. That would be an intriguing property, but how would you
do that without changing the input object? In the past Slang inlined it's
methods under the "*VMMAker C translation" category on the `Object` class,
which made all objects potential inputs, but do I need to do that?


## 20th May 2020 (jpb)

Yesterday I removed a couple of unreferenced methods, which sometimes
weren't even referenced in the Squeak VMMaker image I have here to
check against certain in Cuis unimplemented methods like 
`#monticelloDescription`. I removed them or rewrote them, I still
need to do that a couple of times until I covered all the small
part which I initially extracted from VMMaker. You can easily get
lost in the codebase. All these conversions from translation methods
which call arbitrarily methods on the code generator and so on.

The CodeGenerator is a big class, too big actually. It does a lot of
stuff and has the feeling of a control box of some sort where a lot
of high-voltage loaded wires stick out and you don't touch them or
you get electrocuted.

Good that I'm not intending to be compatible with the VMMaker,
that would make any change hard and I'm doing that in my free time,
why should I endure pain which I only accept for payment? That's
also the charme of Cuis Smalltalk, saying a big fat NO! To
realities of software development. In the end it's the only
way to go longterm, to restructure parts of a software system
so that the authors understand it again.

Got some nice feedback from Juan:

> I also think it is a great idea. I always thought that VMMaker should be 
> split in several packages, one of them PluginMaker part (Not support for 
> the whole vm, GUI, simulation, but just slang to c conversion for 
> plugins). PluginMaker should be easy to port to all Squeak dialects.
>
> Cheers,
> Juan Vuletich

Well, then this gives atleast some input of how, if I find
the motivation, to proceed this project.

I added further testcases to the codebase. Removed other not
referenced methods, it's sad to remove stuff which seems to
have hooks in the VMMaker, while barely understanding the
inner workings of the whole system. But when it's not referenced
in this subworld then it's not needed in my world.


## 18th May 2020 (jpb)

Today I added an FAQ and this journal at the end of the day. I also
updated the current work image of it, without yet checking in again.

I wonder how I can restructure core of Cuis Slang with making it
actually understandable and still retain an almost correct resemblance
with the VMMaker Slang. Should it even be compatible? Should it burn
bridges? Would it then not be better to just use one of the other
lowlevel highlevel languages? Lowtalk? An easy scheme variation? SBCL?

There must be a position in between these extremes of writing a full
fledged implementation of a lowlevel programming language and no
implementation at all!

What is the reason for doing this? The initial stuff I did was to
extract the core of slang out of Cuis VMMaker over the weekend and
changed it around so that some of the existing tests passed. I
want to bundle plugins with Cuis packages and putting everything
needed for that into that package. Storing C code into strings
and serializing them out to the filesystem for compilation is
error prone and ugly. Using a full language implementation get's
easily out of hand and requires a context switch in the head for
writing it, then I would prefer to just code the plugin in C and
include the C files and header files with the package.

I need to make up my mind. What is the exact project scope?
I want easier FFI plugins, I want to ability to take one piece
of code and let the system handle the translation to a different
programming language, so I don't want to write again the same thing
again and again over and over.

Well, maybe this project is a documentation of why this dream
of transpiling, not writing code twice or simulation based development
is just a pipedream of idealists.

That could make it worth doing.


# Authors

- Josef Philip Bernhart (jpb)
