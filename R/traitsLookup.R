#' traitsLookup
#'
#' Takes user keywords via prompt & returns appropriate traits. Users get input prompt in the console where they put 4 keywords & function gives back traits, if possible.
#'
#' @name traitsLookup
#' @param takes : Takes no parameter
#' @return A character vector containing traits; can be saved in an object
#'
#' @examples
#' traitsLookup(takes= NULL)
#'
#' @importFrom rjson fromJSON
#' @export
traitsLookup <- function(takes= NULL){
  message("Please type top 4 words followed by ENTER; let's see if your traits are discovered!")

  tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json"
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
      message("Look up failed, please type single alphabetic words.")
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
