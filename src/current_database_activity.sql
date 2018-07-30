-- https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select now(),state,count(*) from pg_stat_activity group by 1,2;
