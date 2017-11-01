library(purrr)
`%T>%` <- magrittr::`%T>%`

N <- 1e4
blu <- '#8080FF'
p_grid <- seq(0.001, .999, len = N)
uniform_prior  <- rep(1, N)
over_50_prior <- ifelse( p_grid < 0.5 , 0 , 1 )
pointy_prior <- exp( -5*abs( p_grid - 0.5 ) )
informative_prior <- dbeta(p_grid, 5, 3)
priors <- list(uniform_prior, over_50_prior, pointy_prior, informative_prior) %>%
  set_names(c('uniform', 'over 50%', 'pointy', 'informative')) 
likelihood <- dbinom(6, 9, p_grid)

par(mfrow = c(2, 2))
priors %>% walk2(., names(.), ~plot(p_grid, .x, main = .y, ylab = '', col = blu))
pmap(list(priors, list(likelihood)), 
     ~ { ..1 * ..2 %>% {. / sum(.)} }) %>%
  map(~ sample(p_grid, prob = ., size = N, replace = T)) %>%
  walk2(., names(.), ~ rethinking::dens(.x, main = .y, 
                                        col = blu, xlim = c(0, 1)))
