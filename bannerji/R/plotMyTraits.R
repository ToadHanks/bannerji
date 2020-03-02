get_emoji_from_traits <<- function(a_trait) {
  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json"
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

#' Plot the traits in their emoji representation
#'
#' User can pass in 4 single traits of a character type inside a "c()" function & a banner will be generated & saved in the Desktop.
#' @param c("trait1","trait2","trait3","trait4") Takes a character vector of 4 values to be plotted as a banner
#' @return Saves a 'mydna.png' banner in the Desktop directory
#' @import rjson, igraph
#' @export
#' @example plotMyTraits(c("happy", "american", "seeker", "angel"))
#'
plotMyTraits <<- function(traits) {

  base::message("For example: plotMyTraits(traits= c('trait1', 'trait2','trait3','trait4'))")
  base::message("Please use the bannerji::traitsLookup() function if you would like to get plottable traits!")

  tryCatch(
    expr = {
      if(base::length(traits) != 4 | class(traits) != "character"){
        print("Please pass in only 4 unique traits, & make sure that they are all character type.")
        return(NULL)
      }
      traits <- base::toupper(traits)

      dna_strand <- "🧬"
      emoji_bag <- c()
      for(i in base::seq(traits)){
        emoji_bag <- c(emoji_bag, get_emoji_from_traits(traits[i])) #namespace here is custom function names
      }

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
