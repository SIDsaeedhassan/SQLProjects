Create view popvsvacc as
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

select * 
from popvsvacc
