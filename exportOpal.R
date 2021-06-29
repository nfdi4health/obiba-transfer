library(opalr)

demo <- opal.login(username = "administrator",
		 							 password = "password",
									 url = "https://opal-demo.obiba.org")
con <- demo

df_projects <- opal.projects(con)

projects <- lapply(df_projects$name, function(x){
	project <- opal.project(con, x)
	tablenames <- project$datasource$table
	tables <- lapply(tablenames, function(y){
		df_table <- opal.table_get(con, project$name, y)
		dict <- opal.table_dictionary_get(con, project$name, y)
		attr(df_table, "variables") <- dict$variables
		attr(df_table, "categories") <- dict$categories
		return(df_table)
	})
	names(tables) <- tablenames
	project$tables <- tables
	return(project)
})

opal.logout(con)

rm(con)

names(projects) <- unlist(lapply(projects, function(x){x$name}))

save(df_projects, projects, file = "covid19_opal_tables.RData")

