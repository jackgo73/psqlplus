--https://github.com/digoal/blog/blob/master/201704/20170424_06.md
select userid::regrole, dbid, query from pg_stat_statements order by (shared_blks_hit+shared_blks_dirtied) desc limit 5;    
