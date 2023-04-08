use [PortFolioProjectss]

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortFolioProjectss..CovidDeaths
--Where location like '%states%'
--and continent is not null 
order by 1,2

Select year(date), cast(avg(total_cases )as bigint) as Totalcases
From CovidDeaths
Where location like '%PAK%'
and continent is not null 
group by  year(date)

--Loooking Total CASEES vs Population

Select Location, date,Population, total_cases, (total_cases/Population)*100 as DeathPercentage
From PortFolioProjectss..CovidDeaths
Where location like '%PAK%'
--and continent is not null 
order by 1,2

--Loking TOTAL DEATHS VS Population

Select Location, date,Population, total_deaths, (total_deaths/Population)*100 as DeathPercentage
From PortFolioProjectss..CovidDeaths
Where location like '%PAK%'
--and continent is not null 
order by 1,2

--Looking Highst infected Countries

Select Location,Population, max(total_cases) [Total Cases], max((total_cases/Population)*100) as covidinfected
From PortFolioProjectss..CovidDeaths
--Where location like '%PAK%'
--and continent is not null 
Group By Location,Population
order by covidinfected desc

--Looking Highst deaths

Select Location, max(cast(total_deaths as int)) DeathsCount
From PortFolioProjectss..CovidDeaths
--Where location like '%PAK%'
where continent is not null
--and continent is not null 
Group By Location
order by DeathsCount desc

--Braking down with continent
Select location, max(cast(total_deaths as int)) DeathsCount
From PortFolioProjectss..CovidDeaths
--Where location like '%PAK%'
where continent is null and location <> 'world' and location <> 'International'
--and continent is not null 
Group By location
order by DeathsCount desc

--Global Number for new CASES and new DEATHS with DEATHS PERCNETAGE


Select sum(new_cases) [Total Cases], sum(cast(new_deaths as int)) [Total Deaths], 
sum(cast(new_deaths as int))/sum(new_cases)*100 [Death Percentage]
From CovidDeaths
--Where location like '%PAK%'
where continent is not null
--and continent is not null 
--Group By Location
--order by DeathsCount desc



