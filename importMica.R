library(micar)

# get df_projects and projets from export
load(file = "covid19_mica.RData")

# using the docker-mica instance from github 
# (see https://github.com/obiba/docker-mica)
con <- mica.login(username = "administrator",
									password = "password",
									url = "http://localhost:8882")

# TODO: implement the importing of the data frames

# micar seems not to have write functions :(

mica.logout(con)

rm(con)
