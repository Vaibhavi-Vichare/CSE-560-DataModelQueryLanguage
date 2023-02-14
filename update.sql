-------- Selecting outlet details from tables outlet_details and outlet_location --------

Select od.outlet_id, od.manager_id, od.employee_count, ol.street_address, ol.zipcode 
from Outlet_details od, Outlet_location ol
where od.outlet_id = ol.outlet_id;

-------- Selecting count of outlets for franchise IDs - For vendors ---------

Select f.fran_id, f.fran_name, count(ol.outlet_id)
from Franchise f 
join Outlet_location ol on f.fran_id = ol.fran_id
group by f.fran_id
order by f.fran_id;

-------- Selecting outlets on the basis of cuisine and address - For customers ---------

Select f.fran_name, ol.street_address 
from (select fran_id, fran_name from Franchise where category like '%BURGER%') 
as f, Outlet_location ol
where f.fran_id = ol.fran_id and zipcode = 35470;

--------- Franchise wise yearly sale ---------

Create view sales_analysis as select f.fran_name, s.total_sale 
from Franchise f join Sales s on f.fran_id = s.fran_id
group by f.fran_name, s.total_sale
order by s.total_sale desc;

select * from sales_analysis;

------ Update contact and address of an outlet ------

Update Outlet_location set contact = 1234567892, street_address = '179 Callodine Ave'
where contact = 3704364173 and street_address = '2555 11th Avenue';


------ Deleting old outlet location ------

delete from Outlet_locations where zipcode LIKE '123456';



-------- TRIGGER to calculate average in sales ---------

create or replace function calc_average()
returns trigger
as $$
declare 
	average integer;
begin
	average = (new.total_sale / new.total_count)*1000;
	new.average = average;
	return new;
end;
$$ language plpgsql;

create trigger average_insert
before insert
on Sales
for each row
execute procedure calc_average();

insert into Sales values(51,50,100, 10);

-------- TRIGGER to save timestamp on new outlet addition ---------

Create trigger audit_insert 
after insert 
ON Outlet_details
for each row 
execute procedure auditlog();


create or replace function auditlog() 
returns trigger
as $$
begin
	insert into Audit(ID, Insert_date) values (new.outlet_id, current_timestamp);
    return new;
end;
$$ language plpgsql;

insert into Outlet_details values (2000,601,97,'FALSE');


--------- Query Analysis ----------

explain analyze Select f.fran_id, f.fran_name, count(ol.outlet_id)
from Franchise f 
join Outlet_location ol on f.fran_id = ol.fran_id
group by f.fran_id
order by f.fran_id;

explain analyze Select f.fran_name, ol.street_address 
from (select fran_id, fran_name from Franchise where category like '%BURGER%') 
as f, Outlet_location ol
where f.fran_id = ol.fran_id and zipcode = 35470;

explain analyze Select f.fran_name, ol.street_address 
from Franchise f join Outlet_location ol 
on f.fran_id = ol.fran_id 
and category like '%BURGER%'
and zipcode = 35470;


