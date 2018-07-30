-- source: https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select current_database(),t2.schemaname,t2.relname,t2.indexrelname,t2.idx_scan,t2.idx_tup_read,t2.idx_tup_fetch,pg_size_pretty(pg_relation_size(indexrelid)) 
from pg_stat_all_tables t1,pg_stat_all_indexes t2 
where t1.relid=t2.relid and t2.idx_scan<10 and t2.schemaname not in ($$pg_toast$$,$$pg_catalog$$) and indexrelid not in 
  (
    select conindid 
    from pg_constraint 
    where contype in ($$p$$,$$u$$,$$f$$)
  ) 
and pg_relation_size(indexrelid)>65536 order by pg_relation_size(indexrelid) desc
