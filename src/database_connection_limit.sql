-- https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select a.datname, a.datconnlimit, b.connects from pg_database a,(select datname,count(*) connects from pg_stat_activity group by datname) b where a.datname=b.datname order by b.connects desc;
