source("env.R")
source("util.R")

load.token_persistence_sample = tsv_loader(
	paste(DATA_DIR, "enwiki-20150602/token_persistence_sample.tsv", sep="/"),
	"TOKEN_PERSISTENCE_SAMPLE",
	function(dt){
		is_whitespace = dt$is_whitespace == "True"
		dt$is_whitespace = NULL
		dt$is_whitespace = is_whitespace
		contains_letters = dt$contains_letters == "True"
		dt$contains_letters = NULL
		dt$contains_letters = contains_letters
		dt
	}
)
