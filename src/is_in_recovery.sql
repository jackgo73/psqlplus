-- https://github.com/mutex73/psqlplus
select (case pg_is_in_recovery when 'f' then 'this is primary node' when 't' then 'this is standby node' end) as status from pg_is_in_recovery();
