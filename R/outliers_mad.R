#' MAD function to detect outliers
#'
#' Detecting univariate outliers using the robust median absolute deviation
#'
#' @param x vector of values from which we want to compute outliers
#' @param b constant depending on the assumed distribution underlying the data, that equals 1/Q(0.75).
#' When the normal distribution is assumed, the constant 1.4826 is used
#' (and it makes the MAD and SD of normal distributions comparable).
#' @param threshold the number of MAD considered as a threshold to consider a value an outlier
#' @param na.rm set whether Missing Values should be excluded (na.rm = TRUE) or not (na.rm = FALSE)
#' - defaults to TRUE
#'
#' @export outliers_mad
#'
#' @S3method outliers_mad default
#' @S3method print outliers_mad
#'
#' @keywords MAD outliers
#' @return Returns Call, median, MAD, limits of acceptable range of values, number of outliers
#' @examples
#'
#' #### Run outliers_mad
#' x <- runif(150,-100,100)
#' outliers_mad(x, b = 1.4826,threshold = 3,na.rm = TRUE)
#'
#' #### Results can be stored in an object.
#' data(Intention)
#' res1=outliers_mad(Intention$age)
#' # Moreover, a list of elements can be extracted from the function,
#' # such as all the extremely high values,
#' # That will be sorted in ascending order
#  res1$U_outliers
#' #### The function should be performed on dimension rather than on isolated items
#' data(Attacks)
#' SOC <- rowMeans(Attacks[,c("soc1r","soc2r","soc3r","soc4","soc5","soc6",
#' "soc7r","soc8","soc9","soc10r","soc11","soc12","soc13")])
#' res=outliers_mad(x = SOC)
#'
#'
#' @importFrom stats na.omit median
#' @importFrom graphics par points rect segments text title plot

# Create a generic function
outliers_mad <- function(x,b,threshold,na.rm) UseMethod("outliers_mad")

# Create a function that compute all required parameters
outliers_madEst <- function(x,
                            b = 1.4826,
                            threshold = 3,
                            na.rm = TRUE){

  # If x is numeric or integer, applying the function.
  # Otherwise, stopping it.
  if(inherits(x,c("numeric","integer")) == FALSE)
    stop("x is neither numeric nor integer")

  if (na.rm == TRUE) {
    data <- na.omit(x)   # incomplete cases are removed
  } else {data <- x}

  # Calculate the MAD
  # computing the median of the data
  # median = the center of the CI defining acceptable values
  center <- median(data)
  # computing the median of data centered around the sample median
  MAD <- b*median(abs(data-center))
  # how many MAD from the median are the limits of the IC?
  half_CI <- threshold*MAD

  # Calculate the range of acceptable values
  LL_CI_MAD <- center-half_CI # lower limit of the median CI
  UL_CI_MAD <- center+half_CI # upper limit of the median CI

  # calculate the outliers
  outliers <- c(data[data < LL_CI_MAD],data[data > UL_CI_MAD])
  outliers_pos <- c(which(data < LL_CI_MAD),which(data > UL_CI_MAD))

  # Return results in list()
   invisible(list(Median = center,
                  MAD = MAD,
                  LL_CI_MAD = LL_CI_MAD,
                  UL_CI_MAD = UL_CI_MAD,
                  L_outliers = sort(data[data < LL_CI_MAD]),
                  U_outliers = sort(data[data > UL_CI_MAD]),
                  outliers = sort(c(data[data < LL_CI_MAD],
                                    data[data > UL_CI_MAD])),
                  outliers_pos=outliers_pos,
                  threshold=threshold))

}


# Adding a default method in defining a function called outliers_mad.default

outliers_mad.default <- function(x,b = 1.4826,threshold = 3,na.rm = TRUE){

    threshold <- as.numeric(threshold)
    na.rm <- as.logical(na.rm)

    out <- outliers_madEst(x,b,threshold,na.rm)
    out$call <- match.call()
    out$median <- out$Median
    out$MAD <- out$MAD
    out$limits <- as.vector(c(lower = out$LL_CI_MAD,upper = out$UL_CI_MAD))
    out$nb <- c("extremely low" = length(out$L_outliers),
                "extremely high" = length(out$U_outliers),
                total = length(out$outliers))

    class(out) <- "outliers_mad"
    out
}

print.outliers_mad <- function(x,...){

  if(sum(is.na(x)) == 0){

  cat("Call:\n")
  print(x$call)

  cat("\nMedian:\n")
  print(x$median)

  cat("\nMAD:\n")
  print(x$MAD)

  cat("\nLimits of acceptable range of values:\n")
  print(x$limits)

  cat("\nNumber of detected outliers\n")
  print(x$nb)
  } else {
    print(paste("Analysis can not be performed due to missing values"))
  }
}

