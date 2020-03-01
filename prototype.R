library(rjson)
library(igraph)

#------------------------------------------------------------------- Data -----------------------------------------
mytraits <- c("happy", "angel", "curious", "american")

#------------------------------------------------------------------- Viewer---------------------------------------
#The diplay/view function wrapped
displayTraits <<- function(){

  #TRY CATCH HERE FOR THE LINK!!! RETURN the HTML version of the table

  emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json" #link
  json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) #read line by line make
  emo_lib <- base::unlist(base::lapply(json_data,function(x){ x$char })) #unlisted json
  return(base::data.frame(EMOJI= emo_lib))
}
#displayTraits()

#------------------------------------------------------------ Traits to emojis ------------------------------------------

#Helper function
get_emoji_from_traits <<- function(a_trait) {

  #TRY CATCH HERE FOR LINK!!!
  emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json" #link
  json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) #read line by line make

  vector_of_emoji_names_and_characters <- base::unlist(base::lapply(json_data, function(x){ x$char }))

  emoji_character <- base::unname(vector_of_emoji_names_and_characters[base::names(vector_of_emoji_names_and_characters) == a_trait])

  return(emoji_character)
}

plotMyEmojis <<- function(traits) { # add option for , plotLayout, further customizing options colour, fonts, typeface etc.
  
  traits <- base::toupper(traits)
  
  #try catch for min length of traits, make it 2 above and it's chracter
  
  dna_strand <- "🧬"
  emoji_bag <- c()
  for(i in base::seq(traits)){
    emoji_bag <- c(emoji_bag, get_emoji_from_traits(traits[i])) #namespace here is custom function names
  }
  emoji_bag <- base::rbind(emoji_bag, base::matrix(dna_strand, ncol= base::length(emoji_bag)))
  emoji_bag <- c(emoji_bag)
  emoji_bag <- base::as.character(base::rev(emoji_bag))
  emo_mat <- base::matrix(emoji_bag, ncol = 2, byrow= T) #add NA for missing values odd pairs!!!
  links <-  base::data.frame(from = emo_mat[,1], to = emo_mat[,2])

  emogg <- igraph::graph_from_data_frame(links, directed = T)
  
  igraph::V(emogg)$size <- 1
  igraph::V(emogg)$color <- "gray"
  igraph::V(emogg)$frame.color <- "ghostwhite"
  igraph::E(emogg)$arrow.mode <- 0
  isolated <- igraph::degree(igraph::simplify(emogg)) == 0
  base::setwd("~/Desktop")
  grDevices::png(filename = "dna.png", width= 1280, height= 720, res= 200)
  igraph::plot.igraph(igraph::delete.vertices(igraph::simplify(emogg), isolated), vertex.label= igraph::V(emogg)$name, asp= 0, layout= igraph::layout_nicely(emogg))
  dev.off()
  base::message("mydna.png is saved to your Desktop!")
}

#plotMyEmojis(mytraits)

#-------------------------------------------------------- Recommendation ---------------------------------------

traitsLookup <<- function(){
  
  #TRY CATCH HERE FOR LINK VERIFICATION!!!
  emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json" #link
  json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) #read line by line make
  
  
  {first_key <- base::readline(prompt= "First keyword: ");
  second_key <- base::readline(prompt= "Second keyword: ");
  third_key <- base::readline(prompt= "Third keyword: ");
  fourth_key <- base::readline(prompt= "Fourth keyword: ");}
  
  keys_bag <- c(first_key,second_key,third_key,fourth_key)
  dictionary_keywords <- c()
  
  for(i in base::seq(keys_bag)){
    find_keys_in_lib <- base::lapply(json_data, function(ch) base::grep(keys_bag[i], ch))
    if(TRUE %in%base::sapply(find_keys_in_lib, function(x) base::length(x) > 0)){
      find_truth <- base::sapply(find_keys_in_lib, function(x) base::length(x) > 0)
      dictionary_keywords <- c(dictionary_keywords, names(find_truth[find_truth==TRUE]))
    }
  }
  
  plotMyEmojis(base::toupper(dictionary_keywords))
}

#traitsLookup()
#----------------

