use megasoftDB;

drop function if exists get_month_count;
DELIMITER //
create function get_month_count (finish date, start date)
returns int deterministic
begin
return (year(finish)-year(start))*12 + (month(finish)-month(start));
end //

select project.id as name, get_month_count(finish_date, start_date) * sum(salary) as price
from project inner join project_worker
on project.id = project_id
inner join worker on worker.id = worker_id
group by project.id
order by price desc