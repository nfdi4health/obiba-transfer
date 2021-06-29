library(opalr)

# get df_projects and projets from export
load(file = "covid19_opal_tables.RData")

# using the docker-opal instance from github
con <- opal.login(username = "administrator",
									password = "password",
									url = "http://localhost:8870")

# create the projects
lapply(df_projects$name, function(x){
	line <- df_projects[df_projects$name == x, ]
	# database = mongodb for a default docker instance; the project must be linked to a database before importing tables
	opal.project_create(con, project = x, title = line$title, tags = line$tags, database = "mongodb")
})

# create the (empty) project tables
lapply(names(projects), function(x){
	project <- projects[[x]]
	tables <- names(project$tables)
	lapply(tables, function(t){
		df_table <- project$tables[[t]]
		if (opal.table_exists(con, project = project$name, table = t)) {
			# TODO: update table columns
			return(sprintf("found table %s in project %s, ignore recreation", t, project$name))
		} else {
			variables <- attr(project$tables[[t]], "variables")
			categories <- attr(project$tables[[t]], "categories")
			opal.table_create(con, project = project$name, table = t)
			opal.table_dictionary_update(con, project = project$name, table = t, variables = variables, categories = categories)
			return(sprintf("created empty table %s in project %s", t, project$name))
		}
	})
})

opal.logout(con)
