-- Finds my tables
SELECT tbl.name 
FROM Tables tbl 
WHERE so.name like '<%= @table_name %>%'