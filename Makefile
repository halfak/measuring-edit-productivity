# Simplewiki
datasets/simplewiki-20141122.diffs:
	./json2diffs.in_hadoop \
		simplewiki-20141122.diffs \
		western.diffs.yaml \
		/user/halfak/streaming/simplewiki-20141122/json-snappy \
		/user/halfak/streaming/simplewiki-20141122/diffs-snappy && \
	(du -hs /mnt/hdfs/user/halfak/streaming/simplewiki-20141122/diffs-snappy; \
	 ls -al --color=never /mnt/hdfs/user/halfak/streaming/simplewiki-20141122/diffs-snappy) > \
	datasets/simplewiki-20141122.diffs

datasets/simplewiki-20141122.persistence: \
		datasets/simplewiki-20141122.diffs
	./diffs2persistence.in_hadoop \
		simplewiki-20141122.persistence
		20141122000000 \
		/user/halfak/streaming/simplewiki-20141122/diffs-snappy \
		/user/halfak/streaming/simplewiki-20141122/persistence-snappy && \
	(du -hs /mnt/hdfs/user/halfak/streaming/simplewiki-20141122/persistence-snappy; \
	 ls -al --color=never /mnt/hdfs/user/halfak/streaming/simplewiki-20141122/persistence-snappy) > \
	datasets/simplewiki-20141122.persistence

datasets/simplewiki-20141122.stats: \
		datasets/simplewiki-20141122.persistence
	./persistence2stats.in_hadoop \
		simplewiki-20141122.stats \
		/user/halfak/streaming/simplewiki-20141122/persistence-snappy \
		/user/halfak/streaming/simplewiki-20141122/stats-snappy && \
	(du -hs /mnt/hdfs/user/halfak/streaming/simplewiki-20141122/stats-snappy; \
	 ls -al --color=never /mnt/hdfs/user/halfak/streaming/simplewiki-20141122/stats-snappy) > \
	datasets/simplewiki-20141122.stats


# Ptwiki
/a/halfak/streaming/ptwiki-20141229.json.bz2: 
	mwstream dump2json --verbose \
                /mnt/data/xmldatadumps/public/ptwiki/20141229/ptwiki-20141229-pages-meta-history*.xml.bz2 | \
        bzip2 -c > /a/halfak/streaming/ptwiki-20141229.json.bz2

datasets/ptwiki-20141229.json: /a/halfak/streaming/ptwiki-20141229.json.bz2
	hdfs dfs -put \
		/a/halfak/streaming/ptwiki-20141229.json.bz2 \
		/user/halfak/streaming/ptwiki-20141229/json-bz2/dump.json.bz2 && \
	(du -hs /mnt/hdfs/user/halfak/streaming/ptwiki-20141229/json-bz2; \
         ls -al --color=never /mnt/hdfs/user/halfak/streaming/ptwiki-20141229/json-bz2) > \
        datasets/ptwiki-20141229.diffs


# Enwiki
datasets/enwiki-20150602.diffs:
	./json2diffs.in_hadoop \
            enwiki-20150602.diffs \
	    western.diffs.yaml \
	    /user/halfak/streaming/enwiki-20150602/json-snappy \
	    /user/halfak/streaming/enwiki-20150602/diffs-snappy && \
	(du -hs /hdfs/user/halfak/streaming/enwiki-20150602/diffs-snappy; \
	 ls -al --color=never /hdfs/user/halfak/streaming/enwiki-20150602/diffs-snappy) > \
	datasets/enwiki-20150602.diffs


datasets/enwiki-20150602.subset-diffs:
	./json2diffs.in_hadoop \
	    enwiki-20150602.subset-diffs \
	    western.diffs.yaml \
	    /user/halfak/streaming/enwiki-20150602/json-snappy/part-00001.snappy \
	    /user/halfak/streaming/enwiki-20150602/subset-diffs-snappy && \
	(du -hs /hdfs/user/halfak/streaming/enwiki-20150602/subset-diffs-snappy; \
	 ls -al --color=never /hdfs/user/halfak/streaming/enwiki-20150602/subset-diffs-snappy) > \
	datasets/enwiki-20150602.subset-diffs

# Enwiki filtered diff test
#datasets/filtered-enwiki-20141106.diffs:
#	./json2diffs.in_hadoop \
#            filtered-enwiki-20141106.diffs \
#            western.diffs.yaml \
#            /user/halfak/streaming/enwiki-20141106/filtered-json-snappy \
#            /user/halfak/streaming/enwiki-20141106/filtered-diffs-snappy && \
#        (du -hs /hdfs/user/halfak/streaming/enwiki-20141106/filtered-diffs-snappy; \
#         ls -al --color=never /hdfs/user/halfak/streaming/enwiki-20141106/filtered-diffs-snappy) > \
#        datasets/filtered-enwiki-20141106.diffs



# Enwiki filtered small diff test
#datasets/filtered-small-enwiki-20141106.diffs:
#	./json2diffs.in_hadoop \
#	    filtered-small-enwiki-20141106.diffs \
#	    western.diffs.yaml \
#	    /user/halfak/streaming/enwiki-20141106/filtered-json-plain-small.json \
#	    /user/halfak/streaming/enwiki-20141106/filtered-small-diffs-snappy && \
#	(du -hs /mnt/hdfs/user/halfak/streaming/enwiki-20141106/filtered-small-diffs-snappy; \
#	 ls -al --color=never /mnt/hdfs/user/halfak/streaming/enwiki-20141106/filtered-small-diffs-snappy) > \
#	datasets/filtered-small-enwiki-20141106.diffs

# Enwiki token persistence
datasets/enwiki-20150602.persistence: datasets/enwiki-20150602.diffs
	./diffs2persistence.in_hadoop \
		enwiki-20150602.persistence \
		20150602000000 \
		/user/halfak/streaming/enwiki-20150602/diffs-snappy \
		/user/halfak/streaming/enwiki-20150602/persistence-bz2
	(du -hs /mnt/hdfs/user/halfak/streaming/enwiki-20150602/persistence-snappy; \
	 ls -al --color=never /mnt/hdfs/user/halfak/streaming/enwiki-20150602/persistence-snappy) > \
	datasets/enwiki-20150602.persistence

#datasets/enwiki-20141106.subset_persistence: datasets/enwiki-20141106.diffs
#	./diffs2persistence.in_hadoop \
#		enwiki-20141106.subset_persistence \
#		20141106000000 \
#		/user/halfak/streaming/enwiki-20141106/diffs-snappy/part-00001.snappy \
#		/user/halfak/streaming/enwiki-20141106/subset_persistence-snappy
#	(du -hs /mnt/hdfs/user/halfak/streaming/enwiki-20141106/subset_persistence-snappy; \
#	 ls -al --color=never /mnt/hdfs/user/halfak/streaming/enwiki-20141106/subset_persistence-snappy) > \
#	datasets/enwiki-20141106.subset_persistence
