source("env.R")
source("util.R")

load.monthly_persistence_stats = tsv_loader(
	paste(DATA_DIR, "enwiki-20150602/monthly_persistence_stats.tsv", sep="/"),
	"MONTHLY_PERSISTENCE_STATS",
	function(dt){
		dt$month = as.Date(paste(dt$month, "01", sep="-"))
		dt
	}
)
