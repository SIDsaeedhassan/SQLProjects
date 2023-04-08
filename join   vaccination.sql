
--Join 

select * from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date

--looking population vs vaccination

select dea.continent,dea.location,dea.date, dea.population,
vac.new_vaccinations
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location 
and dea.date= vac.date
where dea.continent is not null
and vac.new_vaccinations is not null
order by 2,3

--Total New Vaccinatios with Location

select dea.location, dea.population, 
sum(vac.new_vaccinations) [ total Vaccination]
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location 
and dea.date= vac.date
where dea.continent is not null
and vac.new_vaccinations is not null
group by dea.location, dea.population                                                     
order by 1


--Total  Vaccinatios with Location

select dea.location, dea.population, 
sum(cast(vac.total_vaccinations as bigint)) [ total Vaccination]
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location 
and dea.date= vac.date
where dea.continent is not null
and vac.new_vaccinations is not null
group by dea.location, dea.population                                                     
order by 1

--10 Highst  VACCAINATIONS Locations
select TOP(10) dea.location, dea.population, 
max(cast(vac.total_vaccinations as bigint)) [ total Vaccination]
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location 
and dea.date= vac.date
where dea.continent is not null
and vac.new_vaccinations is not null
group by dea.location, dea.population                                                     
order by [ total Vaccination] desc


	--Looking VACCINATION VS Population
select dea.location, dea.date,dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint))  over (partition by dea.location order by dea.location,dea.date) TotalVACCINATION,
--(TotalVACCINATION/dea.population)*100  VACCPercentage
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
and vac.new_vaccinations is not null                                                 
order by 1,2

--With CTE
With popvsvacc (Location, date, Population,new_vaccinations,TotalVACCINATION)
as
(
select dea.location, dea.date,dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint))  over (partition by dea.location order by dea.location,dea.date) TotalVACCINATION
--(TotalVACCINATION/dea.population)*100  VACCPercentage
from [PortFolioProjectss]..CovidDeaths dea
join [PortFolioProjectss]..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
and vac.new_vaccinations is not null                                                 
--order by 1,2
)
select *,(TotalVACCINATION/Population)*100 as VaccPercentage
from popvsvacc

--Total  TEST vs Population

select location, date,population,new_tests, 
sum(cast(total_tests as bigint)) over (partition by location,date order by location, date) TotalTESTs
from PortFolioProjectss..CovidDeaths
where continent is not null 
and total_tests is not null

--with CTE
with TotalTEST
(location, date,population,new_tests, TotalTESTs)
as
(
select location, date,population,new_tests, 
sum(cast(total_tests as bigint)) over (partition by location,date order by location, date) TotalTESTs
from PortFolioProjectss..CovidDeaths
where continent is not null 


)
select *,(TotalTESTs/population)*100
from TotalTEST