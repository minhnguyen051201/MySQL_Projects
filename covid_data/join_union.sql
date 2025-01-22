select *
from Parks_and_Recreation.employee_demographics;

select *
from Parks_and_Recreation.employee_salary;

-- Inner Join
-- Join two table with employee_id
select *
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- Join two table and return 3 columns employee_id, age and occupation
select dem.employee_id, dem.age, sal.occupation
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;

-- Left Join
select dem.employee_id, dem.age, sal.occupation
from Parks_and_Recreation.employee_demographics as dem
left join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- Right Join
select dem.employee_id, dem.age, sal.occupation
from Parks_and_Recreation.employee_demographics as dem
right join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- Self Join
select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as emp_first_name
from Parks_and_Recreation.employee_salary as emp1
join Parks_and_Recreation.employee_salary as emp2
	on emp1.employee_id + 1 = emp2.employee_id;
    
-- Joining multiple tables together
select *
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join Parks_and_Recreation.parks_departments as dep
	on dep.department_id = sal.dept_id;

-- Union
-- Return the first and last name of the person who has age > 40 or salary > 70000
-- Label it with 'Old Man', 'Old Lady' and 'Highly Paid Employee'
select first_name, last_name, 'Old Man' as Label
from Parks_and_Recreation.employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'Old Lady' as Label
from Parks_and_Recreation.employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, 'Highly Paid Employee' as Label
from Parks_and_Recreation.employee_salary
where salary > 70000
order by first_name, last_name;














