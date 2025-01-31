#' Complete list of palettes.
#'
#' Use names(rksfunPalettes) to return all possible palette names. Current choices are:
#' \code{rktbns_post}, and \code{tf2}
#' Use \code{\link{rksfun.pals}} to construct palettes.
#'
#' @export
rksfunPalettes <- list(
    rktbns_post = list(c("#62292f","#9d4e47","#dc7660","#eb9d77","#fbc78d","#f6d796","#f9e8a3","#dce6a7","#c0e3ab","#9bdfb0","#86dcb5","#59caac","#2dbda4","#3aa794","#48877c","#546f6a","#545955","#554546"),c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)),
    tf2 = list(c("#395c78","#5b7a8c","#768a88","#6b6a65","#34302d","#462d26","#6a4535","#913a1e","#bd3b3b","#9d312f","#f08149","#ef9849","#f5ad87","#f6b98a","#f5e7de","#c1a18a","#dabdab"),c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18))
)


# Function for generating palettes

#' rksfunPalettes for plotting
#' @param name Name of Palette. Choices are:
#' \code{rktbns_post}, and \code{tf2}
#' @param n Number of desired colors. If number of requested colors is beyond the scope of the palette,
#' colors are automatically interpolated. If n is not provided, the length of the palette is used.
#' @param type Either "continuous" or "discrete". Use continuous if you want to automatically
#' interpolate between colors.
#' @param direction Sets order of colors. Default palette is 1. If direction is -1, palette color order is reversed
#' @param override.order Colors are picked from palette to maximize readability and aesthetics. This means
#' that colors are not always selected in sequential order from the full palette. If override.order is set to TRUE,
#' colors are selected in sequential order from the full palette instead. Default is FALSE.
#' @return A vector of colors.
#' @export
rksfun.pals <- function(name, n, type = c("discrete", "continuous"), direction = c(1, -1), override.order=FALSE) {
    `%NOTIN%` <- Negate(`%in%`)
    palette <- rksfunPalettes[[name]]

    if (is.null(palette)|is.numeric(name)){
        stop("Palette does not exist.")
    }

    if (missing(n)) {
        n <- length(palette[[1]])
    }

    if (missing(direction)) {
        direction <- 1
    }

    if (direction %NOTIN% c(1, -1)){
        stop("Direction not valid. Please use 1 for standard palette or -1 for reversed palette.")
    }

    if (missing(type)) {
        if(n > length(palette[[1]])){type <- "continuous"}
        else{type <- "discrete"}
    }

    type <- match.arg(type)
    if (type == "discrete" && n > length(palette[[1]])) {
        stop("Number of requested colors greater than what discrete palette can offer, \n use continuous instead.")
    }

    continuous <-  if(direction==1){grDevices::colorRampPalette(palette[[1]])(n)
    }else{
        grDevices::colorRampPalette(rev(palette[[1]]))(n)}

    discrete <- if(direction==1 & override.order==FALSE){
        palette[[1]][which(palette[[2]] %in% c(1:n)==TRUE)]
    }else if(direction==-1 & override.order==FALSE){
        rev(palette[[1]][which(palette[[2]] %in% c(1:n)==TRUE)])
    } else if(direction==1 & override.order==TRUE){
        palette[[1]][1:n]
    } else{
        rev(palette[[1]])[1:n]
    }

    out <- switch(type,
                  continuous = continuous,
                  discrete = discrete
    )
    structure(out, class = "palette", name = name)

}



# rksfunPalettes for plotting with ggplot2

#' rksfunPalettes for plotting with ggplot2
#'
#' Function for using \code{rksfunPalettes} colors schemes in \code{ggplot2}. Use \code{\link{scale_color_rksfun_d}} and \code{\link{scale_fill_rksfun_d}}
#' for discrete scales and \code{\link{scale_color_rksfun_c}} and \code{\link{scale_fill_rksfun_c}} for continuous scales.
#'
#' @param name Name of Palette. Choices are:
#' \code{rktbns_post}, and \code{tf2}
#' @param direction Sets order of colors. Default palette is 1. If direction is -1, palette color order is reversed
#' @param override.order Colors are picked from palette to maximize readability and aesthetics. This means
#' that colors are not always selected in sequential order from the full palette. If override.order is set to TRUE,
#' colors are selected in sequential order from the full palette instead. Default is FALSE.
#' @param ... Other arguments passed on to \code{\link[ggplot2]{discrete_scale}}
#' @import ggplot2
#' @return A function that returns a discrete color scale.
#' @export
scale_color_rksfun_d <- function(name, direction=1, override.order=FALSE, ...){
    rksfun.pals.disc <- function(name, direction = c(1, -1), override.order=FALSE) {

        `%NOTIN%` <- Negate(`%in%`)
        palette <- rksfunPalettes[[name]]
        if (is.null(palette)|is.numeric(name)){
            stop("Palette does not exist.")
        }

        if (direction %NOTIN% c(1, -1)){
            stop("Direction not valid. Please use 1 for standard palette or -1 for reversed palette.")
        }

        function(n) if(direction==1 & override.order==FALSE){
            palette[[1]][which(palette[[2]] %in% c(1:n)==TRUE)]
        }else if(direction==-1 & override.order==FALSE){
            rev(palette[[1]][which(palette[[2]] %in% c(1:n)==TRUE)])
        } else if(direction==1 & override.order==TRUE){
            palette[[1]][1:n]
        } else{
            rev(palette[[1]])[1:n]
        }

    }

    discrete_scale(aesthetics = "colour", scale_name="rksfun_d",
                   palette = rksfun.pals.disc(name=name, direction=direction, override.order=override.order),
                   ...)
}

#' rksfunPalettes for plotting with ggplot2
#'
#' Function for using \code{rksfunPalettes} colors schemes in \code{ggplot2}. Use \code{\link{scale_color_rksfun_d}} and \code{\link{scale_fill_rksfun_d}}
#' for discrete scales and \code{\link{scale_color_rksfun_c}} and \code{\link{scale_fill_rksfun_c}} for continuous scales.
#'
#' @param name Name of Palette. Choices are:
#' \code{rktbns_post}, and \code{tf2}
#' @param direction Sets order of colors. Default palette is 1. If direction is -1, palette color order is reversed
#' @param override.order Colors are picked from palette to maximize readability and aesthetics. This means
#' that colors are not always selected in sequential order from the full palette. If override.order is set to TRUE,
#' colors are selected in sequential order from the full palette instead. Default is FALSE.
#' @param ... Other arguments passed on to \code{\link[ggplot2]{discrete_scale}}
#' @import ggplot2
#' @return A function that returns a discrete color scale.
#' @export
scale_fill_rksfun_d <- function(name, direction=1, override.order=FALSE, ...){
    rksfun.pals.disc <- function(name, direction = c(1, -1), override.order=FALSE) {

        `%NOTIN%` <- Negate(`%in%`)
        palette <- rksfunPalettes[[name]]
        if (is.null(palette)|is.numeric(name)){
            stop("Palette does not exist.")
        }

        if (direction %NOTIN% c(1, -1)){
            stop("Direction not valid. Please use 1 for standard palette or -1 for reversed palette.")
        }

        function(n) if(direction==1 & override.order==FALSE){
            palette[[1]][which(palette[[2]] %in% c(1:n)==TRUE)]
        }else if(direction==-1 & override.order==FALSE){
            rev(palette[[1]][which(palette[[2]] %in% c(1:n)==TRUE)])
        } else if(direction==1 & override.order==TRUE){
            palette[[1]][1:n]
        } else{
            rev(palette[[1]])[1:n]
        }
    }

    discrete_scale(aesthetics = "fill", scale_name="rksfun_d",
                   palette = rksfun.pals.disc(name=name, direction=direction, override.order=override.order),
                   ...)
}


#' rksfunPalettes for plotting with ggplot2
#'
#' Function for using \code{rksfunPalettes} colors schemes in \code{ggplot2}. Use \code{\link{scale_color_rksfun_d}} and \code{\link{scale_fill_rksfun_d}}
#' for discrete scales and \code{\link{scale_color_rksfun_c}} and \code{\link{scale_fill_rksfun_c}} for continuous scales.
#'
#' @param name Name of Palette. Choices are:
#' \code{rktbns_post}, and \code{tf2}
#' @param direction Sets order of colors. Default palette is 1. If direction is -1, palette color order is reversed
#' @param ... Other arguments passed on to \code{\link[ggplot2]{scale_color_gradientn}}
#' @import ggplot2
#' @return A function that returns a continuous color scale.
#' @export
scale_color_rksfun_c <- function(name, direction=1, ...){

    `%NOTIN%` <- Negate(`%in%`)

    if (direction %NOTIN% c(1, -1)){
        stop("Direction not valid. Please use 1 for standard palette or -1 for reversed palette.")
    }

    scale_color_gradientn(colors=rksfun.pals(name=name, direction=direction, override.order = F),
                          ...)
}


#' rksfunPalettes for plotting with ggplot2
#'
#' Function for using \code{rksfunPalettes} colors schemes in \code{ggplot2}. Use \code{\link{scale_color_rksfun_d}} and \code{\link{scale_fill_rksfun_d}}
#' for discrete scales and \code{\link{scale_color_rksfun_c}} and \code{\link{scale_fill_rksfun_c}} for continuous scales.
#'
#' @param name Name of Palette. Choices are:
#' \code{rktbns_post}, and \code{tf2}
#' @param direction Sets order of colors. Default palette is 1. If direction is -1, palette color order is reversed
#' @param ... Other arguments passed on to \code{\link[ggplot2]{scale_color_gradientn}}
#' @import ggplot2
#' @return A function that returns a continuous color scale.
#' @export
scale_fill_rksfun_c <- function(name, direction=1, ...){

    `%NOTIN%` <- Negate(`%in%`)

    if (direction %NOTIN% c(1, -1)){
        stop("Direction not valid. Please use 1 for standard palette or -1 for reversed palette.")
    }

    scale_fill_gradientn(colors=rksfun.pals(name=name, direction=direction, override.order = F),
                         ...)
}


#' rksfunPalettes for plotting with ggplot2
#'
#' Function for using \code{rksfunPalettes} colors schemes in \code{ggplot2}. Use \code{\link{scale_color_rksfun_d}} and \code{\link{scale_fill_rksfun_d}}
#' for discrete scales and \code{\link{scale_color_rksfun_c}} and \code{\link{scale_fill_rksfun_c}} for continuous scales.
#'
#' @param name Name of Palette. Choices are:
#' \code{rktbns_post}, and \code{tf2}
#' @param direction Sets order of colors. Default palette is 1. If direction is -1, palette color order is reversed
#' @param override.order Colors are picked from palette to maximize readability and aesthetics. This means
#' that colors are not always selected in sequential order from the full palette. If override.order is set to TRUE,
#' colors are selected in sequential order from the full palette instead. Default is FALSE.
#' @param ... Other arguments passed on to \code{\link[ggplot2]{discrete_scale}}
#' @import ggplot2
#' @return A function that returns a discrete colour scale.
#' @export

scale_colour_rksfun_d <- scale_color_rksfun_d

#' rksfunPalettes for plotting with ggplot2
#'
#' Function for using \code{rksfunPalettes} colors schemes in \code{ggplot2}. Use \code{\link{scale_color_rksfun_d}} and \code{\link{scale_fill_rksfun_d}}
#' for discrete scales and \code{\link{scale_color_rksfun_c}} and \code{\link{scale_fill_rksfun_c}} for continuous scales.
#'
#' @param name Name of Palette. Choices are:
#' \code{rktbns_post}, and \code{tf2}
#' @param direction Sets order of colors. Default palette is 1. If direction is -1, palette color order is reversed
#' @param ... Other arguments passed on to \code{\link[ggplot2]{scale_color_gradientn}}
#' @import ggplot2
#' @return A function that returns a continuous colour scale.
#' @export

scale_colour_rksfun_c <- scale_color_rksfun_c
