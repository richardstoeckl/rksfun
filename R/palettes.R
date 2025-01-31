#' @title rksfun palette
#' @description Function to return hex codes for the included palettes
#' @param palette character name of the palette
#' @return character vector of colors
#' @export
rks_palette <- function(palette = "rktbns_post", ...) {

    rks_palettes <- list(
        `rktbns_post` = c("#62292f","#9d4e47","#dc7660","#eb9d77","#fbc78d","#f6d796","#f9e8a3","#dce6a7","#c0e3ab","#9bdfb0","#86dcb5","#59caac","#2dbda4","#3aa794","#48877c","#546f6a","#545955","#554546"),

        `tf2` = c("#395c78","#5b7a8c","#768a88","#6b6a65","#34302d","#462d26","#6a4535","#913a1e","#bd3b3b","#9d312f","#f08149","#ef9849","#f5ad87","#f6b98a","#f5e7de","#c1a18a","#dabdab")
    )

    rks_palettes[[palette]]
}

#' @title rksfun palette generator for discrete palettes
#' @description Function to generate a function that returns a palette of a given length
#' @param palette character name of the palette
#' @param direction integer 1 for normal order, -1 for reversed order
#' @return function that returns a character vector of colors
palette_gen <- function(palette = "rktbns_post", direction = 1) {
    function(n) {
        if (n > length(rks_palette(palette)))
            warning("Not enough colors in this palette!")
        else {
            all_colors <- rks_palette(palette)
            all_colors <- unname(unlist(all_colors))
            all_colors <- if (direction >= 0) all_colors else rev(all_colors)
            color_list <- all_colors[1:n]
        }
    }
}

#' @title rksfun palette generator for continuous palettes
#' @description Function to generate a function that returns a palette of a given length
#' @param palette character name of the palette
#' @param direction integer 1 for normal order, -1 for reversed order
#' @return function that returns a character vector of colors
palette_gen_c <- function(palette = "rktbns_post", direction = 1, ...) {
    pal <- rks_palette(palette)
    pal <- if (direction >= 0) pal else rev(pal)
    grDevices::colorRampPalette(pal, ...)
}

#' @title rksfun fill scale for ggplot2
#' @description Function to create a ggplot2 fill scale function for the rksfun palettes
#' @param palette character name of the palette
#' @param direction integer 1 for normal order, -1 for reversed order
#' @return ggplot2 scale function
#' @export
scale_fill_rksfun <- function(palette = "rktbns_post", direction = 1, ...) {
    ggplot2::discrete_scale(
        "fill", "rksfun",
        palette_gen(palette, direction),
        ...
    )
}

#' @title rksfun color scale for ggplot2
#' @description Function to create a ggplot2 color scale function for the rksfun palettes
#' @param palette character name of the palette
#' @param direction integer 1 for normal order, -1 for reversed order
#' @return ggplot2 scale function
#' @export
scale_colour_rksfun <- function(palette = "rktbns_post", direction = 1, ...) {
    ggplot2::discrete_scale(
        "colour", "rksfun",
        palette_gen(palette, direction),
        ...
    )
}

#' @title rksfun continuous colour scale for ggplot2
#' @description Function to create a continuous ggplot2 colour scale function for the rksfun palettes
#' @param palette character name of the palette
#' @param direction integer 1 for normal order, -1 for reversed order
#' @return ggplot2 scale function
#' @export
scale_color_rksfun_c <- function(palette = "rktbns_post", direction = 1, ...) {
    pal <- palette_gen_c(palette = palette, direction = direction)
    scale_color_gradientn(colors = pal(256), ...)
}

#' @title rksfun continuous fill scale for ggplot2
#' @description Function to create a continuous ggplot2 fill scale function for the rksfun palettes
#' @param palette character name of the palette
#' @param direction integer 1 for normal order, -1 for reversed order
#' @return ggplot2 scale function
#' @export
scale_fill_rksfun_c <- function(palette = "rktbns_post", direction = 1, ...) {
    pal <- palette_gen_c(palette = palette, direction = direction)
    scale_fill_gradientn(colors = pal(256), ...)
}
