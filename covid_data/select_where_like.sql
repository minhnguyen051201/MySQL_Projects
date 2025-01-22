-- Select and Where statement
-- Select 'Leslie' from employee_salary tables with column first_name
select *
from Parks_and_Recreation.employee_demographics
where first_name = 'Leslie';

-- Select salary greater than 50000 from table employee_salary
select *
from Parks_and_Recreation.employee_salary
where salary > 50000;

-- Select gender Female and Male from employee_demographics
select *
from Parks_and_Recreation.employee_demographics
where gender = 'Male';

select *
from Parks_and_Recreation.employee_demographics
where gender = 'Female';

-- Select birth_date greater '1985-01-01' from employee_demographics
select *
from Parks_and_Recreation.employee_demographics
where birth_date > '1985-01-01';

-- Select birth_date greater than '1985-01-01' and male 
select *
from Parks_and_Recreation.employee_demographics
where birth_date > '1985-01-01' and gender = 'Male';

-- Select birth_date greater than '1985-01-01' or male / or not male
select *
from Parks_and_Recreation.employee_demographics
where birth_date > '1985-01-01' or gender = 'Male';

select *
from Parks_and_Recreation.employee_demographics
where birth_date > '1985-01-01' or gender != 'Male';

-- Select the female name leslie and age 44 or age > 50 -> two output Leslie and Jerry
select *
from Parks_and_Recreation.employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 50;

-- Like Statement:
-- % : anything 
-- _ : specific character will be appear no more no less

-- Select Jerry with just Jer, er characters 
select *
from Parks_and_Recreation.employee_demographics
where first_name like 'Jer%';

select *
from Parks_and_Recreation.employee_demographics
where first_name like '_er__';

-- Select Ann, Andy with just A character
select *
from Parks_and_Recreation.employee_demographics
where first_name like 'A__';

select *
from Parks_and_Recreation.employee_demographics
where first_name like 'A___';

-- Select Andy and April at one time
select *
from Parks_and_Recreation.employee_demographics
where first_name like 'A___%';

-- Select birthday in 1989
select *
from Parks_and_Recreation.employee_demographics
where birth_date like '1989%';



















