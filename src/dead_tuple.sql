-- source: https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select current_database(),schemaname,relname,n_dead_tup from pg_stat_all_tables where n_live_tup>0 and n_dead_tup/n_live_tup>0.2 and schemaname not in ($$pg_toast$$,$$pg_catalog$$) order by n_dead_tup desc limit 5;
