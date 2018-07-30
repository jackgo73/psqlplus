-- https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select a.rolname,a.rolconnlimit,b.connects from pg_authid a,(select usename,count(*) connects from pg_stat_activity group by usename) b where a.rolname=b.usename order by b.connects desc;
