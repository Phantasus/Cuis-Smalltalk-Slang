# About Cuis Slang

Cuis Slang is a port and re-imagination of Slang. And now what is Slang?
Slang is a variation of Smalltalk which is so reduced to be used only
for writing lowlevel code. Slang was used in the Squeak Smalltalk System,
on which Cuis-Smalltalk is based on for writing parts of the Squeak VM.
There Slang can be found in the VMMaker project which contains the Slang
code generation and the actual VM implementation. In this original use
Slang was used for writing the portable parts of the VM whereas the
platform specific parts where located in platform specific C files.
The whole configuration of this original use can be found in the 
https://github.com/OpenSmalltalk/opensmalltalk-vm repository and
also the VMMaker repository located at (http://source.squeak.org/VMMaker).
Here the wiki documentation regarding this original use: https://wiki.squeak.org/squeak/2105

Cuis Slang in contrast to the VMMaker version of Slang is not intended (yet?)
for building a whole VM, but for writing FFI loaded plugins and other more
general small programs which should be portable.

## Why Slang?

Slang is as written above a reduced subset of Smalltalk for lowlevel plumbing,
in this regard Slang is useful for representing the same program in Smalltalk,
simulating the behaviour there and then translating it to different output
languages.

## How does Cuis Slang differ from VMMaker Slang?

Cuis Slang is thought to be more general, it was adapted specifically to this
task of translating objects into programs which follow a specific pattern of
programs. So for example cookie cutter plugin code, which should follow a specific
form for performance, security or maintainability reasons. The VMMaker slang
is specifically tailored for C translation of VM Code.

Also Cuis Slang has a little bit of higher ambitions than VMMaker Slang,
it's intended to be translated into different languages and not just C,
so all features which were too specific for C were changed to be more in
a more general way useable.

Codewise Cuis Slang is based on the VMMaker Slang and the SqueakJS version
of Slang, so there are areas which look similiar, but were adapted to Cuis
and the original intention of being not just for VMs.
