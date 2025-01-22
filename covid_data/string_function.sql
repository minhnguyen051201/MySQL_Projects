-- Length
-- Create a new column count the length of first_name and order by with that column (asc)
select first_name, length(first_name) as length
from employee_demographics;

-- Upper, Lower
-- Create a new column with upper, lower first_name 
select first_name, upper(first_name) as upper, lower(first_name) as lower
from employee_demographics;

-- Trim, Rtrim, Ltrim
select trim('         Hello        ') as Trim_function;
select ltrim('        Hello        ') as Left_trim_function;
select rtrim('        Hello        ') as Right_trim_function;

-- Sub String (column, start position, number of characters)
-- Take the new column with 4 first characters, last 4 characters
select first_name,
substring(first_name, 1, 4) as first,
substring(first_name, -4, 4) as last,
substring(first_name, 2, 2) as middle
from employee_demographics;
-- Take out the name the day and month of birthday column
select first_name, birth_date,
substring(birth_date, 1, 4) as year,
substring(birth_date, 6, 2) as month,
substring(birth_date, 9, 2) as day
from employee_demographics;

-- Replace (column, character will be replaced, character want to subtitute)
select first_name, replace(first_name, 'Tom', 'Cruise') as first_name_replace
from employee_demographics;

-- Locate (character in the column, column)
select first_name, locate('n', first_name) as Location
from employee_demographics;

-- Concat 
-- Combine the first_name and last_name to be full_name
select first_name, last_name,
concat(first_name, ' ', last_name) as full_name
from employee_demographics;
