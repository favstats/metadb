# Use a pre-made R environment
FROM rocker/r-ver:4.4.1

# Install helper programs that R needs to talk to the database
RUN apt-get update && apt-get install -y libpq-dev

# Install the R packages needed for the API and the database
RUN R -e "install.packages(c('plumber', 'DBI', 'RPostgres'))"

# Copy all our files into the server
COPY . .

# Tell the server to open a door on port 8000 for our API
EXPOSE 8000

# The command to start the R script
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8000)"]