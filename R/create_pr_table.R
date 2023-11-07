#' Creates a table of pull requests
#' 
#' This function takes a \code{json} input table generated from the Github
#' API, and creates a pull request table with the fields number, title, labels,
#' milestone, pull_request, and assignee. The table is returned as an 
#' \code{html} table grouped by milestone.
#'
#' @param json_input A \code{json} table generated from the Github API.
#' @return A \code{html} table of pull requests.
#' @export
create_pr_table <- function(json_input) {
  sub <- json_input |> dplyr::select(
    "number", "title", "labels",
    "milestone", "requested_reviewers", "assignee", 
  )
  pr_table <- data.frame(
    "number" = NA, "title" = NA, "assignee" = NA, "requested_reviewers" = NA,
    status = NA
  )

  k <- j <- 1
  for (i in seq_len(nrow(sub))) {
      pr_table[j, ]$number <- sub[i, "number"][[1]]
      pr_table[j, ]$title <- sub[i, "title"][[1]]
      pr_table[j, ]$assignee <- sub[i, ]$assignee$login[[1]]
      pr_table[j, ]$requested_reviewers <- sub[i, ]$requested_reviewers
      j <- j + 1
  }

  return(knitr::kable(pr_table, row.names = FALSE, format = "html"))
}