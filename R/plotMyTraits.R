#' getEmojiFromAtrait
#'
#' Returns a single emoji from ONE trait.
#'
#' @name getEmojiFromAtrait
#' @param aTrait : Takes a single trait at a time
#' @return Returns an utf-8 encoded emoji; can be saved in an object (Won't Render on Windows!!)
#'
#' @examples
#' getEmojiFromAtrait(aTrait)
#'
#' @importFrom rjson fromJSON
#' @export
getEmojiFromAtrait <- function(aTrait) {
  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json"
      json_data <- fromJSON(paste(readLines(emoji_json_file), collapse = ""))

      vector_of_emoji_names_and_characters <- unlist(lapply(json_data, function(x){ x$char }))

      emoji_character <- unname(vector_of_emoji_names_and_characters[names(vector_of_emoji_names_and_characters) == a_trait])
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


#' plotMyTraits
#'
#' User can pass in 4 single traits of a character type inside a "c()" function & a banner will be generated & saved in the Desktop.
#'
#' @name plotMyTraits
#' @param traits : Accepts a character vector of length 4, which contains your unique traits
#' @return If no error, you would get a banner size plot saved in your Desktop. File name is "mydna.png"
#'
#' @examples
#' plotMyTraits(c("happy","american","heaven","seeker"))
#'
#' @importFrom igraph graph_from_data_frame delete.vertices simplify V E degree layout_nicely plot.igraph
#' @importFrom rjson fromJSON
#' @importFrom grDevices dev.off png
#' @export
plotMyTraits <- function(traits) {

  message("For example: plotMyTraits(traits= c('trait1', 'trait2','trait3','trait4'))")
  message("Please use the bannerji::traitsLookup(takes= NULL) function if you would like to get plottable traits!")

  tryCatch(
    expr = {
      if(length(traits) != 4 | class(traits) != "character"){
        print("Please pass in only 4 unique traits, & make sure that they are all character type.")
        return(NULL)
      }
      traits <- toupper(traits)

      dna_trait <- "DNA"
      dna_file <- "https://raw.githubusercontent.com/opendatasurgeon/bannerji/master/traitslib/dnastrand.json"
      dna_data <- fromJSON(paste(readLines(dna_file), collapse = ""))

      vector_of_emoji_names_and_characters <- unlist(lapply(dna_data, function(x){ x$char }))

      dna_strand <- unname(vector_of_emoji_names_and_characters[names(vector_of_emoji_names_and_characters) == dna_trait])

      #use_data(dna_strand, bannerji, internal = T)

      emoji_bag <- c()
      for(i in seq(traits)){
        emoji_bag <- c(emoji_bag, getEmojiFromAtrait(traits[i]))
      }

      emoji_bag <- rbind(emoji_bag, matrix(dna_strand, ncol= length(emoji_bag)))
      emoji_bag <- c(emoji_bag)
      emoji_bag <- as.character(rev(emoji_bag))
      emo_mat <- matrix(emoji_bag, ncol = 2, byrow= T)
      links <-  data.frame(from = emo_mat[,1], to = emo_mat[,2])

      emogg <- graph_from_data_frame(links, directed = T)

      igraph::V(emogg)$size <- 1
      igraph::V(emogg)$color <- "gray"
      igraph::V(emogg)$frame.color <- "ghostwhite"
      igraph::E(emogg)$arrow.mode <- 0
      isolated <- degree(simplify(emogg)) == 0

      setwd("~/Desktop")

      png(filename = "dna.png", width= 1280, height= 720, res= 200)
      plot.igraph(delete.vertices(simplify(emogg), isolated), vertex.label= igraph::V(emogg)$name, asp= 0, layout= layout_nicely(emogg))
      dev.off()

      message("mydna.png is saved to your Desktop!")

    },
    error = function(e){
      message("Caught an error, check the arguments!")
      print(e)
    },
    warning = function(w){
      message("Caught an warning!")
      print(w)
    },
    finally = {
      message("")
    }
  )
}
