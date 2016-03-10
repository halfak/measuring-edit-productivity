source("env.R")
source("util.R")

load.per_user_persistence_stats = tsv_loader(
	paste(DATA_DIR, "enwiki-20150602/per_user_persistence_stats.tsv", sep="/"),
	"PER_USER_PERSISTENCE_STATS",
	function(dt){
		dt$month = as.Date(paste(dt$month, "01", sep="-"))
		dt
	}
)
