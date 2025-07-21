# plumber.R
library(plumber)
library(DBI)
library(RPostgres)

# IMPORTANT: This line reads the secret database link we will give to Render.
# It keeps your password out of your code!
db_url <- Sys.getenv("DATABASE_URL")

# Connect to the database
con <- dbConnect(RPostgres::Postgres(), dsn = db_url)

#* @apiTitle Real Database API
#* @apiDescription An API that serves data from a PostgreSQL database.

#* Return all data
#* @get /all_products
function() {
  dbGetQuery(con, "SELECT * FROM products;")
}

#* Filter data by a specific category
#* @get /find_product
#* @param cat The category to search for (e.g., 'dairy')
function(cat = "") {
  if (cat == "") {
    return(list(error = "You need to provide a category. Try ?cat=dairy"))
  }
  # Use a "parameterized query" to prevent SQL injection
  query <- "SELECT * FROM products WHERE category = $1;"
  dbGetQuery(con, query, params = list(tolower(cat)))
}