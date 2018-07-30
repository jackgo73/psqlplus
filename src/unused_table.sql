-- https://github.com/digoal/blog/blob/master/201806/20180613_04.md
select current_database(),* 
from pg_stat_all_tables 
where seq_scan=0 and idx_scan=0 and schemaname <> 'pg_catalog' and schemaname <> 'pg_toast'; 
