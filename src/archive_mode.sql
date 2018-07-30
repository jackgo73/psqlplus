-- https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select name,setting from pg_settings where name in ($$archive_mode$$,$$autovacuum$$,$$archive_command$$);
