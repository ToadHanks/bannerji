#' getEmojiFromTheTrait
#'
#' Returns a single emoji for ONE trait only.
#'
#' @name getEmojiFromTheTrait
#' @param aTrait : Takes a single trait
#' @return Returns an utf-8 encoded emoji; can be saved in an object (Won't Render on Windows!!)
#'
#' @examples
#' getEmojiFromTheTrait(aTrait= "Happy")
#'
#' @importFrom rjson fromJSON
#' @export
getEmojiFromTheTrait <- function(aTrait) {
  
  message("For example: getEmojiFromTheTrait(aTrait= \"Angel\")")
  
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
