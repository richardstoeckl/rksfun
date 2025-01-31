#' @title Negate the %in% operator
#' @description This function negates the %in% operator.
#' I really don't know why this is not a built-in operator in R
#' @export
'%NOTIN%' <- Negate('%in%')
