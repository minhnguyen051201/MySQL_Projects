-- Subquerries
-- Select the employee in demographics who has a dept_id = 1
select *
from Parks_and_Recreation.employee_salary;

select *
from Parks_and_Recreation.employee_demographics
where employee_id in 
(select employee_id
from Parks_and_Recreation.employee_salary
where dept_id = 1);

-- Select the max average age 
select avg(max_age) as average_max_age
from
(select gender, max(age) as max_age
from Parks_and_Recreation.employee_demographics
group by gender) as agg_table;

-- Window function
-- Select the average salary by gender

-- Another approach without window function, this function can't return more column
select gender, avg(salary)
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender;

-- With window function
-- Return the column with avg salary of both female and male
select gender, 
avg(salary) over() as average_salary
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
order by gender;

-- Return the column with avg salary of female and avg salary of male
select gender, avg(salary) over(partition by gender)
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
order by gender;

-- We can add more column
select dem.first_name, dem.last_name, gender, 
avg(salary) over(partition by gender)
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
order by gender;

-- Return all employee first_name, last_name and column of sum salary by gender
select dem.first_name, dem.last_name, gender,
sum(salary) over(partition by gender)
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
order by gender;

-- Rolling total start specify value and add on value on sub rows by partition (order by in over() function)
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
sum(salary) over(partition by gender order by dem.employee_id) as rolling_toll
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
order by gender;

-- row_number()
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
order by gender;

-- rank()
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) rank_num
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
order by gender;

-- dense_rank()
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
order by gender;















