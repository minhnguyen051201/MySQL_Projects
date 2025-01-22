use Covid_Data;

select location, date, total_cases, new_cases, total_deaths, population
from CovidDeath
order by location, date;

-- Convert type string date to datetime
update CovidDeath
set date = STR_TO_DATE(date, '%Y-%m-%d');

alter table CovidDeath
modify date datetime;

update CovidVaccinations
set date = str_to_date(date, '%Y-%m-%d');

alter table CovidVaccinations
modify date datetime;

-- Shows likelihood of dying if you contract covid in your country
-- which means the total_death vs total_cases
select location, date, total_deaths, total_cases,
cast(total_deaths as decimal) / total_cases as likelihood_death
from CovidDeath
where location like '%Viet%'
order by location, date;


-- Shows what percentage of population infected with Covid
-- which means the total_cases vs population in percentage

select location, date, sum(total_cases) as sum_total_cases_date, population,
sum(total_cases) / population * 100 as infected_percentages
from CovidDeath
where location like '%Viet%'
group by location, population, date;


-- Countries with highest infection rate compared to population
-- which means highest total_cases vs population percentage (max) in a date 
 select location, date, population, max(total_cases) as max_total_cases, 
 max(total_cases) / population * 100 as infected_percentage
 from CovidDeath
 group by location, population, date;


-- Countries with highest death in a day 
select location, date, population,
max(cast(total_deaths as decimal)) as highest_death
from CovidDeath
-- where location like '%Viet%'  
group by location, date, population
order by location, date;


-- Showing continents with the highest death
select continent,
max(cast(total_deaths as decimal)) as highest_death
from CovidDeath
where continent != ''
group by continent
order by highest_death desc;


-- The percentages of new cases everyday
-- which means new_cases, new_deaths, new_death_percentages among the continent
select continent, sum(new_cases) as total_cases, sum(cast(new_deaths as decimal)) as new_deaths,
sum(new_cases) / sum(cast(new_deaths as decimal)) * 100 new_death_pertages
from CovidDeath
where new_deaths != '' and new_deaths != '0' and continent != ''
group by continent
order by new_death_pertages desc;


-- Show the total of new vaccinations among location and date
-- Using window function so you can choose more column to preview
-- Rolling toll the sum of new_vaccinations among location, date
select dea.continent, dea.location, dea.date, 
vac.new_vaccinations,
sum(cast(vac.new_vaccinations as decimal)) over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from CovidDeath as dea
join CovidVaccinations as vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent != '';
-- group by continent, location, date


-- Using cte_table with new column the percentage new_vaccinations vs population
with New_vaccinations (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinations)
as (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as decimal)) over(partition by dea.location order by dea.location, dea.date)
from CovidDeath as dea
join CovidVaccinations as vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent != ''
    )
select *, RollingPeopleVaccinations / Population * 100 as PercentagePopulationVaccinated
from New_vaccinations
where Location like '%Viet%';

-- Using temp_table
drop table if exists PercentPopulationVaccinated;

create temporary table PercentPopulationVaccinated
select dea.continent as Continent,
dea.location as Location, 
dea.date as Date,
dea.population as Population,
dea.new_vaccinations as New_vaccinations,
sum(cast(vac.new_vaccinations as decimal)) over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from CovidDeath as dea
join CovidVaccinations as vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent != '' and vac.new_vaccinations != '';

select *, cast(New_vaccinations as decimal) / Population * 100
from PercentPopulationVaccinated
where Location like '%Viet%';






























