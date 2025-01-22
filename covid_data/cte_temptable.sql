-- CTEs
-- Select the average salary among female and male
with cte_table (Gender, Avg_sal, Max_sal, Min_sal) as
(
select gender, avg(salary),
max(salary), min(salary)
from Parks_and_Recreation.employee_demographics as dem
join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
) select avg(Avg_sal)
from cte_table;

-- Select the employee with birthdate > 1985 and salary > 50000
with table_1 as
(
select employee_id, gender, birth_date
from Parks_and_Recreation.employee_demographics
where birth_date > '1985-01-01'
),
table_2 as
(
select employee_id, salary
from Parks_and_Recreation.employee_salary
where salary > 50000
)
select *
from table_1
join table_2
	on table_1.employee_id = table_2.employee_id;
    

-- Temporary Tables
create temporary table salary_over_5k
select *
from Parks_and_Recreation.employee_salary
where salary >=50000;

select *
from salary_over_5k;






























