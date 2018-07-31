--https://github.com/digoal/blog/blob/master/201704/20170424_06.md
select userid::regrole, dbid, query from pg_stat_statements order by (blk_read_time+blk_write_time) desc limit 5;   
