-- https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select spcname,pg_tablespace_location(oid),pg_size_pretty(pg_tablespace_size(oid)) from pg_tablespace order by pg_tablespace_size(oid) desc;
