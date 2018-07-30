--https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select pg_wal_lsn_diff(pg_current_wal_lsn(),flush_lsn), * from pg_stat_replication;
