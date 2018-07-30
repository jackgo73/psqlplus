-- source: https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select current_database(), t2.nspname, t1.relname, pg_size_pretty(pg_relation_size(t1.oid)), t3.idx_cnt 
from pg_class t1, pg_namespace t2, 
  (
    select indrelid,count(*) idx_cnt 
    from pg_index group by 1 having count(*)>4
  ) t3 
where t1.oid=t3.indrelid and t1.relnamespace=t2.oid and pg_relation_size(t1.oid)/1024/1024.0>10 
order by t3.idx_cnt desc;
