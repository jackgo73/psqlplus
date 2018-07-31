--https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select userid::regrole, dbid, query from pg_stat_statements order by total_time desc limit 5;    
