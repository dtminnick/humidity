
#' Find Peaks
#'
#' \code{find_peaks} detects local peaks in values in a vector or data frame
#' using a threshold for comparing each value to adjacent values.  It returns a
#' numeric vector containing the indices of those peak values.
#'
#' @details A peak value is defined as a maximum value with a set of values
#' with a set number of points either side of the value being smaller than it.
#' The \code{find_peaks} function becomes more stringent in identifying a peak
#' as the number of adjacent points evaluated increases.
#'
#' @param source Vector, list or data frame input.
#'
#' @param m Number of adjacent points on each side of a value to include in
#' evaluation.  Defaults to a value of 3.
#'
#' @return A numeric vector containing indices of the peak values from the
#' original source data.
#'
#' @examples
#'
#' source <- c(1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 4, 3, 2, 1)
#'
#' peaks <- find_peaks(source, 4)
#'
#' @export

find_peaks <- function (source, m = 3){

    shape <- diff(sign(diff(source, na.pad = FALSE)))

    peaks <- sapply(which(shape < 0), FUN = function(i){

        z <- i - m + 1

        z <- ifelse(z > 0, z, 1)

        w <- i + m + 1

        w <- ifelse(w < length(source), w, length(source))

        if(all(source[c(z : i, (i + 2) : w)] <= source[i + 1])) {

            return(i + 1)

        } else {

            return(numeric(0))

        }

    })

    peaks <- unlist(peaks)

    return(peaks)

}


