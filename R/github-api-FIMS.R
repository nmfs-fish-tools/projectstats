get_issues <- function(appname_, key_, secret_, org_name, repo_name) {

  # Change based on what you
  myapp <- httr::oauth_app(
    appname = appname_,
    key = key_,
    secret = secret_
  )

  # Get OAuth credentials
  # Can be github, linkedin etc depending on application
  github_token <- httr::oauth2.0_token(httr::oauth_endpoints("github"), myapp)

  # Use API
  gtoken <- httr::config(token = github_token)
  req <- httr::GET(file.path(
    "https://api.github.com/repos",
    org_name, repo_name, "issues"
  ), gtoken)


  # Take action on http error
  httr::stop_for_status(req)

  # Extract content from a request
  json1 <- httr::content(req)

  # Convert to a data.frame
  git_df <- jsonlite::fromJSON(jsonlite::toJSON(json1))
  return(git_df)
}

create_issue_table <- function(json_input) {
  sub <- json_input |> dplyr::select(
    "number", "title", "labels",
    "milestone", "pull_request", "assignee"
  )

  issue_table <- data.frame(
    "number" = NA, "title" = NA, "milestone" = NA,
    "assignee" = NA, "labels" = NA, "label_col" = NA, "status" = NA
  )
  k <- j <- 1
  for (i in seq_len(length(sub))) {
    if (is.null(sub[i, ]$pull_request$url[[1]])) {
      issue_table[k, ]$number <- sub[i, "number"][[1]]
      issue_table[k, ]$title <- sub[i, "title"][[1]]
      issue_table[k, ]$milestone <- sub[i, ]$milestone$number[[1]]
      issue_table[k, ]$assignee <- paste(unlist(sub[i, ]$assignee$login),
       collapse = ", ")
      issue_table[k, ]$labels <- paste(unlist(sub[i, ]$labels[[1]]$name),
       collapse = ", ")
      issue_table[k, ]$label_col <- paste(unlist(sub[i, ]$labels[[1]]$color),
       collapse = ", ")
      k <- k + 1
    }
  }

  issue_table <- issue_table[order(issue_table$milestone), ]
  miles <- which(issue_table$milestone == 2)
  require(kableExtra)
  issue_txt <- knitr::kable(subset(issue_table, select = -c(label_col)),
    row.names = FALSE,
    format = "html", align = "l"
  ) |>
    pack_rows(index = c(
      "milestone 1" = miles[1] - 1,
      "milestone 2" = length(miles)
    ))

  return(issue_txt)
}

create_pr_table <- function(json_input) {
  sub <- json_input |> dplyr::select(
    "number", "title", "labels",
    "milestone", "pull_request", "assignee"
  )
  pr_table <- data.frame(
    "number" = NA, "title" = NA, "assignee" = NA,
    status = NA
  )

  k <- j <- 1
  for (i in seq_len(length(sub))) {
    if (!is.null(sub[i, ]$pull_request$url[[1]])) {
      pr_table[j, ]$number <- sub[i, "number"][[1]]
      pr_table[j, ]$title <- sub[i, "title"][[1]]
      pr_table[j, ]$assignee <- sub[i, ]$assignee$login[[1]]
      j <- j + 1
    }
  }

  return(knitr::kable(pr_table, row.names = FALSE, format = "html"))
}
