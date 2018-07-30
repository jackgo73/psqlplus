-- https://github.com/digoal/blog/blob/master/201806/20180613_04.md
select current_database(),* from pg_stat_all_tables order by seq_scan+idx_scan desc limit 10;
