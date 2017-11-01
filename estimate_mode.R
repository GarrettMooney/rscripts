# Take the maximum of a density estimate:
# usage: estimate(s)
estimate_mode <- function(s) {
  d <- density(s)
  d$x[which.max(d$y)]
}
