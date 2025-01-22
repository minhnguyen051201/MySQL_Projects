-- Case Statement
-- Return the first_name, last_name, age and Age_Bracket column that in the demographics
-- Where age lower 31 is young between 31 and 50 is old and greater 50 is On Death's Door
select first_name, last_name,
age,
case
	when age <= 31 then 'Young'
    when age between 31 and 50 then 'Old'
    when age >= 50 then "On Death's Door"
end
from employee_demographics;

-- In the salary table
-- Pay Increase and Bonus 
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance(department_id) = 10% bonus
select sal.first_name, sal.last_name, sal.salary,
case
	when sal.salary <= 50000 then sal.salary * 1.05
    when sal.salary >= 50000 then sal.salary * 1.07
end as 'New Salary',
case
	when dep.department_name = 'Finance' then sal.salary * 10 / 100
end as 'Bonus'
from employee_salary as sal
join parks_departments as dep
	on dep.department_id = sal.dept_id;

