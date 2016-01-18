SELECT
  user_name,
  LEFT(rev_timestamp, 7) AS month,
  SUM(sum_log_persisted) AS log_persisted,
  SUM(sum_log_non_self_persisted) AS log_non_self_seconds,
  SUM(sum_log_seconds_visible) AS log_seconds,
  SUM(persistent_tokens) AS ptokens,
  SUM(non_self_persistent_tokens) AS ns_ptokens
FROM mep_word_persistence
INNER JOIN enwiki.user USING (user_id)
WHERE user_name IN ("Jimbo Wales", "EpochFail", "DGG", "Ladsgroup")
GROUP BY 1,2;
