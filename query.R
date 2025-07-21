# Your API's base URL will look something like this.
# Find it on your Render.com dashboard for your service.
# -----------------------------------------------------------------
# !!! IMPORTANT: REPLACE THIS URL WITH YOUR OWN RENDER URL !!!
# -----------------------------------------------------------------
API_BASE_URL <- "https://metadb.onrender.com"
# -----------------------------------------------------------------


# =================================================================
# Example 1: Querying the API with R
# =================================================================
# You'll need the 'httr2' and 'jsonlite' packages.
# install.packages(c("httr2", "jsonlite"))

library(httr2)
library(jsonlite)

# --- Query 1: Get all products ---
all_products_url <- paste0(API_BASE_URL, "/all_products")

# Create and perform the request
req_all <- request(all_products_url)
resp_all <- req_perform(req_all)

# Check if the request was successful (status 200)
if (resp_status(resp_all) == 200) {
  # Parse the JSON response into an R data frame
  all_products_df <- resp_body_json(resp_all, simplifyVector = TRUE)
  print("--- All Products (R) ---")
  print(all_products_df)
} else {
  print(paste("Error fetching all products. Status:", resp_status(resp_all)))
}


# --- Query 2: Find products by category (e.g., 'dairy') ---
find_product_url <- paste0(API_BASE_URL, "/find_product")

# Create the request and add the 'cat' parameter to the URL
req_find <- request(find_product_url) |>
  req_url_query(cat = "dairy")

resp_find <- req_perform(req_find)

if (resp_status(resp_find) == 200) {
  dairy_products_df <- resp_body_json(resp_find, simplifyVector = TRUE)
  print("--- Dairy Products (R) ---")
  print(dairy_products_df)
} else {
  print(paste("Error fetching dairy products. Status:", resp_status(resp_find)))
}

