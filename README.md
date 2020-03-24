Project
-------
bannerji (shortened from "banner emoji")

Install
-------
`````r
devtools::install_github("opendatasurgeon/bannerji")
library(bannerji) 

#then enter 1 and choose to "1. ALL"
`````
OS Support
----------
UNIX based only! *(i.e. Mac OS, Linux OS etc.)*

Note
--------
Emoji rendering is not possible at the moment in Windows OS due to Windows NT/OS-2 UTF-8 encoding issues. Ignore the `"Rtools required to build packages..."` warning, if it occurs. It occurs randomly on various machines due to me including binary release within same github repository.

Project Description
--------------------
A micro-mini R package that transforms & plots a user's traits to their emoji-equivalent values.
You can use this to make emoji-traits banner that is personal to you. Useless, but still worth 10 seconds of your time.

*Documentation and more details are in .tar files*          
*Initial emoji library was provided by [Muan](https://github.com/muan/emojilib)*   
*Not worthy of CRAN, believe me.*

Example
-------
1) This is an output from `bannerji::plotMyTraits(c("Happy", "American", "Curious", "Angel"))`      
![Image](https://github.com/opendatasurgeon/bannerji/blob/master/functionDisplay/dna.png?raw=true)

Author
-------
Mihir Patel

Status
------
Working: version 0.1.0      
Next changes: More traits, space key support/better search tools

Language
---------
R

Imported Packages
----------
igraph, rjson

License
--------
MIT
