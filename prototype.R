library(rjson)
library(igraph)

#----------------------------------------------------------- testing variables ------------------------------------
mytraits <- c("happy", "angel", "curious", "american")

#------------------------------------------------------------------- Viewer---------------------------------------
#The diplay/view function wrapped
displayAllTraits <- function(takes= NA){

  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/mytraits.json" 
      json_data <- fromJSON(paste(readLines(emoji_json_file), collapse = "")) 
      emo_lib <- unlist(lapply(json_data,function(x){ x$char })) 
      return(data.frame(TRAITS= names(emo_lib),EMOJI= unname(emo_lib)))
    },
    error = function(e){
      message("Error. Link is down. Sorry about that :(")
      print(e)
    },
    warning = function(w){
      message("Caught an warning, but it is okay.")
      print(w)
    },
    finally = {
      message("All done, quitting.")
    }
  )    
}

#displayAllTraits()
#Done.

#------------------------------------------------------------------- A trait to emoji ---------------------------------------

getEmojiFromTheTrait <- function(aTrait) {
  
  message("For example: getEmojiFromTheTrait(aTrait= \"Happy\")")
  
  tryCatch(
    expr = {
      
      aTrait <- toupper(aTrait)
      
      emoji_json_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/mytraits.json" 
      json_data <- fromJSON(paste(readLines(emoji_json_file), collapse = "")) 
      
      vector_of_emoji_names_and_characters <- unlist(lapply(json_data, function(x){ x$char }))
      
      emoji_character <-unname(vector_of_emoji_names_and_characters[names(vector_of_emoji_names_and_characters) == aTrait])
      
      return(emoji_character)
    },
    error = function(e){
      message("Reading library is down, please try again later. Sorry :(")
      print(e)
    },
    warning = function(w){
      message("Warning! Continue....")
      print(w)
    },
    finally = {
      message("")
    }
  )    
}

#getEmojiFromTheTrait("happy")
#DONE.

#------------------------------------------------------------ Many Traits to emojis ------------------------------------------

plotMyTraits <- function(traits) { 
  
  base::message("For example: plotMyTraits(traits= c('Happy', 'Angel','Curious','American')")
  
  tryCatch(
    expr = {
      if(length(traits) != 4 | class(traits) != "character"){
        print("Please pass in only 4 unique traits, & make sure that they are all character type.")
        return(NULL)
      }
      
      traits <- toupper(traits)
      
      dna_link <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/dnastrand.json"
      emoji_bag <- c()
      
      for(i in seq(traits)){
        emoji_json_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/mytraits.json" 
        json_data <- fromJSON(paste(readLines(emoji_json_file), collapse = "")) 
        
        vector_of_emoji_names_and_characters <- unlist(lapply(json_data, function(x){ x$char }))
        
        emoji_character <- unname(vector_of_emoji_names_and_characters[names(vector_of_emoji_names_and_characters) == traits[i]])
        emoji_bag <- c(emoji_bag, emoji_character) 
      }
      
      dna_data <- fromJSON(paste(readLines(dna_link), collapse = "")) 
      
      dna_emoji <- unlist(lapply(dna_data, function(x){ x$char }))
      
      dna_strand <- unname(dna_emoji[names(dna_emoji) == "DNA"])
      
      emoji_bag <- rbind(emoji_bag, matrix(dna_strand, ncol= length(emoji_bag)))
      emoji_bag <- c(emoji_bag)
      emoji_bag <- as.character(rev(emoji_bag))
      emo_mat <- matrix(emoji_bag, ncol = 2, byrow= T)
      links <-  data.frame(from = emo_mat[,1], to = emo_mat[,2])
      
      emogg <- graph_from_data_frame(links, directed = T)
      
      V(emogg)$size <- 1
      V(emogg)$color <- "gray"
      V(emogg)$frame.color <- "ghostwhite"
      E(emogg)$arrow.mode <- 0
      isolated <- degree(simplify(emogg)) == 0
      
      setwd("~/Desktop")
      
      grDevices::png(filename = "dna.png", width= 1280, height= 720, res= 200)
      plot.igraph(delete.vertices(simplify(emogg), isolated), vertex.label= V(emogg)$name, asp= 0, layout= layout_nicely(emogg))
      grDevices::dev.off()
      
      message("mydna.png is saved to your Desktop!")
    },
    error = function(e){
      message("Plotting failed, check your vector, make sure you're passing characters only.")
      print(e)
    },
    warning = function(w){
      message("Caught a warning!")
      print(w)
    },
    finally = { 
      message("") 
    }
  ) 
}

#plotMyTraits(mytraits)
#Done.

#-------------------------------------------------------- Recommendation ---------------------------------------

traitsLookup <- function(takes= NA){
  
  message("Please type top 4 words followed by ENTER") 
  message("If 4 unique Traits are returned, then you're all set to plot using plotMyTraits(traits) function!!")
  
  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/mytraits.json"
      json_data <- fromJSON(paste(readLines(emoji_json_file), collapse = "")) 
      
      emo_lib <- unlist(lapply(json_data,function(x){ x$char }))
      emo_lib <- data.frame(TRAIT= names(emo_lib), EMOJI= unname(emo_lib))
      
      {first_key <- readline(prompt= "First keyword: ");
        second_key <- readline(prompt= "Second keyword: ");
        third_key <- readline(prompt= "Third keyword: ");
        fourth_key <- readline(prompt= "Fourth keyword: ");}
      
      keys_bag <- tolower(c(first_key,second_key,third_key,fourth_key))
      dictionary_keywords <- c()
      
      for(i in seq(keys_bag)){
        find_keys_in_lib <- lapply(json_data, function(ch) grep(keys_bag[i], ch))
        if(TRUE %in% sapply(find_keys_in_lib, function(x) length(x) > 0)){
          find_truth <- sapply(find_keys_in_lib, function(x) length(x) > 0)
          dictionary_keywords <- c(dictionary_keywords, names(find_truth[find_truth==TRUE]))
        }
      }
      
      print("Traits found: ")
      return(dictionary_keywords)
    },
    error = function(e){
      message("Look up failed, please type single alphabetic words. one at a time.")
      print(e)
    },
    warning = function(w){
      message("Caught a warning!")
      print(w)
    },
    finally = { 
      message("") 
    }
  ) 
  
}

#traitsLookup()
#Done.

