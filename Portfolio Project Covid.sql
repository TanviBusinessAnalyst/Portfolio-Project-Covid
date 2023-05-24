

SELECT *
FROM PortfolioProject..[Covid Deaths]
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..[Covid Vaccinations]
--ORDER BY 3,4

SELECT location,total_cases,date,new_cases,total_deaths,population
FROM PortfolioProject..[Covid Deaths]
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths---
-- Shows Likelihood of dying if you contract covid in your country---

SELECT location,date,total_cases,total_deaths,
CONVERT(DECIMAL(18, 2), (CONVERT(DECIMAL(18, 2), total_deaths) / CONVERT(DECIMAL(18, 2),total_cases))) *100 as DeathPercentage
FROM PortfolioProject..[Covid Deaths]
WHERE location like '%states'
ORDER BY 1,2

--- Looking at Total Cases vs Total Population
--- Shows what percentage of population got Covid

SELECT location,date,population,total_cases, (total_cases/population)*100 as CovidCasePercentage
FROM PortfolioProject..[Covid Deaths]
WHERE location like '%states' AND continent IS NOT NULL
ORDER BY 1,2


-- Looking at COuntries with Highest Infection Rate compared to Population

SELECT location,population,MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentagePopulationInfected
FROM PortfolioProject..[Covid Deaths]
GROUP BY location,population
ORDER BY PercentagePopulationInfected desc

-- Showing countries with highest Death Count per Population

SELECT location,MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..[Covid Deaths]
WHERE continent IS NOT NULL
GROUP BY location 
ORDER BY  TotalDeathCount desc

--- BREAKDOWN BY CONTINENT HAVING HIGHEST DEATHCOUNT---

SELECT continent,MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..[Covid Deaths]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY  TotalDeathCount desc

--GLOBAL NUMBERS---


SELECT DATE,SUM(new_cases) as Total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_percentage
FROM PortfolioProject..[Covid Deaths]
GROUP BY date
ORDER BY  1,2

SELECT dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations
FROM PortfolioProject..[Covid Vaccinations] vac
JOIN PortfolioProject..[Covid Deaths] dea
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2,3





