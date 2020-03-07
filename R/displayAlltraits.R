#' displayAllTraits
#'
#' Displays all of the traits and their unique emoticon associations. You must use the traits name to plot your emojis.
#'
#' @name displayAllTraits
#' @param takes : Takes no parameter
#' @return a dataframe whose one column in traits, another is their emoticon relator; can be saved in an object
#'
#' @examples
#' displayAllTraits(takes= NULL)
#'
#' @importFrom rjson fromJSON
#' @export
displayAllTraits <- function(takes= NULL){

  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json"
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
