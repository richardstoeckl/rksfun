#' Negate the %in% operator
#'
#' @description This function negates the %in% operator.
#' I really don't know why this is not a built-in operator in R
#' @param ... vector
#' @param NA na
#' @export
'%NOTIN%' <- Negate('%in%')


#' ggsave with A4 size (portrait)
#'
#' @description This function saves the plot with A4 size in portrait mode
#' @param plot ggplot object
#' @param filename character. The name of the file to save the plot to.
#' @param ... Other arguments passed to ggsave()
#' @importFrom ggplot2 ggsave
#' @export
ggsave_portrait <- function(filename,plot=last_plot(),...) {
    ggplot2::ggsave(filename = filename,plot = plot, units = "mm", width = 210, height = 297, ...)
}

#' ggsave with A4 size (landscape)
#'
#' @description This function saves the plot with A4 size in landscape mode
#' @param plot ggplot object
#' @param filename character. The name of the file to save the plot to.
#' @param ... Other arguments passed to ggsave()
#' @importFrom ggplot2 ggsave
#' @export
ggsave_landscape <- function(filename,plot=last_plot(),...) {
    ggplot2::ggsave(filename = filename,plot = plot, units = "mm", width = 297, height = 210, ...)
}


# read result file from my annotation pipeline

#' Read the result file from my annotation pipeline
#'
#' @description This function reads the result file from my annotation pipeline
#' @param file character. The name of the file to read
#' @param threads integer. Number of threads to use
#' @param ... Other arguments passed to read_tsv
#' @importFrom readr read_tsv
#' @export
read_annotation <- name <- function(file,threads = 12,...) {
    annotation <- read_tsv(file,col_names = T,
                             col_types = cols(
                                 accession = col_character(),
                                 binID = col_character(),
                                 pContigID = col_character(),
                                 sampleID = col_character(),
                                 contigLength = col_double(),
                                 gc = col_double(),
                                 proteinID = col_character(),
                                 proteinStart = col_double(),
                                 proteinEnd = col_double(),
                                 strand = col_character(),
                                 Prokka = col_character(),
                                 NCBI_CDD =col_character(),
                                 NCBI_CDD_GeneID = col_character(),
                                 NCBI_CDD_Description=col_character(),
                                 NCBI_CDD_evalue=col_double(),
                                 NCBI_COG =col_character(),
                                 NCBI_COG_GeneID = col_character(),
                                 NCBI_COG_Description=col_character(),
                                 NCBI_COG_evalue=col_double(),
                                 arcogs = col_character(),
                                 arcogs_geneID = col_character(),
                                 arcogs_Description = col_character(),
                                 arcogs_Pathway = col_character(),
                                 arcogs_evalue = col_double(),
                                 PGAP = col_character(),
                                 PGAP_description = col_character(),
                                 PGAP_EC = col_character(),
                                 PGAP_Evalue = col_double(),
                             ), num_threads = threads, quote = "",trim_ws=F, na="*",...)
}
