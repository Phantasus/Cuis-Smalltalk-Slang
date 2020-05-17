# Differences from the VMMaker implementation of Slang

Here the differences from the VMMaker implementation of Slang
are discussed. The VMMaker version of Slang is a more pragmatic
implementation, which had at the time of it's construction just
C as it's backend and so it was tailored to just C.


## Removal of C specific constructs

At the time of writing there is a problem by depending on C.
On one hand you have platforms out there which are not written in C
and pushing to not introducing C (e.g IOS, Android), then there are
the security issues with C and new languages are pressing into
removing C (e.g Go, Rust).

Cuis Slang uses `var:declare:`, `returnType:` instead of `var:declareC:`,
`returnTypeC:` as it tries to be less specific to C. But instead
to define an interface which can be translated into different target
languages.
