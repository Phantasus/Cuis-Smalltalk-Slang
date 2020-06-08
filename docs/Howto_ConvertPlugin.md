# Howto convert a VMMaker Plugin to a Cuis Slang Plugin?

## Introduction

This is supposed to be a guide for converting an existing VMMaker
plugin to a Cuis Slang plugin. The current state of this document
is work-in-progress as the whole framework is not in an useable state.

## Step 1: File-out and convert line endings

As VMMaker plugins normally reside on Squeak Smalltalk, they need
to be explicitly filed out to a `.st` file. So right-click on the plugin
class and select `fileout`. Then go to the command line and convert the
line endings with `cat <plugin-class>.st | tr '\r' '\n' > new-<plugin-class>.st`.

Open the target image with Cuis Slang loaded and click on the desktop and select
`Open > File List`. Then select the `new-<plugin-class>.st` and select file-in
in the File List window.

## Step 2: Change the class

Go to the imported plugin class in the SystemBrowser and change the parent class
to `SlangPlugin`.

## Step 3: Change VMMaker Slang method selectors

Change VMMaker specific method selectors to the Cuis Slang versions of these selectors
or when no mapping is present, then just delete or re-organize the code.

`cCoerce:to:` to `coerce:to`
`declareCVarsIn:` to `declareVarsIn:`


# Authors
  - Josef Philip Bernhart (jpb)