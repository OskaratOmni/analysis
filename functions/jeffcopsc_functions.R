# functions for jeffcopsc
# Oskar needs to make more comments


# helpers for below functions

safe_slug <- function(x) {
  x |>
    gsub("[^A-Za-z0-9]+", "-", x = _, perl = TRUE) |>
    gsub("-+", "-", x = _, perl = TRUE) |>
    gsub("(^-|-$)", "", x = _, perl = TRUE) |>
    tolower()
}

path_base <- file.path("analysis", "output")

path_tbls <- file.path(path_base, "tables")

# Save a data frame to Excel, defaulting to the current chunk label for the filename
emit_table <- function(df, name = NULL, path = path_tbls, quiet = FALSE) {
  # pick a name: prefer explicit name, else chunk label, else object name
  if (is.null(name) || !nzchar(name)) {
    lab <- knitr::opts_current$get("label")
    if (is.null(lab) || !nzchar(lab)) lab <- deparse(substitute(df))
    name <- lab
  }
  name <- safe_slug(name)

  if (!dir.exists(path)) dir.create(path, recursive = TRUE)
  file <- file.path(path, paste0(name, ".xlsx"))

  write_xlsx(df, file) # from writexl
  if (!quiet) message("Wrote: ", file)
  invisible(file)
}
