hdfs_dir = /user/halfak/streaming

# Enwiki diffs (hadoop)
datasets/enwiki-20150602.diffs:
	./hadoop/json2diffs.hadoop \
            enwiki-20150602.diffs \
	    western.diffs.yaml \
	    $(hdfs_dir)/enwiki-20150602/json-snappy \
	    $(hdfs_dir)/enwiki-20150602/diffs-snappy && \
	(du -hs /hdfs$(hdfs_dir)/enwiki-20150602/diffs-snappy; \
	 ls -al --color=never /hdfs$(hdfs_dir)/enwiki-20150602/diffs-snappy) > \
	datasets/enwiki-20150602.diffs

# Enwiki token persistence (local)
datasets/enwiki-20150602/persistence.info: datasets/enwiki-20150602/diffs.info
	mwpersistence diffs2persistence \
		datasets/enwiki-20150602/diffs-bz2/*.bz2 \
		--sunset 20150602000000 \
		--window 50 \
		--revert-radius 15 \
		--output datasets/enwiki-20150602/persistence-bz2
		--compress bz2 && \
	(du -hs datasets/enwiki-20150602/persistence-bz2; \
         ls -al --color=never datasets/enwiki-20150602/persistence-bz2) > \
        datasets/enwiki-20150602/persistence.info
