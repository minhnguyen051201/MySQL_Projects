-- Group by
-- Select gender group by gender
select gender
from Parks_and_Recreation.employee_demographics
group by gender;

-- Calculate the average age by gender in demographics tables
select gender, avg(age)
from Parks_and_Recreation.employee_demographics
group by gender;

-- Select the unique element with occupation
select occupation
from Parks_and_Recreation.employee_salary
group by occupation;

-- Select the unique element with salary
select salary 
from Parks_and_Recreation.employee_salary
group by salary;

-- Select the unique element with occupation and salary
select occupation, salary
from Parks_and_Recreation.employee_salary
group by occupation, salary;

-- Calculate the average salary by occupation in salary table
select occupation, avg(salary)
from Parks_and_Recreation.employee_salary
group by occupation;

-- Calculate the average age, max, min and count of age in demogrphics table by the gender
select gender,
avg(age), max(age), min(age), count(age)
from Parks_and_Recreation.employee_demographics
group by gender;

-- Order by
-- Select demographics table with asc and desc by first name
select first_name
from Parks_and_Recreation.employee_demographics
order by first_name asc;

select first_name
from Parks_and_Recreation.employee_demographics
order by first_name desc;

-- Select the same but order by gender and after that order by age with asc order
select first_name, gender, age
from Parks_and_Recreation.employee_demographics
order by gender asc, age asc;

-- Do the same but now age will be desc order
select first_name, gender, age
from Parks_and_Recreation.employee_demographics
order by gender asc, age desc;

-- Limit:
-- Limit 3 from employee_demographics
select *
from Parks_and_Recreation.employee_demographics
limit 3;

-- Select the top 3 age in employee_demographics
select *
from Parks_and_Recreation.employee_demographics
order by age desc
limit 3;

-- Select the third age in employee_demographics limit (start position), (position want to select)
select *
from Parks_and_Recreation.employee_demographics
limit 2, 1;

-- Aliasing:
-- select the column group by gender and avg of age with name avg_age
select gender, avg(age) as avg_age
from Parks_and_Recreation.employee_demographics
group by gender;

-- Having:
-- Filter a gender that has a average age > 40 with demographics
select gender, avg(age) as avg_age
from Parks_and_Recreation.employee_demographics
group by gender
having avg(age) > 40;

-- Filter all the manager occupation and calculate their average salary
select occupation, avg(salary) as avg_salary
from Parks_and_Recreation.employee_salary
group by occupation
having occupation like '%manager%';

-- Filter the manager occupation that have a average salary > 75000 using 
-- using both where and having
select occupation, avg(salary) as avg_salary
from Parks_and_Recreation.employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000;








