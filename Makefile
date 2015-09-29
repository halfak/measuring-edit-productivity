hdfs_dir = /user/halfak/streaming

# Simplewiki
datasets/simplewiki-20141122.diffs:
	./hadoop/json2diffs.hadoop \
		simplewiki-20141122.diffs \
		western.diffs.yaml \
		$(hdfs_dir)/simplewiki-20141122/json-snappy \
		$(hdfs_dir)/simplewiki-20141122/diffs-snappy && \
	(du -hs /mnt/hdfs$(hdfs_dir)/simplewiki-20141122/diffs-snappy; \
	 ls -al --color=never /mnt/hdfs$(hdfs_dir)/simplewiki-20141122/diffs-snappy) > \
	datasets/simplewiki-20141122.diffs

datasets/simplewiki-20141122.persistence: \
		datasets/simplewiki-20141122.diffs
	./hadoop/diffs2persistence.hadoop \
		simplewiki-20141122.persistence
		20141122000000 \
		$(hdfs_dir)/simplewiki-20141122/diffs-snappy \
		$(hdfs_dir)/simplewiki-20141122/persistence-snappy && \
	(du -hs /mnt/hdfs$(hdfs_dir)/simplewiki-20141122/persistence-snappy; \
	 ls -al --color=never /mnt/hdfs$(hdfs_dir)/simplewiki-20141122/persistence-snappy) > \
	datasets/simplewiki-20141122.persistence

datasets/simplewiki-20141122.stats: \
		datasets/simplewiki-20141122.persistence
	./hadoop/persistence2stats.hadoop \
		simplewiki-20141122.stats \
		$(hdfs_dir)/simplewiki-20141122/persistence-snappy \
		$(hdfs_dir)/simplewiki-20141122/stats-snappy && \
	(du -hs /mnt/hdfs$(hdfs_dir)/simplewiki-20141122/stats-snappy; \
	 ls -al --color=never /mnt/hdfs$(hdfs_dir)/simplewiki-20141122/stats-snappy) > \
	datasets/simplewiki-20141122.stats


# Ptwiki
/a/halfak/streaming/ptwiki-20141229.json.bz2:
	mwstream dump2json --verbose \
                /mnt/data/xmldatadumps/public/ptwiki/20141229/ptwiki-20141229-pages-meta-history*.xml.bz2 | \
        bzip2 -c > /a/halfak/streaming/ptwiki-20141229.json.bz2

datasets/ptwiki-20141229.json: /a/halfak/streaming/ptwiki-20141229.json.bz2
	hdfs dfs -put \
		/a/halfak/streaming/ptwiki-20141229.json.bz2 \
		$(hdfs_dir)/ptwiki-20141229/json-bz2/dump.json.bz2 && \
	(du -hs /mnt/hdfs$(hdfs_dir)/ptwiki-20141229/json-bz2; \
         ls -al --color=never /mnt/hdfs$(hdfs_dir)/ptwiki-20141229/json-bz2) > \
        datasets/ptwiki-20141229.diffs


# Enwiki
datasets/enwiki-20150602.diffs:
	./hadoop/json2diffs.hadoop \
            enwiki-20150602.diffs \
	    western.diffs.yaml \
	    $(hdfs_dir)/enwiki-20150602/json-snappy \
	    $(hdfs_dir)/enwiki-20150602/diffs-snappy && \
	(du -hs /hdfs$(hdfs_dir)/enwiki-20150602/diffs-snappy; \
	 ls -al --color=never /hdfs$(hdfs_dir)/enwiki-20150602/diffs-snappy) > \
	datasets/enwiki-20150602.diffs

datasets/enwiki-20150602.subset-diffs:
	./hadoop/json2diffs.hadoop \
	    enwiki-20150602.subset-diffs \
	    western.diffs.yaml \
	    $(hdfs_dir)/enwiki-20150602/json-snappy/part-00001.snappy \
	    $(hdfs_dir)/enwiki-20150602/subset-diffs-snappy && \
	(du -hs /hdfs$(hdfs_dir)/enwiki-20150602/subset-diffs-snappy; \
	 ls -al --color=never /hdfs$(hdfs_dir)/enwiki-20150602/subset-diffs-snappy) > \
	datasets/enwiki-20150602.subset-diffs

# Enwiki filtered diff test
#datasets/filtered-enwiki-20141106.diffs:
#	./hadoop/json2diffs.hadoop \
#            filtered-enwiki-20141106.diffs \
#            western.diffs.yaml \
#            $(hdfs_dir)/enwiki-20141106/filtered-json-snappy \
#            $(hdfs_dir)/enwiki-20141106/filtered-diffs-snappy && \
#        (du -hs /hdfs$(hdfs_dir)/enwiki-20141106/filtered-diffs-snappy; \
#         ls -al --color=never /hdfs$(hdfs_dir)/enwiki-20141106/filtered-diffs-snappy) > \
#        datasets/filtered-enwiki-20141106.diffs



# Enwiki filtered small diff test
#datasets/filtered-small-enwiki-20141106.diffs:
#	./hadoop/json2diffs.hadoop \
#	    filtered-small-enwiki-20141106.diffs \
#	    western.diffs.yaml \
#	    $(hdfs_dir)/enwiki-20141106/filtered-json-plain-small.json \
#	    $(hdfs_dir)/enwiki-20141106/filtered-small-diffs-snappy && \
#	(du -hs /mnt/hdfs$(hdfs_dir)/enwiki-20141106/filtered-small-diffs-snappy; \
#	 ls -al --color=never /mnt/hdfs$(hdfs_dir)/enwiki-20141106/filtered-small-diffs-snappy) > \
#	datasets/filtered-small-enwiki-20141106.diffs

# Enwiki token persistence (hadoop)
#datasets/enwiki-20150602.persistence: datasets/enwiki-20150602.diffs
#	./hadoop/diffs2persistence.hadoop \
#		enwiki-20150602.persistence \
#		20150602000000 \
#		$(hdfs_dir)/enwiki-20150602/diffs-snappy \
#		$(hdfs_dir)/enwiki-20150602/persistence-bz2
#	(du -hs /mnt/hdfs$(hdfs_dir)/enwiki-20150602/persistence-snappy; \
#	 ls -al --color=never /mnt/hdfs$(hdfs_dir)/enwiki-20150602/persistence-snappy) > \
#	datasets/enwiki-20150602.persistence

# Enwiki token persistence (local)
datasets/enwiki-20150602/persistence.info: datasets/enwiki-20150602/diffs.info
	mwpersistence diffs2persistence \
		datasets/enwiki-20150602/diffs-bz2/*.bz2 \
		--sunset 20150602000000 \
		--window 50 \
		--revert-radius 15 \
                --thread 10 \
		--output datasets/enwiki-20150602/persistence-bz2 
		--compress bz2 && \
	(du -hs datasets/enwiki-20150602/persistence-bz2; \
         ls -al --color=never datasets/enwiki-20150602/persistence-bz2) > \
        datasets/enwiki-20150602/persistence.info

#datasets/enwiki-20141106.subset_persistence: datasets/enwiki-20141106.diffs
#	./hadoop/diffs2persistence.hadoop \
#		enwiki-20141106.subset_persistence \
#		20141106000000 \
#		$(hdfs_dir)/enwiki-20141106/diffs-snappy/part-00001.snappy \
#		$(hdfs_dir)/enwiki-20141106/subset_persistence-snappy
#	(du -hs /mnt/hdfs$(hdfs_dir)/enwiki-20141106/subset_persistence-snappy; \
#	 ls -al --color=never /mnt/hdfs$(hdfs_dir)/enwiki-20141106/subset_persistence-snappy) > \
#	datasets/enwiki-20141106.subset_persistence
