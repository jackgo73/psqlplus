-- https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select pg_walfile_name(pg_current_wal_lsn()) now_xlog, * from pg_stat_archiver;
