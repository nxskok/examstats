#' Make longer marks df
#'
#' @param marks_wide A wider df with one column per question and a column `Total` that is sum of marks for each student
#' @return A longer df with all marks in one column and for each student and question: that student's total, the question number, the mark on that question
#'
#' @examples
#' make_long(test_grades)
#' @export
make_long <- function(marks_wide) {
  marks_wide %>% tidyr::pivot_longer(-Total, names_to="q", values_to="mark")
}
