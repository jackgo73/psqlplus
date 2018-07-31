--https://github.com/digoal/blog/blob/master/201806/20180613_04.md
select current_database(),* 
from pg_stat_all_indexes 
where (idx_scan=0 or idx_tup_read=0 or idx_tup_fetch=0) and schemaname<>'pg_toast' and schemaname<>'pg_catalog';
