#' Calculate question hardness
#'
#' @param d_long long-format marks df as made by `make_long`
#'
#' @return data frame of questions and mean percent of maximum grade over students
#' @examples
#' test_long <- make_long(test_grades)
#' make_hardness(test_long)
#'
#' @export
make_hardness <- function(d_long) {
  d_long %>% dplyr::group_by(q) %>% dplyr::summarize(mx=max(mark)) -> qmax
  d_long %>% dplyr::left_join(qmax) %>%
    dplyr::mutate(pct=mark/mx*100) %>%
    dplyr::group_by(q) %>%
    dplyr::summarize(hard=mean(pct))
}

#' Calculate question discrimination (item-total correlation)
#'
#' @param d_long long-format marks df as made by `make_long`
#'
#' @return data frame of questions and item-total correlations over students
#' @examples
#' test_long <- make_long(test_grades)
#' make_discrim(test_long)
#'
#' @export
make_discrim <- function(d_long) {
  d_long %>%
    dplyr::group_by(q) %>%
    dplyr::summarize(cor=cor(mark, Total))
}

#' Calculate hardness and discrimination for all questions
#'
#' @param d_wide wide-format marks df with each question in one column
#'
#' @return data frame of questions, hardness values and item-total correlations
#' @examples
#' make_all(test_grades)
#'
#' @export
make_all <- function(d_wide) {
  d_long <- make_long(d_wide)
  hardness <- make_hardness(d_long)
  discrim <- make_discrim(d_long)
  hardness %>% dplyr::left_join(discrim)
}

#' Compute exam total score statistics
#'
#' @param d_wide wide-format marks df with each question in one column
#' @param ... additional arguments to `quantile`
#'
#' @return named vector of quantiles of exam totals
#'
#' @examples
#' make_stats(test_grades)
#' make_stats(test_grades, c(0.4, 0.6))
#'
#' @export
make_stats <- function(d_wide, ...) {
  quantile(d_wide$Total, ...)
}
