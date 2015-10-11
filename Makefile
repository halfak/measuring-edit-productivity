hdfs_dir = /user/halfak/streaming

# Enwiki revdocs unsorted (local)
datasets/enwiki-20150901/revdocs_unsorted-bz2:
	mwxml dump2revdocs \
		/mnt/data/xmldatadumps/public/enwiki/20150901/*pages-meta-history*.xml*.bz2 \
		--output datasets/enwiki-20150901/revdocs_unsorted-bz2

# Enwiki revdocs (hadoop)
datasets/enwiki-20150901.revdocs:
	./hadoop/dump2revdocs.hadoop \
	    2000 \
	    $(hdfs_dir)/enwiki-20150901/xml-bz2 \
	    $(hdfs_dir)/enwiki-20150901/revdocs-bz2 && \
	(du -hs /hdfs$(hdfs_dir)/enwiki-20150901/revdocs-bz2; \
	 ls -al --color=never /hdfs$(hdfs_dir)/enwiki-20150901/revdocs-bz2) > \
	datasets/enwiki-20150602.diffs

# Enwiki diffs (hadoop)
datasets/enwiki-20150602/diffs.info: datasets/enwiki-20150602.revdocs
	./hadoop/revdocs2diffs.hadoop \
		enwiki-20150602.diffs \
		western.diffs.yaml \
		$(hdfs_dir)/enwiki-20150602/revdocs-bz2 \
		$(hdfs_dir)/enwiki-20150602/diffs-bz2 && \
	(du -hs /hdfs$(hdfs_dir)/enwiki-20150602/diffs-bz2; \
	 ls -al --color=never /hdfs$(hdfs_dir)/enwiki-20150602/diffs-bz2) > \
	datasets/enwiki-20150602/diffs.info

datasets/enwiki-20150901/diffs.info:
	./hadoop/json2diffs.hadoop \
		enwiki-20150901.diffs \
		western.diffs.yaml \
		$(hdfs_dir)/enwiki-20150901/json-snappy \
		$(hdfs_dir)/enwiki-20150901/diffs-bz2 && \
	(du -hs /hdfs$(hdfs_dir)/enwiki-20150901/diffs-bz2; \
	 ls -al --color=never /hdfs$(hdfs_dir)/enwiki-20150901/diffs-bz2) > \
	datasets/enwiki-20150901/diffs.info

# Enwiki token persistence (local)
#datasets/enwiki-20150602/persistence.info: datasets/enwiki-20150602/diffs.info
#	mwpersistence diffs2persistence \
#		datasets/enwiki-20150602/diffs-bz2/*.bz2 \
#		--sunset 20150602000000 \
#		--window 50 \
#		--revert-radius 15 \
#		--output datasets/enwiki-20150602/persistence-bz2 \
#		--compress bz2 && \
#	(du -hs datasets/enwiki-20150602/persistence-bz2; \
#	 ls -al --color=never datasets/enwiki-20150602/persistence-bz2) > \
#	datasets/enwiki-20150602/persistence.info

datasets/enwiki-20150602/persistence.info: datasets/enwiki-20150602/diffs.info
	./hadoop/diffs2persistence.hadoop \
		enwiki-20150602.persistence \
		20150602000000 \
		$(hdfs_dir)/enwiki-20150602/diffs-bz2 \
		$(hdfs_dir)/enwiki-20150602/persistence-bz2 && \
	(du -hs /hdfs$(hdfs_dir)/enwiki-20150602/persistence-bz2; \
	 ls -al --color=never /hdfs$(hdfs_dir)/enwiki-20150602/persistence-bz2) > \
	datasets/enwiki-20150602/persistence.info
