# Get query without leaving open connections.
library(RSQLite)
sqlite_get_query <- function(db, sql)
{
  conn <- dbConnect(RSQLite::SQLite(), db)
  on.exit(dbDisconnect(conn))
  dbGetQuery(conn, sql)
}
