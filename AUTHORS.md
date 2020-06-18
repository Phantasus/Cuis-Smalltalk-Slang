# Authors

This file contains the list of authors who contributed indirectly or directly
to some parts of the packages. The contained code fragments were taken from
projects which all release using an MIT License (Cuis-Smalltalk-Dev version of VMMaker,
SqueakJS VMMakerJS).

## Original authors of VMMaker (Old Cuis version)

Derived from the Cuis-Smalltalk-Dev https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev.git
This was the commit from which the Slang-Tools were initially forked from:

> $ git log CompatibilityPackages/VMMaker.pck.st 
> commit 234740dd4ac8b8f1d94ba3134f55fb58795472b4
> Author: Juan Vuletich <juan@jvuletich.org>
> Date:   Wed May 20 10:35:11 2015 -0300
>
>   Added package description to VMMaker

Extraction of method signatures revealed the following author signatures:

    - Andrew C. Greenberg (acg) 
    - Andreas Raab (ar)
    - ? (asf)
    - ? (ATG)
    - Dan Ingalls (di)
    - Dave Lewis (dtl)
    - Eliot Emilio Miranda (eem)
    - Henrik Gedenryd (hg)
    - Ian Piumarta (ikp)
    - John Maloney (jm)
    - John McIntosh (JMM)
    - Juan Vuletich (jmv)
    - Lex Spoon (ls)
    - Mats Nygren (mn)
    - Ned Konz (nk)
    - Stefan Matthias Aust (sma)
    - Tim Rowledge (tpr, TPR)

This list of authors were extracted from the first selection of the
VMMaker.pck in "Cuis-Smalltalk-Dev/CompatibilityPackages/VMMaker.pck.st".
Where a few classes were extracted into Slang-Tools.pck.st and then the
contributors in that initially exported packages were recorded with 
the following oneliner:
> grep 'methodsFor:.*stamp:' References/Slang-Tools*.st | sed "s/^.*stamp: '([^ ]*) [^']+'.*$/\1/g" -E | sort | uniq

The used starting point of the extraction was the VMMaker.pck.st,
which has the following sha256sum, which is for reference located
in References/VMMaker.pck.st:
> 4f9e3c408ca3d66c018f3156e740e1bc9f36d2bff5c8f409acbf6d09cc64ec40

The first extracted version of the Slang-Tools.pck.st on which
the above list of authors was based is located in References/Slang-Tools.pck.st
and has the sha256sum:
> 361afa369be535b22d442230df8a69fad41b5c1b6070e3a8aeedc52bd93d1dd6

The other first extracted file was the Slang-Tools-Tests.pck.st which
contained a couple of interesting testcases and was used to generated
the above list of contributors. For reference it's located in References/Slang-Tools-Tests.pck.st
and has the sha256sum:
> 42c0d085b61d0b2b96dfa70ac5ef7ff9026f8def4f6d7defe70a195441384ea6


## Authors of the VMMakerJS parts

The javascript generating parts were taken from the SqueakJS VMMaker package.
The newest versions were taken from the http://source.squeak.org/VMMaker repositories
of the last commit VMMakerJS-dtl.18 which was made 29. February 2020 at 02:02:21 pm.

These parts were mostly written by Vanessa Freudenberg.

Other authors of VMMakerJS include:

    - Andrew C. Greenberg (acg)
    - Andreas Raab (ar)
    - Bert Freudenberg (bf)
    - Dave Lewis (dtl)
    - Eliot Emilio Miranda (eem)
    - Henrik Gedenryd (hg)
    - Ian Piumarta (ikp)
    - John Maloney (jm)
    - John McIntosh (JMM)
    - Lex Spoon (ls)
    - Ned Konz (nk)
    - Stefan Matthias Aust (sma)
    - Tim Rowledge (tpr, TPR)

These authors were extracted from the filed out "VMMakerJS-Translation to JS.st"
by this oneliner:
> grep stamp: VMMakerJS-Translation\ to\ JS.st | sed "s/^.*stamp: '([^ ]+) [^']+'.*$/\1/g" -E | sort | uniq

This file is for reference located in References/VMMakerJS-Translation to JS.st
and has the sha256sum:
> ce91e15a616027e4a27de58f2f2a0b0f52220afa3d4d99546e41521f893f4b10


## Initial refactoring of VMMaker Slang into Cuis Slang

The restructuring, refactoring and deletion of old code was done by
Josef Philip Bernhart (jpb) so that it fits into Cuis Smalltalk and
it's view of the world. For this classes were deleted, files were filed
out and filed in again, carriage returns were translated to newlines,
new tests were written, old VMMaker specific classes were rewritten, etc.

The AUTHOR.md, LICENSE.md, LICENSE-VMMakerJS.md (Copied from SqueakJS
repository), LICENSE-CuisVMMaker.md (Copied from Cuis-Smalltalk-Dev
repository) were created/copied by him on the 16th May 2020.

The sha256sum of these different license files of the same license
MIT License are:

> 3b343f04576d0ad22b0fbcdc6211e9056bcbb6159a0f2636fe6a779052e1223b  LICENSE-CuisVMMaker.md
> 224d6f6dd8bafc9875152b10972cd18c1ffc2bbe17ab23c7c28590b9c0243fa8  LICENSE.md
> 62d433668564d31067f2e2fbe4d039253c581c07b86ae19bc9f856ae45ae8e4c  LICENSE-VMMakerJS.md

The only difference of these files are the copyright notices.


## Authors of re-imported SmartSyntaxPlugin related classes back in (23th May 2020)

Saved for completeness selected exports from the VMMaker image for re-integrating
the newest versions of the VMMaker versions of the plugin interfaces. Initially
these classes were removed, because their exact purpose wasn't clear and they
caused of their specific implementations that the associated unit tests break.

> Name: VMMaker-dtl.415
> Author: dtl
> Time: 19 April 2020, 5:30:30.208 pm
> UUID: 747f8591-57e6-4950-858a-c7fbc22ad1c2
> Ancestors: VMMaker-dtl.414

The sha256sum of these different files, they are 1:1 the exact filed out files,
except that carriage returns were replaced by newlines before running the sha256sum
over them, so that they can be imported into a running Cuis Image.

> 6c7d77c8e049cf7f9d23f295954a8da85d757bb89dc059e25c5bca344a090a26  References/InterpreterPlugin.st
> f18d43c4f5ed6e175ff9f2b38120da1cd35837b38ede31d0e988e915c8d4f309  References/Oop.st
> a9cb2fa666499d9a23c3631dc653976e3164eb7b027efdc8c1530aa2e1cd7eca  References/SlangTestSupportSSIP.st
> 484931acc74cc8d9ba3aefbdba07dc6e500b4b54c8ae49e635929fc70295ffce  References/SlangTest-testing smart syntax.st
> 5ebf413bb9b730c025e40def213943867fa8943e676a98c8c48ee3147e5a23cd  References/SlangTest-testing ssip plugins.st
> 4e23b1f3741d45541cf03bcb0c5991acfae51cc8548b72c765034ef5c52e6821  References/SmartSyntaxInterpreterPlugin.st
> 2bf0bf533e33c2540723da0729c6fd81952888c503c0994cbb7e09c2bab6a7d1  References/SmartSyntaxPluginCodeGenerator.st
> 25c54b3643f2f1955754178b08692870831ba967b1457cd1fe5a47ac83f258bb  References/SmartSyntaxPluginTMethod.st
> cf84c89577c39079364ab93830cfbd14ad0c75389541b8c2ba169c75332a1dba  References/Unsigned.st

Contributors of these files are:

    - Andrew C. Greenberg (acg)
    - Anthony Hannan (ajh)
    - Andreas Raab (ar)
    - Bert Freudenberg (bf)
    - Dave Lewis (dtl)
    - Eliot Emilio Miranda (eem)
    - Esteban Lorenzano (EstebanLorenzano)
    - Ian Piumarta (ikp)
    - Ronaldo M. Ferraz (RMF)
    - Stefan Matthias Aust (sma)
    - Stephan Rudlof (sr)
    - Tim Rowledge (tpr / TPR)
    - Yoshiki Ohshima (yo)

## Authors of Matrix2x3Plugin (8th June 2020)

The Matrix2x3plugin was exported from the `VMMaker (dtl.415)`
as a base minimal plugin for testing the plugin generation capabilities
of Slang. The line endings were changed from CR to linefeeds before
adding it to the repository.

The sha256 sum is:
> 4dff486af12ace8572be24be04a676b16eac83d412bdb63d09bcfe2fbcfda1e3  References/Matrix2x3Plugin.st

The original contributors of this plugin are:

    - Andreas Raab (ar)
    - Dave Lewis (dtl)
    - Eliot Emilio Miranda (eem)
    - Stefan Matthias Aust (sma)
    - Tim Rowledge (tpr)

## Authors of InterpreterProxy (18th June 2020)

The interpreter proxy class was exported for maybe later building
an opensmalltalk-vm plugin simulation. It was extracted from
`VMMaker.oscog-eem.2744`. The `VMBasicConstants` class is a shared
pool and is inicluded in the interpreter proxy. The carriage returns
were replaced by newlines before applying sha256sum to it.

The sha256 sums are:
> cd5f7b7f6fc882db7eef68fa492069e84ecb48e55642a1407bfc07cde964b1b0  References/InterpreterProxy.st
> 66d5d910dc13b344e3b9e76cc4fdee739e4773bfd04f4591abc00e5761e17575  References/VMBasicConstants.st

The original contributors of these classes were:

    - Andrew C. Greenberg (acg)
    - Andreas Raab (ar)
    - Dave Lewis (dtl)
    - Eliot Emilio Miranda (eem)
    - Nicolas Cellier (nice)
    - Tim Felgentreff (tfel)
    - Tim Rowledge (tpr)
    - Levente Uzonyi (ul)

