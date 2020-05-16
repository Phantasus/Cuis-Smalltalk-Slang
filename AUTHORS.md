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
