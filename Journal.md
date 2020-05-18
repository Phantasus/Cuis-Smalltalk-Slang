# Project journal

This file is intended to record the history of this project. So that
when it get's abandoned people can take it up again from where it was
left off. The rule of the structure is that newest is at top, oldest
entry is at the bottom. And people mention the author of the entry
by his shortcut. Also people add their shortcuts to the list of
authors at the end of the file.

# Entries

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
