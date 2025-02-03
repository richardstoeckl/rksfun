# Function to calculate pairwise percent identity
#' Calculate pairwise percent identity between two sequences
#'
#' @param seq1 First sequence
#' @param seq2 Second sequence
#' @param substitutionMatrix Substitution matrix to use for alignment
#' @param gapOpening Gap opening penalty
#' @param gapExtension Gap extension penalty
#' @param type Type of alignment. One of "global", "local", "overlap"
#' @param ... Additional arguments passed to pwalign::pairwiseAlignment
#' @return Pairwise percent identity
#' @importFrom pwalign pairwiseAlignment pid
#' @export
calculate_pid <- function(seq1, seq2, substitutionMatrix = "BLOSUM62", gapOpening = 10, gapExtension = 0.5, type = "global", ...) {
    alignment <- pwalign::pairwiseAlignment(seq1,
        seq2,
        substitutionMatrix = substitutionMatrix,
        gapOpening = gapOpening,
        gapExtension = gapExtension,
        scoreOnly = FALSE,
        type = type,
        ...
    )
    pid <- pwalign::pid(alignment)
    return(pid)
}

# Calculate all-vs-all protein percent identities
#' Calculate all-vs-all protein percent identities
#'
#' @param protlist List of protein sequences
#' @return Dataframe with percent identities
#' @export
allVSall_pid <- function(protlist) {
    # Initialize an empty dataframe
    pid_df <- data.frame(matrix(ncol = length(protlist), nrow = length(protlist)))
    colnames(pid_df) <- names(protlist)
    rownames(pid_df) <- names(protlist)
    # Calculate percent identity for all-vs-all
    for (i in 1:length(protlist)) {
        for (j in i:length(protlist)) {
            pid_df[i, j] <- calculate_pid(protlist[[i]], protlist[[j]])
            pid_df[j, i] <- pid_df[i, j] # The matrix is symmetric
        }
    }
    return(pid_df)
}
