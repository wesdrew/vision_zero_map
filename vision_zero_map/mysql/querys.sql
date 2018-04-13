
-- Possible queries 



prepare crashes_per_year from 
'select street, district, count(*) as number_crashes from
b_incidents as b
join b_locations l on b.incident_number = l.incident_number
where b.offense_code in (select offense_code
      		         from b_codes
			 where offense_description like "%mvacc%"
			 or offense_description like "%M/V - ACCIDENT%"
			 or offense_description like "%M/V - LEAVING%")
and year(b.occured_on_date) = ?
group by street, district
order by number_crashes desc
limit 25';

