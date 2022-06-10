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