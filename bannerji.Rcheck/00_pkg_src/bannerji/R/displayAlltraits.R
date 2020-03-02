#' Display all traits & emoticons
#'
#' Shows a table where one column is a list of traits & another is list of emoticons.
#' @param () Takes no parameter
#' @return The dataframe containing traits and emojis; can be saved in an object
#' @import rjson
#' @export
#' @example displayAllTraits()
#'
displayAllTraits <<- function(){

  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json"
      json_data <- rjson::fromJSON(base::paste(base::readLines(emoji_json_file), collapse = ""))
      emo_lib <- base::unlist(base::lapply(json_data,function(x){ x$char }))
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
