-- https://raw.githubusercontent.com/digoal/pgsql_admin_script/master/generate_report.sh
select name,statement,prepare_time,now()-prepare_time,parameter_types,from_sql from pg_prepared_statements where now()-prepare_time > interval $$30 min$$ order by prepare_time;
