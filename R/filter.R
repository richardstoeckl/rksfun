# Function to be able to detect multiple patterns in a string

#' Helper function to detect a pattern in a string
#'
#' @noRd
#' @keywords internal
labels2keep <- function(pattern,text) {
    !stringr::str_detect(text, fixed(pattern))
}

#' Function to get a logical vector if a text contains one of multiple sting patterns
#'
#' @examples
#' # define a vector of patterns
#' patterns <- c("Merc", "Hornet")
#' # create a DF
#' df <- datasets::mtcars
#' df$car <- rownames(df)
#' # filter the DF to keep only the rows that do not contain one of the patterns
#' df_with_pattern <- df %>% dplyr::filter(hasOneOfMultiplePatterns(patterns,df$car))
#' # filter the DF to keep only the rows that do not contain one of the patterns
#' df_without_pattern <- df %>% dplyr::filter(!hasOneOfMultiplePatterns(patterns,df$car))
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


