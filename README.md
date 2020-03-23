Project
-------
Bannerji (shortened from "Banner Emoji")

Install
-------
`````r
devtools::install_github("opendatasurgeon/bannerji")
library(bannerji) 
`````
OS Support
----------
UNIX based only! *(i.e. Mac OS, Linux OS etc.)*

Note
--------
Emoji rendering is not possible at the moment in Windows OS due to Windows NT/OS-2 UTF-8 encoding issues. Ignore the `"Rtools required to build packages..."` warning, if it occurs. It occurs randomly on various machines due to several dependencies of this package.

Project Description
--------------------
A micro-mini R package that transforms & plots a user's traits to their emoji-equivalent values.
You can use this to make emoji-traits banner that is personal to you. Useless, but still worth 10 seconds of your time.

*Documentation and more details are in .tar files*          
*Initial emoji library was provided by [Muan](https://github.com/muan/emojilib)*   
*Not worthy of CRAN, believe me.*

Example
-------
1) This is the output from `bannerji::plotMyTraits(c("Happy", "American", "Curious", "Angel"))`      
![Image](https://github.com/opendatasurgeon/bannerji/functionDisplay/dna.png?raw=true)

Author
-------
Mihir Patel

Status
------
Working (version (0.1.0))

Language
---------
R

Imported Packages
----------
igraph, rjson

License
--------
MIT
