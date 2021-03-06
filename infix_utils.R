## Set operators & misc
`%nin%` <- Negate(`%in%`)
`%in_v%` <- function(x, y) x[x %in% y] 
`%nin_v%` <- function(x, y) x[!x %in% y] 
`%in_d%` <- function(x, y) x[names(x) %in% y] 
`%nin_d%` <- function(x, y) x[!names(x) %in% y] 
`%+%` <- function(x, y) paste0(x, y)

## magrittr pipe
`%>%` <- magrittr::`%>%`
`%<>%` <- magrittr::`%<>%`
`%T>%` <- magrittr::`%T>%`

## Time operators
`%m+%` <- lubridate::`%m+%`
`%m-%` <- lubridate::`%m-%`
