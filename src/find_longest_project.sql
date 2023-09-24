use megasoftDB;

drop function if exists get_month_count;
DELIMITER //
create function get_month_count (finish date, start date)
returns int deterministic
begin
return (year(finish)-year(start))*12 + (month(finish)-month(start));
end //

select id as name, get_month_count(finish_date, start_date) as month_count
from project
where get_month_count(finish_date, start_date) = (select
get_month_count(finish_date, start_date) as max
from project
order by max desc
limit 1)