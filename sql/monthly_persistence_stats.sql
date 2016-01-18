SELECT
  LEFT(rev_timestamp, 7) AS month,
  IF(user_id <= 0, "IP", 
     IF(user_id in (SELECT ufg_user FROM enwiki.user_former_groups 
                    WHERE ufg_group = "bot" UNION 
                    SELECT ug_user FROM enwiki.user_groups 
                    WHERE ug_group = "bot"), "bot", "registered")) AS user_type,
  IF(comment LIKE '%AWB|AWB]]%' OR comment LIKE '%AutoWikiBrowser%' OR comment LIKE '% via awb %', 'awb',
     IF(comment LIKE '%WP:AFCH%', 'afch',
     IF(comment LIKE '%Scripts|CSDH%', 'csdh',
     IF(comment LIKE '%[[Help:Cat-a-lot|Cat-a-lot]]%', 'cat-a-lot',
     IF(comment LIKE '%|AutoEd]]%', 'autoed',
     IF(comment LIKE '%[[:en:WP:REFILL|reFill]]%', 'refill',
     IF(comment LIKE '%WP:HC|HotCat%', 'hotcat',
     IF(comment LIKE '%WP:MOSNUMscript%', 'mosnumscript',
     IF(comment LIKE '%WP:REFLINKS|Reflinks]%', 'reflinks',
     IF(comment LIKE '%via CenPop%', 'cenpop',
     IF(comment LIKE '%User:Ohconfucius/script|Script%', 'ohconfucius',
     IF(comment LIKE '%User:GregU/dashes.js|script%', 'gregu-dashes', NULL)))))))))))) AS tool_used,
  SUM(sum_log_persisted) AS log_persisted,
  SUM(sum_log_non_self_persisted) AS log_non_self_seconds,
  SUM(sum_log_seconds_visible) AS log_seconds,
  SUM(persistent_tokens) AS ptokens,
  SUM(non_self_persistent_tokens) AS ns_ptokens
FROM mep_word_persistence
LEFT JOIN enwiki.user_groups bot ON 
  ug_user = user_id AND
  ug_group = "bot"
LEFT JOIN enwiki.user_former_groups former_bot ON
  ufg_user = user_id AND
  ufg_group = "bot"
GROUP BY month, user_type, tool_used;
