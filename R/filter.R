# Function to be able to detect multiple patterns in a string

#' @title Helper function to detect a pattern in a string
labels2keep <- function(pattern,text) {
    !stringr::str_detect(text, fixed(pattern))
}

#' @title Function to get a logical vector if a text contains one of multiple sting patterns
#' @examples
#' # define a vector of patterns
#' patterns <- c("Merc", "Hornet")
#' # create a DF
#' df <- datasets::mtcars %>% tibble::rownames_to_column(var = "car")
#' # filter the DF to keep only the rows that do not contain one of the patterns
#' df_with_pattern <- df %>% dplyr::filter(rowHasPattern(patterns,df$car))
#' # filter the DF to keep only the rows that do not contain one of the patterns
#' df_without_pattern <- df %>% dplyr::filter(!rowHasPattern(patterns,df$car))
#' @param patterns A vector of strings to detect in the text
#' @param text A vector of strings to detect the patterns
#' @return A logical vector of the same length as the text vector
#' @export
hasOneOfMultiplePatterns <- function(patterns,text) {
                      logical_vector <- patterns %>%
                      # apply the filter of all the text rows for each pattern
                      # you'll get one list of logical by pattern ignored_string
                      purrr::map(~ labels2keep(.x,text)) %>%
                      # get a logical vector of rows to keep
                      purrr::pmap_lgl(all)
                      return(!logical_vector)
}


