# IN-PROGRESS!!
library(rjson)
library(igraph)



#------------------------------------------------------------------- Data -----------------------------------------
mytraits <- c("Happy", "Angel", "Curious", "American")

#------------------------------------------------------------------- Viewer---------------------------------------
#The diplay/view function wrapped
displayTraits <<- function(){

  #TRY CATCH HERE FOR THE LINK!!! RETURN the HTML version of the table

  emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json" #link
  json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) #read line by line make
  emo_lib <- base::unlist(base::lapply(json_data,function(x){ x$char })) #unlisted json
  return(base::data.frame(Emoji= emo_lib))
}

#------------------------------------------------------------ Traits to emojis ------------------------------------------

#Helper function
get_emoji_from_traits <<- function(a_trait) {

  #TRY CATCH HERE FOR LINK!!!
  emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json" #link
  json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) #read line by line make

  vector_of_emoji_names_and_characters <- unlist(base::lapply(json_data, function(x){ x$char }))

  emoji_character <- base::unname(vector_of_emoji_names_and_characters[base::names(vector_of_emoji_names_and_characters) == a_trait])

  return(emoji_character)
}

plotMyEmojis <<- function(traits) { # add option for , plotLayout, further customizing options colour, fonts, typeface etc.
  
  #try catch for min length of traits, make it 2 above and it's chracter
  
  #Add DNA strands
  emoji_bag <- c()
  for(i in seq(traits)){
    emoji_bag <- c(emoji_bag, get_emoji_from_traits(traits[i])) #namespace here is custom function names
  }
  
  emoji_bag <- base::as.character(base::rev(emoji_bag))
  emo_mat <- base::matrix(emoji_bag, ncol = 2, byrow= T) #add NA for missing values odd pairs!!!
  links <-  base::data.frame(source= emo_mat[,1], target= emo_mat[,2])
  emogg <- igraph::graph_from_data_frame(links, directed = T)
  
  igraph::V(emogg)$size <- 1
  igraph::V(emogg)$color <- "azure"
  igraph::V(emogg)$frame.color <- "ghostwhite"
  igraph::E(emogg)$arrow.mode <- 0
  isolated <- igraph::degree(igraph::simplify(emogg)) == 0
  

  igraph::plot.igraph(igraph::delete.vertices(igraph::simplify(emogg), isolated), vertex.label= igraph::V(emogg)$name, asp = 0, layout= igraph::layout_nicely(emogg))
  
  #return(emoji_bag) #return the plot??
}
plotMyEmojis(mytraits)

#---------------------------------------------------------------------------------------------------------------------

text <- "My Very Enthusiastic Mother Just Served Us Noodles!"
gsub('(.{2})', "\\1:", text, perl = T)

library(dplyr)
str_reverse<-function(x){
  strsplit(x,split='')[[1]] %>% rev() %>% paste(collapse = "") 
}

text2<-str_reverse(text)
text3<-gsub('(.{2})', "\\1:", text2, perl = T)
str_reverse(text3)

