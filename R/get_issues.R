#' Query the Github API
#' 
#' This function takes as input the Github API app name, the Github API
#' key, the corresponding secret, the organization and repo name, and uses
#' the Github api and \code{httr} package to query the API for the issues
#' in that repository.
#'
#' @param appname_ The name of the application you have authorized on Github.
#' @param key_ The key you have authorized on Github.
#' @param secret_ The secret corresponding to the key.
#' @param repo_name The name of the repository
#' @return A \code{json} list of returned issues from Github.
#' @examples
#' \dontrun{
#' get_issues(appname_ = "github",
#' key_ = "56b637a5baffac62cad9",
#' secret_ = "8e107541ae1791259e9987d544ca568633da2ebf",
#' repo_name = "r-lib/httr")
#' }
#' @export
get_issues <- function(appname_, key_, secret_, repo_name, type = "issues") {

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
    repo_name, type
  ), gtoken)


  # Take action on http error
  httr::stop_for_status(req)

  # Extract content from a request
  json1 <- httr::content(req)

  # Convert to a data.frame
  git_df <- jsonlite::fromJSON(jsonlite::toJSON(json1))
  return(git_df)
}