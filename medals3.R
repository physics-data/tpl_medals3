#!/usr/bin/env Rscript
# -*- coding: utf-8 -*-

library(dbplyr)
library(DBI)
library(dplyr)
library(RSQLite)

# read input command args
args <- commandArgs(trailingOnly = TRUE)
db <- args[1]
output_file <- args[2]

# hack to read lines from stdin
stdin <- file("stdin")
input <- readLines(stdin)
begin <- input[1]
end <- input[2]
close(stdin)

# open sqlite database
con <- dbConnect(RSQLite::SQLite(), db)

tbl(con, "events") %>%
    # TODO: your query code
    # output to CSV
    write.csv(output_file, quote = FALSE, row.names = FALSE)

# close database
dbDisconnect(con)
