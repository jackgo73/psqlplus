-- https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select datname,pg_size_pretty(pg_database_size(oid)) from pg_database order by pg_database_size(oid) desc;
