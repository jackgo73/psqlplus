-- https://github.com/digoal/blog/blob/master/201806/20180613_04.md
select current_database(),* 
from pg_stat_all_tables 
where schemaname <> 'pg_catalog' and schemaname <> 'pg_toast'
order by seq_scan desc limit 10;
