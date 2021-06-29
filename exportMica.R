library(micar)

con <- mica.login(username = "administrator", 
									password = "password", 
									url = "https://mica-demo.obiba.org/")

df_networks <- mica.networks(con)
df_studies <- mica.studies(con)
df_populations <- mica.study.populations(con)
df_datacollections <- mica.study.dces(con)
df_datasets <- mica.datasets(con)

mica.logout(con)

rm(con)

save(df_networks, df_studies, df_populations, df_datacollections, 
		 df_datasets, file = "covid19_mica.RData")
