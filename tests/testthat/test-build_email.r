test_that("build_email works", {
  #use httr package example
  json_in <- get_issues(appname_ = "github",
  key_ = "56b637a5baffac62cad9",
  secret_ = "8e107541ae1791259e9987d544ca568633da2ebf",
  repo_name = "r-lib/httr")

  testthat::expect_output(
    build_email(from = "christine.stawitz@noaa.gov",
   to = "fisheries.toolbox@noaa.gov", creds = creds(provider = "gmail",
       user = "sender@email.com"), body = "Hi, Check out the current status",
    table_iss = create_pr_table(json_in), 
    table_pr = create_issue_table(json_in), footer_ = "Thanks, \n Christine")
  )
})
