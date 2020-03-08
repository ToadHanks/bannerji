library(rjson)
library(igraph)

#----------------------------------------------------------- testing variables ------------------------------------
mytraits <- c("happy", "angel", "curious", "american")

#------------------------------------------------------------------- Viewer---------------------------------------
#The diplay/view function wrapped
displayAllTraits <<- function(){

  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/mytraits.json" #link
      json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) #read line by line make
      emo_lib <- base::unlist(base::lapply(json_data,function(x){ x$char })) #unlisted json
      return(base::data.frame(TRAITS= base::names(emo_lib),EMOJI= base::unname(emo_lib)))
    },
    error = function(e){
      base::message("Error. Link is down. Sorry about that :(")
      base::print(e)
    },
    warning = function(w){
      base::message("Caught an warning, but it is okay.")
      base::print(w)
    },
    finally = {
      base::message("All done, quitting.")
    }
  )    
}
#displayAllTraits()
#Done.

#------------------------------------------------------------ Traits to emojis ------------------------------------------

#Helper function
get_emoji_from_traits <<- function(a_trait) {
  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/mytraits.json" 
      json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) 
      
      vector_of_emoji_names_and_characters <- base::unlist(base::lapply(json_data, function(x){ x$char }))
      
      emoji_character <- base::unname(vector_of_emoji_names_and_characters[base::names(vector_of_emoji_names_and_characters) == a_trait])
      return(emoji_character)
    },
    error = function(e){
      base::message("Reading library is down, please try again later. Sorry :(")
      base::print(e)
    },
    warning = function(w){
      base::message("Warning! Continue....")
      base::print(w)
    },
    finally = {
      base::message("")
    }
  )    
}

plotMyTraits <- function(traits) { # add option for , plotLayout, further customizing options colour, fonts, typeface etc.
  
  base::message("For example: plotMyTraits(traits= c('trait1', 'trait2','trait3','trait4'), ....)")

    tryCatch(
    expr = {
      if(base::length(traits) != 4 | class(traits) != "character"){
        print("Please pass in only 4 unique traits, & make sure that they are all character type.")
        return(NULL)
      }
      
      traits <- base::toupper(traits)
      
      dna_link <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/dnastrand.json"
      emoji_bag <- c()
      
      for(i in base::seq(traits)){
        tryCatch(
          expr = {
            emoji_json_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/mytraits.json" 
            json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) 
            
            vector_of_emoji_names_and_characters <- base::unlist(base::lapply(json_data, function(x){ x$char }))
            
            emoji_character <- base::unname(vector_of_emoji_names_and_characters[base::names(vector_of_emoji_names_and_characters) == traits[i]])
          },
          error = function(e){
            base::message("Reading library is down, please try again later. Sorry :(")
            base::print(e)
          },
          warning = function(w){
            base::message("Warning! Continue....")
            base::print(w)
          },
          finally = {
            base::message("")
          }
        )    
        emoji_bag <- c(emoji_bag, emoji_character) #namespace here is custom function names
      }
      
      dna_data <- rjson::fromJSON(base::paste(base::readLines(dna_link), collapse = "")) 
      
      dna_emoji <- base::unlist(base::lapply(dna_data, function(x){ x$char }))
      
      dna_strand <- base::unname(dna_emoji[base::names(dna_emoji) == "DNA"])
      
      emoji_bag <- base::rbind(emoji_bag, base::matrix(dna_strand, ncol= base::length(emoji_bag)))
      emoji_bag <- c(emoji_bag)
      emoji_bag <- base::as.character(base::rev(emoji_bag))
      emo_mat <- base::matrix(emoji_bag, ncol = 2, byrow= T)
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
      grDevices::dev.off()
      
      base::message("mydna.png is saved to your Desktop!")
      
    },
    error = function(e){
      base::message("Caught an error, check the arguments!")
      base::print(e)
    },
    warning = function(w){
      base::message("Caught an warning!")
      base::print(w)
    },
    finally = {
      base::message("")
    }
  ) 
}

plotMyTraits(mytraits)

#-------------------------------------------------------- Recommendation ---------------------------------------

traitsLookup <<- function(){
  base::message("Please type top 4 words followed by ENTER; let's see if traits are discovered!")
  
  base::tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/mytraits.json"
      json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = "")) 
      
      emo_lib <- base::unlist(base::lapply(json_data,function(x){ x$char }))
      emo_lib <- base::data.frame(TRAIT= base::names(emo_lib), EMOJI= base::unname(emo_lib))
      
      {first_key <- base::readline(prompt= "First keyword: ");
        second_key <- base::readline(prompt= "Second keyword: ");
        third_key <- base::readline(prompt= "Third keyword: ");
        fourth_key <- base::readline(prompt= "Fourth keyword: ");}
      
      keys_bag <- base::tolower(c(first_key,second_key,third_key,fourth_key))
      dictionary_keywords <- c()
      
      for(i in base::seq(keys_bag)){
        find_keys_in_lib <- base::lapply(json_data, function(ch) base::grep(keys_bag[i], ch))
        if(TRUE %in%base::sapply(find_keys_in_lib, function(x) base::length(x) > 0)){
          find_truth <- base::sapply(find_keys_in_lib, function(x) base::length(x) > 0)
          dictionary_keywords <- c(dictionary_keywords, base::names(find_truth[find_truth==TRUE]))
        }
      }
      
      base::print("Traits found: ")
      return(dictionary_keywords)
    },
    error = function(e){
      base::message("Look up failed, please type single alphabetic words.")
      base::print(e)
    },
    warning = function(w){
      base::message("Caught a warning!")
      base::print(w)
    },
    finally = { 
      base::message("") 
    }
  ) 
}

#traitsLookup()
                                 
#Done.

