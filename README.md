Project
-------
bannerji (shortened from "banner emoji")

Install
-------
`````r
devtools::install_github("opendatasurgeon/bannerji")
library(bannerji) 

#then enter 1 to choose "1. ALL"
`````
*Not worthy of CRAN, believe me.*

OS Support
----------
UNIX based only! *(i.e. Mac OS, Linux OS etc.)*

Note
--------
Emoji rendering is not possible at the moment in Windows OS due to Windows NT/OS-2 UTF-8 encoding issues. So for some emojis you may see their unicode encodings, but when you plot them with `plotMyTraits` you will see the emoji character within the saved plot.

Ignore the `"Rtools required to build packages..."` warning, if it occurs. It occurs randomly on various machines due to me including binary release within same github repository.

Project Description
--------------------
A micro-mini R package that transforms & plots a user's traits to their emoji-equivalent values.
You can use this to make emoji-traits banner that is personal to you. Useless, but still worth 10 seconds of your time.

*Documentation and more details are in .tar files*          
*Initial emoji library was provided by [Muan](https://github.com/muan/emojilib)*   

Example
-------
So far the package has four functions along with appropriate error notification if they occur:

1) **displayAlltraits(takes)** takes nothing and returns a dataframe which can be saved and written to a file. This dataframe contains a "traits-dictionary" which lists all of the unique emojis association for traits. 

    `> traits_df <- bannerji::displayAlltraits(takes= NA)`    
    `> traits_df[1:5, ]`
    ![Image](https://github.com/opendatasurgeon/bannerji/blob/master/functionOutputs/displayall.png?raw=true)

2) **getEmojiFromTheTrait(aTrait)** takes single character trait. If the trait is in the "traits-dictionary" then its associated emoji is returned, otherwise *character(0)* is returned.
    
    `> bannerji::getEmojiFromTheTrait(aTrait= "braggart")`
    ![Image](https://github.com/opendatasurgeon/bannerji/blob/master/functionOutputs/getemojifromtrait.png?raw=true)
    `> bannerji::getEmojiFromTheTrait(aTrait= "wut??")`    
    `> character(0)`

3) **traitsLookup(takes)** takes nothing, but prompts you for four entries. In these entries you can search for traits to match you perfectly with YOUR unique traits. The traits retured is a character vector of length 4 which you can copy for plotting. 
      
      `> bannerji::traitsLookup(takes= NA)`
      ![Image](https://github.com/opendatasurgeon/bannerji/blob/master/functionOutputs/traitslookup.png?raw=true)

4) **plotMyTraits(traits)** takes a character vector of length four. This vector are your four unique traits, and return a plot is made which is auto saved in your current directory. The name of the file is 'mydna.png.'

    `> bannerji::plotMyTraits(traits= c("Happy", "American", "Curious", "Angel"))`      
    ![Image](https://github.com/opendatasurgeon/bannerji/blob/master/functionOutputs/plotmytraits.png?raw=true)
    
    
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
