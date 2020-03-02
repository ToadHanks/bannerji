#' Takes user keywords via prompt & returns appropriate traits
#'
#' Users get input prompt in the console where they put 4 keywords & function gives back traits, if possible.
#' @param () Takes no parameter
#' @return A character vector containing traits; can be saved in an object
#' @import rjson
#' @export
#' @example traitsLookup()
#'
traitsLookup <<- function(){
  base::message("Please type top 4 words followed by ENTER; let's see if traits are discovered!")

  base::tryCatch(
    expr = {
      emoji_json_file <- "https://raw.githubusercontent.com/ToadHanks/urmojis/master/traitslib/mytraits.json"
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
        if(TRUE %in% base::sapply(find_keys_in_lib, function(x) base::length(x) > 0)){
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
