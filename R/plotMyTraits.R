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

  base::message("For example: plotMyTraits(traits= c(\"Happy\", \"Angel\",\"Curious\",\"American\")")

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

      igraph::V(emogg)$size <- 1
      igraph::V(emogg)$color <- "gray"
      igraph::V(emogg)$frame.color <- "ghostwhite"
      igraph::E(emogg)$arrow.mode <- 0
      isolated <- degree(simplify(emogg)) == 0

      png(filename = "~/Desktop/dna.png", width= 1280, height= 720, res= 200)
      plot.igraph(delete.vertices(simplify(emogg), isolated), vertex.label= igraph::V(emogg)$name, asp= 0, layout= layout_nicely(emogg))
      dev.off()

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
